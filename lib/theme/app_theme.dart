import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.notificationRed,
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.onSurface),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.outline,
        elevation: 4,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: AppColors.outlineVariant.withOpacity(0.4),
            width: 1,
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32,
          height: 1.25,
          letterSpacing: -0.25,
          color: AppColors.onSurface,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 28,
          height: 1.28,
          color: AppColors.onSurface,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          height: 1.33,
          color: AppColors.onSurface,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          height: 1.3,
          color: AppColors.onSurface,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.5,
          letterSpacing: 0.15,
          color: AppColors.onSurface,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 1.4,
          letterSpacing: 0.1,
          color: AppColors.onSurface,
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.5,
          letterSpacing: 0.5,
          color: AppColors.onSurface,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.43,
          letterSpacing: 0.25,
          color: AppColors.onSurfaceVariant,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.33,
          color: AppColors.outline,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 1.43,
          letterSpacing: 0.1,
          color: AppColors.onSurface,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          height: 1.33,
          letterSpacing: 0.5,
          color: AppColors.onSurface,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
          height: 1.45,
          letterSpacing: 0.5,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
