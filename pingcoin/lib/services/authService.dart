import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/firebaseRef.dart';
import 'package:pingcoin/controllers/authController.dart';
import 'package:pingcoin/models/adInterestModel.dart';
import 'package:pingcoin/models/businessModel.dart';
import 'package:pingcoin/models/userModel.dart';
import 'package:pingcoin/widgets/customSnackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/dashboard/dashboard.dart';

class AuthService {
  AuthController _authController = Get.find<AuthController>();

  getAdInterests() async {
    List<AdInterestModel> interestList = [];
    await adInterestRef.get().then((value) {
      for (var item in value.docs) {
        AdInterestModel _adInterestModel = AdInterestModel.fromMap(item.data());
        interestList.add(_adInterestModel);
      }
      _authController.populateInterestList(interestList);
    });
  }

  signup(String name, String email, String password, Set<AdInterestModel> selectedInterests) async {
    _authController.setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      List<String> interests = [];
      for (var item in selectedInterests) {
        interests.add(item.id);
      }
      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          fullName: name,
          email: email,
          createdAt: DateTime.now(),
          status: "Active",
          interests: interests,
          favorites: [],
          updatedAt: DateTime.now());

      await userRef.doc(userModel.id).set(userModel.toMap());
      _authController.setUserModel(userModel);
      prefs.setString("pingUserId", userModel.id);
      getUserData(userModel.id);
      _authController.setLoading(false);
      Get.offAll(Dashboard(), transition: Transition.circularReveal);
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show("Error", "Something went wrong. Try again later", isSuccess: false);
      _authController.setLoading(false);
    }
  }

  login(String email, String password) async {
    _authController.setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      prefs.setString("pingUserId", userCredential.user!.uid);
      getUserData(userCredential.user!.uid);

      _authController.setLoading(false);
      Get.offAll(Dashboard(), transition: Transition.circularReveal);
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show("Error", "Something went wrong. Try again later", isSuccess: false);
      _authController.setLoading(false);
    }
  }

  updateProfile(String name) async {
    _authController.setLoading(true);
    await userRef.doc(_authController.userModel!.id).update({"fullName": name});
    UserModel user = _authController.userModel!;
    user.fullName = name;
    _authController.setUserModel(user);
    _authController.setLoading(false);
    Get.back();
    CustomSnackbar.show("Success", "Profile updated successfully");
  }

  getUserData(String userId) {
    userRef.doc(userId).snapshots().listen((event) {
      _authController.setUserModel(UserModel.fromMap(event.data()!));
      _authController.getFavorites();
    });
  }

  setBusinessRequest(BusinessDevelopmentModel businessDevelopmentModel, File bannerImage) async {
    _authController.setLoading(true);
    businessDevelopmentModel.id = businessesRef.doc().id;
    businessDevelopmentModel.specificCode = businessDevelopmentModel.id.substring(0, 5);
    try {
      businessDevelopmentModel.image = (await uploadFileToFirebase(bannerImage, "business/${businessDevelopmentModel.id}"))!;
      await businessesRef.doc(businessDevelopmentModel.id).set(businessDevelopmentModel.toMap());
      _authController.setLoading(false);
      Get.back();
      CustomSnackbar.show("Success", "Business request submitted successfully");
    } catch (e) {
      CustomSnackbar.show("Error", "Something went wrong.", isSuccess: false);
      _authController.setLoading(false);
    }
  }

  Future<String?> uploadFileToFirebase(File file, String path) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(path);

      final uploadTask = storageRef.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }
}
