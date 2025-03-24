import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/constants/colors.dart';
import 'package:pingcoin_admin/controllers/adController.dart';
import 'package:pingcoin_admin/controllers/authController.dart';
import 'package:pingcoin_admin/controllers/businessController.dart';
import 'package:pingcoin_admin/controllers/coinController.dart';
import 'package:pingcoin_admin/controllers/faqController.dart';
import 'package:pingcoin_admin/controllers/supportController.dart';
import 'package:pingcoin_admin/controllers/userController.dart';
import 'package:pingcoin_admin/views/auth/login.dart';
import 'package:pingcoin_admin/views/tabs/adTab.dart';
import 'package:pingcoin_admin/views/tabs/businessDevelopmentTab.dart';
import 'package:pingcoin_admin/views/tabs/coinsTab.dart';
import 'package:pingcoin_admin/views/tabs/homeTab.dart';
import 'package:pingcoin_admin/views/tabs/legalTab.dart';
import 'package:pingcoin_admin/views/tabs/support.dart';
import 'package:pingcoin_admin/views/tabs/usersTab.dart';
import 'package:pingcoin_admin/views/tabs/viewProfile.dart';
import 'dart:html' as html;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;

  Widget selectedView = HomeTab();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData()async{
    await Get.find<AuthController>().getAdminDetails();
    Get.find<CoinController>().getCoinCategories();
    Get.find<CoinController>().getCoins();

    Get.find<AdController>().getAllAds();
    Get.find<AdController>().getAdInterests();

    Get.find<UserController>().getAllUser();
    Get.find<BusinessController>().getAllBusinesses();

    Get.find<AuthController>().getContent();

    Get.find<SupportController>().getAllSupports();

    Get.find<FAQController>().getAllFaqs();
  }

  switchView(Widget screen){
    setState(() {
      selectedView=screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.16,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/logo.svg",
                              width: 40,
                              height: 40,
                            ),
                            Text(
                              "PING",
                              style: TextStyle(
                                color: rGreen,
                                fontSize: 26,
                                fontFamily: "font2",
                              ),
                            ).marginOnly(left: 8),
                            Text(
                              "COIN",
                              style: TextStyle(
                                color: rWhite,
                                fontSize: 26,
                                fontFamily: "font2",
                              ),
                            ),
                          ],
                        ),
                      ).marginOnly(top: 12),
                      ListTile(
                        tileColor: _selectedTab == 0 ? rGreen : rBg,
                        leading: SvgPicture.asset(
                          "assets/svgs/dashboard.svg",
                          color: _selectedTab == 0 ? rWhite : rHint,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dashboard',
                              style: TextStyle(
                                color: _selectedTab == 0 ? rWhite : rHint,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: _selectedTab == 0 ? rWhite : rHint,
                              size: 15,
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _selectedTab = 0;
                            selectedView = HomeTab();
                          });
                        },
                      ).marginOnly(top: 20),
                      ListTile(
                        tileColor: _selectedTab == 1 ? rGreen : rBg,
                        leading: SvgPicture.asset(
                          "assets/svgs/coins.svg",
                          color: _selectedTab == 1 ? rWhite : rHint,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Coins',
                              style: TextStyle(
                                color: _selectedTab == 1 ? rWhite : rHint,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: _selectedTab == 1 ? rWhite : rHint,
                              size: 15,
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _selectedTab = 1;
                            selectedView = CoinsTab(callBack: switchView);
                          });
                        },
                      ),
                      ListTile(
                        tileColor: _selectedTab == 2 ? rGreen : rBg,
                        leading: SvgPicture.asset(
                          "assets/svgs/users.svg",
                          color: _selectedTab == 2 ? rWhite : rHint,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Users',
                              style: TextStyle(
                                color: _selectedTab == 2 ? rWhite : rHint,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: _selectedTab == 2 ? rWhite : rHint,
                              size: 15,
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _selectedTab = 2;
                            selectedView = UsersTab(callBack: switchView);
                          });
                        },
                      ),
                      ListTile(
                        tileColor: _selectedTab == 3 ? rGreen : rBg,
                        leading: SvgPicture.asset(
                          "assets/svgs/ad.svg",
                          color: _selectedTab == 3 ? rWhite : rHint,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ad',
                              style: TextStyle(
                                color: _selectedTab == 3 ? rWhite : rHint,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: _selectedTab == 3 ? rWhite : rHint,
                              size: 15,
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _selectedTab = 3;
                            selectedView = AdTab(callBack: switchView);
                          });
                        },
                      ),
                      ListTile(
                        tileColor: _selectedTab == 4 ? rGreen : rBg,
                        leading: SvgPicture.asset(
                          "assets/svgs/briefcase.svg",
                          color: _selectedTab == 4 ? rWhite : rHint,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Business Dev',
                              style: TextStyle(
                                color: _selectedTab == 4 ? rWhite : rHint,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: _selectedTab == 4 ? rWhite : rHint,
                              size: 15,
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _selectedTab = 4;
                            selectedView = BusinessDevelopmentTab(callBack: switchView);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                //profile section
                Column(
                  children: [
                    ListTile(
                      tileColor: _selectedTab == 5 ? rGreen : rBg,
                      leading: SvgPicture.asset(
                        "assets/svgs/user.svg",
                        color: _selectedTab == 5 ? rWhite : rHint,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              color: _selectedTab == 5 ? rWhite : rHint,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: _selectedTab == 5 ? rWhite : rHint,
                            size: 15,
                          )
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _selectedTab = 5;
                          selectedView = ViewProfile();
                        });
                      },
                    ),
                    ListTile(
                      tileColor: _selectedTab == 6 ? rGreen : rBg,
                      leading: SvgPicture.asset(
                        "assets/svgs/support.svg",
                        color: _selectedTab == 6 ? rWhite : rHint,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Support',
                            style: TextStyle(
                              color: _selectedTab == 6 ? rWhite : rHint,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: _selectedTab == 6 ? rWhite : rHint,
                            size: 15,
                          )
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _selectedTab = 6;
                          selectedView = SupportView();
                        });
                      },
                    ),
                    ListTile(
                      tileColor: _selectedTab == 7 ? rGreen : rBg,
                      leading: SvgPicture.asset(
                        "assets/svgs/legal.svg",
                        color: _selectedTab == 7 ? rWhite : rHint,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Legal',
                            style: TextStyle(
                              color: _selectedTab == 7 ? rWhite : rHint,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: _selectedTab == 7 ? rWhite : rHint,
                            size: 15,
                          )
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _selectedTab = 7;
                          selectedView = LegalTab();
                        });
                      },
                    ),
                    ListTile(
                      tileColor: _selectedTab == 8 ? rGreen : rBg,
                      leading: SvgPicture.asset(
                        "assets/svgs/logout.svg",
                        color: _selectedTab == 8 ? rWhite : rHint,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: _selectedTab == 8 ? rWhite : rHint,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: _selectedTab == 8 ? rWhite : rHint,
                            size: 15,
                          )
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _selectedTab = 8;
                          showLogOutPopup();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
          Expanded(child: selectedView),
        ],
      ),
    );
  }
  showLogOutPopup(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ElasticIn(
          child: AlertDialog(
            backgroundColor: rBg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(child: Text("Are you sure?", style: TextStyle(fontWeight: FontWeight.bold, color: rWhite))),
            content: Text(
              "You want to Logout",
              style: TextStyle(fontSize: 16, color: rWhite),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
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
                      child: Text("Cancel", style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      html.window.localStorage.remove('adminId');
                      Get.off(LoginScreen(),transition: Transition.fade);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: rRed),
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            rRed,
                            rRed,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text("Logout", style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        );
      },
    );
  }
}

// Custom Widget for Section Headers
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}