
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/colors.dart';
import 'package:pingcoin/widgets/customButton.dart';

import '../../animations/fadeInAnimationTTB.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      appBar: AppBar(
        backgroundColor: rBg,
        title: Text("Back",style: TextStyle(color: rWhite,fontSize: 16),),
        iconTheme: IconThemeData(
          color: rWhite,
        ),
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height*0.1,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/svgs/logo.svg")),
          SizedBox(height: 50,),

          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: rWhite, fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 20,),

                Text(
                  "Don’t worry! It happens. Please enter the address associated with your account.", textAlign: TextAlign.center,
                  style: TextStyle(color: rHint, fontSize: 16),
                ),

                SizedBox(height: 20,),

                FadeInAnimationTTB(
                  delay: 1,
                  child: TextFormField(
                    cursorColor: rGreen,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
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
                          vertical: 12.0, horizontal: 16.0,
                        ),
                        prefixIcon: SvgPicture.asset("assets/svgs/mail.svg",color: rWhite,).marginAll(9)
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ).marginOnly(top: 8),
                ),

                SizedBox(height: 20,),

                CustomButton(label: "Send", func: sendPasswordResetMail).marginOnly(top: 12)
              ],
            ),
          )
        ],).marginSymmetric(horizontal: 12),
      ),
    );
  }
  sendPasswordResetMail(){
    showDialog(
      context: context,
      builder: (context) {
        return ElasticIn(
          child: AlertDialog(
            backgroundColor: rBg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text("Email Sent", style: TextStyle(fontWeight: FontWeight.bold,color: rWhite)),
            content: Text("An email has been sent to your provided mail. Check spam if not found in inbox.",style: TextStyle(fontSize: 16,color: rWhite),),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: rGreen),
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        rGreen.withOpacity(0.22),
                        rGreen.withOpacity(0.02),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text("OK", style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        );
      },
    );
  }
}
