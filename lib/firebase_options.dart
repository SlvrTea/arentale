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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAq1Pyc3b4AYRINOdKuHXybgxMPQ7qrBS0',
    appId: '1:210090565912:web:a6020345d559b3e26ffe6d',
    messagingSenderId: '210090565912',
    projectId: 'arentale-24e94',
    authDomain: 'arentale-24e94.firebaseapp.com',
    databaseURL: 'https://arentale-24e94-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'arentale-24e94.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOxtYHAKtLkqKflr7_MxXw6_HIemiDGoc',
    appId: '1:210090565912:android:d78ef3427c7f8faf6ffe6d',
    messagingSenderId: '210090565912',
    projectId: 'arentale-24e94',
    databaseURL: 'https://arentale-24e94-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'arentale-24e94.appspot.com',
  );
}