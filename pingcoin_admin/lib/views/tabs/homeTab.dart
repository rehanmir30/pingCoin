import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/constants/colors.dart';
import 'package:pingcoin_admin/controllers/coinController.dart';
import 'package:pingcoin_admin/controllers/userController.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: GetBuilder<UserController>(builder: (userController) {
        return GetBuilder<CoinController>(
          builder: (coinController) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(title: "Dashboard"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: rBg
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff955C00),
                                    shape: BoxShape.circle
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset("assets/svgs/coins.svg"),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("15,230",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 30),),
                                  TweenAnimationBuilder<int>(
                                    tween: IntTween(begin: 0, end: 130),
                                    duration: Duration(seconds: 2),
                                    builder: (context, value, child) {
                                      return Text(
                                        _formatNumber(value),
                                        style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 30),
                                      );
                                    },
                                  ),
                                  Text("Total coins Tested",style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                                ],
                              ).marginOnly(left: 12)
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: rBg
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff883232),
                                    shape: BoxShape.circle
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset("assets/svgs/coins.svg"),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("${coinController.allCoins.length??0}",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 30),),
                                  TweenAnimationBuilder<int>(
                                    tween: IntTween(begin: 0, end: coinController.allCoins.length),
                                    duration: Duration(seconds: 1),
                                    builder: (context, value, child) {
                                      return Text(
                                        _formatNumber(value),
                                        style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 30),
                                      );
                                    },
                                  ),
                                  Text("Total coins",style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                                ],
                              ).marginOnly(left: 12)
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: rBg
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff008A3F),
                                    shape: BoxShape.circle
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset("assets/svgs/users.svg"),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("3,450",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 30),),
                                  TweenAnimationBuilder<int>(
                                    tween: IntTween(begin: 0, end: userController.allUsers.length),
                                    duration: Duration(seconds: 1),
                                    builder: (context, value, child) {
                                      return Text(
                                        _formatNumber(value),
                                        style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 30),
                                      );
                                    },
                                  ),
                                  Text("Total Users",style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                                ],
                              ).marginOnly(left: 12)
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: rBg
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff620B0B),
                                    shape: BoxShape.circle
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset("assets/svgs/users.svg"),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("0",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 30),),
                                  TweenAnimationBuilder<int>(
                                    tween: IntTween(begin: 0, end: userController.categorizedUsers["Blocked"]?.length??0),
                                    duration: Duration(seconds: 1),
                                    builder: (context, value, child) {
                                      return Text(
                                        _formatNumber(value),
                                        style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 30),
                                      );
                                    },
                                  ),
                                  Text("Blocked Users",style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                                ],
                              ).marginOnly(left: 12)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).marginOnly(top: 12),

                  SizedBox(
                    height: 20,
                  ),
                  Text("Recently Tested Coins",style: TextStyle(color: rWhite,fontWeight: FontWeight.w600,fontSize: 20),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: rBg
                    ),
                    child: Column(
                      children: [
                        TableHeader(),
                        ListView.builder(
                            itemCount: 15,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return TestTile();
                            }),
                      ],
                    ),
                  )
                ],
              ).marginSymmetric(horizontal: 20,vertical: 10),
            );
          },
        );
      },),
    );
  }
}

Widget TableHeader() {
  return Container(
    decoration: BoxDecoration(
      color: rWhite.withOpacity(0.05),
    ),
    child: Row(
      children: [
        Expanded(
            child: Text(
              "ID",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            child: Text(
              "Image",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
          flex: 2,
            child: Text(
              "Name",
              style: TextStyle(color: rHint, fontWeight: FontWeight.bold),
            )),
        Expanded(
            child: Text(
              "Category",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            child: Text(
              "Weight",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            child: Text(
              "High Level",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            child: Text(
              "Country",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            child: Text(
              "Status",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            child: Text(
              "Action",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
      ],
    ).marginSymmetric(horizontal: 12,vertical: 10),
  );
}

class TestTile extends StatefulWidget {
  const TestTile({super.key});

  @override
  State<TestTile> createState() => _TestTileState();
}

class _TestTileState extends State<TestTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
              "TC001",
              style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
            )),
        Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/coinFrontWeb.png",width: 40,height: 40,),
                Image.asset("assets/images/coinBackWeb.png",width: 40,height: 40,),
              ],
            )),
        Expanded(
          flex: 2,
            child: Text(
              "American Silver Eagle",
              style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
            )),
        Expanded(
            child: Text(
              "Gold",
              style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
            )),
        Expanded(
            child: Text(
              "31.1g",
              style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
            )),
        Expanded(
            child: Text(
              "99.5%",
              style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
            )),
        Expanded(
            child: Text(
              "🇺🇸 USA",
              style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
            )),
        Expanded(
            child: Text(
              "Real",
              style: TextStyle(color: rGreen, fontWeight: FontWeight.normal),
            )),
        Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset("assets/svgs/eye.svg"))),
      ],
    ).marginSymmetric(horizontal: 12,vertical: 10);
  }
}

