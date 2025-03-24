import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/constants/firebaseRef.dart';
import 'package:pingcoin_admin/views/tabs/business/businessEdit.dart';
import 'package:pingcoin_admin/views/tabs/businessDevelopmentTab.dart';

import '../../../constants/colors.dart';
import '../../../constants/colors.dart';
import '../../../controllers/adController.dart';
import '../../../models/businessModel.dart';
import '../../../widgets/topBar.dart';

class BusinessDetail extends StatefulWidget {
  var callBack;
  BusinessDevelopmentModel businessDevelopmentModel;

  BusinessDetail({super.key, required this.callBack, required this.businessDevelopmentModel});

  @override
  State<BusinessDetail> createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  String getConcatenatedNames() {
    Map<String, String> modelMap = {for (var item in Get.find<AdController>().adInterests) item.id: item.name};

    List<String> names = widget.businessDevelopmentModel.interestIds.map((id) => modelMap[id] ?? "").toList();

    return names.join(", ");
  }

  String _selectedOption = 'Option 1';


  @override
  void initState() {
    setState(() {
      _selectedOption=widget.businessDevelopmentModel.paymentStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(title: "Business development"),
            Text(
              "Business Details",
              style: TextStyle(color: rWhite, fontSize: 20),
            ).marginOnly(top: 20),
            Row(
              children: [
                InkWell(
                  onTap: () => widget.callBack(BusinessDevelopmentTab(callBack: widget.callBack)),
                  child: Text(
                    "Business development / ",
                    style: TextStyle(color: rGreen),
                  ),
                ),
                Text(
                  "details",
                  style: TextStyle(color: rWhite),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: rBg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //left side
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Personal Details",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff707070), fontSize: 18),
                            ),
                            Text(
                              "",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xffFF9E00), fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ID",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              "${widget.businessDevelopmentModel.id}",
                              style: TextStyle(fontWeight: FontWeight.normal, color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Full Name",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              "${widget.businessDevelopmentModel.fullName}",
                              style: TextStyle(fontWeight: FontWeight.normal, color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              "${widget.businessDevelopmentModel.email}",
                              style: TextStyle(fontWeight: FontWeight.normal, color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phone no",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
                              "${widget.businessDevelopmentModel.phoneNumber}",
                              style: TextStyle(fontWeight: FontWeight.normal, color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff707070), fontSize: 14),
                            ),
                            Text(
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
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Row(
                          children: [
                            Text(
                              "Specific Code: ",
                              style: TextStyle(color: Color(0xff888888), fontSize: 14),
                            ),
                            Text(
                              "${widget.businessDevelopmentModel.specificCode}",
                              style: TextStyle(color: rWhite, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment:",
                              style: TextStyle(color: Color(0xff888888), fontSize: 14),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Inprocess',
                                  groupValue: _selectedOption,
                                  activeColor: Color(0xff3A93CE),
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Color(0xff3A93CE);
                                      }
                                      return rHint;
                                    },
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value!;
                                    });
                                    businessesRef.doc(widget.businessDevelopmentModel.id).update({"paymentStatus":"${_selectedOption}"});
                                  },
                                ),
                                Text(
                                  'Inprocess',
                                  style: TextStyle(
                                    color: _selectedOption == 'Inprocess'
                                        ? Color(0xff3A93CE)
                                        : rHint,
                                  ),
                                ),

                                const SizedBox(width: 10), // Spacing between options

                                // Second radio button
                                Radio<String>(
                                  value: 'Paid',
                                  groupValue: _selectedOption,
                                  activeColor: rGreen,
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return rGreen;
                                      }
                                      return rHint;
                                    },
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value!;
                                    });
                                    businessesRef.doc(widget.businessDevelopmentModel.id).update({"paymentStatus":"${_selectedOption}"});
                                  },
                                ),
                                Text(
                                  'Paid',
                                  style: TextStyle(
                                    color: _selectedOption == 'Paid'
                                        ? rGreen
                                        : rHint,
                                  ),
                                ),

                                const SizedBox(width: 10), // Spacing between options

                                // Third radio button
                                Radio<String>(
                                  value: 'UnPaid',
                                  groupValue: _selectedOption,
                                  activeColor: rRed,
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return rRed;
                                      }
                                      return rHint;
                                    },
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value!;
                                    });
                                    businessesRef.doc(widget.businessDevelopmentModel.id).update({"paymentStatus":"${_selectedOption}"});
                                  },
                                ),
                                Text(
                                  'UnPaid',
                                  style: TextStyle(
                                    color: _selectedOption == 'UnPaid'
                                        ? rRed
                                        : rHint,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ).marginOnly(top: 12),

                        Text(
                          "Note:",
                          style: TextStyle(color: Color(0xff888888), fontSize: 14),
                        ).marginOnly(top: 12),
                        TextFormField(
                          cursorColor: rGreen,
                          keyboardType: TextInputType.text,
                          initialValue: widget.businessDevelopmentModel.note,
                          maxLines: 4,
                          onChanged: (value){
                            businessesRef.doc(widget.businessDevelopmentModel.id).update({"note":value});
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Write personal note',
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => widget.callBack(BusinessEdit(
                                callBack: widget.callBack,
                                businessDevelopmentModel: widget.businessDevelopmentModel,
                              )),
                              child: Container(
                                width: 110,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Color(0xff929599)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Color(0xff929599)),
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xffFF9E00)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Pause",
                                style: TextStyle(color: Color(0xffFF9E00)),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: rGreen),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Complete",
                                style: TextStyle(color: rGreen),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xffFF6666)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Color(0xffFF6666)),
                              ),
                            ),
                          ],
                        ).marginOnly(top: 200, bottom: 30)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  // right side
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Business Details",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff707070), fontSize: 18),
                            ),
                            Text(
                              "",
                              style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xffFF9E00), fontSize: 14),
                            ),
                          ],
                        ),
                        Image.network(
                          "${widget.businessDevelopmentModel.image}",
                          width: 350,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Interest",
                              style: TextStyle(color: Color(0xff888888), fontSize: 14),
                            ),
                            Text(
                              getConcatenatedNames(),
                              style: TextStyle(color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Link",
                              style: TextStyle(color: Color(0xff888888), fontSize: 14),
                            ),
                            Text(
                              "${widget.businessDevelopmentModel.link}",
                              style: TextStyle(color: Color(0xff3A93CE), fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Timeline",
                              style: TextStyle(color: Color(0xff888888), fontSize: 14),
                            ),
                            Text(
                              "${DateFormat("h a").format(widget.businessDevelopmentModel.starTime)} - ${DateFormat("h a").format(widget.businessDevelopmentModel.endTime)}   /   ${DateFormat("MMM dd, yyyy").format(widget.businessDevelopmentModel.starTime)} - ${DateFormat("MMM dd, yyyy").format(widget.businessDevelopmentModel.endTime)}",
                              style: TextStyle(color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Message",
                              style: TextStyle(color: Color(0xff888888), fontSize: 14),
                            ),
                            Text(
                              "${widget.businessDevelopmentModel.description}",
                              style: TextStyle(color: rWhite, fontSize: 14),
                            ),
                          ],
                        ).marginOnly(top: 12),
                      ],
                    ),
                  )
                ],
              ).marginAll(12),
            ).marginOnly(top: 12)
          ],
        ).marginSymmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}
