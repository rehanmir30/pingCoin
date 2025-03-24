import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/models/businessModel.dart';
import 'package:pingcoin_admin/services/businessService.dart';

class BusinessController extends GetxController{

  List<BusinessDevelopmentModel> _allBusinesses=[];
  List<BusinessDevelopmentModel> get allBusinesses=>_allBusinesses;

  List<BusinessDevelopmentModel> _filteredBusinesses=[];
  List<BusinessDevelopmentModel> get filteredBusinesses=>_filteredBusinesses;

  List<String> _filterStatuses=["Active","Pause","Completed","Cancelled"];
  List<String> get filterStatuses=>_filterStatuses;

  String? _selectedStatus;
  String? get selectedStatus=>_selectedStatus;

  DateTime? _selectedDate;
  DateTime? get selectedDate=>_selectedDate;

  TextEditingController searchController = TextEditingController();
  TextEditingController filterDateController = TextEditingController();

  Map<String, List<BusinessDevelopmentModel>> _categorizedBusiness = {};
  Map<String, List<BusinessDevelopmentModel>> get categorizedBusiness =>_categorizedBusiness;

  setFilterStatus(String? value){
    _selectedStatus=value;
    update();
  }

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
    var tempFilteredBusinesses = _allBusinesses;

    // Apply status filter if selected
    if (_selectedStatus != null) {
      tempFilteredBusinesses = tempFilteredBusinesses.where((business) {
        return business.status.toLowerCase() == _selectedStatus!.toLowerCase();
      }).toList();
    }

    // Apply date filter if selected
    if (_selectedDate != null) {
      tempFilteredBusinesses = tempFilteredBusinesses.where((business) {
        // Assuming business has a createdAt or registrationDate field of type DateTime
        // Compare only the date part (ignoring time)
        return business.starTime.year == _selectedDate!.year &&
            business.starTime.month == _selectedDate!.month &&
            business.starTime.day == _selectedDate!.day;
      }).toList();
    }

    // Apply text search filter if text is entered
    if (searchController.text.isNotEmpty) {
      tempFilteredBusinesses = tempFilteredBusinesses.where((business) {
        return business.fullName.toLowerCase().contains(searchController.text.toLowerCase()) ||
            business.id.toLowerCase().contains(searchController.text.toLowerCase()) ||
            business.description.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }

    // Update filtered businesses list
    _filteredBusinesses = tempFilteredBusinesses;
    update();
  }

  addBusinessToList(BusinessDevelopmentModel businessModel) {
    int existingAdIndex = _allBusinesses.indexWhere((business) => business.id == business.id);
    if (existingAdIndex != -1) {
      // _allAds.removeAt(existingAdIndex);
      BusinessDevelopmentModel existingBusiness = _allBusinesses.removeAt(existingAdIndex);

      String existingStatus = existingBusiness.status;
      _categorizedBusiness[existingStatus]?.removeWhere((user) => user.id == existingBusiness.id);
    }
    _allBusinesses.add(businessModel);
    String status = businessModel.status;
    _categorizedBusiness.putIfAbsent(status, () => []);
    _categorizedBusiness[status]!.add(businessModel);

    update();
  }

  getAllBusinesses(){
    BusinessService().getAllBusinesses();
  }

}