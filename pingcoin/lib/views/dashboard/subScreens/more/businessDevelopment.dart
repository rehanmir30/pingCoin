import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pingcoin/controllers/authController.dart';
import 'package:pingcoin/models/businessModel.dart';

import '../../../../animations/fadeInAnimationTTB.dart';
import '../../../../constants/colors.dart';
import '../../../../models/adInterestModel.dart';
import '../../../../widgets/customButton.dart';
import '../../../../widgets/customLoading.dart';
import '../../../../widgets/customSnackbar.dart';

class BusinessDevelopment extends StatefulWidget {
  const BusinessDevelopment({super.key});

  @override
  State<BusinessDevelopment> createState() => _BusinessDevelopmentState();
}

class _BusinessDevelopmentState extends State<BusinessDevelopment> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController startTimeController = TextEditingController(text: "${DateFormat("h a").format(DateTime.now())}");
  TextEditingController startDateController = TextEditingController(text: "${DateFormat('dd, MM, yyyy').format(DateTime.now())}");
  TextEditingController endTimeController = TextEditingController(text: "${DateFormat("h a").format(DateTime.now())}");
  TextEditingController endDateController = TextEditingController(text: "${DateFormat('dd, MM, yyyy').format(DateTime.now())}");
  List<AdInterestModel> selectedItems = [];
  String selectedCountryCode = "+1";
  File? bannerImage;

  var formKey = GlobalKey<FormState>();

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: GetBuilder<AuthController>(
        builder: (authcontroller) {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: rWhite,
                                )),
                            SvgPicture.asset(
                              "assets/svgs/logo.svg",
                              width: 40,
                              height: 40,
                            ).marginOnly(left: 12),
                            SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset(
                              "assets/svgs/logoTextSmall.svg",
                            ),
                          ],
                        ),
                        Text(
                          "Business Development",
                          style: TextStyle(color: rWhite, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "font2"),
                        ).marginSymmetric(horizontal: 12).marginOnly(top: 20),

                        Text(
                          "Personal Details",
                          style: TextStyle(color: rHint, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "font2"),
                        ).marginOnly(top: 20),
                        SizedBox(
                          height: 20,
                        ),

                        //name
                        Text(
                          "Full Name",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        FadeInAnimationTTB(
                          delay: 1,
                          child: TextFormField(
                            cursorColor: rGreen,
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            validator: (name) {
                              if (name == null || name.isEmpty) {
                                return "Name is required";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Enter your Full name',
                              hintStyle: TextStyle(
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
                          ).marginOnly(top: 8),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //email
                        Text(
                          "Email",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        FadeInAnimationTTB(
                          delay: 1,
                          child: TextFormField(
                            cursorColor: rGreen,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return "Email is required";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(
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
                          ).marginOnly(top: 8),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //phone number
                        Text(
                          "Phone No",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CountryCodeDropdown(
                              onCountrySelected: (code) {
                                selectedCountryCode = code;
                                print("Selected Country Code: $code");
                              },
                            ).marginOnly(top: 3),
                            SizedBox(width: 4),
                            Expanded(
                              child: FadeInAnimationTTB(
                                delay: 1,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  validator: (phone) {
                                    if (phone == null || phone.isEmpty) {
                                      return "Phone number is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: 'Enter your phone no',
                                    hintStyle: TextStyle(
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
                                ).marginOnly(top: 8),
                              ),
                            ),
                          ],
                        ),

                        Text(
                          "Business Details",
                          style: TextStyle(color: rHint, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "font2"),
                        ).marginOnly(top: 20),

                        SizedBox(
                          height: 20,
                        ),

                        //Ad Banner
                        Text(
                          "Ad Banner",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        InkWell(
                          onTap: () async {
                            bannerImage = await pickImage();
                            setState(() {
                              bannerImage;
                            });
                          },
                          child: bannerImage == null
                              ? DottedBorder(
                                  color: rHint,
                                  radius: Radius.circular(8),
                                  borderType: BorderType.RRect,
                                  dashPattern: [8, 4],
                                  child: Container(
                                    width: 350,
                                    height: 150,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset("assets/svgs/upload.svg"),
                                        Text(
                                          "Upload ad banner",
                                          style: TextStyle(color: rHint),
                                        ).marginOnly(top: 12),
                                        Text(
                                          "Size: 350 * 150",
                                          style: TextStyle(color: rHint, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )).marginOnly(top: 8)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    bannerImage!,
                                    width: 350,
                                    height: 150,
                                    fit: BoxFit.fill,
                                  ),
                                ).marginOnly(top: 8),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //Link
                        Text(
                          "Link",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        FadeInAnimationTTB(
                          delay: 1,
                          child: TextFormField(
                            cursorColor: rGreen,
                            keyboardType: TextInputType.url,
                            validator: (link) {
                              if (link == null || link.isEmpty) {
                                return "Link is required";
                              } else {
                                return null;
                              }
                            },
                            controller: linkController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Enter your link',
                              hintStyle: TextStyle(
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
                          ).marginOnly(top: 8),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //Timeline
                        Text(
                          "Timeline",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: startTimeController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Start Time",
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
                                    TimeOfDay initialTime = TimeOfDay.fromDateTime(startTime);

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
                                      DateTime newStartDateTime = DateTime(
                                        startTime.year,
                                        startTime.month,
                                        startTime.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );
                                      bool isValidTime = newStartDateTime.isBefore(endTime) || newStartDateTime.isAtSameMomentAs(endTime);

                                      if (isValidTime) {
                                        setState(() {
                                          startTime = newStartDateTime;
                                        });

                                        // Need to update the controller after state update
                                        startTimeController = TextEditingController(text: "${DateFormat("h a").format(newStartDateTime)}");
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
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: endTimeController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "End Time",
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
                                    TimeOfDay initialTime = TimeOfDay.fromDateTime(endTime);

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
                                        endTime.year,
                                        endTime.month,
                                        endTime.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );

                                      // For end time, check if it's after or equal to start time
                                      bool isValidTime = startTime.isBefore(newEndDateTime) || startTime.isAtSameMomentAs(newEndDateTime);

                                      if (isValidTime) {
                                        setState(() {
                                          endTime = newEndDateTime;
                                        });

                                        // Need to update the controller after state update
                                        endTimeController = TextEditingController(text: "${DateFormat("h a").format(newEndDateTime)}");
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
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: startDateController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Start Date",
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
                                    DateTime initialDate = DateTime.now();

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
                                        startTime.hour,
                                        startTime.minute,
                                      );

                                      bool isValidDate = true;

                                      if (endTime != null) {
                                        DateTime endDateTime = endTime;

                                        isValidDate = newStartDateTime.isBefore(endDateTime) || newStartDateTime.isAtSameMomentAs(endDateTime);
                                      }

                                      if (isValidDate) {
                                        setState(() {
                                          startTime = newStartDateTime;
                                        });

                                        // Update the controller after state update
                                        startDateController = TextEditingController(text: "${DateFormat('dd, MM, yyyy').format(startTime)}");

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
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  cursorColor: rGreen,
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: endDateController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "End Date",
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
                                    DateTime initialDate = DateTime.now();

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
                                      DateTime newEndDateTime = DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        endTime.hour,
                                        endTime.minute,
                                      );

                                      DateTime startDateTime = startTime;

                                      // Check if the new end date+time is after or equal to start date+time
                                      bool isValidDate = startDateTime.isBefore(newEndDateTime) || startDateTime.isAtSameMomentAs(newEndDateTime);

                                      if (isValidDate) {
                                        setState(() {
                                          endTime = newEndDateTime;
                                        });

                                        // Update the controller after state update
                                        endDateController = TextEditingController(text: "${DateFormat('dd, MM, yyyy').format(newEndDateTime)}");

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
                        SizedBox(
                          height: 20,
                        ),

                        //Interest
                        Text(
                          "Interest",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width,
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
                              items: authcontroller.adInterestList.map((AdInterestModel item) {
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
                        SizedBox(
                          height: 20,
                        ),

                        //message
                        Text(
                          "Message",
                          style: TextStyle(color: rHint, fontSize: 16),
                        ),
                        FadeInAnimationTTB(
                          delay: 1,
                          child: TextFormField(
                            cursorColor: rGreen,
                            keyboardType: TextInputType.text,
                            validator: (message) {
                              if (message == null || message.isEmpty) {
                                return "Message is required";
                              } else {
                                return null;
                              }
                            },
                            controller: messageController,
                            maxLines: 8,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Message...',
                              hintStyle: TextStyle(
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
                          ).marginOnly(top: 8),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //Button
                        CustomButton(label: "Submit", func: submitBtn),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        )
                      ],
                    ).marginSymmetric(horizontal: 12),
                  ),
                ),
              ),
              Visibility(
                  visible: authcontroller.isLoading,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: rWhite.withOpacity(0.2),
                      child: CustomLoading()))
            ],
          );
        },
      ),
    );
  }

  Future<File?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      print('Error picking image from gallery: $e');
      return null;
    }
  }

  submitBtn() {
    if (formKey.currentState!.validate()) {
      if (bannerImage == null) {
        CustomSnackbar.show("Error", "Ad Banner is required", isSuccess: false);
        return;
      } else if (selectedItems.isEmpty) {
        CustomSnackbar.show("Error", "Select atleast one interest", isSuccess: false);
        return;
      } else {
        BusinessDevelopmentModel businessDevelopmentModel = BusinessDevelopmentModel(
            id: "",
            status: "Pending",
            fullName: nameController.text,
            email: emailController.text,
            phoneNumber: selectedCountryCode + phoneController.text,
            link: linkController.text,
            specificCode: "",
            interestIds: [],
            image: "",
            paymentStatus: "Pending",
            description: messageController.text,
            starTime: startTime,
            note: "",
            endTime: endTime);
        for (var item in selectedItems) {
          businessDevelopmentModel.interestIds.add(item.id);
        }
        Get.find<AuthController>().setBusinessRequest(businessDevelopmentModel, bannerImage!);
      }
    } else {
      return;
    }
  }
}

class CountryCodeDropdown extends StatefulWidget {
  final Function(String) onCountrySelected;

  const CountryCodeDropdown({Key? key, required this.onCountrySelected}) : super(key: key);

  @override
  _CountryCodeDropdownState createState() => _CountryCodeDropdownState();
}

class _CountryCodeDropdownState extends State<CountryCodeDropdown> {
  PhoneNumber _selectedNumber = PhoneNumber(isoCode: 'CA'); // Default country

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90, // Reduced width
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: rHint),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: rBg,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return InternationalPhoneNumberInput(
              selectorTextStyle: TextStyle(
                color: rWhite,
                fontSize: 12, // Reduced font size
              ),
              textStyle: TextStyle(
                color: rWhite,
                fontSize: 12, // Reduced font size
              ),
              onInputChanged: (PhoneNumber number) {
                widget.onCountrySelected(number.dialCode ?? "+1");
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN,
                showFlags: true,
                useEmoji: false,
                trailingSpace: false, // Remove extra trailing space
              ),
              spaceBetweenSelectorAndTextField: 0,
              // Remove space between selector and text field
              ignoreBlank: true,
              initialValue: _selectedNumber,
              textFieldController: TextEditingController(),
              inputDecoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: '', // Remove any hint text
              ),
              onFieldSubmitted: (_) {},
            );
          },
        ),
      ),
    );
  }
}
