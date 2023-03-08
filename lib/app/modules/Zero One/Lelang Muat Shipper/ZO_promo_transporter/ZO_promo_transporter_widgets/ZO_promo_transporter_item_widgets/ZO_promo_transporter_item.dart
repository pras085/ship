import 'package:flutter/material.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_item_widgets/ZO_promo_transporter_item_body.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_item_widgets/ZO_promo_transporter_item_footer.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_item_widgets/ZO_promo_transporter_item_header.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';

class ZoPromoTransporterItem extends StatelessWidget {
  final int index;
  const ZoPromoTransporterItem({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 16,
            color: Color(ListColor.colorBlack).withOpacity(0.2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ZoPromoTransporterItemHeader(index: index),
            ZoPromoTransporterItemBody(index: index),
            Divider(
              color: Color(ListColor.colorLightGrey2),
              height: 0,
              thickness: 0.5,
            ),
            ZoPromoTransporterItemFooter(index: index),
          ],
        ),
      ),
    );
  }
}
