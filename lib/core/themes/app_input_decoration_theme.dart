import 'package:flutter/material.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme get defaultTheme => InputDecorationTheme(
      filled: false,
      contentPadding: EdgeInsets.zero,
      labelStyle: _textStyle,
      hintStyle: _textStyle,
      border: _defaultBorder,
      enabledBorder: _defaultBorder,
      focusedBorder: _defaultBorder);
}

final _defaultBorder = InputBorder.none;
final _textStyle = TextStyle(fontSize: 14, color: AppColors.gray, fontWeight: FontWeight.w500);
