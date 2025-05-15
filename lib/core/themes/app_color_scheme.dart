import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppColorScheme {
  static ColorScheme get defaultTheme => ColorScheme.fromSeed(
        seedColor: AppColors.white,
        primary: AppColors.purple,
        secondary: AppColors.black,
        tertiary: AppColors.subtext,
        outline: AppColors.lightGray,
        inversePrimary: AppColors.background,
        surface: AppColors.secundaryGray,
        outlineVariant: AppColors.gray,
      );
}
