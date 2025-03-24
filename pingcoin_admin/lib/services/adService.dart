import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/adController.dart';
import 'package:pingcoin_admin/models/adInterestModel.dart';
import 'package:pingcoin_admin/models/adModel.dart';
import 'package:pingcoin_admin/models/businessModel.dart';

import '../constants/firebaseRef.dart';
import '../widgets/customSnackbar.dart';

class AdService {
  AdController _adController = Get.find<AdController>();

  getAdInterests() {
    adInterestRef.snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added || element.type == DocumentChangeType.modified) {
          _adController.addAdInterestToList(AdInterestModel.fromMap(element.doc.data()!));
        } else if (element.type == DocumentChangeType.removed) {
          _adController.removeInterestFromList(AdInterestModel.fromMap(element.doc.data()!));
        }
      });
    });
  }

  getAllAds() {
    adsRef.snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added || element.type == DocumentChangeType.modified) {
          _adController.addAdToList(AdModel.fromMap(element.doc.data()!));
        }
      });
    });
  }

  deleteInterest(AdInterestModel adInterestModel) async {
    await adInterestRef.doc(adInterestModel.id).delete();
    CustomSnackbar.show("Success", "Interest deleted successfully");
  }

  createNewInterest(String interestName) async {
    AdInterestModel interestModel = AdInterestModel(id: adInterestRef.doc().id, name: interestName);
    await adInterestRef.doc(interestModel.id).set(interestModel.toMap());
    CustomSnackbar.show("Success", "Interest added successfully");
  }

  createAdd(AdModel adModel, html.File adBanner) async {
    _adController.setLoading(true);
    adModel.id = adsRef.doc().id;
    adModel.specificCode = adModel.id.substring(0, 5);
    try {
      adModel.image = (await uploadFileToFirebase(adBanner, "ads/${adModel.id}"))!;
      await adsRef.doc(adModel.id).set(adModel.toMap());
      CustomSnackbar.show("Success", "Ad created successfully");
      _adController.setLoading(false);
    } catch (e) {
      CustomSnackbar.show("Error", "Something went wrong.", isSuccess: false);
      _adController.setLoading(false);
    }
  }

  Future<String?> uploadFileToFirebase(html.File file, String path) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(path);

      final uploadTask = storageRef.putBlob(file);

      final snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }

  editAdStatus(AdModel adModel, String status) async {
    await adsRef.doc(adModel.id).update({"status": status});
    CustomSnackbar.show("Success", "Ad status changed successfully");
  }

  Future<bool> editAd(AdModel adModel, html.File? file) async {
    try {
      _adController.setLoading(true);
      if (file != null) {
        adModel.image = (await uploadFileToFirebase(file, "ads/${adModel.id}"))!;
      }
      await adsRef.doc(adModel.id).update(adModel.toMap());
      CustomSnackbar.show("Success", "Ad updated successfully");
      _adController.setLoading(false);
      return true;
    } catch (e) {
      CustomSnackbar.show("Error", "Something went wrong.", isSuccess: false);
      _adController.setLoading(false);
      return false;
    }
  }

   editBusiness(BusinessDevelopmentModel businessDevelopmentModel, html.File? adBanner) async {
     try {
       _adController.setLoading(true);
       if (adBanner != null) {
         businessDevelopmentModel.image = (await uploadFileToFirebase(adBanner, "business/${businessDevelopmentModel.id}"))!;
     }
     await businessesRef.doc(businessDevelopmentModel.id).update(businessDevelopmentModel.toMap());
     CustomSnackbar.show("Success", "Business updated successfully");
     _adController.setLoading(false);
     } catch (e,stacktrace) {
     CustomSnackbar.show("Error", "Something went wrong.", isSuccess: false);
     print(stacktrace);
     _adController.setLoading(false);
     }
   }
}
