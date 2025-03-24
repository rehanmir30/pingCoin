import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/services/supportService.dart';

import '../models/supportModel.dart';

class SupportController extends GetxController{
  List<SupportModel> _allSupports=[];
  List<SupportModel> get allSupports=>_allSupports;

  List<SupportModel> _filteredSupports=[];
  List<SupportModel> get filteredSupports=>_filteredSupports;

  DateTime? _selectedDate;
  DateTime? get selectedDate=>_selectedDate;

  TextEditingController searchController = TextEditingController();
  TextEditingController filterDateController = TextEditingController();

  setFilterDate(DateTime? dateTime){
    if(dateTime!=null){
      _selectedDate=dateTime;
      filterDateController.text="${DateFormat('dd, MM, yyyy').format(dateTime)}";
    }else{
      filterDateController.text="";
      _selectedDate=null;
    }
    update();
  }

  searchFilter() {
    var tempFilteredSupports = allSupports;

    if (_selectedDate != null) {
      tempFilteredSupports = tempFilteredSupports.where((support) {
        return support.createdAt.year == _selectedDate!.year &&
            support.createdAt.month == _selectedDate!.month &&
            support.createdAt.day == _selectedDate!.day;
      }).toList();
    }

    if (searchController.text.isNotEmpty) {
      tempFilteredSupports = tempFilteredSupports.where((support) {
        return support.fullName.toLowerCase().contains(searchController.text.toLowerCase()) ||
            support.id.toLowerCase().contains(searchController.text.toLowerCase()) ||
            support.email.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }

    // Update filtered supports list
    _filteredSupports = tempFilteredSupports;
    update();
  }

  addSupportToList(SupportModel value){
    int existingAdIndex = _allSupports.indexWhere((support) => support.id == value.id);
    if (existingAdIndex != -1) {
      _allSupports.removeAt(existingAdIndex);
    }
    _allSupports.add(value);
    update();
  }

  getAllSupports(){
    SupportService().getAllSupports();
  }
}