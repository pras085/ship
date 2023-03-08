import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../global_variable.dart';

class DetailSellerProfileBuyer extends StatelessWidget {

  final String profileImage;
  final String profileName;
  final String profileSince;
  final String reportText;
  final bool isVerified;
  final VoidCallback onLihatBarang;
  final VoidCallback onHubungi;

  const DetailSellerProfileBuyer({
    @required this.profileImage,
    @required this.profileName,
    @required this.profileSince,
    @required this.isVerified,
    @required this.reportText,
    @required this.onLihatBarang,
    @required this.onHubungi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: GlobalVariable.ratioWidth(context) * 135,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 14,
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 12,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorWhiteTemplate),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(ListColor.colorGreyTemplate2),
                      width: GlobalVariable.ratioWidth(context) * 0.5,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: GlobalVariable.ratioWidth(context) * 40,
                      width: GlobalVariable.ratioWidth(context) * 40,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              height: GlobalVariable.ratioWidth(context) * 40,
                              width: GlobalVariable.ratioWidth(context) * 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: GlobalVariable.ratioWidth(context) * 1,
                                  color: Color(ListColor.colorBorderTemplate),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(profileImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                            ),
                          ),
                          if (isVerified)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: SvgPicture.asset(
                                GlobalVariable.urlImageTemplateBuyer + 'ic_buyer_verified_template.svg',
                                width: GlobalVariable.ratioWidth(context) * 13,
                                height: GlobalVariable.ratioWidth(context) * 13,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            profileName,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            withoutExtraPadding: true,
                          ),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                          RichText(
                            text: TextSpan(
                              text: 'Anggota Sejak : ',
                              style: TextStyle(
                                fontFamily: 'AvenirNext',
                                fontSize: GlobalVariable.ratioWidth(context) * 12,
                                color: Color(ListColor.colorGreyTemplate3),
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: profileSince,
                                  style: TextStyle(
                                    fontFamily: 'AvenirNext',
                                    fontSize: GlobalVariable.ratioWidth(context) * 12,
                                    color: Color(ListColor.colorBlackTemplate1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              componentFixedButton(context)
            ],
          ),
        ),
        componentLaporkanIklan(context, reportText),
      ],
    );
  }

  Widget componentLaporkanIklan(BuildContext context, String text) {
    var gap = SizedBox(width: GlobalVariable.ratioWidth(context) * 2);
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: GlobalVariable.ratioWidth(context) * 46,
      ),
      color: Color(ListColor.colorBlueTemplate2).withOpacity(0.5),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text,
            withoutExtraPadding: true,
          ),
          gap,
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  GlobalVariable.urlImageTemplateBuyer + 'ic_flag_template.svg',
                  height: gap.width + 12,
                  color: Color(ListColor.colorBlueTemplate1),
                ),
                gap,
                CustomText(
                  'Laporkan',
                  withoutExtraPadding: true,
                  color: Color(ListColor.colorBlueTemplate1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget componentFixedButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 12,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 24,
      ),
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhiteTemplate),
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _button(
            context: context,
            width: 197,
            height: 32,
            useBorder: true,
            borderColor: Color(ListColor.colorBlue),
            borderSize: 1,
            borderRadius: 18,
            text: 'Lihat Barang Lainnya',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorBlue),
            backgroundColor: Color(ListColor.colorWhiteTemplate),
            onTap: onLihatBarang,
          ),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
          _button(
            context: context,
            width: 119,
            height: 32,
            borderRadius: 18,
            onTap: onHubungi,
            backgroundColor: Color(ListColor.colorBlueTemplate1),
            text: 'Hubungi',
            color: Color(ListColor.colorWhiteTemplate),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            useBorder: false,
          ),
        ],
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
    bool useBorder = true,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
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
      height:
          height == null ? null : GlobalVariable.ratioWidth(context) * height,
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
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
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
