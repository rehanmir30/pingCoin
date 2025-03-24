import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin/controllers/authController.dart';
import 'package:pingcoin/controllers/coinController.dart';
import 'package:pingcoin/controllers/contentController.dart';

class InitController extends Bindings{
  @override
  void dependencies() {

    Get.put(AuthController(),permanent: true);
    Get.put(CoinController(),permanent: true);
    Get.put(ContentController(),permanent: true);
  }


}