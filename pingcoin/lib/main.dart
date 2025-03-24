import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin/controllers/initControllers.dart';
import 'package:pingcoin/views/auth/loginScreen.dart';
import 'package:pingcoin/views/auth/signupScreen.dart';
import 'package:pingcoin/views/splashScreen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ping Coin',
      initialBinding: InitController(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "font"
      ),
      home: LoginScreen(),
    );
  }
}

