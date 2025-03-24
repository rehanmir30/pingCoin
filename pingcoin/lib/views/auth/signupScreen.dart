import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/animations/fadeInAnimationTTB.dart';
import 'package:pingcoin/controllers/authController.dart';
import 'package:pingcoin/models/adInterestModel.dart';
import 'package:pingcoin/widgets/customButton.dart';
import 'package:pingcoin/widgets/customSnackbar.dart';

import '../../animations/fadeInAnimationBTT.dart';
import '../../constants/colors.dart';
import '../../widgets/customLoading.dart';
import '../dashboard/dashboard.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool termsCheck = false;
  bool hideText=true;

  final Set<AdInterestModel> selectedInterests = {};

  var formKey=GlobalKey<FormState>();

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void toggleSelection(AdInterestModel interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  getAdInterests()async{
    await Get.find<AuthController>().getAdInterests();
  }

  @override
  void initState() {
    super.initState();
    getAdInterests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      appBar: AppBar(
        backgroundColor: rBg,
        elevation: 0,
        iconTheme: IconThemeData(
          color: rWhite,
        ),
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: SvgPicture.asset("assets/svgs/logo.svg")),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Create New Account",
                              style: TextStyle(color: rWhite, fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //name
                          Text(
                            "Full Name",
                            style: TextStyle(color: rHint, fontSize: 16),
                          ),
                          FadeInAnimationTTB(
                            delay: 1,
                            child: TextFormField(
                              cursorColor: rGreen,
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              validator: (name){
                                if(name==null||name.isEmpty){
                                  return "Full name is required";
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: 'Enter your full name',
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
                                  prefixIcon: SvgPicture.asset(
                                    "assets/svgs/profile.svg",
                                    color: rWhite,
                                  ).marginAll(9)),
                              style: TextStyle(
                                color: Colors.white, // Text color
                              ),
                            ).marginOnly(top: 8),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //email
                          Text(
                            "Email",
                            style: TextStyle(color: rHint, fontSize: 16),
                          ),
                          FadeInAnimationTTB(
                            delay: 1,
                            child: TextFormField(
                              cursorColor: rGreen,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
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
                                    vertical: 12.0,
                                    horizontal: 16.0,
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    "assets/svgs/mail.svg",
                                    color: rWhite,
                                  ).marginAll(9)),
                              style: TextStyle(
                                color: Colors.white, // Text color
                              ),
                            ).marginOnly(top: 8),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          //password
                          Text(
                            "Password",
                            style: TextStyle(color: rHint, fontSize: 16),
                          ),
                          FadeInAnimationTTB(
                            delay: 1,
                            child: TextFormField(
                              cursorColor: rGreen,
                              obscureText: hideText,
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              validator: (password){
                                if(password==null||password.isEmpty){
                                  return "Password is required";
                                }else if(password.length<6){
                                  return "Password should be greater than 5 characters";
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: 'Enter your password',
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
                                  suffixIcon: InkWell(
                                      onTap: (){
                                        setState(() {
                                          hideText= !hideText;
                                        });
                                      },
                                      child: hideText?SvgPicture.asset("assets/svgs/password_off.svg").marginAll(9):SvgPicture.asset("assets/svgs/showPass.svg").marginAll(9)),
                                  prefixIcon: SvgPicture.asset(
                                    "assets/svgs/password.svg",
                                    color: rWhite,
                                  ).marginAll(9)),
                              style: TextStyle(
                                color: Colors.white, // Text color
                              ),
                            ).marginOnly(top: 8),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Pick your interest to setup your feeds",style: TextStyle(color: rHint),),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: authController.adInterestList.map((item) {
                        final isSelected = selectedInterests.contains(item);
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: ()=> toggleSelection(item),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 12),
                            decoration: BoxDecoration(
                                color: isSelected?Color(0xff1D5A17):rGrey,
                                borderRadius: BorderRadius.circular(40.0),
                                border: Border.all(color: isSelected?rGreen:Colors.transparent)
                            ),
                            child: Text(
                              item.name,
                              style: TextStyle(fontSize: 16.0,color: rWhite),
                            ),
                          ),
                        );
                      }).toList(),
                    ).marginOnly(top: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                            value: termsCheck,
                            activeColor: rGreen,
                            onChanged: (value) {
                              setState(() {
                                termsCheck = value!;
                              });
                            }),
                        Row(
                          children: [
                            Text("I agree with the",style: TextStyle(color: rWhite, fontSize: 16),),
                            Text(" Legal Terms",style: TextStyle(color: rGreen, fontSize: 16),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    CustomButton(label: "Sign Up",func: signupBtn,),
                    SizedBox(height: 20,),
                    FadeInAnimationBTT(
                      delay:1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ",style: TextStyle(color: rWhite,fontSize: 16),),
                          InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child: Text("Log In",style: TextStyle(color: rGreen,fontSize: 16),)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ).marginSymmetric(horizontal: 12),
              ),
            ),
            Visibility(
                visible: authController.isLoading,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: rWhite.withOpacity(0.2),
                    child: CustomLoading()))
          ],
        );
      },),
    );
  }
  signupBtn(){

    if(formKey.currentState!.validate()){
      if(selectedInterests.isEmpty){
        CustomSnackbar.show("Error", "Select atleast 1 interest",isSuccess: false);
        return;
      }else if(!termsCheck){
        CustomSnackbar.show("Error", "Please accept terms check",isSuccess: false);
        return;
      }else{
        //Signup here
        Get.find<AuthController>().signup(nameController.text,emailController.text,passwordController.text,selectedInterests);
      }
    }else{
      return;
    }

  }

  Widget interestTile(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 12),
      decoration: BoxDecoration(
        color: rGrey,
        borderRadius: BorderRadius.circular(40.0),
        // border: Border.all(color: Colors.blue.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0,color: rWhite),
      ),
    );
  }
}
