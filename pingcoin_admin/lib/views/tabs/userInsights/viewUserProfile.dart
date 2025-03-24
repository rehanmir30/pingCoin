import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/controllers/userController.dart';
import 'package:pingcoin_admin/views/tabs/usersTab.dart';

import '../../../constants/colors.dart';
import '../../../models/userModel.dart';
import '../../../widgets/topBar.dart';

class ViewUserProfile extends StatefulWidget {
  var callBack;
  UserModel userModel;
   ViewUserProfile({super.key,required this.callBack,required this.userModel});

  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {

  String _getInitials(String fullName) {
    List<String> nameParts = fullName.trim().split(' ');

    if (nameParts.length == 1) {
      return nameParts[0][0].toUpperCase(); // First letter of single name
    } else {
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase(); // First letter of first and second name
    }
  }

  String _getFirstName(String fullName){
    List<String> nameParts = fullName.trim().split(' ');
    return nameParts[0];
    // if (nameParts.length == 1) {
    //   return nameParts[0];
    // } else {
    //   return (nameParts[0][0] + nameParts[1][0]).toUpperCase(); // First letter of first and second name
    // }
  }

  String _getLastName(String fullName){
    List<String> nameParts = fullName.trim().split(' ');
    if (nameParts.length >= 2) {
      return nameParts[1];
    } else {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(title: "Users"),
            Text(
              "User Profile",
              style: TextStyle(color: rWhite, fontSize: 20),
            ).marginOnly(top: 20),
            Row(
              children: [
                InkWell(
                  onTap: () => widget.callBack(UsersTab(callBack: widget.callBack)),
                  child: Text(
                    "users / ",
                    style: TextStyle(color: rGreen),
                  ),
                ),
                Text(
                  "user profile",
                  style: TextStyle(color: rWhite),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: rBg,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Profile",style: TextStyle(color: rWhite,fontWeight: FontWeight.bold,fontSize: 20),),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: (){
                              if(widget.userModel.status=="Active"){
                                showBlockPopup("Block");
                              }else{
                                showBlockPopup("Activate");
                              }

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: widget.userModel.status=="Blocked"?rGreen:rRed,
                              ),
                              alignment: Alignment.center,
                              child: Text(widget.userModel.status=="Active"?'Block':"Activate",style: TextStyle(color: rWhite),).marginSymmetric(horizontal: 24,vertical: 8),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: rHint,
                            ),
                            alignment: Alignment.center,
                            child: Text('Reset Password',style: TextStyle(color: rWhite),).marginSymmetric(horizontal: 24,vertical: 8),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff222227)),
                            alignment: Alignment.center,
                            child: Text(
                              _getInitials(widget.userModel.fullName),
                              style: TextStyle(color: rWhite, fontSize: 16),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name",style: TextStyle(color: rHint,fontWeight: FontWeight.w600,fontSize: 16),),
                              Text(_getFirstName(widget.userModel.fullName),style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                            ],
                          ).marginOnly(left: 8),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Last Name",style: TextStyle(color: rHint,fontWeight: FontWeight.w600,fontSize: 16),),
                          Text(_getLastName(widget.userModel.fullName),style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",style: TextStyle(color: rHint,fontWeight: FontWeight.w600,fontSize: 16),),
                          Text(widget.userModel.email,style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Member since",style: TextStyle(color: rHint,fontWeight: FontWeight.w600,fontSize: 16),),
                          Text("${DateFormat('dd-MM-yyyy').format(widget.userModel.createdAt)}",style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Last Login",style: TextStyle(color: rHint,fontWeight: FontWeight.w600,fontSize: 16),),
                          Text("${DateFormat('dd-MM-yyyy').format(widget.userModel.updatedAt)}",style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status",style: TextStyle(color: rHint,fontWeight: FontWeight.w600,fontSize: 16),),
                          Text("${widget.userModel.status}",style: TextStyle(color: widget.userModel.status=="Active"?rGreen:rRed,fontWeight: FontWeight.normal,fontSize: 16),),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Coin Tested",style: TextStyle(color: rHint,fontWeight: FontWeight.w600,fontSize: 16),),
                          Text("0",style: TextStyle(color: rWhite,fontWeight: FontWeight.normal,fontSize: 16),),
                        ],
                      ),
                    ],
                  ).marginOnly(top: 30),
                ],
              ).marginSymmetric(horizontal: 24,vertical: 12),
            ).marginOnly(top: 12),
        
            Text("Recent Tests",style: TextStyle(color: rWhite,fontSize: 20,fontWeight: FontWeight.bold),).marginOnly(top: 20),
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
                      itemCount: 8,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return TestTile();
                      }),
                ],
              ),
            )
          ],
        ).marginSymmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  showBlockPopup(String type) {
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
              "You want to ${type} ${widget.userModel.fullName}.",
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
                      if(type=="Block"){
                        Get.find<UserController>().blockUser(widget.userModel,true,widget.callBack);
                      }else{
                        Get.find<UserController>().blockUser(widget.userModel,false,widget.callBack);
                      }

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 50,
                      decoration: BoxDecoration(
                        // border: Border.all(color: rRed),
                        borderRadius: BorderRadius.circular(16),
                        color: widget.userModel.status=="Blocked"?rGreen:rRed,
                      ),
                      alignment: Alignment.center,
                      child: Text(widget.userModel.status=="Blocked"?"Activate":"Block", style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold)),
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
              "Status",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
      ],
    ).marginSymmetric(horizontal: 12, vertical: 10),
  );
}

class TestTile extends StatefulWidget {

  TestTile({super.key});

  @override
  State<TestTile> createState() => _TestTileState();
}

class _TestTileState extends State<TestTile> {
  String getCountryCode(String countryData) {
    return countryData.split(" ")[1].toLowerCase();
  }

  String getFlagUrl(String countryCode) {
    return "https://flagcdn.com/w80/$countryCode.png";
  }

  @override
  Widget build(BuildContext context) {
    String countryCode = getCountryCode("🇲🇽 MX - Mexico");

    return Row(
      children: [
        Expanded(
          child: Text(
            "UP0231...",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/pingcoin.firebasestorage.app/o/utzRZ2lzmIPnBWxjntY8%2FcoinFront?alt=media&token=65517b24-0004-4e01-b8d7-3825deeafcee",
                width: 40,
                height: 40,
              ),
              CachedNetworkImage(
                imageUrl: "https://firebasestorage.googleapis.com/v0/b/pingcoin.firebasestorage.app/o/utzRZ2lzmIPnBWxjntY8%2FcoinBack?alt=media&token=289fed87-8133-4077-bbe2-7f8379d35924",
                width: 40,
                height: 40,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "American Silver",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Text(
            "Silver",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Text(
            "12g",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Text(
            "99%",
            style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Image.network(getFlagUrl(countryCode), width: 24, height: 16),
            ],
          ),
        ),
        Expanded(
          child: Text("Real",style: TextStyle(color: rWhite, fontWeight: FontWeight.normal)),
        ),
      ],
    ).marginSymmetric(horizontal: 12, vertical: 10);
  }
}
