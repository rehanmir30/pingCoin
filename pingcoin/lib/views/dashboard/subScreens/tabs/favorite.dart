import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../../../constants/colors.dart';
import '../coinDetailScreen.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {

  int? swipedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Our Collections",style: TextStyle(color: rWhite,fontSize: 22,fontWeight: FontWeight.normal,fontFamily: "font2"),).marginSymmetric(horizontal: 12).marginOnly(top: 12),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return FavoriteCollectionTile(

                  );
                }),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteCollectionTile extends StatefulWidget {


  @override
  _FavoriteCollectionTileState createState() => _FavoriteCollectionTileState();
}

class _FavoriteCollectionTileState extends State<FavoriteCollectionTile> {
  bool isSwiped = false;

  void openSwipe(){
    setState(() {
      isSwiped=true;
    });
  }
  void closeSwipe(){
    setState(() {
      isSwiped=false;
    });
  }
  // void toggleSwipe() {
  //   setState(() {
  //     isSwiped = !isSwiped;
  //     print("Swiped: $isSwiped"); // Debugging
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < -200) {
          // Swiping left
          openSwipe();

        } else if (details.primaryVelocity! > 200) {
          // Swiping right
          closeSwipe();
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: isSwiped ? 70 : 0, // Show only when swiped
                height: 120,
                margin: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: Color(0xffFF7D7D),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: isSwiped
                    ? SvgPicture.asset("assets/svgs/delete.svg") // Show delete icon only when swiped
                    : SizedBox.shrink(),
              ).marginSymmetric(vertical: 8,horizontal: 12),
            ),
          ),

          // Foreground Tile (Main Content)
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(isSwiped ? -80 : 0, 0, 0), // Moves left but keeps full size
            child: InkWell(
              onTap: () {
                // Get.to(CoinDetailScreen(), transition: Transition.fade);
              },
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width, // Keeps full width
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset("assets/images/coin.png"),
                    Expanded(
                      child: Column(
                        children: [
                          Text("🇺🇸"),
                          SizedBox(height: 8),
                          Text(
                            "American Gold Eagle",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildInfoColumn("assets/svgs/diameter.svg", "37.00", "Diameter (mm)"),
                              _buildInfoColumn("assets/svgs/thickness.svg", "2.00", "Thickness (mm)"),
                              _buildInfoColumn("assets/svgs/weight.svg", "31.10", "Weight (g)"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Image.asset("assets/images/coinBack2.png"),
                  ],
                ).marginSymmetric(horizontal: 12, vertical: 8),
              ).marginSymmetric(vertical: 8, horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Icon + Text
  Widget _buildInfoColumn(String icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white60, fontSize: 7)),
      ],
    );
  }
}



