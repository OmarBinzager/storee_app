import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/text_styles.dart';

enum BadgeType { primary, success, warning, error, info }

class StoreeBadge extends StatelessWidget {
  final String label;
  final BadgeType type;
  final IconData? icon;

  const StoreeBadge({
    super.key,
    required this.label,
    this.type = BadgeType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final (bgColor, fgColor) = switch (type) {
      BadgeType.primary => (AppColors.secondary, AppColors.primary),
      BadgeType.success => (AppColors.successLight, AppColors.success),
      BadgeType.warning => (AppColors.warningLight, AppColors.warning),
      BadgeType.error => (AppColors.errorLight, AppColors.error),
      BadgeType.info => (AppColors.infoLight, AppColors.info),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space8,
        vertical: AppDimensions.space4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppDimensions.roundedSmall,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fgColor),
            const SizedBox(width: AppDimensions.space4),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.badgeLabel.copyWith(color: fgColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
