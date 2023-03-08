import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/modules/buyer/halaman_awal/halaman_awal_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_controller.dart';
import 'package:muatmuat/app/modules/notification/notif_controller.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/main.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_view.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'home/home/home/home_controller.dart';
import 'login/model_data.dart';

class FakeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 16),
            child: Column(
              children: [
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
                Container(
                  child: CustomText(
                    "Fake Home Muat Muat",
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 24),
                  width: GlobalVariable.ratioWidth(Get.context) * 120,
                  height: GlobalVariable.ratioWidth(Get.context) * 21,
                  child: SvgPicture.asset(
                    'assets/ic_logo_muatmuat.svg',
                    width: GlobalVariable.ratioWidth(Get.context) * 120,
                  ),
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "NOTIF WITH BOTTOM NAVBAR",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: (){
                     Get.to(() => NotifChatView());
                    // Get.to(NotifChatView());
                    // GetToPage.toNamed<HomeController>(
                    //   // Routes.HOME,
                    //   Routes.AFTER_LOGIN_SUBUSER,
                    // );
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "HOME",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: (){
                    GetToPage.toNamed<HomeController>(
                      // Routes.HOME,
                      Routes.AFTER_LOGIN_SUBUSER,
                    );
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "Big Fleets Shipper",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: () async {
                    final result = await GetToPage.toNamed<RegisterShipperBfTmController>(
                      Routes.REGISTER_SHIPPER_BF_TM,
                      arguments: TipeModul.BF
                    );
                    
                    if (result != null) {
                      CustomToastTop.show(
                        message: result,
                        context: Get.context,
                        isSuccess: 0,
                      );
                    }
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "Transport Market Shipper",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: () async {
                    final result = await GetToPage.toNamed<RegisterShipperBfTmController>(
                      Routes.REGISTER_SHIPPER_BF_TM,
                      arguments: TipeModul.TM
                    );
                    
                    if (result != null) {
                      CustomToastTop.show(
                        message: result,
                        context: Get.context,
                        isSuccess: 0,
                      );
                    }
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "Notifikasi",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: (){
                    GetToPage.toNamed<NotifControllerNew>(Routes.NOTIF);
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "Template Widget",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: (){
                    Get.to(() => MainPage());
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "Implementasi Template Widget",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: (){
                    Get.to(HalamanAwalView(),
                      arguments: BuyerArgs(
                        id: 4,
                        menuName: "Transportation Store"
                      ),
                    );
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "Manajemen Mitra",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: (){
                    GetToPage.toNamed<ManajemenMitraController>(Routes.MANAJEMEN_MITRA);
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "Pop Up Survei",
                  color: Colors.white,
                  backgroundColor: Color(ListColor.colorBlue),
                  borderRadius: 25,
                  onTap: (){
                    var selected = "0".obs;
                    var textController = TextEditingController();
                    var lebar = 20 * GlobalVariable.ratioWidth(Get.context);

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          // key: _keyDialog,
                          backgroundColor: Colors.white,
                          insetPadding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 10)
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(context) * 23,
                                        vertical: GlobalVariable.ratioWidth(context) * 30
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: GlobalVariable.ratioWidth(context) * 4
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: CustomText(
                                                // "SubscriptionCancelConfirmation".tr,
                                                "Selamat Datang di Ekosistem muatmuat",
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: GlobalVariable.ratioWidth(context) * 20
                                            ),
                                            child: CustomText(
                                              // "SubscriptionCancelConfirmationMessage".tr,
                                              "Bantu kami mengisi survei berikut ini. Partisipasi Anda sangat berarti untuk pengembangan muatmuat.",
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Container(  
                                            margin: EdgeInsets.only(
                                              bottom: GlobalVariable.ratioWidth(context) * 14
                                            ),                                          
                                            child: CustomText(
                                              // "SubscriptionCancelConfirmationMessage".tr,
                                              "Darimana Anda Mengetahui muatmuat?",
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Obx(() => 
                                                  RadioButtonCustom(
                                                    colorSelected: Color(ListColor.colorBlue),
                                                    colorUnselected: Color(ListColor.colorBlue),
                                                    isWithShadow: true,
                                                    isDense: true,
                                                    width: lebar,
                                                    height: lebar,
                                                    groupValue: selected.value,
                                                    value: "1",
                                                    onChanged: (value) {
                                                      selected.value = value;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 14),
                                                  child: Expanded(
                                                    child: CustomText(
                                                      // "SubscriptionCancelConfirmationOption1".tr,
                                                      "Televisi",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(ListColor.colorDarkGrey3),
                                                    )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: GlobalVariable.ratioWidth(context) * 12,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Obx(() => 
                                                  RadioButtonCustom(
                                                    colorSelected: Color(ListColor.colorBlue),
                                                    colorUnselected: Color(ListColor.colorBlue),
                                                    isWithShadow: true,
                                                    isDense: true,
                                                    width: lebar,
                                                    height: lebar,
                                                    groupValue: selected.value,
                                                    value: "2",
                                                    onChanged: (value) {
                                                      selected.value = value;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 14),
                                                  child: Expanded(
                                                    child: CustomText(
                                                      // "SubscriptionCancelConfirmationOption2".tr,
                                                      "Radio",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(ListColor.colorDarkGrey3),
                                                    )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: GlobalVariable.ratioWidth(context) * 12,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Obx(() => 
                                                  RadioButtonCustom(
                                                    colorSelected: Color(ListColor.colorBlue),
                                                    colorUnselected: Color(ListColor.colorBlue),
                                                    isWithShadow: true,
                                                    isDense: true,
                                                    width: lebar,
                                                    height: lebar,
                                                    groupValue: selected.value,
                                                    value: "3",
                                                    onChanged: (value) {
                                                      selected.value = value;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 14),
                                                  child: Expanded(
                                                    child: CustomText(
                                                      // "SubscriptionCancelConfirmationOption3".tr,
                                                      "Google",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(ListColor.colorDarkGrey3),
                                                    )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: GlobalVariable.ratioWidth(context) * 12,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Obx(() => 
                                                  RadioButtonCustom(
                                                    colorSelected: Color(ListColor.colorBlue),
                                                    colorUnselected: Color(ListColor.colorBlue),
                                                    isWithShadow: true,
                                                    isDense: true,
                                                    width: lebar,
                                                    height: lebar,
                                                    groupValue: selected.value,
                                                    value: "4",
                                                    onChanged: (value) {
                                                      selected.value = value;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 14),
                                                  child: Expanded(
                                                    child: CustomText(
                                                      // "SubscriptionCancelConfirmationOption3".tr,
                                                      "Social Media",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(ListColor.colorDarkGrey3),
                                                    )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: GlobalVariable.ratioWidth(context) * 12,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Obx(() => 
                                                  RadioButtonCustom(
                                                    colorSelected: Color(ListColor.colorBlue),
                                                    colorUnselected: Color(ListColor.colorBlue),
                                                    isWithShadow: true,
                                                    isDense: true,
                                                    width: lebar,
                                                    height: lebar,
                                                    groupValue: selected.value,
                                                    value: "5",
                                                    onChanged: (value) {
                                                      selected.value = value;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 14),
                                                  child: Expanded(
                                                    child: CustomText(
                                                      // "SubscriptionCancelConfirmationOption4".tr,
                                                      "Lainnya",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(ListColor.colorDarkGrey3),
                                                    )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Obx(() => selected.value != "5"
                                            ? SizedBox(
                                                height: GlobalVariable.ratioWidth(context) * 30
                                              )
                                            : SizedBox.shrink()
                                          ),
                                          Obx(() => selected.value == "5"
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                  GlobalVariable.ratioWidth(Get.context) * 0,
                                                  GlobalVariable.ratioWidth(Get.context) * 12,
                                                  GlobalVariable.ratioWidth(Get.context) * 0,
                                                  GlobalVariable.ratioWidth(Get.context) * 30,
                                                ),
                                                height: GlobalVariable.ratioWidth(Get.context) * 40,
                                                // TARUH BORDER TEXTFIELD DISINI
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                                                    color: Color(ListColor.colorLightGrey10)
                                                  ),
                                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)
                                                ),
                                                padding: EdgeInsets.fromLTRB(
                                                  GlobalVariable.ratioWidth(Get.context) * 12,
                                                  GlobalVariable.ratioWidth(Get.context) * 8,
                                                  GlobalVariable.ratioWidth(Get.context) * 12,
                                                  GlobalVariable.ratioWidth(Get.context) * 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomTextFormField(
                                                        context: Get.context,
                                                        autofocus: false,
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (value) {
                                                          
                                                        },
                                                        controller: textController,
                                                        textInputAction: TextInputAction.next,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black,
                                                          height: 1.2,
                                                        ),
                                                        textSize: 14,
                                                        newInputDecoration: InputDecoration(
                                                          hintText: "Masukkan Jawaban Anda",
                                                          hintStyle: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            color: Color(ListColor.colorLightGrey2)
                                                          ),
                                                          fillColor: Colors.transparent,
                                                          filled: true,
                                                          isDense: true,
                                                          isCollapsed: true,
                                                          focusedBorder: InputBorder.none,
                                                          enabledBorder: InputBorder.none,
                                                          border: InputBorder.none,
                                                          disabledBorder: InputBorder.none,
                                                          contentPadding: EdgeInsets.only(
                                                            top: GlobalVariable.ratioWidth(Get.context) * 2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              _button(
                                                // Get.context,
                                                marginRight: 4,
                                                text: "Lewati",
                                                height: 36,
                                                width: 104,
                                                useBorder: true,
                                                borderSize: 1,
                                                borderColor: Color(ListColor.colorBlue),
                                                color: Color(ListColor.colorBlue),
                                                backgroundColor: Colors.white,
                                                onTap: () {
                                                  Get.back();
                                                }
                                              ),
                                              _button(
                                                // Get.context,
                                                marginLeft: 4,
                                                text: "Kirim",
                                                height: 36,
                                                width: 104,
                                                color: Colors.white,
                                                backgroundColor: Color(ListColor.colorBlue),
                                                onTap: () {
                                                  Get.back();
                                                }
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: GlobalVariable.ratioWidth(Get.context) * 12,
                                          top: GlobalVariable.ratioWidth(Get.context) * 12
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              "assets/ic_close1,5.svg",
                                              color: Color(ListColor.colorBlue),
                                              width: GlobalVariable.ratioWidth(Get.context) * 15,
                                              height: GlobalVariable.ratioWidth(Get.context) * 15,
                                            )
                                          )
                                        ),
                                      )
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  }
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
                  onTap: (){
                    LoginFunction().signOut2();
                  }
                ),
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
                  onTap: (){
                    GlobalVariable.isDebugMode = !GlobalVariable.isDebugMode;
                    CustomToastTop.show(
                      context: context, 
                      message: "Debug Mode: " + GlobalVariable.isDebugMode.toString(),
                      isSuccess: GlobalVariable.isDebugMode ? 1 : 0
                    );
                  }
                ),
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
                  onTap: (){
                    GlobalVariable.isSuperDebugMode = !GlobalVariable.isSuperDebugMode;
                    CustomToastTop.show(
                      context: context, 
                      message: "Super Debug Mode: " + GlobalVariable.isSuperDebugMode.toString(),
                      isSuccess: GlobalVariable.isSuperDebugMode ? 1 : 0
                    );
                  }
                ),
                _button(
                  maxWidth: true,
                  height: 36,
                  marginBottom: 16,
                  text: "CHANGE URL",
                  color: Colors.black,
                  backgroundColor: Color(ListColor.colorYellow),
                  borderRadius: 25,
                  onTap: (){
                    if(ApiHelper.url == "https://qc.assetlogistik.com/"){
                      ApiHelper.url = "https://devintern.assetlogistik.com/";
                      ApiHelper.urlzo = "https://devzo.assetlogistik.com/";
                      ApiHelper.urlInternal = "https://internal.assetlogistik.com/";
                      ApiHelper.urlIklan = "https://iklan.assetlogistik.com/";
                      CustomToastTop.show(
                        context: context, 
                        message: "URL CHANGED TO DEV",
                        isSuccess: 1
                      );
                    }
                    else{
                      ApiHelper.url = "https://qc.assetlogistik.com/";
                      ApiHelper.urlzo = "https://zo3.assetlogistik.com/";
                      ApiHelper.urlInternal = "https://internalqc.assetlogistik.com/";
                      ApiHelper.urlIklan = "https://iklanqc.assetlogistik.com/";
                      CustomToastTop.show(
                        context: context, 
                        message: "URL CHANGED TO QC",
                        isSuccess: 1
                      );
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      )
    );
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
        GlobalVariable.ratioWidth(Get.context) * marginBottom
      ),
      width: width == null ? maxWidth ? MediaQuery.of(Get.context).size.width : null : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
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
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        border: useBorder
          ? Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * borderSize,
              color: borderColor ?? Color(ListColor.colorBlue),
            )
          : null
      ),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
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
              GlobalVariable.ratioWidth(Get.context) * paddingBottom
            ),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            child: customWidget == null
              ? CustomText(
                  text ?? "",
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                )
              : customWidget,
          )
        ),
      ),
    );
  }
}