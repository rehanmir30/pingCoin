import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/controllers/userController.dart';
import 'package:pingcoin_admin/views/tabs/userInsights/viewUserProfile.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

import '../../constants/colors.dart';
import '../../models/userModel.dart';

class UsersTab extends StatefulWidget {
  var callBack;

  UsersTab({super.key, required this.callBack});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  void initState() {
    Get.find<UserController>().searchFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: SingleChildScrollView(
        child: GetBuilder<UserController>(
          builder: (userController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(title: "Users"),
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
                              decoration: BoxDecoration(color: rYellow, shape: BoxShape.circle),
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
                                  tween: IntTween(begin: 0, end: userController.allUsers.length),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Total Users",
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
                              decoration: BoxDecoration(color: Color(0xff008A3F), shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/users.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: userController.categorizedUsers["Active"]?.length ?? 0),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Active Users",
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
                                  tween: IntTween(begin: 0, end: userController.categorizedUsers["Blocked"]?.length ?? 0),
                                  duration: Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Text(
                                      _formatNumber(value),
                                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 30),
                                    );
                                  },
                                ),
                                Text(
                                  "Blocked Users",
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
                      child: Container(),
                    ),
                  ],
                ).marginOnly(top: 12),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Users",
                      style: TextStyle(color: rWhite, fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextFormField(
                        cursorColor: rGreen,
                        controller: userController.searchController,
                        onChanged: (value) {
                          userController.searchFilter();
                        },
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
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: rBlack,
                        ),
                        child: DropdownButtonFormField<String>(
                          value: userController.selectedStatus,
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
                          items: userController.filterStatuses.map((String validate) {
                            return DropdownMenuItem<String>(
                              value: validate,
                              child: Text(validate, style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            userController.setFilterStatus(newValue!);
                            userController.searchFilter();
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
                          userController.setFilterDate(await showDatePicker(
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
                          userController.searchFilter();
                        },
                        controller: userController.filterDateController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Last Login',
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
                      visible: userController.selectedStatus != null || userController.selectedDate != null ? true : false,
                      child: InkWell(
                          onTap: () {
                            userController.searchController.text = '';
                            userController.setFilterStatus(null);
                            userController.setFilterDate(null);
                            userController.searchFilter();
                          },
                          child: Icon(
                            Icons.close,
                            color: rRed,
                          )).marginOnly(left: 12),
                    )
                  ],
                ),
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
                          itemCount: userController.filteredUsers.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return UserTile(
                              userModel: userController.filteredUsers[index],
                              callBack: widget.callBack,
                            );
                          }),
                    ],
                  ),
                )
              ],
            ).marginSymmetric(horizontal: 20, vertical: 10);
          },
        ),
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
            child: Text(
          "Name",
          style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
        )),
        Expanded(
            child: Text(
          "Email",
          style: TextStyle(color: rHint, fontWeight: FontWeight.bold),
        )),
        Expanded(
            child: Text(
          "Status",
          style: TextStyle(color: rHint, fontWeight: FontWeight.w600),
        )),
        Expanded(
            child: Text(
          "Last Login",
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

class UserTile extends StatefulWidget {
  var callBack;
  final UserModel userModel;

  UserTile({super.key, required this.userModel, required this.callBack});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
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
          "${widget.userModel.id.substring(0, 5)}...",
          style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
        )),
        Expanded(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff744802)),
              alignment: Alignment.center,
              child: Text(
                _getInitials(widget.userModel.fullName),
                style: TextStyle(color: rWhite, fontSize: 16),
              ),
            ),
            Text(
              "${widget.userModel.fullName}",
              style: TextStyle(color: rWhite, fontSize: 14),
            ).marginOnly(left: 5)
          ],
        )),
        Expanded(
            child: Text(
          "${widget.userModel.email}",
          style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
        )),
        Expanded(
            child: Text(
          "${widget.userModel.status}",
          style: TextStyle(color: widget.userModel.status == "Active" ? rGreen : Colors.red, fontWeight: FontWeight.normal),
        )),
        Expanded(
            child: Text(
          "${DateFormat('dd-MM-yyyy').format(widget.userModel.updatedAt)}",
          style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
        )),
        Expanded(
            child: InkWell(
                onTap: () => widget.callBack(ViewUserProfile(
                      callBack: widget.callBack,
                      userModel: widget.userModel,
                    )),
                child: Align(alignment: Alignment.centerLeft, child: SvgPicture.asset("assets/svgs/eye.svg")))),
      ],
    ).marginSymmetric(horizontal: 12, vertical: 10);
  }
}
