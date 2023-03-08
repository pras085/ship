import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_sheet_widgets/ZO_promo_transporter_sheet_base.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterSheetPromoCondition extends StatelessWidget {
  final String conditions;
  final bool isLoading;

  const ZoPromoTransporterSheetPromoCondition({
    Key key,
    this.conditions,
    this.isLoading = false,
  }) : super(key: key);

  static ShapeBorder getShape() => ZoPromoTransporterSheetBase.getShape();
  static Color getBackgroundColor() =>
      ZoPromoTransporterSheetBase.getBackgroundColor();

  @override
  Widget build(BuildContext context) {
    final isEmpty = (conditions?.trim()?.isEmpty ?? true) ||
        conditions == 'GlobalLabelErrorNullResponse'.tr;
    return ZoPromoTransporterSheetBase(
      title: ZoPromoTransporterStrings.promoConditions,
      titleColor: Color(ListColor.colorBlue),
      rows: [
        if (isLoading)
          Container(
            padding: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(context) * 16),
            width: context.width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        else
          Padding(
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 16,
            ),
            child: CustomText(
              isEmpty
                  ? ZoPromoTransporterStrings.emptyPromoConditions.tr
                  : conditions,
              color: Color(
                  isEmpty ? ListColor.colorDarkGrey : ListColor.colorDarkGrey3),
              fontSize: 14,
              height: (16.8 / 14),
              withoutExtraPadding: true,
              fontWeight: FontWeight.w600,
              fontStyle: isEmpty ? FontStyle.italic : FontStyle.normal,
              textAlign: TextAlign.justify,
            ),
          ),
      ],
    );
  }
}
