import 'package:flutter/material.dart';
import 'responsive_layout.dart';

/// Centers child content and applies maximum width constraints on tablets/wide screens.
/// This prevents cards, banners, and lists from stretching uncomfortably across wide displays.
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final bool fillRemainingSpace;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = StoreeBreakpoints.maxContentWidth,
    this.padding,
    this.fillRemainingSpace = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
        );

    Widget content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );

    if (effectivePadding != EdgeInsets.zero) {
      content = Padding(
        padding: effectivePadding,
        child: content,
      );
    }

    return content;
  }
}
