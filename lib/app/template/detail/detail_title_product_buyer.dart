import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class InfoDetailTitleProductBuyer {
  final String label;
  final String value;

  const InfoDetailTitleProductBuyer({
    @required this.label,
    @required this.value,
  });
}

enum PromoType {
  KABKOTA,
  NASIONAL,
}

class DetailTitleProductBuyer extends StatelessWidget {
  
  final PromoType promoType;
  final String promoLocation;
  final String adName;
  final String adPriceInfo;
  final TextStyle styleAdPriceInfo;
  final String adPrice;
  final String adDiscPrice;
  final InfoDetailTitleProductBuyer adInfo;
  final String adLocation;
  final DateTime adDate;
  final bool hidePrice;

  DetailTitleProductBuyer({
    @required this.adName,
    this.adPriceInfo,
    this.styleAdPriceInfo = const TextStyle(
      color: Color(0xFF676767),
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 16.8/14,
    ),
    @required this.adPrice, // nullable
    this.adDiscPrice,
    this.adInfo,
    this.hidePrice = false,
    @required this.adLocation,
    @required this.adDate,
    this.promoType,
    this.promoLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          content(context),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 5,
            child: ColoredBox(color: Colors.transparent),
          ),
        ],
      ),
    );
  }

  Widget _badgePromo(BuildContext context) {
    return Container(
      width: GlobalVariable.ratioWidth(context) * 328,
      height: GlobalVariable.ratioWidth(context) * 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          GlobalVariable.ratioWidth(context) * 6,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "${GlobalVariable.urlImageTemplateBuyer}${promoType == PromoType.KABKOTA ? 'bg_promo_kota.svg' : 'bg_promo_nasional.svg'}",      
              width: GlobalVariable.ratioWidth(context) * 328,
              height: GlobalVariable.ratioWidth(context) * 28,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CustomText("Promo di ${promoLocation ?? 'Nasional'}",
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 16.8/14,
              textAlign: TextAlign.center,
              color: Color(promoType == PromoType.KABKOTA ? 0xFF000000 : 0xFFFFFFFF),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              withoutExtraPadding: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget content(BuildContext context) {
    var gap = SizedBox(height: GlobalVariable.ratioWidth(context) * 12);

    return Container(
      color: Color(ListColor.colorWhiteTemplate),
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (promoType != null)
            ...[
              _badgePromo(context),
              gap,
            ],
          CustomText(
            adName,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            withoutExtraPadding: true,
            height: 19.2 / 16,
          ),
          if (!hidePrice)
            ...[
              gap,
              Row(
                children: [
                  if (adDiscPrice != null)
                    Row(
                      children: [
                        CustomText(
                          adDiscPrice,
                          color: Color(0xFF676767),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 19.2 / 16,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Color(0xFF676767),
                          withoutExtraPadding: true,
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(context) * 12,
                        ),
                      ],
                    ),
                  CustomText(
                    adPrice ?? "Harga Hubungi Penjual",
                    color: adPrice == null ? Color(ListColor.colorBlue) : null,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 24 / 20,
                    withoutExtraPadding: true,
                  ),
                ],
              ),
            ],
          if (adPriceInfo != null)
            CustomText(
              adPriceInfo,
              color: styleAdPriceInfo.color,
              fontWeight: styleAdPriceInfo.fontWeight,
              fontSize: styleAdPriceInfo.fontSize,
              height: styleAdPriceInfo.height,
              withoutExtraPadding: true,
            ),
          if (adInfo != null)
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(context) * 12,
              ),
              child: RichText(
                text: TextSpan(
                  text: adInfo.label,
                  children: [
                    TextSpan(
                      text: ": ${adInfo.value}",
                      style: TextStyle(
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                  style: TextStyle(
                    color: Color(0xFF676767),
                    fontFamily: "AvenirNext",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1,
                  ),
                ),
              ),
            ),
          gap,
          Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      GlobalVariable.urlImageTemplateBuyer + 'temp_location_blue.svg',
                      width: GlobalVariable.ratioWidth(context) * 18,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
                    Expanded(
                      child: CustomText(
                        adLocation,
                        height: 24 / 20,
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorGreyTemplate),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              CustomText(
                Utils.formatDate(
                  value: adDate.toIso8601String(),
                  format: "dd MMM yyyy",
                ),
                withoutExtraPadding: true,
                color: Color(ListColor.colorGreyTemplate),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
