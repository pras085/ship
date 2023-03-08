import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterItemFooter
    extends GetView<ZoPromoTransporterController> {
  final int index;

  const ZoPromoTransporterItemFooter({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ListColor.colorWhite),
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
        vertical: GlobalVariable.ratioWidth(context) * 7,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => controller.onTapPromoCondition(
                idPromo: controller.promoData[index].key.id),
            child: CustomText(
              ZoPromoTransporterStrings.promoConditions.tr,
              color: Color(ListColor.colorBlue),
              decoration: TextDecoration.underline,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: (14.4 / 12),
              withoutExtraPadding: true,
            ),
          ),
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            color: Color(ListColor.colorBlue),
            child: InkWell(
              onTap: () => controller.onTapDetail(index),
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(context) * 24,
                  vertical: GlobalVariable.ratioWidth(context) * 7,
                ),
                child: CustomText(
                  ZoPromoTransporterStrings.detailLabel.tr,
                  color: Color(ListColor.colorWhite),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: (14.4 / 12),
                  withoutExtraPadding: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
