import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/constants/colors.dart';
import 'package:pingcoin_admin/controllers/authController.dart';
import 'package:pingcoin_admin/widgets/customLoading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isObsecure=true;
  TextEditingController emailController = TextEditingController(text: "admin@pingcoin.com");
  TextEditingController passwordController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: GetBuilder<AuthController>(builder: (authController) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/logo.svg",
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        "PING",
                        style: TextStyle(color: rGreen, fontSize: 26, fontFamily: "font2"),
                      ).marginOnly(left: 8),
                      Text(
                        "COIN",
                        style: TextStyle(color: rWhite, fontSize: 26, fontFamily: "font2"),
                      ),
                    ],
                  ),
                  Text(
                    "Log In",
                    style: TextStyle(color: rWhite, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: "fontBold"),
                  ).marginOnly(top: 20),
                  Text(
                    "Please Log In to your account",
                    style: TextStyle(color: rHint, fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            cursorColor: rGreen,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return "Email required";
                              } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
                                return "Enter a valid email address";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Email address',
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
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextFormField(
                            cursorColor: rGreen,
                            controller: passwordController,
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return "Password is required";
                              } else {
                                return null;
                              }
                            },
                            obscureText: isObsecure,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                splashColor: Colors.transparent,
                                  onTap: (){
                                    setState(() {
                                      isObsecure= !isObsecure;
                                    });
                                  },
                                  child: Icon(isObsecure?Icons.visibility_off_outlined:Icons.visibility_outlined)),
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
                          ),
                        ).marginOnly(top: 12),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot password",
                              style: TextStyle(color: rHint),
                            ),
                          ),
                        ).marginOnly(top: 20),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if(formKey.currentState!.validate()){
                              authController.login(emailController.text, passwordController.text);
                            }else{
                              return;
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 40,
                            decoration: BoxDecoration(color: rGreen, borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Text(
                              "Log In",
                              style: TextStyle(color: rWhite, fontSize: 16),
                            ),
                          ).marginOnly(top: 20),
                        ),
                      ],
                    ).marginOnly(top: 20),
                  ),
                ],
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
}
