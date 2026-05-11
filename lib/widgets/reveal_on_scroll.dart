// TechWiseIQ — Scroll-Triggered Reveal Animation
//
// A reusable widget that triggers a flutter_animate sequence once
// when it scrolls into the viewport.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Enum defining the available reveal animation types.
enum RevealType { fadeUp, slideLeft, slideRight, scale, fade }

/// Wraps any [child] widget with a one-shot scroll-triggered animation.
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final RevealType revealType;
  final Duration delay;
  final Duration duration;
  final double triggerFraction;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.revealType = RevealType.fadeUp,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.triggerFraction = 0.1,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _hasRevealed = false;
  late Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();
  }

  Widget _buildAnimatedContent() {
    Animate animate = widget.child.animate(
      delay: widget.delay,
      target: _hasRevealed ? 1 : 0,
    );

    switch (widget.revealType) {
      case RevealType.fadeUp:
        animate = animate
            .fadeIn(duration: widget.duration, curve: Curves.easeOut)
            .slideY(
              begin: 0.2,
              end: 0,
              duration: widget.duration,
              curve: Curves.easeOutCubic,
            );
        break;
      case RevealType.slideLeft:
        animate = animate
            .fadeIn(duration: widget.duration, curve: Curves.easeOut)
            .slideX(
              begin: 0.2,
              end: 0,
              duration: widget.duration,
              curve: Curves.easeOutCubic,
            );
        break;
      case RevealType.slideRight:
        animate = animate
            .fadeIn(duration: widget.duration, curve: Curves.easeOut)
            .slideX(
              begin: -0.2,
              end: 0,
              duration: widget.duration,
              curve: Curves.easeOutCubic,
            );
        break;
      case RevealType.scale:
        animate = animate
            .fadeIn(duration: widget.duration, curve: Curves.easeOut)
            .scale(
              begin: const Offset(0.85, 0.85),
              end: const Offset(1, 1),
              duration: widget.duration,
              curve: Curves.easeOutBack,
            );
        break;
      case RevealType.fade:
        animate = animate.fadeIn(
          duration: widget.duration,
          curve: Curves.easeOut,
        );
        break;
    }

    return animate;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (!_hasRevealed && info.visibleFraction >= widget.triggerFraction) {
          if (mounted) {
            setState(() {
              _hasRevealed = true;
            });
          }
        }
      },
      child: _buildAnimatedContent(),
    );
  }
}
