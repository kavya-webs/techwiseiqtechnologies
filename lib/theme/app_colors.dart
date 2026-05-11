// TechWiseIQ — Application Color Palette
//
// Centralized color definitions for the entire application.
// Uses a dark luxury theme with cyan (#00D4FF) as the primary accent.
// All colors are static constants for compile-time safety and consistency.
import 'package:flutter/material.dart';

class AppColors {
  // ── Background Colors ──────────────────────────────────────────────────
  /// Primary dark background — used for main scaffold and hero sections
  static const Color primaryDark = Color(0xFF060B18);

  /// Secondary dark — slightly lighter, used for alternating sections
  static const Color secondaryDark = Color(0xFF0A0F1F);

  /// Card background — for elevated content surfaces
  static const Color cardBg = Color(0xFF0D1526);

  // ── Accent Colors ──────────────────────────────────────────────────────
  /// Primary accent cyan — brand highlight color (#00D4FF)
  static const Color cyan = Color(0xFF00D4FF);

  // ── Text Colors ────────────────────────────────────────────────────────
  /// Pure white — for headings and primary text
  static const Color white = Colors.white;

  /// Light grey — for body text and secondary content
  static const Color grey = Color(0xFFB0B8C8);

  /// Dark grey — for muted text, labels, and hints
  static const Color darkGrey = Color(0xFF6B7A94);

  // ── Overlay Colors ─────────────────────────────────────────────────────
  /// Gradient overlay start (80% opacity)
  static const Color overlayStart = Color(0xCC060B18);

  /// Gradient overlay end (93% opacity)
  static const Color overlayEnd = Color(0xEE060B18);

  // ── Additional UI Colors ───────────────────────────────────────────────
  /// Body text color — used in service descriptions
  static const Color textBody = Color(0xFF8894A8);

  /// Border color — for input fields and dividers
  static const Color border = Color(0xFF5A6478);

  /// Card dark — darker variant for nested card surfaces
  static const Color cardDark = Color(0xFF0C1324);

  /// Icon grey — for deemphasized icons
  static const Color iconGrey = Color(0xFF4A5B75);

  // ── Brand Accent Palette ───────────────────────────────────────────────
  /// Used in testimonial cards and accent indicators
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color accentPurple = Color(0xFFA855F7);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentPink = Color(0xFFEC4899);
  static const Color accentIndigo = Color(0xFF6366F1);
}
