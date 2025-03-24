import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/constants/firebaseRef.dart';
import 'package:pingcoin_admin/controllers/coinController.dart';
import 'package:pingcoin_admin/models/coinModel.dart';
import 'package:pingcoin_admin/widgets/customSnackbar.dart';

class CoinService {
  CoinController _coinController = Get.find<CoinController>();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> getCoinCategories() async {
    sysConfigRef.doc("CoinCategories").get().then((value) {
      List<String> categories = List<String>.from(value.data()!["Categories"]);
      _coinController.setCoinCategories(categories);
    });
  }

  Future<bool> createCoin(CoinModel coinModel, html.File coinFront, html.File coinBack, html.File coinAudio) async {
    _coinController.setLoading(true);
    coinModel.id = coinsRef.doc().id;
    try {
      coinModel.coinFront = await uploadFileToFirebase(coinFront, "${coinModel.id}/coinFront");
      coinModel.coinBack = await uploadFileToFirebase(coinBack, "${coinModel.id}/coinBack");
      coinModel.coinAudio = await uploadFileToFirebase(coinAudio, "${coinModel.id}/coinAudio");

      await coinsRef.doc(coinModel.id).set(coinModel.toMap());
      _coinController.setLoading(false);
      CustomSnackbar.show("Success", "Coin added successfully");
      return true;
    } catch (e) {
      CustomSnackbar.show("Error", "Something went wrong",isSuccess: false);
      _coinController.setLoading(false);
      return false;
    }
  }

  Future<bool> updateCoin(CoinModel coinModel, html.File? coinFront, html.File? coinBack, html.File? coinAudio) async {
    _coinController.setLoading(true);
    try {
      if (coinFront != null) {
        coinModel.coinFront = await uploadFileToFirebase(coinFront, "${coinModel.id}/coinFront");
      }
      if (coinBack != null) {
        coinModel.coinBack = await uploadFileToFirebase(coinBack, "${coinModel.id}/coinBack");
      }
      if (coinAudio != null) {
        coinModel.coinAudio = await uploadFileToFirebase(coinAudio, "${coinModel.id}/coinAudio");
      }
      await coinsRef.doc(coinModel.id).update(coinModel.toMap());
      _coinController.setLoading(false);
      CustomSnackbar.show("Success", "Coin updated successfully");

      return true;
    } catch (e) {
      print("Error while updating coin: $e");
      _coinController.setLoading(false);
      CustomSnackbar.show("Error", "Something went wrong",isSuccess: false);
      return false;
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

   deleteCoin(CoinModel coin) async{
    _coinController.setLoading(true);
    coinsRef.doc(coin.id).delete();

    final String folderName = coin.id;
    await deleteFolder(folderName);


    _coinController.setLoading(false);
    CustomSnackbar.show("Success", "Coin removed successfully");
   }

  Future<void> deleteFolder(String folderName) async {
    final Reference folderRef = storage.ref().child(folderName);

    // List all items (files) in the folder
    final ListResult result = await folderRef.listAll();

    // Delete each file
    for (Reference fileRef in result.items) {
      await fileRef.delete();
    }

    // Recursively delete files in subfolders, if any
    for (Reference subfolderRef in result.prefixes) {
      await deleteFolder(subfolderRef.fullPath);
    }
  }

}
