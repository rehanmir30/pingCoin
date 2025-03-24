import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pingcoin_admin/constants/firebaseRef.dart';
import 'package:pingcoin_admin/controllers/userController.dart';
import 'package:pingcoin_admin/models/userModel.dart';
import 'package:pingcoin_admin/widgets/customSnackbar.dart';

import '../views/tabs/usersTab.dart';

class UserService{

  UserController _userController=Get.find<UserController>();

  getAllUsers()async{
    userRef.snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if(element.type==DocumentChangeType.added||element.type==DocumentChangeType.modified){
          _userController.addUserToList(UserModel.fromMap(element.doc.data()!));
        }
      });
    });
  }

   blockUser(UserModel userModel, bool value,var callBack) async{
    if(value==true){
      await userRef.doc(userModel.id).update({"status":"Blocked"});
      CustomSnackbar.show("Success", "User blocked successfully");
      return callBack(UsersTab(callBack: callBack));
    }else{
      await userRef.doc(userModel.id).update({"status":"Active"});
      CustomSnackbar.show("Success", "User activated successfully");
      return callBack(UsersTab(callBack: callBack));
    }

   }
}