import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'nav_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light, NavColors.light);
  static ThemeData get dark => _build(Brightness.dark, NavColors.dark);

  static ThemeData _build(Brightness brightness, NavColors navColors) {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      extensions: [navColors],
      cardTheme: const CardThemeData(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.sheet),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.primary,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 44),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
        ),
      ),
    );
  }
}
