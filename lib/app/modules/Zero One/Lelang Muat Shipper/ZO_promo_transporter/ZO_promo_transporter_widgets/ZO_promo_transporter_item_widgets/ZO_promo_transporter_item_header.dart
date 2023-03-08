import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterItemHeader
    extends GetView<ZoPromoTransporterController> {
  final int index;

  const ZoPromoTransporterItemHeader({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var avatarWidget = ClipOval(
      child: Material(
        shape: const CircleBorder(),
        color: Color(ListColor.color4),
        child: Container(
          width: GlobalVariable.ratioFontSize(context) * 32,
          height: GlobalVariable.ratioFontSize(context) * 32,
          color: const Color(0xffff4000),
          child: Center(
            child: Obx(() {
              var item = controller.promoData[index].key;
              var avatar = item?.transporterAvatar;
              var name = item?.transporterName?.trim() ?? '';
              var initial = name.isEmpty ? 'N/A' : name.characters.first;
              var fallback = Center(
                child: CustomText(
                  initial,
                  color: Color(ListColor.colorWhite),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  height: (12 / 10),
                  withoutExtraPadding: true,
                ),
              );

              return avatar == null || avatar.isEmpty
                  ? fallback
                  : Image.network(
                      avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => fallback,
                    );
            }),
          ),
        ),
      ),
    );
    return Container(
      color: Color(ListColor.colorLightBlue),
      padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
      child: Obx(
        () => Row(
          children: [
            avatarWidget,
            SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
            Expanded(
              child: CustomText(
                controller.promoData[index].key.transporterName ?? 'N/A',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: (16.8 / 14),
                withoutExtraPadding: true,
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(context) * 8,
            ),
            if (controller.promoData[index].key.transporterIsGold == '1') ...[
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: Get.context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.ratioWidth(context) * 34,
                        ),
                        child: _buildGoldTransporterDialog(context),
                      );
                    },
                  );
                },
                child: Image.asset(
                  "assets/ic_gold.png",
                  width: GlobalVariable.ratioFontSize(Get.context) * 21,
                  // height: GlobalVariable.ratioFontSize(Get.context) * 27,
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGoldTransporterDialog(BuildContext context) {
    return Dialog(
      key: GlobalKey<State>(),
      insetPadding: EdgeInsets.symmetric(vertical: 34.0),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.bottomCenter, children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/ic_gold.png",
                      height: GlobalVariable.ratioFontSize(Get.context) * 22.88,
                      width: GlobalVariable.ratioFontSize(Get.context) * 17.29,
                    ),
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioFontSize(context) * 4,
                  ),
                  CustomText(
                    "Gold Transporter".tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 16.8 / 14,
                    withoutExtraPadding: true,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 3, top: 3),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.close_rounded,
                      color: Color(ListColor.color4),
                      size: GlobalVariable.ratioFontSize(context) * 24,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: GlobalVariable.ratioFontSize(context) * 12,
          ),
          Container(
            padding: EdgeInsets.only(
              left: GlobalVariable.ratioFontSize(context) * 16,
              right: GlobalVariable.ratioFontSize(context) * 16,
              bottom: GlobalVariable.ratioFontSize(context) * 8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "        " +
                      "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldHead"
                          .tr,
                  textAlign: TextAlign.justify,
                  fontSize: 14,
                  height: (16.8 / 14),
                  withoutExtraPadding: true,
                  color: Color(ListColor.colorDarkGrey3),
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: GlobalVariable.ratioFontSize(context) * 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: SvgPicture.asset(
                        "assets/check_blue_ic.svg",
                        height: GlobalVariable.ratioFontSize(context) * 14,
                        width: GlobalVariable.ratioFontSize(context) * 14,
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioFontSize(context) * 4,
                    ),
                    Expanded(
                      child: CustomText(
                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldSatu"
                            .tr,
                        textAlign: TextAlign.justify,
                        fontSize: 14,
                        height: (16.8 / 14),
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorDarkGrey3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: GlobalVariable.ratioFontSize(context) * 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: SvgPicture.asset(
                        "assets/check_blue_ic.svg",
                        height: GlobalVariable.ratioFontSize(context) * 14,
                        width: GlobalVariable.ratioFontSize(context) * 14,
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioFontSize(context) * 4,
                    ),
                    Expanded(
                      child: CustomText(
                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldDua"
                            .tr,
                        textAlign: TextAlign.justify,
                        fontSize: 14,
                        height: (16.8 / 14),
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorDarkGrey3),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: GlobalVariable.ratioFontSize(context) * 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: SvgPicture.asset(
                        "assets/check_blue_ic.svg",
                        height: GlobalVariable.ratioFontSize(context) * 14,
                        width: GlobalVariable.ratioFontSize(context) * 14,
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioFontSize(context) * 4,
                    ),
                    Expanded(
                      child: CustomText(
                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldTiga"
                            .tr,
                        textAlign: TextAlign.justify,
                        fontSize: 14,
                        height: (16.8 / 14),
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorDarkGrey3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: GlobalVariable.ratioFontSize(context) * 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: SvgPicture.asset(
                        "assets/check_blue_ic.svg",
                        height: GlobalVariable.ratioFontSize(context) * 14,
                        width: GlobalVariable.ratioFontSize(context) * 14,
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioFontSize(context) * 4,
                    ),
                    Expanded(
                      child: CustomText(
                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldEmpat"
                            .tr,
                        textAlign: TextAlign.justify,
                        fontSize: 14,
                        height: (16.8 / 14),
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorDarkGrey3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: GlobalVariable.ratioFontSize(context) * 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: SvgPicture.asset(
                        "assets/check_blue_ic.svg",
                        height: GlobalVariable.ratioFontSize(context) * 14,
                        width: GlobalVariable.ratioFontSize(context) * 14,
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioFontSize(context) * 4,
                    ),
                    Expanded(
                      child: CustomText(
                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldLima"
                            .tr,
                        textAlign: TextAlign.justify,
                        fontSize: 14,
                        height: (16.8 / 14),
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorDarkGrey3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: GlobalVariable.ratioFontSize(context) * 12,
                ),
                CustomText(
                  "        " +
                      "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldFooter"
                          .tr,
                  textAlign: TextAlign.justify,
                  fontSize: 14,
                  height: (16.8 / 14),
                  withoutExtraPadding: true,
                  color: Color(ListColor.colorDarkGrey3),
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 16,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
