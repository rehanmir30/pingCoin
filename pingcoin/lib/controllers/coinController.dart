import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/coinModel.dart';
import '../services/coinService.dart';

class CoinController extends GetxController{

  List<CoinModel> _allCoins=[];
  List<CoinModel> get allCoins=>_allCoins;

  Map<String, List<CoinModel>> _categorizedCoins = {};
  Map<String, List<CoinModel>> get categorizedCoins =>_categorizedCoins;

  TextEditingController searchController=TextEditingController();

  List<CoinModel> _filteredCoins=[];
  List<CoinModel> get filteredCoins=>_filteredCoins;

  searchFilter() {
    List<CoinModel> tempFilteredCoins = [];

    if (searchController.text.isNotEmpty) {
      tempFilteredCoins = _allCoins.where((user) {
        return user.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
            user.category.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }

    _filteredCoins = tempFilteredCoins;
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

  replaceCoinInList(CoinModel updatedCoin) {

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

  removeCoinFromList(CoinModel coinModel) {
    _allCoins.removeWhere((element) => element.id==coinModel.id);
    update();
  }

  getCoins(){
    CoinService().getCoins();
  }

  addToFavorite(CoinModel coinModel) {
    CoinService().addToFavorites(coinModel);
  }

   removeFromFavorite(CoinModel coinModel) {
     CoinService().removeFromFavorites(coinModel);
   }
}