import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterNoPromo extends StatelessWidget {
  final bool isFilter;
  final void Function() onResetFilterTap;

  const ZoPromoTransporterNoPromo({
    Key key,
    this.isFilter = false,
    this.onResetFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: SvgPicture.asset(
            isFilter
                ? "assets/ic_management_lokasi_no_search.svg"
                : "assets/ic_management_lokasi_no_data.svg",
            width:
                GlobalVariable.ratioWidth(context) * (isFilter ? 81.18 : 82.32),
            height:
                GlobalVariable.ratioWidth(context) * (isFilter ? 92.74 : 75),
          ),
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * (isFilter ? 18.26 : 20),
        ),
        CustomText(
          isFilter
              ? ZoPromoTransporterStrings.noPromoWithFilterCaption.tr
              : ZoPromoTransporterStrings.noPromoCaption.tr,
          textAlign: TextAlign.center,
          color: Color(ListColor.colorLightGrey14),
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 16.8 / 14,
          withoutExtraPadding: true,
        ),
        if (isFilter) ...[
          SizedBox(height: GlobalVariable.ratioWidth(context) * 18),
          CustomText(
            ZoPromoTransporterStrings.noPromoWithFilterSeparator.tr,
            textAlign: TextAlign.center,
            color: Color(ListColor.colorLightGrey4),
            fontWeight: FontWeight.w600,
            fontSize: 14,
            height: 16.8 / 14,
            withoutExtraPadding: true,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 18),
          Material(
            color: Color(ListColor.colorBlue),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            child: InkWell(
              onTap: () => onResetFilterTap?.call(),
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioFontSize(Get.context) * 24,
                  vertical: GlobalVariable.ratioFontSize(Get.context) * 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child: CustomText(
                  ZoPromoTransporterStrings.noPromoWithFilterResetFilter.tr,
                  color: Color(ListColor.colorWhite),
                  fontSize: 12,
                  withoutExtraPadding: true,
                  height: 14.4 / 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
