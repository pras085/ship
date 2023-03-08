import 'dart:developer';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/choose_business_field/choose_business_field_controller.dart';
import 'package:muatmuat/app/modules/choose_district/choose_district_controller.dart';
import 'package:muatmuat/app/modules/file_example/file_example_controller.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/upload_picture/upload_picture_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/thousand_separator.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/dropdown_overlay.dart';
import 'package:muatmuat/app/widgets/outline_dropdown_component.dart';
import 'package:muatmuat/global_variable.dart';

class RegisterShipperBfTmView extends GetView<RegisterShipperBfTmController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.back();
        return false;
      },
      child: Container(
        color: Color(ListColor.colorBlue),
        child: SafeArea(
          child: Scaffold(
            extendBody: true,
            appBar: _AppBar(
              // title: controller.tipeModul.value == TipeModul.BF ? 'BFTMRegisterBFDaftarBigFleetsShipper'.tr : 'BFTMRegisterTMDaftarShipperTransportMarket'.tr,
              title: controller.tipeModul.value == TipeModul.BF ? 'Daftar Big Fleets Shipper' : 'Daftar Transport Market Shipper',
              subTitle: controller.subTitle.value,
              preferredSize: Size.fromHeight(
                GlobalVariable.ratioWidth(Get.context) * 99
              ),
              onBack: () {
                controller.cancel();
              },
            ),
            backgroundColor: Colors.white,
            body: Obx(() =>
              controller.loading.value ? Center(child: CircularProgressIndicator()) : _showPage(),
            )
          ),
        ),
      ),
    );
  }

  Widget _showPage() {
    if(controller.pageIndex.value == 1) {
      return _firstPage();
    }
    else if(controller.pageIndex.value == 2) {
      return _secondPage();
    }
    else {
      return _thirdPage();
    }
  }

  Widget _firstPage() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: controller.scrollControllerFirstPage,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16, 
                GlobalVariable.ratioWidth(Get.context) * 16, 
                GlobalVariable.ratioWidth(Get.context) * 16, 
                0
              ),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 16, 
                      GlobalVariable.ratioWidth(Get.context) * 12, 
                      GlobalVariable.ratioWidth(Get.context) * 16, 
                      GlobalVariable.ratioWidth(Get.context) * 12
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(ListColor.colorBlue),
                        width: GlobalVariable.ratioWidth(Get.context) * 1
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6))
                    ),
                    child: CustomText(
                      controller.tipeModul.value == TipeModul.BF ? "BFTMRegisterBFDesc".tr : "BFTMRegisterTMDesc".tr,
                      fontSize: 14,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      color: Color(ListColor.colorBlue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 14),
                  CustomText(
                    "BFTMRegisterAllDesc".tr,
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.left,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
                  CustomText(
                    'BFTMRegisterAllFileSuratJalan'.tr + "*",
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  _progressBar(
                    paddingTop: 16,
                    type: 0,
                  ),
                  Obx(() => controller.dispatchNote.isNotEmpty && controller.dispatchNote[controller.dispatchNote.length-1] == null ?
                    _errorUpload(
                      marginTop: 16,
                      errorMessage: controller.dispatchNoteResult[controller.dispatchNoteResult.length-1],
                    ) :
                    SizedBox.shrink()
                  ),
                  Obx(() =>
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 0,
                        maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
                      ),
                      child: RawScrollbar(
                        thumbColor: Color(ListColor.colorGrey3),
                        thickness: GlobalVariable.ratioWidth(Get.context) * 4,
                        radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
                        child: ListView.builder(
                          controller: controller.dispatchNoteScrollController,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          itemCount: controller.dispatchNote.length,
                          itemBuilder: (context, index) {
                            if(controller.dispatchNoteResult[index].toString().contains(".")){
                             return _successUpload(
                                marginTop: 16,
                                message: controller.dispatchNoteResult[index],
                                type: 0,
                                index: index,
                              );
                            }
                            return SizedBox.shrink();
                          }
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                  _button(
                    width: 119,
                    height: 30,
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
                      controller.showUpload(0);
                    }
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                  CustomText(
                    'BFTMRegisterAllFormatFile'.tr,
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                  CustomText(
                    'BFTMRegisterAllContohFile'.tr,
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 4),
                  GestureDetector(
                    onTap: () {
                      GetToPage.toNamed<FileExampleController>(
                        Routes.FILE_EXAMPLE,
                        arguments: controller.dispatchNoteUrl
                      );
                    },
                    child: Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 328,
                      height: GlobalVariable.ratioWidth(Get.context) * 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                        border: Border.all(
                          color: Color(ListColor.colorGrey6)
                        )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                        child: Image.asset(
                          "assets/contoh_surat_jalan_thumbnail.png",
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                  if (controller.tipeModul.value == TipeModul.TM) ...[
                    _formTransporterFirstPage(),
                  ],
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * (controller.tipeModul.value == TipeModul.TM ? 61 : 69)),
                ],
              )),
            ),
          )
        ),
        Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                spreadRadius: 0,
                offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3)
              )
            ],
            color: Colors.white
          ),
          height: GlobalVariable.ratioWidth(Get.context) * 64,
          child: Obx(() => _button(
            width: 160,
            height: 32,
            marginRight: 16,
            marginTop: 16,
            marginBottom: 16,
            useBorder: false,
            borderRadius: 26,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(!controller.isCapacityValid() ? ListColor.colorLightGrey4 : ListColor.colorWhite),
            backgroundColor: Color(!controller.isCapacityValid() ? ListColor.colorLightGrey2 : ListColor.colorBlue),
            text: 'BFTMRegisterAllSelanjutnya'.tr,
            onTap: !controller.isCapacityValid() ? null : () async {
              controller.pageIndex.value = 2;
              controller.changePageIndex(controller.pageIndex.value);
            }
          )),
        )
      ],
    );
  }

  Widget _formTransporterFirstPage() {
    return Padding(
      padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'BFTMRegisterTMTransporterDariSuratJalanTerakhir'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(ListColor.colorBlack),
            height: 1.2,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterTMNamaPerusahaan'.tr + "*",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => Container(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(Get.context) * 12,
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: GlobalVariable.ratioWidth(Get.context) * 1,
                color: Color(controller.isTransporterCompanyValid.value ? ListColor.colorLightGrey10 : ListColor.colorRed)
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            height: GlobalVariable.ratioWidth(Get.context) * 42,
            child: CustomTextFormField(
              context: Get.context,
              autofocus: false,
              controller: controller.transporterCompany,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
              onChanged: (value) {
                controller.checkCompanyName(value, useToast: false);
              },
              onFieldSubmitted: (value) {
                FocusManager.instance.primaryFocus.unfocus();
                controller.checkCompanyName(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(255)
              ],
              newInputDecoration: InputDecoration(
                hintText: "BFTMRegisterTMMasukkanNamaPerusahaan".tr,
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
              ),
            ),
          )),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterTMKontakPerusahaan'.tr + "*",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => Container(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(Get.context) * 12,
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: GlobalVariable.ratioWidth(Get.context) * 1,
                color: Color(controller.isTransporterPICNameValid.value ? ListColor.colorLightGrey10 : ListColor.colorRed)
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            height: GlobalVariable.ratioWidth(Get.context) * 42,
            child: CustomTextFormField(
              controller: controller.transporterPICName,
              context: Get.context,
              autofocus: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
              onChanged: (value) {
                controller.checkContactName(value, useToast: false);
              },
              onFieldSubmitted: (value) {
                FocusManager.instance.primaryFocus.unfocus();
                controller.checkContactName(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(255)
              ],
              newInputDecoration: InputDecoration(
                hintText: "BFTMRegisterTMMasukkanKontakPerusahaan".tr,
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
              ),
            ),
          )),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterTMNoHpPerusahaan'.tr + "*",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => Container(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(Get.context) * 12,
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: GlobalVariable.ratioWidth(Get.context) * 1,
                color: Color(controller.isTransporterPICPhoneValid.value ? ListColor.colorLightGrey10 : ListColor.colorRed)
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            height: GlobalVariable.ratioWidth(Get.context) * 42,
            child: CustomTextFormField(
              controller: controller.transporterPICPhone,
              context: Get.context,
              autofocus: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
              onChanged: (value) {
                controller.checkPhone(value, useToast: false);
              },
              onFieldSubmitted: (value) {
                FocusManager.instance.primaryFocus.unfocus();
                controller.checkPhone(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(14),
              ],
              keyboardType: TextInputType.number,
              newInputDecoration: InputDecoration(
                hintText: "BFTMRegisterTMMasukkanNoHpPerusahaan".tr,
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
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _secondPage(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: controller.scrollControllerSecondPage,
            child: Form(
              key: controller.formKey.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _headerSecondPage(),
                  _formLogoPerusahaan(),
                  _formNamaPerusahaan(),
                  _formBadanUsaha(),
                  _formCariBidangUsaha(),
                  _lokasiPeruashaan(),
                  controller.alamatlokasiakhir.value == " " ? 
                  _formCariAlamat() : 
                  _formAdaAlamat(),
                  _formAlamatPerusahaan(),
                  _formKecamatan(),
                  _formKodePos(),
                  _pilihPin(),
                  // _peta(),
                  _formNoTelepon(),
                  _beginKontak(),
                  _formNamaPIC1(),
                  _formNoHpPIC1(),
                  _formNamaPIC2(),
                  _formNoHpPIC2(),
                  _formNamaPIC3(),
                  _formNoHpPIC3(),
                  _beginEmail(),
                  _formEmailBF(),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24)
                ],
              ),
            ),
          )
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
                  controller.back();
                }
              ),
              _button(
               width: 160,
                height: 32,
                marginLeft: 4,
                marginTop: 16,
                marginRight: 16,
                marginBottom: 16,
                borderSize: 1,
                borderRadius: 18,
                text: "Selanjutnya",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                 color: controller.isFilled.value || controller.cross.value ? Colors.white : Color(ListColor.colorLightGrey4),
                backgroundColor: controller.isFilled.value || controller.cross.value ? Color(ListColor.colorBlue) : Color(ListColor.colorLightGrey2),
                onTap: () async {
                  print('masuk');
                  controller.cross.value ? controller.checkFieldIsValidCross() : controller.isFilled.value ? controller.checkFieldIsValid() : null;
                }
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _thirdPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: controller.scrollControllerThirdPage,
            child: Form(
              key: controller.formKey.value,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // _header(),
                  if(controller.tipeBadanUsaha.value == TipeBadanUsaha.PT_CV)...[
                    _formAkta1(),
                    _formAkta2(),
                    _formAkta3(),
                  ],
                  _formKtpDirektur(),
                  if(controller.tipeBadanUsaha.value == TipeBadanUsaha.PT_CV)...[
                    _formAkta4(),
                  ],
                  _formNib(),
                  if(controller.tipeBadanUsaha.value == TipeBadanUsaha.PT_CV)...[
                    _formSertifikatStandar(),
                  ],
                  _formNpwpPerusahaan(),
                  _formKtp(),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24)                          
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
                  controller.back();
                }
              ),
              Obx(() => 
                _button(
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
                  color: !controller.isFilledThirdPage.value ? Color(ListColor.colorLightGrey4) : Colors.white,
                  backgroundColor: !controller.isFilledThirdPage.value ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorBlue),
                  onTap: () async {
                    if(controller.isFilledThirdPage.value) {
                      bool isValidAll = true;

                      if(controller.ktpDirekturController.text.length < 16) {
                        isValidAll = false;
                        controller.isValidKtpDirektur.value = false;
                        CustomToastTop.show(
                          context: Get.context, 
                          message: controller.tipeBadanUsaha.value == TipeBadanUsaha.PT_CV ? "No. KTP Direktur minimal 16 digit!" : "No. KTP Pengurus minimal 16 digit!",
                          isSuccess: 0
                        );                                        
                        return;
                      }

                      if(controller.npwpPerusahaanController.text.length < 15) {
                        isValidAll = false;
                        controller.isValidNpwpPerusahaan.value = false;
                        CustomToastTop.show(
                          context: Get.context, 
                          message: "No. NPWP minimal 15 digit!",
                          isSuccess: 0
                        );
                        return;
                      }

                      if(controller.ktpController.text.length < 16) {
                        isValidAll = false;
                        controller.isValidKtp.value = false;
                        CustomToastTop.show(
                          context: Get.context, 
                          message: "No. KTP Pendaftar minimal 16 digit!",
                          isSuccess: 0
                        );
                        return;
                      }

                      if(isValidAll){
                        controller.submit();
                      }
                    }
                  }
                ),
              ),
            ],
          ),
        )
      ],
    );
  }



  // ################################
  // ##  START WIDGET SECOND PAGE  ##
  // ################################
  Widget _headerSecondPage() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterCompanyInformation'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
        ],
      ),
    );
  }

  Widget _formEmailBF() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15.5),
          CustomText(
            'Email*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 6),
           CustomText( 
            "BFTMRegisterHoldEmail".tr,
            fontWeight: FontWeight.w500,
            height: GlobalVariable.ratioWidth(Get.context) * 1,
            fontSize: 12,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => AbsorbPointer(
              absorbing: controller.isverif.value == "1" ? true : false,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 13,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                decoration: BoxDecoration(
                  color: controller.isverif.value == "1" ? Color(0xFFCECECE) : Colors.white,
                  border: Border.all(
                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                      color: Color(controller.isEmailValid.value == true
                          ? ListColor.colorLightGrey10
                          : ListColor.colorRed)),
                  borderRadius: BorderRadius.circular(6),
                ),
                height: GlobalVariable.ratioWidth(Get.context) * 40,
                child: CustomTextFormField(
                  context: Get.context,
                  autofocus: false,
                  controller: controller.emailCtrl.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(
                      ListColor.colorBlack,
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      controller.email.value = value;
                      controller.checkEmailField(value);
                      // controller.isFilled.value = true;
                      // log('alamat: ' + '${controller.alamatValue.value}');
                    } else {
                      controller.email.value = value;
                      controller.checkEmailField(value);
                    }
                    FocusManager.instance.primaryFocus.unfocus();
                    controller.checkAllFieldIsFilled();
                  },
                  onChanged: (value) {
                    controller.isEmailValid.value = true;
                    if (controller.email.value != value) {
                      controller.email.value = value;
                    }
                    controller.checkAllFieldIsFilled();
                  },
                  newInputDecoration: InputDecoration(
                    hintText: "BFTMRegisterEntEmail".tr,
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
                    // contentPadding: EdgeInsets.only(
                    //   top: GlobalVariable.ratioWidth(Get.context) * 1,
                    // ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

   Widget _formCariBidangUsaha() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          child: CustomText(
            'BFTMRegisterCompanyField'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => 
            InkWell(
              onTap: () async {
                final result = await GetToPage.toNamed<ChooseBusinessFieldController>(Routes.CHOOSE_BUSINESS_FIELD);
                if (result != null) {
                  controller.businessFieldController.value.text = result['name'].toString();
                  controller.bidangterpilih.value = result['name'].toString();
                  controller.pilihBadanUsaha.value = result['id'].toString();
                }
                log(controller.pilihBadanUsaha.value);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 0,
                ),
                height: GlobalVariable.ratioWidth(Get.context) * 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(ListColor.colorLightGrey10)
                  ),
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)
                ),
                padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 8,
                  GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      child: SvgPicture.asset(
                        "assets/ic_search.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: controller.bidangterpilih.value == "" ? Color(ListColor.colorLightGrey2) : Colors.black,
                      ),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        context: Get.context,
                        autofocus: false,
                        enabled: false,
                        onChanged: (value) {

                        },
                        controller: controller.businessFieldController.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.2,
                        ),
                        textSize: 14,
                        newInputDecoration: InputDecoration(
                          hintText: 'BFTMRegisterSearchField'.tr,
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
                )                   
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _formLogoPerusahaan() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'BFTMRegisterCompanyLogo'.tr,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 13.5),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 48.5
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // controller.file.value != File("") ?
                controller.urlphoto.value != "" ?
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 73,
                  width: GlobalVariable.ratioWidth(Get.context) * 73,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 900),
                        child: Image.network(
                          controller.urlphoto.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ):
                controller.picturefilllogo.value == false ? 
                Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 73,
                  width: GlobalVariable.ratioWidth(Get.context) * 73,
                  child: Image.asset('assets/camera-grey.png')
                  ) : 
                Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 73,
                  width: GlobalVariable.ratioWidth(Get.context) * 73,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorLightGrey2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Color(ListColor.colorLightGrey10),
                    ),
                  ),
                  child: Obx(() => 
                  controller.picturefilllogo.value == false ? 
                    SvgPicture.asset(
                      'assets/camera_logo.svg',
                      fit: BoxFit.cover,
                    ) : 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 900),
                      child: Image.file(
                        controller.filelogo.value,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: _button(
                    width:  119,
                    height:  30,
                    marginTop: 10,
                    marginRight: 25,
                    marginLeft: 25,
                    marginBottom: 7.5,
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
                        SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 6),
                        Container(
                          width: GlobalVariable.ratioWidth(Get.context) * 60,
                          height: GlobalVariable.ratioWidth(Get.context) * 16,
                          child: Center(
                            child: CustomText(
                              "Upload",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async{
                    // log(controller.file.value.path);
                var result = await GetToPage.toNamed<UploadPictureController>(Routes.UPLOAD_PICTURE);
                print(result);
                if (result == null) {
                  log('stone free');
                  controller.checkAllFieldIsFilled();
                }
                    }
                  ),
                ),          
                Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 169,
                  child: CustomText(
                    "Format file jpg/png max.5MB",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formNamaPerusahaan() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterName'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => 
            Container(
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 13,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNamaPerusahaanValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.colorBlack),
                ),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.namaPerusahaanValue.value = value;
                    controller.checkNameUsahaField(value);
                  } else {
                    controller.namaPerusahaanValue.value = value;
                    controller.checkNameUsahaField(value);
                  }
                  FocusManager.instance.primaryFocus.unfocus();
                  controller.checkAllFieldIsFilled();
                },
                onChanged: (value) {
                  controller.isNamaPerusahaanValid.value = true;
                  if (controller.namaPerusahaanValue.value != value) {
                    controller.namaPerusahaanValue.value = value;
                  }
                  controller.checkAllFieldIsFilled();
                },
                controller: controller.namaPerusahaanC,
                newInputDecoration: InputDecoration(
                  hintText: 'BFTMRegisterEnterName'.tr,
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formBadanUsaha() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterCompanyType'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            DropdownOverlay(
              // bgColor: Colors.red, 
            // value: controller.pilihKodePos.value != null
            //               ? controller.pilihKodePos.value.toString()
            //               : null,
            dataList: 
controller.bidangUsahaList == []
                          ? null
                          : controller.bidangUsahaList,
            contentPadding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(Get.context) * 6,
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            ),
            itemBuilder: (ctx, data) {
              return GestureDetector(
                onTap: () {
                  log(data['Description'] as String);
                  int id = data['ID'];
                  controller.badan.value = data['Description'] as String;
                   controller.pilihBidangUsaha.value = id.toString();
                  controller.checkBidangUsahaField(id.toString());
                  FocusManager.instance.primaryFocus.unfocus();
                  controller.checkAllFieldIsFilled();
              // controller.pilihBidangUsaha.value = data;
              // controller.badan.value = data['Desciption'].toString();
              //         // log('KODEPOS : ${controller.pilihKodePos.value}');
              //       FocusManager.instance.primaryFocus.unfocus();
              //       // controller.pilihKodePosValue.value = null;
              //       controller.checkAllFieldIsFilled();
                  // log(data['ID']);
                  // log( controller.pilihKodePos.value);
                    //   controller.pilihBidangUsaha.value = data['ID'];
                    //   print(controller.pilihBidangUsaha.value + 'ikura');
                    //       // log('KODEPOS : ${controller.pilihKodePos.value}');
                    // controller.checkBidangUsahaField(data['ID']);
                    // FocusManager.instance.primaryFocus.unfocus();
                    // controller.checkAllFieldIsFilled();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 6,
                  ),
                  child: CustomText(data['Description'].toString(),
                    color: Color(ListColor.colorLightGrey4),
                    withoutExtraPadding: true,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
            borderWidth: GlobalVariable.ratioWidth(Get.context) * 1,
            radius: GlobalVariable.ratioWidth(Get.context) * 6,
            borderColor: FocusScope.of(Get.context).hasFocus ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
            builder: (ctx, data, isOpen, hasFocus) {
              return Container(
                height: GlobalVariable.ratioWidth(Get.context) *  40,
                child: Material(
                  color: Color(ListColor.colorWhite),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                    side: BorderSide(
                      color: hasFocus ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    child: Row(
                      children: [
                        Expanded( 
                          child: CustomText(controller.badan.value != "" ? controller.badan.value 
                            : 'BFTMRegisterEnterType'.tr, color: hasFocus ? Color(0xFF676767) : controller.badan.value != "" ? Color(0xFF676767) : Color(0xFFCECECE)),
                        ),
                        SvgPicture.asset(isOpen ? GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_up.svg' : GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_down.svg',
                          width: GlobalVariable.ratioWidth(Get.context) * 16,
                          height: GlobalVariable.ratioWidth(Get.context) * 16,
                          color: Color(0xFF868686),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
    )
              
              ],
            ),
          ),
  
          // Obx(() => 
          //   Container(
          //     height: GlobalVariable.ratioHeight(Get.context) * 40,
          //     child: DropdownBelow(
          //       itemWidth: MediaQuery.of(Get.context).size.width - GlobalVariable.ratioWidth(Get.context) * 32,
          //       itemTextstyle: TextStyle(
          //         color: Color(ListColor.colorLightGrey4),
          //         fontWeight: FontWeight.w500,
          //         fontSize: GlobalVariable.ratioFontSize(Get.context) * 14
          //       ),
          //       boxTextstyle: TextStyle(
          //         color: Color(ListColor.colorLightGrey2),
          //         fontWeight: FontWeight.w600,
          //         fontSize: GlobalVariable.ratioFontSize(Get.context) * 14
          //       ),
          //       boxWidth: MediaQuery.of(Get.context).size.width,
          //       boxHeight: GlobalVariable.ratioWidth(Get.context) * 40,
          //       boxPadding: EdgeInsets.only(
          //         left: GlobalVariable.ratioWidth(Get.context) * 12,
          //         right: GlobalVariable.ratioWidth(Get.context) * 12
          //       ),
          //       boxDecoration: BoxDecoration(
          //         color: Color(ListColor.colorWhite),
          //         borderRadius: BorderRadius.circular(6),
          //         border: Border.all(
          //           width: GlobalVariable.ratioWidth(Get.context) * 1,
          //           color: Color(controller.isBidangUsahaValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed),
          //         ),
          //       ),
          //       icon: Icon(
          //         Icons.keyboard_arrow_down,
          //         size: GlobalVariable.ratioWidth(Get.context) * 18.5, //16
          //         color: Color(controller.pilihBidangUsaha.value != null ? ListColor.colorBlack : ListColor.colorLightGrey2),
          //       ),
          //       hint: CustomText("Pilih Badan Usaha",
          //         fontWeight: FontWeight.w500,
          //         fontSize: 14,
          //         color: Color(ListColor.colorLightGrey2)
          //       ),
          //       value: controller.pilihBidangUsaha.value,
          //       items: controller.bidangUsahaList == []
          //           ? null
          //           : controller.bidangUsahaList.map((data) {
          //               return DropdownMenuItem(
          //                 child: CustomText(data['Description'].toString(),
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 14,
          //                   color: Color(ListColor.colorBlack)
          //                 ),
          //                 value: data['ID'].toString(),
          //               );
          //             }).toList(),
          //       onChanged: (value) {
          //         controller.isBidangUsahaValid.value = true;
          //         if (value.isNotEmpty) {
          //           controller.pilihBidangUsaha.value = value;
          //           print(controller.pilihBidangUsaha.value + 'ikura');
          //         }
          //         controller.checkBidangUsahaField(value);
          //         FocusManager.instance.primaryFocus.unfocus();
          //         controller.checkAllFieldIsFilled();
          //       },
          //     ),
          //   ),
          // ),
        
        ],
      ),
    );
  }

  Widget _formBidangUsaha() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterCompanyField'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => 
            Container(
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              child: DropdownBelow(
                itemWidth: MediaQuery.of(Get.context).size.width - GlobalVariable.ratioWidth(Get.context) * 32,
                itemTextstyle: TextStyle(
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14
                ),
                boxTextstyle: TextStyle(
                  color: Color(ListColor.colorLightGrey2),
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14
                ),
                boxPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 12,
                  right: GlobalVariable.ratioWidth(Get.context) * 12
                ),
                boxWidth: MediaQuery.of(Get.context).size.width,
                boxHeight: GlobalVariable.ratioWidth(Get.context) * 40,
                boxDecoration: BoxDecoration(
                  color: Color(ListColor.colorWhite),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isBidangUsahaValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed),
                  )
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: GlobalVariable.ratioWidth(Get.context) * 16,
                  color: Color(controller.pilihBidangUsaha.value != null ? ListColor.colorBlack : ListColor.colorLightGrey2),
                ),
                hint: CustomText("Pilih Bidang Usaha",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(ListColor.colorLightGrey2)
                ),
                value: controller.pilihBidangUsaha.value != null ? controller.pilihBidangUsaha.value : null,
                items: controller.bidangUsahaList == []
                    ? []
                    : controller.bidangUsahaList.map((data) {
                        return DropdownMenuItem(
                          child: CustomText(data['Description'].toString(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(ListColor.colorBlack)),
                          value: data['ID'].toString(),
                        );
                      }).toList(),
                onChanged: (value) async {
                  controller.isBidangUsahaValid.value = true;
                  if (value.isNotEmpty) {
                    controller.pilihBadanUsaha.value = value;
                    log(controller.pilihBadanUsaha.value);
                  }
                  FocusManager.instance.primaryFocus.unfocus();
                  await controller.checkBidangUsahaField(value);
                  controller.checkAllFieldIsFilled();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _lokasiPeruashaan() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18.5),
          Divider(thickness: 0.5, color: Color(ListColor.colorLightGrey10)),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18.5),
          CustomText(
            'BFTMRegisterLocation'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
        ],
      ),
    );
  }

  Widget _formAlamatPerusahaan() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterDetailComp'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => 
            Container(
              padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 8,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 102,
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isAlamaPerusahaanValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                ),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                maxLines: 4,
                context: Get.context,
                autofocus: false,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.alamatPerusahaanValue.value = value;
                    controller.checkAlamatField(value);
                  } else {
                    controller.alamatPerusahaanValue.value = value;
                    controller.checkAlamatField(value);
                  }
                  controller.checkAllFieldIsFilled();
                  FocusManager.instance.primaryFocus.unfocus();
                },
                onChanged: (value) {
                  controller.isAlamaPerusahaanValid.value = true;
                  if (controller.alamatPerusahaanValue.value != value) {
                    controller.alamatPerusahaanValue.value = value;
                    log(controller.alamatPerusahaanValue.value);
                  }
                  controller.checkAllFieldIsFilled();
                },
                controller: controller.alamatPerusahaanC,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textSize: 14,
                newInputDecoration: InputDecoration(
                  hintText: 'BFTMRegisterEnterComp'.tr,
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
          ),
        ],
      ),
    );
  }

  Widget _formAdaAlamat() {
    return GestureDetector(
      onTap: (){controller.onClickAddresss("lokasi");},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
            child: CustomText(
              'BFTMRegisterAddressComp'.tr,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child: Container(
              height:  GlobalVariable.ratioWidth(Get.context) * 58,
              width: GlobalVariable.ratioWidth(Get.context) * 328,
              decoration: BoxDecoration(
                color: Color(ListColor.colorWhite),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Color(ListColor.colorLightGrey10), width: GlobalVariable.ratioWidth(Get.context) * 1)
              ),
              child: Padding(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
                      child: Image.asset(
                        'assets/location_bf.png', 
                        height: GlobalVariable.ratioWidth(Get.context) * 16, 
                        width: GlobalVariable.ratioWidth(Get.context) * 16
                      ),
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
                          //   child: CustomText(controller.namalokasiakhir.value, fontSize: 14, fontWeight: FontWeight.w600, color: Color(ListColor.colorBlack),),
                          // ),
                          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12,),
                          CustomText(
                            controller.lokasiakhir.value, 
                            fontSize: 14, 
                            fontWeight: FontWeight.w500, 
                            color: Color(ListColor.colorBlack), 
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formCariAlamat() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'BFTMRegisterAddressComp'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          InkWell(
            onTap: () async {
              controller.onClickAddresss("lokasi");
            },
            child: Obx(() => 
              Container(
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                ),                
                decoration: BoxDecoration(
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isKecamatanValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                  ),
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => 
                      SvgPicture.asset(
                        "assets/location_marker.svg",
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(controller.kecamatanPerusahaanText.value == "" ? ListColor.colorLightGrey2 : ListColor.colorBlack),
                      ),
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 10),
                    Obx(() => 
                      Expanded(
                        child: CustomText(
                          controller.kecamatanPerusahaanText.value == "" ? 'BFTMRegisterSearchComp'.tr : controller.kecamatanPerusahaanText.value,
                          color: controller.kecamatanPerusahaanText.value == "" ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formKecamatan() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
            child: CustomText(
              'BFTMRegisterDistrik'.tr,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => InkWell(
            onTap: () async {
              final result = await GetToPage.toNamed<ChooseDistrictController>(Routes.CHOOSE_DISTRICT, arguments: controller.placeidd.value);
              if (result != null) {
                log(result.toString() + 'xsr');
                controller.districtController.value.text = result['name'];
                controller.kecamatanPerusahaanText.value = result['name'];
                controller.companydistrictid.value = result['id'].toString();
                log(controller.companydistrictid.value + 'xsr');
                controller.checkAllFieldIsFilled();
                await controller.getIdUsaha(result['id']);
                print(controller.postalCodeList.toString() + 'xsr');
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 16, //padding not fix
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10)
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)
              ),
              padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 8,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    child: SvgPicture.asset(
                      "assets/ic_search.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                      color: Color(ListColor.colorLightGrey2),
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      enabled: false,
                      onChanged: (value) {
                        
                      },
                      controller: controller.districtController.value,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      newInputDecoration: InputDecoration(
                        hintText: 'BFTMRegisterCariDistrik'.tr,
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
              )                     
            ),
          ))
        ],
      ),
    );
  }

  Widget _beginKontak() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
          Divider(thickness: 0.5, color: Color(ListColor.colorLightGrey10)),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
          CustomText(
            //improve 1.3
            'BFTMRegisterPICCont'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 6),
          CustomText(
            //improve 1.3
            // 'BFTMRegisterDetailPanjang'.tr,
            'Masukkan kontak PIC perusahaan Anda untuk dapat dihubungi oleh transporter. (Pastikan kontak telah terhubung dengan Whatsapp)',
            fontWeight: FontWeight.w500,
            height: GlobalVariable.ratioWidth(Get.context) * 1,
            fontSize: 12,
            color: Color(ListColor.colorLightGrey4),
          ),
        ],
      ),
    );
  }

  Widget _beginEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18.5),
          Divider(thickness: 0.5, color: Color(ListColor.colorLightGrey10)),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18.5),
          CustomText(
            "BFTMRegisterAHolder".tr,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  Widget _peta(){
    return  Stack(
      children: [
        Obx(() => 
          FlutterMap(
            options: MapOptions(
              center: GlobalVariable.centerMap,
              interactiveFlags: InteractiveFlag.none,
              zoom: 13.0,
            ),
            mapController: controller.mapLokasiController,
            layers: [
              GlobalVariable.tileLayerOptions,
              MarkerLayerOptions(markers: [])
            ],
          )
        ),
        Positioned.fill(
          child: Container(
            color: Color(ListColor.colorLightGrey),
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );                
  }

   Widget _formKodePos() {
      return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Kode Pos Perusahaan*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
      AbsorbPointer(
        absorbing: controller.kecamatanPerusahaanText.value != null ? false : true,
        child: DropdownOverlay(
          // bgColor: Colors.red, 
        // value: controller.pilihKodePos.value != null
        //               ? controller.pilihKodePos.value.toString()
        //               : null,
        dataList: 
controller.postalCodeList == []
                      ? []
                      : controller.postalCodeList,
        contentPadding: EdgeInsets.symmetric(
          vertical: GlobalVariable.ratioWidth(Get.context) * 6,
          horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
        ),
        itemBuilder: (ctx, data) {
          return GestureDetector(
            onTap: () {
              // log(data.toString());
              // log( controller.pilihKodePos.value);
              controller.pilihKodePos.value = data.toString();
              controller.kodepos.value = data['PostalCode'].toString();
                      // log('KODEPOS : ${controller.pilihKodePos.value}');
                    FocusManager.instance.primaryFocus.unfocus();
                    // controller.pilihKodePosValue.value = null;
                    controller.checkAllFieldIsFilled();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 6,
              ),
              child: CustomText(data['PostalCode'].toString(),
                color: Color(ListColor.colorLightGrey4),
                withoutExtraPadding: true,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        borderWidth: GlobalVariable.ratioWidth(Get.context) * 1,
        radius: GlobalVariable.ratioWidth(Get.context) * 6,
        borderColor: FocusScope.of(Get.context).hasFocus ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
        builder: (ctx, data, isOpen, hasFocus) {
          return Container(
            height: GlobalVariable.ratioWidth(Get.context) *  40,
            child: Material(
              color: controller.pilihKodePos.value != null ? Color(ListColor.colorWhite) : controller.districtController.value.text == ""
                            ? Color(0xFFCECECE)
                            : Color(ListColor.colorWhite),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                side: BorderSide(
                  color: hasFocus ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                child: Row(
                  children: [
                    Expanded( 
                      child: CustomText(controller.pilihKodePos.value != null ? controller.kodepos.value : controller.districtController.value.text == ""
                            ? 'BFTMRegisterChooseDistrik'.tr
                            : 'RegisterSellerPerusahaanIndexLabelFieldKodePos2'.tr, color: hasFocus ? Color(0xFF676767) : controller.pilihKodePos.value != null ? Color(0xFF676767) : controller.districtController.value.text == "" ? Color(0xFF676767) : Color(0xFFCECECE)),
                    ),
                    SvgPicture.asset(isOpen ? GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_up.svg' : GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_down.svg',
                      width: GlobalVariable.ratioWidth(Get.context) * 16,
                      height: GlobalVariable.ratioWidth(Get.context) * 16,
                      color: Color(0xFF868686),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
    ),
      )
        
        ],
      ),
    );
  
    // return Container(
    //   padding: EdgeInsets.symmetric(
    //     horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
    //       CustomText(
    //         'Kode Pos Perusahaan*',
    //         fontWeight: FontWeight.w600,
    //         fontSize: 14,
    //         color: Color(ListColor.colorLightGrey4),
    //       ),
    //       SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
    //       Obx(() => 
    //         IgnorePointer(
    //           ignoring:  true ,
    //           child: Container(
    //             height: GlobalVariable.ratioWidth(Get.context) * 40,
    //             child: DropdownBelow(
    //               itemWidth: MediaQuery.of(Get.context).size.width - GlobalVariable.ratioWidth(Get.context) * 32,
    //               itemTextstyle: TextStyle(
    //                 color: Color(ListColor.colorBlack),
    //                 fontWeight: FontWeight.w500,
    //                 fontSize: GlobalVariable.ratioFontSize(Get.context) * 14
    //               ),
    //               boxTextstyle: TextStyle(
    //                 color: Color(ListColor.colorLightGrey2),
    //                 fontWeight: FontWeight.w600,
    //                 fontSize: GlobalVariable.ratioFontSize(Get.context) * 14
    //               ),
    //               boxPadding: EdgeInsets.only(
    //                 left: GlobalVariable.ratioWidth(Get.context) * 12,
    //                 right: GlobalVariable.ratioWidth(Get.context) * 12
    //               ),
    //               boxWidth: MediaQuery.of(Get.context).size.width,
    //               boxHeight: GlobalVariable.ratioWidth(Get.context) * 40,
    //               boxDecoration: BoxDecoration(
    //                 color: Color(ListColor.colorLightGrey2),
    //                 borderRadius: BorderRadius.circular(8),
    //                 border: Border.all(
    //                   width: GlobalVariable.ratioWidth(Get.context) * 1,
    //                   color: Color(controller.isKodePosValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
    //                 ),
    //               ),
    //               icon: Icon(
    //                 Icons.keyboard_arrow_down,
    //                 size: GlobalVariable.ratioWidth(Get.context) * 16,
    //                 color: Color(ListColor.colorGrey3),
    //               ),
    //               hint: CustomText(
    //                 "Pilih Kecamatan Dahulu",
    //                 fontWeight: FontWeight.w500,
    //                 fontSize: 14,
    //                 color: Color(ListColor.colorLightGrey4)
    //               ),
    //               value: null,                  
    //               items: controller.postalCodeList == []
    //                   ? []
    //                   : controller.postalCodeList.map((data) {
    //                       return DropdownMenuItem(
    //                         child: CustomText(
    //                           data['PostalCode'].toString(),
    //                           fontWeight: FontWeight.w500,
    //                           fontSize: 14,
    //                           color: Color(ListColor.colorBlack)
    //                         ),
    //                         value: data['ID'].toString(),
    //                       );
    //                     }).toList(),
    //               onChanged: (value) {
    //                 if (value.isNotEmpty) {
                      
    //                 }
    //                 FocusManager.instance.primaryFocus.unfocus();
    //                 controller.checkAllFieldIsFilled();
    //               },
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  
  }

  Widget _pilihPin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 16,left: GlobalVariable.ratioWidth(Get.context) * 16),
          child: CustomText(
            'BFTMRegisterLocPoint'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 12, 
            horizontal:  GlobalVariable.ratioWidth(Get.context) * 16
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
            child: Stack(children: [
              Container(
                height: GlobalVariable.ratioWidth(Get.context) * 163,
                child: Column(
                  mainAxisSize: MainAxisSize.max, 
                  children: [
                    Expanded(
                      child: Obx(() => 
                        Stack(
                          children: [
                            Obx(() => 
                              FlutterMap(
                                options: MapOptions(
                                  center: GlobalVariable.centerMap,
                                  interactiveFlags: InteractiveFlag.none,
                                  zoom: 13.0,
                                ),
                                mapController:controller.mapLokasiController,
                                layers: [
                                  GlobalVariable.tileLayerOptions,
                                  MarkerLayerOptions(markers: [
                                    for (var index = 0; index < controller.latlngLokasi.keys.length; index++)
                                      Marker(
                                        width: 30.0,
                                        height: 30.0,
                                        point: controller.latlngLokasi.values.toList()[index],
                                        builder: (ctx) => Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Image.asset(
                                              'assets/pin_new.png',
                                              width: GlobalVariable.ratioWidth(Get.context) * 29.56,
                                              height: GlobalVariable.ratioWidth(Get.context) * 36.76,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: GlobalVariable.ratioWidth(Get.context) * 5
                                              ),
                                              child: CustomText(
                                                controller.totalLokasi.value == "1" ? "" : (int.parse(controller.latlngLokasi.keys.toList()[index]) +1).toString(),
                                                color: index == 0 ? Color(ListColor.color4) : Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 8
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                  ])
                                ],
                              )),
                            !controller.loadMapLokasi.value
                                ? SizedBox.shrink()
                                : Positioned.fill(
                                    child: Container(
                                      color: Color(ListColor.colorLightGrey),
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 38,
                      width: MediaQuery.of(Get.context).size.width,
                      color: Color(ListColor.color4),
                      child: Center(
                        child: CustomText(
                          'BFTMRegisterSetLocPoint'.tr,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5, //12
                        ),
                      ),
                    )
                  ]
                ),
              ),
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    //map
                    controller.onClickAddressMap("lokasi");
                    // controller.onClickAddressnew("lokasi");
                  },
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _formNoTelepon() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'BFTMRegisterCompTelp'.tr + "*",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(() => 
            Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 0
              ),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNoPic1Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                controller: controller.noTelp,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.colorBlack),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14)
                ],
                onFieldSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    controller.noTelpPerusahaan.value = value;
                    await controller.checkNoTelpField(value);
                  } else {
                    controller.noTelpPerusahaan.value = value;
                    await controller.checkNoTelpField(value);
                  }
                  FocusManager.instance.primaryFocus.unfocus();
                  await controller.checkAllFieldIsFilled();
                },
                onChanged: (value) async {
                  controller.isNoTelpValid.value = true;
                  controller.noTelpPerusahaan.value = value;
                  await controller.checkAllFieldIsFilled();
                  // controller.isNoTelpValid.value = true;

                  // if (value != controller.naoPic1Value.value) {
                  //   controller.noTelpPerusahaan.value = value;
                  // }
                  // await controller.checkAllFieldIsFilled();
                },
                newInputDecoration: InputDecoration(
                  hintText: "No. Telepon Perusahaan",
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
          )
        ],
      ),
    );
  }

  Widget _formNamaPIC1() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterPIC1Name'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => 
            Container(
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNamaPic1Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorBlack),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.' ]")),
                        LengthLimitingTextInputFormatter(255)
                      ],
                      controller: controller.namaPIC1,
                      onFieldSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          controller.namaPic1Value.value = value;
                          await controller.checkNamle1Field(value);
                        } else {
                          controller.namaPic1Value.value = value;
                          await controller.checkNamle1Field(value);
                        }
                        FocusManager.instance.primaryFocus.unfocus();
                        await controller.checkAllFieldIsFilled();
                      },
                      onChanged: (value) async {
                        controller.isNamaPic1Valid.value = true;
                        if (controller.namaPic1Value.value != value) {
                          controller.namaPic1Value.value = value;
                        }
                        await controller.checkAllFieldIsFilled();
                      },
                      newInputDecoration: InputDecoration(
                        hintText: "BFTMRegisterPIC1Ent".tr,
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
                  InkWell(
                    onTap: () async {
                      await controller.pickContact1();
                      await controller.checkAllFieldIsFilled();
                    },
                    child: Obx(() => 
                      SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(controller.namaPic1Value.value == "" ? ListColor.colorLightGrey2 : ListColor.colorBlue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formNoHpPIC1() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'BFTMRegisterPIC1Number'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(() => 
            Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 0
              ),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNoPic1Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                ),
                borderRadius: BorderRadius.circular( GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                controller: controller.noHpPIC1,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.colorBlack),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14)
                ],
                onFieldSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    controller.naoPic1Value.value = value;
                    await controller.checkNoHP1Field(value);
                  } else {
                    controller.naoPic1Value.value = value;
                    await controller.checkNoHP1Field(value);
                  }
                  FocusManager.instance.primaryFocus.unfocus();
                  await controller.checkAllFieldIsFilled();
                },
                onChanged: (value) async {
                  controller.isNoPic1Valid.value = true;

                  if (value != controller.naoPic1Value.value) {
                    controller.naoPic1Value.value = value;
                  }
                  await controller.checkAllFieldIsFilled();
                },
                newInputDecoration: InputDecoration(
                  //improve 1.3
                  hintText: 
                  // 'BFTMRegisterPIC1EntN'.tr,
                  'Contoh : 0821xxxxxxxx',
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
          )
        ],
      ),
    );
  }

  Widget _formNamaPIC2() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            ('BFTMRegisterPIC2Name'.tr).replaceAll("*", ""),
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => 
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNamaPic2Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorBlack),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.' ]")),
                        LengthLimitingTextInputFormatter(255)
                      ],
                      onFieldSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          if (value.length > 1) {
                            controller.namaPic2Value.value = value;
                            await controller.checkNamle2Field(value);
                            await controller.checkAllFieldIsFilled();
                          } else {
                            controller.namaPic2Value.value = value;
                            await controller.checkNamle2Field(value);
                            await controller.checkAllFieldIsFilled();
                          }
                        }

                        FocusManager.instance.primaryFocus.unfocus();
                      },
                      controller: controller.namaPIC2,
                      onChanged: (value) async {
                        controller.isOptionalFilled.value = true;
                        controller.isNamaPic2Valid.value = true;
                        controller.isNoPic2Valid.value = true;
                        controller.namaPic2Value.value = value;
                        await controller.checkAllFieldIsFilled();
                      },
                      newInputDecoration: InputDecoration(
                        hintText: "BFTMRegisterPIC2Ent".tr,
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
                  InkWell(
                    onTap: () async {
                      await controller.pickContact2();
                      await controller
                          .checkNamle2Field(controller.namaPic2Value.value);
                    },
                    child: Obx(() => 
                      SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(controller.namaPic2Value.value == "" ? ListColor.colorLightGrey2 : ListColor.colorBlue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formNoHpPIC2() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            ('BFTMRegisterPIC2Number'.tr).replaceAll("*", ""),
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => 
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNoPic2Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                controller: controller.noHpPIC2,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.colorBlack),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14)
                ],
                onFieldSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    controller.naoPic2Value.value = value;
                    await controller.checkNoHP2Field(value);
                    controller.checkAllFieldIsFilled();
                  } else {
                    controller.naoPic2Value.value = value;
                    await controller.checkNoHP2Field(value);
                    await controller.checkAllFieldIsFilled();
                  }
                  FocusManager.instance.primaryFocus.unfocus();
                },
                onChanged: (value) async {
                  controller.isNamaPic2Valid.value = true;
                  controller.isNoPic2Valid.value = true;
                  await controller.checkAllFieldIsFilled();
                  if (value != controller.naoPic2Value.value) {
                    controller.naoPic2Value.value = value;
                    return;
                  }  
                },
                newInputDecoration: InputDecoration(
                  //improve 1.3
                  hintText: 
                  // 'BFTMRegisterPIC2EntN'.tr,
                  'Contoh : 0821xxxxxxxx',
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
          )
        ],
      ),
    );
  }

  Widget _formNamaPIC3() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            ('BFTMRegisterPIC3Name'.tr).replaceAll("*", ""),
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(() => 
            Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16
              ),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNamaPic3Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorBlack),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.' ]")),
                        LengthLimitingTextInputFormatter(255)
                      ],
                      onFieldSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          controller.namaPic3Value.value = value;
                          await controller.checkNamle3Field(value);
                          controller.checkAllFieldIsFilled();
                        } else {
                          controller.namaPic3Value.value = value;
                          await controller.checkNamle3Field(value);
                          controller.checkAllFieldIsFilled();
                        }
                        FocusManager.instance.primaryFocus.unfocus();
                      },
                      controller: controller.namaPIC3,
                      onChanged: (value) {
                        controller.isNamaPic3Valid.value = true;
                        controller.namaPic3Value.value = value;
                      },
                      newInputDecoration: InputDecoration(
                        hintText: "BFTMRegisterPIC3Ent".tr,
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
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  InkWell(
                    onTap: () async {
                      await controller.pickContact3();
                    },
                    child: Obx(() => 
                      SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(controller.namaPic3Value.value == "" ? ListColor.colorLightGrey2 : ListColor.colorBlue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formNoHpPIC3() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "No. HP PIC 3",
            // ('BFTMRegisterPIC3Phone'.tr).replaceAll("*", ""),
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              vertical: GlobalVariable.ratioWidth(Get.context) * 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: GlobalVariable.ratioWidth(Get.context) * 1,
                color: Color(controller.isNoPic3Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)
              ),
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
            ),
            child: CustomTextFormField(
              context: Get.context,
              autofocus: false,
              controller: controller.noHpPIC3,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(14)
              ],
              onFieldSubmitted: (value) async {
                if (value.isNotEmpty) {
                  controller.naoPic3Value.value = value;
                  await controller.checkNoHP3Field(value);
                  controller.checkAllFieldIsFilled();
                } else {
                  controller.naoPic3Value.value = value;
                  await controller.checkNoHP3Field(value);
                  await controller.checkAllFieldIsFilled();
                }
                FocusManager.instance.primaryFocus.unfocus();
              },
              onChanged: (value) async {
                controller.isNoPic3Valid.value = true;

                if (value != controller.naoPic3Value.value) {
                  controller.naoPic3Value.value = value;
                  return;
                }
              },
              newInputDecoration: InputDecoration(
                //improve 1.3
                hintText: 
                // 'BFTMRegisterPIC3EntN'.tr,
                'Contoh : 0821xxxxxxxx',
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
          )
        ],
      ),
    );
  }
  // ##############################
  // ##  END WIDGET SECOND PAGE  ##
  // ##############################



  // ###############################
  // ##  START WIDGET THIRD PAGE  ##
  // ###############################
  Widget _formAkta1() {
    return Column(
      children: [        
        Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Akta Pendirian Perusahaan dan SK KEMENKUMHAM*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: Color(ListColor.colorLightGrey4),
            // iconAssets: 'assets/ic_info_blue.svg',
            // iconAssetsWidth: 14,
            // iconAssetsHeight: 14,
            // onTap: () {
            //   controller.showHintFile(1);
            // },
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 1
        ),
        Obx(() => controller.fileAkta1.isNotEmpty && controller.fileAkta1[controller.fileAkta1.length-1] == null ?
          _errorUpload(
            marginLeft: 16,
            marginRight: 16,
            marginBottom: 16,
            errorMessage: controller.fileAkta1Result[controller.fileAkta1Result.length-1],
          ) :
          SizedBox.shrink()
        ),
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
                controller: controller.formAkta1ScrollController,
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileAkta1Result.length,
                itemBuilder: (context, index) {
                  if(controller.fileAkta1Result[index].toString().contains(".")){
                     return _successUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      message: controller.fileAkta1Result[index],
                      type: 1,
                      index: index,
                      isFilledFromCross: controller.isFilledFromCrossAkta1.value,
                    );
                  }
                  return SizedBox.shrink();
                }
              ),
            ),
          )
        ),
        if(!controller.isFilledFromCrossAkta1.value)...[
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
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ), 
          ),
        ],
        _divider(
          marginLeft: 16,
          marginTop: controller.isFilledFromCrossAkta1.value ? 0 : 16,
          marginRight: 16,
          maxWidth: true,
          height: 0.5
        ),
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
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Akta Anggaran Dasar Terakhir dan SK*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: Color(ListColor.colorLightGrey4),
            // iconAssets: 'assets/ic_info_blue.svg',
            // iconAssetsWidth: 14,
            // iconAssetsHeight: 14,
            // onTap: () {
            //   controller.showHintFile(2);
            // },
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 2
        ),
        Obx(() => controller.fileAkta2.isNotEmpty && controller.fileAkta2[controller.fileAkta2.length-1] == null ?
          _errorUpload(
            marginLeft: 16,
            marginRight: 16,
            marginBottom: 16,
            errorMessage: controller.fileAkta2Result[controller.fileAkta2Result.length-1],
          ) :
          SizedBox.shrink()
        ),
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
                controller: controller.formAkta2ScrollController,
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileAkta2Result.length,
                itemBuilder: (context, index) {
                  if(controller.fileAkta2Result[index].toString().contains(".")){
                    return _successUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      message: controller.fileAkta2Result[index],
                      type: 2,
                      index: index,
                      isFilledFromCross: controller.isFilledFromCrossAkta2.value,
                    );
                  }
                  return SizedBox.shrink();
                }
              ),
            ),
          )
        ),
        if(!controller.isFilledFromCrossAkta2.value)...[
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
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ],
        _divider(
          marginLeft: 16,
          marginTop: controller.isFilledFromCrossAkta2.value? 0 : 16,
          marginRight: 16,
          maxWidth: true,
          height: 0.5
        ),
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
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Akta Direksi dan Dewan Komisaris terakhir dan SK MenkumHam*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: Color(ListColor.colorLightGrey4),
            // iconAssets: 'assets/ic_info_blue.svg',
            // iconAssetsWidth: 14,
            // iconAssetsHeight: 14,
            // onTap: () {
            //   controller.showHintFile(3);
            // },
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 3
        ),
        Obx(() => controller.fileAkta3.isNotEmpty && controller.fileAkta3[controller.fileAkta3.length-1] == null ?
          _errorUpload(
            marginLeft: 16,
            marginRight: 16,
            marginBottom: 16,
            errorMessage: controller.fileAkta3Result[controller.fileAkta3Result.length-1],
          ) :
          SizedBox.shrink()
        ),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              child: ListView.builder(
                controller: controller.formAkta3ScrollController,
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileAkta3Result.length,
                itemBuilder: (context, index) {
                  if(controller.fileAkta3Result[index].toString().contains(".")){
                    return _successUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      message: controller.fileAkta3Result[index],
                      type: 3,
                      index: index,
                      isFilledFromCross: controller.isFilledFromCrossAkta3.value,
                    );
                  }
                  return SizedBox.shrink();
                }
              ),
            ),
          )
        ),
        if(!controller.isFilledFromCrossAkta3.value)...[
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
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ],
        _divider(
          marginLeft: 16,
          marginTop: controller.isFilledFromCrossAkta3.value ? 0 : 16,
          marginRight: 16,
          maxWidth: true,
          height: 0.5
        ),
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
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            (controller.tipeBadanUsaha.value == TipeBadanUsaha.PT_CV) ? "File KTP Direktur (salah satu)*" : "File KTP Pengurus (salah satu)*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 4
        ),
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
                    return _errorUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      errorMessage: controller.fileKtpDirekturResult[index],
                    );
                  }
                  return _successUpload(
                    marginLeft: 16,
                    marginRight: 16,
                    marginBottom: 16,
                    message: controller.fileKtpDirekturResult[index],
                    type: 4,
                    index: index,
                    isFilledFromCross: controller.isFilledFromCrossKtpDirektur.value,
                  );
                }
              ),
            ),
          )
        ),
        Obx(() => (controller.fileKtpDirektur.isNotEmpty && controller.isValidFileKtpDirektur.value) || controller.isFilledFromCrossKtpDirektur.value ?
          SizedBox.shrink() : 
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
          )
        ),
        if(!controller.isFilledFromCrossKtpDirektur.value)...[
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              controller.fileKtpDirektur.isNotEmpty && controller.isValidFileKtpDirektur.value ? 0 : GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ],
        Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            controller.isFilledFromCrossKtpDirektur.value ? 0 : GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 0
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            (controller.tipeBadanUsaha.value == TipeBadanUsaha.PT_CV) ? "No. KTP Direktur (salah satu)*" : "No. KTP Pengurus (salah satu)*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        Obx(() =>
          AbsorbPointer(
            absorbing: controller.isFilledFromCrossKtpDirektur.value,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              // TARUH BORDER TEXTFIELD DISINI
              decoration: BoxDecoration(
                color: controller.isFilledFromCrossKtpDirektur.value ? Color(ListColor.colorLightGrey2) : Colors.white,
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: controller.isValidKtpDirektur.value ? Color(ListColor.colorLightGrey10) : Color(ListColor.colorRed)
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
                  // TARUH ICON DISINI
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
                        controller.checkFormFilled(controller.pageIndex.value);
                        print("Filled Third Page: " + controller.isFilledThirdPage.value.toString());
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
                        hintText: "No. KTP Sesuai dengan file KTP yang diupload",
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
            ),
          ),
        ),
        _divider(
          marginLeft: 16,
          marginTop: 16,
          marginRight: 16,
          maxWidth: true,
          height: 0.5
        ),
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
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "Akta Perubahan terakhir dan SK (jika ada)",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            // iconAssets: 'assets/ic_info_blue.svg',
            // iconAssetsWidth: 14,
            // iconAssetsHeight: 14,
            // onTap: () {
            //   controller.showHintFile(5);
            // },
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 5
        ),
        Obx(() => controller.fileAkta4.isNotEmpty && controller.fileAkta4[controller.fileAkta4.length-1] == null ?
          _errorUpload(
            marginLeft: 16,
            marginRight: 16,
            marginBottom: 16,
            errorMessage: controller.fileAkta4Result[controller.fileAkta4Result.length-1],
          ) :
          SizedBox.shrink()
        ),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              child: ListView.builder(
                controller: controller.formAkta4ScrollController,
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileAkta4Result.length,
                itemBuilder: (context, index) {
                  if(controller.fileAkta4Result[index].toString().contains(".")){
                    return _successUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      message: controller.fileAkta4Result[index],
                      type: 5,
                      index: index,
                      isFilledFromCross: controller.isFilledFromCrossAkta4.value,
                    );
                  }
                  return SizedBox.shrink();
                }
              ),
            ),
          )
        ),
        if(!controller.isFilledFromCrossAkta4.value)...[
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
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ],
        _divider(
          marginLeft: 16,
          marginTop: controller.isFilledFromCrossAkta4.value ? 0 : 16,
          marginRight: 16,
          maxWidth: true,
          height: 0.5
        ),
      ],
    );
  }

  Widget _formNib() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "File NIB*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            // iconAssets: 'assets/ic_info_blue.svg',
            // iconAssetsWidth: 14,
            // iconAssetsHeight: 14,
            // onTap: () {
            //   controller.showHintFile(6);
            // },
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 6
        ),
        Obx(() => controller.fileNib.isNotEmpty && controller.fileNib[controller.fileNib.length-1] == null ?
          _errorUpload(
            marginLeft: 16,
            marginRight: 16,
            marginBottom: 16,
            errorMessage: controller.fileNibResult[controller.fileNibResult.length-1],
          ) :
          SizedBox.shrink()
        ),
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
                controller: controller.formNibScrollController,
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileNibResult.length,
                itemBuilder: (context, index) {
                  if(controller.fileNibResult[index].toString().contains(".")){
                    return _successUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      message: controller.fileNibResult[index],
                      type: 6,
                      index: index,
                      isFilledFromCross: controller.isFilledFromCrossNib.value,
                    );
                  }
                  return SizedBox.shrink();
                }
              ),
            ),
          )
        ),
        if(!controller.isFilledFromCrossNib.value)...[
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
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ],
        _divider(
          marginLeft: 16,
          marginTop: controller.isFilledFromCrossNib.value ? 0 : 16,
          marginRight: 16,
          maxWidth: true,
          height: 0.5
        ),
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
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "File Sertifikat Standar (optional)",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            // iconAssets: 'assets/ic_info_blue.svg',
            // iconAssetsWidth: 14,
            // iconAssetsHeight: 14,
            // onTap: () {
            //   controller.showHintFile(7);
            // },
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 7
        ),
        Obx(() => controller.fileSertifikat.isNotEmpty && controller.fileSertifikat[controller.fileSertifikat.length-1] == null ?
          _errorUpload(
            marginLeft: 16,
            marginRight: 16,
            marginBottom: 16,
            errorMessage: controller.fileSertifikatResult[controller.fileSertifikatResult.length-1],
          ) :
          SizedBox.shrink()
        ),
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
                controller: controller.formSertifikatScrollController,
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileSertifikatResult.length,
                itemBuilder: (context, index) {
                  if(controller.fileSertifikatResult[index].toString().contains(".")){
                    return _successUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      message: controller.fileSertifikatResult[index],
                      type: 7,
                      index: index,
                      isFilledFromCross: controller.isFilledFromCrossSertifikat.value,
                    );
                  }
                  return SizedBox.shrink();
                }
              ),
            ),
          )
        ),
        if(!controller.isFilledFromCrossSertifikat.value)...[
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
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ],
        _divider(
          marginLeft: 16,
          marginTop: controller.isFilledFromCrossSertifikat.value ? 0 : 16,
          marginRight: 16,
          maxWidth: true,
          height: 0.5
        ),
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
            GlobalVariable.ratioWidth(Get.context) * 0
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "No. NPWP Perusahaan*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        Obx(() =>
          AbsorbPointer(
            absorbing: controller.isFilledFromCrossNpwpPerusahaan.value,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              // TARUH BORDER TEXTFIELD DISINI
              decoration: BoxDecoration(
                color: controller.isFilledFromCrossNpwpPerusahaan.value ? Color(ListColor.colorLightGrey2) : Colors.white,
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: controller.isValidNpwpPerusahaan.value ? Color(ListColor.colorLightGrey10) : Color(ListColor.colorRed)
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
                  // TARUH ICON DISINI
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
                        controller.checkFormFilled(controller.pageIndex.value);
                        print("Filled Third Page: " + controller.isFilledThirdPage.value.toString());
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
                        hintText: "Masukkan 16 digit No. NPWP",
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
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "File NPWP Perusahaan*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 8
        ),
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
                    return _errorUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      errorMessage: controller.fileNpwpPerusahaanResult[index],
                    );
                  }
                  return _successUpload(
                    marginLeft: 16,
                    marginRight: 16,
                    marginBottom: 16,
                    message: controller.fileNpwpPerusahaanResult[index],
                    type: 8,
                    index: index,
                    isFilledFromCross: controller.isFilledFromCrossNpwpPerusahaan.value,
                  );
                }
              ),
            ),
          )
        ),
        Obx(() => (controller.fileNpwpPerusahaan.isNotEmpty && controller.isValidFileNpwpPerusahaan.value) || controller.isFilledFromCrossNpwpPerusahaan.value ?
          SizedBox.shrink() : 
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
          )
        ),
        if(!controller.isFilledFromCrossNpwpPerusahaan.value)...[
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              controller.fileNpwpPerusahaan.isNotEmpty && controller.isValidFileNpwpPerusahaan.value ? 0 : GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ],
        _divider(
          marginLeft: 16,
          marginTop: controller.isFilledFromCrossNpwpPerusahaan.value ? 0 : 16,
          marginRight: 16,
          maxWidth: true,
          height: 0.5
        ),
      ],
    );
  }

  Widget _formKtp() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 0
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "No. KTP Pendaftar/Pemegang Akun*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        Obx(() =>
          AbsorbPointer(
            absorbing: controller.isFilledFromCrossKtp.value,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 24,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              // TARUH BORDER TEXTFIELD DISINI
              decoration: BoxDecoration(
                color: controller.isFilledFromCrossKtp.value ? Color(ListColor.colorLightGrey2) : Colors.white,
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: controller.isValidKtp.value ? Color(ListColor.colorLightGrey10) : Color(ListColor.colorRed)
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
                  // TARUH ICON DISINI
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
                        controller.checkFormFilled(controller.pageIndex.value);
                        print("Filled Third Page: " + controller.isFilledThirdPage.value.toString());
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
                        hintText: "Masukkan 16 digit No. KTP",
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
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16
          ),
          alignment: Alignment.centerLeft,
          child: CustomText(
            "File KTP Pendaftar/Pemegang Akun*",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        _progressBar(
          paddingBottom: 16,
          type: 9
        ),
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
                    return _errorUpload(
                      marginLeft: 16,
                      marginRight: 16,
                      marginBottom: 16,
                      errorMessage: controller.fileKtpResult[index],
                    );
                  }
                  return _successUpload(
                    marginLeft: 16,
                    marginRight: 16,
                    marginBottom: controller.isFilledFromCrossKtp.value ? 0 : 16,
                    message: controller.fileKtpResult[index],
                    type: 9,
                    index: index,
                    isFilledFromCross: controller.isFilledFromCrossKtp.value,
                  );
                }
              ),
            ),
          )
        ),
        Obx(() => (controller.fileKtp.isNotEmpty && controller.isValidFileKtp.value) || controller.isFilledFromCrossKtp.value ?
          SizedBox.shrink() : 
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
          )
        ),
        if(!controller.isFilledFromCrossKtp.value)...[
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              controller.fileKtp.isNotEmpty && controller.isValidFileKtp.value ? 0 : GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0
            ),
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Format file jpg/png/pdf/zip max.5Mb",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        ],
        // _divider(
        //   marginLeft: 16,
        //   marginTop: 16,
        //   marginRight: 16,
        //   maxWidth: true,
        //   height: 0.5
        // ),
      ],
    );
  }
  // #############################
  // ##  END WIDGET THIRD PAGE  ##
  // #############################



  Widget _progressBar({
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    int type
  }) {
    return Obx(() => controller.ratioPerForm[type] == -1.0 ? Container() : Padding(
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * paddingLeft, 
        GlobalVariable.ratioWidth(Get.context) * paddingTop, 
        GlobalVariable.ratioWidth(Get.context) * paddingRight, 
        GlobalVariable.ratioWidth(Get.context) * paddingBottom, 
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(Get.context).size.width - (GlobalVariable.ratioWidth(Get.context) * 32),
            height: GlobalVariable.ratioWidth(Get.context) * 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 9),
              color: Color(ListColor.colorLightGrey2)
            ),
          ),
          AnimatedContainer(
            duration: controller.ratioPerForm[type] == 0 ? Duration.zero : Duration(milliseconds: 200),
            width: (MediaQuery.of(Get.context).size.width - (GlobalVariable.ratioWidth(Get.context) * 32)) * controller.ratioPerForm[type],
            height: GlobalVariable.ratioWidth(Get.context) * 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 9),
              color: Color(controller.ratioPerForm[type] == 0 ? ListColor.colorLightGrey2 : ListColor.colorBlue),
            )
          )
        ],
      ),
    ));
  }

  Widget _divider({
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double width,
    double height,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft,
        GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight,
        GlobalVariable.ratioWidth(Get.context) * marginBottom
      ),
      width: maxWidth ? double.infinity : GlobalVariable.ratioWidth(Get.context) * width,
      height: GlobalVariable.ratioWidth(Get.context) * height,
      color: Color(ListColor.colorLightGrey10),
    );
  }

  Widget _successUpload({
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    String message,
    int type,
    int index,
    bool isFilledFromCross = false,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft, 
        GlobalVariable.ratioWidth(Get.context) * marginTop, 
        GlobalVariable.ratioWidth(Get.context) * marginRight, 
        GlobalVariable.ratioWidth(Get.context) * marginBottom, 
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
          if(!isFilledFromCross)...[
            Container(
              child: GestureDetector(
                onTap: (){
                  log("Type: " + type.toString());
                  if(type == 0){
                    controller.dispatchNote.removeAt(index);
                    controller.dispatchNoteResult.removeAt(index);
                  }
                  else if(type == 1){
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
                    controller.isValidFileKtpDirektur.value = false;
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
                    controller.isValidFileNpwpPerusahaan.value = false;
                  }
                  else if(type == 9){
                    controller.fileKtp.removeAt(index);
                    controller.fileKtpResult.removeAt(index);
                    controller.isValidFileKtp.value = false;
                  }
                  controller.checkFormFilled(controller.pageIndex.value);
                },
                child: SvgPicture.asset(
                  "assets/ic_close_file.svg",
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
          ]
        ],
      ),
    );
  }

  Widget _errorUpload({
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    String errorMessage,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft, 
        GlobalVariable.ratioWidth(Get.context) * marginTop, 
        GlobalVariable.ratioWidth(Get.context) * marginRight, 
        GlobalVariable.ratioWidth(Get.context) * marginBottom, 
      ),
      child: Row(
        crossAxisAlignment: errorMessage == "GlobalValidationLabelFileFormatAndSize".tr ? 
        CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
            // padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 2),
            child: SvgPicture.asset(
              "assets/ic_error_upload_seller.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 16,
              height: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
          ),
          Flexible(
            child: CustomText(
              errorMessage,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.colorRed),
            ),
          ),
        ],
      ),
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
          onTap: onTap,
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

class _AppBar extends PreferredSize {
  final String title;
  final String subTitle;
  final Size preferredSize;
  final Function() onBack;

  _AppBar({this.title, this.subTitle, this.preferredSize, this.onBack});

  @override
  Widget build(BuildContext context) {
    RegisterShipperBfTmController controller = Get.find<RegisterShipperBfTmController>();
    return SafeArea(
      child: Obx(() =>
        Container(
          height: preferredSize.height,
          color: Color(ListColor.color4),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 15.5
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
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
                          left: GlobalVariable.ratioWidth(Get.context) * 12
                        ),
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
                    GlobalVariable.ratioWidth(Get.context) * 15
                  ),
                  width: double.infinity,
                  height: GlobalVariable.ratioWidth(Get.context) * 0.5,
                  color: Color(ListColor.colorLightBlue5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Container(
                        child: CustomText(
                          controller.subTitle.value,
                          color: Color(ListColor.colorWhite),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    for (int i = 1; i < 4; i++)
                      _buildPageIndicator(
                          i == controller.pageIndex.value, i)
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: GlobalVariable.ratioWidth(Get.context) * 19,
          height: GlobalVariable.ratioWidth(Get.context) * 19,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCurrentPage ? Color(ListColor.colorYellow) : Colors.transparent,
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 19),
            border: Border.all(
              color: Color(ListColor.colorYellow), 
              width: GlobalVariable.ratioWidth(Get.context) * 2
            ),
          ),
          child: CustomText(index.toString(),
            color: isCurrentPage ? Color(ListColor.colorBlue) : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700
          ),
        ),
        index == 3
            ? SizedBox.shrink()
            : Container(
                width:  GlobalVariable.ratioWidth(Get.context) * 12,
                height:  GlobalVariable.ratioWidth(Get.context) * 2,
                color: Color(ListColor.colorYellow)
              )
      ],
    );
  }
}