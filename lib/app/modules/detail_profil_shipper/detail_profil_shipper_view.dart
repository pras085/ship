import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/onchange_textfield_number.dart';
import 'package:muatmuat/app/core/function/onchange_textfield_phone_number.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_as_enum.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_custom1.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/search_choices_dropdown_underline.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:share/share.dart';

import 'detail_profil_shipper_controller.dart';

class DetailProfilShipperView extends GetView<DetailProfilShipperController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );
  double _fontSizeLabel = 12;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return Scaffold(
      backgroundColor: Color(ListColor.color4),
      appBar: AppBarCustom1(
        title: 'ProfileShipperLabelProfil'.tr,
        preferredSize: Size.fromHeight(_appBar.preferredSize.height),
      ),

      // AppBar(
      //   titleSpacing: 0,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   backgroundColor: Color(ListColor.color4),
      //   title: Obx(
      //     () => Stack(
      //       children: [
      //         Positioned(
      //           top: -10,
      //           right: -10,
      //           child: Image(
      //             image: AssetImage("assets/fallin_star_3_icon.png"),
      //             height: 50,
      //             fit: BoxFit.fitHeight,
      //           ),
      //         ),
      //         controller.isEditMode.value
      //             ? _appBarEditModeOn()
      //             : _appBarEditModeOff()
      //       ],
      //     ),
      //   ),
      // ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 18),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      print("test");
                    },
                    child: Stack(alignment: Alignment.bottomRight, children: [
                      Obx(
                        () => Material(
                            shape: CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.chooseImage();
                              },
                              child: controller.selectedImage.value.isNull
                                  ? controller.profileShipperModel.value
                                              .avatar ==
                                          null
                                      ? Ink.image(
                                          image: AssetImage(
                                              "assets/gambar_example.jpeg"),
                                          fit: BoxFit.cover,
                                          width: 130,
                                          height: 130,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: GlobalVariable.urlImage +
                                              controller.profileShipperModel
                                                  .value.avatar,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 130,
                                            height: 130,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                        )
                                  : Image(
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          controller.selectedImage.value)),
                            )),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(ListColor.colorGrey),
                          ),
                          child:
                              Icon(Icons.create_rounded, color: Colors.white))
                    ]),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: CustomText(GlobalVariable.userModelGlobal.name,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(ListColor.colorDarkGrey3)),
                ),
                SizedBox(height: 5),
                Center(
                  child: CustomText(GlobalVariable.userModelGlobal.email,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(ListColor.colorDarkGrey3)),
                ),
                Center(
                  child: CustomText(
                      controller.profileShipperModel.value.city +
                          ", " +
                          controller.profileShipperModel.value.province,
                      fontSize: 10,
                      color: Color(ListColor.colorDarkGrey3)),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          width: 0.3, color: Color(ListColor.colorLightGrey5))),
                  child: Obx(
                    () => Form(
                      key: controller.formKey.value,
                      onChanged: () {
                        print("onchange");
                        controller.validateAll();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      color: controller
                                              .profileShipperModel.value.isVerif
                                          ? Color(ListColor.colorLightGreen)
                                          : Color(ListColor.colorBrightRed2)),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        controller.profileShipperModel.value
                                                .isVerif
                                            ? Icon(
                                                Icons.check,
                                                color:
                                                    Color(ListColor.colorGreen),
                                                size: 16,
                                              )
                                            : Icon(
                                                Icons.close_rounded,
                                                color:
                                                    Color(ListColor.colorRed),
                                                size: 16,
                                              ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                            controller.profileShipperModel.value
                                                    .isVerif
                                                ? "ProfileShipperLabelVerified"
                                                    .tr
                                                : "ProfileShipperLabelNotVerified"
                                                    .tr,
                                            color: controller
                                                    .profileShipperModel
                                                    .value
                                                    .isVerif
                                                ? Color(ListColor.colorGreen)
                                                : Color(ListColor.colorRed),
                                            fontWeight: FontWeight.w600),
                                      ]),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Color(ListColor.color4)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Material(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        onTap: () {},
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: CustomText(
                                                "ProfileShipperLabelVerify".tr,
                                                color: Color(ListColor.color4),
                                                fontWeight: FontWeight.w600)),
                                      )),
                                ),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(Get.context).size.width,
                            height: 0.5,
                            color: Color(ListColor.colorLightGrey5)
                                .withOpacity(0.29),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _textFormField(
                            "ProfileShipperLabelFullName".tr,
                            controller.profileShipperModel.value.username,
                            focusNode: controller.fullNameFocusNode.value,
                            textEditingController:
                                controller.fullNameController.value,
                            enabled: true,
                          ),
                          _textFormField("ProfileShipperLabelCode".tr,
                              controller.profileShipperModel.value.code,
                              fontWeightValue: FontWeight.w700,
                              isShowShareButton: true, onTapShare: () {
                            Share.share(
                                controller.profileShipperModel.value.code);
                          }),
                          _textFormField(
                              "ProfileShipperLabelType".tr,
                              controller
                                  .profileShipperModel.value.profileAndType),
                          _textFormField("ProfileShipperLabelRole".tr, "-"),
                          _textFormField("ProfileShipperLabelEmail".tr,
                              controller.profileShipperModel.value.email),
                          _textFormField("ProfileShipperLabelPhone".tr,
                              controller.profileShipperModel.value.phone),
                          _textFormField(
                              "ProfileShipperLabelWhatsapp".tr, "12123",
                              enabled: true,
                              focusNode:
                                  controller.numberWhatssappFocusNode.value,
                              textEditingController:
                                  controller.numberWhatssappController.value,
                              isPhoneNumber: true),
                          _textFormField("ProfileShipperLabelShopName".tr,
                              controller.profileShipperModel.value.shopName,
                              enabled: true,
                              focusNode: controller.shopNameFocusNode.value,
                              textEditingController:
                                  controller.shopNameController.value),
                          Stack(children: [
                            Container(
                              key: controller.globalKeyContainerAddress,
                              child: _textFormField(
                                  "ProfileShipperLabelAddress".tr,
                                  controller.addressController.value.text,
                                  isForceShowPencilIcon: true),
                            ),
                            GestureDetector(
                                onTap: () {
                                  controller.onClickAddress();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: controller.widthAddressContainer,
                                  height: controller.heightAddressContainer,
                                ))
                          ]),
                          // _getSearchableDropdown(
                          //     'ShipperRegisterLabelProvince'.tr,
                          //     controller.listProvince
                          //         .map((data) => DropdownMenuItem(
                          //               value: data.descriptionID,
                          //               child: Text(data.descriptionID),
                          //             ))
                          //         .toList(),
                          //     controller.province.value, (value) {
                          //   controller.setProvince(value);
                          // }, ""),
                          GestureDetector(
                            onTap: () {
                              controller.onClickProvince();
                            },
                            child: _textFormField(
                                'ShipperRegisterLabelProvince'.tr,
                                controller.province.value,
                                isForceShowPencilIcon: true),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.onClickCity();
                            },
                            child: _textFormField('ShipperRegisterLabelCity'.tr,
                                controller.city.value,
                                isForceShowPencilIcon: true),
                          ),
                          _textFormField("ProfileShipperLabelPostalCode".tr,
                              controller.profileShipperModel.value.postalCode,
                              enabled: true,
                              focusNode: controller.postalCodeFocusNode.value,
                              textEditingController:
                                  controller.postalCodeController.value,
                              isNumber: true),
                          // _getSearchableDropdown(
                          //     'ProfileShipperLabelCategoryCapacity'.tr,
                          //     controller.listCategoryCapacity
                          //         .map((data) => DropdownMenuItem(
                          //               value: data.descriptionID,
                          //               child: Text(data.descriptionID),
                          //             ))
                          //         .toList(),
                          //     controller.categoryCapacity.value, (value) {
                          //   controller.setCategoryCapacity(value);
                          // }, ""),
                          controller.profileShipperModel.value.profileAccount ==
                                  ShipperBuyerRegisterAs.SHIPPER
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.onClickCategoryCapacity();
                                      },
                                      child: _textFormField(
                                          'ProfileShipperLabelCategoryCapacity'
                                              .tr,
                                          controller.categoryCapacity.value,
                                          isForceShowPencilIcon: true),
                                    ),
                                    _textFormField(
                                        "ProfileShipperLabelCapacityAverage".tr,
                                        controller.profileShipperModel.value
                                            .categoryCapacity,
                                        textEditingController: controller
                                            .averageCapacityController.value,
                                        focusNode: controller
                                            .averageCapacityFocusNode.value,
                                        enabled: true,
                                        isNumber: true),
                                  ],
                                )
                              : SizedBox.shrink(),

                          _textFormField(
                              "ProfileShipperLabelNumberID".tr,
                              controller.profileShipperModel.value.noKTP == ""
                                  ? "ProfileShipperLabelNoData".tr
                                  : controller.profileShipperModel.value.noKTP),
                          _textFormField("ProfileShipperLabelFileID".tr,
                              "ProfileShipperLabelNoData".tr),
                          _textFormField(
                              "ProfileShipperLabelNumberNPWP".tr,
                              controller.profileShipperModel.value.noNPWP == ""
                                  ? "ProfileShipperLabelNoData".tr
                                  : controller
                                      .profileShipperModel.value.noNPWP),
                          _textFormField("ProfileShipperLabelFileNPWP".tr,
                              "ProfileShipperLabelNoData".tr,
                              isShowUnderline: false),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, -5),
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Center(
                child: Obx(
                  () => Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller.isShowSaveButton.value
                              ? Color(ListColor.color4)
                              : Color(ListColor.colorLightGrey2)),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: controller.isShowSaveButton.value
                                ? () {
                                    controller.saveButton();
                                  }
                                : null,
                            child: Center(
                                child: CustomText('ProfileShipperLabelSave'.tr,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                      )),
                ),
              ))
        ]),
      ),
    );
  }

  Widget _appBarEditModeOn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _backButtonWidget(),
          SizedBox(
            width: 10,
          ),
          Expanded(child: _titleProfileWidget()),
          SizedBox(
            width: 10,
          ),
          _saveButtonWidget(),
        ],
      ),
    );
  }

  Widget _appBarEditModeOff() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(alignment: Alignment.centerLeft, child: _backButtonWidget()),
          Align(alignment: Alignment.center, child: _titleProfileWidget())
        ],
      ),
    );
  }

  Widget _titleProfileWidget() {
    return CustomText('ProfileShipperLabelProfil'.tr,
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14);
  }

  Widget _backButtonWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: ClipOval(
          child: Material(
              shape: CircleBorder(),
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30 * 0.7,
                        color: Color(ListColor.color4),
                      ))))),
        ),
      ),
    );
  }

  Widget _saveButtonWidget() {
    return Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Center(
                  child: CustomText('ProfileShipperLabelSave'.tr,
                      color: Color(ListColor.color4),
                      fontWeight: FontWeight.w800))),
        ));
  }

  Widget _textFormField(String label, String initialValue,
      {FontWeight fontWeightValue = FontWeight.w600,
      bool enabled = false,
      TextEditingController textEditingController,
      FocusNode focusNode,
      bool isShowVerifyButton = false,
      bool isShowShareButton = false,
      bool isShowStatusVerify = false,
      bool isStatusVerify = false,
      bool isShowUnderline = true,
      bool isNumber = false,
      bool isPhoneNumber = false,
      bool isForceShowPencilIcon = false,
      void Function() onTapVerify,
      void Function() onTapShare,
      int maxLength}) {
    double fontSizeLabelRight = 12;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: enabled
          ? Stack(alignment: Alignment.centerRight, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomText(label,
                    fontSize: _fontSizeLabel,
                    fontWeight: FontWeight.w500,
                    color: focusNode == null
                        ? Color(ListColor.colorGrey3)
                        : focusNode.hasFocus
                            ? Color(ListColor.color4)
                            : Color(ListColor.colorGrey3)),
                TextFormField(
                  inputFormatters: maxLength == null
                      ? null
                      : [LengthLimitingTextInputFormatter(maxLength)],
                  focusNode: focusNode,
                  controller: textEditingController,
                  onChanged: (value) {
                    if (isNumber) {
                      OnChangeTextFieldNumber.checkNumber(
                          () => textEditingController, value, true);
                    } else if (isPhoneNumber) {
                      OnChangeTextFieldPhoneNumber.checkPhoneNumber(
                          () => textEditingController, value);
                    }
                  },
                  initialValue:
                      textEditingController == null ? initialValue : null,
                  enabled: enabled,
                  keyboardType: isNumber
                      ? TextInputType.number
                      : (isPhoneNumber
                          ? TextInputType.phone
                          : TextInputType.name),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: fontWeightValue,
                      color: Color(ListColor.colorDarkGrey4)),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      // labelText: label,
                      // labelStyle: TextStyle(
                      //     fontSize: fontSizeLabel,
                      //     fontWeight: FontWeight.w500,
                      //     color: focusNode == null
                      //         ? Color(ListColor.colorGrey3)
                      //         : focusNode.hasFocus
                      //             ? Color(ListColor.color4)
                      //             : Color(ListColor.colorGrey3)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5, color: Color(ListColor.color4))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: Color(ListColor.colorLightGrey5)
                                  .withOpacity(0.29)))),
                ),
              ]),
              (enabled || isForceShowPencilIcon
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          focusNode.requestFocus();
                        },
                        child: Icon(Icons.create_rounded,
                            color: Color(ListColor.colorDarkGrey3), size: 18),
                      ))
                  : SizedBox.shrink()),
            ])
          : Stack(alignment: Alignment.centerRight, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(label,
                          fontSize: _fontSizeLabel,
                          fontWeight: FontWeight.w500,
                          color: Color(ListColor.colorGrey3)),
                      SizedBox(width: 10),
                      isShowStatusVerify
                          ? Container(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                decoration: BoxDecoration(
                                    color: isStatusVerify
                                        ? Color(ListColor.colorLightGreen)
                                        : Color(ListColor.colorRed)
                                            .withOpacity(0.2)),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isStatusVerify
                                          ? Icon(
                                              Icons.check,
                                              color:
                                                  Color(ListColor.colorGreen),
                                              size: 12,
                                            )
                                          : Icon(
                                              Icons.close_rounded,
                                              color: Color(ListColor.colorRed),
                                              size: 12,
                                            ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CustomText(
                                          isStatusVerify
                                              ? "ProfileShipperLabelVerified".tr
                                              : "ProfileShipperLabelNotVerified"
                                                  .tr,
                                          fontSize: 10,
                                          color: isStatusVerify
                                              ? Color(ListColor.colorGreen)
                                              : Color(ListColor.colorRed),
                                          fontWeight: FontWeight.w600),
                                    ]),
                              ),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: CustomText(initialValue,
                            fontSize: 14,
                            fontWeight: fontWeightValue,
                            color: Color(ListColor.colorDarkGrey4)),
                      ),
                      (isForceShowPencilIcon
                          ? Row(mainAxisSize: MainAxisSize.min, children: [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.create_rounded,
                                  color: Color(ListColor.colorDarkGrey3),
                                  size: 18)
                            ])
                          : SizedBox.shrink()),
                      isShowVerifyButton || isShowShareButton
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: isShowVerifyButton
                                        ? onTapVerify
                                        : onTapShare,
                                    child: CustomText(
                                        isStatusVerify
                                            ? "ProfileShipperLabelChange".tr
                                            : isShowVerifyButton
                                                ? "ProfileShipperLabelVerifyNow"
                                                    .tr
                                                : "ProfileShipperLabelShare".tr,
                                        fontSize: fontSizeLabelRight,
                                        color: Color(ListColor.color4),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(Get.context).size.width,
                    height: 0.5,
                    color: isShowUnderline
                        ? Color(ListColor.colorLightGrey5).withOpacity(0.29)
                        : Colors.transparent,
                  )
                ],
              ),
            ]),
    );
  }

  Widget _getSearchableDropdown(
      String title,
      List<DropdownMenuItem<dynamic>> items,
      String value,
      Function onChange,
      String errorMessage,
      {bool readOnly = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(title,
              fontSize: _fontSizeLabel,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorGrey3)),
          SearchChoices.single(
            items: items,
            value: value,
            onChanged: onChange,
            isExpanded: true,
            readOnly: readOnly,
            dialogBox: true,
            displayClearIcon: false,
            style: TextStyle(
                fontFamily: 'AvenirNext',
                fontSize: 14,
                color: Color(ListColor.colorDarkGrey4),
                fontWeight: FontWeight.w600),
            //menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
          ),
          errorMessage != ""
              ? Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  child: CustomText(
                    errorMessage,
                    color: Colors.red,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
