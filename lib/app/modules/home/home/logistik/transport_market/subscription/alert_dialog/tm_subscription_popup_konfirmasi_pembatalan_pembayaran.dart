import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_detail/tm_subscription_detail_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';

class TMSubscriptionPopupKonfirmasiPembatalanPembayaran {
  static void showAlertDialog({
    @required BuildContext context,
    Function onTap,
    bool isDismissible = false,
  }) async {
    var selected = "0".obs;
    var textController = TextEditingController();
    TMSubscriptionDetailController controller;
    try {
      controller = Get.find();
    } catch (err) {}
    if (controller == null) {
      return;
    }
    var lebar = 15 * GlobalVariable.ratioWidth(Get.context);

    final _keyDialog = new GlobalKey<State>();
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext context) {
          return Dialog(
            key: _keyDialog,
            backgroundColor: Colors.white,
            insetPadding:
                EdgeInsets.all(GlobalVariable.ratioWidth(context) * 26),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(context) * 10)),
            child: SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            GlobalVariable.ratioWidth(context) * 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top:
                                  GlobalVariable.ratioWidth(context) * 29,
                              bottom: GlobalVariable.ratioWidth(context) *
                                  16),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              "SubscriptionCancelConfirmation".tr,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(ListColor.colorBlack),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left:
                                  GlobalVariable.ratioWidth(Get.context) *
                                      1),
                          child: CustomText(
                            "SubscriptionCancelConfirmationMessage".tr,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                            height:
                                GlobalVariable.ratioWidth(Get.context) *
                                    14),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) *
                                      7),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => RadioButtonCustom(
                                  colorSelected:
                                      Color(ListColor.colorBlue),
                                  colorUnselected:
                                      Color(ListColor.colorBlue),
                                  isWithShadow: true,
                                  isDense: true,
                                  width: lebar,
                                  height: lebar,
                                  groupValue: selected.value,
                                  value: "1",
                                  onChanged: (value) {
                                    selected.value = value;
                                  },
                                ),
                              ),
                              Container(
                                width: GlobalVariable.ratioWidth(
                                        Get.context) *
                                    15,
                              ),
                              Expanded(
                                  child: CustomText(
                                "SubscriptionCancelConfirmationOption1"
                                    .tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorDarkGrey3),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) *
                                      7),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => RadioButtonCustom(
                                  colorSelected:
                                      Color(ListColor.colorBlue),
                                  colorUnselected:
                                      Color(ListColor.colorBlue),
                                  isWithShadow: true,
                                  isDense: true,
                                  width: lebar,
                                  height: lebar,
                                  groupValue: selected.value,
                                  value: "2",
                                  onChanged: (value) {
                                    selected.value = value;
                                  },
                                ),
                              ),
                              Container(
                                width: GlobalVariable.ratioWidth(
                                        Get.context) *
                                    15,
                              ),
                              Expanded(
                                  child: CustomText(
                                "SubscriptionCancelConfirmationOption2"
                                    .tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorDarkGrey3),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) *
                                      7),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => RadioButtonCustom(
                                  colorSelected:
                                      Color(ListColor.colorBlue),
                                  colorUnselected:
                                      Color(ListColor.colorBlue),
                                  isWithShadow: true,
                                  isDense: true,
                                  width: lebar,
                                  height: lebar,
                                  groupValue: selected.value,
                                  value: "3",
                                  onChanged: (value) {
                                    selected.value = value;
                                  },
                                ),
                              ),
                              Container(
                                width: GlobalVariable.ratioWidth(
                                        Get.context) *
                                    15,
                              ),
                              Expanded(
                                  child: CustomText(
                                "SubscriptionCancelConfirmationOption3"
                                    .tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorDarkGrey3),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) *
                                      7),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => RadioButtonCustom(
                                  colorSelected:
                                      Color(ListColor.colorBlue),
                                  colorUnselected:
                                      Color(ListColor.colorBlue),
                                  isWithShadow: true,
                                  isDense: true,
                                  width: lebar,
                                  height: lebar,
                                  groupValue: selected.value,
                                  value: "4",
                                  onChanged: (value) {
                                    selected.value = value;
                                  },
                                ),
                              ),
                              Container(
                                width: GlobalVariable.ratioWidth(
                                        Get.context) *
                                    15,
                              ),
                              Expanded(
                                  child: CustomText(
                                "SubscriptionCancelConfirmationOption4"
                                    .tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorDarkGrey3),
                              )),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) *
                                      30,
                            ),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(
                                  right: GlobalVariable.ratioWidth(
                                          Get.context) *
                                      5),
                              child: Obx(
                                () => selected.value == "4"
                                    ? Container(
                                            height: GlobalVariable.ratioWidth(context) * 61, 
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(ListColor.colorGrey2),
                                                width: GlobalVariable.ratioWidth(context) * 0.5
                                              ),
                                              borderRadius:
                                                      BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
                                            ),
                                          child: CustomTextFormField(
                                              context: Get.context,
                                              controller: textController,
                                              minLines: 3,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              textSize: 12,
                                              newInputDecoration:
                                                  InputDecoration(
                                                contentPadding: EdgeInsets.all(
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        6),
                                                fillColor: Colors.white,
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                            ),
                                        )
                                    : SizedBox.shrink(),
                              ),
                            )),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _button(
                              context,
                                marginRight: 4,
                                text: "SubscriptionCancel".tr,
                                height: 36,
                                width: 104,
                                marginTop: 24,
                                marginBottom: 24,
                                backgroundColor:
                                    Color(ListColor.colorBlue),
                                onTap: () {
                                  if (selected.value == "0") {
                                    CustomToast.show(
                                      context: Get.context,
                                      message:
                                          "SubscriptionAlertChooseReason"
                                              .tr,
                                    );
                                  } else if (selected.value == "4" &&
                                      textController.text.isEmpty) {
                                    CustomToast.show(
                                      context: Get.context,
                                      message:
                                          "SubscriptionAlertReasonEmpty"
                                              .tr,
                                    );
                                  } else {
                                    var message = "";
                                    switch (selected.value) {
                                      case "1":
                                        {
                                          message =
                                              "SubscriptionCancelConfirmationOption1"
                                                  .tr;
                                          break;
                                        }
                                      case "2":
                                        {
                                          message =
                                              "SubscriptionCancelConfirmationOption2"
                                                  .tr;
                                          break;
                                        }
                                      case "3":
                                        {
                                          message =
                                              "SubscriptionCancelConfirmationOption3"
                                                  .tr;
                                          break;
                                        }
                                      default:
                                        {
                                          message = textController.text;
                                        }
                                    }
                                    Get.back();
                                    controller.batalOrder(message);
                                  }
                                }),
                            _button(
                              context,
                                marginLeft: 4,
                                marginTop: 24,
                                marginBottom: 24,
                                text: "SubscriptionBack".tr,
                                height: 36,
                                width: 104,
                                color: Color(ListColor.colorBlue),
                                useBorder: true,
                                onTap: () {
                                  Get.back();
                                }),
                          ],
                        )
                      ],
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(
                          right:
                              GlobalVariable.ratioWidth(Get.context) * 12,
                          top: GlobalVariable.ratioWidth(Get.context) *
                              12),
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                "assets/ic_close1,5.svg",
                                color: Color(ListColor.colorBlue),
                                width: GlobalVariable.ratioWidth(
                                        Get.context) *
                                    15,
                                height: GlobalVariable.ratioWidth(
                                        Get.context) *
                                    15,
                              )
                              // Icon(
                              //   Icons.close_rounded,
                              //   color: Color(ListColor.colorBlue),
                              //   size: 28,
                              // )
                              )),
                    )),
              ]),
            ],
            ),
            ),
          );
        });
  }

  static Widget _button(BuildContext context,
  {
    bool maxWidth = false,
    double width = 0,
    double height = 0,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * marginLeft,
          GlobalVariable.ratioWidth(context) * marginTop,
          GlobalVariable.ratioWidth(context) * marginRight,
          GlobalVariable.ratioWidth(context) * marginBottom),
      height: height == null ? null : GlobalVariable.ratioWidth(context) * height,
      width: width == null
          ? maxWidth
              ? double.infinity
              : null
          : GlobalVariable.ratioWidth(context) * width,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                    blurRadius: GlobalVariable.ratioWidth(context) * 2,
                    spreadRadius: GlobalVariable.ratioWidth(context) * 2,
                    offset: Offset(GlobalVariable.ratioWidth(context) * 0, GlobalVariable.ratioWidth(context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(context) * 1,
                  color: Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  paddingLeft, paddingTop, paddingRight, paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(context) * borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}
