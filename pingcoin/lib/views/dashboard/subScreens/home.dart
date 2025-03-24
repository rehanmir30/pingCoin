import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/colors.dart';
import 'package:pingcoin/views/dashboard/subScreens/tabs/favorite.dart';
import 'package:pingcoin/views/dashboard/subScreens/tabs/gold.dart';
import 'package:pingcoin/views/dashboard/subScreens/tabs/silver.dart';
import 'package:pingcoin/widgets/infoButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
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
                    InfoButton()
                  ],
                ).marginSymmetric(horizontal: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: rHint,
                      width: 1.0,
                    ),
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: rGreen,
                    unselectedLabelColor: rHint,
                    indicator: BoxDecoration(
                      color: rGreen,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.all(3),
                    labelColor: rWhite,
                    tabs: [
                      Tab(text: 'Gold'),
                      Tab(text: 'Silver'),
                      Tab(text: 'Favorite'),
                    ],
                  ),
                ).marginOnly(top: 12).marginSymmetric(horizontal: 12),
                Container(
                  height: MediaQuery.of(context).size.height * 0.78,
                  child: TabBarView(
                    children: [
                      GoldTab(),
                      SilverTab(),
                      FavoriteTab(),
                    ],
                  ),
                ).marginOnly(top: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
