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
    apiKey: 'AIzaSyDH4v6Ii_q8678u6LGAdwPRIg4XG8c-N40',
    appId: '1:402141111350:web:8433b3cd8dd12943532497',
    messagingSenderId: '402141111350',
    projectId: 'instagramclone-9b91c',
    authDomain: 'instagramclone-9b91c.firebaseapp.com',
    storageBucket: 'instagramclone-9b91c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfgsb7g0ogFqXtiPHkhjGp6-MnXxTVMjU',
    appId: '1:402141111350:android:3b537479afb3f3d4532497',
    messagingSenderId: '402141111350',
    projectId: 'instagramclone-9b91c',
    storageBucket: 'instagramclone-9b91c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQEhm1KGTXx_rnw4QemGQAiqEQPOQSM94',
    appId: '1:402141111350:ios:6dd542e23576edb9532497',
    messagingSenderId: '402141111350',
    projectId: 'instagramclone-9b91c',
    storageBucket: 'instagramclone-9b91c.firebasestorage.app',
    iosBundleId: 'com.example.instagramClone',
  );
}