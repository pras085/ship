import 'package:flutter/material.dart';
import 'package:muatmuat/app/core/function/validator/phoine_number_validator.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:get/get.dart';

class DialogChangeNumber extends StatefulWidget {
  final dialogFormKey;
  final TextEditingController noTelpController;
  final Function(String) onChangeButton;
  final Function(String) onChangeErrorMessage;
  String errorMessage;

  DialogChangeNumber(
      {@required this.onChangeButton,
      @required this.noTelpController,
      @required this.dialogFormKey,
      @required this.errorMessage,
      @required this.onChangeErrorMessage});

  @override
  _DialogChangeNumberState createState() => _DialogChangeNumberState();
}

class _DialogChangeNumberState extends State<DialogChangeNumber> {
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
                'VerifyHPLabelDialogTitleChangePhoneNumber'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(top: 32, right: 20),
                    //   child: MaterialButton(
                    //       padding: EdgeInsets.all(13),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.all(Radius.circular(13)),
                    //           side: BorderSide(color: Colors.grey)),
                    //       onPressed: () {},
                    //       child: Text("+62",
                    //           style: TextStyle(color: Colors.grey, fontSize: 18))),
                    // ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormFieldWidget(
                                isShowError: false,
                                title: 'VerifyHPLabelEdtDialogChange'.tr,
                                validator: (String value) {
                                  String resultValidate = PhoneNumberValidator.validate(
                                      value: value,
                                      warningIfEmpty:
                                          'VerifyHPLabelEdtValidatorPhoneNumberEmpty'
                                              .tr,
                                      warningIfFormatNotMatch:
                                          'VerifyHPLabelEdtValidatorPhoneNumberFalseFormat'
                                              .tr,
                                      minLength: 9);
                                  widget.errorMessage = resultValidate ?? "";
                                  widget.onChangeErrorMessage(
                                      widget.errorMessage);
                                  setState(() {});
                                  return resultValidate;
                                  // if (value.isEmpty)
                                  //   return 'VerifyHPLabelEdtValidatorPhoneNumberEmpty'.tr;
                                  // else if (value.length < 9)
                                  //   return 'VerifyHPLabelEdtValidatorPhoneNumberFalseFormat'
                                  //       .tr;
                                  // return null;
                                },
                                width: _widthContent(context),
                                isPassword: false,
                                isEmail: false,
                                isPhoneNumber: true,
                                textEditingController: widget.noTelpController,
                                isNextEditText: false),
                            CustomText(widget.errorMessage, color: Colors.red)
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
                      widget.onChangeButton(widget.noTelpController.text);
                    }
                  },
                  child: CustomText('VerifyHPButtonDialogChange'.tr,
                      color: Color(ListColor.color4),
                      fontWeight: FontWeight.w600)),
              // Container(
              //   width: widthContent(context),
              //   margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              //   child: MaterialButton(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     onPressed: () {
              //       if (_dialogFormKey.currentState.validate()) {
              //         Get.back();
              //         controller.changePhoneNumber(
              //             context, _noTelpController.text);
              //         _noTelpController.text = "";
              //       }
              //     },
              //     color: Color(ListColor.color4),
              //     child: Text('VerifyHPButtonDialogChange'.tr,
              //         style: TextStyle(
              //             color: Colors.white, fontWeight: FontWeight.w800)),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //       width: widthContent(context) * 2 / 3,
              //       height: 40,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: Color(ListColor.color4)),
              //       child: Material(
              //         borderRadius: BorderRadius.circular(20),
              //         color: Colors.transparent,
              //         child: InkWell(
              //             borderRadius: BorderRadius.circular(20),
              //             onTap: () {
              //               if (_dialogFormKey.currentState.validate()) {
              //                 Get.back();
              //                 controller.changePhoneNumber(
              //                     context, _noTelpController.text);
              //                 _noTelpController.text = "";
              //               }
              //             },
              //             child: Center(
              //                 child: Text("ubah".tr,
              //                     style: TextStyle(
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.w800)))),
              //       )),
              // ),
            ],
          ),
        ));
  }
}
