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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDLp1IOohiwG4JctiVEG-Z79TKv8htDMeM',
    appId: '1:1013781287396:web:6e12149b8ee7f9267b37f1',
    messagingSenderId: '1013781287396',
    projectId: 'employeestoday-2f7ec',
    authDomain: 'employeestoday-2f7ec.firebaseapp.com',
    storageBucket: 'employeestoday-2f7ec.firebasestorage.app',
    measurementId: 'G-VVM031M46R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABhjcaYaioIj0uX-MqLEYi8xvsx7BgKAI',
    appId: '1:1013781287396:android:4ea951007a31b9f17b37f1',
    messagingSenderId: '1013781287396',
    projectId: 'employeestoday-2f7ec',
    storageBucket: 'employeestoday-2f7ec.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDe2MR_tkUXmmtxXXqJF6ugS9DQEv2GSvw',
    appId: '1:1013781287396:ios:a24e0fbd19bf7b437b37f1',
    messagingSenderId: '1013781287396',
    projectId: 'employeestoday-2f7ec',
    storageBucket: 'employeestoday-2f7ec.firebasestorage.app',
    iosBundleId: 'com.example.employeesToday',
  );
}
