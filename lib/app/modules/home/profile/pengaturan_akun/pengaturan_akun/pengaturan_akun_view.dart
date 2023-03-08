import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_zona_waktu_dan_bahasa.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_password_profile/form_password_profile_controller.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_profile/otp_profile_controller.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/pengaturan_akun/pengaturan_akun_controller.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/syarat_dan_kebijakan/syarat_dan_kebijakan_controller.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/zona_waktu_dan%20bahasa/zona_waktu_dan%20bahasa_controller.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class PengaturanAkunView extends GetView<PengaturanAkunController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
        onWillPop: () {
          controller.onWillPop();
          return Future.value(false);
        },
        child: Container(
          color: Color(ListColor.colorBlue),
          child: SafeArea(
            child: Scaffold(
                appBar: AppBarDetail(
                  isBlueMode: true,
                  onClickBack: () {
                    controller.onWillPop();
                    // Get.back();
                  },
                  isWithShadow: false,
                  titleWidget: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 44),
                    child: CustomText(
                      "Pengaturan Akun",
                      fontSize: 16,
                      color: Color(ListColor.colorWhite),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                body: Obx(
                  () => controller.isLoading.value
                      ? Container(
                          color: Color(ListColor.colorWhite),
                          padding: EdgeInsets.symmetric(vertical: 40),
                          width: Get.context.mediaQuery.size.width,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      : Container(
                          color: Color(ListColor.colorLightGrey3),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     _cardAkun(),
                                     _cardSyarat(),
                                     _cardKebijakan(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                )),
          ),
        ));
  }

  Widget _cardAkun() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
        vertical: GlobalVariable.ratioWidth(Get.context) * 20
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
                  child: SvgPicture.asset(
                    "assets/ic_profil_akun.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                  ),
                ),
                CustomText(
                  "Akun",
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          ),
          _itemAkun((){
            GetToPage.toNamed<OtpProfileController>(
              Routes.OTP_PROFILE,
              arguments: {
                "phone": GlobalVariable.userModelGlobal.phone,
                "otp": TipeOtpProfil.PHONE
              }
            );
          }, "No. Whatsapp", controller.akun.phoneUsers, controller.akun.isVerifPhoneUsers == 1),
          
          _itemAkun((){
            GetToPage.toNamed<OtpProfileController>(
              Routes.OTP_PROFILE,
              arguments: {
                "phone": GlobalVariable.userModelGlobal.phone,
                "otp": TipeOtpProfil.EMAIL
              }
            );
          }, "Email", controller.akun.emailUsers.isEmpty ? "-" : controller.akun.emailUsers, controller.akun.isVerifEmailUsers == 1),
          
          if (controller.akun.isGoogle == 0) _itemAkun((){
            GetToPage.toNamed<FormPasswordProfileController>(
              Routes.FORM_PASSWORD_PROFILE,
            );
          }, "", "Ubah Password", false),
          
          _itemAkun(() async {
            var response = await GetToPage.toNamed<ZonaWaktuDanBahasaController>(Routes.ZONA_WAKTU_DAN_BAHASA, arguments: [WAKTU_BAHASA.WAKTU, ModelZonaWaktuDanBahasa(id: controller.akun.timezoneId, alias: controller.akun.alias)]);
            if(response != null) {
              if(response) {
                controller.getInit();
              }
            }
          }, "Zona Waktu", controller.akun.alias, false),
          _itemAkun(() async {
            var response = await GetToPage.toNamed<ZonaWaktuDanBahasaController>(Routes.ZONA_WAKTU_DAN_BAHASA, arguments: [WAKTU_BAHASA.BAHASA, ModelZonaWaktuDanBahasa(id: controller.akun.localization, alias: controller.akun.title)]);
            if(response != null) {
              if(response) {
                controller.isChange.value = response;
                controller.getInit();
              }
            }
          }, "Pengaturan Bahasa", controller.akun.title, false),
          // controller.akun.localization == 1
          //   ? "English"
          //   : "Bahasa Indonesia", false),
        ],
      ),
    );
  }

  Widget _cardSyarat() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 10),
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
        vertical: GlobalVariable.ratioWidth(Get.context) * 20
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
                  child: SvgPicture.asset(
                    "assets/ic_profil_syarat.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                  ),
                ),
                CustomText(
                  "Syarat dan Ketentuan",
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          ),
          _itemSyarat((){
            GetToPage.toNamed<SyaratDanKebijakanController>(Routes.SYARAT_DAN_KEBIJAKAN, arguments: "general");
          }, /* "Pengguna muatmuat", */ controller.listSyarat["general"].title),
          _itemSyarat((){
            GetToPage.toNamed<SyaratDanKebijakanController>(Routes.SYARAT_DAN_KEBIJAKAN, arguments: "bf");
          }, /* "Big Fleet" */controller.listSyarat["bf"].title),
          _itemSyarat((){
            GetToPage.toNamed<SyaratDanKebijakanController>(Routes.SYARAT_DAN_KEBIJAKAN, arguments: "tm");
          }, /* "Transport Market" */ controller.listSyarat["tm"].title),
          _itemSyarat((){
            GetToPage.toNamed<SyaratDanKebijakanController>(Routes.SYARAT_DAN_KEBIJAKAN, arguments: "register_bf");
          }, /* "Big Fleet Suscription" */ controller.listSyarat["register_bf"].title),
          _itemSyarat((){
            GetToPage.toNamed<SyaratDanKebijakanController>(Routes.SYARAT_DAN_KEBIJAKAN, arguments: "register_tm");
          }, /* "Transport Market Subscription" */ controller.listSyarat["register_tm"].title),
        ],
      ),
    );
  }

  Widget _cardKebijakan() {
    return GestureDetector(
      onTap: (){
        GetToPage.toNamed<SyaratDanKebijakanController>(Routes.SYARAT_DAN_KEBIJAKAN, arguments: "kebijakan");
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(
          top: GlobalVariable.ratioWidth(Get.context) * 10,
          bottom: GlobalVariable.ratioWidth(Get.context) * 24
        ),
        height: GlobalVariable.ratioWidth(Get.context) * 64,
        padding: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 16,
          right: GlobalVariable.ratioWidth(Get.context) * 30
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
              child: SvgPicture.asset(
                "assets/ic_profil_kebijakan.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
            ),
            Expanded(
              child: Container(
                child: CustomText(
                  "Kebijakan Privasi",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              child: SvgPicture.asset(
                "assets/ic_profil_arrow_right.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemAkun(Function onTap, String label, String text, bool isVerif) {
    return GestureDetector(
      onTap: (){onTap();},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(
            width: GlobalVariable.ratioWidth(Get.context) * 1,
            color: Color(ListColor.colorStroke),
          ))
        ),
        height: GlobalVariable.ratioWidth(Get.context) * (label.isNotEmpty ? 62 : 48),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 14),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label.isNotEmpty 
                    ? Container(
                        margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 6),
                        child: CustomText(
                          label,
                          fontSize: 12,
                          color: Color(ListColor.colorLightGrey4),
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : SizedBox.shrink(),
                    CustomText(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ),
            ),
            isVerif
            ? Container(
              alignment: Alignment.center,
              height: GlobalVariable.ratioWidth(Get.context) * 22,
              margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
              padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                color: Color(ListColor.colorGreen7)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 4),
                    child: SvgPicture.asset(
                      "assets/ic_profil_verif.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                  ),
                  CustomText(
                    "Verified",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorGreen8),
                  )
                ],
              ),
            )
            : SizedBox.shrink(),
            Container(
              margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * (isVerif ? 8 : 16),
                right: GlobalVariable.ratioWidth(Get.context) * 14),
              child: SvgPicture.asset(
                "assets/ic_profil_arrow_right.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemSyarat(Function onTap, String text) {
    return GestureDetector(
      onTap: (){onTap();},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(
            width: GlobalVariable.ratioWidth(Get.context) * 1,
            color: Color(ListColor.colorStroke),
          ))
        ),
        height: GlobalVariable.ratioWidth(Get.context) * 48,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 14),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
              child: SvgPicture.asset(
                "assets/ic_profil_arrow_right.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
