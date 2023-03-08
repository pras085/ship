import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class TextFormFieldWidget2 extends StatelessWidget {
  Function validator;
  Function onSaved;
  bool isPassword;
  bool isEmail;
  bool isPhoneNumber;
  TextEditingController textEditingController;
  double width;
  String title;
  bool isEnable;
  bool darkBackground;
  bool isNextEditText;

  TextFormFieldWidget2(
      {this.validator,
      this.isPassword,
      this.isEmail,
      this.isPhoneNumber,
      this.textEditingController,
      this.width,
      this.title,
      this.isEnable = true,
      this.darkBackground = true,
      this.isNextEditText = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //     margin: EdgeInsets.only(top: 10),
          //     child: Text(title,
          //         style: TextStyle(
          //             color: darkBackground
          //                 ? Color(ListColor.textColor2)
          //                 : Colors.black,
          //             fontSize: 18))),
          Container(
              margin: EdgeInsets.only(top: 16),
              child: TextFormField(
                  textInputAction: isNextEditText
                      ? TextInputAction.next
                      : TextInputAction.done,
                  enabled: isEnable,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: title,
                    fillColor: Colors.white,
                    errorStyle: TextStyle(color: Colors.white, fontSize: 14),
                    errorMaxLines: 2,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 16),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.color4), width: 1.0),
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorYellow), width: 2.0),
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6),
                    ),
                  ),
                  obscureText: isPassword,
                  validator: validator,
                  keyboardType: isPhoneNumber
                      ? TextInputType.phone
                      : (isEmail
                          ? TextInputType.emailAddress
                          : TextInputType.text))),
        ],
      ),
    );
  }
}
