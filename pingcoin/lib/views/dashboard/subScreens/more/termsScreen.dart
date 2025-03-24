import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../constants/colors.dart';
import '../../../../controllers/contentController.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SafeArea(
        child: GetBuilder<ContentController>(builder: (contentController) {
          return SingleChildScrollView(
            child: Column(
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
                Text("Terms and Conditions",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "font2"),).marginSymmetric(horizontal: 12).marginOnly(top: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.2,
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/svgs/logo.svg"),
                ),
                Text("${contentController.contentModel!.terms}",style: TextStyle(color: rWhite),).marginSymmetric(horizontal: 12),
              ],
            ),
          );
        },),
      ),
    );
  }
}
