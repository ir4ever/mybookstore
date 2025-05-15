import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybookstore/core/configs/app_config.dart';
import 'package:mybookstore/core/http/client_http.dart';
import 'package:mybookstore/features/auth/data/datasources/auth_datasource.dart';
import 'package:mybookstore/features/auth/domain/repositories/auth_repository.dart';
import 'package:mybookstore/features/auth/ui/bloc/auth_bloc.dart';
import 'package:mybookstore/features/login/ui/blocs/login_bloc.dart';
import 'package:mybookstore/features/menu/ui/blocs/navigation_bar_bloc.dart';
import 'package:mybookstore/features/splash/ui/page/splash_page.dart';
import 'package:mybookstore/features/user/domain/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(create: (context) => ClientHttp(baseUrl: AppConfig.urlBase, client: Dio())),
    Provider(create: (context) => SharedPreferencesAsync()),
    Provider(
      create: (context) => AuthDatasourceImpl(client: context.read(), prefs: context.read()),
    ),
    Provider(
      create: (context) => AuthRepositoryImpl(datasource: context.read()),
    ),
    Provider(
      create: (context) => UserRepositoryImpl(),
    ),
    BlocProvider<AuthBloc>(
        lazy: false,
        create: (context) => AuthBloc(
              authRepository: context.read<AuthRepositoryImpl>(),
            ),
        child: SplashPage()),
    BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
              authRepository: context.read<AuthRepositoryImpl>(),
            )),
    BlocProvider(create: (context) => NavigationBarBloc()),
  ];
}
