import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get/get.dart';

class CustomToast {
  static void show(
      {BuildContext context,
      String message,
      String buttonText,
      Function onTap,
      Widget customMessage}) {
    buttonText =
        buttonText == null ? "GlobalCustomToastButtonClose".tr : buttonText;
    ToastFuture toastF;
    toastF = showToastWidget(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: customMessage != null
                      ? customMessage
                      : CustomText(
                          message,
                          textAlign: TextAlign.center,
                          fromCenter: true,
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          bContext: context,
                        ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(context) * 16),
                  color: Colors.white,
                  width: GlobalVariable.ratioWidth(context) * 2,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      toastF.dismiss();
                      if (onTap != null) {
                        onTap;
                      }
                    },
                    child: Container(
                      width: GlobalVariable.ratioWidth(context) * 53,
                      height: GlobalVariable.ratioWidth(context) * 28,
                      alignment: Alignment.center,
                      child: CustomText(
                        buttonText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        bContext: context,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        handleTouch: true,
        duration: Duration(seconds: 3),
        position: ToastPosition.bottom);
  }

  static Widget getTextRichWidget(BuildContext context, String message,
      String splitterCode, String splitterReplace) {
    return Text.rich(
      TextSpan(
          children: _getListWidgetTextSpan(
              context, message, splitterCode, splitterReplace)),
      textAlign: TextAlign.center,
    );
  }

  static List<InlineSpan> _getListWidgetTextSpan(BuildContext context,
      String message, String splitterCode, String splitterReplace) {
    List<InlineSpan> listInline = [];
    List<String> listString = message.split(splitterCode);
    String text = "";
    if (listString.length < 2) {
      listInline.add(_setTextSpan(context, listString[0], false));
    } else {
      listInline.add(_setTextSpan(context, listString[0], false));
      listInline.add(_setTextSpan(context, splitterReplace, true));
      listInline.add(_setTextSpan(context, listString[1], false));
    }
    return listInline;
  }

  static TextSpan _setTextSpan(
      BuildContext context, String title, bool isBold) {
    return TextSpan(
        text: title,
        style: TextStyle(
            fontFamily: "AvenirNext",
            color: Colors.white,
            fontSize: GlobalVariable.ratioHeight(context) * 12,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400));
  }
}


Flushbar flushbar;

class CustomToastTop {
  static void show(
      {@required BuildContext context,
      String message,
      String buttonText,
      Function onTap,
      double fontSize,
      FontWeight fontWeight,
      // Color fontColor,
      // Color backGroundcolor,

      //isSuccess 0 untuk merah
      //isSuccess 1 untuk hijau
      @required int isSuccess,
      Widget customMessage}) {
    buttonText =
        buttonText == null ? "GlobalCustomToastButtonClose".tr : buttonText;

    if (flushbar != null) {
      flushbar.dismiss();
    }

    flushbar = Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 16,
        GlobalVariable.ratioWidth(Get.context) * 24,
        GlobalVariable.ratioWidth(Get.context) * 16,
        0,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          GlobalVariable.ratioWidth(Get.context) * 6,
        ),
      ), 
      backgroundColor: (isSuccess == 0)
          ? Color(ListColor.colorLightRed3)
          : Color(ListColor.colorLightGreen4),
      borderColor: (isSuccess == 0)
          ? Color(ListColor.colorRed)
          : Color(ListColor.colorGreen3),
      padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 12),
      icon: Container(
        margin: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 12,
          right: GlobalVariable.ratioWidth(Get.context) * 6,
        ),
        child: 
        Image.asset(
          (isSuccess == 0)
              ? "assets/infocircle.png"
              : "assets/infocheck.png",
          width: GlobalVariable.ratioWidth(Get.context) * 16,
          height: GlobalVariable.ratioWidth(Get.context) * 16,
          //     width: GlobalVariable.ratioWidth(Get.context) * isSuccess == 0 ? 13 : 15,
          // height: GlobalVariable.ratioWidth(Get.context) * isSuccess == 0 ? 13 : 15,
          color: (isSuccess == 0)
              ? Color(ListColor.colorRed)
              : Color(ListColor.colorGreen3),
        )
        // SvgPicture.asset(
        //   (isSuccess == 0)
        //       ? "assets/ic_toast_error.svg"
        //       : "assets/ic_toast_success.svg",
        //   width: GlobalVariable.ratioWidth(Get.context) * 13.33,
        //   height: GlobalVariable.ratioWidth(Get.context) * 13.33,
        //   color: (isSuccess == 0)
        //       ? Color(ListColor.colorRed)
        //       : Color(ListColor.colorGreen3),
        // ),
      ),
      isDismissible: true,
      animationDuration: Duration(
        milliseconds: 500,
      ),
      messageText: CustomText(
        message,
        textAlign: TextAlign.start,
        color: (isSuccess == 0)
            ? Color(ListColor.colorRed)
            : Color(ListColor.colorGreen3),
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.2,
        bContext: context,
        // withoutPadding: true,
      ),
      mainButton: GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(
            right: 12,
          ),
          child: InkWell(
            onTap: () {
              flushbar.dismiss();
              if (onTap != null) {
                onTap();
              }
            },
            child: SvgPicture.asset(
              'assets/ic_close1,5.svg',
              width: GlobalVariable.ratioWidth(Get.context) * 12.24,
              height: GlobalVariable.ratioWidth(Get.context) * 12.24,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ),
      ),
      duration: Duration(
        seconds: 3,
      ),
    );

    flushbar.show(context);
    // flushbar.dismiss();
    // ToastFuture toastF;
    // toastF = showToastWidget(
    //   Container(
    //     margin: EdgeInsets.symmetric(
    //         horizontal: GlobalVariable.ratioWidth(Get.context) * 16,),
    //     decoration: BoxDecoration(
    //         color: (isSuccess == 0)
    //             ? Color(ListColor.colorLightRed4)
    //             : Color(ListColor.colorLightGreen4),
    //         borderRadius: BorderRadius.all(
    //             Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
    //         border: Border.all(
    //           width: GlobalVariable.ratioWidth(Get.context) * 1,
    //           color: (isSuccess == 0)
    //               ? Color(ListColor.colorRed)
    //               : Color(ListColor.colorGreen3),
    //         ),
    //         ),
    //     padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 12),
    //     child: IntrinsicHeight(
    //       child: Row(
    //         mainAxisSize: MainAxisSize.max,
    //         // mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Container(
    //             width: GlobalVariable.ratioWidth(Get.context) * 16,
    //             height: GlobalVariable.ratioWidth(Get.context) * 16,
    //             child: SvgPicture.asset(
    //               (isSuccess == 0)
    //                   ? "assets/ic_toast_error.svg"
    //                   : "assets/ic_toast_success.svg",
    //               width: GlobalVariable.ratioWidth(Get.context) * 16,
    //               height: GlobalVariable.ratioWidth(Get.context) * 16,
    //               color: (isSuccess == 0)
    //                   ? Color(ListColor.colorRed)
    //                   : Color(ListColor.colorGreen3),
    //             ),
    //           ),
    //           SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
    //           Expanded(
    //             child: Container(
    //               alignment: Alignment.centerLeft,
    //               child: CustomText(
    //                 message,
    //                 textAlign: TextAlign.start,
    //                 fromCenter: true,
    //                 color: (isSuccess == 0)
    //                     ? Color(ListColor.colorRed)
    //                     : Color(ListColor.colorGreen3),
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w500,
    //                 height: 1.2,
    //                 bContext: context,
    //               ),
    //             ),
    //           ),
    //           // Spacer(),
    //           SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
    //           GestureDetector(
    //             onTap: () {
    //               toastF.dismiss();
    //               if (onTap != null) {
    //                 onTap;
    //               }
    //             },
    //             child: Container(
    //               // padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context)*3.76),
    //               width: GlobalVariable.ratioWidth(Get.context) * 16,
    //               alignment: Alignment.center,
    //               child: SvgPicture.asset(
    //                 'assets/ic_close1,5.svg',
    //                 width: GlobalVariable.ratioWidth(Get.context) * 12.24,
    //                 height: GlobalVariable.ratioWidth(Get.context) * 12.24,
    //                 color: Color(ListColor.colorLightGrey4),
    //               ),
    //             ),
    //           )
    //           // Expanded(
    //           //   child: customMessage != null
    //           //       ? customMessage
    //           //       : CustomText(
    //           //           message,
    //           //           textAlign: TextAlign.center,
    //           //           fromCenter: true,
    //           //           color: Colors.white,
    //           //           fontSize: 12,
    //           //           fontWeight: FontWeight.w500,
    //           //           bContext: context,
    //           //         ),
    //           // ),
    //           // Container(
    //           //     margin: EdgeInsets.symmetric(horizontal: 15),
    //           //     color: Colors.white,
    //           //     width: 2),
    //           // MaterialButton(
    //           //     padding: EdgeInsets.zero,
    //           //     onPressed: () {
    //           //       toastF.dismiss();
    //           //       if (onTap != null) {
    //           //         onTap;
    //           //       }
    //           //     },
    //           //     child: CustomText(
    //           //       buttonText,
    //           //       fontSize: 12,
    //           //       fontWeight: FontWeight.w600,
    //           //       color: Colors.white,
    //           //       bContext: context,
    //           //     )),
    //         ],
    //       ),
    //     ),
    //   ),
    //   handleTouch: true,
    //   duration: Duration(seconds: 3),
    //   position: ToastPosition.top,
    // );
  }

  static Widget getTextRichWidget(BuildContext context, String message,
      String splitterCode, String splitterReplace) {
    return Text.rich(
      TextSpan(
          children: _getListWidgetTextSpan(
              context, message, splitterCode, splitterReplace)),
      textAlign: TextAlign.center,
    );
  }

  static List<InlineSpan> _getListWidgetTextSpan(BuildContext context,
      String message, String splitterCode, String splitterReplace) {
    List<InlineSpan> listInline = [];
    List<String> listString = message.split(splitterCode);
    String text = "";
    if (listString.length < 2) {
      listInline.add(_setTextSpan(context, listString[0], false));
    } else {
      listInline.add(_setTextSpan(context, listString[0], false));
      listInline.add(_setTextSpan(context, splitterReplace, true));
      listInline.add(_setTextSpan(context, listString[1], false));
    }
    return listInline;
  }

  static TextSpan _setTextSpan(
      BuildContext context, String title, bool isBold) {
    return TextSpan(
        text: title,
        style: TextStyle(
            fontFamily: "AvenirNext",
            color: Colors.white,
            fontSize: GlobalVariable.ratioHeight(context) * 12,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400));
  }
}
