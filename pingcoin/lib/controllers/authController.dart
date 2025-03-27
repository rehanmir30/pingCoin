import 'dart:io';

import 'package:get/get.dart';
import 'package:pingcoin/models/businessModel.dart';
import 'package:pingcoin/services/authService.dart';

import '../models/adInterestModel.dart';
import '../models/coinModel.dart';
import '../models/userModel.dart';
import 'coinController.dart';

class AuthController extends GetxController {

  List<AdInterestModel> _adInterestList = [];
  List<AdInterestModel> get adInterestList => _adInterestList;

  UserModel? _userModel;
  UserModel? get userModel=>_userModel;

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  List<CoinModel> _favorites=[];
  List<CoinModel> get favorites=>_favorites;

  getFavorites(){
    var allCoins = Get.find<CoinController>().allCoins;
    var favoriteIds = _userModel?.favorites ?? [];

    if (favoriteIds.isNotEmpty) {
      _favorites = allCoins.where((coin) {
        return favoriteIds.contains(coin.id);
      }).toList();
    } else {
      _favorites = [];
    }

  }

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

   setBusinessRequest(BusinessDevelopmentModel businessDevelopmentModel, File bannerImage) {
    AuthService().setBusinessRequest(businessDevelopmentModel,bannerImage);
   }

}
