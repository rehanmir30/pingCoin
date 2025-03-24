import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/firebaseRef.dart';
import 'package:pingcoin/controllers/authController.dart';
import 'package:pingcoin/models/adInterestModel.dart';
import 'package:pingcoin/models/userModel.dart';
import 'package:pingcoin/widgets/customSnackbar.dart';

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
          updatedAt: DateTime.now());

      await userRef.doc(userModel.id).set(userModel.toMap());
      _authController.setUserModel(userModel);
      _authController.setLoading(false);
      Get.offAll(Dashboard(),transition: Transition.circularReveal);
    } on FirebaseAuthException catch (e) {
      CustomSnackbar.show("Error", "Something went wrong. Try again later",isSuccess: false);
      _authController.setLoading(false);
    }
  }

   login(String email, String password) async {
     _authController.setLoading(true);
     try{
       final FirebaseAuth _auth = FirebaseAuth.instance;
       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
         email: email,
         password: password,
       );

       await userRef.doc(userCredential.user!.uid).get().then((value) {
         _authController.setUserModel(UserModel.fromMap(value.data()!));
         _authController.setLoading(false);
         Get.offAll(Dashboard(),transition: Transition.circularReveal);
       });

     }on FirebaseAuthException catch (e){
       CustomSnackbar.show("Error", "Something went wrong. Try again later",isSuccess: false);
       _authController.setLoading(false);
     }
   }

   updateProfile(String name) async{
    _authController.setLoading(true);
    await userRef.doc(_authController.userModel!.id).update({"fullName":name});
    UserModel user= _authController.userModel!;
    user.fullName=name;
    _authController.setUserModel(user);
    _authController.setLoading(false);
    Get.back();
    CustomSnackbar.show("Success", "Profile updated successfully");
   }
}
