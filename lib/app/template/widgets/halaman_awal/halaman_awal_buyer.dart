import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../../global_variable.dart';

class HalamanAwalBuyer extends StatelessWidget {

  final String title;
  final Widget image;
  final String location;
  final VoidCallback onBack;
  final VoidCallback onLocationTap;
  final List<Widget> children;

  const HalamanAwalBuyer({
    @required this.title,
    @required this.image,
    @required this.location,
    @required this.onLocationTap,
    this.onBack,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(ListColor.colorBlueTemplate),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ColoredBox(
              color: Colors.white,
              child: SafeArea(
                bottom: false,
                child: Container(
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(context) * 11,
                    bottom: GlobalVariable.ratioWidth(context) * 11,
                    left: GlobalVariable.ratioWidth(context) * 16,
                    right: GlobalVariable.ratioWidth(context) * 16
                  ),
                  height: GlobalVariable.ratioWidth(context) * 24,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton(
                          context: context,
                          iconColor: Color(ListColor.colorWhite),
                          backgroundColor: Color(ListColor.colorBlueTemplate),
                          onTap: onBack,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          title,
                          fontSize: 16,
                          color: Color(ListColor.colorBlueTemplate),
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: GlobalVariable.ratioWidth(context) * 131,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ColoredBox(
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: GlobalVariable.ratioWidth(context) * 5,
                      color: Color(ListColor.colorBlueTemplate),
                    ),
                  ),
                  Positioned.fill(
                    child: image,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Color(ListColor.colorBlueTemplate),
              child: Column(
                children: [
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 16,
                  ),
                  _button(
                    onTap: onLocationTap,
                    backgroundColor: Color(ListColor.colorWhite),
                    width: 272,
                    height: 24,
                    paddingLeft: 8,
                    paddingRight: 0,
                    paddingTop: 2,
                    paddingBottom: 2,
                    borderRadius: 8,
                    customWidget: Center(
                      child: Row(
                        children: [
                          SvgPicture.asset(GlobalVariable.urlImageTemplateBuyer + "template_location_icon_buyer.svg",
                            width: GlobalVariable.ratioWidth(context) * 8.67,
                            height: GlobalVariable.ratioWidth(context) * 12.53,
                            color: Color(ListColor.colorBlueTemplate),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 15.23,
                          ),
                          Expanded(
                            child: Center(
                              child: CustomText(location,
                                fontSize: 14,
                                color: Color(ListColor.colorBlueTemplate),
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 8,
                          ),
                          SvgPicture.asset(GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_down_frame.svg',
                            width: GlobalVariable.ratioWidth(context) * 24,
                            height: GlobalVariable.ratioWidth(context) * 24,
                            color: Color(ListColor.colorBlueTemplate),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 24,
                  ),
                  Container(
                    width: GlobalVariable.ratioWidth(context) * 328,
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(context) * 16,
                      horizontal: GlobalVariable.ratioWidth(context) * 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 20),
                    ),
                    child: Column(
                      children: [
                        CustomText("Apa yang ingin Anda Cari?",
                          fontSize: 14,
                          color: Color(ListColor.colorBlack),
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                          withoutExtraPadding: true,
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 14,
                        ),
                        StaggeredGrid.count( 
                          crossAxisCount: 2,
                          mainAxisSpacing: GlobalVariable.ratioWidth(context) * 12,
                          crossAxisSpacing: GlobalVariable.ratioWidth(context) * 8,
                          children: children,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget ItemMenuHalamanAwalBuyer({
  @required BuildContext context,
  @required Widget image,
  @required String menuTitle,
  @required VoidCallback onTap,
}) {
  return Container(
    width: GlobalVariable.ratioWidth(context) * 152,
    height: GlobalVariable.ratioWidth(context) * 183,
    padding: EdgeInsets.symmetric(
      vertical: GlobalVariable.ratioWidth(context) * 10,
      horizontal: GlobalVariable.ratioWidth(context) * 12,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 10),
      border: Border.all(
        width: GlobalVariable.ratioWidth(context) * 1,
        color: Color(ListColor.colorGreyTemplate2),
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(
            0, 
            GlobalVariable.ratioWidth(context) * 4,
          ),
          blurRadius: GlobalVariable.ratioWidth(context) * 4,
          color: Color(0xFF7D7D7D).withOpacity(0.15),
        ),
      ],
    ),
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            width: GlobalVariable.ratioWidth(context) * 128,
            height: GlobalVariable.ratioWidth(context) * 117,
            child: image,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 10,
          ),
          SizedBox(
            width: GlobalVariable.ratioWidth(context) * 128,
            height: GlobalVariable.ratioWidth(context) * 34,
            child: Center(
              child: CustomText(menuTitle,
                fontSize: 14,
                color: Color(ListColor.colorBlack),
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// PRIVATE CUSTOM BUTTON 
Widget _button({
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