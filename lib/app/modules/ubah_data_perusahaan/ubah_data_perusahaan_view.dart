import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong/latlong.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/choose_district/choose_district_profil_controller.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/ubah_data_perusahaan_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/dropdown_overlay.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';

class UbahDataPerusahaanView extends GetView<UbahDataPerusahaanController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () async {
        controller.cancel();
        return false;
      },
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: Color(ListColor.colorWhite),
        // resizeToAvoidBottomInset: true,
        appBar: AppBarProfile(
          title: "Ubah Informasi Perusahaan",
          isCenter: false,
          onClickBack: () => controller.cancel(),
        ),
        body: Obx(
          () {
            if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
              return content(context);
            } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
              return ErrorDisplayComponent(
                "${controller.dataModelResponse.value.exception}",
                onRefresh: () => controller.onInit(),
              );
            }
            return LoadingComponent();
          },
        ),
        bottomNavigationBar: fixedButton(),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Container(
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(ListColor.colorWhite),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //CHI
                      _formNoTelepon(),
                      _divider(),
                      _beginLokasiPerusahaan(),
                      controller.lokasiakhir.value == " " ? _formCariAlamat() : _formAdaAlamat(),
                      _formDetailAlamatPerusahaan(),
                      _formKecamatan(),
                      _formKodePos(),
                      _pilihPin(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
        vertical: GlobalVariable.ratioWidth(Get.context) * 24,
      ),
      height: GlobalVariable.ratioWidth(Get.context) * 0.5,
      width: double.infinity,
      color: Color(ListColor.colorLightGrey10),
    );
  }

  Widget _formNoTelepon() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          CustomText(
            'No. Telepon Perusahaan*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            withoutExtraPadding: true,
            color: Color(ListColor.colorLightGrey4),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 0),
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              vertical: GlobalVariable.ratioWidth(Get.context) * 13,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(
                    controller.isNoTelpValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed,
                  )),
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
            ),
            child: CustomTextFormField(
              context: Get.context,
              autofocus: false,
              controller: controller.noTeleponC,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(14)],
              onChanged: (value) async {
                controller.isNoTelpValid.value = true;

                if (value != controller.noTelpPerusahaan.value) {
                  controller.noTelpPerusahaan.value = value;
                }
                await controller.checkAllFieldIsFilled();
              },
              newInputDecoration: InputDecoration(
                hintText: "No. Telepon Perusahaan",
                hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
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
        ],
      ),
    );
  }

  Widget _formDetailAlamatPerusahaan() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Detail Alamat',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            withoutExtraPadding: true,
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
                    color: Color(controller.isAlamaPerusahaanValid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                maxLines: 4,
                context: Get.context,
                autofocus: false,
                onChanged: (value) {
                  controller.isAlamaPerusahaanValid.value = true;
                  if (controller.alamatPerusahaanValue.value != value) {
                    controller.alamatPerusahaanValue.value = value;
                  }
                  controller.checkAllFieldIsFilled();
                },
                controller: controller.detailAlamatC.value,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textSize: 14,
                newInputDecoration: InputDecoration(
                  hintText: "Masukkan alamat perusahaan",
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
                  final result = await GetToPage.toNamed<ChooseDistrictProfilPerusahaanController>(
                    Routes.CHOOSE_DISTRICT_PROFIL_PERUSAHAAN,
                    arguments: controller.placeidd.value,
                  );
                  if (result != null) {
                    print(result.toString() + 'xsr');
                    controller.districtController.value.text = result['name'];
                    controller.kecamatanPerusahaanText.value = result['name'];
                    controller.kodepos.value = null;
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
                        border: Border.all(width: GlobalVariable.ratioWidth(Get.context) * 1, color: Color(ListColor.colorLightGrey10)),
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
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
                            onChanged: (value) {},
                            controller: controller.districtController.value,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              height: 1.2,
                            ),
                            textSize: 14,
                            newInputDecoration: InputDecoration(
                              hintText: 'BFTMRegisterCariDistrik'.tr,
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
                      ],
                    )),
              ))
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
                    controller.distid.value = data['ID'].toString();
                    controller.districtID.value = data['ID'];
                    log('KODEPOS : ${controller.distid.value}');
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

  Widget _beginLokasiPerusahaan() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            'Lokasi Perusahaan',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            withoutExtraPadding: true,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 16,
          )
        ],
      ),
    );
  }

  Widget _formCariAlamat() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
        vertical: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            'Alamat Perusahaan*',
            fontWeight: FontWeight.w600,
            withoutExtraPadding: true,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          InkWell(
            onTap: () async {
              controller.onClickAddresss("lokasi");
            },
            child: Obx(
              () => Container(
                margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 8),
                padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(ListColor.colorLightGrey10),
                  ),
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => SvgPicture.asset(
                        "assets/location_marker.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                        color: Color(ListColor.colorLightGrey2),
                      ),
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                    Obx(
                      () => Expanded(
                        child: CustomText(
                          controller.lokasiakhir.value == " " ? 'Cari alamat' : controller.lokasiakhir.value,
                          color: controller.lokasiakhir.value == " " ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorBlack),
                          withoutExtraPadding: true,
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

  Widget _formAdaAlamat() {
    return Container(
      margin: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Alamat Perusahaan*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
          InkWell(
            onTap: () => controller.onClickAddresss("lokasi"),
            child: Container(
              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 12),
              decoration: BoxDecoration(
                color: Color(ListColor.colorWhite),
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
                  Image.asset(
                    'assets/location_bf.png',
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                    color: Color(ListColor.colorBlack),
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
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

  Widget _pilihPin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 16, left: GlobalVariable.ratioWidth(Get.context) * 16),
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
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 163,
              child: Column(
                children: [
                  Obx(
                    () => Expanded(
                      child: FlutterMap(
                        options: MapOptions(
                          center: GlobalVariable.centerMap,
                          zoom: GlobalVariable.zoomMap,
                        ),
                        mapController: controller.mapLokasiController,
                        layers: [
                          GlobalVariable.tileLayerOptions,
                          MarkerLayerOptions(
                            markers: [
                              if (controller.latlngLokasi.keys.length == 0)
                                Marker(
                                  width: GlobalVariable.ratioWidth(Get.context) * 30.0,
                                  height: GlobalVariable.ratioWidth(Get.context) * 30.0,
                                  point: controller.latLngSubmit,
                                  builder: (ctx) => Image.asset(
                                    'assets/pin_new.png',
                                    width: GlobalVariable.ratioWidth(Get.context) * 29.56,
                                    height: GlobalVariable.ratioWidth(Get.context) * 36.76,
                                  ),
                                )
                              else
                                Marker(
                                  width: GlobalVariable.ratioWidth(Get.context) * 30.0,
                                  height: GlobalVariable.ratioWidth(Get.context) * 30.0,
                                  point: controller.latlngLokasi.values.toList()[0],
                                  builder: (ctx) => Image.asset(
                                    'assets/pin_new.png',
                                    width: GlobalVariable.ratioWidth(Get.context) * 29.56,
                                    height: GlobalVariable.ratioWidth(Get.context) * 36.76,
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                      onTap: () => controller.onClickAddressMap('lokasi'),
                      child: Container(
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
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
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
