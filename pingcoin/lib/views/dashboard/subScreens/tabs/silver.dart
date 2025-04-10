import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pingcoin/controllers/coinController.dart';

import '../../../../constants/colors.dart';
import '../../../../models/coinModel.dart';
import '../coinDetailScreen.dart';

class SilverTab extends StatefulWidget {
  const SilverTab({super.key});

  @override
  State<SilverTab> createState() => _SilverTabState();
}

class _SilverTabState extends State<SilverTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: SingleChildScrollView(
        child: GetBuilder<CoinController>(
          builder: (coinController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Our Collections",style: TextStyle(color: rWhite,fontSize: 22,fontWeight: FontWeight.normal,fontFamily: "font2"),).marginSymmetric(horizontal: 12).marginOnly(top: 12),
                coinController.categorizedCoins.containsKey("Silver")?ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: coinController.categorizedCoins.containsKey("Silver")
                        ? coinController.categorizedCoins["Silver"]!.length
                        : 0,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return SilverCollectionTile(categorizedCoin: coinController.categorizedCoins["Silver"]![index],);
                    }):Center(child: Text("No coin, of Silver category found",style: TextStyle(color: rWhite),).marginOnly(top: MediaQuery.of(context).size.height*0.3),),
                SizedBox(
                  height: 50,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
class SilverCollectionTile extends StatefulWidget {
  CoinModel categorizedCoin;
  SilverCollectionTile({super.key,required this.categorizedCoin});

  @override
  State<SilverCollectionTile> createState() => _SilverCollectionTileState();
}

class _SilverCollectionTileState extends State<SilverCollectionTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(CoinDetailScreen(coinModel: widget.categorizedCoin,),transition: Transition.fade);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: rWhite.withOpacity(0.2),width: 1),
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              rWhite.withOpacity(0.15),
              rWhite.withOpacity(0.02),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Row(
          children: [
            Image.network("${widget.categorizedCoin.coinFront}",width: 60,height: 60,fit: BoxFit.fill),
            Expanded(
                child: Column(
                  children: [
                    Text("${widget.categorizedCoin.country.substring(0,5)}"),
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
                                  "${widget.categorizedCoin.diameter}",
                                  style: TextStyle(fontSize: 12, color: rWhite,fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Diameter (${widget.categorizedCoin.diameterUnit})",
                              style: TextStyle(color: Colors.white70,fontSize: 10),
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
                                  style: TextStyle(fontSize: 12, color: rWhite,fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Thickness (${widget.categorizedCoin.thicknessUnit})",
                              style: TextStyle(color: Colors.white70,fontSize: 10),
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
                                  style: TextStyle(fontSize: 12, color: rWhite,fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Weight (${widget.categorizedCoin.weightUnit})",
                              style: TextStyle(color: Colors.white70,fontSize: 10),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )),
            Image.network("${widget.categorizedCoin.coinBack}",width: 60,height: 60,fit: BoxFit.fill,),
          ],
        ).marginSymmetric(horizontal: 12, vertical: 8),
      ).marginSymmetric(vertical: 8, horizontal: 12),
    );
  }
}