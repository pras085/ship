import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/profile_individu/components/search_kecamatan/search_kecamatan_controller.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/ubah_data_usaha_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/dropdown_overlay.dart';
import 'package:muatmuat/global_variable.dart';

class UbahDataUsahaView extends GetView<UbahDataUsahaController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.cancel();
        return false;
      },
      child: Scaffold(
        appBar: AppBarProfile(
          isCenter: false,
          isBlueMode: false,
          title: 'Ubah Data Usaha',
          onClickBack: () => controller.cancel(),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 24, left: GlobalVariable.ratioWidth(context) * 16),
                    child: CustomText(
                      'Informasi Usaha',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  // CONTENT
                  _formNamaUsaha(),
                  _formNamaPIC(),
                  _formNoHpPIC(),
                  _formAlamatUsaha(),
                  _formKecamatan(),
                  _formKodePos(),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                  // contentField(context: null),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: fixedButton(),
      ),
    );
  }

  Widget fixedButton() {
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 64,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3))
      ]),
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
              text: 'ShipperUbahDataPerusahaanIndexLabelBatal'.tr,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.colorBlue),
              backgroundColor: Colors.white,
              onTap: () async {
                controller.cancel();
              }),
          Obx(
            () => _button(
              width: 160,
              height: 32,
              marginLeft: 4,
              marginTop: 16,
              marginRight: 16,
              marginBottom: 16,
              borderRadius: 18,
              onTap: () => controller.isFilled.value == false ? {} : controller.checkFieldIsValid(),
              backgroundColor: controller.isFilled.value == true ? Color(ListColor.colorBlue) : Color(ListColor.colorLightGrey2),
              text: 'ShipperUbahDataPerusahaanIndexLabelSimpan'.tr,
              color: controller.isFilled.value ? Color(ListColor.colorWhite) : Color(ListColor.colorLightGrey4),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              useBorder: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(
      {double height,
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
      Widget customWidget}) {
    return Container(
      margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * marginLeft, GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight, GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
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
              padding: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * paddingLeft, GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight, GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(borderRadius)),
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

  Widget _formNamaUsaha() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'Nama Usaha',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            withoutExtraPadding: true,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(
                    controller.isNamaUsahaValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed,
                  ),
                ),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              child: CustomTextFormField(
                context: Get.context,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.' ]")), LengthLimitingTextInputFormatter(255)],
                autofocus: false,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(
                    ListColor.colorBlack,
                  ),
                ),
                controller: controller.namaUsaha,
                onChanged: (value) {
                  controller.isNamaUsahaValid.value = true;
                  if (controller.namaUsahaValue.value != value) {
                    controller.namaUsahaValue.value = value;
                  }
                  controller.checkAllFieldIsFilled();
                },
                newInputDecoration: InputDecoration(
                  hintText: "RegisterSellerIndividuIndexLabelFieldNamaUsaha".tr,
                  hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
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

  Widget _formNamaPIC() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
          CustomText(
            'RegisterSellerIndividuIndexLabelNamaPIC'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              // height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isNamaPicValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      keyboardType: TextInputType.name,
                      enableSuggestions: false,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z.' ]")),
                        // FilteringTextInputFormatter.deny(Pattern.),
                        LengthLimitingTextInputFormatter(255)
                      ],
                      controller: controller.namaPICC,
                      onChanged: (value) async {
                        // print("NAMA : ${controller.namaPICValue.value}");
                        controller.isNamaPicValid.value = true;
                        if (controller.namaPICValue.value != value) {
                          controller.namaPICValue.value = value;
                        }

                        await controller.checkAllFieldIsFilled();

                        // print("NAMA : ${controller.namaPICobx.value}");

                        // print("Filled: " + controller.isFilled.value.toString());
                      },
                      newInputDecoration: InputDecoration(
                        hintText: "RegisterSellerIndividuIndexLabelFieldNamaPIC".tr,
                        hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
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
                      await controller.pickContact();
                      await controller.checkAllFieldIsFilled();
                    },
                    child: Obx(
                      () => SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(
                          controller.namaPICValue.value != "" ? ListColor.colorBlue : ListColor.colorLightGrey2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formNoHpPIC() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
          CustomText(
            'RegisterSellerIndividuIndexLabelNoPIC'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(
            () => Container(
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(
                      controller.isNoPicValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed,
                    )),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(
                    ListColor.colorBlack,
                  ),
                ),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(14)],
                controller: controller.noPICC,
                onChanged: (value) async {
                  controller.isNoPicValid.value = true;

                  if (value != controller.noHpPICValue.value) {
                    controller.noHpPICValue.value = value;
                  }
                  controller.checkAllFieldIsFilled();
                },
                newInputDecoration: InputDecoration(
                  hintText: "RegisterSellerIndividuIndexLabelFieldNoPIC".tr,
                  hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
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

  Widget _formAlamatUsaha() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
          CustomText(
            'Alamat sesuai KTP*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
          InkWell(
            onTap: () {
              controller.onClickAddresss("lokasi");
              controller.checkAllFieldIsFilled();
            },
            child: Container(
              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 12),
              constraints: BoxConstraints(minHeight: GlobalVariable.ratioWidth(Get.context) * 104),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                border: Border.all(
                  color: Color(ListColor.colorLightGrey10),
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Obx(
                    () => Flexible(
                      fit: FlexFit.tight,
                      child: CustomText(
                        controller.lokasiakhir.value,
                        fontSize: 14,
                        color: Color(ListColor.colorBlack),
                        height: 16.8 / 14,
                        maxLines: 3,
                        withoutExtraPadding: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formKecamatan() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'RegisterSellerPerusahaanIndexLabelKecamatan'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          GestureDetector(
            onTap: () async {
              // controller.postalCodeList.value = [];
              final result = await GetToPage.toNamed<SearchKecamatanController>(Routes.SEARCH_KECAMATAN);

              if (result != null) {
                print('HASIL RESULT : $result');
                controller.districtController.value.text = result['name'].toString();
                controller.kecamatanPerusahaanText.value = result['name'].toString();
                controller.kodepos.value = null;
                controller.cityID.value = result['city_id'];
                controller.provinceID.value = result['province_id'];
                controller.districtID.value = result['id'];
                await controller.getIdUsaha(result['id']);

                log('DIS.VALUE : ${controller.districtID.value} ');
                log('PROV.VALUE : ${controller.provinceID.value} ');
                log('CITY.VALUE : ${controller.cityID.value} ');

                if (controller.kecamatanPerusahaanText.value == "") {
                  // controller.isKecamatanValid.value = false;
                }
                controller.checkAllFieldIsFilled();
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: Obx(
              () => Container(
                // height: GlobalVariable.ratioWidth(Get.context) * 40,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                // height: GlobalVariable.ratioWidth(Get.context) * 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    // color: Color(controller.isKecamatanValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)),
                    color: Color(ListColor.colorLightGrey10),
                  ),
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/location_marker.svg",
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      color: Color(controller.districtController.value.text == "" ? ListColor.colorLightGrey2 : ListColor.colorBlack),
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 10),
                    Expanded(
                      child: CustomTextFormField(
                        context: Get.context,
                        autofocus: false,
                        enabled: false,
                        onChanged: (value) {},
                        controller: controller.districtController.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: GlobalVariable.ratioWidth(Get.context) * 1.2,
                        ),
                        textSize: 14,
                        newInputDecoration: InputDecoration(
                          hintText: 'RegisterSellerPerusahaanIndexLabelFieldKecamatan'.tr,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2),
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
        ],
      ),
    );
  }

  Widget _formKodePos() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
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
          AbsorbPointer(
            absorbing: controller.districtController.value.text != "" ? false : true,
            child: DropdownOverlay(
              // bgColor: Colors.red,
              value: controller.kodepos.value != null ? controller.kodepos.value.toString() : null,
              dataList: controller.postalCodeList == [] ? [] : controller.postalCodeList,
              contentPadding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 6,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              itemBuilder: (ctx, data) {
                return GestureDetector(
                  onTap: () {
                    controller.pilihKodePos.value = data.toString();
                    controller.kodepos.value = data['PostalCode'].toString();
                    controller.districtID.value = data['ID'];
                    // log('KODEPOS : ${controller.pilihKodePos.value}');
                    FocusManager.instance.primaryFocus.unfocus();
                    // controller.pilihKodePosValue.value = null;
                    controller.checkAllFieldIsFilled();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 6,
                    ),
                    child: CustomText(
                      data['PostalCode'].toString(),
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
              borderColor: FocusScope.of(Get.context).hasFocus
                  ? Color(ListColor.colorBlue) ?? Color(ListColor.colorLightGrey2)
                  : Color(
                      ListColor.colorLightGrey2,
                    ),
              builder: (ctx, data, isOpen, hasFocus) {
                return Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 40,
                  child: Material(
                    color: controller.kodepos.value != null
                        ? Color(ListColor.colorWhite)
                        : controller.districtController.value.text == ""
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
                            child: CustomText(
                                controller.kodepos.value != null
                                    ? controller.kodepos.value
                                    : controller.districtController.value.text == ""
                                        ? 'BFTMRegisterChooseDistrik'.tr
                                        : 'RegisterSellerPerusahaanIndexLabelFieldKodePos2'.tr,
                                color: hasFocus
                                    ? Color(0xFF676767)
                                    : controller.kodepos.value != null
                                        ? Color(0xFF676767)
                                        : controller.districtController.value.text == ""
                                            ? Color(0xFF676767)
                                            : Color(0xFFCECECE)),
                          ),
                          SvgPicture.asset(
                            isOpen ? 'assets/template_buyer/ic_chevron_up.svg' : 'assets/template_buyer/ic_chevron_down.svg',
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
  }
}
