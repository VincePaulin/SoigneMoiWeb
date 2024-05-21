import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF0072BB);
  static const Color secondaryColor = Color(0xFFE96A5E);
  static const Color accentColor = Color(0xFF6FBF73);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFB00020);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onSecondaryColor = Color(0xFF000000);
  static const Color onBackgroundColor = Color(0xFF000000);
  static const Color onSurfaceColor = Color(0xFF000000);
  static const Color onErrorColor = Color(0xFFFFFFFF);
}

ThemeData buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      background: AppColors.backgroundColor,
      surface: AppColors.surfaceColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.onPrimaryColor,
      onSecondary: AppColors.onSecondaryColor,
      onBackground: AppColors.onBackgroundColor,
      onSurface: AppColors.onSurfaceColor,
      onError: AppColors.onErrorColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.onBackgroundColor,
      displayColor: AppColors.onBackgroundColor,
    ),
    primaryColor: AppColors.primaryColor,
  );
}
