import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class GlobalAlertDialog {
  static final String yesLabelButton = "GlobalDialogLabelYES".tr;
  static final String noLabelButton = "GlobalDialogLabelNO".tr;
  static final String okLabelButton = "GlobalDialogLabelOK".tr;
  static void showAlertDialogCustom({
    String title,
    String subtitle,
    String message,
    double paddingLeft = 40.0,
    double paddingRight = 40.0,
    BuildContext context,
    Function onTapPriority1,
    String labelButtonPriority1,
    Function onTapPriority2,
    String labelButtonPriority2 = "",
    bool isDismissible = true,
    bool isShowCloseButton = true,
    bool isDirectBack = true,
    bool isShowButton = true,
    Widget customMessage,
    Widget customTitle,
    PositionColorPrimaryButton positionColorPrimaryButton =
        PositionColorPrimaryButton.PRIORITY1,
  }) {
    final _keyDialog = new GlobalKey<State>();
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext context) {
          return Dialog(
            key: _keyDialog,
            backgroundColor: Colors.white,
            insetPadding:
                EdgeInsets.only(left: paddingLeft, right: paddingRight),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
            child: Container(
                child: Scrollbar(
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        title != null
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            7,
                                      ),
                                      child: SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24)),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                    ),
                                    child: CustomText(title,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          7,
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          10,
                                      bottom: title != ""
                                          ? GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              7
                                          : 0,
                                    ),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (isShowCloseButton) Get.back();
                                        },
                                        child: Container(
                                            child: GestureDetector(
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'ic_close_blue.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              color: isShowCloseButton
                                                  ? Color(ListColor.color4)
                                                  : Colors.transparent),
                                        ))),
                                  )
                                ],
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: customTitle),
                        subtitle != null
                            ? Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      16,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                ),
                                child: CustomText(subtitle,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    height: 1.2,
                                    textAlign: TextAlign.center,
                                    color: Color(ListColor.colorGrey3)))
                            : SizedBox(),
                        title != ""
                            ? SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 19,
                              )
                            : SizedBox(),
                        Container(
                          padding: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) *
                                  16, // 5
                              right: GlobalVariable.ratioWidth(Get.context) *
                                  16, //5
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 24),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customMessage == null
                                    ? CustomText(message,
                                        textAlign: TextAlign.center,
                                        fontSize: 14,
                                        color: Colors.black,
                                        height: title != "" ? 1.2 : 1.4,
                                        fontWeight: FontWeight.w500)
                                    : customMessage,
                                isShowButton
                                    ? SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            23,
                                      )
                                    : SizedBox(),
                                isShowButton
                                    ? Container(
                                        padding: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              25,
                                          right: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              25,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            labelButtonPriority2 != ""
                                                ? Expanded(
                                                    child: positionColorPrimaryButton ==
                                                            PositionColorPrimaryButton
                                                                .PRIORITY1
                                                        ? _buttonPriorityPrimary(
                                                            onTapPriority1,
                                                            labelButtonPriority1,
                                                            labelButtonPriority2,
                                                            isDirectBack)
                                                        : _buttonPrioritySecondary(
                                                            onTapPriority1,
                                                            labelButtonPriority1,
                                                            labelButtonPriority2,
                                                            isDirectBack))
                                                : _buttonPriorityPrimary(
                                                    onTapPriority1,
                                                    labelButtonPriority1,
                                                    "",
                                                    isDirectBack),
                                            labelButtonPriority2 != ""
                                                ? SizedBox(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        8,
                                                  )
                                                : SizedBox.shrink(),
                                            labelButtonPriority2 != ""
                                                ? Expanded(
                                                    child: positionColorPrimaryButton ==
                                                            PositionColorPrimaryButton
                                                                .PRIORITY2
                                                        ? _buttonPriorityPrimary(
                                                            onTapPriority2,
                                                            labelButtonPriority2,
                                                            labelButtonPriority1,
                                                            isDirectBack)
                                                        : _buttonPrioritySecondary(
                                                            onTapPriority2,
                                                            labelButtonPriority2,
                                                            labelButtonPriority1,
                                                            isDirectBack))
                                                : SizedBox.shrink(),
                                          ],
                                        ))
                                    : SizedBox()
                              ]),
                        ),
                      ],
                    )))),
          );
        });
  }

  static Widget _buttonPriorityPrimary(
      Function onTapPriority,
      String labelButtonPriority,
      String labelButtonPriorityShadow,
      bool isDirectBack) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Color(ListColor.color4),
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
          )),
      onPressed: () {
        if (isDirectBack) {
          Get.back();
        }
        if (onTapPriority != null) onTapPriority();
      },
      child: Container(
        width: labelButtonPriorityShadow == ""
            ? GlobalVariable.ratioWidth(Get.context) * 100
            : null,
        padding: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 8),
        child: Stack(alignment: Alignment.center, children: [
          CustomText(labelButtonPriorityShadow,
              fontWeight: FontWeight.w600, color: Colors.transparent),
          CustomText(labelButtonPriority,
              fontWeight: FontWeight.w600, color: Colors.white),
        ]),
      ),
    );
  }

  static Widget _buttonPrioritySecondary(
      Function onTapPriority,
      String labelButtonPriority,
      String labelButtonPriorityShadow,
      bool isDirectBack) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
          )),
      onPressed: () {
        if (isDirectBack) {
          Get.back();
        }
        if (onTapPriority != null) onTapPriority();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 8),
        child: Stack(alignment: Alignment.center, children: [
          CustomText(labelButtonPriorityShadow,
              fontWeight: FontWeight.w600, color: Colors.transparent),
          CustomText(labelButtonPriority,
              fontWeight: FontWeight.w600, color: Color(ListColor.color4)),
        ]),
      ),
    );
  }

  static Widget getTextRichtWidget(
      String message, String splitterCode, String splitterReplace) {
    return Text.rich(
      TextSpan(
          children:
              _getListWidgetTextSpan(message, splitterCode, splitterReplace)),
      textAlign: TextAlign.center,
    );
  }

  static List<InlineSpan> _getListWidgetTextSpan(
      String message, String splitterCode, String splitterReplace) {
    List<InlineSpan> listInline = [];
    List<String> listString = message.split(splitterCode);
    String text = "";
    if (listString.length < 2) {
      listInline.add(_setTextSpan(listString[0], false));
    } else {
      listInline.add(_setTextSpan(listString[0], false));
      listInline.add(_setTextSpan(splitterReplace, true));
      listInline.add(_setTextSpan(listString[1], false));
    }
    return listInline;
  }

  static TextSpan _setTextSpan(String title, bool isBold) {
    return TextSpan(
        text: title,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500));
  }

  static Widget convertHTMLToText(String message) {
    return Html(data: message, style: {
      "body": Style(
        textAlign: TextAlign.center,
        fontSize: FontSize(14),
      ),
    });
  }

  static void showDialogError({
    String title,
    String message,
    BuildContext context,
    Function onTapPriority1,
    String labelButtonPriority1,
    Function onTapPriority2,
    String labelButtonPriority2 = "",
    bool isDismissible = false,
    Widget customMessage,
  }) {
    showAlertDialogCustom(
        title: title == null ? "GlobalLabelError".tr : title,
        message: message,
        labelButtonPriority1:
            labelButtonPriority1 == null ? "Ok" : labelButtonPriority1,
        onTapPriority1: onTapPriority1,
        labelButtonPriority2: labelButtonPriority2,
        onTapPriority2: onTapPriority2,
        isDismissible: isDismissible,
        customMessage: customMessage,
        context: context,
        isShowCloseButton: false);
  }
}

enum PositionColorPrimaryButton { PRIORITY1, PRIORITY2 }
