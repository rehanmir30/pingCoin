import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/coinController.dart';
import 'package:pingcoin_admin/models/coinModel.dart';
import 'package:pingcoin_admin/views/tabs/coinInsights/createCoin.dart';
import 'package:pingcoin_admin/views/tabs/coinInsights/editCoin.dart';
import 'package:pingcoin_admin/widgets/customLoading.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

import '../../constants/colors.dart';
import '../../widgets/customDropDown.dart';

class CoinsTab extends StatefulWidget {
  var callBack;

  CoinsTab({super.key, required this.callBack});

  @override
  State<CoinsTab> createState() => _CoinsTabState();
}

class _CoinsTabState extends State<CoinsTab> {
  CoinModel? selectedCoin;
  final player = AudioPlayer();
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  bool isPlaying = false;

  @override
  void initState() {
    Get.find<CoinController>().searchFilter();

    // Listen for player state changes
    player.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        isPlaying = (state == PlayerState.playing);
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: GetBuilder<CoinController>(
        builder: (coinController) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(title: "Coins"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            height: 125,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: rBg),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xff989898),
                                        Color(0xffDFDFDF),
                                        Color(0xffD5D5D5),
                                        Color(0xff808080),
                                      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                                      shape: BoxShape.circle),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    "assets/svgs/coins.svg",
                                    color: rBlack,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TweenAnimationBuilder<int>(
                                      tween: IntTween(begin: 0, end: coinController.categorizedCoins["Silver"]?.length ?? 0),
                                      duration: Duration(seconds: 1),
                                      builder: (context, value, child) {
                                        return Text(
                                          _formatNumber(value),
                                          style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                        );
                                      },
                                    ),
                                    Text(
                                      "Total Silver Coins",
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.normal, fontSize: 16),
                                    ),
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
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: rBg),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xffB28738),
                                        Color(0xffFBB75A),
                                        Color(0xffDB9747),
                                        Color(0xffE5862A),
                                        Color(0xffF1AD76),
                                      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                                      shape: BoxShape.circle),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    "assets/svgs/coins.svg",
                                    color: rBlack,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TweenAnimationBuilder<int>(
                                      tween: IntTween(begin: 0, end: coinController.categorizedCoins["Gold"]?.length ?? 0),
                                      duration: Duration(seconds: 1),
                                      builder: (context, value, child) {
                                        return Text(
                                          _formatNumber(value),
                                          style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                        );
                                      },
                                    ),
                                    Text(
                                      "Total Gold Coins",
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.normal, fontSize: 16),
                                    ),
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
                          child: Container(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ).marginOnly(top: 12),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Coins",
                          style: TextStyle(color: rWhite, fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () => widget.callBack(CreateCoin(callBack: widget.callBack)),
                          child: Container(
                            decoration: BoxDecoration(color: rGreen, borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/svgs/add.svg"),
                                Text(
                                  "Add New Coin",
                                  style: TextStyle(color: rWhite),
                                ).marginOnly(left: 8)
                              ],
                            ).marginAll(12),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            cursorColor: rGreen,
                            controller: coinController.searchController,
                            onChanged: (value){
                              coinController.searchFilter();
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Search name',
                              hintStyle: TextStyle(
                                color: rHint,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
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
                          width: MediaQuery.of(context).size.width * 0.18,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: rBlack,
                            ),
                            child: DropdownButtonFormField<String>(
                              value: coinController.selectedCategoryFilter,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Category',
                                suffixIcon: Icon(Icons.keyboard_arrow_down, color: rHint),
                                // Custom dropdown arrow
                                hintStyle: TextStyle(
                                  color: rHint.withOpacity(0.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: rHint),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: rHint),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              ),
                              style: TextStyle(color: Colors.white),
                              icon: SizedBox.shrink(),
                              items: coinController.coinCategories.map((String validate) {
                                return DropdownMenuItem<String>(
                                  value: validate,
                                  child: Text(validate, style: TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                coinController.setFilterCategory(newValue!);
                                coinController.searchFilter();
                              },
                            ),
                          ),
                        ).marginOnly(left: 12),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.18,
                          child: SearchableDropdown(
                            countryCodes: coinController.countryCodes,
                            onChanged: (String? newValue) {
                              setState(() {
                                coinController.setFilterCountry(newValue) ;
                                coinController.searchFilter();
                              });
                            },
                            selectedCountry: coinController.selectedCountryFilter,
                          ),
                        ).marginOnly(left: 12),
                        Visibility(
                          visible: coinController.selectedCategoryFilter!=null||coinController.selectedCountryFilter!=null?true:false,
                          child: InkWell(
                              onTap: (){
                                coinController.searchController.text='';
                                coinController.setFilterCategory(null);
                                coinController.setFilterCountry(null);
                                coinController.searchFilter();
                              },
                              child: Icon(Icons.close,color: rRed,)).marginOnly(left: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: rBg),
                      child: Column(
                        children: [
                          TableHeader(),
                          ListView.builder(
                              itemCount: coinController.filteredCoins.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return CoinTile(coinController.filteredCoins[index], callBack, widget.callBack);
                              }),
                        ],
                      ),
                    )
                  ],
                ).marginSymmetric(horizontal: 20, vertical: 10),
              ),
              //coin detail section
              if (selectedCoin != null)
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: rBlack.withOpacity(0.8),
                    ),
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: double.infinity,
                      color: rBg,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Coin Details",
                                style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              InkWell(
                                onTap: () {
                                  if(isPlaying){
                                    player.stop();
                                  }
                                  setState(() {
                                    selectedCoin = null;
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: rWhite), shape: BoxShape.circle),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.close,
                                    color: rWhite,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ).marginSymmetric(horizontal: MediaQuery.of(context).size.width * 0.02).marginOnly(top: 12),
                          Expanded(
                              child: Center(
                                  child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      selectedCoin!.coinFront!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.network(
                                      selectedCoin!.coinBack!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ).marginOnly(left: 3),
                                  ],
                                ).marginOnly(top: 20),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${selectedCoin!.name}",
                                  style: TextStyle(color: rWhite, fontSize: 24, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Category",
                                      style: TextStyle(color: rHint, fontSize: 16),
                                    ),
                                    Text(
                                      "${selectedCoin!.category}",
                                      style: TextStyle(color: rWhite, fontSize: 16),
                                    ),
                                  ],
                                ),
                                Dash(
                                  direction: Axis.horizontal,
                                  length: MediaQuery.of(context).size.width * 0.26,
                                  dashLength: 5, // Length of dashes
                                  dashColor: Colors.grey,
                                ).marginOnly(top: 10),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Weight",
                                      style: TextStyle(color: rHint, fontSize: 16),
                                    ),
                                    Text(
                                        convertToTroyOz(selectedCoin!.weight, selectedCoin!.weightUnit),
                                        style: TextStyle(color: rWhite, fontSize: 16),
                                      ),
                                  ],
                                ),
                                Dash(
                                  direction: Axis.horizontal,
                                  length: MediaQuery.of(context).size.width * 0.26,
                                  dashLength: 5, // Length of dashes
                                  dashColor: Colors.grey,
                                ).marginOnly(top: 10),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "High Level",
                                      style: TextStyle(color: rHint, fontSize: 16),
                                    ),
                                    Text(
                                      "${selectedCoin!.highLevel} %",
                                      style: TextStyle(color: rWhite, fontSize: 16),
                                    ),
                                  ],
                                ),
                                Dash(
                                  direction: Axis.horizontal,
                                  length: MediaQuery.of(context).size.width * 0.26,
                                  dashLength: 5, // Length of dashes
                                  dashColor: Colors.grey,
                                ).marginOnly(top: 10),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Diameter",
                                      style: TextStyle(color: rHint, fontSize: 16),
                                    ),
                                    Text(
                                      "${selectedCoin!.diameter} ${selectedCoin!.diameterUnit}",
                                      style: TextStyle(color: rWhite, fontSize: 16),
                                    ),
                                  ],
                                ),
                                Dash(
                                  direction: Axis.horizontal,
                                  length: MediaQuery.of(context).size.width * 0.26,
                                  dashLength: 5, // Length of dashes
                                  dashColor: Colors.grey,
                                ).marginOnly(top: 10),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Thickness",
                                      style: TextStyle(color: rHint, fontSize: 16),
                                    ),
                                    Text(
                                      "${selectedCoin!.thickness} ${selectedCoin!.thicknessUnit}",
                                      style: TextStyle(color: rWhite, fontSize: 16),
                                    ),
                                  ],
                                ),
                                Dash(
                                  direction: Axis.horizontal,
                                  length: MediaQuery.of(context).size.width * 0.26,
                                  dashLength: 5, // Length of dashes
                                  dashColor: Colors.grey,
                                ).marginOnly(top: 10),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Audio Sound",
                                      style: TextStyle(color: rHint, fontSize: 16),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (isPlaying) {
                                          await player.pause();
                                        } else {
                                          await player.play(UrlSource(selectedCoin!.coinAudio!));
                                        }
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(color: rWhite),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                          color: rWhite,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Description",
                                      style: TextStyle(color: rHint, fontSize: 16),
                                    )),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                        height: 150,
                                        child: SingleChildScrollView(
                                            child: Text(
                                          "${selectedCoin!.description}",
                                          style: TextStyle(color: rWhite, fontSize: 16),
                                        )))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () => widget.callBack(EditCoin(coinModel: selectedCoin!, callBack: widget.callBack)),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: rGreen, borderRadius: BorderRadius.circular(8)),
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(color: rWhite),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.1,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: rRed, borderRadius: BorderRadius.circular(8)),
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: rWhite),
                                      ),
                                    )
                                  ],
                                ).marginOnly(top: 20, bottom: 20)
                              ],
                            ).marginSymmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
                          )))
                        ],
                      ),
                    )),
              Visibility(visible: coinController.isLoading, child: CustomLoading())
            ],
          );
        },
      ),
    );
  }

  callBack(CoinModel coin) {
    setState(() {
      selectedCoin = coin;
    });
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
          "Action",
          style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
        )),
      ],
    ).marginSymmetric(horizontal: 12, vertical: 10),
  );
}

class CoinTile extends StatefulWidget {
  final CoinModel coin;
  var callBack;
  var updateView;

  CoinTile(this.coin, this.callBack, this.updateView, {super.key});

  @override
  State<CoinTile> createState() => _CoinTileState();
}

class _CoinTileState extends State<CoinTile> {
  String getCountryCode(String countryData) {
    return countryData.split(" ")[1].toLowerCase();
  }

  String getFlagUrl(String countryCode) {
    return "https://flagcdn.com/w80/$countryCode.png";
  }

  @override
  Widget build(BuildContext context) {
    String countryCode = getCountryCode(widget.coin.country);
    String countryName = widget.coin.country.split("-").last.trim();

    return Row(
      children: [
        Expanded(
          child: Text(
            "${widget.coin.id.substring(0, 5)}...",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: widget.coin.coinFront!,
                width: 40,
                height: 40,
              ),
              CachedNetworkImage(
                imageUrl: widget.coin.coinBack!,
                width: 40,
                height: 40,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "${widget.coin.name}",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Text(
            "${widget.coin.category}",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Text(
            "${widget.coin.weight}${widget.coin.weightUnit}",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Text(
            "${widget.coin.highLevel}%",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Image.network(getFlagUrl(countryCode), width: 24, height: 16),
              SizedBox(width: 8),
              Text(
                countryCode.toUpperCase(),
                style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              InkWell(onTap: () => widget.callBack(widget.coin), child: SvgPicture.asset("assets/svgs/eye.svg")),
              InkWell(
                  onTap: () => widget.updateView(EditCoin(coinModel: widget.coin, callBack: widget.updateView)),
                  child: SvgPicture.asset("assets/svgs/edit.svg").marginOnly(left: 8)),
              InkWell(
                  onTap: () {
                    showDeletePopup();
                  },
                  child: SvgPicture.asset("assets/svgs/delete.svg").marginOnly(left: 8)),
            ],
          ),
        ),
      ],
    ).marginSymmetric(horizontal: 12, vertical: 10);
  }

  showDeletePopup() {
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
              "You want to delete ${widget.coin.name}.",
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
                      Navigator.pop(context);
                      Get.find<CoinController>().deleteCoin(widget.coin);
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
                      child: Text("Delete", style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold)),
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
