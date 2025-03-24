import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/animations/fadeInAnimationBTT.dart';
import 'package:pingcoin/animations/fadeInAnimationTTB.dart';
import 'package:pingcoin/constants/colors.dart';
import 'package:pingcoin/controllers/authController.dart';
import 'package:pingcoin/views/auth/forgotPassword.dart';
import 'package:pingcoin/views/auth/signupScreen.dart';
import 'package:pingcoin/views/dashboard/dashboard.dart';
import 'package:pingcoin/widgets/customButton.dart';

import '../../widgets/customLoading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool hideText=true;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      appBar: AppBar(
        backgroundColor: rBg,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (authController) {
          return Stack(
            children: [
              Form(
                key:formKey,
                child: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: SvgPicture.asset("assets/svgs/logo.svg")),
                    SizedBox(height: 50,),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Login To Your Account",
                              style: TextStyle(color: rWhite, fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 20,),

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
                              validator: (email){
                                if(email==null||email.isEmpty){
                                  return "Email is required";
                                }else{
                                  return null;
                                }
                              },
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
                                color: Colors.white, // Text color
                              ),
                            ).marginOnly(top: 8),
                          ),

                          SizedBox(height: 20,),
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
                              validator: (password){
                                if(password==null||password.isEmpty){
                                  return "Password is required";
                                }else{
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
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
                                    vertical: 12.0, horizontal: 16.0,
                                  ),
                                  suffixIcon: InkWell(
                                      onTap: (){
                                        setState(() {
                                          hideText= !hideText;
                                        });
                                      },
                                      child: hideText?SvgPicture.asset("assets/svgs/password_off.svg").marginAll(9):SvgPicture.asset("assets/svgs/showPass.svg").marginAll(9)),
                                  prefixIcon: SvgPicture.asset("assets/svgs/password.svg",color: rWhite,).marginAll(9)
                              ),
                              style: TextStyle(
                                color: Colors.white, // Text color
                              ),
                            ).marginOnly(top: 8),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: (){
                            Get.to(ForgotPassword(),transition: Transition.leftToRightWithFade);
                          },
                          child: Text("Forgot password?",style: TextStyle(color: rWhite,fontSize: 16),)),
                    ),
                    SizedBox(height: 20,),
                    CustomButton(label: "Log In",func: loginBtn,),
                    Expanded(child: FadeInAnimationBTT(
                      delay: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ",style: TextStyle(color: rWhite,fontSize: 16),),
                          InkWell(
                              onTap: (){
                                Get.to(SignupScreen(),transition: Transition.downToUp);
                              },
                              child: Text("Sign Up",style: TextStyle(color: rGreen,fontSize: 16),)),
                        ],
                      ),
                    ))
                  ],
                ).marginSymmetric(horizontal: 12),
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
      ),
    );
  }
  loginBtn(){
    if(formKey.currentState!.validate()){
        Get.find<AuthController>().login(emailController.text,passwordController.text);
    }else{
      return;
    }
  }
}
