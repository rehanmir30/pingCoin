import 'package:get/get.dart';
import 'package:pingcoin/services/authService.dart';

import '../models/adInterestModel.dart';
import '../models/userModel.dart';

class AuthController extends GetxController {

  List<AdInterestModel> _adInterestList = [];
  List<AdInterestModel> get adInterestList => _adInterestList;

  UserModel? _userModel;
  UserModel? get userModel=>_userModel;

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  setLoading(bool value){
    _isLoading=value;
    update();
  }

  setUserModel(UserModel value){
    _userModel=value;
    update();
  }


  signup(String name, String email, String password, Set<AdInterestModel> selectedInterests) {
    AuthService().signup(name,email,password,selectedInterests);
  }

  populateInterestList(List<AdInterestModel> value){
    _adInterestList.clear();
    _adInterestList=value;
    update();
  }

  getAdInterests(){
    AuthService().getAdInterests();
  }

   login(String email, String password) {
    AuthService().login(email,password);
   }

   updateProfile(String name) {
    AuthService().updateProfile(name);
   }

}
