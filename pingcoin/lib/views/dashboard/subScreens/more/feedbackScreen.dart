import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/colors.dart';
import 'package:pingcoin/controllers/contentController.dart';
import 'package:pingcoin/widgets/customButton.dart';

import '../../../../animations/fadeInAnimationTTB.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SafeArea(
        child: Form(
          key: formKey,
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
              Text("Feedback/Support",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "font2"),).marginSymmetric(horizontal: 12).marginOnly(top: 20),

              SizedBox(
                height: 30,
              ),

              //name
              FadeInAnimationTTB(
                delay: 1,
                child: TextFormField(
                  cursorColor: rGreen,
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  validator: (name){
                    if(name==null||name.isEmpty){
                      return "Name is required";
                    }else{
                      return null;
                    }
                  },
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
                  controller: emailController,
                  validator: (email){
                    if(email==null||email.isEmpty){
                      return "Email is required";
                    }else{
                      return null;
                    }
                  },
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
                  keyboardType: TextInputType.text,
                  controller:messageController,
                  validator: (message){
                    if(message==null||message.isEmpty){
                      return "Message is required";
                    }else{
                      return null;
                    }
                  },
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
      ),

    );
  }
  submitBtn(){
    if(formKey.currentState!.validate()){
      Get.find<ContentController>().submitSupport(nameController.text,emailController.text,messageController.text);
    }else{
      return;
    }
  }
}
