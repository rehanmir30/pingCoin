import 'dart:html' as html;

import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/adController.dart';
import 'package:pingcoin_admin/models/adInterestModel.dart';
import 'package:pingcoin_admin/models/adModel.dart';
import 'package:pingcoin_admin/views/tabs/adTab.dart';
import 'package:pingcoin_admin/widgets/customSnackbar.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

import '../../../constants/colors.dart';
import '../../../widgets/customLoading.dart';

class CreateAd extends StatefulWidget {
  var callBack;

  CreateAd({super.key, required this.callBack});

  @override
  State<CreateAd> createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
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
                      "Add New Ad",
                      style: TextStyle(color: rWhite, fontSize: 20),
                    ).marginOnly(top: 20),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => widget.callBack(AdTab(callBack: widget.callBack)),
                          child: Text(
                            "Ad / ",
                            style: TextStyle(color: rGreen),
                          ),
                        ),
                        Text(
                          "add new ad",
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
                            child: adBanner == null
                                ? DottedBorder(
                                    color: rHint,
                                    radius: Radius.circular(8),
                                    borderType: BorderType.RRect,
                                    dashPattern: [8, 4],
                                    child: Container(
                                      width: 350,
                                      height: 150,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset("assets/svgs/upload.svg"),
                                          Text(
                                            "Upload ad banner",
                                            style: TextStyle(color: rHint),
                                          ).marginOnly(top: 12),
                                          Text(
                                            "Size: 350 * 150",
                                            style: TextStyle(color: rHint, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )).marginOnly(top: 8)
                                : Container(
                                    width: 350,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        adBannerUrl!,
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
                              if (adNameController.text.isEmpty || selectedItems.isEmpty || adLinkController.text.isEmpty || adBanner == null) {
                                CustomSnackbar.show("Error", "All fields are required", isSuccess: false);
                              } else {
                                AdModel adModel = AdModel(
                                    id: "", name: adNameController.text, image: "", interestIds: [], link: adLinkController.text, status: "Active",specificCode: "");
                                for (var item in selectedItems) {
                                  adModel.interestIds.add(item.id);
                                }
                                await adController.createAd(adModel, adBanner!);
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
                                "Add",
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

class AdInterestTile extends StatefulWidget {
  AdInterestModel adInterestModel;

  AdInterestTile({super.key, required this.adInterestModel});

  @override
  State<AdInterestTile> createState() => _AdInterestTileState();
}

class _AdInterestTileState extends State<AdInterestTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.adInterestModel.name}",
                style: TextStyle(color: rWhite, fontSize: 16),
              ),
              InkWell(
                  onTap: () {
                    showDeletePopup();
                  },
                  child: Icon(
                    Icons.delete_outlined,
                    color: rRed,
                  )),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 1,
          color: rHint.withOpacity(0.2),
        ).marginOnly(top: 5)
      ],
    ).marginOnly(top: 10);
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
              "You want to delete ${widget.adInterestModel.name}.",
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
                      Get.find<AdController>().deleteInterest(widget.adInterestModel);
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
