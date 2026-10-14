import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/text_styles.dart';

enum StoreeButtonVariant { filled, outlined, text }

class StoreeButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final StoreeButtonVariant variant;
  final Color? color;

  const StoreeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.variant = StoreeButtonVariant.filled,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: AppDimensions.buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.6),
          borderRadius: AppDimensions.roundedMedium,
        ),
        child: const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
        ),
      );
    }

    final btnColor = color ?? AppColors.primary;

    return switch (variant) {
      StoreeButtonVariant.filled => ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
            minimumSize: const Size.fromHeight(AppDimensions.buttonHeight),
          ),
          child: _buildContent(Colors.white),
        ),
      StoreeButtonVariant.outlined => OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: btnColor,
            side: BorderSide(color: btnColor, width: 1.5),
            minimumSize: const Size.fromHeight(AppDimensions.buttonHeight),
          ),
          child: _buildContent(btnColor),
        ),
      StoreeButtonVariant.text => TextButton(
          onPressed: onPressed,
          child: _buildContent(btnColor),
        ),
    };
  }

  Widget _buildContent(Color textColor) {
    if (icon == null) {
      return Text(label, style: AppTextStyles.buttonLabel.copyWith(color: textColor));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: textColor),
        const SizedBox(width: AppDimensions.space8),
        Text(label, style: AppTextStyles.buttonLabel.copyWith(color: textColor)),
      ],
    );
  }
}
