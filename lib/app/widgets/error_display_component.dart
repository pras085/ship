import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';

import '../../global_variable.dart';
import 'custom_text.dart';

class ErrorDisplayComponent extends StatelessWidget {

  final String errorMessage;
  final bool isOnlyButton;
  final VoidCallback onRefresh;

  const ErrorDisplayComponent(this.errorMessage, {
    @required this.onRefresh,
    this.isOnlyButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(context) * 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isOnlyButton)
              CustomText(errorMessage.length > 120 ? "${errorMessage.substring(0, 118)} ..." : errorMessage,
                textAlign: TextAlign.center,
              ),
            if (!isOnlyButton)
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 8,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _button(
                  context: context,
                  onTap: onRefresh,
                  backgroundColor: Color(ListColor.colorBlue),
                  customWidget: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(context) * 4,
                      horizontal: GlobalVariable.ratioWidth(context) * 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh,
                          color: Colors.white,
                        ),
                        CustomText("Refresh",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({
    @required BuildContext context,
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
          GlobalVariable.ratioWidth(context) * marginLeft,
          GlobalVariable.ratioWidth(context) * marginTop,
          GlobalVariable.ratioWidth(context) * marginRight,
          GlobalVariable.ratioWidth(context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(context).size.width
              : null
          : GlobalVariable.ratioWidth(context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
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
                  GlobalVariable.ratioWidth(context) * paddingLeft,
                  GlobalVariable.ratioWidth(context) * paddingTop,
                  GlobalVariable.ratioWidth(context) * paddingRight,
                  GlobalVariable.ratioWidth(context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius)),
              child: Center(
                child: customWidget == null
                    ? CustomText(
                        text ?? "",
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: color,
                      )
                    : customWidget,
              ),
            )),
      ),
    );
  }

}