import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/adController.dart';
import 'package:pingcoin_admin/views/tabs/ad/adDetail.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

import '../../constants/colors.dart';
import '../../models/adModel.dart';
import 'ad/createAd.dart';

class AdTab extends StatefulWidget {
  var callBack;

  AdTab({super.key, required this.callBack});

  @override
  State<AdTab> createState() => _AdTabState();
}

class _AdTabState extends State<AdTab> {
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  void initState() {
    Get.find<AdController>().searchFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: GetBuilder<AdController>(
        builder: (adController) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(title: "Ad"),
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
                              decoration: BoxDecoration(color: Color(0xff3A93CE), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/total.svg",
                                color: rWhite,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: adController.allAds.length),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Total Ads",
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
                              decoration: BoxDecoration(color: Color(0xff30B14B), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/active.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${adController.categorizedAd["Active"]?.length??0}",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                                Text(
                                  "Active",
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
                              decoration: BoxDecoration(color: Color(0xffB0710B), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/pause.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${adController.categorizedAd["Pause"]?.length}",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                                Text(
                                  "Pause",
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
                              decoration: BoxDecoration(color: Color(0xff83AC61), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/active.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${adController.categorizedAd["Completed"]?.length}",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                                Text(
                                  "Completed",
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
                              decoration: BoxDecoration(color: rRed, shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/cancel.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${adController.categorizedAd["Cancelled"]?.length}",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                                Text(
                                  "Cancelled",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.normal, fontSize: 16),
                                ),
                              ],
                            ).marginOnly(left: 12)
                          ],
                        ),
                      ),
                    ),
                  ],
                ).marginOnly(top: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Ads",
                      style: TextStyle(color: rWhite, fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () => widget.callBack(CreateAd(callBack: widget.callBack)),
                      child: Container(
                        decoration: BoxDecoration(color: rGreen, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svgs/add.svg"),
                            Text(
                              "Add New Ad",
                              style: TextStyle(color: rWhite),
                            ).marginOnly(left: 8)
                          ],
                        ).marginAll(12),
                      ),
                    )
                  ],
                ).marginOnly(top: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            cursorColor: rGreen,
                            controller: adController.searchController,
                            onChanged: (value) {
                              adController.searchFilter();
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Search',
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
                              value: adController.selectedStatus,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Status',
                                suffixIcon: Icon(Icons.keyboard_arrow_down, color: rHint),
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
                              items: adController.filterStatuses.map((String validate) {
                                return DropdownMenuItem<String>(
                                  value: validate,
                                  child: Text(validate, style: TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                adController.setFilterStatus(newValue!);
                                adController.searchFilter();
                              },
                            ),
                          ),
                        ).marginOnly(left: 12),
                        Visibility(
                          visible: adController.selectedStatus != null ? true : false,
                          child: InkWell(
                              onTap: () {
                                adController.searchController.text = '';
                                adController.setFilterStatus(null);
                                adController.searchFilter();
                              },
                              child: Icon(
                                Icons.close,
                                color: rRed,
                              )).marginOnly(left: 12),
                        )
                      ],
                    ),
                  ],
                ).marginOnly(top: 12),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: rBg),
                  child: Column(
                    children: [
                      TableHeader(),
                      ListView.builder(
                          itemCount: adController.filteredAds.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return AdTile(callBack: widget.callBack, adModel: adController.filteredAds[index]);
                          }),
                    ],
                  ),
                ).marginOnly(top: 12)
              ],
            ).marginSymmetric(horizontal: 20, vertical: 10),
          );
        },
      ),
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
            flex: 2,
            child: Text(
              "Name",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            flex: 2,
            child: Text(
              "Link",
              style: TextStyle(color: rHint, fontWeight: FontWeight.bold),
            )),
        Expanded(
            child: Text(
          "Status",
          style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
        )),
        Expanded(
            flex: 2,
            child: Text(
              "Interest",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            child: Text(
          "Specific Code",
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

class AdTile extends StatefulWidget {
  var callBack;
  AdModel adModel;

  AdTile({super.key, required this.callBack, required this.adModel});

  @override
  State<AdTile> createState() => _AdTileState();
}

class _AdTileState extends State<AdTile> {
  String getConcatenatedNames() {
    Map<String, String> modelMap = {for (var item in Get.find<AdController>().adInterests) item.id: item.name};

    List<String> names = widget.adModel.interestIds.map((id) => modelMap[id] ?? "").toList();

    return names.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          "${widget.adModel.id.substring(0, 6)}...",
          style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
        )),
        Expanded(
            flex: 2,
            child: Text(
              "${widget.adModel.name}",
              style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
            )),
        Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => openLinkInNewTab(widget.adModel.link),
              child: Text(
                widget.adModel.link,
                style: TextStyle(color: Color(0xff3A93CE), fontWeight: FontWeight.normal),
              ),
            )),
        Expanded(
            child: Text(
          "${widget.adModel.status}",
          style: TextStyle(
              color: widget.adModel.status == "Active"
                  ? rGreen
                  : widget.adModel.status == "Pause"
                      ? rYellow
                      : widget.adModel.status == "Completed"
                          ? rLightGreen
                          : rRed,
              fontWeight: FontWeight.normal),
        )),
        Expanded(
            flex: 2,
            child: Text(
              getConcatenatedNames(),
              style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
            ).marginOnly(right: 10)),
        Expanded(
            child: Text(
          "${widget.adModel.specificCode}",
          style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
        )),
        Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () => widget.callBack(AdDetail(
                          callBack: widget.callBack,
                          adModel: widget.adModel,
                        )),
                    child: SvgPicture.asset("assets/svgs/eye.svg")))),
      ],
    ).marginSymmetric(horizontal: 12, vertical: 10);
  }

  void openLinkInNewTab(String link) {
    html.window.open(link, '_blank');
  }
}
