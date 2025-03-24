import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/constants/colors.dart';
import 'package:pingcoin_admin/controllers/authController.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

import '../../widgets/customLoading.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {

  String firstName='';
  String lastName='';

  @override
  void initState() {
    firstName=Get.find<AuthController>().managementUserModel!.firstName;
    lastName=Get.find<AuthController>().managementUserModel!.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: GetBuilder<AuthController>(builder: (authController) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(title: "Profile"),
                Container(
                  decoration: BoxDecoration(
                    color: rBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //profile picture
                          Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      color: rBlack,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${authController.managementUserModel!.firstName.substring(0,1)}${authController.managementUserModel!.lastName.substring(0,1)}",
                                      style: TextStyle(color: rWhite, fontSize: 20),
                                    ),
                                  ),
                                  // Positioned(
                                  //   bottom: 5,
                                  //   right: 0,
                                  //   child: Container(
                                  //     width: 50,
                                  //     height: 50,
                                  //     decoration: BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       color: rBg,
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //     child: SvgPicture.asset("assets/svgs/edit.svg"),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Text(
                                "${authController.managementUserModel!.firstName} ${authController.managementUserModel!.lastName}",
                                style: TextStyle(color: rWhite, fontSize: 20),
                              ).marginOnly(top: 12),
                              SizedBox(height: 60),
                            ],
                          ),

                          //first name and email
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextField("First name", "${authController.managementUserModel!.firstName}"),
                              SizedBox(height: 20),
                              _buildTextField("Email", "${authController.managementUserModel!.email}", readOnly: true),
                              SizedBox(height: 60),
                            ],
                          ),

                          //last name and password
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextField("Last name", "${authController.managementUserModel!.lastName}"),
                              SizedBox(height: 20),
                              _buildTextField("Password", "1234567890", obscureText: true, readOnly: true),
                              SizedBox(height: 20),
                              // Align the "Change Password" and "Update" button to the right
                              Container(
                                width: MediaQuery.of(context).size.width * 0.23, // Match the width of the text fields
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        showChangePasswordPopup();
                                      },
                                      child: Text(
                                        "Change Password",
                                        style: TextStyle(color: Color(0xffFF9E00)),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    InkWell(
                                      onTap: (){
                                        authController.updateProfile(firstName,lastName);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: rGreen,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Update",
                                          style: TextStyle(color: rWhite),
                                        ).marginSymmetric(horizontal: 25, vertical: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ).marginSymmetric(horizontal: 50, vertical: 20),
                ).marginSymmetric(vertical: 20)
              ],
            ).marginSymmetric(horizontal: 20, vertical: 10),
            Visibility(
                visible: authController.isLoading,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: rWhite.withOpacity(0.2),
                    child: CustomLoading()))
          ],
        );
      },),
    );
  }

  showChangePasswordPopup(){
    bool oldPaswordObsecure=true;
    bool newPaswordObsecure=true;
    bool confirmPaswordObsecure=true;
    var formKey=GlobalKey<FormState>();
    String oldPassword="";
    String newPassword="";
    String confirmPassword="";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ElasticIn(
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: rBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Center(child: Text("Change Password", style: TextStyle(fontWeight: FontWeight.bold, color: rWhite))),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        cursorColor: rGreen,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Old Password is required";
                          } else {
                            oldPassword=password;
                            return null;
                          }
                        },
                        obscureText: oldPaswordObsecure,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Old password',
                          suffixIcon: InkWell(
                              splashColor: Colors.transparent,
                              onTap: (){
                                setState(() {
                                  oldPaswordObsecure= !oldPaswordObsecure;
                                });
                              },
                              child: Icon(oldPaswordObsecure?Icons.visibility_off_outlined:Icons.visibility_outlined)),
                          hintStyle: TextStyle(
                            color: rHint,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: rHint,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: rHint,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white, // Text color
                        ),
                      ),
                    ).marginOnly(top: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        cursorColor: rGreen,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "New password is required";
                          } else if(password.length<6){
                            return "New password should not be less than 6 characters";
                          }else {
                            newPassword=password;
                            return null;
                          }
                        },
                        obscureText: newPaswordObsecure,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'New password',
                          suffixIcon: InkWell(
                              splashColor: Colors.transparent,
                              onTap: (){
                                setState(() {
                                  newPaswordObsecure= !newPaswordObsecure;
                                });
                              },
                              child: Icon(newPaswordObsecure?Icons.visibility_off_outlined:Icons.visibility_outlined)),
                          hintStyle: TextStyle(
                            color: rHint,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: rHint,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: rHint,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white, // Text color
                        ),
                      ),
                    ).marginOnly(top: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        cursorColor: rGreen,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Confirm password is required";
                          } else if(password!=newPassword){
                            return "Confirm password should match new password";
                          }else {
                            confirmPassword=password;
                            return null;
                          }
                        },
                        obscureText: confirmPaswordObsecure,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Confirm password',
                          suffixIcon: InkWell(
                              splashColor: Colors.transparent,
                              onTap: (){
                                setState(() {
                                  confirmPaswordObsecure= !confirmPaswordObsecure;
                                });
                              },
                              child: Icon(confirmPaswordObsecure?Icons.visibility_off_outlined:Icons.visibility_outlined)),
                          hintStyle: TextStyle(
                            color: rHint,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: rHint,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: rHint,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white, // Text color
                        ),
                      ),
                    ).marginOnly(top: 12),

                    InkWell(
                      onTap: (){
                        if(formKey.currentState!.validate()){
                          Get.find<AuthController>().updatePassword(oldPassword,newPassword);
                        }else{
                          return;
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 40,
                        decoration: BoxDecoration(
                          color: rGreen,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        child: Text("Update",style: TextStyle(color: rWhite),),
                      ).marginOnly(top: 12),
                    ),

                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",style: TextStyle(color: rRed),).marginOnly(top: 20))
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
            );
          },),
        );
      },
    );
  }

  Widget _buildTextField(String label, String initialValue, {bool obscureText = false, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: rWhite, fontSize: 12)),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.23,
          child: TextFormField(
            cursorColor: rGreen,
            initialValue: initialValue,
            obscureText: obscureText,
            readOnly: readOnly,
            onChanged: (value){
              if(label=="First name"){
                firstName=value;
              }else if(label=="Last name"){
                lastName=value;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              hintStyle: TextStyle(color: rHint),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: rHint),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: rHint),
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
            style: TextStyle(color: readOnly ? rHint : Colors.white),
          ),
        ),
      ],
    );
  }
}