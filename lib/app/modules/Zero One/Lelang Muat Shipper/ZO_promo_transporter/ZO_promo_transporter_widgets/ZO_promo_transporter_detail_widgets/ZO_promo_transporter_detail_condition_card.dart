import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_detail_widgets/ZO_promo_transporter_detail_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterDetailConditionCard extends StatelessWidget {
  final String data;
  final bool isLoading;
  const ZoPromoTransporterDetailConditionCard({
    Key key,
    @required this.data,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoPromoTransporterDetailCard.grey(
      title: ZoPromoTransporterStrings.detailConditionTitle.tr,
      child: isLoading
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : CustomText(
              (data?.isEmpty ?? true) ? '-' : '$data',
              color: Color(ListColor.colorDarkGrey3),
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 16.8 / 14,
              withoutExtraPadding: true,
              textAlign: TextAlign.justify,
            ),
    );
  }
}
