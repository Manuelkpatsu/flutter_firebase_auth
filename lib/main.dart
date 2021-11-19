import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebaseauth/locator.dart';
import 'package:flutterfirebaseauth/screens/app/app_entry_screen.dart';

Future<void> main() async {
  setUpLocator();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const AppEntryScreen());
  });
}
