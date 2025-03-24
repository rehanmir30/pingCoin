import 'package:get/get.dart';
import 'package:pingcoin/models/contentModel.dart';
import 'package:pingcoin/models/faqModel.dart';
import 'package:pingcoin/services/contentService.dart';

class ContentController extends GetxController {
  ContentModel? _contentModel;

  ContentModel? get contentModel => _contentModel;

  List<FAQModel> _allFaqs = [];

  List<FAQModel> get allFaqs => _allFaqs;

  getAllFaqs() {
    ContentService().getAllFaqs();
  }

  addFaqToList(FAQModel faqModel) {
    int existingAdIndex = _allFaqs.indexWhere((interest) => interest.id == faqModel.id);
    if (existingAdIndex != -1) {
      _allFaqs.removeAt(existingAdIndex);
    }
    _allFaqs.add(faqModel);
    update();
  }

  removeFaqFromList(FAQModel faqModel) {
    _allFaqs.removeWhere((element) => element.id == faqModel.id);
    update();
  }

  setContentModel(ContentModel model) {
    _contentModel = model;
    update();
  }

  getContent() {
    ContentService().getContent();
  }

  submitSupport(String name, String email, String message) {
    ContentService().submitSupport(name,email,message);
  }
}
