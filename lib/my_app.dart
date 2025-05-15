import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybookstore/core/configs/app_environment_banner.dart';
import 'package:mybookstore/core/routes/route_generator.dart';
import 'package:mybookstore/core/routes/route_names.dart';
import 'package:mybookstore/core/themes/app_themes.dart';
import 'package:mybookstore/features/auth/domain/repositories/auth_repository.dart';
import 'package:mybookstore/features/auth/ui/bloc/auth_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();
  final _routeObserver = RouteObserver<PageRoute>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyBookStore',
        navigatorKey: _navigatorKey,
        theme: AppThemes.themeDefault,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [_routeObserver],
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthStatus.authenticated:
                  _navigator.pushNamedAndRemoveUntil<void>(
                    RouteName.menu,
                    (route) => false,
                  );
                  break;
                case AuthStatus.unauthenticated:
                  _navigator.pushNamedAndRemoveUntil<void>(
                    RouteName.signIn,
                    (route) => false,
                  );
                  break;
              }
            },
            child: AppEnvironmentBanner(child: child ?? SizedBox.shrink()),
          );
        });
  }
}
