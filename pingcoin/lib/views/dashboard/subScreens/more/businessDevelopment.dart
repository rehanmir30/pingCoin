import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../animations/fadeInAnimationTTB.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/customButton.dart';

class BusinessDevelopment extends StatefulWidget {
  const BusinessDevelopment({super.key});

  @override
  State<BusinessDevelopment> createState() => _BusinessDevelopmentState();
}

class _BusinessDevelopmentState extends State<BusinessDevelopment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SafeArea(
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
            ),
            Text("Business Development",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "font2"),).marginSymmetric(horizontal: 12).marginOnly(top: 20),

            SizedBox(
              height: 30,
            ),

            //name
            FadeInAnimationTTB(
              delay: 1,
              child: TextFormField(
                cursorColor: rGreen,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Full name',
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
              ).marginOnly(top: 8),
            ),
            SizedBox(
              height: 20,
            ),

            //email
            FadeInAnimationTTB(
              delay: 1,
              child: TextFormField(
                cursorColor: rGreen,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Email',
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
              ).marginOnly(top: 8),
            ),
            SizedBox(
              height: 20,
            ),

            //message
            FadeInAnimationTTB(
              delay: 1,
              child: TextFormField(
                cursorColor: rGreen,
                keyboardType: TextInputType.emailAddress,
                maxLines: 8,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Message...',
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
              ).marginOnly(top: 8),
            ),
            SizedBox(
              height: 20,
            ),
            //Button
            CustomButton(label: "Submit", func: submitBtn),

            SizedBox(
              height: MediaQuery.of(context).size.height*0.05,
            )

          ],
        ).marginSymmetric(horizontal: 12),
      ),

    );
  }
  submitBtn(){
    Get.back();
  }
}
