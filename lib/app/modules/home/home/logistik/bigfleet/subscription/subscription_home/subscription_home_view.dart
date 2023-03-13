import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/alert_dialog/subscription_popup_keuntungan.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subscription/create_subscription_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subuser/create_subuser_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list/subscription_riwayat_pesanan_list_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list/subscription_menunggu_pembayaran_list_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/tipe_paket.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_dan_su_list/subscription_riwayat_langganan_bf_dan_su_list_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_home/subscription_home_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';

import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/custom_tooltip_overlay.dart';
import 'package:muatmuat/app/widgets/tutorial.dart';
import 'package:muatmuat/global_variable.dart';

class SubscriptionHomeView extends GetView<SubscriptionHomeController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      extendBody: true,
      appBar: _AppBar(
        preferredSize:
            Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Obx(() => controller.loading.value
            ? Container(
                color: Color(ListColor.colorWhite),
                padding: EdgeInsets.symmetric(vertical: 40),
                width: Get.context.mediaQuery.size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator()),
                    ),
                    CustomText("ListTransporterLabelLoading".tr),
                  ],
                ))
            : !controller.isSegmented
                ? Container(
                    color: Color(ListColor.colorWhite),
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            GlobalVariable.ratioWidth(Get.context) * 16),
                    width: Get.context.mediaQuery.size.width,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 65),
                          child: SvgPicture.asset(
                            "assets/ic_muatmuat_sad.svg",
                            width:
                                GlobalVariable.ratioWidth(Get.context) * 142.5,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 20),
                          child: CustomText(
                            "SubscriptionLabelNonSegmented1".tr,
                            textAlign: TextAlign.center,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 24 / 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 20),
                          child: CustomText(
                            "SubscriptionLabelNonSegmented2".tr,
                            textAlign: TextAlign.center,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 16.8 / 14,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 60),
                          child: CustomText(
                            "SubscriptionLabelNonSegmented3".tr,
                            textAlign: TextAlign.center,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 16.8 / 14,
                          ),
                        ),
                        _button(
                            text: "Home",
                            minHeight: 36,
                            paddingLeft: 64,
                            paddingRight: 64,
                            useShadow: false,
                            backgroundColor: Color(ListColor.colorBlue),
                            onTap: () {
                              Get.back();
                            })
                      ],
                    ))
                : TutorListener(
                  listener: () async {
                    // controller.showTutorial(context);
                    // print("tes call");
                  },
                  child: Container(
                      color: Color(ListColor.colorWhite),
                      padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0),
                      child: ListView(
                        children: [
                          Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                          ),
                          controller.tipe == TipePaketSubscription.FIRST ||
                                  controller.tipe == TipePaketSubscription.EXPIRED
                              ? _cardFirstOrExpired(controller.tipe)
                              : _cardActiiveOrWillExpired(controller.tipe),
                          (controller.listDataSubUser.length == 0 &&
                                  !(controller.isRiwayatSubUser))
                              ? Container()
                              : _cardSubUser(),
                          controller.dataPaketNext != null
                              ? _cardNext()
                              : Container(),
                          Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                          ),
                          _button(
                              //menunggu pembayaran
                              marginLeft: 0,
                              marginRight: 0,
                              borderRadius: 6,
                              marginBottom:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              useBorder: true,
                              minHeight: 40,
                              useShadow: false,
                              customWidget: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                      ),
                                      child: CustomText(
                                        "SubscriptionWaitingPayment".tr,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorBlack),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            6),
                                    child: SvgPicture.asset(
                                      "assets/ic_arrow_right_subscription.svg",
                                      width:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              20,
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              20,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                if (!controller.hasAccessTambahLangganan.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                                // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "16");
                                // if (!hasAccess) {
                                //   return;
                                // }
                                var result = await GetToPage.toNamed<
                                    SubscriptionMenungguPembayaranListController>(
                                  Routes.SUBSCRIPTION_MENUNGGU_PEMBAYARAN_LIST,
                                );
                                if (result != null) {
                                  if (result is List) {
                                    controller.resultPembayaranSubsciption(
                                      result[0],
                                      result[1],
                                      kredit: result[2],
                                    );
                                    controller.getDataCek();
                                  } else if (result is bool && result == true) {
                                    controller.getDataCek();
                                  }
                                }
                              }),
                          _button(
                              //riwayat pesanan
                              marginLeft: 0,
                              marginRight: 0,
                              borderRadius: 6,
                              marginBottom:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                              useBorder: true,
                              minHeight: 40,
                              useShadow: false,
                              customWidget: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                      ),
                                      child: CustomText(
                                        "SubscriptionOrderHistory".tr,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorBlack),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            6),
                                    child: SvgPicture.asset(
                                      "assets/ic_arrow_right_subscription.svg",
                                      width:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              20,
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              20,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                if (!controller.hasAccessLihatRiwayatLangganan.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                                // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "402");
                                // if (!hasAccess) {
                                //   return;
                                // }
                                GetToPage.toNamed<
                                        SubscriptionRiwayatPesananListController>(
                                    Routes.SUBSCRIPTION_RIWAYAT_PESANAN_LIST);
                              }),
                        ],
                      )),
                )),
      ),
    );
  }

  Widget _cardFirstOrExpired(TipePaketSubscription tipePaket) {
    bool tipeFirst = tipePaket == TipePaketSubscription.FIRST;

    return Container(
      //first dan kadaluarsa
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(tipeFirst
              ? "assets/bg_subscription_first.png"
              : "assets/bg_subscription_aktif.png"),
          fit: BoxFit.fill,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorBlack).withOpacity(0.1),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 4),
          ),
        ],
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 11),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 16),
          child: CustomText(
            "SubscriptionPacketNow".tr,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(ListColor.colorWhite),
          ),
        ),
        tipeFirst
            ? _textCard(
                text: "SubscriptionNoPacket".tr,
                textColor: Color(ListColor.colorBlack),
                backgroundColor: Color(ListColor.colorWhite2))
            : _textCard(
                text: "SubscriptionExpired".tr,
                textColor: Color(ListColor.colorGrey3),
                backgroundColor: Color(ListColor.colorLightGrey12)),
        tipeFirst
            ? Container()
            : Row(
                children: [
                  _button(
                      minHeight: 23,
                      marginTop: 16,
                      marginBottom: 25,
                      borderRadius: 6,
                      useShadow: false,
                      maxWidth: false,
                      backgroundColor: controller.hasAccessLihatRiwayatLangganan.value ? Colors.white : Color(ListColor.colorLightGrey2),
                      color: controller.hasAccessLihatRiwayatLangganan.value ? Color(ListColor.colorBlue) : Colors.white,
                      customWidget: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 4),
                            child: SvgPicture.asset(
                              "assets/ic_riwayat.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              color: controller.hasAccessLihatRiwayatLangganan.value ? Color(ListColor.colorBlue) : Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            child: CustomText(
                              "SubscriptionHistory".tr,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: controller.hasAccessLihatRiwayatLangganan.value ? Color(ListColor.colorBlue) : Colors.white,
                            ),
                          )
                        ],
                      ),
                      onTap: () async {
                        if (!controller.hasAccessLihatRiwayatLangganan.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                        // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "402");
                        // if (!hasAccess) {
                        //   return;
                        // }
                        GetToPage.toNamed<
                                SubscriptionRiwayatLanggananBFDanSUListController>(
                            Routes
                                .SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_DAN_SU_LIST,
                            arguments: TipeLayananSubscription.BF);
                      }),
                ],
              ),
        _button(
            marginLeft: 32,
            marginRight: 32,
            marginTop: tipeFirst ? 36 : 0,
            marginBottom: 16,
            borderRadius: 20,
            minHeight: 32,
            backgroundColor: controller.hasAccessTambahLangganan.value ? Colors.white : Color(ListColor.colorLightGrey2),
            color: controller.hasAccessTambahLangganan.value ? Color(ListColor.colorBlue) : Colors.white,
            text: tipeFirst
                ? "SubscriptionSubscribeNow".tr
                : "SubscriptionSubscribeAgain".tr,
            fontWeight: tipeFirst ? FontWeight.w700 : FontWeight.w600,
            onTap: () async {
              // if (tipeFirst) {
              if (!controller.hasAccessTambahLangganan.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
              // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "16");
              // if (!hasAccess) {
              //   return;
              // }
              var result = await GetToPage.toNamed<
                      CreateSubscriptionController>(Routes.CREATE_SUBSCRIPTION,
                  arguments: [false, controller.userStatus.isFirstBFShipper == 1, "", ""]);
              if (result != null) {
                if (result is List) {
                  controller.resultPembayaranSubsciption(result[0], result[1],
                      kredit: result[2]);
                } else {
                  controller.getDataCek();
                }
              }
              // } else {}
            }),
      ]),
    );
  }

  Widget _cardActiiveOrWillExpired(TipePaketSubscription tipePaket) {
    bool tipeActive = tipePaket == TipePaketSubscription.ACTIVE;
    return Container(
      //aktif dan akan kadaluarsa
      key: controller.keyTutor0,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_subscription_aktif.png"),
          fit: BoxFit.fill,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorBlack).withOpacity(0.1),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 4),
          ),
        ],
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 11),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 16),
          child: CustomText(
            "SubscriptionPacketNow".tr,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(ListColor.colorWhite),
          ),
        ),
        tipeActive
            ? CustomTooltipOverlay(
              width: GlobalVariable.ratioWidth(Get.context) * 194,
              message: "Saat ini Anda menikmati akses penuh layanan Big Fleets selama 6 Bulan",
              child: _textCard(
                  text: controller.dataPaketNow.name,
                  textColor: Color(ListColor.colorBlue),
                  backgroundColor: Color(ListColor.colorLightBlue3)),
            )
            : CustomTooltipOverlay(
              width: GlobalVariable.ratioWidth(Get.context) * 194,
              message: "Masa trial Anda akan segera berakhir. Segera beli langganan untuk melanjutkan akses penuh Anda dalam menikmati layanan Big Fleets.",
              child: _textCard(
                  text: "SubscriptionWillExpired".tr,
                  textColor: Color(ListColor.colorGrey3),
                  backgroundColor: Color(ListColor.colorLightGrey12)),
            ),
        Container(
          margin: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              top: GlobalVariable.ratioWidth(Get.context) * 16),
          child: CustomText("SubscriptionSubscriptionPeriod".tr + " :",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.colorWhite)),
        ),
        Container(
          margin: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          child: CustomText(
              "${controller.dataPaketNow.periodeAwal} - ${controller.dataPaketNow.periodeAkhir}",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(ListColor.colorWhite)),
        ),
        Row(
          children: [
            _button(
                minHeight: 23,
                marginTop: 22,
                borderRadius: 6,
                useShadow: false,
                maxWidth: false,
                backgroundColor: controller.hasAccessLihatRiwayatLangganan.value ? Colors.white: Color(ListColor.colorLightGrey2),
                color: controller.hasAccessLihatRiwayatLangganan.value ? Color(ListColor.colorBlue) : Colors.white,
                customWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 4),
                      child: SvgPicture.asset(
                        "assets/ic_riwayat.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 14,
                        height: GlobalVariable.ratioWidth(Get.context) * 14,
                        color: controller.hasAccessLihatRiwayatLangganan.value ? Color(ListColor.colorBlue) : Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: CustomText(
                        "SubscriptionHistory".tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: controller.hasAccessLihatRiwayatLangganan.value ? Color(ListColor.colorBlue) : Colors.white,
                      ),
                    )
                  ],
                ),
                onTap: () async {
                  if (!controller.hasAccessLihatRiwayatLangganan.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                  // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "402");
                  // if (!hasAccess) {
                  //   return;
                  // }
                  GetToPage.toNamed<
                          SubscriptionRiwayatLanggananBFDanSUListController>(
                      Routes.SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_DAN_SU_LIST,
                      arguments: TipeLayananSubscription.BF);
                }),
          ],
        ),
        // Container(
        //   height: (tipeActive && controller.listDataSubUser.length != 0) ||
        //           (!tipeActive &&
        //               controller.dataPaketNext != null &&
        //               controller.listDataSubUser.length != 0)
        //       ? 0
        //       : GlobalVariable.ratioWidth(Get.context) * 24,
        // ),
        !tipeActive && controller.dataPaketNext == null
            ? _button(
                marginTop: 24,
                marginBottom: (controller.listDataSubUser.length == 0 &&
                        !(controller.isRiwayatSubUser))
                    // (controller.listDataSubUser.length == 0 ||
                    //         (controller.listDataSubUser.length == 1 &&
                    //             controller.listDataSubUser[0].quota == 0))
                    ? 12
                    : 0,
                text: "SubscriptionRenewSubscription".tr,
                minHeight: 28,
                fontWeight: FontWeight.w700,
                borderRadius: 20,
                backgroundColor: controller.hasAccessTambahLanggananBerikutnya.value ? Colors.white : Color(ListColor.colorLightGrey2),
                color: controller.hasAccessTambahLanggananBerikutnya.value ? Color(ListColor.colorBlue) : Colors.white,
                maxWidth: true,
                onTap: () async {
                  if (!controller.hasAccessTambahLanggananBerikutnya.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                  // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "403");
                  // if (!hasAccess) {
                  //   return;
                  // }
                  var result =
                      await GetToPage.toNamed<CreateSubscriptionController>(
                          Routes.CREATE_SUBSCRIPTION,
                          arguments: [
                        true,
                        controller.userStatus.isFirstBFShipper == 1,
                        controller.dataPaketNow.fullPeriodeAkhir,
                        controller.dataPaketNow.fullNextPeriode
                      ]);
                  if (result != null) {
                    if (result is List) {
                      controller.resultPembayaranSubsciption(
                          result[0], result[1],
                          kredit: result[2]);
                    } else {
                      controller.getDataCek();
                    }
                  }
                })
            : Container(),
        (controller.listDataSubUser.length == 0 &&
                !(controller.isRiwayatSubUser))
            // (controller.listDataSubUser.length == 0 ||
            //         (controller.listDataSubUser.length == 1 &&
            //             controller.listDataSubUser[0].quota == 0))
            ? Container(
                margin: EdgeInsets.only(
                    top: !tipeActive && controller.dataPaketNext == null
                        ? 0
                        : GlobalVariable.ratioWidth(Get.context) * 24),
                child: _button(
                    text: "SubscriptionAddSubUser".tr,
                    minHeight: 28,
                    borderRadius: 20,
                    backgroundColor: controller.hasAccessTambahSubUser.value ? Colors.white : Color(ListColor.colorLightGrey2),
                    color: controller.hasAccessTambahSubUser.value ? Color(ListColor.colorBlue) : Colors.white,
                    maxWidth: true,
                    onTap: () async {
                      if (!controller.hasAccessTambahSubUser.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                      // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "400");
                      // if (!hasAccess) {
                      //   return;
                      // }
                      var result =
                          await GetToPage.toNamed<CreateSubuserController>(
                              Routes.CREATE_SUBUSER,
                              arguments: [
                            controller.dataPaketNow.id.toString(),
                            controller.dataPaketNow.paketID.toString(),
                            controller.dataPaketNow.name,
                            // "${controller.dataPaketNow.periodeAwal} - ${controller.dataPaketNow.periodeAkhir}",
                            false,
                            DateTime.parse(
                                controller.dataPaketNow.packetStartDate),
                            DateTime.parse(
                                controller.dataPaketNow.packetEndDate),
                            controller.dataPaketNow.periodeAwal,
                            controller.dataPaketNow.periodeAkhir,
                            controller.dataPaketNow.nextPeriode
                          ]);
                      if (result != null) {
                        CustomToast.show(
                          context: Get.context,
                          message: "SubscriptionAlertSubUserBuySuccess".tr,
                        );
                        controller.getDataCek();
                      }
                    }),
              )
            : Container(),
        Container(
          height: GlobalVariable.ratioWidth(Get.context) * 16,
        )
      ]),
    );
  }

  Widget _cardSubUser() {
    return Padding(
      padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 14),
      child: Container(
        //sub user
        key: controller.keyTutor1,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_subscription_sub.png"),
            fit: BoxFit.fill,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorBlack).withOpacity(0.1),
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
              spreadRadius: 0,
              offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 4),
            ),
          ],
          borderRadius:
              BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 11),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 16),
            child: CustomText(
              "SubscriptionPacketSubUserActive".tr,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(ListColor.colorWhite),
            ),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 8,
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              padding: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 10,
                bottom: GlobalVariable.ratioWidth(Get.context) * 7,
              ),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorLightGrey2).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 6),
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 0.5,
                    color: Color(ListColor.colorLightGrey10),
                  )),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CustomText(
                      controller.listDataSubUser.length < 1
                          ? ""
                          : "${controller.listDataSubUser[controller.indexSubUser.value].fullStartDate} - ${controller.listDataSubUser[controller.indexSubUser.value].fullEndDate}",
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(ListColor.colorWhite),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // controller.listDataSubUser.length <= 1
                        //     ? Container()
                        //     :
                        Visibility(
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          visible: !(controller.listDataSubUser.length <= 1),
                          child: Container(
                            //button kiri
                            margin: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 14),
                            decoration: BoxDecoration(
                              color: Color(0 == controller.indexSubUser.value
                                  ? ListColor.colorLightGrey2
                                  : ListColor.colorWhite),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius:
                                      GlobalVariable.ratioWidth(Get.context) * 4,
                                  spreadRadius: 0,
                                  offset: Offset(0,
                                      GlobalVariable.ratioWidth(Get.context) * 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 6),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 6),
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) * 6),
                                ),
                                onTap: () {
                                  if (0 != controller.indexSubUser.value) {
                                    controller.indexSubUser.value--;
                                  }
                                },
                                child: Container(
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: SvgPicture.asset(
                                      "assets/ic_arrow_right_subscription.svg",
                                      color: Color(
                                          0 == controller.indexSubUser.value
                                              ? ListColor.colorWhite
                                              : ListColor.colorBlue),
                                      width:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              24,
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          //text
                          child: Center(
                            child: controller.listDataSubUser.length < 1
                                ? CustomText(
                                    "Anda Tidak Memiliki Sub User",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorWhite),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        "SubscriptionSubUserHave".tr + " ",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(ListColor.colorWhite),
                                      ),
                                      CustomText(
                                        "${controller.listDataSubUser[controller.indexSubUser.value].quota} Sub User",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(ListColor.colorWhite),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        // controller.listDataSubUser.length <= 1
                        //     ? Container()
                        //     :
                        Visibility(
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          visible: !(controller.listDataSubUser.length <= 1),
                          child: Container(
                            //button kanan
                            margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 14),
                            decoration: BoxDecoration(
                              color: Color(
                                  (controller.listDataSubUser.length - 1 ==
                                          controller.indexSubUser.value)
                                      ? ListColor.colorLightGrey2
                                      : ListColor.colorWhite),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius:
                                      GlobalVariable.ratioWidth(Get.context) * 4,
                                  spreadRadius: 0,
                                  offset: Offset(0,
                                      GlobalVariable.ratioWidth(Get.context) * 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 6),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 6),
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) * 6),
                                ),
                                onTap: () {
                                  if (controller.listDataSubUser.length - 1 !=
                                      controller.indexSubUser.value) {
                                    controller.indexSubUser.value++;
                                  }
                                },
                                child: Container(
                                  child: SvgPicture.asset(
                                    "assets/ic_arrow_right_subscription.svg",
                                    color: Color(
                                        (controller.listDataSubUser.length - 1 ==
                                                controller.indexSubUser.value)
                                            ? ListColor.colorWhite
                                            : ListColor.colorBlue),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 1.5),
                        padding: EdgeInsets.only(
                            bottom: GlobalVariable.ratioWidth(Get.context) * 2),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            1.5))),
                        child: CustomText(
                          controller.listDataSubUser.length < 1 ||
                                  controller
                                          .listDataSubUser[
                                              controller.indexSubUser.value]
                                          .notUsed ==
                                      0
                              ? ""
                              : "${controller.listDataSubUser[controller.indexSubUser.value].notUsed} Sub User " +
                                  "SubscriptionSubUserNotUsed".tr,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorWhite),
                        ),
                      ),
                      controller.listDataSubUser.length < 1 ||
                              controller
                                      .listDataSubUser[
                                          controller.indexSubUser.value]
                                      .notUsed ==
                                  0
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(
                                  left:
                                      GlobalVariable.ratioWidth(Get.context) * 2),
                              padding: EdgeInsets.only(
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) * 3),
                              child: SvgPicture.asset(
                                "assets/ic_arrow_top_right_subscription.svg",
                                color: Color(ListColor.colorWhite),
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 11,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 11,
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ),
          ),
          controller.isRiwayatSubUser
              ? Row(
                  children: [
                    _button(
                        marginTop: 24,
                        useShadow: false,
                        maxWidth: false,
                        minHeight: 23,
                        borderRadius: 6,
                        backgroundColor: controller.hasAccessLihatRiwayatLanggananSubUser.value ? Colors.white : Color(ListColor.colorLightGrey2),
                        color: controller.hasAccessLihatRiwayatLanggananSubUser.value ? Color(ListColor.colorBlue) : Colors.white,
                        customWidget: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) * 8,
                                  right: GlobalVariable.ratioWidth(Get.context) * 4),
                              child: SvgPicture.asset(
                                "assets/ic_riwayat.svg",
                                width: GlobalVariable.ratioWidth(Get.context) * 14,
                                height: GlobalVariable.ratioWidth(Get.context) * 14,
                                color: controller.hasAccessLihatRiwayatLanggananSubUser.value ? Color(ListColor.colorBlue) : Colors.white,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) * 8),
                              child: CustomText(
                                "SubscriptionHistory".tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: controller.hasAccessLihatRiwayatLanggananSubUser.value ? Color(ListColor.colorBlue) : Colors.white,
                              ),
                            )
                          ],
                        ),
                        onTap: () async {
                          if (!controller.hasAccessLihatRiwayatLanggananSubUser.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                          // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "574");
                          // if (!hasAccess) {
                          //   return;
                          // }
                          GetToPage.toNamed<
                                  SubscriptionRiwayatLanggananBFDanSUListController>(
                              Routes
                                  .SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_DAN_SU_LIST,
                              arguments: TipeLayananSubscription.SU);
                        }),
                  ],
                )
              : Container(),
          Container(
            height: GlobalVariable.ratioWidth(Get.context) * 24,
          ),
          controller.tipe == TipePaketSubscription.FIRST ||
                  controller.tipe == TipePaketSubscription.EXPIRED
              ? Container()
              : _button(
                  text: "SubscriptionAdd".tr,
                  marginBottom: 12,
                  minHeight: 28,
                  fontWeight: FontWeight.w700,
                  borderRadius: 20,
                  backgroundColor: controller.hasAccessTambahSubUser.value ? Colors.white : Color(ListColor.colorLightGrey2),
                  color: controller.hasAccessTambahSubUser.value ? Color(ListColor.colorBlue) : Colors.white,
                  maxWidth: true,
                  onTap: () async {
                    if (!controller.hasAccessTambahSubUser.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                    // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "400");
                    // if (!hasAccess) {
                    //   return;
                    // }
                    var result = await GetToPage.toNamed<CreateSubuserController>(
                        Routes.CREATE_SUBUSER,
                        arguments: [
                          controller.dataPaketNow.id.toString(),
                          controller.dataPaketNow.paketID.toString(),
                          controller.dataPaketNow.name,
                          // "${controller.dataPaketNow.periodeAwal} - ${controller.dataPaketNow.periodeAkhir}",
                          false,
                          DateTime.parse(controller.dataPaketNow.packetStartDate),
                          DateTime.parse(controller.dataPaketNow.packetEndDate),
                          controller.dataPaketNow.periodeAwal,
                          controller.dataPaketNow.periodeAkhir,
                          controller.dataPaketNow.nextPeriode
                        ]);
                    if (result != null) {
                      CustomToast.show(
                        context: Get.context,
                        message: "SubscriptionAlertSubUserBuySuccess".tr,
                      );
                      controller.getDataCek();
                    }
                  }),
          _button(
              key: controller.keyTutor2,
              text: "SubscriptionViewDetail".tr,
              minHeight: 28,
              fontWeight: FontWeight.w600,
              borderRadius: 20,
              backgroundColor: controller.hasAccessLihatDaftarSubUser.value ? Colors.white : Color(ListColor.colorLightGrey2),
              color: controller.hasAccessLihatDaftarSubUser.value ? Color(ListColor.colorBlue) : Colors.white,
              maxWidth: true,
              onTap: () async {
                if (!controller.hasAccessLihatDaftarSubUser.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "401");
                // if (!hasAccess) {
                //   return;
                // }
              }),
          Container(
            height: GlobalVariable.ratioWidth(Get.context) * 16,
          )
        ]),
      ),
    );
  }

  Widget _cardNext() {
    return Container(
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 14),
      //berikutnya
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_subscription_next.png"),
          fit: BoxFit.fill,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorBlack).withOpacity(0.1),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 4),
          ),
        ],
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 11),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 16),
          child: CustomText(
            "SubscriptionPacketNext".tr,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(ListColor.colorWhite),
          ),
        ),
        Row(
          children: [
            _textCard(
                text: controller.dataPaketNext.name,
                textColor: Color(ListColor.colorBlue),
                backgroundColor: Color(ListColor.colorLightBlue3)),
            controller.dataPaketNext.subUser > 0
                ? _textCard(
                    text: "+ ${controller.dataPaketNext.subUser} User",
                    marginLeft: 8,
                    textColor: Color(ListColor.colorGreen6),
                    backgroundColor: Color(ListColor.colorLightGreen2))
                : Container(),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              top: GlobalVariable.ratioWidth(Get.context) * 22),
          child: CustomText("SubscriptionSubscriptionPeriod".tr + ' :',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.colorWhite)),
        ),
        Container(
          margin: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          child: CustomText(
              "${controller.dataPaketNext.periodeAwal} - ${controller.dataPaketNext.periodeAkhir}",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(ListColor.colorWhite)),
        ),
        Container(
          height: GlobalVariable.ratioWidth(Get.context) * 24,
        ),
        _button(
            marginBottom: controller.dataPaketNext.subUser > 0 ? 12 : 0,
            text: "SubscriptionAddSubUser".tr,
            minHeight: 28,
            fontWeight: controller.dataPaketNext.subUser > 0
                ? FontWeight.w700
                : FontWeight.w600,
            borderRadius: 20,
            backgroundColor: controller.hasAccessTambahSubUserLanggananBerikutnya.value ? Colors.white : Color(ListColor.colorLightGrey2),
            color: controller.hasAccessTambahSubUserLanggananBerikutnya.value ? Color(ListColor.colorBlue) : Colors.white,
            maxWidth: true,
            onTap: () async {
              if (!controller.hasAccessTambahSubUserLanggananBerikutnya.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
              // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "404");
              // if (!hasAccess) {
              //   return;
              // }
              var result = await GetToPage.toNamed<CreateSubuserController>(
                  Routes.CREATE_SUBUSER,
                  arguments: [
                    controller.dataPaketNext.id.toString(),
                    controller.dataPaketNext.paketID.toString(),
                    controller.dataPaketNext.name,
                    // "${controller.dataPaketNext.periodeAwal} - ${controller.dataPaketNext.periodeAkhir}",
                    true,
                    DateTime.parse(controller.dataPaketNext.packetStartDate),
                    DateTime.parse(controller.dataPaketNext.packetEndDate),
                    controller.dataPaketNext.periodeAwal,
                    controller.dataPaketNext.periodeAkhir,
                    controller.dataPaketNext.nextPeriode
                  ]);
              if (result != null) {
                CustomToast.show(
                  context: Get.context,
                  message: "SubscriptionAlertSubUserBuySuccess".tr,
                );
                controller.getDataCek();
              }
            }),
        controller.dataPaketNext.subUser > 0
            ? _button(
                text: "SubscriptionChooseUser".tr,
                minHeight: 28,
                fontWeight: FontWeight.w600,
                borderRadius: 20,
                backgroundColor: controller.hasAccessPilihUserLanggananBerikutnya.value ? Colors.white : Color(ListColor.colorLightGrey2),
                color: controller.hasAccessPilihUserLanggananBerikutnya.value ? Color(ListColor.colorBlue) : Colors.white,
                maxWidth: true,
                onTap: () async {
                  if (!controller.hasAccessPilihUserLanggananBerikutnya.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                  // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "405");
                  // if (!hasAccess) {
                  //   return;
                  // }
                })
            : Container(),
        Container(
          height: GlobalVariable.ratioWidth(Get.context) * 16,
        )
      ]),
    );
  }

  Widget _button({
    GlobalKey key,
    bool maxWidth = false,
    double marginLeft = 16,
    double marginTop = 0,
    double marginRight = 16,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = true,
    bool useBorder = false,
    double borderRadius = 10,
    double minHeight = 28,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Widget customWidget,
  }) {
    return Container(
      key: key,
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: maxWidth ? double.infinity : null,
      constraints: BoxConstraints(
          minHeight: GlobalVariable.ratioWidth(Get.context) * minHeight),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 4),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10),
                )
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
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            alignment: Alignment.centerLeft,
            height: GlobalVariable.ratioWidth(Get.context) * 24,
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * marginLeft),
            padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 8,
                0,
                GlobalVariable.ratioWidth(Get.context) * 8,
                0),
            child: CustomText(
              text,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6),
            )),
      ],
    );
  }

  Future<bool> onWillPop() {
    return Future.value(!controller.loading.value);
  }
}

class _AppBar extends PreferredSize {
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SubscriptionHomeController>();
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
                          // GlobalAlertDialog.showAlertDialogCustom(
                          //     insetPadding: 16,
                          //     borderRadius: 15,
                          //     widthButton1: 254,
                          //     heightButton1: 40,
                          //     context: Get.context,
                          //     isDismissible: false,
                          //     title: "",
                          //     customMessage: Container(
                          //       margin: EdgeInsets.only(
                          //           bottom:
                          //               GlobalVariable.ratioWidth(Get.context) *
                          //                   20),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Container(
                          //             margin: EdgeInsets.only(
                          //                 bottom: GlobalVariable.ratioWidth(
                          //                         Get.context) *
                          //                     28),
                          //             child: SvgPicture.asset(
                          //                 "assets/pembayaran_berhasil.svg",
                          //                 width: GlobalVariable.ratioWidth(
                          //                         Get.context) *
                          //                     124,
                          //                 height: GlobalVariable.ratioWidth(
                          //                         Get.context) *
                          //                     124),
                          //           ),
                          //           CustomText(
                          //             "SubscriptionPaymentSuccess".tr,
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w700,
                          //           ),
                          //           Container(
                          //               height: GlobalVariable.ratioWidth(
                          //                       Get.context) *
                          //                   11),
                          //           CustomText(
                          //             "wqeqweqweqweqweqwe",
                          //             // "${'SubscriptionSubscriptionSuccessAlert1'.tr} $namaPaket. ${'SubscriptionSubscriptionSuccessAlert2'.tr} $textPeriode",
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w500,
                          //             height: 1.2,
                          //             textAlign: TextAlign.center,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     labelButtonPriority1:
                          //         "SubscriptionLabelKembaliKeMuatmuat".tr,
                          //     positionColorPrimaryButton:
                          //         PositionColorPrimaryButton.PRIORITY1);
                        })
                  ],
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _placeHolderInfo(),
                    Container(
                      margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 5.17,
                          right: GlobalVariable.ratioWidth(Get.context) * 5.17),
                      child: CustomText(
                        "SubscriptionTitle".tr,
                        color: Color(ListColor.colorWhite),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    controller.loading.value
                        ? _placeHolderInfo()
                        : !controller.isSegmented
                            ? _placeHolderInfo()
                            : Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    SubscriptionPopupKeuntungan.showAlertDialog(
                                        context: Get.context,
                                        onTap: () async {
                                          if (!controller.hasAccessTambahLangganan.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
                                          // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "16");
                                          // if (!hasAccess) {
                                          //   return;
                                          // }
                                          var result = await GetToPage.toNamed<
                                                  CreateSubscriptionController>(
                                              Routes.CREATE_SUBSCRIPTION,
                                              arguments: [
                                                controller.tipe ==
                                                    TipePaketSubscription
                                                        .WILL_EXPIRED,
                                                controller.userStatus.isFirstBFShipper == 1,
                                                controller.tipe ==
                                                        TipePaketSubscription
                                                            .WILL_EXPIRED
                                                    ? controller.dataPaketNow
                                                        .fullPeriodeAkhir
                                                    : "",
                                                controller.tipe ==
                                                        TipePaketSubscription
                                                            .WILL_EXPIRED
                                                    ? controller.dataPaketNow
                                                        .fullNextPeriode
                                                    : ""
                                              ]);
                                          if (result != null) {
                                            controller
                                                .resultPembayaranSubsciption(
                                                    result[0], result[1],
                                                    kredit: result[2]);
                                          }
                                        });
                                  },
                                  child: Container(
                                      child: SvgPicture.asset(
                                    "assets/ic_info.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.67,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.67,
                                    color: Color(ListColor.colorWhite),
                                  )),
                                ),
                              ),
                  ],
                ),
              )
            ])),
      )),
    );
  }

  _AppBar({this.preferredSize});

  Widget _placeHolderInfo() {
    return Container(
        child: SvgPicture.asset("assets/ic_info.svg",
            width: GlobalVariable.ratioWidth(Get.context) * 11.67,
            height: GlobalVariable.ratioWidth(Get.context) * 11.67,
            color: Colors.transparent));
  }
}
