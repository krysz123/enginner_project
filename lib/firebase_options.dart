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
    apiKey: 'AIzaSyAxlmYVDf8bPHwZXY5qBJAOrYBwChaJKso',
    appId: '1:583167747676:web:5f15c601321f28e365e899',
    messagingSenderId: '583167747676',
    projectId: 'walletwatch-b6fe1',
    authDomain: 'walletwatch-b6fe1.firebaseapp.com',
    storageBucket: 'walletwatch-b6fe1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBT4XZ9M77lXfbnHoIgYsy9Uw9Ke84B-mg',
    appId: '1:583167747676:android:f439e6154ec9360765e899',
    messagingSenderId: '583167747676',
    projectId: 'walletwatch-b6fe1',
    storageBucket: 'walletwatch-b6fe1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcZlPQCTvpUlOYL-qzbkyUSSuc9ByOuRg',
    appId: '1:583167747676:ios:0dc67c97927c088f65e899',
    messagingSenderId: '583167747676',
    projectId: 'walletwatch-b6fe1',
    storageBucket: 'walletwatch-b6fe1.appspot.com',
    iosBundleId: 'com.example.enginnerProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcZlPQCTvpUlOYL-qzbkyUSSuc9ByOuRg',
    appId: '1:583167747676:ios:0dc67c97927c088f65e899',
    messagingSenderId: '583167747676',
    projectId: 'walletwatch-b6fe1',
    storageBucket: 'walletwatch-b6fe1.appspot.com',
    iosBundleId: 'com.example.enginnerProject',
  );

}