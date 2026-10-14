import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'responsive_layout.dart';

/// Shows a responsive bottom sheet that is width-constrained and centered on tablets/desktops,
/// and full-width with safe insets on mobile screens.
Future<T?> showResponsiveModalSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useRootNavigator = true,
  double maxWidth = StoreeBreakpoints.maxModalWidth,
}) {
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (ctx) {
      final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
      final isTablet = ctx.isTabletOrLarger;

      final sheetBody = Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: isTablet
              ? const BorderRadius.all(Radius.circular(AppDimensions.radiusLarge))
              : const BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        margin: isTablet ? const EdgeInsets.all(AppDimensions.space24) : EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: builder(ctx),
        ),
      );

      return Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Align(
          alignment: isTablet ? Alignment.center : Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? maxWidth : double.infinity,
            ),
            child: isTablet ? SafeArea(child: sheetBody) : sheetBody,
          ),
        ),
      );
    },
  );
}

/// Standard drag handle widget for bottom sheets.
class ModalDragHandle extends StatelessWidget {
  const ModalDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(top: AppDimensions.space12, bottom: AppDimensions.space8),
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: AppDimensions.roundedPill,
        ),
      ),
    );
  }
}
