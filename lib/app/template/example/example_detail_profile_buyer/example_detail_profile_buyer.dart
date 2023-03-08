import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ExampleDetailProfileBuyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetail(
        title: "Example Detail Profile",
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 24,
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 12,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 180),
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 62,
                        height: GlobalVariable.ratioWidth(context) * 62,
                        child: Image.asset(
                          'assets/smile_icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(context) * 20,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "Adi Perwira, 23 Tahun, Pria",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 8,
                        ),
                        CustomText(
                          "Posisi Yang Diharapkan:",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(ListColor.colorGreyTemplate3),
                        ),
                        CustomText(
                          "Property Manager",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: GlobalVariable.ratioWidth(context) * 0.5,
                  color: Color(ListColor.colorGreyTemplate2),
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(context) * 12,
                    bottom: GlobalVariable.ratioWidth(context) * 10,
                  ),
                ),
                // WIDGET FOR DETAIL
                Container(
                  margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(context) * 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/ic_profil.svg",
                        width: GlobalVariable.ratioWidth(context) * 14,
                        height: GlobalVariable.ratioWidth(context) * 14,
                        color: Color(ListColor.colorBlueTemplate1),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 9,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            "Preferensi Tempat Kerja",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorGreyTemplate3),
                            withoutExtraPadding: true,
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 10, // -2px CustomText
                          ),
                          CustomText(
                            "Kota Surabaya",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 6),
                _button(
                  context: context,
                  onTap: () {},
                  borderRadius: 6,
                  backgroundColor: Colors.white,
                  borderColor: Color(ListColor.colorBlueTemplate1),
                  useBorder: true,
                  borderSize: 1,
                  height: 32,
                  customWidget: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/ic_phone.svg",
                          width: GlobalVariable.ratioWidth(context) * 14,
                          height: GlobalVariable.ratioWidth(context) * 14,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                        CustomText(
                          "Hubungi",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PRIVATE CUSTOM BUTTON
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
      margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(context) * marginLeft, GlobalVariable.ratioWidth(context) * marginTop,
          GlobalVariable.ratioWidth(context) * marginRight, GlobalVariable.ratioWidth(context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(context).size.width
              : null
          : GlobalVariable.ratioWidth(context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(context) * 4,
                    spreadRadius: 0,
                    offset: Offset(0, GlobalVariable.ratioWidth(context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(context) * paddingLeft, GlobalVariable.ratioWidth(context) * paddingTop,
                  GlobalVariable.ratioWidth(context) * paddingRight, GlobalVariable.ratioWidth(context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(borderRadius)),
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
