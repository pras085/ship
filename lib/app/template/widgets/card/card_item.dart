import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

/// Class ini merupakan base card yang digunakan di buyer
abstract class CardItem extends StatelessWidget {
  final double padding;
  final double width;
  /// Event card ditekan
  final Function() onTap;
  final bool highlight;
  final bool verified;
  final bool favorite;
  /// Event favorite ditekan
  final Function() onFavorited;
  final bool report;
  /// Event report ditekan
  final Function() onReported;
  final String location;
  final BoxShadow cardShadow;
  final bool individu;

  const CardItem({
    this.padding = 8,
    this.width = 156,
    this.onTap,
    @required this.highlight, 
    @required this.verified, 
    @required this.favorite, 
    this.onFavorited, 
    @required this.report, 
    this.onReported,
    @required this.location,
    this.cardShadow,
    this.individu
  });

  Widget wrapper({Widget child}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: GlobalVariable.ratioWidth(Get.context) * width,
        padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * padding),
        decoration: BoxDecoration(
          color: highlight ? Color(ListColor.colorBlueTemplate3) : Colors.white,
          border: Border.all(
            color: highlight ? Color(ListColor.colorBlueTemplate1) : Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(Get.context) * 1
          ),
          borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * 8
          ),
          boxShadow: [
            cardShadow ?? 
              BoxShadow(
                offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
                blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.1)
              ),
          ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header(),
            child ?? Container(),
            footer()
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (highlight && verified) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 4,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 3.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
                      bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
                    ),
                    color: Color(ListColor.colorBlueTemplate1)
                  ),
                  child: CustomText(
                    'Highlight',
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 4,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 3.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
                      bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
                    ),
                    color: Color(ListColor.colorGreenTemplate)
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        GlobalVariable.urlImageTemplateBuyer + 'ic_buyer_verified_template.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 13,
                        width: GlobalVariable.ratioWidth(Get.context) * 13
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 6),
                      CustomText(
                        'Verified',
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ] else if (highlight && !verified) ... [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 4,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 3.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
                    color: Color(ListColor.colorBlueTemplate1)
                  ),
                  child: CustomText(
                    'Highlight',
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 5.5)
              ] else if (!highlight && verified) ... [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 4,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 3.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
                    color: Color(ListColor.colorGreenTemplate)
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        GlobalVariable.urlImageTemplateBuyer + 'ic_buyer_verified_template.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 13,
                        width: GlobalVariable.ratioWidth(Get.context) * 13
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 6),
                      CustomText(
                        'Verified',
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 5.5)
              ],
              if (report) ...[
                GestureDetector(
                  onTap: onReported,
                  child: SvgPicture.asset(
                    GlobalVariable.urlImageTemplateBuyer + 'ic_flag_template.svg',
                    height: GlobalVariable.ratioWidth(Get.context) * 16,
                    width: GlobalVariable.ratioWidth(Get.context) * 16
                  ),
                ),
              ]
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (individu) ...[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 4
                        ),
                        blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                        color: Color(ListColor.colorShadowTemplate3).withOpacity(0.25)
                      )
                    ],
                    shape: BoxShape.circle
                  ),
                  child: SvgPicture.asset(
                    GlobalVariable.urlImageTemplateBuyer + 'ic_individu.svg',
                    height: GlobalVariable.ratioWidth(Get.context) * 18,
                    width: GlobalVariable.ratioWidth(Get.context) * 18
                  ),
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8)
              ],
              GestureDetector(
                onTap: onFavorited,
                child: SvgPicture.asset(
                  favorite ? GlobalVariable.urlImageTemplateBuyer + 'ic_favorite_template.svg' : GlobalVariable.urlImageTemplateBuyer + 'ic_unfavorite_template.svg',
                  height: GlobalVariable.ratioWidth(Get.context) * 20,
                  width: GlobalVariable.ratioWidth(Get.context) * 20
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget footer({double fontSize, double height}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 2),
          child: SvgPicture.asset(
            GlobalVariable.urlImageTemplateBuyer + 'ic_pin_blue_template.svg',
            width: GlobalVariable.ratioWidth(Get.context) * 11,
            height: GlobalVariable.ratioWidth(Get.context) * 11,
          ),
        ),
        SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: GlobalVariable.ratioWidth(Get.context) * 2.5,
            ),
            child: CustomText(
              location,
              color: Color(ListColor.colorGreyTemplate3),
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              height: 1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        )
      ],
    );
  }

  Widget button({
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
        GlobalVariable.ratioWidth(Get.context) * marginBottom
      ),
      width: width == null ? maxWidth ? MediaQuery.of(Get.context).size.width : null : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
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
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        border: useBorder
          ? Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * borderSize,
              color: borderColor ?? Color(ListColor.colorBlue),
            )
          : null
      ),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
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
              GlobalVariable.ratioWidth(Get.context) * paddingBottom
            ),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            child: customWidget == null
              ? CustomText(
                  text ?? "",
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                )
              : customWidget,
          )
        ),
      ),
    );
  }
}