import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../theme/text_styles.dart';

/// Represents a single destination in the [StoreeBottomNavBar].
class StoreeNavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final int? badgeCount;
  final bool showBadge;

  const StoreeNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.badgeCount,
    this.showBadge = false,
  });
}

/// A modern, boutique floating bottom navigation bar designed specifically for Storee.
/// 
/// Incorporates the "Soft Boutique" design language:
/// - Floating island container with soft ivory/white surface.
/// - Berry Rose (`#A34863`) active accents and indicator dots.
/// - Blush Pink (`#F7E8EC`) active container pill.
/// - Soft shadow and gentle borders (`#EADBDF`).
/// - Micro-animations on selection with tactile haptic feedback.
class StoreeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<StoreeNavItem> items;

  const StoreeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 360;
    final isWide = screenWidth >= 640;

    Widget navBar = Container(
      height: isSmall ? 62 : 68,
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 4 : 6, vertical: isSmall ? 2 : 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.border,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;

          return Expanded(
            child: _NavBarItemWidget(
              item: item,
              isSelected: isSelected,
              isSmall: isSmall,
              onTap: () {
                HapticFeedback.selectionClick();
                onTap(index);
              },
            ),
          );
        }),
      ),
    );

    if (isWide) {
      navBar = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: navBar,
        ),
      );
    }

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(isSmall ? 8 : 14, 0, isSmall ? 8 : 14, isSmall ? 6 : 10),
        child: navBar,
      ),
    );
  }
}

class _NavBarItemWidget extends StatelessWidget {
  final StoreeNavItem item;
  final bool isSelected;
  final bool isSmall;
  final VoidCallback onTap;

  const _NavBarItemWidget({
    required this.item,
    required this.isSelected,
    this.isSmall = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      splashColor: AppColors.secondary,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 2 : 4, vertical: isSmall ? 2 : 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryLight.withValues(alpha: 0.3)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top active indicator pill
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: isSelected ? (isSmall ? 10 : 14) : 0,
              height: 2.0,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: isSmall ? 1 : 2),

            // Icon with potential badge
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.06 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    isSelected ? item.selectedIcon : item.icon,
                    size: isSmall ? 19 : 22,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
                if (item.showBadge || (item.badgeCount != null && item.badgeCount! > 0))
                  Positioned(
                    top: -2,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: Text(
                        item.badgeCount != null
                            ? (item.badgeCount! > 99 ? '99+' : '${item.badgeCount}')
                            : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),

            // Label
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: isSmall ? 9.5 : 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondary,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: Text(
                item.label,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
