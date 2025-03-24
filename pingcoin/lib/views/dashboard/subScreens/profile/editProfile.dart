import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/controllers/authController.dart';

import '../../../../animations/fadeInAnimationTTB.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/customButton.dart';
import '../../../../widgets/customLoading.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();


  @override
  void initState() {
    super.initState();

    nameController.text=Get.find<AuthController>().userModel!.fullName;
    emailController.text=Get.find<AuthController>().userModel!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: GetBuilder<AuthController>(builder: (authController) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back,color: rWhite,)),
                      SvgPicture.asset(
                        "assets/svgs/logo.svg",
                        width: 40,
                        height: 40,
                      ).marginOnly(left: 12),
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        "assets/svgs/logoTextSmall.svg",
                      ),
                    ],
                  ).marginSymmetric(horizontal: 12),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment:Alignment.center,
                            child: Text("Edit Profile",style: TextStyle(color: rWhite,fontSize: 24,fontWeight: FontWeight.w600),)),
                        SizedBox(
                          height: 20,
                        ),
                        //Full Name
                        Text(
                          "Full Name",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        FadeInAnimationTTB(
                          delay: 1,
                          child: TextFormField(
                            cursorColor: rGreen,
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Enter your full name',
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
                                prefixIcon: SvgPicture.asset(
                                  "assets/svgs/profile.svg",
                                  color: rWhite,
                                ).marginAll(9)),
                            style: TextStyle(
                              color: Colors.white, // Text color
                            ),
                          ).marginOnly(top: 8),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //email
                        Text(
                          "Email",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        FadeInAnimationTTB(
                          delay: 1,
                          child: TextFormField(
                            cursorColor: rGreen,
                            keyboardType: TextInputType.emailAddress,
                            initialValue: "${authController.userModel!.email}",
                            readOnly: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0x77dadada),
                                hintText: 'Enter your email',
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
                                prefixIcon: SvgPicture.asset(
                                  "assets/svgs/mail.svg",
                                  color: Color(0xff969696),
                                ).marginAll(9)),
                            style: TextStyle(
                              color: Color(0xff969696), // Text color
                            ),
                          ).marginOnly(top: 8),
                        ),

                      ],
                    ).marginSymmetric(horizontal: 12),
                  ),

                  Expanded(child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(label: "Update",func: updateProfile,)).marginSymmetric(horizontal: 20)),
                  SizedBox(
                    height: 140,
                  ),
                ],
              ),
              Visibility(
                  visible: authController.isLoading,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: rWhite.withOpacity(0.2),
                      child: CustomLoading()))
            ],
          ),
        );
      },),
    );
  }
  updateProfile(){
    Get.find<AuthController>().updateProfile(nameController.text);
  }
}
