import 'package:flutter/material.dart';
import 'package:mybookstore/core/themes/app_appbar_theme.dart';
import 'package:mybookstore/core/themes/app_button_theme.dart';
import 'package:mybookstore/core/themes/app_color_scheme.dart';
import 'package:mybookstore/core/themes/app_colors.dart';
import 'package:mybookstore/core/themes/app_icon_theme.dart';
import 'package:mybookstore/core/themes/app_input_decoration_theme.dart';
import 'package:mybookstore/core/themes/app_navigation_bar_theme.dart';
import 'package:mybookstore/core/themes/app_searchbar_theme.dart';
import 'package:mybookstore/core/themes/app_text_theme.dart';

class AppThemes {
  static ThemeData get themeDefault => ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.background,
        iconTheme: AppIconTheme.defaultTheme,
        textTheme: AppTextTheme.defaultTheme,
        colorScheme: AppColorScheme.defaultTheme,
        appBarTheme: AppAppbarTheme.defaultTheme,
        searchBarTheme: AppSearchBarTheme.defaultTheme,
        iconButtonTheme: AppButtonTheme.defaultIconButtonTheme,
        navigationBarTheme: AppNavigationBarTheme.defaultTheme,
        inputDecorationTheme: AppInputDecorationTheme.defaultTheme,
        elevatedButtonTheme: AppButtonTheme.defaultElevatedButtonTheme,
        outlinedButtonTheme: AppButtonTheme.defaultOutlinedButtonTheme,
      );
}
