import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test2/firebase_options.dart';
import 'package:test2/views/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: 'Flutter Demo', home: LoginView());
/*************  ✨ Codeium Command ⭐  *************/
  /// Build a [GetMaterialApp] with title "Flutter GetX" and [HomeView] as home.
  ///
/******  6ad9aa29-4d74-48b2-ac2c-b5f14b47b2b9  *******/  }
}