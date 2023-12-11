// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyD2XX4vwlPVNsZHZISXqhmQhoBmygR5vQY',
    appId: '1:1051041635036:web:bbbad04e30c570353b3219',
    messagingSenderId: '1051041635036',
    projectId: 'healthpal-50854',
    authDomain: 'healthpal-50854.firebaseapp.com',
    storageBucket: 'healthpal-50854.appspot.com',
    measurementId: 'G-8G5LJ3EG3M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAR5puvJfEX90iJHRyUppUi1poCrqgZoh0',
    appId: '1:1051041635036:android:26ccf41b66a9574f3b3219',
    messagingSenderId: '1051041635036',
    projectId: 'healthpal-50854',
    storageBucket: 'healthpal-50854.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4BEINM8FMP7hGWJ1NlU41_qPKsaxjDJw',
    appId: '1:1051041635036:ios:11dc0d734917322c3b3219',
    messagingSenderId: '1051041635036',
    projectId: 'healthpal-50854',
    storageBucket: 'healthpal-50854.appspot.com',
    iosBundleId: 'com.example.healthpal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4BEINM8FMP7hGWJ1NlU41_qPKsaxjDJw',
    appId: '1:1051041635036:ios:cacd71a81fbf577e3b3219',
    messagingSenderId: '1051041635036',
    projectId: 'healthpal-50854',
    storageBucket: 'healthpal-50854.appspot.com',
    iosBundleId: 'com.example.healthpal.RunnerTests',
  );
}
