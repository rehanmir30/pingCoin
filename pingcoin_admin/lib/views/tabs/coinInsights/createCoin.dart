import 'dart:html' as html;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/coinController.dart';
import 'package:pingcoin_admin/models/coinModel.dart';
import 'package:pingcoin_admin/widgets/customSnackbar.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';
import '../../../constants/colors.dart';
import '../../../widgets/customDropDown.dart';
import '../../../widgets/customLoading.dart';
import '../coinsTab.dart';

class CreateCoin extends StatefulWidget {
  var callBack;
  CreateCoin({super.key,required this.callBack});

  @override
  State<CreateCoin> createState() => _CreateCoinState();
}

class _CreateCoinState extends State<CreateCoin> {
  html.File? coinFront;
  html.File? coinBack;
  String? coinFrontUrl;
  String? coinBackUrl;
  html.File? mp3File;

  String? selectedCountry;
  String? selectedDiameterUnit;
  String? selectedThicknessUnit;
  String? selectedCategory;
  String? selectedWeightUnit;
  String? selectedHighLevelValidation;

  TextEditingController diameterController = TextEditingController();
  TextEditingController thicknessController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController highLevelController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController coinNameController = TextEditingController();
  TextEditingController coinDescriptionController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void pickImage(String type) {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      if (input.files!.isNotEmpty) {
        final file = input.files!.first;
        final objectUrl = html.Url.createObjectUrl(file); // Convert file to URL

        setState(() {
          if (type == "front") {
            coinFront = file;
            coinFrontUrl = objectUrl;
          } else if (type == "back") {
            coinBack = file;
            coinBackUrl = objectUrl;
          }
        });
      }
    });
  }

  void pickMp3File() {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'audio/mp3'; // Accept only MP3 files
    input.click();

    input.onChange.listen((event) {
      if (input.files!.isNotEmpty) {
        mp3File = input.files!.first; // Get the selected file
        print("Picked file: ${mp3File?.name}, Size: ${mp3File?.size} bytes, Type: ${mp3File?.type}");
        setState(() {
          mp3File;
        });
      }
    });
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
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopBar(title: "Coins"),
                          Text(
                            "Add New Coin",
                            style: TextStyle(color: rWhite, fontSize: 20),
                          ).marginOnly(top: 20),
                          Row(
                            children: [
                              InkWell(
                                onTap: () => widget.callBack(CoinsTab(callBack: widget.callBack)),
                                child: Text(
                                  "coins / ",
                                  style: TextStyle(color: rGreen),
                                ),
                              ),
                              Text(
                                "add new coin",
                                style: TextStyle(color: rWhite),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: rBg,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //left side
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height * 0.17,
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Head",
                                                      style: TextStyle(color: rHint),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        pickImage("front");
                                                      },
                                                      child: coinFront != null
                                                          ? Container(
                                                              width: 60,
                                                              height: 60,
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(10),
                                                                child: Image.network(coinFrontUrl!, fit: BoxFit.fill,width: 40,height: 40,),
                                                              ),
                                                            ).marginOnly(top: 20)
                                                          : DottedBorder(
                                                              color: rHint,
                                                              radius: Radius.circular(8),
                                                              borderType: BorderType.Circle,
                                                              dashPattern: [8, 4],
                                                              child: Container(
                                                                width: 60,
                                                                height: 60,
                                                                alignment: Alignment.center,
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    SvgPicture.asset("assets/svgs/upload.svg"),
                                                                  ],
                                                                ),
                                                              )).marginOnly(top: 20),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.05,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Tail",
                                                      style: TextStyle(color: rHint),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        pickImage("back");
                                                      },
                                                      child: coinBack != null
                                                          ? Container(
                                                              width: 60,
                                                              height: 60,
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(10),
                                                                child: Image.network(coinBackUrl!, fit: BoxFit.fill),
                                                              ),
                                                            ).marginOnly(top: 20)
                                                          : DottedBorder(
                                                              color: rHint,
                                                              radius: Radius.circular(8),
                                                              borderType: BorderType.Circle,
                                                              dashPattern: [8, 4],
                                                              child: Container(
                                                                width: 60,
                                                                height: 60,
                                                                alignment: Alignment.center,
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    SvgPicture.asset("assets/svgs/upload.svg"),
                                                                  ],
                                                                ),
                                                              )).marginOnly(top: 20),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Country",
                                            style: TextStyle(color: rHint),
                                          ),

                                          // Theme(
                                          //   data: Theme.of(context).copyWith(
                                          //     canvasColor: rBlack,
                                          //   ),
                                          //   child: DropdownButtonFormField<String>(
                                          //     value: null,
                                          //     validator: (value) {
                                          //       if (value == null || value.isEmpty) {
                                          //         return 'Please select a country';
                                          //       }
                                          //       return null;
                                          //     },
                                          //     decoration: InputDecoration(
                                          //       filled: true,
                                          //       fillColor: Colors.transparent,
                                          //       hintText: 'Select',
                                          //       suffixIcon: Icon(Icons.keyboard_arrow_down, color: rHint),
                                          //       // Custom dropdown arrow
                                          //       hintStyle: TextStyle(
                                          //         color: rHint.withOpacity(0.5),
                                          //       ),
                                          //       border: OutlineInputBorder(
                                          //         borderRadius: BorderRadius.circular(8.0),
                                          //       ),
                                          //       enabledBorder: OutlineInputBorder(
                                          //         borderSide: BorderSide(color: rHint),
                                          //         borderRadius: BorderRadius.circular(8.0),
                                          //       ),
                                          //       focusedBorder: OutlineInputBorder(
                                          //         borderSide: BorderSide(color: rHint),
                                          //         borderRadius: BorderRadius.circular(8.0),
                                          //       ),
                                          //       contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                          //     ),
                                          //     style: TextStyle(color: Colors.white),
                                          //     icon: SizedBox.shrink(),
                                          //     items: coinController.countryCodes.map((String country) {
                                          //       return DropdownMenuItem<String>(
                                          //         value: country,
                                          //         child: Text(country, style: TextStyle(color: Colors.white)),
                                          //       );
                                          //     }).toList(),
                                          //     onChanged: (String? newValue) {
                                          //       selectedCountry = newValue;
                                          //     },
                                          //   ),
                                          // ),

                                          SearchableDropdown(
                                            countryCodes: coinController.countryCodes,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedCountry = newValue;
                                              });
                                            },
                                            selectedCountry: selectedCountry,
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Diameter",
                                                        style: TextStyle(color: rHint),
                                                      ),
                                                      TextFormField(
                                                        cursorColor: rGreen,
                                                        controller: diameterController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                                                        ],
                                                        validator: (diameter) {
                                                          if (diameter == null || diameter.isEmpty) {
                                                            return "Diameter is required";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.transparent,
                                                          hintText: 'Enter diameter(e.g, 40.6)',
                                                          hintStyle: TextStyle(
                                                            color: rHint.withOpacity(0.5),
                                                          ),
                                                          // prefixIcon: Icon(Icons.search,color: rHint,),
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
                                                    ],
                                                  )),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Unit",
                                                    style: TextStyle(color: rHint),
                                                  ),
                                                  Theme(
                                                    data: Theme.of(context).copyWith(
                                                      canvasColor: rBlack,
                                                    ),
                                                    child: DropdownButtonFormField<String>(
                                                      value: null,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Select a unit';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        hintText: 'Select',
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
                                                      items: coinController.coinDiameterUnits.map((String unit) {
                                                        return DropdownMenuItem<String>(
                                                          value: unit,
                                                          child: Text(unit, style: TextStyle(color: Colors.white)),
                                                        );
                                                      }).toList(),
                                                      onChanged: (String? newValue) {
                                                        selectedDiameterUnit = newValue;
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ).marginOnly(left: 12)),
                                            ],
                                          ).marginOnly(top: 20),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Thickness",
                                                        style: TextStyle(color: rHint),
                                                      ),
                                                      TextFormField(
                                                        cursorColor: rGreen,
                                                        controller: thicknessController,
                                                        validator: (thickness) {
                                                          if (thickness == null || thickness.isEmpty) {
                                                            return "Thickness is required";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                                                        ],
                                                        decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.transparent,
                                                          hintText: 'Enter diameter(e.g, 40.6)',
                                                          hintStyle: TextStyle(
                                                            color: rHint.withOpacity(0.5),
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
                                                    ],
                                                  )),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Unit",
                                                    style: TextStyle(color: rHint),
                                                  ),
                                                  Theme(
                                                    data: Theme.of(context).copyWith(
                                                      canvasColor: rBlack,
                                                    ),
                                                    child: DropdownButtonFormField<String>(
                                                      value: null,
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Select unit';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        hintText: 'Select',
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
                                                      items: coinController.coinDiameterUnits.map((String validate) {
                                                        return DropdownMenuItem<String>(
                                                          value: validate,
                                                          child: Text(validate, style: TextStyle(color: Colors.white)),
                                                        );
                                                      }).toList(),
                                                      onChanged: (String? newValue) {
                                                        selectedThicknessUnit = newValue;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ).marginOnly(left: 12)),
                                            ],
                                          ).marginOnly(top: 20),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Audio Sound",
                                                style: TextStyle(color: rHint),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  pickMp3File();
                                                },
                                                child: DottedBorder(
                                                    color: rHint,
                                                    radius: Radius.circular(8),
                                                    borderType: BorderType.RRect,
                                                    dashPattern: [8, 4],
                                                    child: Container(
                                                      // width: 60,
                                                      height: 100,
                                                      alignment: Alignment.center,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          mp3File == null
                                                              ? SvgPicture.asset("assets/svgs/upload.svg")
                                                              : Icon(
                                                                  Icons.file_copy_outlined,
                                                                  color: rHint,
                                                                ),
                                                          Text(
                                                            mp3File == null ? "Upload Audio Sound" : "${mp3File!.name}",
                                                            style: TextStyle(color: rHint, fontWeight: FontWeight.w600, fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ).marginOnly(top: 20),
                                        ],
                                      ).marginSymmetric(horizontal: 12),
                                    ),

                                    //right side
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.17,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Name",
                                                style: TextStyle(color: rHint),
                                              ),
                                              TextFormField(
                                                cursorColor: rGreen,
                                                keyboardType: TextInputType.name,
                                                controller: coinNameController,
                                                validator: (coinName) {
                                                  if (coinName == null || coinName.isEmpty) {
                                                    return "Coin name is required";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.transparent,
                                                  hintText: 'Enter coin name (e.g., Gold Eagle)',
                                                  hintStyle: TextStyle(
                                                    color: rHint.withOpacity(0.5),
                                                  ),
                                                  // prefixIcon: Icon(Icons.search,color: rHint,),
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
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "Category",
                                          style: TextStyle(color: rHint),
                                        ),
                                        Theme(
                                          data: Theme.of(context).copyWith(
                                            canvasColor: rBlack,
                                          ),
                                          child: DropdownButtonFormField<String>(
                                            value: null,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Select category';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintText: 'Select',
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
                                            items: coinController.coinCategories.map((String category) {
                                              return DropdownMenuItem<String>(
                                                value: category,
                                                child: Text(category, style: TextStyle(color: Colors.white)),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              selectedCategory = newValue;
                                            },
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Weight",
                                                      style: TextStyle(color: rHint),
                                                    ),
                                                    TextFormField(
                                                      cursorColor: rGreen,
                                                      keyboardType: TextInputType.number,
                                                      controller: weightController,
                                                      validator: (weight) {
                                                        if (weight == null || weight.isEmpty) {
                                                          return "Coin weight is required";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                                                      ],
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        hintText: 'Enter weight (e.g., 31.1)',
                                                        // suffixIcon: Icon(Icons.keyboard_arrow_down,color: rHint,),
                                                        hintStyle: TextStyle(
                                                          color: rHint.withOpacity(0.5),
                                                        ),
                                                        // prefixIcon: Icon(Icons.search,color: rHint,),
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
                                                  ],
                                                )),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Unit",
                                                  style: TextStyle(color: rHint),
                                                ),
                                                Theme(
                                                  data: Theme.of(context).copyWith(
                                                    canvasColor: rBlack,
                                                  ),
                                                  child: DropdownButtonFormField<String>(
                                                    value: null,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Select a unit';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.transparent,
                                                      hintText: 'Select',
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
                                                    items: coinController.coinWeightUnits.map((String unit) {
                                                      return DropdownMenuItem<String>(
                                                        value: unit,
                                                        child: Text(unit, style: TextStyle(color: Colors.white)),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      selectedWeightUnit = newValue;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ).marginOnly(left: 12)),
                                          ],
                                        ).marginOnly(top: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "High Level",
                                                      style: TextStyle(color: rHint),
                                                    ),
                                                    TextFormField(
                                                      cursorColor: rGreen,
                                                      keyboardType: TextInputType.number,
                                                      controller: levelController,
                                                      validator: (highLevel) {
                                                        if (highLevel == null || highLevel.isEmpty) {
                                                          return "Level is required";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                                                      ],
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        hintText: 'Enter purity (e.g., 99.99%)',
                                                        hintStyle: TextStyle(
                                                          color: rHint.withOpacity(0.5),
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
                                                  ],
                                                )),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Validation",
                                                  style: TextStyle(color: rHint),
                                                ),
                                                Theme(
                                                  data: Theme.of(context).copyWith(
                                                    canvasColor: rBlack,
                                                  ),
                                                  child: DropdownButtonFormField<String>(
                                                    value: null,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Select validation';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.transparent,
                                                      hintText: 'Select',
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
                                                    items: coinController.validationList.map((String validate) {
                                                      return DropdownMenuItem<String>(
                                                        value: validate,
                                                        child: Text(validate, style: TextStyle(color: Colors.white)),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      selectedHighLevelValidation = newValue;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ).marginOnly(left: 12)),
                                          ],
                                        ).marginOnly(top: 20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Description",
                                              style: TextStyle(color: rHint),
                                            ),
                                            TextFormField(
                                              cursorColor: rGreen,
                                              keyboardType: TextInputType.text,
                                              controller: coinDescriptionController,
                                              validator: (description) {
                                                if (description == null || description.isEmpty) {
                                                  return "Description cannot be empty";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              maxLines: 4,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                hintText: 'Write description',
                                                hintStyle: TextStyle(
                                                  color: rHint.withOpacity(0.5),
                                                ),
                                                // prefixIcon: Icon(Icons.search,color: rHint,),
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
                                          ],
                                        ).marginOnly(top: 20),
                                      ],
                                    ).marginSymmetric(horizontal: 12)),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (coinFront == null || coinBack == null) {
                                          CustomSnackbar.show("Error", "Coin images are required", isSuccess: false);
                                          return;
                                        } else if (mp3File == null) {
                                          CustomSnackbar.show("Error", "Audio file is required", isSuccess: false);
                                          return;
                                        } else {
                                          CoinModel coinModel = CoinModel(
                                            description: coinDescriptionController.text,
                                            id: "",
                                            name: coinNameController.text,
                                            category: selectedCategory!,
                                            country: selectedCountry!,
                                            diameter: diameterController.text,
                                            diameterUnit: selectedDiameterUnit!,
                                            weight: weightController.text,
                                            weightUnit: selectedWeightUnit!,
                                            thickness: thicknessController.text,
                                            thicknessUnit: selectedThicknessUnit!,
                                            highLevel: levelController.text,
                                            highLevelValidation: selectedHighLevelValidation!,
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now()
                                          );
                                          bool result= await coinController.createCoin(coinModel, coinFront!, coinBack!, mp3File!);
                                          if(result){
                                            return widget.callBack(CoinsTab(callBack: widget.callBack));
                                          }
                                        }
                                      } else {
                                        return;
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.1,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: rGreen,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Add",
                                        style: TextStyle(color: rWhite),
                                      ).marginSymmetric(vertical: 12),
                                    ).marginOnly(top: 12),
                                  ),
                                )
                              ],
                            ).marginSymmetric(horizontal: 15, vertical: 15),
                          ).marginOnly(top: 12),
                        ],
                      ).marginSymmetric(horizontal: 20, vertical: 10),

                    ],
                  ),
                ),
              ),

              Visibility(
                  visible: coinController.isLoading,
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
}

