// lib/theme/dark_theme.dart
// Dark theme — default

import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accentBlue,
    surface: AppColors.darkCard,
    onSurface: AppColors.darkTextPrimary,
    onPrimary: Colors.white,
    secondary: AppColors.accentBlueLight,
    onSecondary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkCard,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0x1A3A9BDC),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.darkCard,
    contentTextStyle: TextStyle(color: AppColors.darkTextPrimary),
  ),
);
