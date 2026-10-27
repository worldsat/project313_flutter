import 'package:flutter/material.dart';

/// Semantic Design System Tokens matching Android Compose Color.kt and DESIGN.md
abstract class AppColors {
  // Primary Brand Identity (Deep Evergreen)
  static const Color primary = Color(0xFF1B4332);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF2D6A4F);
  static const Color onPrimaryContainer = Color(0xFFE8F5E9);

  // Secondary Accents (Leaf Green / Celadon)
  static const Color secondary = Color(0xFF40916C);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFD8F3DC);
  static const Color onSecondaryContainer = Color(0xFF081C15);

  // Tertiary Accents (Warm Sand / Architectural Brass)
  static const Color tertiary = Color(0xFFD4A373);
  static const Color onTertiary = Color(0xFF2B1700);
  static const Color tertiaryContainer = Color(0xFFFFDDB8);
  static const Color onTertiaryContainer = Color(0xFF2B1700);

  // Surfaces & Backgrounds (Natural Limestone / Crisp Off-White)
  static const Color surface = Color(0xFFF8FAF7);
  static const Color onSurface = Color(0xFF191C1B);
  static const Color surfaceDim = Color(0xFFEBEFEA);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFDEE5DD);
  static const Color onSurfaceVariant = Color(0xFF404943);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F5F1);
  static const Color surfaceContainer = Color(0xFFECEFEA);
  static const Color surfaceContainerHigh = Color(0xFFE6EAE4);
  static const Color surfaceContainerHighest = Color(0xFFE0E5DF);
  static const Color background = Color(0xFFF8FAF7);
  static const Color onBackground = Color(0xFF191C1B);

  // Borders & Dividers
  static const Color outline = Color(0xFF707972);
  static const Color outlineVariant = Color(0xFFC0C9C0);

  // Special Ambient & Dark Shell Gradients (For Intro & Hero headers)
  static const Color introGradientDark = Color(0xFF071B12);
  static const Color introGradientMid = Color(0xFF143828);
  static const Color introGradientLight = Color(0xFF245A40);
  static const Color glassmorphismOverlay = Color(0xCCFFFFFF);
  static const Color glassmorphismBorder = Color(0x66FFFFFF);

  // Additional UI Accent Colors
  static const Color starGold = Color(0xFFFFB703);
  static const Color notificationRed = Color(0xFFE53935);
  static const Color ecoPillContainer = Color(0xFFFFE8D6);
  static const Color ecoPillBorder = Color(0xFFE6BE94);
  static const Color ecoPillText = Color(0xFF7C5528);
  static const Color darkFabBg = Color(0xFF09281C);
}
