import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/initController.dart';
import 'package:pingcoin_admin/views/auth/login.dart';
import 'package:pingcoin_admin/views/dashboard.dart';
import 'package:pingcoin_admin/views/delayLoading.dart';
import 'dart:html' as html;
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget selectedScreen = DelayLoading();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Ping Coin",
      debugShowCheckedModeBanner: false,
      initialBinding: initController(),
      theme: ThemeData(fontFamily: "font"),
      home: selectedScreen,
    );
  }

  @override
  void initState() {
    getSharedPrefs();
  }

  getSharedPrefs() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String? adminId = html.window.localStorage['adminId'];
    if (adminId == null) {
      selectedScreen=LoginScreen();
    }else{
      print(adminId);
      selectedScreen=DashboardScreen();
    }
  }
}
