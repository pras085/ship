import 'dart:developer';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/choose_business_field/choose_business_field_controller.dart';
import 'package:muatmuat/app/modules/choose_district/choose_district_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/create_permintaan_muat/create_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/select_list_lokasi/select_list_lokasi_controller.dart';
import 'package:muatmuat/app/modules/upload_picture/upload_picture_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'form_pendaftaran_bf_controller.dart';

class _AppBar extends PreferredSize {
  final String title;
  final Size preferredSize;
  final Function() onBack;

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<FormPendaftaranIndividuController>();
    return Container(
      color: Color(ListColor.color4),
      child: SafeArea(
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
                              'Data Perusahaan',
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
                          child: Image.asset('assets/part2.png', width: GlobalVariable.ratioWidth(Get.context) * 78,
                            height: GlobalVariable.ratioWidth(Get.context) * 19,)
                        )
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }

  _AppBar({this.title, this.preferredSize, this.onBack});
}



class FormPendaftaranPerusahaanView
    extends GetView<FormPendaftaranBFController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return WillPopScope(
      onWillPop: () async {
        controller.cancel();
        return false;
      },
      child: Scaffold(
        appBar: _AppBar(
          title: controller.tipeModul.value == TipeModul.BF ? 'BFTMRegisterBFDaftarBigFleetsShipper'.tr : 'BFTMRegisterTMDaftarShipperTransportMarket'.tr,
                preferredSize: Size.fromHeight(
                    GlobalVariable.ratioWidth(Get.context) *
                        99),
                onBack: () {
                  controller.cancel();
                },
              ),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Obx(
              () => Container(
                color: Color(ListColor.colorBlue),
                child: SafeArea(
                  child: Container(
                    height: MediaQuery.of(Get.context).size.height,
                    color: Color(ListColor.colorWhite),
                    child: controller.loading.value != true
                        ? SingleChildScrollView(
                            child: Form(
                              key: controller.formKey.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //BEGIN
                                  _header(),
                                  _formLogoPerusahaan(),
                                  //BEGIN INFROMASI PERUSAHAAN
                                  _formNamaPerusahaan(),
                                  _formBadanUsaha(),
                                  _formCariBidangUsaha(),
                                  // _formBidangUsaha(),
                                  //BEGIN LOKASI PERUSAHAAN
                                  SizedBox(
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) * 12),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            GlobalVariable.ratioWidth(Get.context) *
                                                16),
                                    child: Divider(
                                        thickness: 0.5,
                                        color: Color(ListColor.colorLightGrey10)),
                                  ),
                                  SizedBox(
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) * 24),
                                  _lokasiPeruashaan(),
                                  controller.alamatlokasiakhir.value == " "?
                                  _formCariAlamat() : 
                                  _formAdaAlamat(),
                                  _formAlamatPerusahaan(),
                                  _formKecamatan(),
                                  _formKodePos(),
                                  _pilihPin(),
                                  // _peta(),
                                  _formNoTelepon(),
                                  _beginKontak(),
                                  //BEGINKONTAK
                                  _formNamaPIC1(),
                                  _formNoHpPIC1(),
                                  _formNamaPIC2(),
                                  _formNoHpPIC2(),
                                  _formNamaPIC3(),
                                  _formNoHpPIC3(),
                                  _beginEmail(),
                                  _formEmailBF(),
                                  SizedBox(
                                    height: GlobalVariable.ratioWidth(context) * 87.5,
                                  )
                                  // Obx(
                                  //   () => _button(
                                  //     height: 35,
                                  //     marginLeft:
                                  //         GlobalVariable.ratioWidth(Get.context) * 16,
                                  //     marginRight:
                                  //         GlobalVariable.ratioWidth(Get.context) * 16,
                                  //     marginTop:
                                  //         GlobalVariable.ratioWidth(Get.context) * 24,
                                  //     marginBottom:
                                  //         GlobalVariable.ratioWidth(Get.context) * 32,
                                  //     useBorder: false,
                                  //     fontSize: 14,
                                  //     text: 'Selanjutnya',
                                  //     fontWeight: FontWeight.w600,
                                  //     color: controller.isFilled.value == false
                                  //         ? Color(ListColor.colorLightGrey4)
                                  //         : Colors.white,
                                  //     backgroundColor:
                                  //         controller.isFilled.value == false
                                  //             ? Color(ListColor.colorLightGrey2)
                                  //             : Color(ListColor.colorBlue),
                                  //     onTap: () => controller.isFilled.value == false
                                  //         ? {}
                                  //         : controller.checkFieldIsValid(),
                                  //   ),
                                  // ),
                                  // ElevatedButton(
                                  //     onPressed: () => controller.direct(),
                                  //     child: Text('direct')),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 24),
                          height: GlobalVariable.ratioWidth(Get.context) * 64,
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
                                    borderRadius: 18,
                                    onTap: ()=> controller.isFilled.value == false
                                ? {}
                                : controller.checkFieldIsValid(), backgroundColor: 
                controller.isFilled.value == true ? Color(ListColor.colorBlue) : Color(ListColor.colorLightGrey2), text: 'Selanjutnya', color: controller.isFilled.value? Color(ListColor.colorWhite) : Color(ListColor.colorLightGrey4), fontSize: 12, fontWeight: FontWeight.w600, useBorder: false,),
                              ),
                            ],
                          ),
                        )
                      )
          ],
        ),
      ),
    );
  }

  // Widget __formLogoPerusahaan() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: GlobalVariable.ratioWidth(Get.context) *
  //             16), // color: Color(ListColor.colorBrightRed),
  //     // height: GlobalVariable.ratioWidth(Get.context) * 167,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         CustomText(
  //           'Logo Perusahaan*',
  //           fontWeight: FontWeight.w600,
  //           // height: GlobalVariable.ratioWidth(Get.context) * 1,
  //           color: Color(ListColor.colorLightGrey4),
  //         ),
  //         SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 12),
  //         Align(
  //           alignment: Alignment.center,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 // padding: EdgeInsets.symmetric(
  //                 //   vertical: GlobalVariable.ratioWidth(Get.context) * 28,
  //                 //   horizontal: GlobalVariable.ratioWidth(Get.context) * 27,
  //                 // ),
  //                 height: GlobalVariable.ratioWidth(Get.context) * 72,
  //                 width: GlobalVariable.ratioWidth(Get.context) * 72,
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                   color: Color(ListColor.colorLightGrey2),
  //                   shape: BoxShape.circle,
  //                   border: Border.all(
  //                     width: 1,
  //                     color: Color(ListColor.colorLightGrey10),
  //                   ),
  //                 ),
  //                 child: Container(
  //                   height: GlobalVariable.ratioWidth(Get.context) * 24,
  //                   width: GlobalVariable.ratioWidth(Get.context) * 24,
  //                   child: controller.file.value.path != null
  //                       ? SvgPicture.asset(
  //                           'assets/camera_logo.svg',
  //                           fit: BoxFit.cover,
  //                           // height: GlobalVariable.ratioWidth(Get.context) * 24,
  //                         )
  //                       // width: GlobalVariable.ratioWidth(Get.context) * 24,
  //                       : MemoryImage(controller.imageData),
  //                 ),
  //               ),
  //               _button(
  //                 width: GlobalVariable.ratioWidth(Get.context) * 119,
  //                 height: GlobalVariable.ratioWidth(Get.context) * 30,
  //                 marginTop: GlobalVariable.ratioWidth(Get.context) * 12,
  //                 marginRight: GlobalVariable.ratioWidth(Get.context) * 25,
  //                 marginLeft: GlobalVariable.ratioWidth(Get.context) * 25,
  //                 marginBottom: GlobalVariable.ratioWidth(Get.context) * 10,
  //                 useBorder: true,
  //                 borderColor: Color(ListColor.colorBlue),
  //                 borderSize: 1,
  //                 borderRadius: 18,
  //                 paddingBottom: GlobalVariable.ratioWidth(Get.context) * 7,
  //                 paddingTop: GlobalVariable.ratioWidth(Get.context) * 7,
  //                 paddingLeft: GlobalVariable.ratioWidth(Get.context) * 24,
  //                 paddingRight: GlobalVariable.ratioWidth(Get.context) * 24,
  //                 backgroundColor: Color(ListColor.colorBlue),
  //                 customWidget: Container(
  //                   child: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         margin: EdgeInsets.only(
  //                             right:
  //                                 GlobalVariable.ratioWidth(Get.context) * 6),
  //                         alignment: Alignment.centerLeft,
  //                         width: GlobalVariable.ratioWidth(Get.context) * 12,
  //                         height: GlobalVariable.ratioWidth(Get.context) * 12,
  //                         child: SvgPicture.asset(
  //                           "assets/ic_upload_seller.svg",
  //                         ),
  //                       ),
  //                       Container(
  //                         alignment: Alignment.center,
  //                         width: GlobalVariable.ratioWidth(Get.context) * 53,
  //                         child: CustomText(
  //                           "Upload",
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 onTap: () async {
  //                   // final result = await controller.showUpload();
  //                   controller.showUpload();
  //                   // if (result != null) {
  //                   //   log('RESULT : $result');
  //                   //   controller.file.value = result;
  //                   // } else {
  //                   //   log('RESULT : $result');
  //                   // }
  //                   // Get.back();
  //                 },
  //               ),
  //               Container(
  //                 width: GlobalVariable.ratioWidth(Get.context) * 169,
  //                 child: CustomText(
  //                   "Format file .jpg/.png max.5MB",
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w500,
  //                   color: Color(ListColor.colorLightGrey4),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _formLogoPerusahaan() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) *
              16), // color: Color(ListColor.colorBrightRed),
      // height: GlobalVariable.ratioWidth(Get.context) * 167,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Logo Perusahaan*',
            fontWeight: FontWeight.w600,
            // height: GlobalVariable.ratioWidth(Get.context) * 1,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 12),
          Container(
            // color: Color(ListColor.colorBrightRed),
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 48.5),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 72,
                  width: GlobalVariable.ratioWidth(Get.context) * 72,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorLightGrey12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Color(ListColor.colorGrey3),
                    ),
                  ),
                  child: Obx(
                    () => controller.picturefill.value == false
                        ? SvgPicture.asset(
                            'assets/camera_logo.svg',
                            fit: BoxFit.cover,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                          )
                        // width: GlobalVariable.ratioWidth(Get.context) * 24,
                        // : MemoryImage(controller.croppedfile.bytes)
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 900),
                          child: Image.file(
                              controller.file.value,
                              fit: BoxFit.cover,
                            ),
                        ),
                  ),
                ),

                Align(
          alignment: Alignment.center,
          child: _button(
            width:  GlobalVariable.ratioWidth(Get.context) * 119,
            height:  GlobalVariable.ratioWidth(Get.context) * 30,
            marginTop: GlobalVariable.ratioWidth(Get.context) * 12,
            marginRight: GlobalVariable.ratioWidth(Get.context) * 25,
            marginLeft: GlobalVariable.ratioWidth(Get.context) * 25,
            marginBottom: GlobalVariable.ratioWidth(Get.context) * 10,
            useBorder: false,
            borderRadius:  GlobalVariable.ratioWidth(Get.context) * 18,
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
            onTap: (){
              GetToPage.toNamed<UploadPictureController>(Routes.UPLOAD_PICTURE);
            }
          ),
        ),
        
                // Image.file(controller.file.va),
                // _button(
                //   width: GlobalVariable.ratioWidth(Get.context) * 123,
                //   height: GlobalVariable.ratioWidth(Get.context) * 33,
                //   marginTop: GlobalVariable.ratioWidth(Get.context) * 12,
                //   marginRight: GlobalVariable.ratioWidth(Get.context) * 25,
                //   marginLeft: GlobalVariable.ratioWidth(Get.context) * 25,
                //   marginBottom: GlobalVariable.ratioWidth(Get.context) * 10,
                //   useBorder: true,
                //   borderColor: Color(ListColor.colorBlue),
                //   borderSize: 1,
                //   borderRadius: 18,
                //   paddingBottom: GlobalVariable.ratioWidth(Get.context) * 7,
                //   paddingTop: GlobalVariable.ratioWidth(Get.context) * 9,
                //   paddingLeft: GlobalVariable.ratioWidth(Get.context) * 24,
                //   paddingRight: GlobalVariable.ratioWidth(Get.context) * 24,
                //   backgroundColor: Color(ListColor.colorBlue),
                //   customWidget: Container(
                //     child: Row(
                //       // mainAxisSize: MainAxisSize.max,
                //       // mainAxisAlignment: MainAxisAlignment.start,
                //       // crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           alignment: Alignment.centerLeft,
                //           width: GlobalVariable.ratioWidth(Get.context) * 12,
                //           height: GlobalVariable.ratioWidth(Get.context) * 12,
                //           child: SvgPicture.asset(
                //             "assets/ic_upload_seller.svg",
                //           ),
                //         ),
                //         SizedBox(
                //             width: GlobalVariable.ratioWidth(Get.context) * 8),
                //         Container(
                //           alignment: Alignment.topCenter,
                //           width: GlobalVariable.ratioWidth(Get.context) * 53,
                //           child: CustomText(
                //             "Upload",
                //             fontSize: 12,
                //             // height: GlobalVariable.ratioWidth(Get.context) * 1,
                //             fontWeight: FontWeight.w600,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   onTap: () {
                //     GetToPage.toNamed<UploadPictureController>(Routes.UPLOAD_PICTURE);
                //     // refo
                //     // controller.isLogoPerusahaanValid.value = true;

                //     // controller.showUpload();

                //     // controller.showUpload();
                //     // log(result.toString());
                //     // if (result != null) {
                //     //   log('RESULT ISI : $result');
                //     //   controller.file.value = result;
                //     // } else {
                //     //   log('RESULT TDK : $result');
                //     // }
                //     // Get.back();
                //   },
                // ),
                
                Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 169,
                  child: CustomText(
                    "Format file .jpg/.png max.5MB",
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

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          // SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          // CustomText(
          //   'Data Seller / Partner',
          //   fontWeight: FontWeight.w700,
          //   color: Color(ListColor.colorBlack),
          //   fontSize: 16,
          // ),
          // SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 3),
          // CustomText(
          //   'Silahkan Anda melengkapi data-data dibawah ini',
          //   fontWeight: FontWeight.w600,
          //   color: Color(ListColor.colorGrey3),
          //   fontSize: 14,
          // ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'Informasi Perusahaan',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
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
            'Notifikasi dan konfirmasi dari muatmuat akan dikirimkan ke email Pemegang Akun',
            fontWeight: FontWeight.w500,
            height: GlobalVariable.ratioWidth(Get.context) * 1,
            fontSize: 12,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 13,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              decoration: BoxDecoration(
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
                  hintText: "Masukkan email",
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
              'Bidang Usaha*',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
        Obx(() => InkWell(
          onTap: () async {
            final result = await GetToPage.toNamed<ChooseBusinessFieldController>(Routes.CHOOSE_BUSINESS_FIELD);
            print(result);
            if (result != null) {
              controller.businessFieldController.value.text = result['name'];
            }
          },
          child: Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 18,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10)
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6
                )
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
                      color: Colors.red,
                      //refo
                      // controller.text == ""
                      //   ? Color(ListColor.colorLightGrey2)
                      //   : Color(ListColor.colorBlack),
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      enabled: false,
                      onChanged: (value) {
                        //refo
                        // controller.search(search: value);
                      },
                      //refo
                      controller: controller.businessFieldController.value,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 14,
                      newInputDecoration: InputDecoration(
                        hintText: "Cari Bidang Usaha",
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

  Widget _formNamaPerusahaan() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'Nama Perusahaan*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 13,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isNamaPerusahaanValid.value == true
                        ? ListColor.colorLightGrey10
                        : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(6),
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(
                    ListColor.colorBlack,
                  ),
                ),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.namaPerusahaanValue.value = value;
                    controller.checkNameUsahaField(value);

                    // controller.isFilled.value = true;
                    // log('alamat: ' + '${controller.alamatValue.value}');
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
                newInputDecoration: InputDecoration(
                  hintText: "Masukkan Nama Perusahaan",
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
            'Badan Usaha*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              height: GlobalVariable.ratioHeight(Get.context) * 40,
              child: DropdownBelow(
                itemWidth: MediaQuery.of(Get.context).size.width -
                    GlobalVariable.ratioWidth(Get.context) * 32,
                itemTextstyle: TextStyle(
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                boxTextstyle: TextStyle(
                    color: Color(ListColor.colorLightGrey2),
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                boxWidth: MediaQuery.of(Get.context).size.width,
                boxHeight: GlobalVariable.ratioWidth(Get.context) * 40,
                boxPadding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 12,
                    right: GlobalVariable.ratioWidth(Get.context) * 12),
                boxDecoration: BoxDecoration(
                  color: Color(ListColor.colorWhite),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    // color: Colors.grey[300],
                    color: Color(controller.isBidangUsahaValid.value == true
                        ? ListColor.colorLightGrey10
                        : ListColor.colorRed),
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: GlobalVariable.ratioWidth(Get.context) * 16,
                  color: Color(
                    controller.pilihBidangUsaha.value != null
                        ? ListColor.colorBlack
                        : ListColor.colorLightGrey2,
                  ),
                ),
                hint: CustomText("Pilih Badan Usaha",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey2)),
                value: controller.pilihBidangUsaha.value,
                items: controller.bidangUsahaList == []
                    ? null
                    : controller.bidangUsahaList.map((data) {
                        return DropdownMenuItem(
                          child: CustomText(data['Description'].toString(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(ListColor.colorBlack)),
                          value: data['ID'].toString(),
                        );
                      }).toList(),
                onChanged: (value) {
                  controller.isBidangUsahaValid.value = true;
                  if (value.isNotEmpty) {
                    controller.pilihBidangUsaha.value = value;
                    log(controller.pilihBidangUsaha.value);
                  }
                  controller.checkBidangUsahaField(value);
                  FocusManager.instance.primaryFocus.unfocus();
                  controller.checkAllFieldIsFilled();
                },
              ),
            ),
          ),
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
            'Bidang Usaha*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              child: DropdownBelow(
                itemWidth: MediaQuery.of(Get.context).size.width -
                    GlobalVariable.ratioWidth(Get.context) * 32,
                itemTextstyle: TextStyle(
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                boxTextstyle: TextStyle(
                    color: Color(ListColor.colorLightGrey2),
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                boxPadding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 12,
                    right: GlobalVariable.ratioWidth(Get.context) * 12),
                boxWidth: MediaQuery.of(Get.context).size.width,
                boxHeight: GlobalVariable.ratioWidth(Get.context) * 40,
                boxDecoration: BoxDecoration(
                    color: Color(ListColor.colorWhite),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                      // color: Colors.grey[300],
                      color: Color(controller.isBidangUsahaValid.value == true
                          ? ListColor.colorLightGrey10
                          : ListColor.colorRed),
                    )),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: GlobalVariable.ratioWidth(Get.context) * 16,
                  color: Color(
                    controller.pilihBidangUsaha.value != null
                        ? ListColor.colorBlack
                        : ListColor.colorLightGrey2,
                  ),
                ),
                hint: CustomText("Pilih Bidang Usaha",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey2)),
                value: controller.pilihBidangUsaha.value != null
                    ? controller.pilihBidangUsaha.value
                    : null,
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
                    controller.pilihBidangUsaha.value = value;
                    log(controller.pilihBidangUsaha.value);
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
          CustomText(
            'Lokasi Perusahaan',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
          // SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
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
            'Detail Alamat',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
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
                    color: Color(controller.isAlamaPerusahaanValid.value == true
                        ? ListColor.colorLightGrey10
                        : ListColor.colorRed)),
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

                    // controller.isFilled.value = true;
                    // log('alamat: ' + '${controller.alamatValue.value}');
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
                  hintText: "Masukkan alamat perusahaan",
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
              'Alamat Perusahaan*',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child: Container(
              height:  GlobalVariable.ratioWidth(Get.context) * 78,
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
                    child: Image.asset('assets/location_bf.png', height: GlobalVariable.ratioWidth(Get.context) * 16, width: GlobalVariable.ratioWidth(Get.context) * 16,),
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8,),
                  Flexible(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
                        child: CustomText(controller.namalokasiakhir.value, fontSize: GlobalVariable.ratioWidth(Get.context) * 14, fontWeight: FontWeight.w600, color: Color(ListColor.colorBlack),),
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 3,),
                      CustomText(controller.alamatlokasiakhir.value, fontSize: GlobalVariable.ratioWidth(Get.context) * 14, fontWeight: FontWeight.w500, color: Color(ListColor.colorBlack), maxLines: 2,),
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
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Alamat Perusahaan*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          InkWell(
            onTap: () async {
              // controller.onClickAddress(0);
              // GetToPage.toNamed<SelectListLokasiController>(
        // Routes.SELECT_LIST_LOKASI);
              controller.onClickAddresss("lokasi");
        //       GetToPage.toNamed<CreatePermintaanMuatController>(
        // Routes.CREATE_PERMINTAAN_MUAT);                                                            
              // controller.postalCodeList.value = [];
              // final result = await GetToPage.toNamed<SearchKecamatanController>(
              //     Routes.SEARCH_KECAMATAN);

              // if (result != null) {
              //   controller.isKecamatanValid.value = true;

              //   // log(result['id'].toString());                controller.isKecamatanValid.value = true;
              //   print('HASIL RESULT : $result');

              //   controller.kecamatanPerusahaanText.value =
              //       result['name'].toString();
              //   controller.cityStoreArg.value = result['city_id'].toString();
              //   controller.provinceStoreArg.value =
              //       result['province_id'].toString();
              //   await controller.getIdUsaha(result['id']);
              //   // controller.kecamatanText.value = controller.kecamatanC.text;
              //   // log('KEC.TEXT : ${controller.kecamatanC.text} ');
              //   controller.idKecamatanResult.value = result['id'];

              //   log('ID.KECAMATAN : ${controller.idKecamatanResult.value} ');
              //   log('KEC.VALUE : ${controller.kecamatanPerusahaanText.value} ');
              //   log('PROV.VALUE : ${controller.provinceStoreArg.value} ');
              //   log('CITY.VALUE : ${controller.cityStoreArg.value} ');

              //   if (controller.kecamatanPerusahaanText.value == "") {
              //     controller.isKecamatanValid.value = false;
              //   }
              //   controller.checkAllFieldIsFilled();
              //   FocusManager.instance.primaryFocus.unfocus();
              // }

              // controller.textId.value = result;
            },
            child: Obx(
              () => Container(
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                // height: GlobalVariable.ratioWidth(Get.context) * 40,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                      color: Color(controller.isKecamatanValid.value == true
                          ? ListColor.colorLightGrey10
                          : ListColor.colorRed)),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => SvgPicture.asset(
                        "assets/location_marker.svg",
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(
                            controller.kecamatanPerusahaanText.value == ""
                                ? ListColor.colorLightGrey2
                                : ListColor.colorBlack),
                      ),
                    ),
                    SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10),
                    Obx(
                      () => Expanded(
                        child: CustomText(
                          controller.kecamatanPerusahaanText.value == ""
                              ? 'Cari alamat'
                              : controller.kecamatanPerusahaanText.value,
                          color: controller.kecamatanPerusahaanText.value == ""
                              ? Color(ListColor.colorLightGrey2)
                              : Color(ListColor.colorBlack),
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
              'Kecamatan*',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(() => InkWell(
            onTap: () async {
              final result = await GetToPage.toNamed<ChooseDistrictController>(Routes.CHOOSE_DISTRICT);
              if (result != null) {
                controller.districtController.value.text = result['name'];
              }
            },
            child: Container(
                margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 18,
                ),
                height: GlobalVariable.ratioWidth(Get.context) * 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(ListColor.colorLightGrey10)
                  ),
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6
                  )
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
                        //refo
                        // controller.text == ""
                        //   ? Color(ListColor.colorLightGrey2)
                        //   : Color(ListColor.colorBlack),
                      ),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        context: Get.context,
                        autofocus: false,
                        enabled: false,
                        onChanged: (value) {
                          //refo
                          // controller.search(search: value);
                        },
                        //refo
                        controller: controller.districtController.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.2,
                        ),
                        textSize: 14,
                        newInputDecoration: InputDecoration(
                          hintText: "Cari Kecamatan",
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
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          Divider(thickness: 0.5, color: Color(ListColor.colorLightGrey10)),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'Kontak PIC',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 6),
          CustomText( 
            'Masukkan kontak PIC perusahaan Anda untuk dapat dihubungi oleh transporter.',
            fontWeight: FontWeight.w500,
            height: GlobalVariable.ratioWidth(Get.context) * 1,
            fontSize: 12,
            color: Color(ListColor.colorLightGrey4),
          ),
        ],
      ),
    )       ;
  }

  Widget _beginEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          Divider(thickness: 0.5, color: Color(ListColor.colorLightGrey10)),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'Data Pemegang Akun',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ],
      ),
    )       ;
  }

  Widget _peta(){
    return  Stack(
        children: [
          Obx(() => FlutterMap(
                options: MapOptions(
                  center: GlobalVariable.centerMap,
                  interactiveFlags: InteractiveFlag.none,
                  zoom: 13.0,
                ),
                mapController:
                    controller.mapLokasiController,
                layers: [
                  GlobalVariable.tileLayerOptions,
                  MarkerLayerOptions(markers: [
                    // for (var index = 0;
                    //     index <
                    //         controller
                    //             .latlngLokasi.keys.length;
                    //     index++)
                      // Marker(
                      //   width: 30.0,
                      //   height: 30.0,
                      //   point: controller
                      //       .latlngLokasi.values
                      //       .toList()[index],
                      //   builder: (ctx) => Stack(
                      //     alignment: Alignment.topCenter,
                      //     children: [
                      //       SvgPicture.asset(
                      //         // controller.totalLokasi
                      //         //             .value ==
                      //         //         "1"
                      //         //     ? "assets/pin_truck_icon.svg"
                      //         //     : index == 0
                      //         //         ? 
                      //                 "assets/pin_yellow_icon.svg",
                      //                 // : "assets/pin_blue_icon.svg",
                      //         width:
                      //             GlobalVariable.ratioWidth(
                      //                     Get.context) *
                      //                 16,
                      //         height:
                      //             GlobalVariable.ratioWidth(
                      //                     Get.context) *
                      //                 22,
                      //       ),
                      //       Container(
                      //           margin: EdgeInsets.only(
                      //               top: GlobalVariable.ratioWidth(
                      //                       Get.context) *
                      //                   5),
                      //           child: CustomText(
                      //             "",
                      //               // controller.totalLokasi.value == "1"
                      //               //     ? ""
                      //               //     : (int.parse(controller
                      //               //                     .latlngLokasi
                      //               //                     .keys
                      //               //                     .toList()[
                      //               //                 index]) +
                      //               //             1)
                      //               //         .toString(),
                      //               color: 
                      //               // index == 0
                      //                   // ? 
                      //                   Color(ListColor.color4),
                      //                   // : Colors.white,
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: 8))
                      //     ],
                      //   ),
                      // ),
                  
                  ])
                ],
              )),
          // !controller.loadMapLokasi.value
          //     ? SizedBox.shrink()
          //     : 
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'Kode Pos Perusahaan*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => IgnorePointer(
              ignoring:  true ,
              child: Container(
                height: GlobalVariable.ratioWidth(Get.context) * 40,
                child: DropdownBelow(
                  itemWidth: MediaQuery.of(Get.context).size.width -
                      GlobalVariable.ratioWidth(Get.context) * 32,
                  itemTextstyle: TextStyle(
                      color: Color(ListColor.colorBlack),
                      fontWeight: FontWeight.w500,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  boxTextstyle: TextStyle(
                      color: Color(ListColor.colorLightGrey2),
                      fontWeight: FontWeight.w600,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  boxPadding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 12,
                      right: GlobalVariable.ratioWidth(Get.context) * 12),

                  boxWidth: MediaQuery.of(Get.context).size.width,
                  boxHeight: GlobalVariable.ratioWidth(Get.context) * 40,
                  boxDecoration: BoxDecoration(
                    color: Color(
                      ListColor.colorLightGrey2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: GlobalVariable.ratioWidth(Get.context) * 1,
                        // color: Colors.grey[300],
                        color: Color(controller.isKodePosValid.value == true
                            ? ListColor.colorLightGrey10
                            : ListColor.colorRed)),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: GlobalVariable.ratioWidth(Get.context) * 16,
                    color: Color(ListColor.colorGrey3,
                    ),
                  ),
                  hint: CustomText( "Pilih Kecamatan Dahulu",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color( ListColor.colorLightGrey4,
                      )),

                  value: null,

                  // value: controller.pilihKodePosValue.value,
                  items: controller.postalCodeList == []
                      // ? controller.postalCodeErrorList.map((String value) {
                      //     return DropdownMenuItem(
                      //       child: CustomText(value,
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: 14,
                      //           color: Color(ListColor.colorBlack)),
                      //       value: value,
                      //     );
                      //   }).toList()
                      ? []
                      : controller.postalCodeList.map((data) {
                          return DropdownMenuItem(
                            child: CustomText(data['PostalCode'].toString(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(ListColor.colorBlack)),
                            value: data['ID'].toString(),
                          );
                        }).toList(),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      // controller.pilihKodePosValue.value = value;
                      // log('KODEPOS : ${controller.pilihKodePosValue.value}');
                    }
                    FocusManager.instance.primaryFocus.unfocus();
                    controller.checkAllFieldIsFilled();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pilihPin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 16,left: GlobalVariable.ratioWidth(Get.context) * 16),
            child: CustomText(
              'Titik Lokasi*',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        Container(
                  margin: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 12
                      , horizontal:  GlobalVariable.ratioWidth(Get.context) * 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 6)),
                    child: Stack(children: [
                      Container(
                        height: GlobalVariable.ratioWidth(Get.context) * 152,
                        child: Column(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                            child: Obx(
                              () => Stack(
                                children: [
                                  Obx(() => FlutterMap(
                                        options: MapOptions(
                                          center: GlobalVariable.centerMap,
                                          interactiveFlags: InteractiveFlag.none,
                                          zoom: 13.0,
                                        ),
                                        mapController:
                                            controller.mapLokasiController,
                                        layers: [
                                          GlobalVariable.tileLayerOptions,
                                          MarkerLayerOptions(markers: [
                                            for (var index = 0;
                                                index <
                                                    controller
                                                        .latlngLokasi.keys.length;
                                                index++)
                                              Marker(
                                                width: 30.0,
                                                height: 30.0,
                                                point: controller
                                                    .latlngLokasi.values
                                                    .toList()[index],
                                                builder: (ctx) => Stack(
                                                  alignment: Alignment.topCenter,
                                                  children: [
                                                    // SvgPicture.asset(
                                                    //   controller.totalLokasi
                                                    //               .value ==
                                                    //           "1"
                                                    //       ? "assets/pin_truck_icon.svg"
                                                    //       : index == 0
                                                    //           ? "assets/pin_yellow_icon.svg"
                                                    //           : "assets/pin_blue_icon.svg",
                                                    //   width:
                                                    //       GlobalVariable.ratioWidth(
                                                    //               Get.context) *
                                                    //           16,
                                                    //   height:
                                                    //       GlobalVariable.ratioWidth(
                                                    //               Get.context) *
                                                    //           22,
                                                    // ),
                                                    Image.asset(
                                                    'assets/pin_new.png',
                                                    width: GlobalVariable.ratioWidth(Get.context) * 29.56,
                                                    height: GlobalVariable.ratioWidth(Get.context) * 36.76,),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: GlobalVariable.ratioWidth(
                                                                    Get.context) *
                                                                5),
                                                        child: CustomText(
                                                            controller.totalLokasi.value == "1"
                                                                ? ""
                                                                : (int.parse(controller
                                                                                .latlngLokasi
                                                                                .keys
                                                                                .toList()[
                                                                            index]) +
                                                                        1)
                                                                    .toString(),
                                                            color: index == 0
                                                                ? Color(ListColor.color4)
                                                                : Colors.white,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 8))
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
                            height: GlobalVariable.ratioWidth(Get.context) * 35,
                            width: MediaQuery.of(Get.context).size.width,
                            color: Color(ListColor.color4),
                            child: Center(
                              child: CustomText(
                                "InfoPermintaanMuatLabelAturPin".tr,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ]),
                      ),
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            // print('zehahaha');
                            // controller.onClickAddress("lokasi");
                            // controller.onClickSetPositionMarker();
                            controller.onClickAddressMap("lokasi");
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
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'No. Telepon Perusahaan*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 0),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(
                      controller.isNoPic1Valid.value == true
                          ? ListColor.colorLightGrey10
                          : ListColor.colorRed,
                    )),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                controller: controller.noTelp,
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

                  if (value != controller.naoPic1Value.value) {
                    controller.noTelpPerusahaan.value = value;
                  }
                  await controller.checkAllFieldIsFilled();
                },
                newInputDecoration: InputDecoration(
                  hintText: "No. Telepon Perusahaan",
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
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'Nama PIC 1*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              // margin: EdgeInsets.fromLTRB(
              //     GlobalVariable.ratioWidth(Get.context) * 0,
              //     GlobalVariable.ratioWidth(Get.context) * 12,
              //     GlobalVariable.ratioWidth(Get.context) * 0,
              //     GlobalVariable.ratioWidth(Get.context) * 24),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isNamaPic1Valid.value == true
                        ? ListColor.colorLightGrey10
                        : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6),
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
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9.' ]")),
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

                        // log('nama: ' + '${controller.namaUsahaValue.value}');
                      },
                      onChanged: (value) async {
                        controller.isNamaPic1Valid.value = true;
                        if (controller.namaPic1Value.value != value) {
                          controller.namaPic1Value.value = value;
                        }
                        await controller.checkAllFieldIsFilled();
                      },
                      newInputDecoration: InputDecoration(
                        hintText: "Masukkan nama PIC 1",
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
                  // SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  InkWell(
                    onTap: () async {
                      await controller.pickContact1();
                      await controller.checkAllFieldIsFilled();
                    },
                    child: Obx(
                      () => SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(
                          controller.namaPic1Value.value == ""
                              ? ListColor.colorLightGrey2
                              : ListColor.colorBlue,
                        ),
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
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'No. HP PIC 1*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 0),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(
                      controller.isNoPic1Valid.value == true
                          ? ListColor.colorLightGrey10
                          : ListColor.colorRed,
                    )),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                controller: controller.noHpPIC1,
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
                  hintText: "Masukkan No. HP PIC 1",
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
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'Nama PIC 2',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isNamaPic2Valid.value == true
                        ? ListColor.colorLightGrey10
                        : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6),
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
                        color: Color(
                          ListColor.colorBlack,
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9.' ]")),
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
                      onChanged: (value) {
                        controller.isOptionalFilled.value = true;
                        controller.isNamaPic2Valid.value = true;
                        controller.namaPic2Value.value = value;
                      },
                      newInputDecoration: InputDecoration(
                        hintText: "Masukkan nama PIC 2",
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
                  InkWell(
                    onTap: () async {
                      await controller.pickContact2();
                      await controller
                          .checkNamle2Field(controller.namaPic2Value.value);
                    },
                    child: Obx(
                      () => SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(
                          controller.namaPic2Value.value == ""
                              ? ListColor.colorLightGrey2
                              : ListColor.colorBlue,
                        ),
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
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'No. HP PIC 2',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(
                      controller.isNoPic2Valid.value == true
                          ? ListColor.colorLightGrey10
                          : ListColor.colorRed,
                    )),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                controller: controller.noHpPIC2,
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
                onChanged: (value) {
                  controller.isNoPic2Valid.value = true;

                  if (value != controller.naoPic2Value.value) {
                    controller.naoPic2Value.value = value;
                    return;
                  }
                },
                newInputDecoration: InputDecoration(
                  hintText: "Masukkan No. HP PIC 2",
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
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'Nama PIC 3',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 0,
                  GlobalVariable.ratioWidth(Get.context) * 24),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isNamaPic3Valid.value == true
                        ? ListColor.colorLightGrey10
                        : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6),
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
                        color: Color(
                          ListColor.colorBlack,
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9.' ]")),
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
                        hintText: "Masukkan nama PIC 3",
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
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  InkWell(
                    onTap: () async {
                      await controller.pickContact3();
                    },
                    child: Obx(
                      () => SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(
                          controller.namaPic3Value.value == ""
                              ? ListColor.colorLightGrey2
                              : ListColor.colorBlue,
                        ),
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
            'No. HP PIC 3',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 0,
                GlobalVariable.ratioWidth(Get.context) * 0),
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              vertical: GlobalVariable.ratioWidth(Get.context) * 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNoPic3Valid.value == true
                      ? ListColor.colorLightGrey10
                      : ListColor.colorRed)),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6),
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
                hintText: "Masukkan No. HP PIC 3",
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
          )
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
    bool useBorder = true,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
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
}
