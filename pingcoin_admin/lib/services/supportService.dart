import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/constants/firebaseRef.dart';
import 'package:pingcoin_admin/controllers/supportController.dart';
import 'package:pingcoin_admin/models/supportModel.dart';

class SupportService {
  SupportController _supportController = Get.find<SupportController>();

  getAllSupports() {
    supportRef.snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if(element.type==DocumentChangeType.added){
          _supportController.addSupportToList(SupportModel.fromMap(element.doc.data()!));
        }
      });
    });
  }
}
