import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/widgets/infoButton.dart';

import '../../../constants/colors.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  InfoButton()
                ],
              ).marginSymmetric(horizontal: 12),
              SizedBox(
                height: 20,
              ),
              Text("Coin Text Demo",style: TextStyle(color: rWhite,fontWeight: FontWeight.w600,fontSize: 20),),
              Text("Watch this quick tutorial to see how to test your coins with precision. Tap, analyze, and verify in seconds!",textAlign: TextAlign.center,style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 12),).marginSymmetric(horizontal: MediaQuery.of(context).size.width*0.1),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.65,
                decoration: BoxDecoration(
                  color: rBlack.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(24)
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset("assets/svgs/play.svg"),
              ).marginAll(12)

            ],
          ),
        ),
      ),
    );
  }
}
