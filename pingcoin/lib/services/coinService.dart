import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pingcoin/controllers/coinController.dart';

import '../constants/firebaseRef.dart';
import '../models/coinModel.dart';

class CoinService{

  CoinController _coinController=Get.find<CoinController>();

  getCoins() {
    coinsRef.snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          _coinController.addCoinToList(CoinModel.fromMap(element.doc.data()!));
        }else if(element.type==DocumentChangeType.modified){
          _coinController.replaceCoinInList(CoinModel.fromMap(element.doc.data()!));
        }else if(element.type==DocumentChangeType.removed){
          _coinController.removeCoinFromList(CoinModel.fromMap(element.doc.data()!));
        }
      });
    });
  }
}