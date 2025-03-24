import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/controllers/faqController.dart';
import 'package:pingcoin_admin/models/faqModel.dart';
import 'package:pingcoin_admin/widgets/customSnackbar.dart';

import '../../../constants/colors.dart';

class FAQsTab extends StatefulWidget {
  const FAQsTab({super.key});

  @override
  State<FAQsTab> createState() => _FAQsTabState();
}

class _FAQsTabState extends State<FAQsTab> {
  TextEditingController _question = TextEditingController();
  TextEditingController _answer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FAQController>(
      builder: (faqController) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FAQs",
                style: TextStyle(color: rWhite, fontSize: 24, fontWeight: FontWeight.w600),
              ).marginOnly(top: 12),
              Text(
                "Question",
                style: TextStyle(color: rHint.withOpacity(0.8), fontSize: 12),
              ).marginOnly(top: 30),
          
              Container(
                width: MediaQuery.of(context).size.width,
                height: 65,
                child: TextFormField(
                  cursorColor: rGreen,
                  controller: _question,
                  style: TextStyle(color: rWhite),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: rBg,
                    hintText: "Enter your question here",
                    hintStyle: TextStyle(color: rHint),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF98A2B3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF98A2B3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF98A2B3)),
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                ).marginOnly(top: 4),
              ),
          
              Text(
                "Answer",
                style: TextStyle(color: rHint.withOpacity(0.8), fontSize: 12),
              ).marginOnly(top: 12),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 65,
                child: TextFormField(
                  cursorColor: rGreen,
                  controller: _answer,
                  style: TextStyle(color: rWhite),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: rBg,
                    hintText: "Enter your answer here",
                    hintStyle: TextStyle(color: rHint),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF98A2B3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF98A2B3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF98A2B3)),
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                ).marginOnly(top: 4),
              ),
          
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (_question.text.isEmpty || _answer.text.isEmpty) {
                      CustomSnackbar.show("Error", "Both question and answer are required");
                    } else {
                      faqController.addFaq(FAQModel(id: "", question: _question.text, answer: _answer.text, createdAt: DateTime.now()));
                      _question.text="";
                      _answer.text="";
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: rGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(color: rWhite),
                    ).marginSymmetric(vertical: 12),
                  ).marginOnly(top: 12),
                ),
              ),

              Text(
                "All FAQs",
                style: TextStyle(color: rWhite, fontSize: 24, fontWeight: FontWeight.w600),
              ).marginOnly(top: 12),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: rBg),
                child: ListView.builder(
                    itemCount: faqController.allFAQs.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return FAQTile(faqController.allFAQs[index],index,faqController.allFAQs.length);
                    }),
              ).marginOnly(top: 12)
            ],
          ),
        );
      },
    );
  }
}

class FAQTile extends StatefulWidget {
  FAQModel FAQ;
  int index;
  int length;
  FAQTile(this.FAQ,this.index,this.length,{super.key});

  @override
  State<FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.FAQ.question}",
                  style: TextStyle(color: rWhite, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.FAQ.answer}",
                  style: TextStyle(color: rWhite, fontWeight: FontWeight.normal),
                ).marginOnly(top: 10),
              ],
            ).marginAll(12)),
            InkWell(
                onTap: (){
                  showEditPopup();
                },
                child: SvgPicture.asset("assets/svgs/edit.svg")),
            SizedBox(
              width: 20,
            ),
            InkWell(
                onTap: (){
                  showDeletePopup();
                },
                child: SvgPicture.asset("assets/svgs/delete.svg").marginOnly(right: 20))
          ],
        ),
        if(widget.index!=widget.length-1)
        Dash(
          direction: Axis.horizontal,
          length: MediaQuery.of(context).size.width*0.8,
          dashLength: 5, // Length of dashes
          dashColor: Colors.grey,
        ).marginOnly(top: 10,bottom: 10),
      ],
    );
  }
  showDeletePopup() {
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
              "You want to delete this FAQ.",
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
                      Get.find<FAQController>().deleteFAQ(widget.FAQ);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: rRed),
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            rRed,
                            rRed,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text("Delete", style: TextStyle(color: rWhite, fontSize: 16, fontWeight: FontWeight.bold)),
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

  showEditPopup(){
    var formKey=GlobalKey<FormState>();
    TextEditingController questionController=TextEditingController(text:widget.FAQ.question);
    TextEditingController answerController=TextEditingController(text: widget.FAQ.answer);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ElasticIn(
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: rBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Center(child: Text("Edit FAQ", style: TextStyle(fontWeight: FontWeight.bold, color: rWhite))),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        cursorColor: rGreen,
                        controller: questionController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Question cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Question',
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
                      ),
                    ).marginOnly(top: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        cursorColor: rGreen,
                        controller: answerController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Answer cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        maxLines: 3,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Answer',
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
                      ),
                    ).marginOnly(top: 12),

                    InkWell(
                      onTap: (){
                        if(formKey.currentState!.validate()){
                          Get.find<FAQController>().updateFAQ(questionController.text,answerController.text,widget.FAQ);
                          Navigator.pop(context);
                        }else{
                          return;
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 40,
                        decoration: BoxDecoration(
                            color: rGreen,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        child: Text("Update",style: TextStyle(color: rWhite),),
                      ).marginOnly(top: 12),
                    ),

                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",style: TextStyle(color: rRed),).marginOnly(top: 20))
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
            );
          },),
        );
      },
    );
  }
}
