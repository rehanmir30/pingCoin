import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/constants/firebaseRef.dart';
import 'package:pingcoin_admin/controllers/businessController.dart';
import 'package:pingcoin_admin/models/businessModel.dart';

class BusinessService{
  BusinessController _businessController =Get.find<BusinessController>();

  getAllBusinesses()async{
    businessesRef.snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if(element.type==DocumentChangeType.added||element.type==DocumentChangeType.modified){
          _businessController.addBusinessToList(BusinessDevelopmentModel.fromMap(element.doc.data()!));
        }
      });
    });
  }
}