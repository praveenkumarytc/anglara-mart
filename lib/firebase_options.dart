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
    apiKey: 'AIzaSyCMPa8EVjfdcH31BW9siXzhiOS4A478qn0',
    appId: '1:648546675828:web:5b080a410d4e2ea237f521',
    messagingSenderId: '648546675828',
    projectId: 'anglara-mart',
    authDomain: 'anglara-mart.firebaseapp.com',
    storageBucket: 'anglara-mart.appspot.com',
    measurementId: 'G-3EFNE7SSP7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBm_FH45JZClnzuOevPLs5DjYVHvTu8NpU',
    appId: '1:648546675828:android:acab912708631e0c37f521',
    messagingSenderId: '648546675828',
    projectId: 'anglara-mart',
    storageBucket: 'anglara-mart.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJATBkZj4kQVqDVVdCWiDGTl33zisuLHU',
    appId: '1:648546675828:ios:9d9f5fdd0a1a7bd137f521',
    messagingSenderId: '648546675828',
    projectId: 'anglara-mart',
    storageBucket: 'anglara-mart.appspot.com',
    iosClientId: '648546675828-3jcgfumrjkie3hnvvsd3ehi1ttvo8dgh.apps.googleusercontent.com',
    iosBundleId: 'com.anglara.ecommerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJATBkZj4kQVqDVVdCWiDGTl33zisuLHU',
    appId: '1:648546675828:ios:9d9f5fdd0a1a7bd137f521',
    messagingSenderId: '648546675828',
    projectId: 'anglara-mart',
    storageBucket: 'anglara-mart.appspot.com',
    iosClientId: '648546675828-3jcgfumrjkie3hnvvsd3ehi1ttvo8dgh.apps.googleusercontent.com',
    iosBundleId: 'com.anglara.ecommerce',
  );
}
