import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/controllers/authController.dart';
import 'package:pingcoin/views/dashboard/subScreens/profile/editProfile.dart';
import 'package:pingcoin/widgets/customButton.dart';
import 'package:pingcoin/widgets/infoButton.dart';

import '../../../constants/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: GetBuilder<AuthController>(builder: (authController) {
        return SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/logo.svg",
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        "assets/svgs/logoTextSmall.svg",
                      ),
                    ],
                  ),
                  InfoButton(),
                ],
              ).marginSymmetric(horizontal: 12),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                child: Column(
                  children: [
                    Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff19181E)
                      ),
                      alignment: Alignment.center,
                      child: Text("${authController.userModel!.fullName.substring(0,1)}",style: TextStyle(
                          color: rGreen,
                          fontSize: 56
                      ),),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("${authController.userModel!.fullName}",style: TextStyle(color: rWhite,fontSize: 24),),
                    SizedBox(
                      height: 30,
                    ),
                    Text("${authController.userModel!.email}",style: TextStyle(color: rHint,fontSize: 16),),

                  ],
                ),
              ),

              Expanded(child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(label: "Edit",func: editProfile,)).marginSymmetric(horizontal: 20)),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        );
      },),
    );
  }
  editProfile(){
    Get.to(EditProfile(),transition: Transition.fade);
  }
}
