import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/controllers/contentController.dart';
import 'package:pingcoin/models/faqModel.dart';

import '../../../../constants/colors.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {

  List<String> questions=[
    "What is PINGCOIN?",
    "How does it work?",
    "How accurate is it?",
    "Who can use it?",
    "Does it detect all coins?",
    "How long does it take to get results?",
    "Can it help with buying or selling?",
    "Can I verify rare coins?",
    "Is it available on both Android and iOS?"
  ];
  List<String> answers=[
    "A tool that uses sound wave analysis to verify the authenticity of silver and gold coins.",
    "Tap the coin to analyze its frequency and compare it to a database of verified profiles.",
    "Results are precise, based on sound wave analysis compared to verified profiles.",
    "Coin collectors, investors, and enthusiasts.",
    "Mainly silver and gold coins, depending on the profile in the database.",
    "Results are provided instantly, within seconds.",
    "The app will alert you if the coin doesn’t match any verified profile.",
    "It depends on whether the coin's profile is in the database.",
    "Yes, it works on both platforms."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ContentController>(builder: (contentController) {
            return Column(
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
                Text("FAQs",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "font2"),).marginSymmetric(horizontal: 12).marginOnly(top: 20),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: contentController.allFaqs.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return FAQTile(contentController.allFaqs[index]);
                    }).marginOnly(bottom: 20),
              ],
            );
          },),
        ),
      ),
    );
  }
}

class FAQTile extends StatefulWidget {
  final FAQModel faq;
  const FAQTile(this.faq,{super.key});

  @override
  State<FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${widget.faq.question}",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 16),),
        Text("${widget.faq.answer}",style: TextStyle(color: rHint,fontWeight: FontWeight.normal,fontSize: 14),),
      ],
    ).marginSymmetric(horizontal: 12).marginOnly(top: 30);
  }
}

