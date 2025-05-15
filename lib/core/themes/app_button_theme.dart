import 'package:flutter/material.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class AppButtonTheme {
  static ElevatedButtonThemeData get defaultElevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          enableFeedback: true,
          backgroundColor: AppColors.purple,
          padding: const EdgeInsets.all(18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

  static OutlinedButtonThemeData get defaultOutlinedButtonTheme => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          enableFeedback: true,
          backgroundColor: AppColors.background,
          padding: const EdgeInsets.all(18),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), side: BorderSide(color: AppColors.lightGray)),
        ),
      );

  static IconButtonThemeData get defaultIconButtonTheme => IconButtonThemeData(
        style: IconButton.styleFrom(
            foregroundColor: AppColors.black,
            iconSize: 24,
            shape: CircleBorder(),
            padding: const EdgeInsets.all(12),
            enableFeedback: true),
      );
}
