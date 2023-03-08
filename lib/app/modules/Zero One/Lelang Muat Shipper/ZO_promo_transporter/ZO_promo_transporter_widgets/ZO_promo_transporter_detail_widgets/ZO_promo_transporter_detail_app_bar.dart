import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterDetailAppBar
    extends GetView<ZoPromoTransporterController> {
  ZoPromoTransporterDetailAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ListColor.colorBlue),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image(
                    image: AssetImage("assets/fallin_star_3_icon.png"),
                    height: GlobalVariable.ratioFontSize(context) * 67,
                    width: GlobalVariable.ratioFontSize(context) * 138,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: ClipOval(
                          child: Material(
                            shape: const CircleBorder(),
                            color: Color(ListColor.colorWhite),
                            child: InkWell(
                              onTap: () {
                                controller.onDetailTooltipClose();
                                Get.back();
                              },
                              child: Container(
                                width:
                                    GlobalVariable.ratioFontSize(context) * 24,
                                height:
                                    GlobalVariable.ratioFontSize(context) * 24,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size:
                                        GlobalVariable.ratioFontSize(context) *
                                            14,
                                    color: Color(ListColor.colorBlue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                      Expanded(
                        child: CustomText(
                          ZoPromoTransporterStrings.detailAppBarTitle.tr,
                          textAlign: TextAlign.left,
                          color: Color(ListColor.colorWhite),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
