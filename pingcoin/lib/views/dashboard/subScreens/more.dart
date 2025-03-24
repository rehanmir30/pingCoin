import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/views/dashboard/subScreens/more/aboutScreen.dart';
import 'package:pingcoin/views/dashboard/subScreens/more/businessDevelopment.dart';
import 'package:pingcoin/views/dashboard/subScreens/more/faqs.dart';
import 'package:pingcoin/views/dashboard/subScreens/more/privacyScreen.dart';
import 'package:pingcoin/views/dashboard/subScreens/more/termsScreen.dart';

import '../../../constants/colors.dart';
import 'more/feedbackScreen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  List<String> options=["About","FAQs","Feedback/Support","Business Development","Privacy Policy","Terms and conditions"];

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
            SizedBox(height: 20,),
            Text("More",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "font2"),),

            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return OptionTile(options[index]);
                }),

          ],
        ).marginSymmetric(horizontal: 12),
      ),
    );
  }
}
class OptionTile extends StatefulWidget {
  final String option;
  const OptionTile(this.option,{super.key});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.option=="About"){
          Get.to(AboutScreen(),transition: Transition.fade);
        }else if(widget.option=="FAQs"){
          Get.to(FAQsScreen(),transition: Transition.fade);
        }else if(widget.option=="Feedback/Support"){
          Get.to(FeedbackScreen(),transition: Transition.fade);
        }else if(widget.option=="Business Development"){
          Get.to(BusinessDevelopment(),transition: Transition.fade);
        }else if(widget.option=="Privacy Policy"){
          Get.to(PrivacyScreen(),transition: Transition.fade);
        }else if(widget.option=="Terms and conditions"){
          Get.to(TermsScreen(),transition: Transition.fade);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${widget.option}",style: TextStyle(color: rWhite,fontSize: 16,fontWeight: FontWeight.w600),),
          Icon(Icons.navigate_next,color: rWhite,)
        ],
      ).marginOnly(top: 40),
    );
  }
}

