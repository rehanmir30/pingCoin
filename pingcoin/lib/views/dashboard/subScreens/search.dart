import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/controllers/coinController.dart';
import 'package:pingcoin/widgets/infoButton.dart';

import '../../../animations/fadeInAnimationTTB.dart';
import '../../../constants/colors.dart';
import '../../../models/coinModel.dart';
import 'coinDetailScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SafeArea(
        child: GetBuilder<CoinController>(
          builder: (coinController) {
            return Column(
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
                FadeInAnimationTTB(
                  delay: 1,
                  child: TextFormField(
                    cursorColor: rGreen,
                    keyboardType: TextInputType.text,
                    controller: coinController.searchController,
                    onChanged: (value){
                      coinController.searchFilter();
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Search',
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
                          "assets/svgs/search2.svg",
                        ).marginAll(9)),
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ).marginOnly(top: 8),
                ).marginSymmetric(horizontal: 12).marginOnly(top: 12),
                coinController.searchController.text.isEmpty
                    ? Text(
                        "Enter a coin name or category to search",
                        style: TextStyle(color: rHint),
                      ).marginOnly(top: MediaQuery.of(context).size.height * 0.3)
                    : ListView.builder(
                        itemCount: coinController.filteredCoins.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return CoinTile(categorizedCoin: coinController.filteredCoins[index]);
                        })
              ],
            );
          },
        ),
      ),
    );
  }
}

class CoinTile extends StatefulWidget {
  CoinModel categorizedCoin;

  CoinTile({super.key, required this.categorizedCoin});

  @override
  State<CoinTile> createState() => _CoinTileState();
}

class _CoinTileState extends State<CoinTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            CoinDetailScreen(
              coinModel: widget.categorizedCoin,
            ),
            transition: Transition.fade);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: rWhite.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              rWhite.withOpacity(0.15),
              rWhite.withOpacity(0.02),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Row(
          children: [
            Image.network("${widget.categorizedCoin.coinFront}", width: 60, height: 60, fit: BoxFit.fill),
            Expanded(
                child: Column(
              children: [
                Text("${widget.categorizedCoin.country.substring(0, 5)}"),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.categorizedCoin.name}",
                  style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/svgs/diameter.svg"),
                            Text(
                              "${widget.categorizedCoin.weight}",
                              style: TextStyle(fontSize: 12, color: rWhite, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Diameter (${widget.categorizedCoin.weight})",
                          style: TextStyle(color: rHint, fontSize: 7),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/svgs/thickness.svg"),
                            Text(
                              "${widget.categorizedCoin.thickness}",
                              style: TextStyle(fontSize: 12, color: rWhite, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Thickness (${widget.categorizedCoin.thicknessUnit})",
                          style: TextStyle(color: rHint, fontSize: 7),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/svgs/weight.svg"),
                            Text(
                              "${widget.categorizedCoin.weight}",
                              style: TextStyle(fontSize: 12, color: rWhite, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Weight (${widget.categorizedCoin.weightUnit})",
                          style: TextStyle(color: rHint, fontSize: 7),
                        )
                      ],
                    )
                  ],
                )
              ],
            )),
            Image.network(
              "${widget.categorizedCoin.coinBack}",
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
          ],
        ).marginSymmetric(horizontal: 12, vertical: 8),
      ).marginSymmetric(vertical: 8, horizontal: 12),
    );
  }
}
