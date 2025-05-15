import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybookstore/core/consts/svg_path_enum.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class ObscureEyeWidget extends StatelessWidget {
  final bool isObscurePassword;
  final VoidCallback onTap;
  const ObscureEyeWidget({super.key, required this.isObscurePassword, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      enableFeedback: true,
      child: SvgPicture.asset(isObscurePassword ? SvgPath.eyeSlash.path : SvgPath.eye.path,
          fit: BoxFit.none, colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
    );
  }
}
