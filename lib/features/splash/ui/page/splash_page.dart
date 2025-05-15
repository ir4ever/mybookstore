import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybookstore/core/consts/svg_path_enum.dart';
import 'package:mybookstore/core/themes/app_colors.dart';
import 'package:mybookstore/features/auth/ui/bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

const _duration = Duration(milliseconds: 500);

class _SplashPageState extends State<SplashPage> {
  bool _animate = false;

  final _logoHeight = 135.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _animate = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedSlide(
              offset: _animate ? const Offset(0, -0.25) : const Offset(0, 6),
              duration: _duration,
              onEnd: () {
                Future.delayed(const Duration(milliseconds: 150), () {
                  context.read<AuthBloc>().add(AuthInitEvent());
                });
              },
              child: SvgPicture.asset(
                SvgPath.logo.path,
                height: _logoHeight,
                colorFilter: const ColorFilter.mode(AppColors.background, BlendMode.srcIn),
              ),
            ),
            AnimatedPadding(
              padding: EdgeInsets.only(top: !_animate ? 0.0 : _logoHeight + 24),
              duration: _duration,
              child: Text(
                'BookStore',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.background),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
