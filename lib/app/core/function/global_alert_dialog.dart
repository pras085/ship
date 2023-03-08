import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

//untuk dialog dengan button width statis yg ditentukan
class GlobalAlertDialog {
  static final String yesLabelButton = "GlobalDialogLabelYES".tr;
  static final String noLabelButton = "GlobalDialogLabelNO".tr;
  static void showAlertDialogCustom(
      {String title,
      String message,
      @required BuildContext context,
      double insetPadding = 32,
      double borderRadius = 10,
      Function onTapPriority1,
      String labelButtonPriority1 = "",
      double widthButton1,
      double heightButton1,
      double borderRadiusButton1,
      double borderSizeButton1,
      double fontSizeButton1,
      Function onTapPriority2,
      String labelButtonPriority2 = "",
      double widthButton2,
      double heightButton2,
      double borderRadiusButton2,
      double borderSizeButton2,
      double fontSizeButton2,
      bool isDismissible = true,
      bool isShowCloseButton = true,
      Function onTapCloseButton,
      Widget customMessage,
      PositionColorPrimaryButton positionColorPrimaryButton =
          PositionColorPrimaryButton.PRIORITY1,
      bool disableGetBack = false,
      Color barrierColor = const Color(0x33000000),
      Color primaryColor}) {
    final _keyDialog = new GlobalKey<State>();
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        barrierColor: barrierColor,
        builder: (BuildContext context) {
          return Dialog(
            key: _keyDialog,
            insetPadding: EdgeInsets.all(
                GlobalVariable.ratioWidth(context) * insetPadding),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * borderRadius)),
            child: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.topCenter, children: [
                  if (title != null)
                    Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 24),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomText(title,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  isShowCloseButton 
                    ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(
                          right: GlobalVariable.ratioWidth(Get.context) * 12,
                          top: GlobalVariable.ratioWidth(Get.context) * 12
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (isShowCloseButton) {
                              Get.back();
                              if (onTapCloseButton != null) {
                                onTapCloseButton();
                              }
                            }
                          },
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/ic_close1,5.svg",
                              color: isShowCloseButton ? primaryColor ?? Color(ListColor.colorBlue) : Colors.transparent,
                              width: GlobalVariable.ratioWidth(Get.context) * 15,
                              height: GlobalVariable.ratioWidth(Get.context) * 15,
                            )
                              // Icon(
                              //   Icons.close_rounded,
                              // color: isShowCloseButton
                              //     ? Color(ListColor.color4)
                              //     : Colors.transparent,
                              //   size: 28,
                              // )
                          )
                        ),
                      )
                    )
                    : Container(
                        height: GlobalVariable.ratioWidth(context) * 24,
                    )
                ]),
                if (title != null)
                  SizedBox(
                    height: GlobalVariable.ratioWidth(Get.context) * 16,
                  ),
                Container(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customMessage == null
                            ? Container(
                                margin: EdgeInsets.only(
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                ),
                                child: CustomText(message,
                                    textAlign: TextAlign.center,
                                    fontSize: 14,
                                    height: 16.8 / 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )
                            : customMessage,
                        Padding(
                          padding: EdgeInsets.only(
                              // left: 25,
                              // right: 25,
                              ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              labelButtonPriority2 != ""
                                  ? Expanded(
                                      child: positionColorPrimaryButton ==
                                              PositionColorPrimaryButton
                                                  .PRIORITY1
                                          ? _buttonPriorityPrimary(
                                              positionColorPrimaryButton,
                                              onTapPriority1,
                                              labelButtonPriority1,
                                              // labelButtonPriority2,
                                              widthButton1,
                                              heightButton1,
                                              fontSizeButton1,
                                              labelButtonPriority2 != "",
                                              disableGetBack: disableGetBack,
                                              color: primaryColor)
                                          : _buttonPrioritySecondary(
                                              positionColorPrimaryButton,
                                              onTapPriority1,
                                              labelButtonPriority1,
                                              // labelButtonPriority2,
                                              widthButton1,
                                              heightButton1,
                                              borderRadiusButton1,
                                              borderSizeButton1,
                                              fontSizeButton1,
                                              disableGetBack: disableGetBack,
                                              color: primaryColor))
                                  : labelButtonPriority1 != ""
                                      ? positionColorPrimaryButton ==
                                              PositionColorPrimaryButton
                                                  .PRIORITY1
                                          ? _buttonPriorityPrimary(
                                              positionColorPrimaryButton,
                                              onTapPriority1,
                                              labelButtonPriority1,
                                              // "",
                                              widthButton1,
                                              heightButton1,
                                              fontSizeButton1,
                                              labelButtonPriority2 != "",
                                              color: primaryColor
                                            )
                                          : _buttonPrioritySecondary(
                                              positionColorPrimaryButton,
                                              onTapPriority1,
                                              labelButtonPriority1,
                                              // labelButtonPriority2,
                                              widthButton1,
                                              heightButton1,
                                              borderRadiusButton1,
                                              borderSizeButton1,
                                              fontSizeButton1,
                                              disableGetBack: disableGetBack,
                                              color: primaryColor)
                                      : SizedBox.shrink(),
                              labelButtonPriority2 != ""
                                  ? SizedBox(
                                      width: GlobalVariable.ratioWidth(
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
                                              positionColorPrimaryButton,
                                              onTapPriority2,
                                              labelButtonPriority2,
                                              // labelButtonPriority1,
                                              widthButton2,
                                              heightButton2,
                                              fontSizeButton2,
                                              labelButtonPriority2 != "",
                                              disableGetBack: disableGetBack,
                                              color: primaryColor)
                                          : _buttonPrioritySecondary(
                                              positionColorPrimaryButton,
                                              onTapPriority2,
                                              labelButtonPriority2,
                                              // labelButtonPriority1,
                                              widthButton2,
                                              heightButton2,
                                              borderRadiusButton2,
                                              borderSizeButton2,
                                              fontSizeButton2,
                                              disableGetBack: disableGetBack,
                                              color: primaryColor))
                                  : SizedBox.shrink(),
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            )),
          );
        });
  }

  static Widget _buttonPriorityPrimary(
      PositionColorPrimaryButton positionColorPrimaryButton,
      Function onTapPriority,
      String labelButtonPriority,
      // String labelButtonPriorityShadow,
      double widthButton,
      double heightButton,
      double fontSize,
      bool isButton2NotEmpty,
      {bool disableGetBack = false, Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: isButton2NotEmpty
          ? positionColorPrimaryButton == PositionColorPrimaryButton.PRIORITY1
              ? MainAxisAlignment.end
              : MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        _button(
            width: widthButton ?? 104,
            height: heightButton ?? 36,
            text: labelButtonPriority,
            fontSize: fontSize ?? 14,
            backgroundColor: color ?? Color(ListColor.colorBlue),
            onTap: () {
              if (!disableGetBack) Get.back();
              if (onTapPriority != null) onTapPriority();
            }),
      ],
    );

    // OutlinedButton(
    //   style: OutlinedButton.styleFrom(
    //       backgroundColor: Color(ListColor.color4),
    //       side: BorderSide(width: 2, color: Color(ListColor.color4)),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(
    //             Radius.circular(GlobalVariable.ratioWidth(Get.context) * 18)),
    //       )),
    //   onPressed: () {
    //     if (!disableGetBack) Get.back();
    //     if (onTapPriority != null) onTapPriority();
    //   },
    //   child: Container(
    //     color: Colors.red,
    //     alignment: Alignment.center,
    //     constraints: BoxConstraints(
    //         minWidth: GlobalVariable.ratioWidth(Get.context) * 104,
    //         maxHeight: GlobalVariable.ratioWidth(Get.context) * 36),
    //     padding: EdgeInsets.symmetric(
    //         // horizontal: GlobalVariable.ratioWidth(Get.context) * 24,
    //         ),
    //     child: Stack(alignment: Alignment.center, children: [
    //       CustomText(labelButtonPriorityShadow,
    //           fontWeight: FontWeight.w600, color: Colors.transparent),
    //       CustomText(labelButtonPriority,
    //           fontWeight: FontWeight.w600, color: Colors.white),
    //     ]),
    //   ),
    // );
  }

  static Widget _buttonPrioritySecondary(
      PositionColorPrimaryButton positionColorPrimaryButton,
      Function onTapPriority,
      String labelButtonPriority,
      // String labelButtonPriorityShadow,
      double widthButton,
      double heightButton,
      double borderRadiusButton,
      double borderSizeButton,
      double fontSize,
      {bool disableGetBack = false, Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          positionColorPrimaryButton == PositionColorPrimaryButton.PRIORITY1
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
      children: [
        _button(
            width: widthButton ?? 104,
            height: heightButton ?? 36,
            text: labelButtonPriority,
            color: color ?? Color(ListColor.colorBlue),
            useBorder: true,
            borderColor: color,
            borderRadius: borderRadiusButton ?? 18,
            borderSize: borderSizeButton ?? 1.5,
            fontSize: fontSize ?? 14,
            onTap: () {
              if (!disableGetBack) Get.back();
              if (onTapPriority != null) onTapPriority();
            }),
      ],
    );

    // OutlinedButton(
    //   style: OutlinedButton.styleFrom(
    //       backgroundColor: Colors.white,
    //       side: BorderSide(width: 2, color: Color(ListColor.color4)),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(
    //             Radius.circular(GlobalVariable.ratioWidth(Get.context) * 18)),
    //       )),
    //   onPressed: () {
    //     if (!disableGetBack) Get.back();
    //     if (onTapPriority != null) onTapPriority();
    //   },
    //   child: Container(
    //     color: Colors.red,
    //     alignment: Alignment.center,
    //     constraints: BoxConstraints(
    //         minWidth: GlobalVariable.ratioWidth(Get.context) * 104,
    //         maxHeight: GlobalVariable.ratioWidth(Get.context) * 36),
    //     padding: EdgeInsets.symmetric(
    //         // horizontal: GlobalVariable.ratioWidth(Get.context) * 24,
    //         ),
    //     child: Stack(alignment: Alignment.center, children: [
    //       CustomText(labelButtonPriorityShadow,
    //           fontWeight: FontWeight.w600, color: Colors.transparent),
    //       CustomText(labelButtonPriority,
    //           fontWeight: FontWeight.w600, color: Color(ListColor.color4)),
    //     ]),
    //   ),
    // );
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
    bool disableGetBack = false,
  }) {
    showAlertDialogCustom(
        title: title == null ? "GlobalLabelError".tr : title,
        message: message,
        labelButtonPriority1: labelButtonPriority1 == null
            ? "GlobalButtonOK".tr
            : labelButtonPriority1,
        onTapPriority1: onTapPriority1,
        labelButtonPriority2: labelButtonPriority2,
        onTapPriority2: onTapPriority2,
        isDismissible: isDismissible,
        customMessage: customMessage,
        context: context,
        isShowCloseButton: false);
  }

  static void showDialogWarningWithoutTitle({
    String message,
    BuildContext context,
    Function onTapPriority1,
    String labelButtonPriority1,
    double buttonWidth,
    bool isDismissible = false,
    Widget customMessage,
  }) {
    showAlertDialogCustom(
        message: message,
        labelButtonPriority1: labelButtonPriority1 == null
            ? "GlobalButtonOK".tr
            : labelButtonPriority1,
        onTapPriority1: onTapPriority1,
        isDismissible: isDismissible,
        customMessage: customMessage,
        context: context,
        widthButton1: buttonWidth,
        isShowCloseButton: true);
  }

  static Widget _button({
    double height,
    double width,
    bool maxWidth = false,
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
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text ?? "",
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

//untuk dialog dengan button width dinamis dengan padding
class GlobalAlertDialog2 {
  static final String yesLabelButton = "GlobalDialogLabelYES".tr;
  static final String noLabelButton = "GlobalDialogLabelNO".tr;
  static void showAlertDialogCustom(
      {String title,
      String message,
      @required BuildContext context,
      double insetPadding = 32,
      double borderRadius = 10,
      EdgeInsetsGeometry paddingTitle,
      EdgeInsetsGeometry paddingContent,
      EdgeInsetsGeometry paddingButton,
      Function onTapPriority1,
      String labelButtonPriority1 = "",
      double widthButton1,
      double heightButton1,
      double borderRadiusButton1,
      double borderSizeButton1,
      double fontSizeButton1,
      Function onTapPriority2,
      String labelButtonPriority2 = "",
      double widthButton2,
      double heightButton2,
      double borderRadiusButton2,
      double borderSizeButton2,
      double fontSizeButton2,
      bool isDismissible = true,
      bool isShowCloseButton = true,
      Function onTapCloseButton,
      Widget customMessage,
      PositionColorPrimaryButton positionColorPrimaryButton =
          PositionColorPrimaryButton.PRIORITY1,
      bool disableGetBack = false,
      Color barrierColor = const Color(0x33000000)}) {
    final _keyDialog = new GlobalKey<State>();
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        barrierColor: barrierColor,
        builder: (BuildContext context) {
          return Dialog(
            key: _keyDialog,
            insetPadding: EdgeInsets.all(
                GlobalVariable.ratioWidth(context) * insetPadding),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * borderRadius)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.topCenter, children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 8,
                            top: GlobalVariable.ratioWidth(Get.context) * 8),
                        child: GestureDetector(
                            onTap: () {
                              if (isShowCloseButton) {
                                Get.back();
                                if (onTapCloseButton != null) {
                                  onTapCloseButton();
                                }
                              }
                            },
                            child: Container(
                                color: Colors.transparent,
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/ic_close1,5.svg",
                                  color: isShowCloseButton
                                      ? Color(ListColor.colorBlue)
                                      : Colors.transparent,
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                ))),
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (title != null)
                        Container(
                          padding: paddingTitle ??
                              EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) * 24,
                                  bottom: GlobalVariable.ratioWidth(Get.context) * 16,
                                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                                  right: GlobalVariable.ratioWidth(Get.context) * 16,
                                  ),
                          child: CustomText(title,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      Container(
                        padding: paddingContent ??
                            EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) *
                                    (title != null ? 0 : 24),
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                bottom: GlobalVariable.ratioWidth(Get.context) *
                                    20),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customMessage == null
                                  ? Container(
                                      child: CustomText(message ?? "",
                                          textAlign: TextAlign.center,
                                          fontSize: 14,
                                          height: 16.8 / 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : customMessage,
                            ]),
                      ),
                      Container(
                        padding: paddingButton ??
                            EdgeInsets.only(
                                bottom: GlobalVariable.ratioWidth(Get.context) *
                                    24),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            labelButtonPriority2 != ""
                                ? Expanded(
                                    child: positionColorPrimaryButton ==
                                            PositionColorPrimaryButton.PRIORITY1
                                        ? _buttonPriorityPrimary(
                                            positionColorPrimaryButton,
                                            onTapPriority1,
                                            labelButtonPriority1,
                                            // labelButtonPriority2,
                                            widthButton1,
                                            heightButton1,
                                            fontSizeButton1,
                                            labelButtonPriority2 != "",
                                            disableGetBack: disableGetBack)
                                        : _buttonPrioritySecondary(
                                            positionColorPrimaryButton,
                                            onTapPriority1,
                                            labelButtonPriority1,
                                            // labelButtonPriority2,
                                            widthButton1,
                                            heightButton1,
                                            borderRadiusButton1,
                                            borderSizeButton1,
                                            fontSizeButton1,
                                            disableGetBack: disableGetBack))
                                : labelButtonPriority1 != ""
                                    ? positionColorPrimaryButton ==
                                            PositionColorPrimaryButton.PRIORITY1
                                        ? _buttonPriorityPrimary(
                                            positionColorPrimaryButton,
                                            onTapPriority1,
                                            labelButtonPriority1,
                                            // "",
                                            widthButton1,
                                            heightButton1,
                                            fontSizeButton1,
                                            labelButtonPriority2 != "",
                                          )
                                        : _buttonPrioritySecondary(
                                            positionColorPrimaryButton,
                                            onTapPriority1,
                                            labelButtonPriority1,
                                            // labelButtonPriority2,
                                            widthButton1,
                                            heightButton1,
                                            borderRadiusButton1,
                                            borderSizeButton1,
                                            fontSizeButton1,
                                            disableGetBack: disableGetBack)
                                    : SizedBox.shrink(),
                            labelButtonPriority2 != ""
                                ? SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                  )
                                : SizedBox.shrink(),
                            labelButtonPriority2 != ""
                                ? Expanded(
                                    child: positionColorPrimaryButton ==
                                            PositionColorPrimaryButton.PRIORITY2
                                        ? _buttonPriorityPrimary(
                                            positionColorPrimaryButton,
                                            onTapPriority2,
                                            labelButtonPriority2,
                                            // labelButtonPriority1,
                                            widthButton2,
                                            heightButton2,
                                            fontSizeButton2,
                                            labelButtonPriority2 != "",
                                            disableGetBack: disableGetBack)
                                        : _buttonPrioritySecondary(
                                            positionColorPrimaryButton,
                                            onTapPriority2,
                                            labelButtonPriority2,
                                            // labelButtonPriority1,
                                            widthButton2,
                                            heightButton2,
                                            borderRadiusButton2,
                                            borderSizeButton2,
                                            fontSizeButton2,
                                            disableGetBack: disableGetBack))
                                : SizedBox.shrink(),
                          ],
                        ),
                      )
                    ],
                  )
                ]),
              ],
            ),
          );
        });
  }

  static Widget _buttonPriorityPrimary(
      PositionColorPrimaryButton positionColorPrimaryButton,
      Function onTapPriority,
      String labelButtonPriority,
      // String labelButtonPriorityShadow,
      double widthButton,
      double heightButton,
      double fontSize,
      bool isButton2NotEmpty,
      {bool disableGetBack = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: isButton2NotEmpty
          ? positionColorPrimaryButton == PositionColorPrimaryButton.PRIORITY1
              ? MainAxisAlignment.end
              : MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        _button(
            width: widthButton,
            height: heightButton ?? 36,
            text: labelButtonPriority,
            fontSize: fontSize ?? 14,
            backgroundColor: Color(ListColor.colorBlue),
            onTap: () {
              if (!disableGetBack) Get.back();
              if (onTapPriority != null) onTapPriority();
            }),
      ],
    );
  }

  static Widget _buttonPrioritySecondary(
      PositionColorPrimaryButton positionColorPrimaryButton,
      Function onTapPriority,
      String labelButtonPriority,
      // String labelButtonPriorityShadow,
      double widthButton,
      double heightButton,
      double borderRadiusButton,
      double borderSizeButton,
      double fontSize,
      {bool disableGetBack = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          positionColorPrimaryButton == PositionColorPrimaryButton.PRIORITY1
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
      children: [
        _button(
            width: widthButton,
            height: heightButton ?? 36,
            text: labelButtonPriority,
            color: Color(ListColor.colorBlue),
            useBorder: true,
            borderRadius: borderRadiusButton ?? 18,
            borderSize: borderSizeButton ?? 1.5,
            fontSize: fontSize ?? 14,
            onTap: () {
              if (!disableGetBack) Get.back();
              if (onTapPriority != null) onTapPriority();
            }),
      ],
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
            fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
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
    bool disableGetBack = false,
  }) {
    showAlertDialogCustom(
        title: title == null ? "GlobalLabelError".tr : title,
        message: message,
        labelButtonPriority1: labelButtonPriority1 == null
            ? "GlobalButtonOK".tr
            : labelButtonPriority1,
        onTapPriority1: onTapPriority1,
        labelButtonPriority2: labelButtonPriority2,
        onTapPriority2: onTapPriority2,
        isDismissible: isDismissible,
        customMessage: customMessage,
        context: context,
        isShowCloseButton: false);
  }

  static void showDialogWarningWithoutTitle({
    String message,
    BuildContext context,
    Function onTapPriority1,
    String labelButtonPriority1,
    bool isDismissible = false,
    Widget customMessage,
  }) {
    showAlertDialogCustom(
        title: "",
        message: message,
        labelButtonPriority1: labelButtonPriority1 == null
            ? "GlobalButtonOK".tr
            : labelButtonPriority1,
        onTapPriority1: onTapPriority1,
        isDismissible: isDismissible,
        customMessage: customMessage,
        context: context,
        isShowCloseButton: true);
  }

  static Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 24,
    double paddingTop = 0,
    double paddingRight = 24,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text ?? "",
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

enum PositionColorPrimaryButton { PRIORITY1, PRIORITY2 }
