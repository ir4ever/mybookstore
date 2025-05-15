import 'package:flutter/material.dart';

abstract class IAppNavigator {
  void pushNamed(String routeName, {bool replace = false, Object? arguments});
  void pop({String? routeName});
  void popToRoot();
  void popUntil(String routeName);
  BuildContext get context;
  String? get currentRouteName;
}

class AppNavigator implements IAppNavigator {
  final GlobalKey<NavigatorState> _navigatorKey;

  AppNavigator(this._navigatorKey);

  @override
  BuildContext get context => _navigatorKey.currentState!.overlay!.context;

  @override
  String? get currentRouteName {
    return _navigatorKey.currentState?.overlay?.context != null
        ? ModalRoute.of(_navigatorKey.currentState!.overlay!.context)?.settings.name
        : null;
  }

  @override
  void pushNamed(String routeName, {bool replace = false, Object? arguments}) {
    if (routeName == currentRouteName) return;
    if (replace) {
      _navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
      return;
    }
    _navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  @override
  void pop({String? routeName}) {
    if (_navigatorKey.currentState == null) return;

    if (_navigatorKey.currentState!.canPop()) {
      _navigatorKey.currentState?.popUntil((route) {
        if (routeName == null || route.settings.name == routeName) {
          _navigatorKey.currentState!.pop();
        }
        return true;
      });
    }
  }

  @override
  void popToRoot() {
    if (_navigatorKey.currentState!.canPop()) {
      _navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  @override
  void popUntil(String routeName) {
    if (_navigatorKey.currentState!.canPop()) {
      _navigatorKey.currentState!.popUntil((route) => route.settings.name == routeName);
    }
  }
}
