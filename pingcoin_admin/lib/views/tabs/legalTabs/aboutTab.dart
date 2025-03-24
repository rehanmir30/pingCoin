import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/constants/colors.dart';
import 'package:pingcoin_admin/controllers/authController.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {

  String about='';
  @override
  void initState() {
    super.initState();
    about= Get.find<AuthController>().about;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About",
            style: TextStyle(color: rWhite, fontSize: 24, fontWeight: FontWeight.bold),
          ).marginOnly(top: 12),
          Expanded(
            child: TextFormField(
              cursorColor: rGreen,
              initialValue: about,
              style: TextStyle(color: rWhite),
              onChanged: (value){
                about=value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: rBg,
                hintText: "Enter your about here",
                hintStyle: TextStyle(color: rHint),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFF98A2B3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFF98A2B3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFF98A2B3)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                alignLabelWithHint: true,
              ),
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
            ).marginOnly(top: 12),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (){
                authController.updateContent("About",about);
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: rGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Save",style: TextStyle(color: rWhite),).marginSymmetric(vertical: 12),
              ).marginOnly(top: 12),
            ),
          )
        ],
      );
    },);
  }
}
