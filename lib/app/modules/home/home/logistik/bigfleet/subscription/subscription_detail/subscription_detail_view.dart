import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/tipe_paket.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_detail/subscription_detail_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';

import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class SubscriptionDetailView extends GetView<SubscriptionDetailController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      extendBody: true,
      appBar: AppBarDetail(
        onClickBack: () {
          if (!controller.onDownloading.value &&
              !controller.loading.value &&
              !controller.loadingBatal.value)
            Get.back(
                result: [controller.refreshData, controller.refreshPanel, null]);
        },
        title: controller.tipeDetail == TipeDetailSubscription.LANGGANAN
            ? "SubscriptionHistory".tr
            : controller.tipeDetail == TipeDetailSubscription.PEMBAYARAN
                ? 'SubscriptionDetailOrderHistory'.tr
                : 'SubscriptionOrderHistory'.tr,
        prefixIcon: [
          Obx(
            () => controller.loading.value
                ? Container()
                : controller.statusPesanan == 1
                    ? Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            // Get.back();
                            var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "584");
                            if (!hasAccess) {
                              return;
                            }
                            controller.tapDownload = true;
                            controller.cekDownloadFile();
                          },
                          child: SvgPicture.asset(
                            "assets/ic_download.svg",
                            color: Color(ListColor.colorBlue),
                            width:
                                GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24,
                          ),
                        ),
                      )
                    : Container(),
          ),
          Obx(
            () => controller.loading.value
                ? Container()
                : controller.statusPesanan == 1
                    ? Container(
                        margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 12,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "585");
                              if (!hasAccess) {
                                return;
                              }
                              controller.shareFile();
                            },
                            child: SvgPicture.asset(
                              "assets/share_icon.svg",
                              color: Color(ListColor.colorBlue),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) *
                                      24,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) *
                                      24,
                            ),
                          ),
                        ),
                      )
                    : Container(),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Obx(() => controller.loading.value
            ? Container(
                color: Color(ListColor.colorWhite),
                padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 40),
                width: Get.context.mediaQuery.size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 30,
                          height: GlobalVariable.ratioWidth(Get.context) * 30,
                          child: CircularProgressIndicator()),
                    ),
                    CustomText("ListTransporterLabelLoading".tr),
                  ],
                ))
            : Container(
                color: Color(ListColor.colorWhite),
                child: Obx(
                  () => Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: GlobalVariable.ratioWidth(
                                            Get.context) *
                                        16, // minus 4, it come from margin top detailWaktu() : real 20px
                                  ),
                                  _detailWaktu(),
                                  Container(
                                    height: GlobalVariable.ratioWidth(
                                            Get.context) *
                                        6,
                                  ),
                                  for (int i = 0;
                                      i < controller.listData.length;
                                      i++)
                                    _cardRiwayatLangganan(i),
                                  controller.kodeVoucher == "-" ||
                                          controller.kodeVoucher.isEmpty
                                      ? Container()
                                      : _cardVoucher(),
                                  _cardSubTotal(),
                                  _cardPembayaran(),
                                ],
                              ),
                            ),
                          ),
                          controller.statusPesanan == 0
                              ? _footer()
                              : Container(),
                        ],
                      ),
                      !controller.loadingBatal.value
                          ? SizedBox.shrink()
                          : Positioned.fill(
                              child: Container(
                                  color: Colors.black.withAlpha(100),
                                  child: Center(
                                    child: Container(
                                        padding: EdgeInsets.all(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius
                                                .circular(GlobalVariable
                                                        .ratioWidth(
                                                            Get.context) *
                                                    10)),
                                        child: CircularProgressIndicator()),
                                  ))),
                      controller.onDownloading.value == false
                          ? SizedBox.shrink()
                          : Container(
                              color: Colors.black.withOpacity(0.3),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 8))),
                                      padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 30),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(
                                              backgroundColor: Colors.grey,
                                              valueColor:
                                                  AlwaysStoppedAnimation<
                                                          Color>(
                                                      Color(ListColor
                                                          .color4)),
                                              value: controller
                                                      .processing.value
                                                  ? null
                                                  : controller
                                                      .onProgress.value),
                                          Container(height: GlobalVariable.ratioWidth(Get.context) * 10),
                                          CustomText(controller
                                                  .processing.value
                                              ? "Processing"
                                              : "Downloading ${(controller.onProgress.value * 100).ceilToDouble()} %"),
                                        ],
                                      )),
                                ],
                              ),
                            )
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget _detailWaktu() {
    // NOTE : i'm using combination min height 25 and "margin" top 4 to
    // achieve the real distance between each widget. which is 29px
    return Table(
      columnWidths: <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth()
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: [
        TableRow(children: [
          Container(
            constraints: BoxConstraints(
                minHeight: GlobalVariable.ratioWidth(Get.context) * 25),
            margin: EdgeInsets.only(
              top: GlobalVariable.ratioWidth(Get.context) * 4,
            ),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16),
            child: CustomText(
              'SubscriptionOrderCode'.tr,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(ListColor.colorGrey3),
              withoutExtraPadding: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 4,
            ),
            constraints: BoxConstraints(
                minHeight: GlobalVariable.ratioWidth(Get.context) * 25),
            child: CustomText(
              controller.kodePesanan,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              withoutExtraPadding: true,
              color: Color(ListColor.colorBlack),
            ),
          )
        ]),
        TableRow(children: [
          Container(
            constraints: BoxConstraints(
                minHeight: GlobalVariable.ratioWidth(Get.context) * 25),
            margin: EdgeInsets.only(
              top: GlobalVariable.ratioWidth(Get.context) * 4,
            ),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'SubscriptionOrderDate'.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3),
                  withoutExtraPadding: true,
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(
                minHeight: GlobalVariable.ratioWidth(Get.context) * 25),
            margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 4,
            ),
            child: CustomText(
              controller.tanggalPesanan,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              withoutExtraPadding: true,
              color: Color(ListColor.colorBlack),
            ),
          )
        ]),
        controller.statusPesanan == 1 &&
                controller.tipeDetail == TipeDetailSubscription.PESANAN
            ? TableRow(children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 25),
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 4,
                  ),
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16),
                  child: CustomText(
                    'SubscriptionValidTime'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(ListColor.colorGrey3),
                    withoutExtraPadding: true,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 25),
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 4,
                  ),
                  child: CustomText(
                    controller.waktuPembayaran,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(ListColor.colorBlack),
                    withoutExtraPadding: true,
                  ),
                )
              ])
            : _kosong(),
        controller.statusPesanan == 0
            ? TableRow(children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 25),
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 4,
                  ),
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16),
                  child: CustomText(
                    'SubscriptionOrderStatus'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(ListColor.colorGrey3),
                    withoutExtraPadding: true,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _textCard(
                        marginLeft: 0,
                        text: "SubscriptionWaitingPayment".tr,
                        textColor: Color(ListColor.colorYellow5),
                        backgroundColor: Color(ListColor.colorLightYellow1)),
                  ],
                )
              ])
            : controller.tipeDetail == TipeDetailSubscription.LANGGANAN
                ? _kosong()
                : TableRow(children: [
                    Container(
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 25),
                      margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 4,
                      ),
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 16,
                          right: GlobalVariable.ratioWidth(Get.context) * 16),
                      child: CustomText(
                        'SubscriptionOrderStatus'.tr,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(ListColor.colorGrey3),
                        withoutExtraPadding: true,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 25),
                      margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 4,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          3.5),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          9,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          9,
                                  child: SvgPicture.asset(
                                    controller.statusPesanan == 1
                                        ? "assets/ic_subscription_circle_hijau.svg"
                                        : controller.statusPesanan == 2
                                            ? "assets/ic_subscription_circle_merah.svg"
                                            : "assets/ic_subscription_circle_abu.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9,
                                  )),
                              Container(
                                child: Dash(
                                    length:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            38.85,
                                    dashThickness: GlobalVariable.ratioWidth(Get.context) * 1,
                                    dashLength: GlobalVariable.ratioWidth(Get.context) * 2,
                                    dashGap: GlobalVariable.ratioWidth(Get.context) * 1.5,
                                    direction: Axis.vertical,
                                    dashColor: Color(ListColor.colorDarkGrey3)),
                              ),
                              Container(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          9,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          9,
                                  child: SvgPicture.asset(
                                    "assets/ic_subscription_circle_kuning.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: GlobalVariable.ratioWidth(Get.context) * 8, // -4
                            ),
                            constraints: BoxConstraints(
                              minHeight: GlobalVariable.ratioWidth(Get.context) * 90,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _textCard(
                                    marginLeft: 0,
                                    text: controller.statusPesananStatus,
                                    textColor:
                                        Color(controller.statusPesanan == 1
                                            ? ListColor.colorGreen6
                                            : controller.statusPesanan == 2
                                                ? ListColor.colorRed
                                                : ListColor.colorGrey3),
                                    backgroundColor: Color(controller
                                                .statusPesanan ==
                                            1
                                        ? ListColor.colorLightGreen3
                                        : controller.statusPesanan == 2
                                            ? ListColor.colorLightRed3
                                            : ListColor.colorLightGrey12)),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: GlobalVariable.ratioWidth(Get.context) * 8,
                                    bottom: GlobalVariable.ratioWidth(Get.context) * 10,
                                  ),
                                  child: CustomText(
                                    controller.statusPesananWaktu,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    withoutExtraPadding: true,
                                    color: Color(ListColor.colorGrey4),
                                  ),
                                ),
                                _textCard(
                                    marginLeft: 0,
                                    text: controller
                                        .statusPesananMenungguStatus,
                                    textColor:
                                        Color(ListColor.colorYellow5),
                                    backgroundColor:
                                        Color(ListColor.colorLightYellow1)),
                                Container(
                                  margin: EdgeInsets.only(
                                      top:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              6), // -2 from figma
                                  child: CustomText(
                                    controller.statusPesananMenungguWaktu,
                                    fontWeight: FontWeight.w600,
                                    withoutExtraPadding: true,
                                    fontSize: 10,
                                    color: Color(ListColor.colorGrey4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
        controller.statusPesanan == 0 || controller.statusPesanan == 1
            ? TableRow(children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight:
                          GlobalVariable.ratioWidth(Get.context) * 25),
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 4,
                  ),
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16),
                  child: CustomText(
                    controller.statusPesanan == 0
                        ? 'SubscriptionPaymentLimit'.tr
                        : 'SubscriptionPaymentTime'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(ListColor.colorGrey3),
                    withoutExtraPadding: true,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 25),
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 4,
                  ),
                  child: CustomText(
                    controller.statusPesanan == 0 &&
                            controller.tipeDetail ==
                                TipeDetailSubscription.PEMBAYARAN
                        ? controller.batasPembayaran
                        : controller.waktuPembayaran,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    withoutExtraPadding: true,
                    color: Color(ListColor.colorBlack),
                  ),
                )
              ])
            : _kosong(),
      ],
    );
  }

  Widget _cardRiwayatLangganan(
    int index,
  ) {
    bool tipeBF = controller.tipe == TipeLayananSubscription.BF;
    return Container(
      padding:
          EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 4),
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 14),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(ListColor.colorWhite),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
              spreadRadius: GlobalVariable.ratioWidth(Get.context) * 0,
              offset: Offset(GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 13),
            ),
          ],
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16),
            decoration: BoxDecoration(
                color: Color(ListColor.colorLightBlue),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                    topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 15, bottom: GlobalVariable.ratioWidth(Get.context) * 15),
              alignment: Alignment.centerLeft,
              child: CustomText(
                controller.listData[index].name,
                maxLines: 2,
                height: 16 / 14,
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionPackageType".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )),
                Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    controller.listData[index].tipe,
                    textAlign: TextAlign.right,
                    color: Color(ListColor.colorBlack),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            //garis
            width: MediaQuery.of(Get.context).size.width,
            height: GlobalVariable.ratioWidth(Get.context) * 0.5,
            color: Color(ListColor.colorLightGrey10),
          ),
          Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionQuantity".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )),
                Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    controller.listData[index].jumlah.toString(),
                    textAlign: TextAlign.right,
                    color: Color(ListColor.colorBlack),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            //garis
            width: MediaQuery.of(Get.context).size.width,
            height: GlobalVariable.ratioWidth(Get.context) * 0.5,
            color: Color(ListColor.colorLightGrey10),
          ),
          Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionTotalPackagePrice".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )),
                Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    Utils.formatUang(
                        controller.listData[index].harga.toDouble()),
                    textAlign: TextAlign.right,
                    color: Color(ListColor.colorBlack),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          tipeBF
              ? Container()
              : Container(
                  margin: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 14,
                      right: GlobalVariable.ratioWidth(Get.context) * 14),
                  //garis
                  width: MediaQuery.of(Get.context).size.width,
                  height: GlobalVariable.ratioWidth(Get.context) * 0.5,
                  color: Color(ListColor.colorLightGrey10),
                ),
          tipeBF
              ? Container()
              : Container(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 14,
                      right: GlobalVariable.ratioWidth(Get.context) * 14),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        constraints: BoxConstraints(
                            minHeight:
                                GlobalVariable.ratioWidth(Get.context) * 41),
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          "SubscriptionValidPeriod".tr,
                          color: Color(ListColor.colorLightGrey4),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      )),
                      Container(
                        constraints: BoxConstraints(
                            minHeight:
                                GlobalVariable.ratioWidth(Get.context) * 41),
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          controller.listData[index].periode,
                          textAlign: TextAlign.right,
                          color: Color(ListColor.colorBlack),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _cardVoucher() {
    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                    top: GlobalVariable.ratioWidth(Get.context) * 12,
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16),
                child: CustomText("SubscriptionVoucherCode".tr,
                    fontSize: 14,
                    color: Color(ListColor.colorBlack),
                    fontWeight: FontWeight.w600)),
            Container(
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    child: SvgPicture.asset(
                      "assets/ic_voucher_bg.svg",
                      height: GlobalVariable.ratioWidth(Get.context) * 40,
                      width: MediaQuery.of(Get.context).size.width,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 20,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SvgPicture.asset(
                            "assets/ic_voucher.svg",
                            height: GlobalVariable.ratioWidth(Get.context) * 15,
                          ),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          10),
                                  child: CustomText(controller.kodeVoucher,
                                      color: Color(ListColor.colorBlue),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)))
                        ],
                      ))
                ]))
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            color: Color(ListColor.colorWhite),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: GlobalVariable.ratioWidth(Get.context) * 12,
                offset: Offset(
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 3,
                ),
                spreadRadius: GlobalVariable.ratioWidth(Get.context) * 0,
              ),
            ]));
  }

  Widget _cardSubTotal() {
    bool tipeBF = controller.tipe == TipeLayananSubscription.BF;
    var jarak = 64;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: GlobalVariable.ratioWidth(Get.context) * 12,
          offset: Offset(
            GlobalVariable.ratioWidth(Get.context) * 0,
            GlobalVariable.ratioWidth(Get.context) * 3,
          ),
          spreadRadius: GlobalVariable.ratioWidth(Get.context) * 0,
        ),
      ], borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10), color: Colors.white),
      child: Table(
        columnWidths: <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth()
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                tipeBF ? 'SubscriptionPackage'.tr : 'SubscriptionSubTotal'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                Utils.formatUang(tipeBF
                    ? controller.hargaLayanan.toDouble()
                    : controller.hargaSubUsers.toDouble()),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorBlack),
              ),
            )
          ]),
          _garis(),
          TableRow(children: [
            Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    tipeBF
                        ? 'SubscriptionSubUserPackage'.tr
                        : 'SubscriptionTotalSubUser'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  tipeBF &&
                          (controller.jumlahSubUsersBayar > 0 ||
                              controller.jumlahSubUsersGratis > 0)
                      ? Container(
                          margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 4),
                          child: Row(
                            children: [
                              CustomText(
                                controller.jumlahSubUsersBayar > 0
                                    ? ('(${controller.jumlahSubUsersBayar.toString()} ${'SubscriptionPaidUser'.tr}' +
                                        (controller.jumlahSubUsersGratis > 0
                                            ? ''
                                            : ')'))
                                    : '',
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Color(ListColor.colorBlack),
                              ),
                              CustomText(
                                controller.jumlahSubUsersGratis > 0 ? ((controller.jumlahSubUsersBayar > 0 ? ' + ' : '(') + '${controller.jumlahSubUsersGratis} ${'SubscriptionFreeUser'.tr})')
                                    : '',
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Color(ListColor.colorOrange),
                              ),
                            ],
                          ),
                        )
                      : !tipeBF && controller.jumlahSubUsersGratis > 1
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      4),
                              child: CustomText(
                                '1',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.transparent,
                              ),
                            )
                          : !tipeBF && controller.jumlahSubUsersGratis > 0 ? CustomText(
                                '',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(ListColor.colorBlack),
                              ) : Container(),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  tipeBF
                      ? Container(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                            Utils.formatUang(
                                controller.hargaSubUsers.toDouble()),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(ListColor.colorBlack),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(
                              '${controller.jumlahSubUsersBayar.toString()} ${'SubscriptionPaidUser'.tr}',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(ListColor.colorBlack),
                            ),
                            CustomText(
                              controller.jumlahSubUsersGratis > 0
                                  ? "${controller.jumlahSubUsersBayar > 0 ? ' + ' : ''}${controller.jumlahSubUsersGratis.toString()}"
                                  : '',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(ListColor.colorOrange),
                            )
                          ],
                        ),
                  tipeBF &&
                          (controller.jumlahSubUsersBayar > 0 ||
                              controller.jumlahSubUsersGratis > 0)
                      ? CustomText(
                          '1',
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.transparent,
                        )
                      : !tipeBF && controller.jumlahSubUsersGratis > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  "SubscriptionFreeUser".tr,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(ListColor.colorOrange),
                                ),
                              ],
                            )
                          : Container(),
                ],
              ),
            )
          ]),
          _garis(),
          TableRow(children: [
            Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                'SubscriptionDiscountVoucher'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                controller.hargaDiskon == 0
                    ? 'Rp 0'
                    : '- ${Utils.formatUang(controller.hargaDiskon.toDouble())}',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorRed),
              ),
            )
          ]),
          _garis(),
          TableRow(children: [
            Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                'SubscriptionServiceFee'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                Utils.formatUang(controller.biayaLayanan.toDouble()),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorBlack),
              ),
            )
          ]),
          _garis(),
          TableRow(children: [
            Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                'SubscriptionTax'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                Utils.formatUang(controller.pajak.toDouble()),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorBlack),
              ),
            )
          ]),
          _garis(),
          TableRow(children: [
            Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                'SubscriptionTotalOrders'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              constraints: BoxConstraints(
                  minHeight: GlobalVariable.ratioWidth(Get.context) * jarak),
              child: CustomText(
                Utils.formatUang(controller.totalHarga.toDouble()),
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorBlack),
              ),
            )
          ]),
        ],
      ),
    );
  }

  Widget _cardPembayaran() {
    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 14,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                    top: GlobalVariable.ratioWidth(Get.context) * 12,
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16),
                child: CustomText("SubscriptionPaymentMethod".tr,
                    fontSize: 14,
                    color: Color(ListColor.colorBlack),
                    fontWeight: FontWeight.w600)),
            Container(
                padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 20),
                height: GlobalVariable.ratioWidth(Get.context) * 40,
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16),
                decoration: BoxDecoration(
                    color: Color(ListColor.colorLightGrey10WithOpacity30),
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 3)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                        imageUrl: controller.iconPembayaran,
                        imageBuilder: (context, imageProvider) => Container(
                              width: GlobalVariable.ratioWidth(Get.context) * 25,
                              decoration: BoxDecoration(
                                  border: null,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fitWidth)),
                            )),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(
                                left: GlobalVariable.ratioWidth(Get.context) *
                                    10),
                            child: CustomText(controller.metodePembayaran,
                                color: Color(ListColor.colorBlack),
                                fontSize: 12,
                                fontWeight: FontWeight.w600)))
                  ],
                ))
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            color: Color(ListColor.colorWhite),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: GlobalVariable.ratioWidth(Get.context) * 12,
                offset: Offset(
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 3,
                ),
                spreadRadius: GlobalVariable.ratioWidth(Get.context) * 0,
              ),
            ]));
  }

  Widget _footer() {
    return Container(
      width: MediaQuery.of(Get.context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10), topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 12,
              offset: Offset(
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 3,
              ),
              spreadRadius: GlobalVariable.ratioWidth(Get.context) * 0,
            ),
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: _button(
                  text: "SubscriptionCancelOrder".tr,
                  marginRight: 6,
                  color: Color(ListColor.colorBlue),
                  useBorder: true,
                  onTap: () async {
                    var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "16");
                    if (!hasAccess) {
                      return;
                    }
                    controller.showAskBatalDialog();
                  })),
          Expanded(
            child: _button(
                text: "SubscriptionPayNow".tr,
                marginLeft: 6,
                backgroundColor: Color(ListColor.colorBlue),
                onTap: () async {
                  var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "16");
                  if (!hasAccess) {
                    return;
                  }
                  controller.bayarSekarang();
                }),
          ),
        ],
      ),
    );
  }

  TableRow _garis() {
    return TableRow(children: [
      Container(
        height: GlobalVariable.ratioWidth(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10),
      ),
      Container(
        height: GlobalVariable.ratioWidth(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10),
      ),
    ]);
  }

  TableRow _kosong() {
    return TableRow(children: [Container(), Container()]);
  }

  Widget _button({
    bool maxWidth = true,
    double marginLeft = 22,
    double marginTop = 12,
    double marginRight = 22,
    double marginBottom = 12,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 20,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: maxWidth ? double.infinity : null,
      height: GlobalVariable.ratioWidth(Get.context) * 33,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 2,
                    spreadRadius: GlobalVariable.ratioWidth(Get.context) * 2,
                    offset: Offset(GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorBlue))
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              height: GlobalVariable.ratioWidth(Get.context) * 33,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  paddingLeft, paddingTop, paddingRight, paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }

  Widget _textCard({
    @required String text,
    double marginLeft = 16,
    @required Color textColor,
    @required Color backgroundColor,
  }) {
    return Container(
      margin: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * marginLeft),
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 8, 
        GlobalVariable.ratioWidth(Get.context) * 0, 
        GlobalVariable.ratioWidth(Get.context) * 8, 
        GlobalVariable.ratioWidth(Get.context) * 0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
      ),
      constraints: BoxConstraints(
        minHeight: GlobalVariable.ratioWidth(Get.context) * 20,
      ),
      alignment: Alignment.center,
      child: CustomText(
        text,
        maxLines: 1,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  Future<bool> onWillPop() {
    if (!controller.onDownloading.value &&
        !controller.loading.value &&
        !controller.loadingBatal.value)
      Get.back(result: [controller.refreshData, controller.refreshPanel, null]);
    return Future.value(false);
  }
}
