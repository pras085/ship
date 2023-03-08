import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/cari_harga_transport/cari_harga_transport_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/transport_market/menu_horizontal_scroll_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class TransportMarketController extends GetxController {
  //TODO: Implement BigfleetsController

  final List<String> imgList = [
    'banner_1.png',
    'banner_1.png',
    'banner_1.png',
    'banner_1.png',
    'banner_1.png',
    'banner_1.png'
  ];

  var imageSliders = [].obs;

  final indexImageSlider = 0.obs;
  var cekCariHargaTransport = false;

  var listWidgetLogistic = [].obs;

  var onLoading = true.obs;

  @override
  void onInit() async {
    cekCariHargaTransport =
        await SharedPreferencesHelper.getHakAkses("Lihat Cari Harga Transport");

    imageSliders.value = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage(GlobalVariable.imagePath + item),
                          width: 1000,
                          fit: BoxFit.cover,
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    listWidgetLogistic.add(MenuHorizontalScrollTransportMarket(
        title: "TransportMarketIndexLabelSubscription".tr, //Subscription
        image: GlobalVariable.imagePath + "subscription.png",
        width: GlobalVariable.ratioWidth(Get.context) * 24.92,
        height: GlobalVariable.ratioWidth(Get.context) * 38,
        color: ListColor.colorBackgroundCircleBigFleetSubscription,
        onPress: () {},
        akses: true));
    listWidgetLogistic.add(MenuHorizontalScrollTransportMarket(
        title: "TransportMarketIndexLabelLelangMuatan".tr, // Lelang Muatan

        image: GlobalVariable.imagePath + "lelang_muatan_icon.png",
        width: GlobalVariable.ratioWidth(Get.context) * 32,
        height: GlobalVariable.ratioWidth(Get.context) * 31,
        color: ListColor.colorDashboardTransporterMarketMenuLelangMuatan,
        onPress: () async {},
        akses: true));
    listWidgetLogistic.add(MenuHorizontalScrollTransportMarket(
        title: "CariHargaTransportIndexLabelCariHargaTransport"
            .tr, // Cari Harga Transport

        image: GlobalVariable.imagePath + "cari_harga_transport_icon.png",
        width: GlobalVariable.ratioWidth(Get.context) * 36,
        height: GlobalVariable.ratioWidth(Get.context) * 36,
        color: ListColor.colorBackgroundCircleTransportMarketCariHargaTransport,
        onPress: () async {
          cekCariHargaTransport = await SharedPreferencesHelper.getHakAkses(
              "Lihat Cari Harga Transport",
              denganLoading: true);
          if (SharedPreferencesHelper.cekAkses(cekCariHargaTransport)) {
            GetToPage.toNamed<CariHargaTransportController>(
                Routes.CARI_HARGA_TRANSPORT,
                preventDuplicates: false,
                arguments: [""]);
          }
        },
        akses: cekCariHargaTransport));
    listWidgetLogistic.add(MenuHorizontalScrollTransportMarket(
        title:
            "TransportMarketIndexLabelPromoTransporter".tr, // Promo Transporter

        image: GlobalVariable.imagePath + "promo_transporter_icon.png",
        width: GlobalVariable.ratioWidth(Get.context) * 30,
        height: GlobalVariable.ratioWidth(Get.context) * 30,
        color: ListColor.colorBackgroundCircleTransportMarketPromoTransporter,
        akses: true));
    listWidgetLogistic.refresh();
    onLoading.value = false;
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
