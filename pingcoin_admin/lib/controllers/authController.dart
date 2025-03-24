import 'package:get/get.dart';
import 'package:pingcoin_admin/models/managementModel.dart';
import 'package:pingcoin_admin/services/authService.dart';

class AuthController extends GetxController{

  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  ManagementModel? _managementUserModel;
  ManagementModel? get managementUserModel=>_managementUserModel;

  String _about="";
  String get about=>_about;

  String _privacy="";
  String get privacy=>_privacy;

  String _terms="";
  String get terms=>_terms;

  setLoading(bool value){
    _isLoading=value;
    update();
  }

  setManagementUserModel(ManagementModel user){
    _managementUserModel=user;
    update();
  }

  login(String email, String password){
    AuthService().login(email,password);
  }

  updateProfile(String firstName, String lastName) {
    AuthService().updateProfile(firstName,lastName);
   }

   getContent(){
    AuthService().getContent();
   }

   setContent(Map<String,dynamic>map){
    _about=map["About"];
    _terms=map["Terms"];
    _privacy=map["Privacy"];
   }

  void updateContent(String type, String content) {
    AuthService().updateContent(type,content);
  }

  void updatePassword(String oldPassword, String newPassword) {
    AuthService().updatePassword(oldPassword,newPassword);
  }

   getAdminDetails() async{
    await AuthService().getAdminDetails();
   }

}