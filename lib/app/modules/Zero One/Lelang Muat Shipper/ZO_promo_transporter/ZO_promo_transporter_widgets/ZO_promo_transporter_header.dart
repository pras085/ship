import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterHeader extends StatelessWidget {
  const ZoPromoTransporterHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: GlobalVariable.ratioWidth(context) * 159,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/background_header_lelang_muatan.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 20,
                right: GlobalVariable.ratioWidth(context) * 24,
              ),
              child: Image(
                image: AssetImage(
                  "assets/ic_mobile_header_lelang_muatan.png",
                ),
                width: GlobalVariable.ratioWidth(context) * 92,
                height: GlobalVariable.ratioWidth(context) * 91,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: GlobalVariable.ratioWidth(context) * 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    ZoPromoTransporterStrings.headerTitle.tr,
                    color: Colors.white,
                    fontSize: 24,
                    height: 28.8 / 24,
                    withoutExtraPadding: true,
                    fontWeight: FontWeight.w600,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(context) * 9,
                    ),
                    child: CustomText(
                      ZoPromoTransporterStrings.headerDescription.tr,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: (16.8 / 14),
                      withoutExtraPadding: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
