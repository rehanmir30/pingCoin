import 'package:get/get.dart';
import 'package:pingcoin_admin/services/faqService.dart';

import '../models/faqModel.dart';

class FAQController extends GetxController{

  List<FAQModel> _allFAQs=[];
  List<FAQModel> get allFAQs=>_allFAQs;

  addFaqToList(FAQModel faqModel){
    int existingAdIndex = _allFAQs.indexWhere((interest) => interest.id == faqModel.id);
    if (existingAdIndex != -1) {
      _allFAQs.removeAt(existingAdIndex);
    }
    _allFAQs.add(faqModel);
    update();
  }

  removeFaqFromList(FAQModel faqModel) {
    _allFAQs.removeWhere((element) => element.id==faqModel.id);
    update();
  }

  addFaq(FAQModel value){
    FAQService().addFAQ(value);
  }

  getAllFaqs(){
    FAQService().getAllFaqs();
  }

   deleteFAQ(FAQModel faq) {
    FAQService().deleteFAQ(faq);
   }

   updateFAQ(String question, String answer, FAQModel faq) {
    FAQService().updateFAQ(question,answer,faq);
   }


}