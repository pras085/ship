import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/file_example/file_example_controller.dart';
import 'package:muatmuat/app/modules/form_pendaftaran_bf/form_pendaftaran_bf_controller.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/shipment_capacity_validation/shipment_capacity_validation_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ShipmentCapacityValidationView extends GetView<ShipmentCapacityValidationController> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(Get.context).size.width - (GlobalVariable.ratioWidth(Get.context) * 32);

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
              title: controller.tipeModul.value == TipeModul.BF ? 'BFTMRegisterBFDaftarBigFleetsShipper'.tr : 'BFTMRegisterTMDaftarShipperTransportMarket'.tr,
              preferredSize: Size.fromHeight(
                GlobalVariable.ratioWidth(Get.context) * 99
              ),
              onBack: () {
                controller.cancel();
              },
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                          Obx(() => controller.ratio.value == -1 ? Container() : Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: GlobalVariable.ratioWidth(Get.context) * 16
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: width,
                                  height: GlobalVariable.ratioWidth(Get.context) * 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    color: Color(ListColor.colorLightGrey2)
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: controller.ratio.value == 0 ? Duration.zero : Duration(milliseconds: 200),
                                  width: width * controller.ratio.value,
                                  height: GlobalVariable.ratioWidth(Get.context) * 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    color: Color(controller.ratio.value == 0 ? ListColor.colorLightGrey2 : ListColor.colorBlue),
                                  )
                                )
                              ],
                            ),
                          )),
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
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  reverse: true,
                                  itemCount: controller.dispatchNote.length,
                                  itemBuilder: (context, index) {
                                    if(!controller.dispatchNoteResult[index].toString().contains(".")){
                                      return _errorUpload(controller.dispatchNoteResult[index]);
                                    }
                                    return _successUpload(controller.dispatchNoteResult[index], 1, index);
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
                              controller.showUpload();
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
                              height: GlobalVariable.ratioWidth(Get.context) * 172,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                border: Border.all(
                                  color: Color(ListColor.colorGrey6)
                                )
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                child: Image.network(
                                  controller.dispatchNoteUrl,
                                  fit: BoxFit.cover
                                ),
                              ),
                            ),
                          ),
                          if (controller.tipeModul.value == TipeModul.TM) ...[
                            _formTransporter(),
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
                    color: Color(!controller.isValid() ? ListColor.colorLightGrey4 : ListColor.colorWhite),
                    backgroundColor: Color(!controller.isValid() ? ListColor.colorLightGrey2 : ListColor.colorBlue),
                    text: 'BFTMRegisterAllSelanjutnya'.tr,
                    onTap: !controller.isValid() ? null : () async {
                      GetToPage.toNamed<FormPendaftaranBFController>(
                        Routes.REGISTER_PERUSAHAAN_BF, 
                        arguments: controller.tipeModul.value
                      );
                    }
                  )),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _formTransporter() {
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
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
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
              context: Get.context,
              autofocus: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
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
              context: Get.context,
              autofocus: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
              onFieldSubmitted: (value) {
                FocusManager.instance.primaryFocus.unfocus();
                controller.checkPhone(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
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

  Widget _successUpload(String message, int type, int index) {
    return Container(
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 16),
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
                controller.dispatchNote.removeAt(index);
                controller.dispatchNoteResult.removeAt(index);
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
                controller.showUpload();
                controller.changeIndex = index;
              },
              child: CustomText(
                  "BFTMRegisterAllUbahFile".tr,
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

  Widget _errorUpload(String errorMesssage) {
    return Container(
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
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
                  errorMesssage,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorRed),
                  height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _button({
    bool maxWidth = false,
    double width = 0,
    double height = 0,
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
    Color borderColor,
    double borderSize,
    double borderRadius,
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
      width: maxWidth ? double.infinity : GlobalVariable.ratioWidth(Get.context) * width,
      height: GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor,
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
            onTap: onTap == null
                ? null
                : () {
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
}

class _AppBar extends PreferredSize {
  final String title;
  final Size preferredSize;
  final Function() onBack;

  _AppBar({this.title, this.preferredSize, this.onBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                  GlobalVariable.ratioWidth(Get.context) * 16
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
                        'BFTMRegisterAllValidasiKapasitasPengiriman'.tr,
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
                      'assets/ic_step_1_of_3.svg',
                      width: GlobalVariable.ratioWidth(Get.context) * 78,
                      height: GlobalVariable.ratioWidth(Get.context) * 19,
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}