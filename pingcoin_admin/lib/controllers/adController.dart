import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/models/adInterestModel.dart';
import 'package:pingcoin_admin/models/adModel.dart';
import 'package:pingcoin_admin/models/businessModel.dart';
import 'package:pingcoin_admin/services/adService.dart';

class AdController extends GetxController{
  List<AdInterestModel> _adInterests=[];
  List<AdInterestModel> get adInterests=>_adInterests;

  TextEditingController searchController = TextEditingController();

  List<AdModel> _allAds=[];
  List<AdModel> get allAds=>_allAds;

  List<AdModel> _filteredAds=[];
  List<AdModel> get filteredAds=>_filteredAds;

  Map<String, List<AdModel>> _categorizedAd = {};
  Map<String, List<AdModel>> get categorizedAd =>_categorizedAd;

  List<String> _filterStatuses=["Active","Pause","Completed","Cancelled"];
  List<String> get filterStatuses=>_filterStatuses;

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  String? _selectedStatus;
  String? get selectedStatus=>_selectedStatus;

  setFilterStatus(String? value){
    _selectedStatus=value;
    update();
  }

  searchFilter() {
    var tempFilteredAds = _allAds;

    if (_selectedStatus != null) {
      tempFilteredAds = tempFilteredAds.where((ad) {
        return ad.status.toLowerCase() == _selectedStatus!.toLowerCase();
      }).toList();
    }

    if (searchController.text.isNotEmpty) {
      tempFilteredAds = tempFilteredAds.where((ad) {
        return ad.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
            ad.id.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }
    _filteredAds = tempFilteredAds;
    update();
  }

  setLoading(bool value){
    _isLoading=value;
    update();
  }

  addAdToList(AdModel adModel) {
    int existingAdIndex = _allAds.indexWhere((ad) => ad.id == adModel.id);
    if (existingAdIndex != -1) {
      // _allAds.removeAt(existingAdIndex);
      AdModel existingAd = _allAds.removeAt(existingAdIndex);

      String existingStatus = existingAd.status;
      _categorizedAd[existingStatus]?.removeWhere((user) => user.id == existingAd.id);
    }
    _allAds.add(adModel);
    String status = adModel.status;
    _categorizedAd.putIfAbsent(status, () => []);
    _categorizedAd[status]!.add(adModel);

    update();
  }

   getAdInterests() {
    AdService().getAdInterests();
   }

   addAdInterestToList(AdInterestModel value){
     int existingAdIndex = _adInterests.indexWhere((interest) => interest.id == value.id);
     if (existingAdIndex != -1) {
       _adInterests.removeAt(existingAdIndex);
     }
     _adInterests.add(value);
     update();
   }

  removeInterestFromList(AdInterestModel adInterestModel) {
     _adInterests.removeWhere((element) => element.id==adInterestModel.id);
     update();
  }

   deleteInterest(AdInterestModel adInterestModel) {
     AdService().deleteInterest(adInterestModel);
   }

   createNewInterest(String interestName) {
     AdService().createNewInterest(interestName);
   }

   createAd(AdModel adModel, File adBanner) async{
      await AdService().createAdd(adModel,adBanner);
  }

   getAllAds() {
    AdService().getAllAds();
   }

   editAdStatus(AdModel adModel, String status) {
    AdService().editAdStatus(adModel,status);
   }

  Future<bool>editAd(AdModel adModel, File? file) async{
    return await AdService().editAd(adModel,file);
  }

  editBusiniess(BusinessDevelopmentModel businessDevelopmentModel, File? adBanner) {
    AdService().editBusiness(businessDevelopmentModel,adBanner);
  }

}