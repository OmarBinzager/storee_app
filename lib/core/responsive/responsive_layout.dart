import 'package:flutter/material.dart';

/// Screen classification based on screen width breakpoints.
enum ScreenType {
  /// Devices with screen width < 360dp (compact phones, small screens).
  smallMobile,

  /// Typical smartphones (360dp <= width < 600dp).
  mobile,

  /// Tablets, foldables in unfolded state (600dp <= width < 900dp).
  tablet,

  /// Large tablets, desktop screens, web (width >= 900dp).
  desktop;

  bool get isSmallMobile => this == ScreenType.smallMobile;
  bool get isMobile => this == ScreenType.smallMobile || this == ScreenType.mobile;
  bool get isTablet => this == ScreenType.tablet;
  bool get isDesktop => this == ScreenType.desktop;
  bool get isTabletOrLarger => this == ScreenType.tablet || this == ScreenType.desktop;
}

/// Standard breakpoints used throughout Storee.
abstract final class StoreeBreakpoints {
  static const double smallMobile = 360.0;
  static const double mobile = 600.0;
  static const double tablet = 900.0;
  static const double maxContentWidth = 640.0;
  static const double maxWideContentWidth = 920.0;
  static const double maxModalWidth = 540.0;
}

/// Responsive extensions on BuildContext for quick, clean, and declarative checks.
extension ResponsiveContext on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  Orientation get orientation => mediaQuery.orientation;
  bool get isLandscape => orientation == Orientation.landscape;

  ScreenType get screenType {
    final w = screenWidth;
    if (w < StoreeBreakpoints.smallMobile) return ScreenType.smallMobile;
    if (w < StoreeBreakpoints.mobile) return ScreenType.mobile;
    if (w < StoreeBreakpoints.tablet) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  bool get isSmallMobile => screenWidth < StoreeBreakpoints.smallMobile;
  bool get isMobile => screenWidth < StoreeBreakpoints.mobile;
  bool get isTablet => screenWidth >= StoreeBreakpoints.mobile && screenWidth < StoreeBreakpoints.tablet;
  bool get isDesktop => screenWidth >= StoreeBreakpoints.tablet;
  bool get isTabletOrLarger => screenWidth >= StoreeBreakpoints.mobile;

  /// Returns a responsive value according to current screen breakpoint.
  T responsiveValue<T>({
    required T mobile,
    T? smallMobile,
    T? tablet,
    T? desktop,
  }) {
    switch (screenType) {
      case ScreenType.smallMobile:
        return smallMobile ?? mobile;
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet ?? desktop ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  /// Adaptive horizontal padding for pages and lists.
  double get responsiveHorizontalPadding {
    return responsiveValue<double>(
      smallMobile: 12.0,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
  }

  /// Adapts font size slightly for small mobile screens to prevent overflow.
  double responsiveFontSize(double baseSize) {
    if (isSmallMobile) {
      return (baseSize * 0.9).roundToDouble();
    }
    if (isTabletOrLarger) {
      return (baseSize * 1.05).roundToDouble();
    }
    return baseSize;
  }
}

/// A widget that provides current ScreenType to its builder.
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenType screenType) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = context.screenType;
        return builder(context, screenType);
      },
    );
  }
}
