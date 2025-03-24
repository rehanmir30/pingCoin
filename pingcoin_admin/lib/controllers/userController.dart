import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/services/userService.dart';

import '../models/userModel.dart';

class UserController extends GetxController {
  List<UserModel> _allUsers = [];
  List<UserModel> get allUsers => _allUsers;

  List<String> _filterStatuses=["Active","Blocked"];
  List<String> get filterStatuses=>_filterStatuses;

  Map<String, List<UserModel>> _categorizedUsers = {};
  Map<String, List<UserModel>> get categorizedUsers => _categorizedUsers;

  TextEditingController searchController = TextEditingController();
  TextEditingController filterDateController = TextEditingController();

  List<UserModel> _filteredUsers=[];
  List<UserModel> get filteredUsers=>_filteredUsers;

  String? _selectedStatus;
  String? get selectedStatus=>_selectedStatus;

  DateTime? _selectedDate;
  DateTime? get selectedDate=>_selectedDate;

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

  setFilterStatus(String? value){
    _selectedStatus=value;
    update();
  }

  searchFilter() {
    var tempFilteredUsers = _allUsers;

    if (_selectedStatus != null) {
      tempFilteredUsers = tempFilteredUsers.where((user) {
        return user.status.toLowerCase() == _selectedStatus!.toLowerCase();
      }).toList();
    }

    if (_selectedDate != null) {
      tempFilteredUsers = tempFilteredUsers.where((user) {
        return user.createdAt.year == _selectedDate!.year &&
            user.createdAt.month == _selectedDate!.month &&
            user.createdAt.day == _selectedDate!.day;
      }).toList();
    }

    if (searchController.text.isNotEmpty) {
      tempFilteredUsers = tempFilteredUsers.where((user) {
        return user.fullName.toLowerCase().contains(searchController.text.toLowerCase()) ||
            user.email.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }

    // Update filtered users list
    _filteredUsers = tempFilteredUsers;
    update();
  }

  addUserToList(UserModel _user) {
    int existingUserIndex = _allUsers.indexWhere((user) => user.id == _user.id);

    if (existingUserIndex != -1) {
      UserModel existingUser = _allUsers.removeAt(existingUserIndex);

      String existingStatus = existingUser.status;
      _categorizedUsers[existingStatus]?.removeWhere((user) => user.id == existingUser.id);
    }

    _allUsers.add(_user);

    String status = _user.status;
    _categorizedUsers.putIfAbsent(status, () => []);
    _categorizedUsers[status]!.add(_user);

    _allUsers.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    _categorizedUsers.forEach((key, list) {
      list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    });

    update();
  }

  getAllUser() {
    UserService().getAllUsers();
  }

  blockUser(UserModel userModel, bool value, var callBack) {
    UserService().blockUser(userModel, value, callBack);
  }

}
