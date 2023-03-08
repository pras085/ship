import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterPopUp extends GetView<ZoPromoTransporterController> {
  const ZoPromoTransporterPopUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorLightGrey).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(ListColor.colorYellow4),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(context) * 18,
                GlobalVariable.ratioWidth(context) * 26,
                GlobalVariable.ratioWidth(context) * 18,
                GlobalVariable.ratioWidth(context) * 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'AvenirNext',
                          fontSize: GlobalVariable.ratioFontSize(context) * 14,
                          color: Colors.black,
                          height: 25.2 / 14,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: ZoPromoTransporterStrings.popUpTitle.tr + " ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ZoPromoTransporterStrings.popUpDescription.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: GlobalVariable.ratioWidth(context) * 9.29,
                top: GlobalVariable.ratioWidth(context) * 9.4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.onPopUpClose,
                      child: Container(
                        child: SvgPicture.asset(
                          "assets/ic_close_zo.svg",
                          height: GlobalVariable.ratioFontSize(context) * 10,
                          color: Color(ListColor.colorBlack),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
