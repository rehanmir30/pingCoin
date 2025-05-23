import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/animations/fadeInAnimationBTT.dart';
import 'package:pingcoin/animations/fadeInAnimationTTB.dart';
import 'package:pingcoin/constants/colors.dart';
import 'package:pingcoin/services/authService.dart';
import 'package:pingcoin/views/dashboard/dashboard.dart';
import 'package:pingcoin/views/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/authController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.2,
              )
            ],
          ),
          FadeInAnimationTTB(
              delay: 2,
              child: SvgPicture.asset("assets/svgs/logo.svg")),
          FadeInAnimationTTB(
              delay: 2,
              child: SvgPicture.asset("assets/svgs/logoText.svg").marginOnly(top: 20)),
          SizedBox(
            height: 20,
          ),
          Text("Authenticity at the Tap of a Coin",style: TextStyle(color: rWhite,fontSize: 16,fontWeight: FontWeight.normal),),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
          ),
          FadeInAnimationBTT(
              delay: 3,
              child: Image.asset("assets/images/coinSplash.png"))
        ],
      ),
    );
  }

  @override
  void initState() {

    getSharedPrefs();

  }
  getSharedPrefs()async{
    await Get.find<AuthController>().getAdInterests();
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? userId=prefs.getString("pingUserId");

    if(userId==null){
      Future.delayed(Duration(seconds: 4),(){
        Get.offAll(WelcomeScreen(),transition: Transition.leftToRight);
      });
    }else{
      Future.delayed(Duration(seconds: 4),(){
        AuthService().getUserData(userId);
        Get.offAll(Dashboard(),transition: Transition.leftToRight);
      });
    }
  }
}
