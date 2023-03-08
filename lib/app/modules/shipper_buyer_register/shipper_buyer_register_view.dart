import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/validator/phoine_number_validator.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_as_enum.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_controller.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_type_account_enum.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/search_choices_dropdown.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:muatmuat/global_variable.dart';

class ShipperBuyerRegisterView extends GetView<ShipperBuyerRegisterController> {
  double _widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 20;
  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _heightAppBar = AppBar().preferredSize.height + 30;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_heightAppBar),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: _getWidthOfScreen(context),
              decoration: BoxDecoration(
                  //   boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                  color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: ClipOval(
                      child: Material(
                          shape: CircleBorder(),
                          color: Color(ListColor.color4),
                          child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  width: _heightAppBar * 1.7 / 4,
                                  height: _heightAppBar * 1.7 / 4,
                                  child: Center(
                                      child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: (_heightAppBar * 1.7 / 4) * 0.7,
                                    color: Colors.white,
                                  ))))),
                    ),
                  ),
                  SizedBox(width: 13),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          'ShipperRegisterLabelTitle'.tr,
                          color: Color(ListColor.color4),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                        CustomText(
                          'ShipperRegisterLabelShipperBuyer'.tr,
                          color: Color(ListColor.color4),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ]),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Obx(
                  () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'ShipperRegisterLabelTypeOfAccount'.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        // _getRadioTypeOfAccount(
                        //     "Individu", ShipperBuyerRegisterTypeAccount.INDIVIDU),
                        // _getRadioTypeOfAccount("Perusahaan",
                        //     ShipperBuyerRegisterTypeAccount.PERUSAHAAN),
                        SizedBox(
                          height: 10,
                        ),
                        _getListRegisterAsTypeOfAccount(
                            'ShipperRegisterLabelIndividual'.tr,
                            "individual_icon.svg",
                            controller.typeOfAccountValue.value ==
                                ShipperBuyerRegisterTypeAccount.INDIVIDU, () {
                          controller.setChangeTypeOfAccount(
                              ShipperBuyerRegisterTypeAccount.INDIVIDU);
                        }),
                        _getListRegisterAsTypeOfAccount(
                            'ShipperRegisterLabelCompany'.tr,
                            "company_icon.svg",
                            controller.typeOfAccountValue.value ==
                                ShipperBuyerRegisterTypeAccount.PERUSAHAAN, () {
                          controller.setChangeTypeOfAccount(
                              ShipperBuyerRegisterTypeAccount.PERUSAHAAN);
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'ShipperRegisterLabelYouAre'.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _getListRegisterAsTypeOfAccount(
                            'ShipperRegisterLabelBuyer'.tr,
                            "buyer_icon.svg",
                            controller.registerAsValue.value ==
                                ShipperBuyerRegisterAs.BUYER, () {
                          controller.setChangeRegisterAs(
                              ShipperBuyerRegisterAs.BUYER);
                        }),
                        _getListRegisterAsTypeOfAccount(
                            'ShipperRegisterLabelShipper'.tr,
                            "shipper_icon.svg",
                            controller.registerAsValue.value ==
                                ShipperBuyerRegisterAs.SHIPPER, () {
                          controller.setChangeRegisterAs(
                              ShipperBuyerRegisterAs.SHIPPER);
                        }),
                        // _getRadioRegisterAs(
                        //     "Pembeli", ShipperBuyerRegisterAs.BUYER),
                        // _getRadioRegisterAs(
                        //     "Pengirim Barang", ShipperBuyerRegisterAs.SHIPPER),
                        SizedBox(
                          height: 20,
                        ),
                        _listTextFormWidget(context),
                      ]),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Obx(() => _panelEndForm(context)))
            ]),
          ),
        ),
      ),
    );
  }

  Widget _getRadioTypeOfAccount(
      String title, ShipperBuyerRegisterTypeAccount value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: controller.typeOfAccountValue.value,
          onChanged: (value) {
            controller.setChangeTypeOfAccount(value);
          },
        ),
        CustomText(title),
      ],
    );
  }

  Widget _getRadioRegisterAs(String title, ShipperBuyerRegisterAs value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: controller.registerAsValue.value,
          onChanged: (value) {
            controller.setChangeRegisterAs(value);
          },
        ),
        CustomText(title),
      ],
    );
  }

  Widget _getListRegisterAsTypeOfAccount(
      String title, String urlIcon, bool isChecked, void Function() onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                "assets/" + urlIcon,
                color: Colors.black,
              ),
              SizedBox(width: 29),
              Expanded(
                  child: CustomText(title,
                      fontWeight: isChecked ? FontWeight.w700 : FontWeight.w600,
                      color: Color(isChecked
                          ? ListColor.color4
                          : ListColor.colorLightGrey4))), // colorGrey)))),
              isChecked
                  ? Icon(Icons.check, color: Color(ListColor.color4))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTextFormWidget(BuildContext context) {
    return Form(
      key: controller.formKey.value,
      onChanged: () {
        if (controller.isValidateOnChange.value) controller.validateAll();
        print("onchange");
      },
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextFormFieldWidget(
            //   title: 'Nama Usaha / Alias / Nama Toko',
            //   validator: (String value) {
            //     if (value.isEmpty) return '* ' + 'Harus diisi';
            //     return null;
            //   },
            //   width: _widthContent(context),
            //   isPassword: false,
            //   isEmail: false,
            //   isPhoneNumber: false,
            //   textEditingController: controller.companyName.value,
            //   isShort: false,
            //   titleColor: Color(ListColor.colorBlack),
            //   errorColor: Colors.red,
            // ),
            _textFormField(
                controller.typeOfAccountValue.value ==
                        ShipperBuyerRegisterTypeAccount.INDIVIDU
                    ? 'ShipperRegisterLabelCompanyName'.tr
                    : "ShipperRegisterLabelCompanyNameCompanyUser".tr,
                (String value) {
              if (value.isEmpty)
                return '* ' +
                    (controller.typeOfAccountValue.value ==
                            ShipperBuyerRegisterTypeAccount.INDIVIDU
                        ? 'ShipperRegisterLabelValidatorCompanyName'.tr
                        : "ShipperRegisterLabelValidatorCompanyNameCompanyUser"
                            .tr);
              return null;
            },
                controller.companyName.value,
                controller.typeOfAccountValue.value ==
                        ShipperBuyerRegisterTypeAccount.INDIVIDU
                    ? 'ShipperRegisterLabelHintCompanyName'.tr
                    : "ShipperRegisterLabelHintCompanyNameCompanyUser".tr,
                false,
                false),
            controller.typeOfAccountValue.value ==
                    ShipperBuyerRegisterTypeAccount.PERUSAHAAN
                ? _typeCompanyWidget(context)
                : Container(),
            Stack(children: [
              Container(
                key: controller.globalKeyContainerAddress,
                child: _textFormField('ShipperRegisterLabelAddress'.tr,
                    (String value) {
                  if (value.isEmpty)
                    return '* ' + 'ShipperRegisterLabelValidatorAddress'.tr;
                  return null;
                }, controller.address.value,
                    'ShipperRegisterLabelHintAddress'.tr, true, false,
                    isShowCursor: false, isReadOnly: true),
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
            _getSearchableDropdown(
                'ShipperRegisterLabelProvince'.tr,
                controller.listProvince
                    .map((data) => DropdownMenuItem(
                          value: data.descriptionID,
                          child: CustomText(data.descriptionID),
                        ))
                    .toList(),
                controller.province.value, (value) {
              controller.setProvince(value);
            }, controller.errorProvince,
                isUseValidator: controller.isValidateOnChange.value,
                errorValidator: controller.defaultProvince),
            _getSearchableDropdown(
                'ShipperRegisterLabelCity'.tr,
                controller.listCity
                    .map((data) => DropdownMenuItem(
                          value: data.city,
                          child: CustomText(data.city),
                        ))
                    .toList(),
                controller.city.value, (value) {
              controller.setCity(value);
            }, controller.errorCity,
                readOnly: controller.isReadOnlyCity.value,
                isUseValidator: controller.isValidateOnChange.value,
                errorValidator: controller.defaultCity),
            _textFormField('ShipperRegisterLabelPostalCode'.tr, (String value) {
              if (value.isEmpty) {
                return '* ' + 'ShipperRegisterLabelValidatorPostalCode'.tr;
              } else if (value.length < 5) {
                return '* ' + 'ShipperRegisterLabelValidatorPostalCodeLess'.tr;
              }
              return null;
            }, controller.postalCode.value,
                'ShipperRegisterLabelHintPostalCode'.tr, false, true,
                maxLength: 5),
            // controller.registerAsValue.value == ShipperBuyerRegisterAs.SHIPPER
            //     ?
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getSearchableDropdown(
                    'ShipperRegisterLabelCategoryCapacity'.tr,
                    controller.listCategoryCapacity
                        .map((data) => DropdownMenuItem(
                              value: data.descriptionID,
                              child: CustomText(data.descriptionID),
                            ))
                        .toList(),
                    controller.categoryCapacity.value, (value) {
                  controller.setCategoryCapacity(value);
                }, controller.errorCategoryCapacity,
                    isUseValidator: controller.isValidateOnChange.value,
                    errorValidator: controller.defaultCategoryCapacity),
                _textFormField('ShipperRegisterLabelAverageCapacity'.tr,
                    (String value) {
                  return controller.validatorMessageAverageCapacity(value);
                }, controller.capacityEachDay.value,
                    'ShipperRegisterLabelHintAverageCapacity'.tr, false, true,
                    maxLength: 4),
              ],
            ),
            // : SizedBox.shrink(),

            // controller.typeOfAccountValue.value ==
            //         ShipperBuyerRegisterTypeAccount.PERUSAHAAN
            //     ? _PICWidget(context)
            //     : SizedBox.shrink(),
          ]),
    );
  }

  Widget _panelEndForm(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 16),
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    CheckBoxCustom(
                      // size: 15,
                      // shadowSize: 19,
                      // isWithShadow: true,
                      onChanged: (value) {
                        controller.onCheckedChangedTermsCondition(value);
                      },
                      value: controller.isCheckedTermsCondition.value,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomText(
                        'Dengan mendaftar sebagai shipper saya menyetujui syarat dan ketentuan yang berlaku',
                        // overflow: TextOverflow.ellipsis,
                        fontSize: 12, color: Color(ListColor.colorBlack),
                      ),
                    ),
                  ]))),
          controller.isValidateOnChange.value &&
                  !controller.isCheckedTermsCondition.value
              ? Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0, 10.0, 0),
                  child: CustomText(
                      'Anda harus menyetujui syarat dan ketentuan terlebih dahulu',
                      textAlign: TextAlign.center,
                      color: Colors.red,
                      fontSize: 14))
              : SizedBox.shrink(),
          // Container(
          //     margin: EdgeInsets.symmetric(vertical: 10),
          //     width: MediaQuery.of(context).size.width,
          //     child: InkWell(
          //         onTap: () {
          //           controller.showPrivacyPolicy();
          //         },
          //         child: Center(
          //             child: CustomText('Lihat Syarat dan Ketentuan',
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.w600,
          //                 color: Color(ListColor.color4))))),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 2 / 3,
                child: MaterialButton(
                  onPressed: () {
                    controller.onSaving();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  color: Color(ListColor.color4),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CustomText('ShipperRegisterLabelButtonSave'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ]);
  }

  Widget _typeCompanyWidget(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSearchableDropdown(
              'ShipperRegisterLabelBusinessEntity'.tr,
              controller.listBusinessEntity
                  .map((data) => DropdownMenuItem(
                        value: data.showText,
                        child: CustomText(data.showText),
                      ))
                  .toList(),
              controller.businessEntity.value, (value) {
            controller.setBusinessEntity(value);
          }, controller.errorBusinessEntity,
              isUseValidator: controller.isValidateOnChange.value,
              errorValidator: controller.defaultBusinessEntity),
          // _getSearchableDropdown(
          //     'ShipperRegisterLabelBusinessFields'.tr,
          //     controller.listBusinessField
          //         .map((data) => DropdownMenuItem(
          //               value: data.showText,
          //               child: Text(data.showText),
          //             ))
          //         .toList(),
          //     controller.businessField.value, (value) {
          //   controller.setBusinessField(value);
          // }, controller.errorBusinessField.value),
        ]);
  }

  Widget _PICWidget(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textFormField('ShipperRegisterLabelPicName1'.tr, (String value) {
            if (value.isEmpty)
              return '* ' + 'ShipperRegisterLabelValidatorPicName1'.tr;
            return null;
          }, controller.picName1.value, 'ShipperRegisterLabelHintPicName1'.tr,
              false, false),
          _textFormField('ShipperRegisterLabelPicPhoneNumber1'.tr,
              (String value) {
            return PhoneNumberValidator.validate(
                value: value,
                warningIfEmpty:
                    '* ' + 'ShipperRegisterLabelValidatorPicPhoneNumber1'.tr,
                warningIfFormatNotMatch: "* " +
                    "ShipperRegisterLabelValidatorPicPhoneNumber1FalseFormat"
                        .tr);
          }, controller.picPhoneNumber1.value,
              'ShipperRegisterLabelHintPicPhoneNumber1'.tr, false, true,
              isPhoneNumber: true),
          _textFormField('ShipperRegisterLabelPicName2'.tr, (String value) {
            return null;
          }, controller.picName2.value, 'ShipperRegisterLabelHintPicName2'.tr,
              false, false),
          _textFormField('ShipperRegisterLabelPicPhoneNumber2'.tr,
              (String value) {
            if (value.isNotEmpty) {
              return PhoneNumberValidator.validate(
                  value: value,
                  warningIfEmpty:
                      '* ' + 'ShipperRegisterLabelValidatorPicPhoneNumber2'.tr,
                  warningIfFormatNotMatch: "* " +
                      "ShipperRegisterLabelValidatorPicPhoneNumber2FalseFormat"
                          .tr);
            }
            return null;
          }, controller.picPhoneNumber2.value,
              'ShipperRegisterLabelHintPicPhoneNumber2'.tr, false, true,
              isPhoneNumber: true),
          _textFormField('ShipperRegisterLabelPicName3'.tr, (String value) {
            return null;
          }, controller.picName3.value, 'ShipperRegisterLabelHintPicName3'.tr,
              false, false),
          _textFormField('ShipperRegisterLabelPicPhoneNumber3'.tr,
              (String value) {
            if (value.isNotEmpty) {
              return PhoneNumberValidator.validate(
                  value: value,
                  warningIfEmpty:
                      '* ' + 'ShipperRegisterLabelValidatorPicPhoneNumber3'.tr,
                  warningIfFormatNotMatch: "* " +
                      "ShipperRegisterLabelValidatorPicPhoneNumber3FalseFormat"
                          .tr);
            }
            return null;
          }, controller.picPhoneNumber3.value,
              'ShipperRegisterLabelHintPicPhoneNumber3'.tr, false, true,
              isPhoneNumber: true),
        ]);
  }

  Widget _getSearchableDropdown(
      String title,
      List<DropdownMenuItem<dynamic>> items,
      String value,
      Function onChange,
      String errorMessage,
      {bool readOnly = false,
      bool isUseValidator = false,
      String errorValidator = ""}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(title, color: Colors.black, fontWeight: FontWeight.w700),
          SizedBox(
            height: 5,
          ),
          SearchChoices.single(
            items: items,
            value: value,
            onChanged: onChange,
            isExpanded: true,
            readOnly: readOnly,
            dialogBox: true,
            displayClearIcon: false,
            validator: (selectedItem) {
              if (isUseValidator && selectedItem == errorValidator)
                return '* ' + errorMessage;
              return null;
            },
            style: TextStyle(
                fontFamily: 'AvenirNext',
                fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
                color: Color(ListColor.colorLightGrey4),
                fontWeight: FontWeight.w600),
            //menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
          ),
          // errorMessage != "" && !isUseValidator
          //     ? Container(
          //         margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          //         child: Text(errorMessage,
          //             style: TextStyle(color: Colors.red, fontSize: 14)),
          //       )
          //     : Container(),
        ],
      ),
    );
  }

  Widget _textFormField(
      String title,
      Function validator,
      TextEditingController textEditingController,
      String hintText,
      bool isMultiline,
      bool isNumber,
      {int maxLength,
      bool isEnable = true,
      bool isReadOnly = false,
      bool isShowCursor,
      bool isPhoneNumber = false}) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextFormFieldWidget(
          isReadOnly: isReadOnly,
          isShowCursor: isShowCursor,
          isEnable: isEnable,
          maxLength: maxLength,
          title: title,
          validator: validator,
          width: _widthContent(Get.context),
          isEmail: false,
          isPhoneNumber: false,
          isNumber: isNumber,
          textEditingController: textEditingController,
          isShort: false,
          titleColor: Color(ListColor.colorBlack),
          errorColor: Colors.red,
          focusedBorderColor: Color(ListColor.color4),
          fillColor: Color(ListColor.colorLightGrey3),
          hintTextStyle: TextStyle(
              color: Color(ListColor.colorLightGrey2),
              fontWeight: FontWeight.w600),
          hintText: hintText,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
          contentTextStyle: TextStyle(
              fontSize: 14,
              color: Color(ListColor.colorLightGrey4),
              fontWeight: FontWeight.w600),
          isMultiLine: isMultiline,
        ));
  }
}
