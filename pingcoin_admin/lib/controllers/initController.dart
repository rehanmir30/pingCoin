import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/adController.dart';
import 'package:pingcoin_admin/controllers/authController.dart';
import 'package:pingcoin_admin/controllers/businessController.dart';
import 'package:pingcoin_admin/controllers/coinController.dart';
import 'package:pingcoin_admin/controllers/faqController.dart';
import 'package:pingcoin_admin/controllers/supportController.dart';
import 'package:pingcoin_admin/controllers/userController.dart';
class initController extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController(),permanent: true);
    Get.put(CoinController(),permanent: true);
    Get.put(UserController(),permanent: true);
    Get.put(AdController(),permanent: true);
    Get.put(BusinessController(),permanent: true);
    Get.put(SupportController(),permanent: true);
    Get.put(FAQController(),permanent: true);
  }

}