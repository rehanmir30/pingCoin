import 'dart:html' as html;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/adController.dart';
import 'package:pingcoin_admin/views/tabs/ad/adDetail.dart';
import 'package:pingcoin_admin/views/tabs/adTab.dart';

import '../../../constants/colors.dart';
import '../../../models/adInterestModel.dart';
import '../../../models/adModel.dart';
import '../../../widgets/customLoading.dart';
import '../../../widgets/customSnackbar.dart';
import '../../../widgets/topBar.dart';
import 'createAd.dart';

class EditAd extends StatefulWidget {
  var callBack;
  AdModel adModel;

  EditAd({super.key, required this.adModel, required this.callBack});

  @override
  State<EditAd> createState() => _EditAdState();
}

class _EditAdState extends State<EditAd> {
  List<AdInterestModel> selectedItems = [];
  TextEditingController adNameController = TextEditingController();
  TextEditingController adLinkController = TextEditingController();
  html.File? adBanner;
  String? adBannerUrl;

  void pickImage() {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      if (input.files!.isNotEmpty) {
        final file = input.files!.first;
        final objectUrl = html.Url.createObjectUrl(file);
        setState(() {
          adBanner = file;
          adBannerUrl = objectUrl;
        });
      }
    });
  }

  @override
  void initState() {
    adNameController.text = widget.adModel.name;
    adLinkController.text = widget.adModel.link;

    for (var id in widget.adModel.interestIds) {
      selectedItems.add(Get.find<AdController>().adInterests.firstWhere((element) => element.id == id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: GetBuilder<AdController>(
        builder: (adController) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TopBar(title: "Ad"),
                    Text(
                      "Edit Ad",
                      style: TextStyle(color: rWhite, fontSize: 20),
                    ).marginOnly(top: 20),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => widget.callBack(AdDetail(adModel: widget.adModel, callBack: widget.callBack)),
                          child: Text(
                            "Ad / ad detail / ",
                            style: TextStyle(color: rGreen),
                          ),
                        ),
                        Text(
                          "edit ad ",
                          style: TextStyle(color: rWhite),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ad name",
                            style: TextStyle(color: rWhite, fontSize: 14),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: TextFormField(
                              cursorColor: rGreen,
                              keyboardType: TextInputType.emailAddress,
                              controller: adNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff282828),
                                hintText: 'Enter ad name',
                                hintStyle: TextStyle(
                                  color: rHint,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff4C4C4C),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff4C4C4C),
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

                          //add interest button
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 24,
                            child: TextFormField(
                              cursorColor: rGreen,
                              keyboardType: TextInputType.url,
                              initialValue: "Interest",
                              readOnly: true,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        showAddInterestPopup();
                                      },
                                      child: SvgPicture.asset("assets/svgs/addGreen.svg")),
                                  hintStyle: TextStyle(
                                    color: rHint,
                                  ),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.zero),
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ).marginOnly(top: 20),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: rBlack,
                              ),
                              child: DropdownButtonFormField<AdInterestModel>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: selectedItems.isEmpty ? 'Select' : selectedItems.map((item) => item.name).join(', '),
                                  suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                ),
                                icon: SizedBox.shrink(),
                                items: adController.adInterests.map((AdInterestModel item) {
                                  return DropdownMenuItem<AdInterestModel>(
                                    value: item,
                                    enabled: false,
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final isSelected = selectedItems.contains(item);
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              isSelected ? selectedItems.remove(item) : selectedItems.add(item);
                                            });
                                            menuSetState(() {});
                                          },
                                          child: SizedBox(
                                            height: 40,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                                                  color: isSelected ? Colors.green : Colors.grey,
                                                ),
                                                const SizedBox(width: 16),
                                                Text(
                                                  item.name,
                                                  style: TextStyle(fontSize: 14, color: rWhite),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ).marginOnly(top: 8),

                          Text(
                            "Link",
                            style: TextStyle(color: rWhite, fontSize: 14),
                          ).marginOnly(top: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: TextFormField(
                              cursorColor: rGreen,
                              keyboardType: TextInputType.url,
                              controller: adLinkController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff282828),
                                hintText: 'Enter link',
                                hintStyle: TextStyle(
                                  color: rHint,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff4C4C4C),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff4C4C4C),
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

                          Text(
                            "Upload ad banner",
                            style: TextStyle(color: rWhite, fontSize: 14),
                          ).marginOnly(top: 20),

                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              pickImage();
                            },
                            child: Container(
                              width: 350,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  adBannerUrl != null ? adBannerUrl! : widget.adModel.image,
                                  fit: BoxFit.fill,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () async {
                              if (adNameController.text.isEmpty || selectedItems.isEmpty || adLinkController.text.isEmpty) {
                                CustomSnackbar.show("Error", "All fields are required", isSuccess: false);
                              } else {
                                AdModel adModel = AdModel(
                                    id: widget.adModel.id,
                                    name: adNameController.text,
                                    image: widget.adModel.image,
                                    interestIds: [],
                                    link: adLinkController.text,
                                    status: widget.adModel.status,
                                    specificCode: widget.adModel.specificCode);
                                for (var item in selectedItems) {
                                  adModel.interestIds.add(item.id);
                                }
                                bool result=await adController.editAd(adModel, adBanner);
                                if(result){
                                  return widget.callBack(AdTab(callBack: widget.callBack));
                                }
                              }
                            },
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                color: rGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Update",
                                style: TextStyle(color: rWhite),
                              ).marginSymmetric(vertical: 8),
                            ).marginOnly(top: 20),
                          )
                        ],
                      ),
                    )
                  ],
                ).marginSymmetric(horizontal: 20, vertical: 10),
              ),
              Visibility(
                  visible: adController.isLoading,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: rWhite.withOpacity(0.2),
                      child: CustomLoading()))
            ],
          );
        },
      ),
    );
  }

  showAddInterestPopup() {
    String interestName = '';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ElasticIn(
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: rBg,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add New Interest",
                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
                ),
                content: GetBuilder<AdController>(
                  builder: (adController) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(color: rWhite, fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: TextFormField(
                                cursorColor: rGreen,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  interestName = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xff282828),
                                  hintText: 'Enter ad name',
                                  hintStyle: TextStyle(
                                    color: rHint,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff4C4C4C),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff4C4C4C),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 16.0,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (interestName == "") {
                                  CustomSnackbar.show("Error", "Interest name is required", isSuccess: false);
                                  return;
                                } else {
                                  adController.createNewInterest(interestName);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(color: rGreen, borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add",
                                  style: TextStyle(color: rWhite),
                                ).marginSymmetric(horizontal: 20, vertical: 12),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Recent",
                          style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold),
                        ).marginOnly(top: 12),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: ListView.builder(
                            itemCount: adController.adInterests.length,
                            shrinkWrap: true,
                            // physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return AdInterestTile(adInterestModel: Get.find<AdController>().adInterests[index]);
                            },
                          ),
                        ).marginOnly(top: 20),
                      ],
                    );
                  },
                ),
                actionsAlignment: MainAxisAlignment.center,
              );
            },
          ),
        );
      },
    );
  }
}
