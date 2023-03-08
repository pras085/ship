import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:get/get.dart';

class DialogChangeEmail extends StatefulWidget {
  final dialogFormKey;
  final TextEditingController emailController;
  final Function(String) onChangeButton;
  final Function(String) onChangeErrorMessage;
  String errorMessage;

  DialogChangeEmail(
      {@required this.onChangeButton,
      @required this.emailController,
      @required this.dialogFormKey,
      @required this.errorMessage,
      @required this.onChangeErrorMessage});

  @override
  _DialogChangeEmailState createState() => _DialogChangeEmailState();
}

class _DialogChangeEmailState extends State<DialogChangeEmail> {
  double _widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Form(
          key: widget.dialogFormKey,
          onChanged: () {
            widget.dialogFormKey.currentState.validate();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomText(
                'BFTMRegisterAllUbahEmail'.tr,
                fontSize: 22, fontWeight: FontWeight.w600,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormFieldWidget(
                                isShowError: false,
                                title: 'BFTMRegisterAllMasukkanEmail'.tr,
                                width: _widthContent(context),
                                isPassword: false,
                                isEmail: false,
                                isPhoneNumber: true,
                                textEditingController: widget.emailController,
                                isNextEditText: false),
                            CustomText(widget.errorMessage,
                                color: Colors.red)
                          ]),
                    ),
                  ],
                ),
              ),
              Container(height: 20),
              MaterialButton(
                  color: Color(ListColor.color5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  onPressed: () {
                    if (widget.dialogFormKey.currentState.validate()) {
                      Get.back();
                      widget.onChangeButton(widget.emailController.text);
                    }
                  },
                  child: CustomText('BFTMRegisterAllSimpan'.tr,
                          color: Color(ListColor.color4),
                          fontWeight: FontWeight.w800)),
            ],
          ),
        ));
  }
}
