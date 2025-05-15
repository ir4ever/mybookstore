import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mybookstore/core/configs/app_config.dart';
import 'package:mybookstore/core/themes/app_colors.dart';

class AppEnvironmentBanner extends StatelessWidget {
  final Widget child;

  const AppEnvironmentBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (AppConfig.isProd) return child;

    return Stack(
      children: [
        child,
        Positioned(
          top: 12,
          left: -36,
          child: Transform.rotate(
            angle: -pi / 4,
            child: Container(
              color: AppColors.lightPurple,
              alignment: Alignment.center,
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'QA',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
