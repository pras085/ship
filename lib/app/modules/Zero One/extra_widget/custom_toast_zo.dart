import 'package:flutter/material.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get/get.dart';

class CustomToast {
  static void show(
      {BuildContext context,
      String message,
      String buttonText,
      Function onTap,
      double sizeRounded,
      Widget customMessage}) {
    buttonText =
        buttonText == null ? "GlobalCustomToastButtonClose".tr : buttonText;
    ToastFuture toastF;
    toastF = showToastWidget(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius:
                  BorderRadius.all(Radius.circular(sizeRounded ?? 20))),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
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
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.white,
                    width: 2),
                MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      toastF.dismiss();
                      if (onTap != null) {
                        onTap;
                      }
                    },
                    child: CustomText(
                      buttonText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      bContext: context,
                    )),
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
            fontSize: GlobalVariable.ratioWidth(context) * 12,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400));
  }
}
