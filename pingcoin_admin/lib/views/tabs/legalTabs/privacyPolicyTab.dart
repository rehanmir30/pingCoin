import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/authController.dart';

import '../../../constants/colors.dart';

class PrivacyPolicyTab extends StatefulWidget {
  const PrivacyPolicyTab({super.key});

  @override
  State<PrivacyPolicyTab> createState() => _PrivacyPolicyTabState();
}

class _PrivacyPolicyTabState extends State<PrivacyPolicyTab> {

  String privacy='';
  @override
  void initState() {
    privacy= Get.find<AuthController>().about;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Privacy Policy",
            style: TextStyle(color: rWhite, fontSize: 24, fontWeight: FontWeight.bold),
          ).marginOnly(top: 12),
          Expanded(
            child: TextFormField(
              cursorColor: rGreen,
              initialValue: authController.privacy,
              onChanged: (value){
                privacy=value;
              },
              style: TextStyle(color: rWhite),
              decoration: InputDecoration(
                filled: true,
                fillColor: rBg,
                hintText: "Enter your privacy policy here",
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
                authController.updateContent("Privacy",privacy);
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
