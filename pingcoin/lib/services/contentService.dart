import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/firebaseRef.dart';
import 'package:pingcoin/controllers/contentController.dart';
import 'package:pingcoin/models/contentModel.dart';
import 'package:pingcoin/models/faqModel.dart';
import 'package:pingcoin/models/supportModel.dart';
import 'package:pingcoin/widgets/customSnackbar.dart';

class ContentService {
  ContentController _contentController = Get.find<ContentController>();

  getContent() {
    sysConfigRef.doc("Content").snapshots().listen((event) {
      _contentController.setContentModel(ContentModel.fromMap(event.data()!));
    });
  }

  getAllFaqs() {
    faqRef.snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added || element.type == DocumentChangeType.modified) {
          _contentController.addFaqToList(FAQModel.fromMap(element.doc.data()!));
        }
        if (element.type == DocumentChangeType.removed) {
          _contentController.removeFaqFromList(FAQModel.fromMap(element.doc.data()!));
        }
      });
    });
  }

  submitSupport(String name, String email, String message) async {

    SupportModel supportModel = SupportModel(id: supportRef.doc().id, email: email, fullName: name, createdAt: DateTime.now(), message: message);

    await supportRef.doc(supportModel.id).set(supportModel.toMap());

    Get.back();

    CustomSnackbar.show("Success", "Feedback submitted successfully");

  }
}
