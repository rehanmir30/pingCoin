import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin/controllers/authController.dart';
import 'package:pingcoin/controllers/coinController.dart';
import 'package:pingcoin/models/coinModel.dart';
import 'package:pingcoin/views/dashboard/subScreens/coinTesting/testSound.dart';
import 'package:pingcoin/widgets/ad.dart';
import 'package:pingcoin/widgets/customButtonWithIcon.dart';

import '../../../constants/colors.dart';

class CoinDetailScreen extends StatefulWidget {
  CoinModel coinModel;
  CoinDetailScreen({super.key,required this.coinModel});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {

  String convertToTroyOz(String value, String unit) {
    double weight = double.tryParse(value) ?? 0; // Convert string to double safely
    double troyOz = 0;

    switch (unit.toLowerCase()) {
      case "mg":
        troyOz = weight * 0.0000321507; // mg → troy oz
        break;
      case "g":
        troyOz = weight * 0.0321507; // g → troy oz
        break;
      case "lb":
        troyOz = weight * 14.5833; // lb → troy oz
        break;
      case "oz":
        troyOz = weight * 0.911458; // oz → troy oz
        break;
      default:
        return "Invalid Unit"; // If unit is not recognized
    }

    return "${troyOz.toStringAsFixed(2)} TROY OZ - $value $unit";
  }

  Icon likeIcon=Icon(Icons.favorite_border,color: rWhite,);
  bool liked=false;

  @override
  void initState() {
    super.initState();

    if(Get.find<AuthController>().userModel!.favorites.contains(widget.coinModel.id)){
      setState(() {
        likeIcon=Icon(Icons.favorite,color: rRed,);
        liked=true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: GetBuilder<CoinController>(builder: (coinController) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    InkWell(
                        onTap: (){
                          if(liked){
                            coinController.removeFromFavorite(widget.coinModel);
                            setState(() {
                              liked=false;
                              likeIcon=Icon(Icons.favorite_border,color: rWhite,);
                            });
                          }else{
                            coinController.addToFavorite(widget.coinModel);
                            setState(() {
                              liked=true;
                              likeIcon=Icon(Icons.favorite,color: rRed,);
                            });
                          }
                        },
                        child: likeIcon)
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(widget.coinModel.coinFront,width: 130,height: 130,fit: BoxFit.fill),
                    Image.network(widget.coinModel.coinBack,width: 130,height: 130,fit: BoxFit.fill,),
                  ],
                ).marginOnly(top: 20),
                Align(
                    alignment: Alignment.center,
                    child: Text("${widget.coinModel.country.substring(0,5)} ${widget.coinModel.name}",style: TextStyle(fontSize: 24,color: rWhite,fontWeight: FontWeight.w600),)).marginOnly(top: 20),
                CustomButtonWithIcon(label: "Start Testing", func: startTesting).marginOnly(top: 30).marginSymmetric(horizontal: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/svgs/weight.svg"),
                        Text("Weight",style: TextStyle(color: rHint,fontSize: 16,),).marginOnly(left: 8)
                      ],
                    ),
                    Text(convertToTroyOz(widget.coinModel.weight, widget.coinModel.weightUnit),style: TextStyle(color: rWhite,fontSize: 16),)
                  ],
                ).marginOnly(top: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/svgs/diameter.svg"),
                        Text("Diameter",style: TextStyle(color: rHint,fontSize: 16,),).marginOnly(left: 8)
                      ],
                    ),
                    Text("${widget.coinModel.diameter} ${widget.coinModel.diameterUnit}",style: TextStyle(color: rWhite,fontSize: 16),)
                  ],
                ).marginOnly(top: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/svgs/thickness.svg"),
                        Text("Thickness",style: TextStyle(color: rHint,fontSize: 16,),).marginOnly(left: 8)
                      ],
                    ),
                    Text("${widget.coinModel.thickness} ${widget.coinModel.thicknessUnit}",style: TextStyle(color: rWhite,fontSize: 16),)
                  ],
                ).marginOnly(top: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/svgs/trade.svg",width: 20,height: 20,),
                        Text("High Level",style: TextStyle(color: rHint,fontSize: 16,),).marginOnly(left: 8)
                      ],
                    ),
                    Text("${widget.coinModel.highLevel}%",style: TextStyle(color: rWhite,fontSize: 16),)
                  ],
                ).marginOnly(top: 20),

                Text("Description",style: TextStyle(color: rWhite,fontSize: 16,fontWeight: FontWeight.w600),).marginOnly(top: 30),
                Text("${widget.coinModel.description}",
                  style: TextStyle(color: rHint,fontSize: 12),).marginOnly(top: 12),
                AdWidget().marginOnly(top: 20,bottom: 20),

              ],
            ).marginSymmetric(horizontal: 12),
          ),
        );
      },),
    );
  }
  startTesting(){
    Get.to(TestSound(widget.coinModel),transition: Transition.circularReveal);
  }
}
