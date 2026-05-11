// TechWiseIQ — Responsive Section Container
//
// A reusable wrapper that constrains content to a max width (1440px)
// and applies consistent padding.
import 'package:flutter/material.dart';

/// Wraps child content with consistent horizontal padding and max-width constraint.
class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final double? width;

  const SectionContainer({
    super.key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(80),
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: color,
      padding: padding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: child,
        ),
      ),
    );
  }
}
