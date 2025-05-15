import 'package:flutter/material.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class AppSnackbar extends SnackBar {
  AppSnackbar({super.key, required String message, required BuildContext context})
      : super(
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.purple,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          duration: const Duration(milliseconds: 3000),
        );
}
