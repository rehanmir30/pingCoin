import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pingcoin/views/dashboard/dashboard.dart';
import 'package:pingcoin/widgets/customButton.dart';

import '../constants/colors.dart';

class InfoButton extends StatefulWidget {
  const InfoButton({super.key});

  @override
  State<InfoButton> createState() => _InfoButtonState();
}

class _InfoButtonState extends State<InfoButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showTestCoinDialog(context);
      },
      child: Icon(
        Icons.info_outline,
        color: rWhite,
      ),
    );
  }
  void showTestCoinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: rPopupBg,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // Popup Box
              Container(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 20), // Adjusted for spacing
                decoration: BoxDecoration(
                  color: rPopupBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      "How to Test Your Coin",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),

                    // Instructions
                    Text(
                      "Place the coin on a flat surface or balance point.\n\n"
                          "Make sure the coin is stable and not wobbling.\n\n"
                          "Tap the edge of the coin lightly with a small object.\n\n"
                          "Make sure there is no background noise for accurate results.",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 40),

                    TextButton(
                      onPressed: () {
                        Get.offAll(Dashboard(index: 2,),transition: Transition.circularReveal);
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svgs/camera.svg"),
                          SizedBox(width: 8),
                          Text("Watch Video Demo", style: TextStyle(color: Colors.white,fontSize: 16)),
                        ],
                      ).marginSymmetric(vertical: 8),
                    ).marginSymmetric(horizontal: 8),
                    SizedBox(height: 10),

                    // Confirmation Button
                    CustomButton(label: "Got  it, Let's Test!", func: letsTest).marginOnly(bottom: 20),

                  ],
                ),
              ),

              Positioned(
                top: -35, // Moves it half outside the popup
                child: Container(
                  width: 60,
                  height: 60,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: rGreen,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -36,
                child: Container(
                  width: 59,
                  height: 59,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: rPopupBg,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset("assets/svgs/logo.svg",width: 47,height: 47,),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
  letsTest(){
    Get.back();
  }
}
