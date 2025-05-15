import 'package:flutter/material.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class AppTextTheme {
  static TextTheme get defaultTheme => TextTheme(
        headlineSmall: TextStyle(fontSize: 16, color: AppColors.black, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 24, color: AppColors.black, fontWeight: FontWeight.w700),
        headlineLarge: TextStyle(fontSize: 33, color: AppColors.purple, fontWeight: FontWeight.w700),
        titleSmall: TextStyle(fontSize: 14, color: AppColors.black, fontWeight: FontWeight.w400),
        titleMedium: TextStyle(fontSize: 16, color: AppColors.black, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(fontSize: 32, color: AppColors.black, fontWeight: FontWeight.w700),
        labelSmall: TextStyle(fontSize: 14, color: AppColors.gray, fontWeight: FontWeight.w400),
        labelMedium: TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.w500),
        labelLarge: TextStyle(fontSize: 18, color: AppColors.gray, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 14, color: AppColors.white, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(fontSize: 16, color: AppColors.purple, fontWeight: FontWeight.w500),
        displayLarge: TextStyle(fontSize: 20, color: AppColors.black, fontWeight: FontWeight.w600),
        bodySmall: TextStyle(fontSize: 16, color: AppColors.background, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 18, color: AppColors.background, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 20, color: AppColors.background, fontWeight: FontWeight.w700),
      );
}
