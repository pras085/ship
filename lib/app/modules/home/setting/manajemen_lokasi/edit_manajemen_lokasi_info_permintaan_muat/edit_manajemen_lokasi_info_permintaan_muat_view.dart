import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/validator/phoine_number_validator.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:muatmuat/global_variable.dart';

class EditManajemenLokasiInfoPermintaanMuatView
    extends GetView<EditManajemenLokasiInfoPermintaanMuatController> {
  double _widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () {
        controller.onWillPop();
        return Future.value(false);
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    GlobalVariable.ratioWidth(Get.context) * 56),
                child: Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 56,
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16),
                                  child: CustomBackButton(
                                      context: Get.context,
                                      backgroundColor:
                                          Color(ListColor.colorBlue),
                                      iconColor: Color(ListColor.colorWhite),
                                      onTap: () {
                                        controller.onWillPop();
                                      }),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     controller.onWillPop();
                                //   },
                                //   child: Container(
                                //     margin: EdgeInsets.only(left: 12),
                                //     height: GlobalVariable
                                //                               .ratioWidth(Get
                                //                                   .context) *56,
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: GlobalVariable.ratioWidth(
                                //                 Get.context) *
                                //             16),
                                //     child: ClipOval(
                                //       child: Material(
                                //           shape: CircleBorder(),
                                //           color: Color(ListColor.color4),
                                //           child: Container(
                                //               width: 30,
                                //               height: 30,
                                //               child: Center(
                                //                   child: Icon(
                                //                 Icons.arrow_back_ios_rounded,
                                //                 size: 20,
                                //                 color: Colors.white,
                                //               )))),
                                //     ),
                                //   ),
                                // ),

                                Align(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                      controller.typeEdit ==
                                              TypeEditManajemenLokasiInfoPermintaanMuat
                                                  .ADD
                                          ? "LabelTitleSaveLocation"
                                              // ? "LocationManagementLabelLocationManagement"
                                              .tr
                                          : "LocationManagementLabelEditLocationManagement"
                                              .tr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ]),
                    ),
                    // Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 2,
                    //     color: Color(ListColor.colorLightBlue5))
                  ]),
                ),
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 7,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                _buildMap(),
                                GestureDetector(
                                  onTap: () {
                                    controller.goToSearchMarkerMap();
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                (GlobalVariable.ratioHeight(Get.context) * 25) -
                                    FontTopPadding.getSize(12),
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioHeight(Get.context) * 22),
                            child: _listTextFormWidget(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 23),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(ListColor.colorLightGrey)
                                .withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 4,
                          ),
                        ]),
                    child: controller.typeEdit ==
                            TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE
                        ? Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: _deleteButton()),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: _saveButton()),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: _saveButton()),
                            ],
                          ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _listTextFormWidget(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.formKey.value,
        onChanged: () {
          controller.isChange = true;
          print('Debug: ' +
              'onChanged isChange = ' +
              controller.isChange.toString());
          if (controller.isValidateOnChange)
            controller.formKey.value.currentState.validate();
        },
        child: Obx(
          () => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textFormField("LocationManagementLabelLocationName".tr,
                    (String value) {
                  if (value.isEmpty) {
                    controller.errorNamaLokasi.value = true;
                    return "LocationManagementLabelValidatorEmptyLocationName"
                        .tr;
                  }
                  controller.errorNamaLokasi.value = false;
                  return null;
                }, (String value) {
                  if (controller.isValidateOnChange) {
                    if (value.isEmpty) {
                      controller.errorNamaLokasi.value = true;
                    } else {
                      controller.errorNamaLokasi.value = false;
                    }
                  }
                }, controller.namaLokasiTextEditingController,
                    "LocationManagementLabelLocationNameHint".tr,
                    maxLength: 64),
                controller.isValidateOnChange &&
                        controller.errorNamaLokasi.value
                    ? _errorText("LocationManagementLabelLocationName".tr)
                    : Container(),
                _separator(),
                GestureDetector(
                  onTap: () {
                    controller.getLocation();
                  },
                  child: _textFormField("LocationManagementLabelLocation".tr,
                      (String value) {
                    if (value.isEmpty) {
                      controller.errorLokasi.value = true;
                      return "LocationManagementLabelValidatorEmptyLocation".tr;
                    }
                    controller.errorLokasi.value = false;
                    return null;
                  }, (String value) {
                    if (controller.isValidateOnChange) {
                      if (value.isEmpty) {
                        controller.errorLokasi.value = true;
                      } else {
                        controller.errorLokasi.value = false;
                      }
                    }
                  }, controller.lokasiTextEditingController,
                      "LocationManagementLabelLocation".tr,
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 6),
                        child: Icon(
                          Icons.location_on,
                          color: Color(ListColor.color4),
                          size: GlobalVariable.ratioHeight(Get.context) * 19,
                        ),
                      ),
                      isEnable: false,
                      textSize: 11),
                ),
                controller.isValidateOnChange && controller.errorLokasi.value
                    ? _errorText(
                        "LocationManagementLabelValidatorEmptyLocation".tr)
                    : Container(),
                _separator(),
                _textFormField("LocationManagementLabelDetailLocation".tr,
                    (String value) {
                  if (value.isEmpty) {
                    controller.errorDetailLokasi.value = true;
                    return "LocationManagementLabelValidatorEmptyDetailLocation"
                        .tr;
                  }
                  controller.errorDetailLokasi.value = false;
                  return null;
                }, (String value) {
                  if (controller.isValidateOnChange) {
                    if (value.isEmpty) {
                      controller.errorDetailLokasi.value = true;
                    } else {
                      controller.errorDetailLokasi.value = false;
                    }
                  }
                }, controller.detailLokasiTextEditingController,
                    "LocationManagementLabelDetailLocationHint".tr,
                    isMultiLine: true, minLines: 3, maxLines: 3),
                controller.isValidateOnChange &&
                        controller.errorDetailLokasi.value
                    ? _errorText(
                        "LocationManagementLabelValidatorEmptyDetailLocation"
                            .tr)
                    : Container(),
                _separator(),
                _itemWithoutTextField(
                    title: "LocationManagementLabelProvince".tr,
                    value: controller.province.value),
                _separator(),
                _itemWithoutTextField(
                    title: "LocationManagementLabelCity".tr,
                    value: controller.city.value),
                _separator(),
                _itemWithoutTextField(
                    title: "LocationManagementLabelDistrict".tr,
                    value: controller.district.value),
                _separator(),
                _textFormField("LocationManagementLabelPostalCode".tr,
                    (String value) {
                  if (value.isEmpty) {
                    controller.errorPostalCode.value = true;
                    controller.errorMessagePostalCode.value =
                        'LocationManagementLabelValidatorEmptyPostalCode'.tr;
                    return 'LocationManagementLabelValidatorEmptyPostalCode'.tr;
                  } else if (value.length < 5 || value == "00000") {
                    controller.errorPostalCode.value = true;
                    controller.errorMessagePostalCode.value =
                        'LocationManagementLabelValidatorNotValidPostalCode'.tr;
                    return 'LocationManagementLabelValidatorNotValidPostalCode'
                        .tr;
                  }
                  controller.errorPostalCode.value = false;
                  return null;
                }, (String value) {
                  if (controller.isValidateOnChange) {
                    if (value.isEmpty) {
                      controller.errorPostalCode.value = true;
                      controller.errorMessagePostalCode.value =
                          'LocationManagementLabelValidatorEmptyPostalCode'.tr;
                    } else if (value.length < 5 || value == "00000") {
                      controller.errorPostalCode.value = true;
                      controller.errorMessagePostalCode.value =
                          'LocationManagementLabelValidatorNotValidPostalCode'
                              .tr;
                    } else {
                      controller.errorPostalCode.value = false;
                    }
                  }
                }, controller.postalCodeTextEditingController, "Kode Pos".tr,
                    maxLength: 5, isNumber: true, removeZeroFront: false),
                controller.isValidateOnChange &&
                        controller.errorPostalCode.value
                    ? _errorText(controller.errorMessagePostalCode.value)
                    : Container(),
                _separator(),
                _textFormField("LocationManagementLabelPICName".tr,
                    (String value) {
                  if (value.isEmpty) {
                    controller.errorNamaPIC.value = true;
                    return "LocationManagementLabelValidatorEmptyPICName".tr;
                  } else {
                    controller.errorNamaPIC.value = false;
                    return null;
                  }
                }, (String value) {
                  if (controller.isValidateOnChange) {
                    if (value.isEmpty) {
                      controller.errorNamaPIC.value = true;
                    } else {
                      controller.errorNamaPIC.value = false;
                    }
                  }
                }, controller.namaPICTextEditingController,
                    "LocationManagementLabelPICName".tr,
                    maxLength: 64),
                controller.errorNamaPIC.value && controller.isValidateOnChange
                    ? _errorText(
                        "LocationManagementLabelValidatorEmptyPICName".tr)
                    : Container(),
                _separator(),
                _textFormField("LocationManagementLabelPICPhoneNumber".tr,
                    (String value) {
                  controller.errorMessageNoTelpPic.value =
                      PhoneNumberValidator.validate(
                          value: value, isMustZeroFirst: false);
                  controller.errorNoTelpPIC.value =
                      controller.errorMessageNoTelpPic.value != null;
                  return controller.errorMessageNoTelpPic.value;
                }, (String value) {
                  if (controller.isValidateOnChange) {
                    controller.errorMessageNoTelpPic.value =
                        PhoneNumberValidator.validate(
                            value: value, isMustZeroFirst: false);
                    controller.errorNoTelpPIC.value =
                        controller.errorMessageNoTelpPic.value != null;
                  }
                }, controller.noTelpPICTextEditingController,
                    "LocationManagementLabelPICPhoneNumberHint".tr,
                    isPhoneNumber: true, maxLength: 16),
                controller.errorNoTelpPIC.value && controller.isValidateOnChange
                    ? _errorText(controller.errorMessageNoTelpPic.value)
                    : Container(),
              ]),
        ),
      ),
    );
  }

  Widget _separator() {
    return SizedBox(
      height: GlobalVariable.ratioHeight(Get.context) * 20,
    );
  }

  Widget _itemWithoutTextField(
      {@required String title, @required String value}) {
    var edit =
        controller.typeEdit == TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title + "*",
          fontWeight: FontWeight.w700,
          fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
          color: Color(ListColor.colorGrey3)
            // fontSize: 14,
            // color: Color(ListColor.colorGrey3),
            // fontWeight: FontWeight.w700
            ),
        SizedBox(
          height:  GlobalVariable.ratioHeight(Get.context) * 8, //5
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: edit ? 0 : 16, vertical: edit ? 0 : 13),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: edit
                    ? Colors.transparent
                    : Color(ListColor.colorLightGrey15)),
            borderRadius: BorderRadius.circular(6),
            color: edit ? Colors.transparent : Color(0xFFE9E9E9),
          ),
          child: CustomText(
            value.isEmpty ? title : value,
            fontSize: 14,
            color: edit
                ? Color(ListColor.colorBlack)
                : Color(value.isEmpty
                    ? ListColor.colorLightGrey2
                    : ListColor.colorLightGrey4),
            fontWeight: FontWeight.w600,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  TextStyle _textStyleTitle({Color textColor}) {
    textColor = textColor == null ? Color(ListColor.colorGrey3) : textColor;
    return TextStyle(
        fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
        color: textColor,
        fontWeight: FontWeight.w700);
  }

  Widget _textFormField(String title, Function validator, Function onChanged,
      TextEditingController textEditingController, String hintText,
      {int maxLength,
      bool isPhoneNumber = false,
      bool isNumber = false,
      Widget prefixIcon,
      bool isEnable = true,
      double textSize = 14,
      bool isMultiLine = false,
      int minLines = 2,
      int maxLines = 6,
      bool removeZeroFront = true}) {
    return TextFormFieldWidget(
      isCustomTitle: true,
      titleWidget: Text.rich(TextSpan(children: [
        TextSpan(text: title, style: _textStyleTitle()),
        TextSpan(text: "*", style: _textStyleTitle())
      ])),
      enableBorderColor: Color(ListColor.colorLightGrey15),
      disableBorderColor: Color(ListColor.colorLightGrey15),
      isEnable: isEnable,
      maxLength: maxLength,
      isMultiLine: isMultiLine,
      minLines: minLines,
      maxLines: maxLines,
      isShowError: false,
      validator: validator,
      onChanged: onChanged,
      width: _widthContent(Get.context),
      removeZeroFront: removeZeroFront,
      isPassword: false,
      isDense: true,
      isCollapse: true,
      isEmail: false,
      isNumber: isNumber,
      isPhoneNumber: isPhoneNumber,
      isShowCodePhoneNumber: false,
      textEditingController: textEditingController,
      isShort: false,
      titleColor: Color(ListColor.colorLightGrey14),
      errorColor: Color(ListColor.colorRed),
      focusedBorderColor: Color(ListColor.color4),
      fillColor: Colors.white,
      hintTextStyle: TextStyle(
          color: Color(ListColor.colorLightGrey2), fontWeight: FontWeight.w600),
      hintText: hintText,
      contentTextStyle: TextStyle(
          height: 1.2,
          fontSize: textSize,
          color: Color(ListColor.colorLightGrey4),
          fontWeight: FontWeight.w600),
      prefixIcon: prefixIcon,
      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
          color: Color(ListColor.colorGrey3)),
      textSize: 14,
      marginBottom: 0,
    );
  }

  Widget _errorText(String text) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: CustomText(
        text,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
        color: Color(ListColor.colorRed),
      ),
    );
  }

  Widget _buildMap() {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController.value,
        options: MapOptions(
          interactiveFlags: InteractiveFlag.none,
          center: controller.latLng == null
              ? GlobalVariable.centerMap
              : controller.latLng,
          zoom: GlobalVariable.zoomMap,
          minZoom: GlobalVariable.zoomMap,
          maxZoom: GlobalVariable.zoomMap,
        ),
        layers: [
          GlobalVariable.tileLayerOptions,
          MarkerLayerOptions(markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: controller.latLng,
              anchorPos: AnchorPos.align(AnchorAlign.top),
              builder: (ctx) => SvgPicture.asset(
                "assets/pin_truck_icon.svg",
                width: 14,
                height: 35,
              ),
            ),
          ])
        ],
      ),
    );
  }

  Widget _deleteButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(width: 1, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        controller.onDeleteButton();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Stack(alignment: Alignment.center, children: [
          CustomText("LocationManagementLabelButtonRemove".tr,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(ListColor.color4)),
        ]),
      ),
    );
  }

  Widget _saveButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Color(ListColor.color4),
          side: BorderSide(width: 1, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        controller.onSaveButton();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Stack(alignment: Alignment.center, children: [
          CustomText("LocationManagementLabelButtonSave".tr,
              fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),
        ]),
      ),
    );
  }
}
