import 'package:flutter/material.dart';

import '../constants.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeWidget;
  final Widget? mediumWidget;
  final Widget smallWidget;
  final Widget? customWidget;

  const ResponsiveWidget({
    super.key,
    required this.largeWidget,
    this.mediumWidget,
    required this.smallWidget,
    this.customWidget,
  });

  static bool isSmall(BuildContext context) => MediaQuery.of(context).size.width < kMedScreenWidth;
  static bool isMed(BuildContext context) =>
      MediaQuery.of(context).size.width >= kMedScreenWidth && MediaQuery.of(context).size.width < kLargeScreenWidth;
  static bool isLarge(BuildContext context) => MediaQuery.of(context).size.width >= kLargeScreenWidth;
  //bool isCustom = currentWidth >= medScreenWidth && currentWidth <= customScreenWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      if (width >= kLargeScreenWidth) {
        return largeWidget;
      } else if (width < kLargeScreenWidth && width >= kMedScreenWidth) {
        return mediumWidget ?? largeWidget;
      } else {
        return smallWidget;
      }
    });
  }
}
