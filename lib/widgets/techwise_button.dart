// TechWiseIQ — Branded CTA Button
//
// A reusable call-to-action button with two variants:
// - Filled (default): Cyan background with dark text
// - Outline: Transparent background with cyan border
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A styled button that matches the TechWiseIQ brand design.
class TechWiseButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isOutline;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;

  const TechWiseButton({
    super.key,
    required this.text,
    this.onPressed,
    this.borderRadius,
    this.padding,
    this.isOutline = false,
    this.color,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isOutline ? Colors.transparent : (color ?? AppColors.cyan);
    final fgColor =
        textColor ?? (isOutline ? AppColors.white : AppColors.primaryDark);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
        border: isOutline ? Border.all(color: AppColors.cyan) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed ?? () {},
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          child: Padding(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisSize: width != null ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: fgColor,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
