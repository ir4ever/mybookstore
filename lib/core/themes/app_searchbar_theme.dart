import 'package:flutter/material.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class AppSearchBarTheme {
  static SearchBarThemeData get defaultTheme => SearchBarThemeData(
        padding:
            const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0, right: 20.0)),
        hintStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.w400)),
        textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.w600)),
        backgroundColor: WidgetStatePropertyAll(AppColors.field),
        elevation: WidgetStatePropertyAll(1.0),
        textCapitalization: TextCapitalization.words,
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
      );
}
