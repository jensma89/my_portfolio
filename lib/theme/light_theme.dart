// lib/theme/light_theme.dart
// Light theme

import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  colorScheme: const ColorScheme.light(
    primary: AppColors.accentBlue,
    surface: AppColors.lightCard,
    onSurface: AppColors.lightTextPrimary,
    onPrimary: Colors.white,
    secondary: AppColors.accentBlueDark,
    onSecondary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightCard,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0x1A3A9BDC),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.lightCard,
    contentTextStyle: TextStyle(color: AppColors.lightTextPrimary),
  ),
);
