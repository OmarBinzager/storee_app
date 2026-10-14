import 'package:flutter/material.dart';
import 'responsive_layout.dart';

/// A responsive grid that automatically adapts its column count based on screen size.
class ResponsiveGrid<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final int mobileColumns;
  final int smallMobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double runSpacing;
  final double? childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const ResponsiveGrid({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.mobileColumns = 1,
    this.smallMobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 12.0,
    this.runSpacing = 12.0,
    this.childAspectRatio,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final columns = context.responsiveValue<int>(
      smallMobile: smallMobileColumns,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );

    if (columns <= 1) {
      return ListView.separated(
        padding: padding,
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: runSpacing),
        itemBuilder: (context, index) => itemBuilder(context, items[index], index),
      );
    }

    return GridView.builder(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: runSpacing,
        childAspectRatio: childAspectRatio ?? 2.2,
      ),
      itemBuilder: (context, index) => itemBuilder(context, items[index], index),
    );
  }
}
