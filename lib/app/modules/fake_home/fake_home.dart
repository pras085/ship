import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/function/survei_dalog.dart';
import 'package:muatmuat/app/katalog/katalog_iklan/katalog_iklan.dart';
import 'package:muatmuat/app/katalog/katalog_iklan/tour.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_controller.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_view.dart';
import 'package:muatmuat/app/modules/buyer/halaman_awal/halaman_awal_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/report/report_controller.dart';
import 'package:muatmuat/app/modules/notification/notif_controller.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/main.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import '../home/home/home/home_controller.dart';
import '../login/model_data.dart';
import 'fake_home_controller.dart';

class FakeHome extends GetView<FakeHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(
                          GlobalVariable.ratioWidth(Get.context) * 16),
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24),
                          Container(
                            child: CustomText(
                              "Fake Home Muat Muat",
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        24),
                            width: GlobalVariable.ratioWidth(Get.context) * 120,
                            height: GlobalVariable.ratioWidth(Get.context) * 21,
                            child: SvgPicture.asset(
                              'assets/ic_logo_muatmuat.svg',
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 120,
                            ),
                          ),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "HOME",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () {
                                GetToPage.toNamed<HomeController>(
                                  // Routes.HOME,
                                  Routes.AFTER_LOGIN_SUBUSER,
                                );
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Big Fleets Shipper",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () async {
                                final result = await GetToPage.toNamed<
                                        RegisterShipperBfTmController>(
                                    Routes.REGISTER_SHIPPER_BF_TM,
                                    arguments: TipeModul.BF);

                                if (result != null) {
                                  CustomToastTop.show(
                                    message: result,
                                    context: Get.context,
                                    isSuccess: 0,
                                  );
                                }
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Transport Market Shipper",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () async {
                                final result = await GetToPage.toNamed<
                                        RegisterShipperBfTmController>(
                                    Routes.REGISTER_SHIPPER_BF_TM,
                                    arguments: TipeModul.TM);

                                if (result != null) {
                                  CustomToastTop.show(
                                    message: result,
                                    context: Get.context,
                                    isSuccess: 0,
                                  );
                                }
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Laporkan",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () async {
                                final result =
                                    await GetToPage.toNamed<ReportController>(
                                  Routes.REPORT,
                                );
                                if (result != null) {
                                  CustomToast.show(
                                      context: Get.context,
                                      message:
                                          'LaporkanIndexBerhasilMelaporkanPerusahaan'
                                              .tr);
                                }
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Share",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () async {
                                Share.share(
                                    "View my website in https://assetlogistik.com");
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Download",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () async {
                                controller.tapDownload = true;
                                controller.cekDownloadFile();
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Hubungi",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () async {
                                controller.contactPartner();
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Testimoni",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () async {
                                await GetToPage.toNamed<ReportController>(
                                  Routes.TESTIMONI,
                                );
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Notifikasi",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () {
                                GetToPage.toNamed<NotifControllerNew>(
                                    Routes.NOTIF);
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Template Widget",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () {
                                Get.to(() => MainPage());
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Implementasi Template Widget",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () {
                                Get.to(
                                  HalamanAwalView(),
                                  arguments: BuyerArgs(
                                      id: 130,
                                      menuName: "Transportation Store"),
                                );
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Manajemen Mitra",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () {
                                GetToPage.toNamed<ManajemenMitraController>(
                                    Routes.MANAJEMEN_MITRA);
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Pop Up Survei",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () {
                                SurveiDialog.showSurveiDialog(Get.context);
                              }),
                          _button(
                            maxWidth: true,
                            height: 36,
                            marginBottom: 16,
                            text: "Profile Sisi Lain",
                            color: Colors.white,
                            backgroundColor: Color(ListColor.colorBlue),
                            borderRadius: 25,
                            onTap: () =>
                                GetToPage.toNamed<OtherSideTransController>(
                                    Routes.OTHERSIDE),
                          ),
                          // KALAU MAU TAMBAH BUTTON PAKEK YANG WARNA BIRU SAJA
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "LOGOUT",
                              color: Color(ListColor.colorBlue),
                              backgroundColor: Colors.white,
                              useBorder: true,
                              borderColor: Color(ListColor.colorBlue),
                              borderSize: 1,
                              borderRadius: 25,
                              onTap: () {
                                LoginFunction().signOut2();
                              }),
                          // DEBUG MODE TOGGLE
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "DEBUG MODE",
                              color: Color(ListColor.colorBlue),
                              backgroundColor: Colors.white,
                              useBorder: true,
                              borderColor: Color(ListColor.colorBlue),
                              borderSize: 1,
                              borderRadius: 25,
                              onTap: () {
                                GlobalVariable.isDebugMode =
                                    !GlobalVariable.isDebugMode;
                                CustomToastTop.show(
                                    context: context,
                                    message: "Debug Mode: " +
                                        GlobalVariable.isDebugMode.toString(),
                                    isSuccess:
                                        GlobalVariable.isDebugMode ? 1 : 0);
                              }),
                          // SUPER DEBUG MODE TOGGLE (biarin super debug mode paling bawah)
                          // ApiHelper.url == "https://qc.assetlogistik.com/"
                          // ? SizedBox.shrink()
                          // :
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "SUPER DEBUG MODE",
                              color: Colors.black,
                              backgroundColor: Color(ListColor.colorYellow),
                              borderRadius: 25,
                              onTap: () {
                                GlobalVariable.isSuperDebugMode =
                                    !GlobalVariable.isSuperDebugMode;
                                CustomToastTop.show(
                                    context: context,
                                    message: "Super Debug Mode: " +
                                        GlobalVariable.isSuperDebugMode
                                            .toString(),
                                    isSuccess: GlobalVariable.isSuperDebugMode
                                        ? 1
                                        : 0);
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "NOTIF WITH BOTTOM NAVBAR",
                              color: Colors.white,
                              backgroundColor: Color(ListColor.colorBlue),
                              borderRadius: 25,
                              onTap: () {
                                // Get.to(() => NotifChatView());
                                GetToPage.toNamed<NotifChatController>(
                                  // Routes.HOME,
                                  Routes.NOTIF_CHAT_SCREEN,
                                );
                                // Get.to(NotifChatView());
                                // GetToPage.toNamed<HomeController>(
                                //   // Routes.HOME,
                                //   Routes.AFTER_LOGIN_SUBUSER,
                                // );
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "CHANGE URL",
                              color: Colors.black,
                              backgroundColor: Color(ListColor.colorYellow),
                              borderRadius: 25,
                              onTap: () {
                                if (ApiHelper.url ==
                                    "https://qc.assetlogistik.com/") {
                                  ApiHelper.url =
                                      "https://devintern.assetlogistik.com/";
                                  ApiHelper.urlzo =
                                      "https://devzo.assetlogistik.com/";
                                  ApiHelper.urlInternal =
                                      "https://internal.assetlogistik.com/";
                                  ApiHelper.urlIklan =
                                      "https://iklan.assetlogistik.com/";
                                  CustomToastTop.show(
                                      context: context,
                                      message: "URL CHANGED TO DEV",
                                      isSuccess: 1);
                                } else {
                                  ApiHelper.url =
                                      "https://qc.assetlogistik.com/";
                                  ApiHelper.urlzo =
                                      "https://zo3.assetlogistik.com/";
                                  ApiHelper.urlInternal =
                                      "https://internalqc.assetlogistik.com/";
                                  ApiHelper.urlIklan =
                                      "https://iklanqc.assetlogistik.com/";
                                  CustomToastTop.show(
                                      context: context,
                                      message: "URL CHANGED TO QC",
                                      isSuccess: 1);
                                }
                              }),
                          _button(
                              maxWidth: true,
                              height: 36,
                              marginBottom: 16,
                              text: "Katalog",
                              color: Colors.black,
                              backgroundColor: Color(ListColor.colorYellow),
                              borderRadius: 25,
                              onTap: () {
                                // Get.to(KatalogIklan());
                                Get.to(Tour2());
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(
                                        backgroundColor: Colors.grey,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(ListColor.color4)),
                                        value: null),
                                    Container(height: 10),
                                    CustomText("Processing"),
                                  ],
                                )),
                          ],
                        ),
                      )
              ],
            )));
  }

  // PRIVATE CUSTOM BUTTON
  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
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
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text ?? "",
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}
