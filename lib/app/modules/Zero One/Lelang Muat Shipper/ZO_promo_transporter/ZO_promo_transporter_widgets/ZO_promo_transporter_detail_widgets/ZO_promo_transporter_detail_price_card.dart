import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_promo_transporter_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_detail_widgets/ZO_promo_transporter_detail_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_tooltip.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterDetailPriceCard
    extends GetView<ZoPromoTransporterController> {
  final List<ZoPromoTransporterDetailModel> data;
  const ZoPromoTransporterDetailPriceCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatCurrency(int number) {
      if (number == null) return null;
      return "Rp ${NumberFormat('#,###').format(number).replaceAll(',', '.')}";
    }

    return Stack(
      children: [
        ZoPromoTransporterDetailCard.yellow(
          title: ZoPromoTransporterStrings.detailPriceTitle.tr,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(context) * 12,
                ),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(ListColor.colorBlack),
                ),
              );
            },
            itemBuilder: (context, index) {
              final datum = data[index];

              final title = datum.title;
              final dimension = '${datum.dimension}';
              final normal =
                  int.tryParse(datum.normalPrice.replaceAll('.', ''));
              final promo = int.tryParse(datum.promoPrice.replaceAll('.', ''));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    '$title',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 16.8 / 14,
                    withoutExtraPadding: true,
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 10),
                  GestureDetector(
                    onTapDown: controller.onDimensionTap,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/ic_dimension.svg',
                          width: GlobalVariable.ratioFontSize(context) * 17,
                          height: GlobalVariable.ratioFontSize(context) * 17,
                        ),
                        SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
                        CustomText(
                          '$dimension',
                          color: Color(ListColor.colorBlack),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 14.4 / 12,
                          withoutExtraPadding: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 10),
                  if (normal != null &&
                      promo != null &&
                      normal != promo &&
                      normal > 0)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                formatCurrency(normal) ?? "Rp -",
                                color: Color(ListColor.colorRed),
                                // decoration: TextDecoration.lineThrough,
                                // decorationThickness: 2,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: (14.4 / 12),
                                withoutExtraPadding: true,
                              ),
                              CustomText(
                                " /" + ZoPromoTransporterStrings.unit.tr,
                                color: Color(ListColor.colorRed),
                                // decoration: TextDecoration.lineThrough,
                                // decorationThickness: 2,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                height: (12 / 10),
                                withoutExtraPadding: true,
                              ),
                            ],
                          ),
                          Positioned.fill(
                            // top: 4,
                            child: Divider(
                              color: Color(ListColor.colorRed),
                              thickness:
                                  GlobalVariable.ratioFontSize(context) * 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        formatCurrency(promo) ?? "Rp -",
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: (18 / 15),
                        withoutExtraPadding: true,
                      ),
                      CustomText(
                        " /" + ZoPromoTransporterStrings.unit.tr,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: (14.4 / 12),
                        withoutExtraPadding: true,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        Obx(
          () => controller.shouldShowDimensionTooltip()
              ? Positioned(
                  left: GlobalVariable.ratioWidth(context) * 16,
                  top: controller.getDetailTooltipLocalPosition(context)?.dy ==
                          null
                      ? 0
                      : controller.getDetailTooltipLocalPosition(context).dy -
                          (GlobalVariable.ratioWidth(context) * 70),
                  child: ZoPromoTransporterTooltip(
                    message: ZoPromoTransporterStrings.tooltipDimension.tr,
                    onTap: controller.onDetailTooltipClose,
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
