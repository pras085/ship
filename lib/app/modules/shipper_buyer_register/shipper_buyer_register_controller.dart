import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/tac_pap_controller.dart';
import 'package:muatmuat/app/core/function/check_after_register_login_go_to_home_function.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/loading_dialog.dart';
import 'package:muatmuat/app/core/models/point_tac_pap_model.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_point_model.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_response_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/business_entity_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/business_field_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/category_capacity_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/city_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/province_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_as_enum.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_business_entity_response.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_business_field_response.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_category_capacity_response.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_city_response.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_province_response.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_response_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_type_account_enum.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_condition_point_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/core/function/dialog_search_city_by_google.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:url_launcher/url_launcher.dart';

class ShipperBuyerRegisterController extends GetxController {
  final typeOfAccountValue = ShipperBuyerRegisterTypeAccount.INDIVIDU.obs;
  final registerAsValue = ShipperBuyerRegisterAs.BUYER.obs;
  final companyName = TextEditingController().obs;
  final address = TextEditingController().obs;
  final postalCode = TextEditingController().obs;
  final capacityEachDay = TextEditingController().obs;
  final picName1 = TextEditingController().obs;
  final picPhoneNumber1 = TextEditingController().obs;
  final picName2 = TextEditingController().obs;
  final picPhoneNumber2 = TextEditingController().obs;
  final picName3 = TextEditingController().obs;
  final picPhoneNumber3 = TextEditingController().obs;

  final String defaultBusinessEntity =
      "ShipperRegisterLabelChooseBusinessEntity".tr;
  final String defaultBusinessField =
      "ShipperRegisterLabelChooseBusinessFields".tr;
  final String defaultProvince = "ShipperRegisterLabelChooseProvince".tr;
  final String defaultCity = "ShipperRegisterLabelChooseCity".tr;
  final String defaultCategoryCapacity =
      "ShipperRegisterLabelChooseCapacityCategory".tr;
  final String _typeTermsCondition = "general-shipper";
  final String _typePrivacyPolicy = "general";

  final businessEntity = "".obs;
  final businessField = "".obs;
  final province = "".obs;
  final city = "".obs;
  final categoryCapacity = "".obs;

  final errorBusinessEntity = 'ShipperRegisterLabelValidatorBusinessEntity'.tr;
  final errorBusinessField = 'ShipperRegisterLabelValidatorBusinessFields'.tr;
  final errorProvince = 'ShipperRegisterLabelValidatorProvince'.tr;
  final errorCity = 'ShipperRegisterLabelValidatorCity'.tr;
  final errorCategoryCapacity =
      "ShipperRegisterLabelValidatorCategoryCapacity".tr;

  String _businessEntityID = "0";
  String _businessFieldID = "0";
  String _provinceID = "0";
  String _cityID = "0";
  String _categoryCapacityID = "0";
  String _errorMessageGettingData = "Error when getting data";

  final listBusinessEntity = [].obs;
  final listBusinessField = [].obs;
  final listProvince = [].obs;
  final listCity = [].obs;
  final listCategoryCapacity = [].obs;

  final isValidateOnChange = false.obs;
  final isCheckedTermsCondition = false.obs;

  final formKey = GlobalKey<FormState>().obs;

  final errorMessageTermsConditionPrivacyPolicy = "".obs;
  final isErrorTermsConditionPrivacyPolicy = false.obs;
  final isSuccessTermsCondition = false.obs;
  final isAllCheckTermCondition = false.obs;
  final isSuccessPrivacyPolicy = false.obs;
  final isAllCheckPrivacyPolicy = false.obs;
  final isReadOnlyCity = true.obs;

  final listPointTermsCondition = [].obs;
  final listPointPrivacyPolicy = [].obs;

  final globalKeyContainerAddress = GlobalKey<FormState>();
  double widthAddressContainer = 0;
  double heightAddressContainer = 0;

  bool _isCompleteBuildWidget = false;
  bool _isTestDebugGetData = false;

  TACPAPController _tacController;
  TACPAPController _papController;

  List<Future> _listGetData = [];

  int _posGetData = 0;

  @override
  void onInit() async {
    _tacController = Get.put(
        TACPAPController(
            title: "ShipperRegisterTACLabelTitle".tr,
            titleNextButton: "ShipperRegisterTACButtonNext".tr,
            onConfirm: _onAcceptTermsCondition),
        tag: "TACShipperRegister");
    _papController = Get.put(
        TACPAPController(
            title: "ShipperRegisterPAPLabelTitle".tr,
            titleNextButton: "ShipperRegisterPAPButtonNext".tr,
            onConfirm: _onAcceptPrivacyPolicy),
        tag: "PAPShipperRegister");
    _addFirstData();
    _resetListGetData();
    //FlutterStatusbarManager.setColor(Color(ListColor.colorBlue));
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  void _resetListGetData() {
    _listGetData.clear();
    // _listGetData.addAll([
    //   _getBusinessEntity(),
    //   _getBusinessField(),
    //   _getProvince(),
    //   _getCategoryCapacity()
    // ]);
  }

  void _addFirstData() {
    listBusinessEntity
        .add(BusinessEntityModel(0, "", "", defaultBusinessEntity));
    listBusinessField.add(BusinessFieldModel(0, "", "", defaultBusinessField));
    listProvince.add(ProvinceModel(0, defaultProvince));
    listCity.add(CityModel(0, defaultCity));
    listCategoryCapacity.add(CategoryCapacityModel(0, defaultCategoryCapacity));

    businessEntity.value = defaultBusinessEntity;
    businessField.value = defaultBusinessField;
    province.value = defaultProvince;
    city.value = defaultCity;
    categoryCapacity.value = defaultCategoryCapacity;
  }

  void setChangeTypeOfAccount(ShipperBuyerRegisterTypeAccount value) {
    typeOfAccountValue.value = value;
    _posGetData = 0;
    _getBusinessEntityAndFieldData();
  }

  void setChangeRegisterAs(ShipperBuyerRegisterAs value) {
    registerAsValue.value = value;
  }

  Future<bool> _getBusinessEntity() async {
    var response;
    try {
      response = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchBusinessEntity();
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterBusinessEntityResponse businessEntityResponse =
          ShipperBuyerRegisterBusinessEntityResponse.fromJson(response);
      if (businessEntityResponse.message.code == 200)
        listBusinessEntity.addAll(businessEntityResponse.listData);
      else {
        _errorMessageGettingData = businessEntityResponse.message.text;
        return false;
      }
      return true;
    }
    return false;
  }

  Future<bool> _getBusinessField() async {
    var response;
    try {
      response = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchBusinessField();
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterBusinessFieldResponse businessFieldResponse =
          ShipperBuyerRegisterBusinessFieldResponse.fromJson(response);
      if (businessFieldResponse.message.code == 200)
        listBusinessField.addAll(businessFieldResponse.listData);
      else {
        _errorMessageGettingData = businessFieldResponse.message.text;
        return false;
      }
      return true;
    }
    return false;
  }

  Future<bool> _getProvince() async {
    print("getprovince");
    var response;
    try {
      response = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchProvince();
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterProvinceResponse provinceResponse =
          ShipperBuyerRegisterProvinceResponse.fromJson(response);
      if (provinceResponse.message.code == 200)
        listProvince.addAll(provinceResponse.listData);
      else {
        _errorMessageGettingData = provinceResponse.message.text;
        return false;
      }
      // if (!_isTestDebugGetData) {
      //   _isTestDebugGetData = true;
      //   return false;
      // }
      return true;
    }
    return false;
  }

  Future _getCity() async {
    isReadOnlyCity.value = true;
    var response;
    try {
      response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchCity(_provinceID);
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterCityResponse cityResponse =
          ShipperBuyerRegisterCityResponse.fromJson(response);
      listCity.addAll(cityResponse.listData);
      isReadOnlyCity.value = false;
      //isShowCity.value = true;
      return true;
    }
    return false;
  }

  Future<bool> _getCategoryCapacity() async {
    print("getCategoryCapacity");
    var response;
    try {
      response = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchCategoryCapacity();
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterCategoryCapacityResponse categoryCapacityResponse =
          ShipperBuyerRegisterCategoryCapacityResponse.fromJson(response);
      if (categoryCapacityResponse.message.code == 200)
        listCategoryCapacity.addAll(categoryCapacityResponse.listData);
      else {
        _errorMessageGettingData = categoryCapacityResponse.message.text;
        return false;
      }
      return true;
    }
    return false;
  }

  void setBusinessEntity(String value) {
    businessEntity.value = value;
    _searchBusinessEntityID();
    _validatorBusinessEntity();
  }

  void setBusinessField(String value) {
    businessField.value = value;
    _searchBusinessFieldID();
    _validatorBusinessField();
  }

  Future setProvince(String value) async {
    //isShowCity.value = false;
    province.value = value;
    city.value = defaultCity;
    _clearCity();
    _searchProvinceID();
    if (_validatorProvince())
      await _getCity();
    else
      isReadOnlyCity.value = true;
  }

  void setCity(String value) {
    city.value = value;
    _searchCityID();
    _validatorCity();
  }

  void setCategoryCapacity(String value) {
    categoryCapacity.value = value;
    _searchCategoryCapacityID();
    _validatorCategoryCapacity();
  }

  void _searchBusinessEntityID() {
    for (BusinessEntityModel data in listBusinessEntity) {
      if (data.showText == businessEntity.value) {
        _businessEntityID = data.id.toString();
        break;
      }
    }
  }

  void _searchBusinessFieldID() {
    for (BusinessFieldModel data in listBusinessField) {
      if (data.showText == businessField.value) {
        _businessFieldID = data.id.toString();
        break;
      }
    }
  }

  void _searchProvinceID() {
    for (ProvinceModel data in listProvince) {
      if (data.descriptionID == province.value) {
        _provinceID = data.code.toString();
        break;
      }
    }
  }

  void _searchCityID() {
    for (CityModel data in listCity) {
      if (data.city == city.value) {
        _cityID = data.code.toString();
        break;
      }
    }
  }

  void _searchCategoryCapacityID() {
    for (CategoryCapacityModel data in listCategoryCapacity) {
      if (data.descriptionID == categoryCapacity.value) {
        _categoryCapacityID = data.id.toString();
        break;
      }
    }
  }

  void _clearCity() {
    if (listCity.length > 1) {
      for (int i = listCity.length - 1; i > 0; i--) {
        listCity.removeAt(i);
      }
    }
  }

  void onSaving() {
    isValidateOnChange.value = true;
    if (validateAll()) {
      _showTermsCondition();
      //Get.offNamed(Routes.BIGFLEETS);
    }
  }

  Future savingData() async {
    var result;
    try {
      result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: true,
              isShowDialogError: true)
          .fetchShipperRegister(
        GlobalVariable.userModelGlobal.docID,
        typeOfAccountValue.value == ShipperBuyerRegisterTypeAccount.INDIVIDU
            ? "0"
            : "1",
        registerAsValue.value == ShipperBuyerRegisterAs.BUYER ? "0" : "1",
        companyName.value.text,
        _businessEntityID,
        _businessFieldID,
        address.value.text,
        _provinceID,
        _cityID,
        postalCode.value.text,
        registerAsValue.value == ShipperBuyerRegisterAs.BUYER
            ? "0"
            : _categoryCapacityID,
        registerAsValue.value == ShipperBuyerRegisterAs.BUYER
            ? "0"
            : capacityEachDay.value.text,
        typeOfAccountValue.value == ShipperBuyerRegisterTypeAccount.INDIVIDU
            ? ""
            : picName1.value.text,
        typeOfAccountValue.value == ShipperBuyerRegisterTypeAccount.INDIVIDU
            ? ""
            : picPhoneNumber1.value.text,
        typeOfAccountValue.value == ShipperBuyerRegisterTypeAccount.INDIVIDU
            ? ""
            : picName2.value.text,
        typeOfAccountValue.value == ShipperBuyerRegisterTypeAccount.INDIVIDU
            ? ""
            : picPhoneNumber2.value.text,
        typeOfAccountValue.value == ShipperBuyerRegisterTypeAccount.INDIVIDU
            ? ""
            : picName3.value.text,
        typeOfAccountValue.value == ShipperBuyerRegisterTypeAccount.INDIVIDU
            ? ""
            : picPhoneNumber3.value.text,
      );
      if (result != null) {
        ShipperBuyerRegisterResponseModel shipperBuyerRegisterResponseModel =
            ShipperBuyerRegisterResponseModel.fromJson(result);
        if (shipperBuyerRegisterResponseModel.message.code == 200) {
          if (shipperBuyerRegisterResponseModel.shipperID != "0") {
            await SharedPreferencesHelper.setUserShipperID(
                shipperBuyerRegisterResponseModel.shipperID);
            // GlobalAlertDialog.showDialogError(.showAlertDialogSuccessNotDissmiss(
            //     shipperBuyerRegisterResponseModel.messaggeResponse, () {
            //   CheckAfterRegisterLoginGoToHome.checkGoToHome();
            // });
            Get.offAllNamed(Routes.SHIPPER_BUYER_REGISTER_SUCCESS);
          } else {
            GlobalAlertDialog.showDialogError(
                context: Get.context,
                message: shipperBuyerRegisterResponseModel.messaggeResponse);
          }
        } else {
          GlobalAlertDialog.showDialogError(
              context: Get.context,
              message: shipperBuyerRegisterResponseModel.message.text);
          GlobalAlertDialog.showDialogError(
              context: Get.context,
              message: shipperBuyerRegisterResponseModel.message.text);
        }
      }
    } catch (err) {}
  }

  bool validateAll() {
    _validatorProvince();
    bool isValidateBusinessEntityField;
    if (typeOfAccountValue.value ==
        ShipperBuyerRegisterTypeAccount.PERUSAHAAN) {
      bool isValidateBusinessEntity = _validatorBusinessEntity();
      bool isValidateBusinessField = _validatorBusinessField();
      isValidateBusinessEntityField =
          isValidateBusinessEntity && isValidateBusinessField;
    } else {
      isValidateBusinessEntityField = true;
    }
    bool isValidateProvince = _validatorProvince();
    bool isValidateCity = _validatorCity();
    bool isValidateCategoryCapacity =
        registerAsValue.value == ShipperBuyerRegisterAs.SHIPPER
            ? _validatorCategoryCapacity()
            : true;
    return (formKey.value.currentState.validate() &&
        isValidateBusinessEntityField &&
        isValidateProvince &&
        isValidateCity &&
        isValidateCategoryCapacity &&
        isCheckedTermsCondition.value);
  }

  bool _validatorBusinessEntity() {
    int id;
    for (BusinessEntityModel data in listBusinessEntity) {
      if (data.showText == businessEntity.value) {
        id = data.id;
        break;
      }
    }
    bool result = _validateDropdown(id);
    // errorBusinessEntity.value = !result && isValidateOnChange.value
    //     ? 'ShipperRegisterLabelValidatorBusinessEntity'.tr
    //     : "";
    return result;
  }

  bool _validatorBusinessField() {
    int id;
    for (BusinessFieldModel data in listBusinessField) {
      if (data.showText == businessField.value) {
        id = data.id;
        break;
      }
    }
    bool result = _validateDropdown(id);
    // errorBusinessField.value = !result && isValidateOnChange.value
    //     ? 'ShipperRegisterLabelValidatorBusinessFields'.tr
    //     : "";
    return result;
  }

  bool _validatorProvince() {
    bool result = _validateDropdown(int.parse(_provinceID));
    // errorProvince.value = !result && isValidateOnChange.value
    //     ? 'ShipperRegisterLabelValidatorProvince'.tr
    //     : "";
    return result;
  }

  bool _validatorCity() {
    int code;
    for (CityModel data in listCity) {
      if (data.city == city.value) {
        code = data.code;
        break;
      }
    }
    bool result = _validateDropdown(code);
    // errorCity.value = !result && isValidateOnChange.value
    //     ? 'ShipperRegisterLabelValidatorCity'.tr
    //     : "";
    return result;
  }

  bool _validatorCategoryCapacity() {
    int id;
    for (CategoryCapacityModel data in listCategoryCapacity) {
      if (data.descriptionID == categoryCapacity.value) {
        id = data.id;
        break;
      }
    }
    bool result = _validateDropdown(id);
    // errorCategoryCapacity.value = !result && isValidateOnChange.value
    //     ? "ShipperRegisterLabelValidatorCategoryCapacity".tr
    //     : "";
    return result;
  }

  bool _validateDropdown(int idChoose) {
    return idChoose != 0;
  }

  String validatorMessageAverageCapacity(String value) {
    String message;
    if (value.isEmpty) {
      message = 'ShipperRegisterLabelValidatorAverageCapacity'.tr;
    } else if (_categoryCapacityID == "0") {
      message = 'ShipperRegisterLabelValidatorMustChooseAverageCapacity'.tr;
    } else {
      CategoryCapacityModel dataCapacity = listCategoryCapacity
          .where((data) => data.id == int.parse(_categoryCapacityID))
          .toList()[0];
      int capacity = int.parse(value);
      if (dataCapacity.bottomRange <= capacity &&
          capacity <= dataCapacity.topRange) {
        message = null;
      } else {
        message =
            'ShipperRegisterLabelValidatorMustInsideRangeAverageCapacity'.tr;
      }
    }

    return message;
  }

  void _showTermsCondition() {
    isAllCheckTermCondition.value = false;
    _getDataTermsCondition();
    _tacController.showModalBottomSheetIsGettingDataPointTrue();
    // showModalBottomSheet(
    //     isDismissible: false,
    //     isScrollControlled: true,
    //     enableDrag: false,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    //     backgroundColor: Colors.white,
    //     context: Get.context,
    //     builder: (context) {
    //       return Container(
    //         color: Colors.transparent,
    //         height: MediaQuery.of(context).size.height - 100,
    //         child: Column(children: [
    //           Container(
    //             padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
    //             child: Text(
    //               'ShipperRegisterTACLabelTitle'.tr,
    //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               color: Colors.white,
    //               child: Obx(() => !isSuccessTermsCondition.value
    //                   ? Center(
    //                       child: Container(
    //                           width: 30,
    //                           height: 30,
    //                           child: CircularProgressIndicator()))
    //                   : SingleChildScrollView(
    //                       child: Container(
    //                       padding: EdgeInsets.fromLTRB(20, 5, 20, 16),
    //                       child: Obx(
    //                         () => Column(children: _getListTermsAndCondition()
    //                             // [
    //                             //   Container(
    //                             //     // margin: EdgeInsets.only(top: 20),
    //                             //     child: Html(
    //                             //       data: controller.termsConditionData.value,
    //                             //       onLinkTap: (url) {
    //                             //         print("Opening $url...");
    //                             //         controller.urlLauncher(url);
    //                             //       },
    //                             //     )
    //                             //     ,
    //                             //   ),
    //                             // ],
    //                             ),
    //                       ),
    //                     ))),
    //             ),
    //           ),
    //         ]),
    //       );
    //     });
  }

  // List<Widget> _getListTermsAndCondition() {
  //   List<Widget> list = [];
  //   if (listPointTermsCondition.length > 0) {
  //     for (int i = 0; i < listPointTermsCondition.length; i++) {
  //       TermsAndConditionsPointModel termsAndConditionsPointModel =
  //           listPointTermsCondition[i];
  //       list.add(_getDetailTermsAndCondition(termsAndConditionsPointModel, i));
  //     }
  //   }
  //   if (isSuccessTermsCondition.value)
  //     list.add(Obx(() => MaterialButton(
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(40)),
  //             side: isAllCheckTermCondition.value
  //                 ? BorderSide.none
  //                 : BorderSide(
  //                     color: Color(ListColor.colorDarkGrey), width: 2)),
  //         color: Color(isAllCheckTermCondition.value
  //             ? ListColor.color4
  //             : ListColor.colorLightGrey),
  //         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
  //         onPressed: () {
  //           if (isAllCheckTermCondition.value) _onAcceptTermsCondition();
  //         },
  //         child: CustomText('ShipperRegisterTACButtonNext'.tr,
  //             fontSize: 14,
  //             color: isAllCheckTermCondition.value
  //                 ? Colors.white
  //                 : Color(ListColor.colorGrey),
  //             fontWeight: FontWeight.w600))));
  //   return list;
  // }

  // Widget _getDetailTermsAndCondition(
  //     TermsAndConditionsPointModel termsAndConditionsPointModel, int index) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       index == 0
  //           ? SizedBox.shrink()
  //           : Theme(
  //               data: ThemeData(unselectedWidgetColor: Color(ListColor.color4)),
  //               child: Checkbox(
  //                 value: termsAndConditionsPointModel.isChecked,
  //                 onChanged: isSuccessTermsCondition.value
  //                     ? (value) {
  //                         setCheckboxTermsCondition(value, index);
  //                       }
  //                     : null,
  //                 checkColor: Colors.white,
  //                 activeColor: Color(ListColor.color4),
  //               ),
  //             ),
  //       Expanded(
  //         child: Html(
  //           data: termsAndConditionsPointModel.data,
  //           onLinkTap: (url) {
  //             print("Opening $url...");
  //             urlLauncher(url);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void _onAcceptTermsCondition() {
    _showPrivacyPolicy();
    // if (_isAllCheckedTermsCondition()) {
    //   _showPrivacyPolicy();
    // } else {
    //   _showAlertDialogError(
    //       'ShipperRegisterTACLabelErrorCheck'.tr, Get.context);
    // }
  }

  // void _showAlertDialogError(String message, BuildContext context) {
  //   GlobalAlertDialog.showDialogError(message: message, context: context);
  // }

  Future _getDataTermsCondition() async {
    isSuccessTermsCondition.value = false;
    listPointTermsCondition.clear();
    _resetError();
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchTermCondition(type: _typeTermsCondition);
    if (responseBody != null) {
      TermsAndConditionsResponseModel termsAndConditionsResponseModel =
          TermsAndConditionsResponseModel.fromJson(responseBody);
      if (termsAndConditionsResponseModel.message.code == 200) {
        listPointTermsCondition
            .addAll(termsAndConditionsResponseModel.listPoint);
        if (listPointTermsCondition.length > 0)
          listPointTermsCondition[0].isChecked = true;
        _tacController.addListPoint(listPointTermsCondition
            .map((element) => PointTACPAPModel(element.data))
            .toList());
        _tacController.setIsGettingDataPoint(false);
        isSuccessTermsCondition.value = true;
        listPointTermsCondition.refresh();
      } else {
        _setError(termsAndConditionsResponseModel.message.text);
      }
    } else {
      _setError('GlobalLabelErrorNoConnection'.tr);
    }
  }

  void _resetError() {
    isErrorTermsConditionPrivacyPolicy.value = false;
    errorMessageTermsConditionPrivacyPolicy.value = "";
  }

  void _setError(String errorMessage) {
    isErrorTermsConditionPrivacyPolicy.value = true;
    this.errorMessageTermsConditionPrivacyPolicy.value = errorMessage;
  }

  void urlLauncher(String url) async {
    if (await canLaunch(url)) {
      //await launch(url);
      Get.toNamed(Routes.WEBVIEW_TAC_PAP, arguments: url);
    }
  }

  void setCheckboxTermsCondition(bool isChecked, int index) {
    listPointTermsCondition[index].isChecked = isChecked;
    listPointTermsCondition.refresh();
    isAllCheckTermCondition.value = _isAllCheckedTermsCondition();
  }

  _isAllCheckedTermsCondition() {
    bool result = true;
    for (TermsAndConditionsPointModel model in listPointTermsCondition) {
      if (!model.isChecked) {
        result = false;
        break;
      }
    }
    return result;
  }

  void showPrivacyPolicy() {
    _showPrivacyPolicy();
  }

  void _showPrivacyPolicy() {
    isAllCheckPrivacyPolicy.value = false;
    _getDataPrivacyPolicy();
    _papController.showModalBottomSheetIsGettingDataPointTrue();
    // showModalBottomSheet(
    //     isDismissible: false,
    //     isScrollControlled: true,
    //     enableDrag: false,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    //     backgroundColor: Colors.white,
    //     context: Get.context,
    //     builder: (context) {
    //       return Container(
    //         color: Colors.transparent,
    //         height: MediaQuery.of(context).size.height - 100,
    //         child: Column(children: [
    //           Container(
    //             padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
    //             child: Text(
    //               'ShipperRegisterPAPLabelTitle'.tr,
    //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               color: Colors.white,
    //               child: Obx(() => !isSuccessPrivacyPolicy.value
    //                   ? Center(
    //                       child: Container(
    //                           width: 30,
    //                           height: 30,
    //                           child: CircularProgressIndicator()))
    //                   : SingleChildScrollView(
    //                       child: Container(
    //                       padding: EdgeInsets.all(20),
    //                       child: Column(children: _getListPrivacyAndPolicy()
    //                           // [
    //                           //   Container(
    //                           //     margin: EdgeInsets.only(top: 20),
    //                           //     child: Obx(() => Html(
    //                           //               data: controller
    //                           //                   .privacyAndPolicyData.value,
    //                           //               onLinkTap: (url) {
    //                           //                 print("Opening $url...");
    //                           //                 controller.urlLauncher(url);
    //                           //               },
    //                           //             )
    //                           //         ),
    //                           //   ),
    //                           // ],
    //                           ),
    //                     ))),
    //             ),
    //           ),
    //         ]),
    //       );
    //     });
  }

  void _onAcceptPrivacyPolicy() {
    Get.back();
    Get.back();
    savingData();
    // if (_isAllCheckedPrivacyPolicy()) {
    //   // && isAgreeTC2.value
    //   Get.back();
    //   Get.back();
    //   savingData();
    // } else {
    //   _showAlertDialogError(
    //       'ShipperRegisterPAPLabelErrorCheck'.tr, Get.context);
    // }
  }

  Future _getDataPrivacyPolicy() async {
    isSuccessPrivacyPolicy.value = false;
    listPointPrivacyPolicy.clear();
    _resetError();
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchPrivacyPolicy(type: _typePrivacyPolicy);
    if (responseBody != null) {
      PrivacyAndPolicyResponseModel privacyAndPolicyResponseModel =
          PrivacyAndPolicyResponseModel.fromJson(responseBody);
      if (privacyAndPolicyResponseModel.message.code == 200) {
        // privacyAndPolicyData.value = privacyAndPolicyResponseModel.data;
        listPointPrivacyPolicy.addAll(privacyAndPolicyResponseModel.listPoint);
        if (listPointPrivacyPolicy.length > 0)
          listPointPrivacyPolicy[0].isChecked = true;
        _papController.addListPoint(listPointPrivacyPolicy
            .map((element) => PointTACPAPModel(element.data))
            .toList());
        _papController.setIsGettingDataPoint(false);
        isSuccessPrivacyPolicy.value = true;
        listPointPrivacyPolicy.refresh();
      } else {
        _setError(privacyAndPolicyResponseModel.message.text);
      }
    } else {
      _setError('GlobalLabelErrorNoConnection'.tr);
    }
  }

  void setCheckboxPrivacyPolicy(bool isChecked, int index) {
    listPointPrivacyPolicy[index].isChecked = isChecked;
    listPointPrivacyPolicy.refresh();
    isAllCheckPrivacyPolicy.value = _isAllCheckedPrivacyPolicy();
  }

  _isAllCheckedPrivacyPolicy() {
    bool result = true;
    for (PrivacyAndPolicyPointModel model in listPointPrivacyPolicy) {
      if (!model.isChecked) {
        result = false;
        break;
      }
    }
    return result;
  }

  // List<Widget> _getListPrivacyAndPolicy() {
  //   List<Widget> list = [];
  //   if (listPointPrivacyPolicy.length > 0) {
  //     for (int i = 0; i < listPointPrivacyPolicy.length; i++) {
  //       PrivacyAndPolicyPointModel privacyAndPolicyPointModel =
  //           listPointPrivacyPolicy[i];
  //       list.add(_getDetailPrivacyAndPolicy(privacyAndPolicyPointModel, i));
  //     }
  //   }
  //   if (isSuccessPrivacyPolicy.value)
  //     list.add(Obx(() => MaterialButton(
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(40)),
  //             side: isAllCheckPrivacyPolicy.value
  //                 ? BorderSide.none
  //                 : BorderSide(
  //                     color: Color(ListColor.colorDarkGrey), width: 2)),
  //         color: Color(isAllCheckPrivacyPolicy.value
  //             ? ListColor.color4
  //             : ListColor.colorLightGrey),
  //         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
  //         onPressed: () {
  //           if (isAllCheckPrivacyPolicy.value) _onAcceptPrivacyPolicy();
  //         },
  //         child: CustomText('ShipperRegisterPAPButtonNext'.tr,
  //             fontSize: 14,
  //             color: isAllCheckPrivacyPolicy.value
  //                 ? Colors.white
  //                 : Color(ListColor.colorGrey),
  //             fontWeight: FontWeight.w800))));
  //   return list;
  // }

  // Widget _getDetailPrivacyAndPolicy(
  //     PrivacyAndPolicyPointModel privacyAndPolicyPointModel, int index) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       index == 0
  //           ? SizedBox.shrink()
  //           : Theme(
  //               data: ThemeData(unselectedWidgetColor: Color(ListColor.color4)),
  //               child: Checkbox(
  //                 value: privacyAndPolicyPointModel.isChecked,
  //                 onChanged: isSuccessPrivacyPolicy.value
  //                     ? (value) {
  //                         setCheckboxPrivacyPolicy(value, index);
  //                       }
  //                     : null,
  //                 checkColor: Colors.white,
  //                 activeColor: Color(ListColor.color4),
  //               ),
  //             ),
  //       Expanded(
  //         child: Html(
  //           data: privacyAndPolicyPointModel.data,
  //           onLinkTap: (url) {
  //             print("Opening $url...");
  //             urlLauncher(url);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  //   // return Column(
  //   //   mainAxisSize: MainAxisSize.min,
  //   //   children: [
  //   //     Container(
  //   //         decoration: BoxDecoration(
  //   //           borderRadius: BorderRadius.circular(12),
  //   //           border: Border.all(width: 1, color: Colors.grey),
  //   //         ),
  //   //         child: Html(
  //   //           data: privacyAndPolicyPointModel.data,
  //   //           onLinkTap: (url) {
  //   //             print("Opening $url...");
  //   //             controller.urlLauncher(url);
  //   //           },
  //   //         )),
  //   //     Row(
  //   //       children: [
  //   //         Checkbox(
  //   //           value: privacyAndPolicyPointModel.isChecked,
  //   //           onChanged: controller.isSuccess.value
  //   //               ? (value) {
  //   //                   controller.setCheckbox(value, index);
  //   //                 }
  //   //               : null,
  //   //           checkColor: Color(ListColor.colorBlue),
  //   //           activeColor: Colors.transparent,
  //   //         ),
  //   //         Expanded(
  //   //           child: Text('TACLabelAgree'.tr,
  //   //               style: TextStyle(
  //   //                   color: Colors.black, fontWeight: FontWeight.bold)),
  //   //         ),
  //   //       ],
  //   //     ),
  //   //   ],
  //   // );
  // }

  onCompleteBuildWidget() {
    if (!_isCompleteBuildWidget) {
      _isCompleteBuildWidget = true;
      final renderBox = globalKeyContainerAddress.currentContext
          .findRenderObject() as RenderBox;
      widthAddressContainer = renderBox.size.width;
      heightAddressContainer = renderBox.size.height;
      _getFirstData();
    }
  }

  Future _getFirstData() async {
    bool isError = false;
    LoadingDialog loadingDialog = LoadingDialog(Get.context);
    loadingDialog.showLoadingDialog();
    for (int i = _posGetData; i < 2; i++) {
      _posGetData = i;
      switch (i) {
        case 0:
          isError = !await _getProvince();
          break;
        case 1:
          isError = !await _getCategoryCapacity();
          break;
      }

      if (isError) {
        break;
      }
    }

    loadingDialog.dismissDialog();
    if (isError) {
      GlobalAlertDialog.showDialogError(
        message: _errorMessageGettingData,
        context: Get.context,
        labelButtonPriority1: "ShipperRegisterLabelButtonTryAgain".tr,
        onTapPriority1: () async {
          _resetListGetData();
          await _getFirstData();
        },
        labelButtonPriority2: "ShipperRegisterLabelButtonCancel".tr,
      );
    }
  }

  Future _getBusinessEntityAndFieldData() async {
    if (listBusinessEntity.length <= 1 || listBusinessField.length <= 1) {
      bool isError = false;
      LoadingDialog loadingDialog = LoadingDialog(Get.context);
      loadingDialog.showLoadingDialog();
      for (int i = _posGetData; i < 2; i++) {
        _posGetData = i;
        switch (i) {
          case 0:
            isError = !await _getBusinessEntity();
            break;
          case 1:
            isError = !await _getBusinessField();
            break;
        }

        if (isError) {
          break;
        }
      }

      loadingDialog.dismissDialog();
      if (isError) {
        GlobalAlertDialog.showDialogError(
          message: _errorMessageGettingData,
          context: Get.context,
          labelButtonPriority1: "ShipperRegisterLabelButtonTryAgain".tr,
          onTapPriority1: () async {
            _resetListGetData();
            await _getBusinessEntityAndFieldData();
          },
          labelButtonPriority2: "ShipperRegisterLabelButtonCancel".tr,
        );
      }
    }
  }

  void onClickAddress() {
    showDialog(
        context: Get.context,
        builder: (context) => DialogSearchCityByGoogle(
              onTapItem: (data) {
                address.value.text = data.formattedAddress;
              },
              address: address.value.text,
            ));
  }

  DialogSearchDropdownItemModel({String id, value}) {}

  void onCheckedChangedTermsCondition(bool value) {
    isCheckedTermsCondition.value = value;
  }
}
