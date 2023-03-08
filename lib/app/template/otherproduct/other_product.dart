import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';


class OtherProduct extends StatelessWidget {
  final String urlimg;
  final String headertext;
  final String joined;
  final Function ontap;
  final bool isVerified;

  const OtherProduct({
    @required this.urlimg,
    @required this.headertext,
    @required this.joined,
    @required this.ontap,
    this.isVerified = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GlobalVariable.ratioWidth(context) * 155,
      width: GlobalVariable.ratioWidth(context) * 360,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(context) * 24,),
          Container(
            height: GlobalVariable.ratioWidth(context) * 59,
            width: GlobalVariable.ratioWidth(context) * 328,
            // color: Colors.red,
            child: Row(
              children: [
                _photoWidget(
                  isVerified: isVerified, 
                  urlimg: urlimg
                ),
                SizedBox(width: GlobalVariable.ratioWidth(context) * 20),
                Container(
                  height: GlobalVariable.ratioWidth(context) * 37,
                  width: GlobalVariable.ratioWidth(context) * 240,
                  // color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        headertext, 
                        fontSize: 16, 
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 2),
                      Row(
                        children: [
                          CustomText(
                            'Anggota Sejak : ', 
                            fontSize: 12, 
                            fontWeight: FontWeight.w500, 
                            color: Color(0xFF676767)
                          ),
                          CustomText(
                            joined, 
                            fontSize: 12, 
                            fontWeight: FontWeight.w500
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 12,
          ),
          _lineSaparator(),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button(
                onTap: ontap, 
                height: 32, 
                width: 328, 
                backgroundColor: Color(0xFF176CF7), 
                text: 'Hubungi', color: Colors.white, 
                fontSize: 14, 
                fontWeight: FontWeight.w600
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _lineSaparator() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      height: 1,
      width: MediaQuery.of(Get.context).size.width,
      color: Color(ListColor.colorLightGrey10)
    );
  }

  Widget _photoWidget({
    @required bool isVerified,
    @required String urlimg
  }) {
    return Container(
      width: GlobalVariable.ratioWidth(Get.context) * 59,
      height: GlobalVariable.ratioWidth(Get.context) * 59,
      child: Stack(
        children: [
          ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              urlimg,
              width: GlobalVariable.ratioWidth(Get.context) * 59,
              height: GlobalVariable.ratioWidth(Get.context) * 59,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Image.asset(
                  'assets/smile_icon.png',
                  width: GlobalVariable.ratioWidth(Get.context) * 59,
                  height: GlobalVariable.ratioWidth(Get.context) * 59,
                  fit: BoxFit.cover
                );
              },
              errorBuilder: (context, child, stackTrace) {
                return Image.asset(
                  'assets/smile_icon.png',
                  width: GlobalVariable.ratioWidth(Get.context) * 59,
                  height: GlobalVariable.ratioWidth(Get.context) * 59,
                  fit: BoxFit.cover);
              },
            ),
          ),
          if (isVerified) ...[
            Positioned(
              right: GlobalVariable.ratioWidth(Get.context) * 5.16,
              top: GlobalVariable.ratioWidth(Get.context) * 5.16,
                child: Image.asset(
                  GlobalVariable.urlImageTemplateBuyer + 'verif_buy.png', 
                  height: GlobalVariable.ratioWidth(Get.context) * 13, 
                  width: GlobalVariable.ratioWidth(Get.context) * 13
              )
            )
          ]
        ],
      ),
    );
  }

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
}