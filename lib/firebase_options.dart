// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCzro27WMWglA80bxNfRTRZZJb_1P4UIDc',
    appId: '1:1088848746860:web:7faf286b12eb7544bd3b49',
    messagingSenderId: '1088848746860',
    projectId: 'mybookstore-e44e0',
    authDomain: 'mybookstore-e44e0.firebaseapp.com',
    storageBucket: 'mybookstore-e44e0.firebasestorage.app',
    measurementId: 'G-3ZRJCY8621',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZGU1LgLAA92-2efAKbKSfz8DOfJi2k3Y',
    appId: '1:1088848746860:android:1a9fd99831126603bd3b49',
    messagingSenderId: '1088848746860',
    projectId: 'mybookstore-e44e0',
    storageBucket: 'mybookstore-e44e0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAY24PWgQYbHlwzj4MDGy5wItQyDF9TqHE',
    appId: '1:1088848746860:ios:d9b59ff82347ad1ebd3b49',
    messagingSenderId: '1088848746860',
    projectId: 'mybookstore-e44e0',
    storageBucket: 'mybookstore-e44e0.firebasestorage.app',
    iosBundleId: 'com.example.mybookstore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAY24PWgQYbHlwzj4MDGy5wItQyDF9TqHE',
    appId: '1:1088848746860:ios:d9b59ff82347ad1ebd3b49',
    messagingSenderId: '1088848746860',
    projectId: 'mybookstore-e44e0',
    storageBucket: 'mybookstore-e44e0.firebasestorage.app',
    iosBundleId: 'com.example.mybookstore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCzro27WMWglA80bxNfRTRZZJb_1P4UIDc',
    appId: '1:1088848746860:web:9f422e100b9d0df1bd3b49',
    messagingSenderId: '1088848746860',
    projectId: 'mybookstore-e44e0',
    authDomain: 'mybookstore-e44e0.firebaseapp.com',
    storageBucket: 'mybookstore-e44e0.firebasestorage.app',
    measurementId: 'G-GWXYZETRSJ',
  );
}
