import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pingcoin_admin/constants/firebaseRef.dart';
import 'package:pingcoin_admin/controllers/faqController.dart';
import 'package:pingcoin_admin/models/faqModel.dart';
import 'package:pingcoin_admin/widgets/customSnackbar.dart';

class FAQService {
FAQController _faqController=Get.find<FAQController>();
  getAllFaqs() {
faqRef.snapshots().listen((event) {
  event.docChanges.forEach((element) {
    if(element.type==DocumentChangeType.added||element.type==DocumentChangeType.modified){
      _faqController.addFaqToList(FAQModel.fromMap(element.doc.data()!));
    }if(element.type==DocumentChangeType.removed){
      _faqController.removeFaqFromList(FAQModel.fromMap(element.doc.data()!));
    }
  });
});

  }

   addFAQ(FAQModel value) async {
    value.id=faqRef.doc().id;
    await faqRef.doc(value.id).set(value.toMap());

    CustomSnackbar.show("Success", "FAQ added successfully");
   }

   deleteFAQ(FAQModel faq) async{
    await faqRef.doc(faq.id).delete();
    CustomSnackbar.show("Success", "FAQ removed successfully");
   }

   updateFAQ(String question, String answer, FAQModel faq) async {
    await faqRef.doc(faq.id).update({"question":question,"answer":answer});
    CustomSnackbar.show("Success", "FAQ edited successfully");
   }

}
