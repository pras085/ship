import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'detail_title_compro_detail_buyer.dart';

class DetailTitleComproBuyer extends StatelessWidget {

  final String image;
  final String title;
  final Widget titleContent;
  final bool isVerified;
  final List<DetailTitleComproDetailBuyer> detailChildren;
  final VoidCallback onTapHubungi;
  final String textHubungi;
  final String textLaporkan;
  final VoidCallback onTapLaporkan;

  const DetailTitleComproBuyer({
    @required this.image,
    @required this.title,
    this.titleContent,
    this.isVerified = false,
    this.detailChildren,
    this.textHubungi,
    @required this.onTapHubungi,
    @required this.textLaporkan,
    @required this.onTapLaporkan,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
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
                    Container(
                      width: GlobalVariable.ratioWidth(context) * 73,
                      height: GlobalVariable.ratioWidth(context) * 73,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(ListColor.colorWhite),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(ListColor.colorBlackTemplate).withOpacity(0.15),
                            blurRadius: GlobalVariable.ratioWidth(context) * 16,
                            offset: Offset(
                              GlobalVariable.ratioWidth(context) * 0,
                              GlobalVariable.ratioWidth(context) * -4,
                            ),
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(image),
                          onError: (exception, stackTrace) {
                            return Image.asset(
                              'assets/smile_icon.png',
                              height: GlobalVariable.ratioWidth(context) * 73,
                              fit: BoxFit.contain
                            );
                          },
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(context) * 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (titleContent != null) titleContent,
                          SizedBox(
                            height: GlobalVariable.ratioWidth(context) * 8,
                          ),
                          if (isVerified)
                            Row(
                              children: [
                                SvgPicture.asset(
                                  GlobalVariable.urlImageTemplateBuyer + 'ic_buyer_verified_template.svg',
                                  width: GlobalVariable.ratioWidth(context) * 13,
                                  height: GlobalVariable.ratioWidth(context) * 13,
                                ),
                                SizedBox(
                                  width: GlobalVariable.ratioWidth(context) * 6,
                                ),
                                CustomText(
                                  "Verified",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(ListColor.colorGreen6),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Divider
                if (detailChildren.isNotEmpty)
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
                if (detailChildren.isNotEmpty) ...detailChildren else SizedBox(height: GlobalVariable.ratioWidth(context) * 10),

                SizedBox(height: GlobalVariable.ratioWidth(context) * 6),
                _button(
                  context: context,
                  onTap: () => onTapHubungi(),
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
                        if (textHubungi == null) ...[
                          SvgPicture.asset(
                            "assets/detail_compro_buyer/ic_blue_phone_buyer.svg",
                            width: GlobalVariable.ratioWidth(context) * 14,
                            height: GlobalVariable.ratioWidth(context) * 14,
                          ),
                          SizedBox(width: GlobalVariable.ratioWidth(context)*4),
                        ],
                        CustomText(
                          textHubungi ?? "Hubungi",
                          fontSize: 14,
                          withoutExtraPadding: true,
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
          componentLaporkanIklan(context),
        ],
      ),
    );
  }

  Widget componentLaporkanIklan(BuildContext context) {
    var gap = SizedBox(width: GlobalVariable.ratioWidth(context) * 2);
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 46,
      color: Color(ListColor.colorBlueTemplate2).withOpacity(0.5),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            textLaporkan,
            withoutExtraPadding: true,
          ),
          gap,
          InkWell(
            onTap: onTapLaporkan,
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
