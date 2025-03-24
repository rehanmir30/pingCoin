import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/controllers/businessController.dart';
import 'package:pingcoin_admin/views/tabs/business/businessDetail.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

import '../../constants/colors.dart';
import '../../models/businessModel.dart';

class BusinessDevelopmentTab extends StatefulWidget {
  var callBack;

  BusinessDevelopmentTab({super.key, required this.callBack});

  @override
  State<BusinessDevelopmentTab> createState() => _BusinessDevelopmentTabState();
}

class _BusinessDevelopmentTabState extends State<BusinessDevelopmentTab> {

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  void initState() {
    Get.find<BusinessController>().searchFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: GetBuilder<BusinessController>(
        builder: (businessController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                TopBar(title: "Business Development"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 125,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: rBg),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: Color(0xff3A93CE), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/users.svg",
                                color: rWhite,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: businessController.allBusinesses.length),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Total Ads",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.normal, fontSize: 16),
                                ),
                              ],
                            ).marginOnly(left: 12)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 125,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: rBg),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: Color(0xff30B14B), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/blockedUsers.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: businessController.categorizedBusiness["Active"]?.length ?? 0),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Active",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.normal, fontSize: 16),
                                ),
                              ],
                            ).marginOnly(left: 12)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 125,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: rBg),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: Color(0xffB0710B), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/blockedUsers.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: businessController.categorizedBusiness["Pause"]?.length ?? 0),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Pause",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.normal, fontSize: 16),
                                ),
                              ],
                            ).marginOnly(left: 12)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 125,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: rBg),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: Color(0xff83AC61), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/blockedUsers.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: businessController.categorizedBusiness["Completed"]?.length ?? 0),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Completed",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.normal, fontSize: 16),
                                ),
                              ],
                            ).marginOnly(left: 12)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 125,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: rBg),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: rRed, shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/blockedUsers.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: businessController.categorizedBusiness["Cancelled"]?.length ?? 0),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Cancelled",
                                  style: TextStyle(color: rWhite, fontWeight: FontWeight.normal, fontSize: 16),
                                ),
                              ],
                            ).marginOnly(left: 12)
                          ],
                        ),
                      ),
                    ),
                  ],
                ).marginOnly(top: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Business Development Ad",
                      style: TextStyle(color: rWhite, fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ],
                ).marginOnly(top: 12),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextFormField(
                        cursorColor: rGreen,
                        controller: businessController.searchController,
                        onChanged: (value) {
                          businessController.searchFilter();
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: rHint,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: rHint,
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
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: rBlack,
                        ),
                        child: DropdownButtonFormField<String>(
                          value: businessController.selectedStatus,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Status',
                            suffixIcon: Icon(Icons.keyboard_arrow_down, color: rHint),
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
                          items: businessController.filterStatuses.map((String validate) {
                            return DropdownMenuItem<String>(
                              value: validate,
                              child: Text(validate, style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            businessController.setFilterStatus(newValue!);
                            businessController.searchFilter();
                          },
                        ),
                      ),
                    ).marginOnly(left: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: TextFormField(
                        cursorColor: rGreen,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        onTap: () async {
                          DateTime initialDate = DateTime.now();
                          businessController.setFilterDate(await showDatePicker(
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
                          businessController.searchFilter();
                        },
                        controller: businessController.filterDateController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Timeline',
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
                      visible: businessController.selectedStatus != null || businessController.selectedDate != null ? true : false,
                      child: InkWell(
                          onTap: () {
                            businessController.searchController.text = '';
                            businessController.setFilterStatus(null);
                            businessController.setFilterDate(null);
                            businessController.searchFilter();
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: rBg),
                  child: Column(
                    children: [
                      TableHeader(),
                      ListView.builder(
                          itemCount: businessController.filteredBusinesses.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return BusinessTile(
                              callBack: widget.callBack,
                              businessDevelopmentModel: businessController.filteredBusinesses[index],
                            );
                          }),
                    ],
                  ),
                ).marginOnly(top: 12)
              ],
            ).marginSymmetric(horizontal: 20, vertical: 10),
          );
        },
      ),
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
            flex: 2,
            child: Text(
              "Name",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            flex: 2,
            child: Text(
              "Link",
              style: TextStyle(color: rHint, fontWeight: FontWeight.bold),
            )),
        Expanded(
            child: Text(
          "Status",
          style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
        )),
        Expanded(
            flex: 2,
            child: Text(
              "Timeline",
              style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
            )),
        Expanded(
            child: Text(
          "Specific Code",
          style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
        )),
        Expanded(
            child: Text(
          "Action",
          style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
        )),
      ],
    ).marginSymmetric(horizontal: 12, vertical: 10),
  );
}

class BusinessTile extends StatefulWidget {
  var callBack;
  BusinessDevelopmentModel businessDevelopmentModel;

  BusinessTile({super.key, required this.callBack, required this.businessDevelopmentModel});

  @override
  State<BusinessTile> createState() => _BusinessTileState();
}

class _BusinessTileState extends State<BusinessTile> {
  String _getInitials(String fullName) {
    List<String> nameParts = fullName.trim().split(' ');

    if (nameParts.length == 1) {
      return nameParts[0][0].toUpperCase(); // First letter of single name
    } else {
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase(); // First letter of first and second name
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          "${widget.businessDevelopmentModel.id.substring(0, 5)}...",
          style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
        )),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff744802)),
                  alignment: Alignment.center,
                  child: Text(
                    _getInitials(widget.businessDevelopmentModel.fullName),
                    style: TextStyle(color: rWhite, fontSize: 16),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.businessDevelopmentModel.fullName}",
                      style: TextStyle(color: rWhite, fontSize: 14),
                    ).marginOnly(left: 5),
                    Text(
                      "${widget.businessDevelopmentModel.email}",
                      style: TextStyle(color: rHint, fontSize: 12),
                    ).marginOnly(left: 5)
                  ],
                )
              ],
            )),
        Expanded(
            flex: 2,
            child: Text(
              "${widget.businessDevelopmentModel.email}",
              style: TextStyle(color: Color(0xff3A93CE), fontWeight: FontWeight.normal),
            )),
        Expanded(
            child: Text(
          "${widget.businessDevelopmentModel.status}",
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: widget.businessDevelopmentModel.status == "Active"
                  ? rGreen
                  : widget.businessDevelopmentModel.status == "Pause"
                      ? Color(0xffFF9E00)
                      : widget.businessDevelopmentModel.status == "Completed"
                          ? rLightGreen
                          : rRed,
              fontSize: 14),
        )),
        Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${DateFormat("MMM dd, yyyy").format(widget.businessDevelopmentModel.starTime)} - ${DateFormat("MMM dd, yyyy").format(widget.businessDevelopmentModel.endTime)}",
                  style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
                ),
                Text(
                  "${DateFormat("h a").format(widget.businessDevelopmentModel.starTime)} - ${DateFormat("h a").format(widget.businessDevelopmentModel.endTime)}",
                  style: TextStyle(color: rHint, fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            )),
        Expanded(
            child: Text(
          "${widget.businessDevelopmentModel.specificCode}",
          style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
        )),
        Expanded(
            child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () => widget.callBack(BusinessDetail(
                          callBack: widget.callBack,
                          businessDevelopmentModel: widget.businessDevelopmentModel,
                        )),
                    child: SvgPicture.asset("assets/svgs/eye.svg")))),
      ],
    ).marginSymmetric(horizontal: 12, vertical: 10);
  }
}
