import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/ketentuan_harga_transport/ketentuan_harga_transport_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_role/manajemen_role_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_with_Tab2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiver/pattern.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'dart:math' as math;
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class KetentuanHargaTransportView
    extends GetView<KetentuanHargaTransportController> {
  // double _heightAppBar = AppBar().preferredSize.height + 30;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          child: Container(
            alignment: Alignment.center,
            height: GlobalVariable.ratioWidth(Get.context) * 56,
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 16),
            decoration: BoxDecoration(
                // image: DecorationImage(
                //     image: AssetImage(GlobalVariable.urlImageNavbar),
                //     fit: BoxFit.cover),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ], color: Colors.white),
            child: Stack(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: GestureDetector(
                        onTap: () {
                          onWillPop();
                        },
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + "ic_back_button.svg",
                            color: Color(ListColor.colorBlue),
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24))),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                Center(
                  child: CustomText(
                    "CariHargaTransportIndexKetentuanHargaTransport"
                        .tr, //Detail Pemenang Tender
                    fontWeight: FontWeight.w700,
                    fontSize: 16.00,
                    color: Color(ListColor.colorBlack),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(context) * 16,
            GlobalVariable.ratioWidth(context) * 20,
            GlobalVariable.ratioWidth(context) * 16,
            0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 16,
                    GlobalVariable.ratioWidth(context) * 14,
                    GlobalVariable.ratioWidth(context) * 12,
                    GlobalVariable.ratioWidth(context) * 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6),
                    ),
                    border: Border.all(
                      color: Color(ListColor.colorLightGrey21),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.additionalNotes == ""
                          ? Container()
                          : CustomText(
                              "CariHargaTransportIndexCatatanTambahan".tr,
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.colorGrey3),
                            ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(context) * 14,
                        ),
                        height: GlobalVariable.ratioWidth(context),
                        width: MediaQuery.of(context).size.width -
                            GlobalVariable.ratioWidth(context) * 60,
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey21),
                        ),
                      ),
                      CustomText(
                        controller.additionalNotes,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Container(height: GlobalVariable.ratioWidth(context) * 24),
                controller.notes == ""
                    ? Container()
                    : Container(
                        padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 14,
                          GlobalVariable.ratioWidth(context) * 12,
                          GlobalVariable.ratioWidth(context) * 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 6),
                          ),
                          border: Border.all(
                            color: Color(ListColor.colorLightGrey21),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "CariHargaTransportIndexCatatanTarif".tr,
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.colorGrey3),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(context) * 14,
                              ),
                              height: GlobalVariable.ratioWidth(context),
                              width: MediaQuery.of(context).size.width -
                                  GlobalVariable.ratioWidth(context) * 60,
                              decoration: BoxDecoration(
                                color: Color(ListColor.colorLightGrey21),
                              ),
                            ),
                            CustomText(
                              controller.notes,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    Get.back(result: true);
  }
}
