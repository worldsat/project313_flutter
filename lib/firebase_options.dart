// File generated for project313 Firebase configuration.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
          'DefaultFirebaseOptions have not been configured for macos.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDX1KXVJiV0PVotu_GsyRQz4VM3wsrY2fo',
    appId: '1:845584901201:web:7c9e0344d5c90b63',
    messagingSenderId: '845584901201',
    projectId: 'project313-82c85',
    authDomain: 'project313-82c85.firebaseapp.com',
    storageBucket: 'project313-82c85.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDX1KXVJiV0PVotu_GsyRQz4VM3wsrY2fo',
    appId: '1:845584901201:android:22573ea180e2aeeab48470',
    messagingSenderId: '845584901201',
    projectId: 'project313-82c85',
    storageBucket: 'project313-82c85.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDX1KXVJiV0PVotu_GsyRQz4VM3wsrY2fo',
    appId: '1:845584901201:ios:22573ea180e2aeeab48470',
    messagingSenderId: '845584901201',
    projectId: 'project313-82c85',
    storageBucket: 'project313-82c85.firebasestorage.app',
    iosBundleId: 'com.example.project313',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDX1KXVJiV0PVotu_GsyRQz4VM3wsrY2fo',
    appId: '1:845584901201:web:7c9e0344d5c90b63',
    messagingSenderId: '845584901201',
    projectId: 'project313-82c85',
    authDomain: 'project313-82c85.firebaseapp.com',
    storageBucket: 'project313-82c85.firebasestorage.app',
  );
}

