import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pingcoin_admin/views/tabs/business/businessDetail.dart';
import 'dart:html' as html;
import '../../../constants/colors.dart';
import '../../../controllers/adController.dart';
import '../../../models/businessModel.dart';
import '../../../models/adInterestModel.dart';
import '../../../widgets/customLoading.dart';
import '../../../widgets/customSnackbar.dart';
import '../../../widgets/topBar.dart';
import '../ad/createAd.dart';
import '../businessDevelopmentTab.dart';

class BusinessEdit extends StatefulWidget {
  var callBack;
  BusinessDevelopmentModel businessDevelopmentModel;

  BusinessEdit({super.key, required this.businessDevelopmentModel, required this.callBack});

  @override
  State<BusinessEdit> createState() => _BusinessEditState();
}

class _BusinessEditState extends State<BusinessEdit> {
  List<AdInterestModel> selectedItems = [];
  TextEditingController adLinkController = TextEditingController();

  html.File? adBanner;
  String? adBannerUrl;

  void pickImage() {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      if (input.files!.isNotEmpty) {
        final file = input.files!.first;
        final objectUrl = html.Url.createObjectUrl(file);
        setState(() {
          adBanner = file;
          adBannerUrl = objectUrl;
        });
      }
    });
  }

  bool _isTimeBeforeOrEqual(TimeOfDay time1, TimeOfDay time2) {
    return time1.hour < time2.hour ||
        (time1.hour == time2.hour && time1.minute <= time2.minute);
  }

  @override
  void initState() {
    adLinkController.text = widget.businessDevelopmentModel.link;
    for (var id in widget.businessDevelopmentModel.interestIds) {
      selectedItems.add(Get
          .find<AdController>()
          .adInterests
          .firstWhere((element) => element.id == id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: GetBuilder<AdController>(builder: (adController) {
        return Stack(
          children: [
            SingleChildScrollView(
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
                      InkWell(
                        onTap: () =>
                            widget.callBack(BusinessDetail(callBack: widget.callBack,
                              businessDevelopmentModel: widget.businessDevelopmentModel,)),
                        child: Text(
                          "details / ",
                          style: TextStyle(color: rGreen),
                        ),
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(color: rWhite),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Timeline", style: TextStyle(color: rWhite, fontSize: 14),),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.12,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: TextEditingController(
                                      text: "${DateFormat("h a").format(widget.businessDevelopmentModel.starTime)}"
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    suffixIcon: Icon(Icons.access_time, color: rHint),
                                    hintStyle: TextStyle(
                                      color: rHint,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff4C4C4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff4C4C4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 16.0,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  onTap: () async {
                                    TimeOfDay initialTime = TimeOfDay.fromDateTime(widget.businessDevelopmentModel.starTime);

                                    // Show time picker
                                    TimeOfDay? selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: initialTime,
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
                                    );

                                    if (selectedTime != null) {
                                      // Create a new DateTime with the selected time components but original date
                                      DateTime newStartDateTime = DateTime(
                                        widget.businessDevelopmentModel.starTime.year,
                                        widget.businessDevelopmentModel.starTime.month,
                                        widget.businessDevelopmentModel.starTime.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );
                                      bool isValidTime = newStartDateTime.isBefore(widget.businessDevelopmentModel.endTime) ||
                                          newStartDateTime.isAtSameMomentAs(widget.businessDevelopmentModel.endTime);

                                      if (isValidTime) {
                                        setState(() {
                                          widget.businessDevelopmentModel.starTime = newStartDateTime;
                                        });

                                        // Need to update the controller after state update
                                        final controller = TextEditingController(
                                            text: "${DateFormat("h a").format(newStartDateTime)}"
                                        );
                                        // This ensures the field is updated
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          setState(() {});
                                        });
                                      } else {
                                        CustomSnackbar.show("Error", "Start time cannot be later than end time", isSuccess: false);
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.12,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: TextEditingController(
                                      text: "${DateFormat("h a").format(widget.businessDevelopmentModel.endTime)}"
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    suffixIcon: Icon(Icons.access_time, color: rHint),
                                    hintStyle: TextStyle(
                                      color: rHint,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff4C4C4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff4C4C4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 16.0,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  onTap: () async {
                                    TimeOfDay initialTime = TimeOfDay.fromDateTime(widget.businessDevelopmentModel.endTime);

                                    // Show time picker
                                    TimeOfDay? selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: initialTime,
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
                                    );

                                    if (selectedTime != null) {
                                      // Create a new DateTime with the selected time components but original date
                                      DateTime newEndDateTime = DateTime(
                                        widget.businessDevelopmentModel.endTime.year,
                                        widget.businessDevelopmentModel.endTime.month,
                                        widget.businessDevelopmentModel.endTime.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );

                                      // For end time, check if it's after or equal to start time
                                      bool isValidTime = widget.businessDevelopmentModel.starTime.isBefore(newEndDateTime) ||
                                          widget.businessDevelopmentModel.starTime.isAtSameMomentAs(newEndDateTime);

                                      if (isValidTime) {
                                        setState(() {
                                          widget.businessDevelopmentModel.endTime = newEndDateTime;
                                        });

                                        // Need to update the controller after state update
                                        final controller = TextEditingController(
                                            text: "${DateFormat("h a").format(newEndDateTime)}"
                                        );
                                        // This ensures the field is updated
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          setState(() {});
                                        });
                                      } else {
                                        CustomSnackbar.show("Error", "End time cannot be earlier than start time", isSuccess: false);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.12,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: TextEditingController(
                                      text: "${DateFormat('dd, MM, yyyy').format(widget.businessDevelopmentModel.starTime)}"
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    suffixIcon: SvgPicture.asset(
                                      "assets/svgs/calendar.svg",
                                      color: rHint,
                                    ).marginAll(6),
                                    hintStyle: TextStyle(
                                      color: rHint,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff4C4C4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff4C4C4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 16.0,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  onTap: () async {
                                    // Get the current date from the model
                                    DateTime initialDate = widget.businessDevelopmentModel.starTime;

                                    // Show date picker
                                    DateTime? selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                                      // One year ago
                                      lastDate: DateTime.now().add(Duration(days: 365)),
                                      // One year in future
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
                                    );

                                    if (selectedDate != null) {
                                      // Create a new DateTime with the selected date components but original time
                                      DateTime newStartDateTime = DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        widget.businessDevelopmentModel.starTime.hour,
                                        widget.businessDevelopmentModel.starTime.minute,
                                      );

                                      // Check if the new date is valid (e.g., not after endTime)
                                      bool isValidDate = true;

                                      // If there's an end time constraint, check if the new date is valid
                                      if (widget.businessDevelopmentModel.endTime != null) {
                                        // Create a new end datetime that preserves the original hour and minute
                                        DateTime endDateTime = widget.businessDevelopmentModel.endTime;

                                        // Check if the new start date+time is before or equal to end date+time
                                        isValidDate = newStartDateTime.isBefore(endDateTime) ||
                                            newStartDateTime.isAtSameMomentAs(endDateTime);
                                      }

                                      if (isValidDate) {
                                        setState(() {
                                          widget.businessDevelopmentModel.starTime = newStartDateTime;
                                        });

                                        // Update the controller after state update
                                        final controller = TextEditingController(
                                            text: "${DateFormat('dd, MM, yyyy').format(newStartDateTime)}"
                                        );

                                        // This ensures the field is updated
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          setState(() {});
                                        });
                                      } else {
                                        // Show error message
                                        CustomSnackbar.show("Error", "Start date cannot be later than end date", isSuccess: false);
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.12,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: TextEditingController(
                                      text: "${DateFormat('dd, MM, yyyy').format(widget.businessDevelopmentModel.endTime)}"
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    suffixIcon: SvgPicture.asset(
                                      "assets/svgs/calendar.svg",
                                      color: rHint,
                                    ).marginAll(6),
                                    hintStyle: TextStyle(
                                      color: rHint,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff4C4C4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff4C4C4C),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 16.0,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  onTap: () async {
                                    // Get the current date from the model
                                    DateTime initialDate = widget.businessDevelopmentModel.endTime;

                                    // Show date picker
                                    DateTime? selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                                      // One year ago
                                      lastDate: DateTime.now().add(Duration(days: 365)),
                                      // One year in future
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
                                    );

                                    // If a date was selected, update the field
                                    if (selectedDate != null) {
                                      // Create a new DateTime with the selected date components but original time
                                      DateTime newEndDateTime = DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        widget.businessDevelopmentModel.endTime.hour,
                                        widget.businessDevelopmentModel.endTime.minute,
                                      );

                                      // Check if the new date is valid (e.g., not before startTime)
                                      DateTime startDateTime = widget.businessDevelopmentModel.starTime;

                                      // Check if the new end date+time is after or equal to start date+time
                                      bool isValidDate = startDateTime.isBefore(newEndDateTime) ||
                                          startDateTime.isAtSameMomentAs(newEndDateTime);

                                      if (isValidDate) {
                                        setState(() {
                                          widget.businessDevelopmentModel.endTime = newEndDateTime;
                                        });

                                        // Update the controller after state update
                                        final controller = TextEditingController(
                                            text: "${DateFormat('dd, MM, yyyy').format(newEndDateTime)}"
                                        );

                                        // This ensures the field is updated
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          setState(() {});
                                        });
                                      } else {
                                        // Show error message
                                        CustomSnackbar.show("Error", "End date cannot be earlier than start date", isSuccess: false);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ).marginOnly(top: 12),
                        ),

                        //add interest button
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          height: 24,
                          child: TextFormField(
                            cursorColor: rGreen,
                            keyboardType: TextInputType.url,
                            initialValue: "Interest",
                            readOnly: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                suffixIcon: InkWell(
                                    onTap: () {
                                      showAddInterestPopup();
                                    },
                                    child: SvgPicture.asset("assets/svgs/addGreen.svg")),
                                hintStyle: TextStyle(
                                  color: rHint,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                contentPadding: EdgeInsets.zero),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ).marginOnly(top: 20),

                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: rBlack,
                            ),
                            child: DropdownButtonFormField<AdInterestModel>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: selectedItems.isEmpty ? 'Select' : selectedItems.map((item) => item.name).join(', '),
                                suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              ),
                              icon: SizedBox.shrink(),
                              items: adController.adInterests.map((AdInterestModel item) {
                                return DropdownMenuItem<AdInterestModel>(
                                  value: item,
                                  enabled: false,
                                  child: StatefulBuilder(
                                    builder: (context, menuSetState) {
                                      final isSelected = selectedItems.contains(item);
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected ? selectedItems.remove(item) : selectedItems.add(item);
                                          });
                                          menuSetState(() {});
                                        },
                                        child: SizedBox(
                                          height: 40,
                                          child: Row(
                                            children: [
                                              Icon(
                                                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                                                color: isSelected ? Colors.green : Colors.grey,
                                              ),
                                              const SizedBox(width: 16),
                                              Text(
                                                item.name,
                                                style: TextStyle(fontSize: 14, color: rWhite),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ).marginOnly(top: 8),

                        Text("Link", style: TextStyle(color: rWhite, fontSize: 14),).marginOnly(top: 20),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          child: TextFormField(
                            cursorColor: rGreen,
                            keyboardType: TextInputType.url,
                            controller: adLinkController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff282828),
                              hintStyle: TextStyle(
                                color: rHint,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff4C4C4C),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff4C4C4C),
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

                        Text(
                          "Upload ad banner",
                          style: TextStyle(color: rWhite, fontSize: 14),
                        ).marginOnly(top: 20),

                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            pickImage();
                          },
                          child: Container(
                            width: 350,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                adBannerUrl != null ? adBannerUrl! : widget.businessDevelopmentModel.image,
                                fit: BoxFit.fill,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () async {
                            if (selectedItems.isEmpty || adLinkController.text.isEmpty) {
                              CustomSnackbar.show("Error", "All fields are required", isSuccess: false);
                            } else {
                              BusinessDevelopmentModel businessDevelopmentModel = BusinessDevelopmentModel(id: widget.businessDevelopmentModel.id,
                                  status: widget.businessDevelopmentModel.status,
                                  fullName: widget.businessDevelopmentModel.fullName,
                                  email: widget.businessDevelopmentModel.email,
                                  phoneNumber: widget.businessDevelopmentModel.phoneNumber,
                                  link: adLinkController.text,
                                  specificCode: widget.businessDevelopmentModel.specificCode,
                                  interestIds: [],
                                  paymentStatus: widget.businessDevelopmentModel.paymentStatus,
                                  note: widget.businessDevelopmentModel.note,
                                  image: widget.businessDevelopmentModel.image,
                                  description: widget.businessDevelopmentModel.description,
                                  starTime: widget.businessDevelopmentModel.starTime,
                                  endTime: widget.businessDevelopmentModel.endTime);
                              for (var item in selectedItems) {
                                businessDevelopmentModel.interestIds.add(item.id);
                              }
                              await adController.editBusiniess(businessDevelopmentModel, adBanner);
                            }
                          },
                          child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              color: rGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text("Update", style: TextStyle(color: rWhite),).marginSymmetric(vertical: 8),
                          ).marginOnly(top: 20),
                        )
                      ],
                    ),
                  )
                ],
              ).marginSymmetric(horizontal: 20, vertical: 10),
            ),
            Visibility(
                visible: adController.isLoading,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: rWhite.withOpacity(0.2),
                    child: CustomLoading()))
          ],
        );
      },),
    );
  }

  showAddInterestPopup() {
    String interestName = '';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ElasticIn(
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: rBg,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add New Interest",
                      style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: rWhite), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.close,
                          color: rWhite,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                content: GetBuilder<AdController>(
                  builder: (adController) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(color: rWhite, fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.2,
                              child: TextFormField(
                                cursorColor: rGreen,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  interestName = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xff282828),
                                  hintText: 'Enter ad name',
                                  hintStyle: TextStyle(
                                    color: rHint,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff4C4C4C),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff4C4C4C),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 16.0,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (interestName == "") {
                                  CustomSnackbar.show("Error", "Interest name is required", isSuccess: false);
                                  return;
                                } else {
                                  adController.createNewInterest(interestName);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(color: rGreen, borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add",
                                  style: TextStyle(color: rWhite),
                                ).marginSymmetric(horizontal: 20, vertical: 12),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Recent",
                          style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold),
                        ).marginOnly(top: 12),
                        Container(
                          height: 200,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          child: ListView.builder(
                            itemCount: adController.adInterests.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return AdInterestTile(adInterestModel: Get
                                  .find<AdController>()
                                  .adInterests[index]);
                            },
                          ),
                        ).marginOnly(top: 20),
                      ],
                    );
                  },
                ),
                actionsAlignment: MainAxisAlignment.center,
              );
            },
          ),
        );
      },
    );
  }
}
