import 'package:flutter/material.dart';
import 'package:mybookstore/core/routes/page_transitions.dart';
import 'package:mybookstore/core/routes/route_names.dart';
import 'package:mybookstore/core/widgets/custom_app_bar.dart';
import 'package:mybookstore/features/login/ui/pages/sign_in_page.dart';
import 'package:mybookstore/features/login/ui/pages/sign_up_page.dart';
import 'package:mybookstore/features/menu/ui/pages/menu_page.dart';
import 'package:mybookstore/features/splash/ui/page/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case RouteName.initial:
      case RouteName.splash:
        return FadeRoute(page: SplashPage());
      case RouteName.signIn:
        return FadeRoute(page: SignInPage());

      case RouteName.signUp:
        return FadeRoute(page: SignUpPage());

      case RouteName.profile:
        return FadeRoute(page: SplashPage());
      case RouteName.menu:
        return FadeRoute(page: MenuPage());
      case RouteName.home:
        return FadeRoute(page: SplashPage());

      default:
        return _errorPage();
    }
  }

  static Route<dynamic> _errorPage() => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: CustomAppBar(),
          body: Center(child: Text('Tela não encontrada!', style: Theme.of(context).textTheme.headlineLarge)),
        ),
      );
}
