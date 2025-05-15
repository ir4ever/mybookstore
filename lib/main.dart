import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mybookstore/core/configs/app_config.dart';
import 'package:mybookstore/firebase_options.dart';
import 'package:mybookstore/my_app.dart';
import 'package:provider/provider.dart';

import 'core/configs/dependecies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Para executar os ambientes basta usar um desses comandos:
  //HML: flutter run --dart-define=PROFILE=hml
  //PROD: flutter run --dart-define=PROFILE=prod
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppConfig.init(Enviroment.fromArgs());

  runApp(MultiProvider(providers: providers, child: MyApp()));
}
