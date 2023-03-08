import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterTooltip extends StatelessWidget {
  final String message;
  final void Function() onTap;

  const ZoPromoTransporterTooltip({
    Key key,
    this.message,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: GlobalVariable.ratioFontSize(context) * 160,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Transform.rotate(
            angle: -math.pi / 4,
            child: Container(
              width: GlobalVariable.ratioFontSize(context) * 24,
              height: GlobalVariable.ratioFontSize(context) * 24,
              decoration: BoxDecoration(
                color: Color(ListColor.colorDarkGrey4),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey18),
                    blurRadius: 18,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              // constraints: BoxConstraints(
              //   // maxWidth: GlobalVariable.ratioWidth(context) * 160,
              //   // minWidth: 0,
              // ),
              // height: GlobalVariable.ratioWidth(context) * 59,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(ListColor.colorDarkGrey4),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioFontSize(context) * 5,
                      GlobalVariable.ratioFontSize(context) * 7,
                      GlobalVariable.ratioFontSize(context) * 5,
                      GlobalVariable.ratioFontSize(context) * 0,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onTap,
                        child: Icon(
                          Icons.close,
                          color: Color(ListColor.colorWhite),
                          size: GlobalVariable.ratioFontSize(context) * 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioFontSize(context) * 12,
                      GlobalVariable.ratioFontSize(context) * 16,
                      GlobalVariable.ratioFontSize(context) * 12,
                      GlobalVariable.ratioFontSize(context) * 16,
                    ),
                    child: CustomText(
                      message,
                      fontSize: 12,
                      height: (15.54 / 12),
                      fontWeight: FontWeight.w500,
                      color: Color(ListColor.color2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
