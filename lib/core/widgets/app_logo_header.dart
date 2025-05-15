import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybookstore/core/consts/svg_path_enum.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class AppLogoHeader extends StatelessWidget {
  const AppLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        SvgPicture.asset(SvgPath.logo.path,
            width: 145, colorFilter: ColorFilter.mode(AppColors.purple, BlendMode.srcIn)),
        Text('BookStore', style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 28)),
      ],
    );
  }
}
