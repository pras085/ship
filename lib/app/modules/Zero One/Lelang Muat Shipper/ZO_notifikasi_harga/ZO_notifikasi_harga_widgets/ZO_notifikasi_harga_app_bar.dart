import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaAppBar extends StatelessWidget {
  final ZoNotifikasiHargaController controller;

  const ZoNotifikasiHargaAppBar({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(ListColor.colorWhite), boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 15,
          color: Color(ListColor.colorBlack).withOpacity(0.15),
        )
      ]),
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: ClipOval(
                  child: Material(
                    shape: const CircleBorder(),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                      onTap: () async {
                        final shouldPop = await controller.onWillPop();
                        if (shouldPop ?? false) {
                          Get.back();
                        }
                      },
                      child: Container(
                        width: GlobalVariable.ratioFontSize(context) * 24,
                        height: GlobalVariable.ratioFontSize(context) * 24,
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: GlobalVariable.ratioFontSize(context) * 14,
                            color: Color(ListColor.colorWhite),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
              Expanded(
                child: Center(
                  child: Obx(
                    () => CustomText(
                      controller.isEditPage.isTrue
                          ? ZoNotifikasiHargaStrings.editAppbarText.tr
                          : ZoNotifikasiHargaStrings.appbarText.tr,
                      textAlign: TextAlign.center,
                      color: Color(ListColor.colorBlack),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: GlobalVariable.ratioWidth(context) * 8,
              ),
              SizedBox(
                width: GlobalVariable.ratioWidth(context) * 24,
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
