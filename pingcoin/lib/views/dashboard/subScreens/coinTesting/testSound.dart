import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pingcoin/constants/colors.dart';
import 'package:pingcoin/widgets/ad.dart';
import 'package:pingcoin/widgets/customButton.dart';
import 'package:pingcoin/widgets/infoButton.dart';

class TestSound extends StatefulWidget {
  const TestSound({super.key});

  @override
  State<TestSound> createState() => _TestSoundState();
}

class _TestSoundState extends State<TestSound> {

  bool isTesting=false;
  bool isTested=false;

  final List<double> soundData = [0.0, 0.5, 1.0, 0.7, 0.3, 0.8, 0.2, 0.6, 0.9, 0.4];

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
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: rWhite,
                          )),
                      SizedBox(
                        width: 8,
                      ),
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
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: rWhite,
                      ),
                      SizedBox(width: 15,),
                      InfoButton(),
                      SizedBox(width: 15,),
                      Icon(
                        Icons.share_outlined,
                        color: rWhite,
                      ),
                    ],
                  )
                ],
              ).marginSymmetric(horizontal: 12),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/coinFront.png",width: 80,height: 80,),
                  Column(
                    children: [
                      Text("🇺🇸",style: TextStyle(fontSize: 20),),
                      Text("American Gold Eagle",style: TextStyle(color: rWhite,fontSize: 18,fontWeight: FontWeight.w600),),

                    ],
                  ),
                  Image.asset("assets/images/coinBack.png",width: 80,height: 80),
                ],
              ).marginOnly(top: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: isTested==false?rYellow:rBg),
                child: isTested==false?
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("TEST SOUND",style: TextStyle(color: rBlack,fontSize: 24, fontWeight: FontWeight.bold),),
                            Text("0 out 3 Match Frequencies",style: TextStyle(color: rBlack,fontSize: 16, fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffB79300)
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              border: Border.all(color: rWhite,width: 5)
                            ),
                          ),
                        )
                      ],
                    ).marginSymmetric(horizontal: 15).marginOnly(top: 12),
                    Container(
                      padding: EdgeInsets.all(16),
                      height: 130,
                      color: rBg,
                    ).marginSymmetric(horizontal: 12,vertical: 12)
                  ],
                ):
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.495,
                          height: MediaQuery.of(context).size.height*0.33,
                          color: rGreen,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("GOOD SOUND",style: TextStyle(color: rBlack,fontSize: 24,fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text("3 out 3 Match Frequencies",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff368C2D)
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset("assets/svgs/tick.svg"),
                                  )
                                ],
                              )
                            ],
                          ).marginSymmetric(horizontal: 12),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.495,
                          height: MediaQuery.of(context).size.height*0.33,
                          color: Color(0xffFF5D5D),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("BAD WEIGHT",style: TextStyle(color: rBlack,fontSize: 24,fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text("1.10 oz t \n36.34 grams",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffBE4040)
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset("assets/svgs/cancel.svg"),
                                  )
                                ],
                              )
                            ],
                          ).marginSymmetric(horizontal: 12),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                       width: MediaQuery.of(context).size.width*0.95,
                        padding: EdgeInsets.all(16),
                        height: 130,
                        color: rBg,
                      ).marginSymmetric(horizontal: 12,vertical: 12),
                    )
                  ],
                ),
              ).marginOnly(top: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("⚠ Use at your own risk",style: TextStyle(color: rHint,fontSize: 14),),
                  CustomButton(label: isTesting==false?isTested==false?"Start Testing":"Test Again":"Testing...",fail: isTesting==false?isTested==false?"Not fail":"fail":"not fail", func: startTesting,width: MediaQuery.of(context).size.width*0.4,)
                ],
              ).marginSymmetric(horizontal: 12).marginOnly(top: 14),

              Container(
                height: MediaQuery.of(context).size.height*0.20,
                alignment: Alignment.center,
                child: Visibility(
                    visible: isTesting,
                    child: Text("Listening...",style:TextStyle(color: rWhite))),
              ),
              AdWidget().marginSymmetric(horizontal: 30).marginOnly(bottom: 20)
            ],
          ),
        ),
      ),
    );
  }
  startTesting(){
    setState(() {
      isTesting=true;
    });
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
        isTesting=false;
        isTested=true;
      });
    });
  }
}
