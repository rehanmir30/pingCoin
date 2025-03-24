import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/authController.dart';

import '../constants/colors.dart';

class TopBar extends StatefulWidget {
  final title;
  const TopBar({super.key,required this.title});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
        decoration: BoxDecoration(
            color: rBg,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          children: [
            Expanded(child: Text("${widget.title}",style: TextStyle(color: rWhite,fontSize: 20),)),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.notifications_active_outlined,color: rWhite,),
                SizedBox(
                  width: 40,
                ),
                Text("${authController.managementUserModel!.firstName} ${authController.managementUserModel!.lastName}",style: TextStyle(color: rWhite),),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: rBlack
                  ),
                  alignment: Alignment.center,
                  child: Text("${authController.managementUserModel!.firstName[0]}",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 20),),
                ).marginOnly(left: 12)
              ],
            ))
          ],
        ).marginSymmetric(horizontal: 20,vertical: 5),
      );
    },);
  }
}
