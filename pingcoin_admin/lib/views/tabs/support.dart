import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/controllers/supportController.dart';
import 'package:pingcoin_admin/models/supportModel.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

import '../../constants/colors.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {

  @override
  void initState() {
    Get.find<SupportController>().searchFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: GetBuilder<SupportController>(builder: (supportController) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(title: "Support"),

              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: TextFormField(
                      cursorColor: rGreen,
                      controller: supportController.searchController,
                      onChanged: (value){
                        supportController.searchFilter();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: rHint,
                        ),
                        prefixIcon: Icon(Icons.search,color: rHint,),
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
                          vertical: 12.0, horizontal: 16.0,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: TextFormField(
                      cursorColor: rGreen,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      onTap: () async {
                        DateTime initialDate = DateTime.now();
                        supportController.setFilterDate(await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: DateTime.now().subtract(Duration(days: 365)),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: rGreen,
                                  onPrimary: Colors.white,
                                  surface: Color(0xff2C2C2C),
                                  onSurface: Colors.white,
                                ),
                                dialogBackgroundColor: Color(0xff2C2C2C),
                              ),
                              child: child!,
                            );
                          },
                        ));
                        supportController.searchFilter();
                      },
                      controller: supportController.filterDateController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Date',
                        hintStyle: TextStyle(
                          color: rHint,
                        ),
                        suffixIcon: SvgPicture.asset(
                          "assets/svgs/calendar.svg",
                          color: rHint,
                        ).marginAll(6),
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
                  ).marginOnly(left: 12),
                  Visibility(
                    visible:  supportController.selectedDate != null ? true : false,
                    child: InkWell(
                        onTap: () {
                          supportController.searchController.text = '';
                          supportController.setFilterDate(null);
                          supportController.searchFilter();
                        },
                        child: Icon(
                          Icons.close,
                          color: rRed,
                        )).marginOnly(left: 12),
                  )
                ],
              ).marginOnly(top: 20),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: rBg,
                ),
                child: ListView.builder(
                  itemCount: supportController.filteredSupports.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return SupportTile(supportController.filteredSupports[index]);
                  },
                ),
              ).marginSymmetric(vertical: 12)
            ],
          ).marginSymmetric(horizontal: 20, vertical: 10),
        );
      },),
    );
  }
}

class SupportTile extends StatefulWidget {
  final SupportModel supportModel;
  const SupportTile(this.supportModel,{super.key});

  @override
  State<SupportTile> createState() => _SupportTileState();
}

class _SupportTileState extends State<SupportTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Full Name",style: TextStyle(color: rHint.withOpacity(0.8),fontSize: 12),),
                          Text(
                            "${widget.supportModel.fullName}",
                            style: TextStyle(color: rWhite.withOpacity(0.8), fontSize: 14),
                          ).marginOnly(top: 4),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",style: TextStyle(color: rHint.withOpacity(0.8),fontSize: 12),),
                          Text(
                            "${widget.supportModel.email}",
                            style: TextStyle(color: rWhite.withOpacity(0.8), fontSize: 14),
                          ).marginOnly(top: 4),
                        ],
                      ).marginOnly(left: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date",style: TextStyle(color: rHint.withOpacity(0.8),fontSize: 12),),
                          Text(
                            "${DateFormat('dd-MM-yyyy').format(widget.supportModel.createdAt)}",
                            style: TextStyle(color: rWhite.withOpacity(0.8), fontSize: 14),
                          ).marginOnly(top: 4),
                        ],
                      ).marginOnly(left: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Time",style: TextStyle(color: rHint.withOpacity(0.8),fontSize: 12),),
                          Text(
                            "${DateFormat('hh:mm a').format(widget.supportModel.createdAt)}",
                            style: TextStyle(color: rWhite.withOpacity(0.8), fontSize: 14),
                          ).marginOnly(top: 4),
                        ],
                      ).marginOnly(left: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID",style: TextStyle(color: rHint.withOpacity(0.8),fontSize: 12),),
                          Text(
                            "${widget.supportModel.id}",
                            style: TextStyle(color: rWhite.withOpacity(0.8), fontSize: 14),
                          ).marginOnly(top: 4),
                        ],
                      ).marginOnly(left: 30),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Message",
                        style: TextStyle(color: rHint.withOpacity(0.8), fontSize: 12),
                      ),
                      Text(
                        "${widget.supportModel.message}",
                        style: TextStyle(color: rWhite.withOpacity(0.8), fontSize: 14),
                      ).marginOnly(top: 4),
                    ],
                  ).marginOnly(top: 20),
                ],
              ),
            ),
          ],
        ),
      ],
    ).marginSymmetric(horizontal: 20,vertical: 20);
  }
}
