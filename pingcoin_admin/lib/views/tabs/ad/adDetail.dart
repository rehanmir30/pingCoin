import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/adController.dart';
import 'package:pingcoin_admin/views/tabs/ad/editAd.dart';
import 'package:pingcoin_admin/views/tabs/adTab.dart';
import 'package:pingcoin_admin/widgets/customSnackbar.dart';

import '../../../constants/colors.dart';
import '../../../models/adModel.dart';
import '../../../widgets/topBar.dart';

class AdDetail extends StatefulWidget {
  var callBack;
  AdModel adModel;

  AdDetail({super.key, required this.callBack, required this.adModel});

  @override
  State<AdDetail> createState() => _AdDetailState();
}

class _AdDetailState extends State<AdDetail> {
  String getConcatenatedNames() {
    Map<String, String> modelMap = {for (var item in Get.find<AdController>().adInterests) item.id: item.name};

    List<String> names = widget.adModel.interestIds.map((id) => modelMap[id] ?? "").toList();

    return names.join(", ");
  }

  String currentStatus="";


  @override
  void initState() {
    setState(() {
      currentStatus=widget.adModel.status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(title: "Ad"),
            Text(
              "Ad Details",
              style: TextStyle(color: rWhite, fontSize: 20),
            ).marginOnly(top: 20),
            Row(
              children: [
                InkWell(
                  onTap: () => widget.callBack(AdTab(callBack: widget.callBack)),
                  child: Text(
                    "ad / ",
                    style: TextStyle(color: rGreen),
                  ),
                ),
                Text(
                  "ad details",
                  style: TextStyle(color: rWhite),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: rBg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //left side
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              "${widget.adModel.name}",
                              style: TextStyle(fontWeight: FontWeight.normal, color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              "${currentStatus}",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: currentStatus == "Active"
                                      ? rGreen
                                      : currentStatus == "Pause"
                                          ? rYellow
                                          : currentStatus == "Completed"
                                              ? rLightGreen
                                              : rRed,
                                  fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Interest",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              getConcatenatedNames(),
                              style: TextStyle(fontWeight: FontWeight.normal, color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Specific Code",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              "${widget.adModel.specificCode}",
                              style: TextStyle(fontWeight: FontWeight.normal, color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Link",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              "${widget.adModel.link}",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff3A93CE), fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                      ],
                    ),
                  ),

                  //right side
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.network(
                          "${widget.adModel.image}",
                          width: 350,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () => widget.callBack(EditAd(adModel: widget.adModel, callBack: widget.callBack)),
                                child: Container(
                                  width: 120,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Color(0xff929599)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Color(0xff929599)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if(currentStatus=="Pause"){
                                    await showStatusPopup("Active");
                                    setState(() {
                                      currentStatus;
                                    });
                                  }else if(currentStatus=="Active"){
                                   await showStatusPopup("Pause");
                                    setState(() {
                                      currentStatus;
                                    });
                                  }
                                  else{
                                    CustomSnackbar.show("Error", "Completed or cancelled Ads cannot be activated or paused",isSuccess: false);
                                  }
                                },
                                child: Container(
                                  width: 120,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: currentStatus=="Pause"?rGreen:Color(0xffFF9E00)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    currentStatus=="Pause"?"Activate":"Pause",
                                    style: TextStyle(color: currentStatus=="Pause"?rGreen:Color(0xffFF9E00)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await showStatusPopup("Completed");
                                  setState(() {
                                    currentStatus;
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: rLightGreen),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Complete",
                                    style: TextStyle(color: rLightGreen),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await showStatusPopup("Cancelled");
                                  setState(() {
                                    currentStatus;
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Color(0xffFF6666)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Color(0xffFF6666)),
                                  ),
                                ),
                              ),
                            ],
                          ).marginOnly(top: 200, bottom: 30),
                        )
                      ],
                    ),
                  )
                ],
              ).marginAll(12),
            ).marginOnly(top: 12)
          ],
        ).marginSymmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  showStatusPopup(String status) async{
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ElasticIn(
          child: AlertDialog(
            backgroundColor: rBg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(child: Text("Are you sure?", style: TextStyle(fontWeight: FontWeight.bold, color: rWhite))),
            content: Text(
              "You want to mark your ad ${widget.adModel.name} as $status.",
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
                    onTap: () async {
                      Navigator.pop(context);
                      currentStatus=status;
                      await Get.find<AdController>().editAdStatus(widget.adModel, status);
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
                      child: Text("$status", style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold)),
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
