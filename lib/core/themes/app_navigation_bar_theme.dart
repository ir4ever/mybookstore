import 'package:flutter/material.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class AppNavigationBarTheme {
  static NavigationBarThemeData get defaultTheme => NavigationBarThemeData(
        labelPadding: EdgeInsets.only(top: 8),
        shadowColor: Colors.black,
        backgroundColor: AppColors.white.withValues(alpha: .9),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: Colors.transparent,
        labelTextStyle:
            WidgetStatePropertyAll(TextStyle(fontSize: 13, color: AppColors.black, fontWeight: FontWeight.w600)),
      );
}
