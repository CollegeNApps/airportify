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
    apiKey: 'AIzaSyAJPkeT6uexzlOVdM5amqR-6X4wo-WMVp4',
    appId: '1:191042664285:web:5c603265bbed02c97d5ab4',
    messagingSenderId: '191042664285',
    projectId: 'airportify-26d93',
    authDomain: 'airportify-26d93.firebaseapp.com',
    storageBucket: 'airportify-26d93.appspot.com',
    measurementId: 'G-8CK2K7ZB2H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvhRGU21SXabhXbEbGBRDM-EmnnKEKaoU',
    appId: '1:191042664285:android:91ac2e78c3e7ee477d5ab4',
    messagingSenderId: '191042664285',
    projectId: 'airportify-26d93',
    storageBucket: 'airportify-26d93.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXIwcCjDMryRzybdS39z6KvHhm1zHYi-A',
    appId: '1:191042664285:ios:3832abc596e1b5567d5ab4',
    messagingSenderId: '191042664285',
    projectId: 'airportify-26d93',
    storageBucket: 'airportify-26d93.appspot.com',
    androidClientId: '191042664285-0t3un43jna51g99ga1c0jniu2em7t3oq.apps.googleusercontent.com',
    iosClientId: '191042664285-rl5rmb9h8mbd5jh0mg4v5du3uqj2fspe.apps.googleusercontent.com',
    iosBundleId: 'com.collegeapps.airportify',
  );
}
