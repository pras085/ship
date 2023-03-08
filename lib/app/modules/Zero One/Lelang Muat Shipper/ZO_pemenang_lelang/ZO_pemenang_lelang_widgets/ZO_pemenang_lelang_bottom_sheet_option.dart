import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_bottom_sheet_base.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPemenangLelangRateBottomSheet
    extends GetView<ZoPemenangLelangController> {
  final int winnerIndex;

  const ZoPemenangLelangRateBottomSheet({
    Key key,
    @required this.winnerIndex,
  }) : super(key: key);

  static ShapeBorder getShape() =>
      ZoPemenangLelangBaseBottomSheetBase.getShape();

  static Color getBackgroundColor() =>
      ZoPemenangLelangBaseBottomSheetBase.getBackgroundColor();

  @override
  Widget build(BuildContext context) {
    return ZoPemenangLelangBaseBottomSheetBase(
      title: "Opsi".tr,
      rows: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              // Get.back();
              var winner = controller.bidWinnerList[winnerIndex];

              // Get.back();
              print("Beri Nilai Transporter tapped");
              if (winner.star == null || winner.star < 1 || winner.star > 5) {
                var shouldRefresh = await Get.toNamed(
                  Routes.ZO_BERI_RATING +
                      "/${controller.bidInformation.value.id}"
                          "/${winner.transporterId}",
                  arguments: {
                    'transporter_name': winner.transporterName,
                    'truck_offer': winner.truckOffer,
                    'loginAS': controller.loginASval.value,
                    'idLelang': controller.bidInformation.value.id
                  },
                );
                if (shouldRefresh ?? false) {
                  Get.back(result: shouldRefresh ?? false);
                }
              } else {
                Get.back(result: false);
                // GlobalAlertDialog.showAlertDialogCustom(
                //   context: context,
                //   message:
                //       "LelangMuatPesertaLelangPesertaLelangLabelTitlePopNoNilaiDuaKali"
                //           .tr,
                //   labelButtonPriority1: "Oke".tr,
                //   labelButtonPriority2: "",
                //   onTapPriority1: () {},
                //   onTapPriority2: () {},
                //   onTapCloseButton: () {},
                //   title: "",
                // );
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return Dialog(
                        // key: _keyDialog,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                                // alignment: Alignment.bottomCenter,
                                children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(right: 3, top: 3),
                                        child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 5, 5, 0),
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color:
                                                      Color(ListColor.color4),
                                                  size: 28,
                                                ))),
                                      )),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          GlobalVariable.ratioFontSize(
                                                  context) *
                                              17,
                                          GlobalVariable.ratioFontSize(
                                                  context) *
                                              0,
                                          GlobalVariable.ratioFontSize(
                                                  context) *
                                              17,
                                          GlobalVariable.ratioFontSize(
                                                  context) *
                                              0),
                                      child: CustomText(
                                          "LelangMuatPesertaLelangPesertaLelangLabelTitlePopNoNilaiDuaKali"
                                              .tr,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          textAlign: TextAlign.center,
                                          color: Colors.black),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 20),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              Color(ListColor.color4),
                                          side: BorderSide(
                                              width: 2,
                                              color: Color(ListColor.color4)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          )),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CustomText("Oke".tr,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        )),
                      );
                    });
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(context) * 16,
                vertical: GlobalVariable.ratioWidth(context) * 12,
              ),
              child: CustomText(
                "LelangMuatPesertaLelangPesertaLelangLabelTitleBeriNilaiTransporter"
                    .tr,
                color: Color(ListColor.colorBlack),
                fontSize: GlobalVariable.ratioFontSize(context) * 14,
                fontWeight: FontWeight.w600,
                height: GlobalVariable.ratioFontSize(context) * (16.8 / 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
