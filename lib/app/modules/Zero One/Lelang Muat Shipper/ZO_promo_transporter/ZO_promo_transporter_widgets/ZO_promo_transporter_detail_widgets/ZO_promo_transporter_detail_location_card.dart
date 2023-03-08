import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_vertical_dash.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_promo_transporter_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_detail_widgets/ZO_promo_transporter_detail_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterDetailLocationCard extends StatelessWidget {
  final ZoPromoTransporterKeyModel data;
  const ZoPromoTransporterDetailLocationCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointSize = GlobalVariable.ratioFontSize(context) * 16;
    final pickup = '${data.pickupLocationName}';
    final pickupCity = '${data.pickupCity}';
    final destination = '${data.destinationLocationName}';
    final destinationCity = '${data.destinationCity}';
    final pickupDescription = data.pickupKecamatanPanjang.trim().isEmpty
        ? '${data.pickupKecamatan}'
        : '${data.pickupKecamatanPanjang}';
    final destinationDescription =
        data.destinationKecamatanPanjang.trim().isEmpty
            ? '${data.destinationKecamatan}'
            : '${data.destinationKecamatanPanjang}';

    Widget buildLocationTitle(String name, String city) {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'AvenirNext',
            color: Color(ListColor.colorBlack),
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            // height: GlobalVariable.ratioFontSize(context) * 16.8 / 14,
          ),
          children: [
            TextSpan(
              text: '$name',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: ' ($city)',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    Widget buildDescription(String description) {
      return CustomText(
        '$description',
        color: Color(ListColor.colorLightGrey4),
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 16.8 / 14,
      );
    }

    Widget buildPoint(String asset) {
      return SizedBox(
        width: pointSize,
        height: pointSize,
        child: Center(
          child: SvgPicture.asset(
            '$asset',
            width: pointSize,
            height: pointSize,
          ),
        ),
      );
    }

    Widget buildLine() {
      return SizedBox(
        width: pointSize,
        height: double.infinity,
        child: Center(
          child: SizedBox(
            height: double.infinity,
            child: ZoPromoTransporterVerticalDash(
              width: 1.5,
              height: double.infinity,
            ),
            // SvgPicture.asset(
            //   "assets/garis_alur_perjalanan.svg",
            //   fit: BoxFit.fill,
            //   height: double.infinity,
            //   width: 1.5,
            // ),
          ),
        ),
      );
    }

    // final spacer = SizedBox(height: GlobalVariable.ratioWidth(context) * 4);

    return ZoPromoTransporterDetailCard.grey(
      title: ZoPromoTransporterStrings.detailLocationTitle.tr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    buildPoint("assets/titik_biru_pickup.svg"),
                    Expanded(child: buildLine()),
                  ],
                ),
                SizedBox(width: GlobalVariable.ratioWidth(context) * 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 1,
                      ),
                      buildLocationTitle(pickup, pickupCity),
                      // spacer,
                      buildDescription(pickupDescription),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPoint("assets/titik_biru_kuning_destinasi.svg"),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: GlobalVariable.ratioWidth(context) * 1,
                    ),
                    buildLocationTitle(destination, destinationCity),
                    // spacer,
                    buildDescription(destinationDescription),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
