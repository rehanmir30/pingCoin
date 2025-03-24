import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/models/coinModel.dart';
import 'package:pingcoin_admin/services/coinService.dart';

class CoinController extends GetxController {
  List<String> _coinCategories = [];

  List<String> get coinCategories => _coinCategories;

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  TextEditingController searchController = TextEditingController();

  List<String> _countryCodes = [
    "🇦🇫 AF - Afghanistan",
    "🇦🇱 AL - Albania",
    "🇩🇿 DZ - Algeria",
    "🇦🇩 AD - Andorra",
    "🇦🇴 AO - Angola",
    "🇦🇷 AR - Argentina",
    "🇦🇲 AM - Armenia",
    "🇦🇺 AU - Australia",
    "🇦🇹 AT - Austria",
    "🇦🇿 AZ - Azerbaijan",
    "🇧🇭 BH - Bahrain",
    "🇧🇩 BD - Bangladesh",
    "🇧🇾 BY - Belarus",
    "🇧🇪 BE - Belgium",
    "🇧🇷 BR - Brazil",
    "🇨🇦 CA - Canada",
    "🇨🇳 CN - China",
    "🇨🇴 CO - Colombia",
    "🇨🇿 CZ - Czech Republic",
    "🇩🇰 DK - Denmark",
    "🇪🇬 EG - Egypt",
    "🇫🇷 FR - France",
    "🇩🇪 DE - Germany",
    "🇬🇭 GH - Ghana",
    "🇬🇷 GR - Greece",
    "🇭🇰 HK - Hong Kong",
    "🇮🇳 IN - India",
    "🇮🇩 ID - Indonesia",
    "🇮🇷 IR - Iran",
    "🇮🇶 IQ - Iraq",
    "🇮🇹 IT - Italy",
    "🇯🇵 JP - Japan",
    "🇯🇴 JO - Jordan",
    "🇰🇪 KE - Kenya",
    "🇰🇼 KW - Kuwait",
    "🇱🇦 LA - Laos",
    "🇱🇧 LB - Lebanon",
    "🇲🇾 MY - Malaysia",
    "🇲🇻 MV - Maldives",
    "🇲🇽 MX - Mexico",
    "🇲🇦 MA - Morocco",
    "🇳🇵 NP - Nepal",
    "🇳🇱 NL - Netherlands",
    "🇳🇿 NZ - New Zealand",
    "🇳🇬 NG - Nigeria",
    "🇳🇴 NO - Norway",
    "🇴🇲 OM - Oman",
    "🇵🇰 PK - Pakistan",
    "🇵🇪 PE - Peru",
    "🇵🇭 PH - Philippines",
    "🇵🇱 PL - Poland",
    "🇶🇦 QA - Qatar",
    "🇷🇴 RO - Romania",
    "🇷🇺 RU - Russia",
    "🇸🇦 SA - Saudi Arabia",
    "🇸🇬 SG - Singapore",
    "🇿🇦 ZA - South Africa",
    "🇪🇸 ES - Spain",
    "🇱🇰 LK - Sri Lanka",
    "🇸🇪 SE - Sweden",
    "🇨🇭 CH - Switzerland",
    "🇹🇭 TH - Thailand",
    "🇹🇷 TR - Turkey",
    "🇦🇪 AE - United Arab Emirates",
    "🇬🇧 GB - United Kingdom",
    "🇺🇸 US - United States",
    "🇻🇳 VN - Vietnam",
    "🇾🇪 YE - Yemen",
  ];

  List<String> get countryCodes => _countryCodes;

  List<String> _coinDiameterUnits = ["mm", "cm", "in", "m"];

  List<String> get coinDiameterUnits => _coinDiameterUnits;

  List<String> _coinWeightUnits = ["mg", "g", "lb", "oz"];

  List<String> get coinWeightUnits => _coinWeightUnits;

  List<String> _validationList = ["Good", "Bad"];

  List<String> get validationList => _validationList;

  List<CoinModel> _allCoins=[];
  List<CoinModel> get allCoins=>_allCoins;

  List<CoinModel> _filteredCoins=[];
  List<CoinModel> get filteredCoins=>_filteredCoins;

  Map<String, List<CoinModel>> _categorizedCoins = {};
  Map<String, List<CoinModel>> get categorizedCoins =>_categorizedCoins;

  String? _selectedCategoryFilter;
  String? get selectedCategoryFilter=>_selectedCategoryFilter;

  String? _selectedCountryFilter;
  String? get selectedCountryFilter=>_selectedCountryFilter;

  setFilterCategory(String? value){
    _selectedCategoryFilter=value;
    update();
  }

  setFilterCountry(String? value){
    _selectedCountryFilter=value;
    update();
  }

  searchFilter() {

    var tempFilteredCoins = _allCoins;

    // Apply category filter if selected
    if (_selectedCategoryFilter != null) {
      tempFilteredCoins = tempFilteredCoins.where((coin) {
        return coin.category.toLowerCase() == _selectedCategoryFilter!.toLowerCase();
      }).toList();
    }

    // Apply country filter if selected
    if (_selectedCountryFilter != null) {
      tempFilteredCoins = tempFilteredCoins.where((coin) {
        return coin.country == _selectedCountryFilter!;
      }).toList();
    }

    // Apply text search filter if text is entered
    if (searchController.text.isNotEmpty) {
      tempFilteredCoins = tempFilteredCoins.where((coin) {
        return coin.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
            coin.id.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }

    // Update filtered coins list
    _filteredCoins = tempFilteredCoins;
    update();
  }

  setLoading(bool value){
    _isLoading=value;
    update();
  }

  addCoinToList(CoinModel _coin) {
    bool exists = _allCoins.any((coin) => coin.id == _coin.id);

    if (!exists) {
      _allCoins.add(_coin);

      String category = _coin.category;

      if (!categorizedCoins.containsKey(category)) {
        categorizedCoins[category] = [];
      }

      categorizedCoins[category]!.add(_coin);
    }

    _allCoins.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    categorizedCoins.forEach((key, list) {
      list.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    });

    update();
  }

  void replaceCoinInList(CoinModel updatedCoin) {

    int index = _allCoins.indexWhere((coin) => coin.id == updatedCoin.id);

    if (index != -1) {
      _allCoins[index] = updatedCoin;

      String category = updatedCoin.category;

      categorizedCoins.forEach((key, list) {
        list.removeWhere((coin) => coin.id == updatedCoin.id);
      });

      if (!categorizedCoins.containsKey(category)) {
        categorizedCoins[category] = [];
      }
      categorizedCoins[category]!.add(updatedCoin);

      _allCoins.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      categorizedCoins.forEach((key, list) {
        list.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      });

      update();
    } else {
      print('Coin with id ${updatedCoin.id} not found.');
    }
  }

  void removeCoinFromList(CoinModel coinModel) {
    _allCoins.removeWhere((element) => element.id==coinModel.id);
    update();
  }

  setCoinCategories(List<String> value) {
    _coinCategories.clear();
    _coinCategories = value;
    update();
  }

  getCoinCategories() {
    CoinService().getCoinCategories();
  }

  getCoins(){
    CoinService().getCoins();
  }

  Future<bool>createCoin(
    CoinModel coinModel,
    html.File coinFront,
    html.File coinBack,
    html.File coinAudio,
  ) {
    return CoinService().createCoin(coinModel, coinFront, coinBack, coinAudio);
  }

  Future<bool> updateCoin(CoinModel coinModel, html.File? coinFront, html.File? coinBack, html.File? coinAudio) {
    return CoinService().updateCoin(coinModel, coinFront, coinBack, coinAudio);
  }

   deleteCoin(CoinModel coin) {
    CoinService().deleteCoin(coin);
   }


}
