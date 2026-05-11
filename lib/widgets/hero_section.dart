// TechWiseIQ — Reusable Hero Section
//
// A full-width hero section with a background image, gradient overlay,
// and centered content. Responds to screen size by adjusting height.
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A visually rich hero section with layered background image and gradient.
class HeroSection extends StatelessWidget {
  final String imagePath;
  final Widget child;
  final double height;
  final double opacity;

  const HeroSection({
    super.key,
    required this.imagePath,
    required this.child,
    this.height = 800,
    this.opacity = 0.35,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveHeight = screenWidth < 900 ? height * 0.7 : height;

    return SizedBox(
      height: responsiveHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: opacity,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.overlayStart,
                    Color(0x50060B18),
                    Color(0x60060B18),
                    AppColors.overlayEnd,
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1440),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
