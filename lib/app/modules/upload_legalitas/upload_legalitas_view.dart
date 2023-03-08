import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/upload_legalitas/upload_legalitas_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import '../api_login_register.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UploadLegalitasView extends GetView<UploadLegalitasController> {
  @override
  Widget build(BuildContext context) {
    print('build upload legalitas shipper');
    return WillPopScope(
      onWillPop: () async {
        controller.cancel();
        return false;
      },
      child: Container(
        color: Color(ListColor.color4),
        child: SafeArea(
          child: Scaffold(
              extendBody: true,
              appBar: _AppBar(
                title: controller.param['type'] == TipeModul.BF ? 'BFTMRegisterBFDaftarBigFleetsShipper'.tr : 'BFTMRegisterTMDaftarShipperTransportMarket'.tr,
                preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 99),
                onBack: (){
                  controller.cancel();
                },
              ),
              backgroundColor: Colors.white,
              body:
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.formKey.value,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // _header(),
                              if(controller.param["entity"] == TipeBadanUsaha.PT_CV)...[
                                _formAkta1(),
                                _formAkta2(),
                                _formAkta3(),
                              ],
                              _formKtpDirektur(),
                              if(controller.param["entity"] == TipeBadanUsaha.PT_CV)...[
                                _formAkta4(),
                              ],
                              _formNib(),
                              if(controller.param["entity"] == TipeBadanUsaha.PT_CV)...[
                                _formSertifikatStandar(),
                              ],
                              _formNpwpPerusahaan(),
                              _formKtp(),
                              SizedBox(
                                height: GlobalVariable.ratioWidth(Get.context) * 24,
                              )                          
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        // margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 24),
                        // height: GlobalVariable.ratioWidth(Get.context) * 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                            spreadRadius: 0,
                            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3)
                          )]
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _button(
                              width: 160,
                              height: 32,
                              marginLeft: 16,
                              marginTop: 16,
                              marginRight: 4,
                              marginBottom: 16,
                              useBorder: true,
                              borderColor: Color(ListColor.colorBlue),
                              borderSize: 1,
                              borderRadius: 18,
                              text: "Kembali",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorBlue),
                              backgroundColor: Colors.white,
                              onTap: () async {
                                controller.cancel();
                              }
                            ),
                            Obx(
                              () => _button(
                                  width: 160,
                                  height: 32,
                                  marginLeft: 4,
                                  marginTop: 16,
                                  marginRight: 16,
                                  marginBottom: 16,
                                  useBorder: false,
                                  borderRadius: 18,
                                  text: "Daftar",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: !controller.isFilled.value
                                      ? Color(ListColor.colorLightGrey4)
                                      : Colors.white,
                                  backgroundColor:
                                      !controller.isFilled.value
                                          ? Color(ListColor.colorLightGrey2)
                                          : Color(ListColor.colorBlue),
                                  onTap: () async {
                                    if(controller.isFilled.value) {
                                      bool isValidAll = true;

                                      if(controller.ktpDirekturController.text.length < 16) {
                                        isValidAll = false;
                                        controller.isValidKtpDirektur.value = false;
                                        CustomToastTop.show(
                                          context: Get.context, 
                                          message: (controller.param["entity"] == TipeBadanUsaha.PT_CV) ? "No. KTP Direktur Salah!" : "No. KTP Pengurus Salah!",
                                          isSuccess: 0
                                        );                                        
                                        return;
                                      }

                                      if(controller.npwpPerusahaanController.text.length < 15) {
                                        isValidAll = false;
                                        controller.isValidNpwpPerusahaan.value = false;
                                        CustomToastTop.show(
                                          context: Get.context, 
                                          message: "No. NPWP Anda harus terdiri dari 15-16 digit!",
                                          isSuccess: 0
                                        );
                                        return;
                                      }

                                      if(controller.ktpController.text.length < 16) {
                                        isValidAll = false;
                                        controller.isValidKtp.value = false;
                                        CustomToastTop.show(
                                          context: Get.context, 
                                          message: "No. KTP Pendaftar Salah!",
                                          isSuccess: 0
                                        );
                                        return;
                                      }

                                      if(isValidAll){
                                        controller.submit();
                                      }
                                    }
                                  }),
                            ),
                          ],
                        ),
                      )
                  ],
                )
              ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Data Kelengkapan Legalitas",
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 3,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Unggah dan isi kelengkapan legalitas dibawah",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorGrey3),
          ),
        ),
        _button(
          maxWidth: true,
          height: 35,
          marginLeft: 16,
          marginRight: 16,
          borderColor: Color(ListColor.colorBlue),
          borderSize: 1,
          borderRadius: 18,
          text: "Unggah Nanti",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(ListColor.colorBlue),
          backgroundColor: Colors.white,
          onTap: (){
            // Get.toNamed(Routes.SUCCESS_REGISTER_SELLER_WITHOUT_LEGALITY);
          }
        ),
      ],
    );
  }

  Widget _formAkta1() {
    return Column(
      children: [        
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomTextWithIcon(
            "Akta Pendirian Perusahaan dan SK KEMENKUMHAM (bila ada)",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: Color(ListColor.colorLightGrey4),
            iconAssets: 'assets/ic_info_blue.svg',
            iconAssetsWidth: 14,
            iconAssetsHeight: 14,
            onTap: () {
              controller.showHintFile(1);
            },
          ),
        ),
        _progressBar(1),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              thumbColor: Color(ListColor.colorGrey3),
              thickness: GlobalVariable.ratioWidth(Get.context) * 4,
              radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileAkta1Result.length,
                itemBuilder: (context, index) {
                  if(!controller.fileAkta1Result[index].toString().contains(".")){
                    return _errorUpload(controller.fileAkta1Result[index]);
                  }
                  return _successUpload(controller.fileAkta1Result[index], 1, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(1);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _formAkta2() {
    return Column(
      children: [        
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Akta Anggaran Dasar Terakhir dan SK (bila ada)",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(2),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              thumbColor: Color(ListColor.colorGrey3),
              thickness: GlobalVariable.ratioWidth(Get.context) * 4,
              radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileAkta2Result.length,
                itemBuilder: (context, index) {
                  if(!controller.fileAkta2Result[index].toString().contains(".")){
                    return _errorUpload(controller.fileAkta2Result[index]);
                  }
                  return _successUpload(controller.fileAkta2Result[index], 2, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(2);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _formAkta3() {
    return Column(
      children: [        
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Akta Direksi dan Dewan Komisaris terakhir dan SK MenkumHam (bila ada)",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(3),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileAkta3Result.length,
                itemBuilder: (context, index) {
                  if(!controller.fileAkta3Result[index].toString().contains(".")){
                    return _errorUpload(controller.fileAkta3Result[index]);
                  }
                  return _successUpload(controller.fileAkta3Result[index], 3, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(3);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _formKtpDirektur() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            (controller.param["entity"] == TipeBadanUsaha.PT_CV) ? "File KTP Direktur (salah satu)*" : "File KTP Pengurus (salah satu)*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(4),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              thumbColor: Color(ListColor.colorGrey3),
              thickness: GlobalVariable.ratioWidth(Get.context) * 4,
              radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileKtpDirekturResult.length,
                itemBuilder: (context, index) {
                  if(!controller.fileKtpDirekturResult[index].toString().contains(".")){
                    return _errorUpload(controller.fileKtpDirekturResult[index]);
                  }
                  return _successUpload(controller.fileKtpDirekturResult[index], 4, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(4);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            (controller.param["entity"] == TipeBadanUsaha.PT_CV) ? "No KTP Direktur (salah satu)*" : "No KTP Pengurus (salah satu)*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        Obx(() =>
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
            ),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: controller.isValidKtpDirektur.value ? Color(ListColor.colorLightGrey10) : Color(ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 8,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 8,
            ),
            child: Row(
              children: [
                // TARUH ICON DISINI
                // Container(
                //   margin: EdgeInsets.only(
                //     right: GlobalVariable.ratioWidth(Get.context) * 10,
                //   ),
                //   child: SvgPicture.asset(
                //     "assets/ic_username_seller.svg",
                //     width: GlobalVariable.ratioWidth(Get.context) * 24,
                //     height: GlobalVariable.ratioWidth(Get.context) * 24,
                //     color: Color(ListColor.colorLightGrey2),
                //   ),
                // ),
                Expanded(
                  child: CustomTextFormField(
                    context: Get.context,
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, 
                      LengthLimitingTextInputFormatter(16)
                    ],
                    onChanged: (value) {
                      controller.isValidKtpDirektur.value = true;
                      controller.checkFormFilled();
                      print("Filled: " + controller.isFilled.value.toString());
                      print("Valid: " + controller.isValidKtpDirektur.value.toString());
                    },
                    controller: controller.ktpDirekturController,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.2,
                    ),
                    textSize: 14,
                    newInputDecoration: InputDecoration(
                      hintText: "No KTP Sesuai dengan file KTP yang diupload",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(ListColor.colorLightGrey2)),
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
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _formAkta4() {
    return Column(
      children: [        
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Akta Perubahan terakhir dan SK (jika ada)",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(5),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileAkta4Result.length,
                itemBuilder: (context, index) {
                  if(!controller.fileAkta4Result[index].toString().contains(".")){
                    return _errorUpload(controller.fileAkta4Result[index]);
                  }
                  return _successUpload(controller.fileAkta4Result[index], 5, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(5);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _formNib() {
    return Column(
      children: [
        // FORM NIB
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "File NIB*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        // UPLOADED FILE NIB
        _progressBar(6),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              thumbColor: Color(ListColor.colorGrey3),
              thickness: GlobalVariable.ratioWidth(Get.context) * 4,
              radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileNibResult.length,
                itemBuilder: (context, index) {
                  if(!controller.fileNibResult[index].toString().contains(".")){
                    return _errorUpload(controller.fileNibResult[index]);
                  }
                  return _successUpload(controller.fileNibResult[index], 6, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(6);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _formSertifikatStandar() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "File Sertifikat Standar (optional)",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(7),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              thumbColor: Color(ListColor.colorGrey3),
              thickness: GlobalVariable.ratioWidth(Get.context) * 4,
              radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileSertifikatResult.length,
                itemBuilder: (context, index) {
                  if(!controller.fileSertifikatResult[index].toString().contains(".")){
                    return _errorUpload(controller.fileSertifikatResult[index]);
                  }
                  return _successUpload(controller.fileSertifikatResult[index], 7, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(7);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _formNpwpPerusahaan() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "No NPWP Perusahaan*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        Obx(() =>
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
            ),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: controller.isValidNpwpPerusahaan.value ? Color(ListColor.colorLightGrey10) : Color(ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 8,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 8,
            ),
            child: Row(
              children: [
                // TARUH ICON DISINI
                // Container(
                //   margin: EdgeInsets.only(
                //     right: GlobalVariable.ratioWidth(Get.context) * 10,
                //   ),
                //   child: SvgPicture.asset(
                //     "assets/ic_username_seller.svg",
                //     width: GlobalVariable.ratioWidth(Get.context) * 24,
                //     height: GlobalVariable.ratioWidth(Get.context) * 24,
                //     color: Color(ListColor.colorLightGrey2),
                //   ),
                // ),
                Expanded(
                  child: CustomTextFormField(
                    context: Get.context,
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, 
                      LengthLimitingTextInputFormatter(16)
                    ],
                    onChanged: (value) {
                      controller.isValidNpwpPerusahaan.value = true;
                      controller.checkFormFilled();
                      print("Filled: " + controller.isFilled.value.toString());
                      print("Valid: " + controller.isValidNpwpPerusahaan.value.toString());
                    },
                    controller: controller.npwpPerusahaanController,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.2,
                    ),
                    textSize: 14,
                    newInputDecoration: InputDecoration(
                      hintText: "Masukkan 16 digit No NPWP",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(ListColor.colorLightGrey2)),
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
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "File NPWP Perusahaan*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(8),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              thumbColor: Color(ListColor.colorGrey3),
              thickness: GlobalVariable.ratioWidth(Get.context) * 4,
              radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileNpwpPerusahaanResult.length,
                itemBuilder: (context, index) {
                  if(!controller.fileNpwpPerusahaanResult[index].toString().contains(".")){
                    return _errorUpload(controller.fileNpwpPerusahaanResult[index]);
                  }
                  return _successUpload(controller.fileNpwpPerusahaanResult[index], 8, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(8);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _formKtp() {
    return Column(
      children: [
        // FORM KTP
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "No KTP Pendaftar/Pemegang Akun*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        Obx(() =>
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 24,
            ),
            height: GlobalVariable.ratioWidth(Get.context) * 40,
            // TARUH BORDER TEXTFIELD DISINI
            decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: controller.isValidKtp.value ? Color(ListColor.colorLightGrey10) : Color(ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 8,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 8,
            ),
            child: Row(
              children: [
                // TARUH ICON DISINI
                // Container(
                //   margin: EdgeInsets.only(
                //     right: GlobalVariable.ratioWidth(Get.context) * 10,
                //   ),
                //   child: SvgPicture.asset(
                //     "assets/ic_username_seller.svg",
                //     width: GlobalVariable.ratioWidth(Get.context) * 24,
                //     height: GlobalVariable.ratioWidth(Get.context) * 24,
                //     color: Color(ListColor.colorLightGrey2),
                //   ),
                // ),
                Expanded(
                  child: CustomTextFormField(
                    context: Get.context,
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, 
                      LengthLimitingTextInputFormatter(16)
                    ],
                    onChanged: (value) {
                      controller.isValidKtp.value = true;
                      controller.checkFormFilled();
                      print("Filled: " + controller.isFilled.value.toString());
                      print("Valid: " + controller.isValidKtp.value.toString());
                    },
                    controller: controller.ktpController,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.2,
                    ),
                    textSize: 14,
                    newInputDecoration: InputDecoration(
                      hintText: "Masukkan 16 digit No KTP",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(ListColor.colorLightGrey2)),
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
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "File KTP Pendaftar/Pemegang Akun*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(9),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              thumbColor: Color(ListColor.colorGrey3),
              thickness: GlobalVariable.ratioWidth(Get.context) * 4,
              radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
              child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileKtpResult.length,
                itemBuilder: (context, index) {
                  if(!controller.fileKtpResult[index].toString().contains(".")){
                    return _errorUpload(controller.fileKtpResult[index]);
                  }
                  return _successUpload(controller.fileKtpResult[index], 9, index);
                }
              ),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _button(
            width: 119,
            height: 30,
            marginLeft: 16,
            marginRight: 16,
            useBorder: false,
            borderRadius: 18,
            backgroundColor: Color(ListColor.colorBlue),
            customWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_upload_seller.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 12,
                  height: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                CustomText(
                  "Upload",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: (){
              controller.showUpload(9);
            }
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Format file jpg/png/pdf/zip max.5Mb",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        // _divider(),
      ],
    );
  }

  Widget _fakeProgressBar({
    bool maxWidth = false,
    double width = 0,
    double height = 0,
    int exponent = 0,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    double borderRadius,
    Color foregroundColor,
    Color backgroundColor,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft,
        GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight,
        GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: (maxWidth) ? double.infinity : GlobalVariable.ratioWidth(Get.context) * width,
      height: GlobalVariable.ratioWidth(Get.context) * height,
      child: Stack(
        // alignment: Alignment.centerLeft,
        children: [
          Container(
            width: (maxWidth) ? double.infinity : GlobalVariable.ratioWidth(Get.context) * width,
            height: GlobalVariable.ratioWidth(Get.context) * height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
              color: backgroundColor
            ),
          ),
          Container(
            width: ((GlobalVariable.ratioWidth(Get.context) * MediaQuery.of(Get.context).size.width) - GlobalVariable.ratioWidth(Get.context) * 32) / exponent,
            height: GlobalVariable.ratioWidth(Get.context) * height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
              color: foregroundColor
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressBar(int type) {
    return Obx(() => controller.ratioPerForm[type] == -1.0 ? Container() : Padding(
      padding: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(Get.context).size.width - (GlobalVariable.ratioWidth(Get.context) * 32),
            height: GlobalVariable.ratioWidth(Get.context) * 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Color(ListColor.colorLightGrey2)
            ),
          ),
          AnimatedContainer(
            duration: controller.ratioPerForm[type] == 0 ? Duration.zero : Duration(milliseconds: 200),
            width: (MediaQuery.of(Get.context).size.width - (GlobalVariable.ratioWidth(Get.context) * 32)) * controller.ratioPerForm[type],
            height: GlobalVariable.ratioWidth(Get.context) * 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Color(controller.ratioPerForm[type] == 0 ? ListColor.colorLightGrey2 : ListColor.colorBlue),
            )
          )
        ],
      ),
    ));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 0),
      width: double.infinity,
      height: GlobalVariable.ratioWidth(Get.context) * 0.5,
      color: Color(ListColor.colorLightGrey10),
    );
  }

  Widget _successUpload(String message, int type, int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 16, 
        GlobalVariable.ratioWidth(Get.context) * 0, 
        GlobalVariable.ratioWidth(Get.context) * 16, 
        GlobalVariable.ratioWidth(Get.context) * 16, 
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
            child: SvgPicture.asset(
              "assets/ic_success_upload_seller.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 16,
              height: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 16),
              child: CustomText(
                  message,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  color: Color(ListColor.colorGreen3),
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                log("Type: " + type.toString());
                if(type == 1){
                  controller.fileAkta1.removeAt(index);
                  controller.fileAkta1Result.removeAt(index);
                }
                else if(type == 2){
                  controller.fileAkta2.removeAt(index);
                  controller.fileAkta2Result.removeAt(index);
                }
                else if(type == 3){
                  controller.fileAkta3.removeAt(index);
                  controller.fileAkta3Result.removeAt(index);
                }
                else if(type == 4){
                  controller.fileKtpDirektur.removeAt(index);
                  controller.fileKtpDirekturResult.removeAt(index);
                }
                else if(type == 5){
                  controller.fileAkta4.removeAt(index);
                  controller.fileAkta4Result.removeAt(index);
                }
                else if(type == 6){
                  controller.fileNib.removeAt(index);
                  controller.fileNibResult.removeAt(index);
                }
                else if(type == 7){
                  controller.fileSertifikat.removeAt(index);
                  controller.fileSertifikatResult.removeAt(index);
                }
                else if(type == 8){
                  controller.fileNpwpPerusahaan.removeAt(index);
                  controller.fileNpwpPerusahaanResult.removeAt(index);
                }
                else if(type == 9){
                  controller.fileKtp.removeAt(index);
                  controller.fileKtpResult.removeAt(index);
                }
                controller.checkFormFilled();
              },
              child: SvgPicture.asset(
                "assets/ic_close1,5.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 16,
                height: GlobalVariable.ratioWidth(Get.context) * 16,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
            child: GestureDetector(
              onTap: (){
                log("Type: " + type.toString());
                log("Index: " + index.toString());
                controller.showUpload(type);
                controller.changeIndex = index;
              },
              child: CustomText(
                  "Ubah File",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  color: Color(ListColor.colorBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorUpload(String errorMessage) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 16, 
        GlobalVariable.ratioWidth(Get.context) * 0, 
        GlobalVariable.ratioWidth(Get.context) * 16, 
        GlobalVariable.ratioWidth(Get.context) * 16, 
      ),
      child: Row(
        crossAxisAlignment: errorMessage == "Format file tidak sesuai ketentuan dan file maksimal 5MB!" ? 
        CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
            padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 2),
            child: SvgPicture.asset(
              "assets/ic_error_upload_seller.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 16,
              height: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 16),
              child: CustomText(
                  errorMessage,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorRed),
              ),
            ),
          ),
        ],
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

class _AppBar extends PreferredSize {
  final String title;
  final Size preferredSize;
  final Function() onBack;

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<FormPendaftaranIndividuController>();
    return SafeArea(
        child: Container(
            height: preferredSize.height,
            color: Color(ListColor.color4),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomBackButton(
                        context: Get.context, 
                        onTap: onBack
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 12),
                          child: CustomText(
                            title,
                            color: Color(ListColor.colorWhite),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 0, 
                      GlobalVariable.ratioWidth(Get.context) * 12, 
                      GlobalVariable.ratioWidth(Get.context) * 0, 
                      GlobalVariable.ratioWidth(Get.context) * 16
                    ),
                    width: double.infinity,
                    height: GlobalVariable.ratioWidth(Get.context) * 0.5,
                    color: Color(ListColor.colorLightBlue5),
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Container(
                          child: CustomText(
                            'Kelengkapan Legalitas',
                            color: Color(ListColor.colorWhite),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 78,
                        height: GlobalVariable.ratioWidth(Get.context) * 19,
                        child: SvgPicture.asset(
                          'assets/ic_step_3_of_3.svg',
                          width: GlobalVariable.ratioWidth(Get.context) * 78,
                          height: GlobalVariable.ratioWidth(Get.context) * 19,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }

  _AppBar({this.title, this.preferredSize, this.onBack});
}

class _CustomBackButton extends StatelessWidget {
  final BuildContext context;
  final Function onTap;
  final Color iconColor;
  final Color backgroundColor;
  _CustomBackButton(
      {@required this.context,
      @required this.onTap,
      this.iconColor,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    double radius = 25;
    return Container(
      height: GlobalVariable.ratioWidth(context) * 24,
      width: GlobalVariable.ratioWidth(context) * 24,
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(ListColor.colorWhite),
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(context) * radius),
      ),
      child: Material(
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(context) * radius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                GlobalVariable.ratioWidth(context) * radius),
          ),
          onTap: () {
            onTap();
          },
          child: Container(
            child: SvgPicture.asset(
              "assets/ic_back_seller.svg",
              color: iconColor ?? Color(ListColor.colorBlue),
              width: GlobalVariable.ratioWidth(Get.context) * 24,
              height: GlobalVariable.ratioWidth(Get.context) * 24,
            ),
          ),
        ),
      ),
    );
  }
}


// Obx(() =>
//           _fakeProgressBar(
//             maxWidth: true,
//             height: 4,
//             exponent: controller.fileAkta1Timer.value,
//             marginLeft: 16,
//             marginTop: 0,
//             marginRight: 16,
//             marginBottom: 16,
//             borderRadius: 9,
//             backgroundColor: Color(ListColor.colorLightGrey2),
//             foregroundColor: Color(ListColor.colorBlue),
//           ),
//         ), 