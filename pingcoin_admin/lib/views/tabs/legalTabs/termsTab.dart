import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/authController.dart';

import '../../../constants/colors.dart';

class TermsTab extends StatefulWidget {
  const TermsTab({super.key});

  @override
  State<TermsTab> createState() => _TermsTabState();
}

class _TermsTabState extends State<TermsTab> {

  String terms='';
  @override
  void initState() {
    terms= Get.find<AuthController>().terms;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Terms and Conditions",
            style: TextStyle(color: rWhite, fontSize: 24, fontWeight: FontWeight.bold),
          ).marginOnly(top: 12),
          Expanded(
            child: TextFormField(
              cursorColor: rGreen,
              initialValue: terms,
              onChanged: (value){
                terms=value;
              },
              style: TextStyle(color: rWhite),
              decoration: InputDecoration(
                filled: true,
                fillColor: rBg,
                hintText: "Enter your terms and conditions here",
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
                authController.updateContent("Terms",terms);
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
