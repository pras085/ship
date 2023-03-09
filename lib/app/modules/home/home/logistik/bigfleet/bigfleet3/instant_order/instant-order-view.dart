import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/create_order_entry/create_order_entry_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/list_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_controller.dart';
import 'package:muatmuat/app/modules/manajemen_order_entry/manajemen_order_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet3/instant_order/instant-order-controller.dart';

class InstantOrderView extends GetView<InstantOrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(
        preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 54),
      ),
      body: Obx(
        () => !controller.loading.value
            ? Container(
                color: Color(ListColor.colorWhite),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => _contentDataShipperMenu(
                        context: context,
                        title: 'Lokasi Truk Siap Muat',
                        haveAccess: controller.lokasiTrukAkses.value,
                        onTap: () async {
                          var lihatResponse = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
                            context: context,
                            menuId: '669',
                          );
                          if (lihatResponse != null && !lihatResponse) return;
                          GetToPage.toNamed<LokasiTrukSiapMuatController>(Routes.LOKASI_TRUK_SIAP_MUAT);
                        },
                      ),
                    ),
                    Obx(
                      () => _contentDataShipperMenu(
                        context: context,
                        haveAccess: controller.infoPermintaanAkses.value,
                        title: 'Info Permintaan Muat',
                        onTap: () async {
                          var lihatResponse = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
                            context: context,
                            menuId: '611',
                          );
                          if (lihatResponse != null && !lihatResponse) return;
                          GetToPage.toNamed<ListInfoPermintaanMuatController>(Routes.LIST_INFO_PERMINTAAN_MUAT);
                        },
                      ),
                    ),
                    Obx(
                      () => _contentDataShipperMenu(
                        context: context,
                        haveAccess: controller.directOrderAkses.value,
                        title: 'Direct Order Entry',
                        onTap: () => GetToPage.toNamed<ManajemenOrderController>(Routes.MANAJEMEN_ORDER_ENTRY),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

Widget _contentDataShipperMenu({
  @required BuildContext context,
  String title,
  VoidCallback onTap,
  bool haveAccess = true,
}) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * 0,
          GlobalVariable.ratioWidth(context) * 16,
          GlobalVariable.ratioWidth(context) * 0, // -2 border
          GlobalVariable.ratioWidth(context) * 16,
        ),
        constraints: BoxConstraints(
          minHeight: GlobalVariable.ratioWidth(context) * 48,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: GlobalVariable.ratioWidth(context) * 1,
              color: Color(ListColor.colorLightGrey2),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: GlobalVariable.ratioWidth(context) * 264,
              child: CustomText(
                title,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                color: haveAccess ? Color(ListColor.colorBlack) : Color(ListColor.colorGrey3),
              ),
            ),
            SvgPicture.asset(
              'assets/ic_arrow_right_profile.svg',
              width: GlobalVariable.ratioWidth(context) * 16,
              height: GlobalVariable.ratioWidth(context) * 16,
                color: haveAccess ? Color(ListColor.colorBlack) : Color(ListColor.colorGrey3),
            ),
          ],
        ),
      ),
    ),
  );
}

class _AppBar extends PreferredSize {
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(ListColor.color4),
      child: SafeArea(
          child: Container(
        height: preferredSize.height,
        child: Container(
            height: preferredSize.height,
            color: Color(ListColor.color4),
            child: Stack(alignment: Alignment.center, children: [
              Positioned(
                top: 5,
                right: 0,
                child: Image(
                  image: AssetImage("assets/fallin_star_3_icon.png"),
                  height: preferredSize.height,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 14,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBackButton(
                        context: Get.context,
                        onTap: () {
                          Get.back();
                        })
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 5.17, right: GlobalVariable.ratioWidth(Get.context) * 5.17),
                    child: CustomText(
                      "Instant Order",
                      color: Color(ListColor.colorWhite),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ])),
      )),
    );
  }

  _AppBar({this.preferredSize});
}
