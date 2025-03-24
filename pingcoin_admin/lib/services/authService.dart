import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/authController.dart';
import 'package:pingcoin_admin/constants/firebaseRef.dart';
import 'package:pingcoin_admin/models/managementModel.dart';
import 'package:pingcoin_admin/widgets/customSnackbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;
import '../views/dashboard.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthController _authController = Get.find<AuthController>();

  // createAdmin() async {
  //   try {
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: "admin@pingcoin.com",
  //       password: "123456",
  //     );
  //     ManagementModel _managementModel = ManagementModel(id: userCredential.user!.uid,
  //         email: userCredential.user!.email!,
  //         userName: "Admin",
  //         role: "Super_Admin",
  //         createdAt: DateTime.now(),
  //         updatedAt: DateTime.now());
  //     await managementRef.doc(_managementModel.id).set(_managementModel.toMap());
  //   } on FirebaseAuthException catch (e) {
  //     print('Error creating admin: ${e.message}');
  //   }
  // }

  Future<void> login(String email, String password) async {
    _authController.setLoading(true);
    try {
      // SharedPreferences prefs=await SharedPreferences.getInstance();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      html.window.localStorage['adminId'] = userCredential.user!.uid;
      // await prefs.setString("adminId", "${userCredential.user!.uid}");
      await managementRef.doc(userCredential.user!.uid).get().then((value) {
        _authController.setManagementUserModel(ManagementModel.fromMap(value.data()!));
        _authController.setLoading(false);
        Get.offAll(DashboardScreen(),transition: Transition.downToUp);
      });

    } on FirebaseAuthException catch (e) {
      print("Error logging in");
      _authController.setLoading(false);
    }
  }

   updateProfile(String firstName, String lastName) async{
    _authController.setLoading(true);
    await managementRef.doc(_authController.managementUserModel!.id).update({"firstName":firstName,"lastName":lastName,"updatedAt":DateTime.now()});
    await managementRef.doc(_authController.managementUserModel!.id).get().then((value) {
      _authController.setManagementUserModel(ManagementModel.fromMap(value.data()!));
    });
    _authController.setLoading(false);
    CustomSnackbar.show("Success", "Profile updated successfully");
   }

   getContent() {
    sysConfigRef.doc("Content").snapshots().listen((event) {
      if(event.exists){
        _authController.setContent(event.data()!);
      }
    });
   }

   updateContent(String type, String content) {
    sysConfigRef.doc("Content").update({type:content});
    CustomSnackbar.show("Success", "${type} updated successfully");
   }

   updatePassword(String oldPassword, String newPassword) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _authController.managementUserModel!.email,
        password: oldPassword,
      );

      // Update password
      await userCredential.user?.updatePassword(newPassword);
      Get.back();
      CustomSnackbar.show("Success", "Password updated successfully");
    }catch (e){
      CustomSnackbar.show("Error", "Failed to update password\nRecheck your old password",isSuccess: false);
    }
   }

   getAdminDetails() async{
    // SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String? adminId=html.window.localStorage['adminId'];;

    await managementRef.doc(adminId).get().then((value) {
      _authController.setManagementUserModel(ManagementModel.fromMap(value.data()!));
    });
   }

}
