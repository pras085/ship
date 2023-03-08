import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaInfo extends GetView<ZoPromoTransporterController> {
  const ZoNotifikasiHargaInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xffD3EBFF),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * 14,
          GlobalVariable.ratioWidth(context) * 8,
          GlobalVariable.ratioWidth(context) * 14,
          GlobalVariable.ratioWidth(context) * 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: GlobalVariable.ratioFontSize(context) * 12,
                        color: Colors.black,
                        height:
                            GlobalVariable.ratioFontSize(context) * (14.4 / 12),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'AvenirNext',
                      ),
                      children: [
                        TextSpan(
                          text: ZoNotifikasiHargaStrings.infoPrefix.tr + " ",
                        ),
                        TextSpan(
                          text: ZoNotifikasiHargaStrings.infoBold.tr,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: " " + ZoNotifikasiHargaStrings.infoSuffix.tr,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
