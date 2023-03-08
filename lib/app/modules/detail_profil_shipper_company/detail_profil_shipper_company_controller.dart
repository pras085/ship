import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/dialog_search_city_by_google.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/loading_dialog.dart';
import 'package:muatmuat/app/core/function/validator/phoine_number_validator.dart';
import 'package:muatmuat/app/core/models/dialog_search_dropdown_item_model.dart';
import 'package:muatmuat/app/modules/detail_profil_shipper/detail_profil_shipper_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_model.dart';
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
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/core/function/dialog_search_dropdown.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class DetailProfilShipperCompanyController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;

  final profileShipperModel = ProfileShipperModel().obs;

  final tabValue = "".obs;

  final fullNameController = TextEditingController().obs;
  final numberWhatssappController = TextEditingController().obs;
  final companyNameController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final namePIC1Controller = TextEditingController().obs;
  final numberPIC1Controller = TextEditingController().obs;
  final namePIC2Controller = TextEditingController().obs;
  final numberPIC2Controller = TextEditingController().obs;
  final namePIC3Controller = TextEditingController().obs;
  final numberPIC3Controller = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final averageCapacityController = TextEditingController().obs;

  final fullNameFocusNode = FocusNode().obs;
  final numberWhatssappFocusNode = FocusNode().obs;
  final companyNameFocusNode = FocusNode().obs;
  final addressFocusNode = FocusNode().obs;
  final namePIC1FocusNode = FocusNode().obs;
  final numberPIC1FocusNode = FocusNode().obs;
  final namePIC2FocusNode = FocusNode().obs;
  final numberPIC2FocusNode = FocusNode().obs;
  final namePIC3FocusNode = FocusNode().obs;
  final numberPIC3FocusNode = FocusNode().obs;
  final postalCodeFocusNode = FocusNode().obs;
  final averageCapacityFocusNode = FocusNode().obs;

  final isShowSaveButton = false.obs;
  final isSubTabProfile = true.obs;
  final isSubTabVerifyData = false.obs;

  final formKey = GlobalKey<FormState>().obs;
  final verifyKey = GlobalKey().obs;

  final String _defaultBusinessEntity =
      "ProfileShipperLabelDefaultBusinessEntity".tr;
  final String _defaultBusinessField =
      "ProfileShipperLabelDefaultBusinessField".tr;
  final String _defaultProvince = "ProfileShipperLabelDefaultProvince".tr;
  final String _defaultCity = "ProfileShipperLabelDefaultCity".tr;
  final String _defaultCategoryCapacity =
      "ProfileShipperLabelDefaultCategoryCapacity".tr;

  final businessEntity = "".obs;
  final businessField = "".obs;
  final province = "".obs;
  final city = "".obs;
  final categoryCapacity = "".obs;

  final listBusinessEntity = [].obs;
  final listBusinessField = [].obs;
  final listProvince = [].obs;
  final listCity = [].obs;
  final listCategoryCapacity = [].obs;

  var selectedImage = File("").obs;

  final contentPaddingTextFormFieldVerify = EdgeInsets.zero.obs;

  List<TextEditingController> _listTextEditingController = [];
  List<String> _listInitialValue = [];
  List<Rx<FocusNode>> _listInitialFocusNode = [];
  List<String> _listInitialDropDownIDValue = [];
  List<RxString> _listDropDownRxString = [];

  final globalKeyContainerAddress = GlobalKey<FormState>();

  double widthAddressContainer = 0;
  double heightAddressContainer = 0;
  LatLng _latLng;

  final _provinceID = "0".obs;
  final _cityID = "0".obs;
  final _categoryCapacityID = "0".obs;
  final _businessEntityID = "0".obs;
  final _businessFieldID = "0".obs;

  int _posGetData = 0;

  bool _isCompleteBuildWidget = false;
  bool _isEnableValidate = false;

  final _keyDialog = new GlobalKey<State>();

  ProfileShipperModel _profileTemp;
  //final shopNameController = TextEditingController().obs;

  @override
  void onInit() {
    selectedImage.value = null;
    profileShipperModel.value = Get.arguments;
    _profileTemp = ProfileShipperModel.copy(profileShipperModel.value);
    if (profileShipperModel.value.latitude != "" &&
        profileShipperModel.value.longitude != "") {
      _latLng = LatLng(double.parse(profileShipperModel.value.latitude),
          double.parse(profileShipperModel.value.longitude));
    }
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      print(tabController.index.toString);
    });
    _addFirstData();
    _initialListController();
    _initialListInitialValue();
    _initialFocusNode();
    _addListenerAllFocusNode();
    _initialDropDownRxString();
    _initialDropDownValue();
    //tabValue.value = listTabMitra[0];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  setShowSaveButton(bool isEnable) {
    isShowSaveButton.value = isEnable;
  }

  void _initialListController() {
    _listTextEditingController = [
      fullNameController.value,
      numberWhatssappController.value,
      companyNameController.value,
      addressController.value,
      namePIC1Controller.value,
      numberPIC1Controller.value,
      namePIC2Controller.value,
      numberPIC2Controller.value,
      namePIC3Controller.value,
      numberPIC3Controller.value,
      postalCodeController.value,
      averageCapacityController.value
    ];
  }

  void _initialListInitialValue() {
    fullNameController.value.text = profileShipperModel.value.username;
    companyNameController.value.text = profileShipperModel.value.shopName;
    postalCodeController.value.text = profileShipperModel.value.postalCode;
    addressController.value.text = profileShipperModel.value.address;
    averageCapacityController.value.text = profileShipperModel.value.capacity;
    numberWhatssappController.value.text =
        profileShipperModel.value.numberWhatssapp;
    namePIC1Controller.value.text = profileShipperModel.value.namePIC1;
    numberPIC1Controller.value.text = profileShipperModel.value.contactPIC1;
    namePIC2Controller.value.text = profileShipperModel.value.namePIC2;
    numberPIC2Controller.value.text = profileShipperModel.value.contactPIC2;
    namePIC3Controller.value.text = profileShipperModel.value.namePIC3;
    numberPIC3Controller.value.text = profileShipperModel.value.contactPIC3;
    _listInitialValue = [
      fullNameController.value.text,
      numberWhatssappController.value.text,
      companyNameController.value.text,
      addressController.value.text,
      namePIC1Controller.value.text,
      numberPIC1Controller.value.text,
      namePIC2Controller.value.text,
      numberPIC2Controller.value.text,
      namePIC3Controller.value.text,
      numberPIC3Controller.value.text,
      postalCodeController.value.text,
      averageCapacityController.value.text
    ];
  }

  void _initialFocusNode() {
    _listInitialFocusNode = [
      fullNameFocusNode,
      numberWhatssappFocusNode,
      companyNameFocusNode,
      addressFocusNode,
      namePIC1FocusNode,
      numberPIC1FocusNode,
      namePIC2FocusNode,
      numberPIC2FocusNode,
      namePIC3FocusNode,
      numberPIC3FocusNode,
      postalCodeFocusNode,
      averageCapacityFocusNode
    ];
  }

  void _initialDropDownRxString() {
    _listDropDownRxString = [
      _provinceID,
      _cityID,
      _categoryCapacityID,
      _businessEntityID,
      _businessFieldID
    ];
  }

  void _initialDropDownValue() {
    _listInitialDropDownIDValue = [
      profileShipperModel.value.provinceCode,
      profileShipperModel.value.cityID,
      profileShipperModel.value.categoryCapacityID,
      profileShipperModel.value.businessEntityID,
      profileShipperModel.value.businessFieldID,
    ];
  }

  void _addListenerAllFocusNode() {
    for (int i = 0; i < _listInitialFocusNode.length; i++) {
      _listInitialFocusNode[i].value.addListener(() {
        _listInitialFocusNode[i].refresh();
      });
    }
  }

  Future onCompleteBuildWidget() async {
    if (!_isCompleteBuildWidget) {
      _isCompleteBuildWidget = true;
      final renderBox = globalKeyContainerAddress.currentContext
          .findRenderObject() as RenderBox;
      widthAddressContainer = renderBox.size.width;
      heightAddressContainer = renderBox.size.height;
      await _getCategoryCapacity();
      _isEnableValidate = true;
      addressController.refresh();
    }
  }

  void _addFirstData() {
    listBusinessEntity.add(BusinessEntityModel(
        0, "", _defaultBusinessEntity, _defaultBusinessEntity));
    listBusinessField.add(BusinessFieldModel(
        0, "", _defaultBusinessField, _defaultBusinessField));
    listProvince.add(ProvinceModel(0, _defaultProvince));
    listCity.add(CityModel(0, _defaultCity));
    listCategoryCapacity
        .add(CategoryCapacityModel(0, _defaultCategoryCapacity));

    province.value = profileShipperModel.value.province;
    _provinceID.value = profileShipperModel.value.provinceCode;
    city.value = profileShipperModel.value.city;
    _cityID.value = profileShipperModel.value.cityID;
    categoryCapacity.value = profileShipperModel.value.categoryCapacity;
    _categoryCapacityID.value = profileShipperModel.value.categoryCapacityID;
    businessEntity.value = profileShipperModel.value.businessEntity;
    _businessEntityID.value = profileShipperModel.value.businessEntityID;
    businessField.value = profileShipperModel.value.businessField;
    _businessFieldID.value = profileShipperModel.value.businessFieldID;
  }

  void setBusinessEntity(String value) {
    businessEntity.value = value;
    _searchBusinessEntityID();
    validateAll();
    //_validatorBusinessEntity();
  }

  void setBusinessField(String value) {
    businessField.value = value;
    _searchBusinessFieldID();
    validateAll();
    //_validatorBusinessField();
  }

  Future setProvince(String value) async {
    //isShowCity.value = false;
    province.value = value;
    city.value = _defaultCity;
    _clearCity();
    _searchProvinceID();
    validateAll();
    await _getCity();
  }

  void setCity(String value) {
    city.value = value;
    _searchCityID();
    validateAll();
  }

  void _clearCity() {
    if (listCity.length > 1) {
      listCity.removeWhere((data) => data.code != 0);
    }
  }

  void _searchProvinceID() {
    for (ProvinceModel data in listProvince) {
      if (data.descriptionID == province.value) {
        _provinceID.value = data.code.toString();
        break;
      }
    }
  }

  void _searchBusinessEntityID() {
    for (BusinessEntityModel data in listBusinessEntity) {
      if (data.descriptionID == businessEntity.value) {
        _businessEntityID.value = data.id.toString();
        break;
      }
    }
  }

  void _searchBusinessFieldID() {
    for (BusinessFieldModel data in listBusinessField) {
      if (data.descriptionID == businessField.value) {
        _businessFieldID.value = data.id.toString();
        break;
      }
    }
  }

  Future _getCity() async {
    var response;
    try {
      response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchCity(_provinceID.value);
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterCityResponse cityResponse =
          ShipperBuyerRegisterCityResponse.fromJson(response);
      listCity.addAll(cityResponse.listData);
      //isShowCity.value = true;
      return true;
    }
    return false;
  }

  Future<bool> _getProvince() async {
    print("getprovince");
    var response;
    try {
      response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchProvince();
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterProvinceResponse provinceResponse =
          ShipperBuyerRegisterProvinceResponse.fromJson(response);
      if (provinceResponse.message.code == 200) {
        listProvince.addAll(provinceResponse.listData);
        //await setProvince(profileShipperModel.value.province);
        //setCity(profileShipperModel.value.city);
      } else {
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

  Future<bool> _getBusinessEntity() async {
    var response;
    try {
      response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchBusinessEntity();
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterBusinessEntityResponse businessEntityResponse =
          ShipperBuyerRegisterBusinessEntityResponse.fromJson(response);
      if (businessEntityResponse.message.code == 200) {
        listBusinessEntity.addAll(businessEntityResponse.listData);
        //setBusinessEntity(profileShipperModel.value.businessEntity);
      } else {
        //_errorMessageGettingData = businessEntityResponse.message.text;
        return false;
      }
      return true;
    }
    return false;
  }

  Future<bool> _getBusinessField() async {
    var response;
    try {
      response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchBusinessField();
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterBusinessFieldResponse businessFieldResponse =
          ShipperBuyerRegisterBusinessFieldResponse.fromJson(response);
      if (businessFieldResponse.message.code == 200) {
        listBusinessField.addAll(businessFieldResponse.listData);
        //setBusinessField(profileShipperModel.value.businessField);
      } else {
        //_errorMessageGettingData = businessFieldResponse.message.text;
        return false;
      }
      return true;
    }
    return false;
  }

  Future<bool> _getCategoryCapacity() async {
    print("getCategoryCapacity");
    var response;
    try {
      response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchCategoryCapacity();
    } catch (err) {}
    if (response != null) {
      ShipperBuyerRegisterCategoryCapacityResponse categoryCapacityResponse =
          ShipperBuyerRegisterCategoryCapacityResponse.fromJson(response);
      if (categoryCapacityResponse.message.code == 200) {
        listCategoryCapacity.addAll(categoryCapacityResponse.listData);
        //setCategoryCapacity(profileShipperModel.value.categoryCapacity);
      } else {
        //_errorMessageGettingData = categoryCapacityResponse.message.text;
        return false;
      }
      return true;
    }
    return false;
  }

  void _searchCityID() {
    for (CityModel data in listCity) {
      if (data.city == city.value) {
        _cityID.value = data.code.toString();
        break;
      }
    }
  }

  void setCategoryCapacity(String value) {
    categoryCapacity.value = value;
    _searchCategoryCapacityID();
    validateAll();
  }

  void _searchCategoryCapacityID() {
    for (CategoryCapacityModel data in listCategoryCapacity) {
      if (data.descriptionID == categoryCapacity.value) {
        _categoryCapacityID.value = data.id.toString();
        break;
      }
    }
  }

  void onTapSubTabProfile() {
    isSubTabProfile.value = true;
    isSubTabVerifyData.value = false;
  }

  void onTapSubTabVerifyData() {
    isSubTabVerifyData.value = true;
    isSubTabProfile.value = false;
  }

  Future _getAllData() async {
    bool isError = false;
    LoadingDialog loadingDialog = LoadingDialog(Get.context);
    loadingDialog.showLoadingDialog();
    for (int i = _posGetData; i < 4; i++) {
      _posGetData = i;
      switch (i) {
        case 0:
          isError = !await _getBusinessEntity();
          break;
        case 1:
          isError = !await _getBusinessField();
          break;
        case 2:
          isError = !await _getProvince();
          break;
        case 3:
          isError = !await _getCategoryCapacity();
          break;
      }

      if (isError) {
        break;
      }
    }

    loadingDialog.dismissDialog();
  }

  void chooseImage() {
    showDialog(
        context: Get.context,
        builder: (context) {
          return AlertDialog(
            // content: Text("HI"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await getFromCamera();
                    },
                    padding: EdgeInsets.all(11),
                    child: CustomText("Take a photo"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await getFromGallery();
                    },
                    padding: EdgeInsets.all(11),
                    child: CustomText("Get from gallery"),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        maxHeight: 900,
        imageQuality: 50);
    _cropImage(pickedFile.path);
  }

  void getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1600,
        maxHeight: 900,
        imageQuality: 50);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
      //selectedImage.value = File(pickedFile.path);
    }
  }

  void _cropImage(filePath) async {
    File croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      selectedImage.value = croppedImage;
      validateAll();
    }
  }

  Future saveButton() async {
    try {
      if (checkAllEdit()) {
        profileShipperModel.value.username = fullNameController.value.text;
        profileShipperModel.value.numberWhatssapp =
            numberWhatssappController.value.text;
        profileShipperModel.value.shopName = companyNameController.value.text;
        profileShipperModel.value.address = addressController.value.text;
        profileShipperModel.value.provinceCode = _provinceID.value;
        profileShipperModel.value.cityID = _cityID.value;
        profileShipperModel.value.categoryCapacityID =
            _categoryCapacityID.value;
        profileShipperModel.value.capacity =
            averageCapacityController.value.text;
        profileShipperModel.value.postalCode = postalCodeController.value.text;
        profileShipperModel.value.namePIC1 = namePIC1Controller.value.text;
        profileShipperModel.value.contactPIC1 = numberPIC1Controller.value.text;
        profileShipperModel.value.namePIC2 =
            namePIC2Controller.value.text == "-"
                ? ""
                : namePIC2Controller.value.text;
        profileShipperModel.value.contactPIC2 =
            numberPIC2Controller.value.text == "-"
                ? ""
                : numberPIC2Controller.value.text;
        profileShipperModel.value.namePIC3 =
            namePIC3Controller.value.text == "-"
                ? ""
                : namePIC3Controller.value.text;
        profileShipperModel.value.contactPIC3 =
            numberPIC3Controller.value.text == "-"
                ? ""
                : numberPIC3Controller.value.text;
        profileShipperModel.value.businessEntityID = _businessEntityID.value;
        profileShipperModel.value.businessFieldID = _businessFieldID.value;
        if (_latLng != null) {
          profileShipperModel.value.latitude = _latLng.latitude.toString();
          profileShipperModel.value.longitude = _latLng.longitude.toString();
        }
        var response = await ApiHelper(context: Get.context)
            .fetchUpdateProfile(selectedImage.value, profileShipperModel.value);
        if ((response != null)) {
          DetailProfileShipperResponseModel detailProfileShipperResponseModel =
              DetailProfileShipperResponseModel.fromJson(response);
          if (detailProfileShipperResponseModel.message.code == 200) {
            if (_profileTemp.shopName != profileShipperModel.value.shopName ||
                _profileTemp.username != profileShipperModel.value.username) {
              _showDialogVerify();
            } else {
              _eventWhenSuccessAndGoBack();
            }
          }
        }
      }
    } catch (err) {
      print(err.toString());
    }
  }

  bool checkAllEdit() {
    String errorMessageAverageCapacity =
        validatorMessageAverageCapacity(averageCapacityController.value.text);
    String errorMessage = "";
    String errorMessageWA = (PhoneNumberValidator.validate(
            value: numberWhatssappController.value.text,
            warningIfEmpty: "ProfileShipperErrorMessageWAEmpty".tr,
            warningIfFormatNotMatch:
                "ProfileShipperErrorMessageWAFalseFormat".tr)) ??
        "";
    String errorMessageNoPIC1 = (PhoneNumberValidator.validate(
            value: numberPIC1Controller.value.text,
            warningIfEmpty: "ProfileShipperErrorMessageNoPIC1Empty".tr,
            warningIfFormatNotMatch:
                "ProfileShipperErrorMessageNoPIC1FalseFormat".tr)) ??
        "";
    String errorMessageNoPIC2 = numberPIC2Controller.value.text == ""
        ? ""
        : (PhoneNumberValidator.validate(
                value: numberPIC2Controller.value.text,
                warningIfFormatNotMatch:
                    "ProfileShipperErrorMessageNoPIC2FalseFormat".tr)) ??
            "";
    String errorMessageNoPIC3 = numberPIC3Controller.value.text == ""
        ? ""
        : (PhoneNumberValidator.validate(
                value: numberPIC3Controller.value.text,
                warningIfFormatNotMatch:
                    "ProfileShipperErrorMessageNoPIC3FalseFormat".tr)) ??
            "";
    if (fullNameController.value.text == "") {
      errorMessage = "ProfileShipperErrorFullNameEmpty".tr;
    } else if (errorMessageWA != "") {
      errorMessage = errorMessageWA;
    } else if (namePIC1Controller.value.text == "") {
      errorMessage = "ProfileShipperErrorMessagePIC1NameEmpty".tr;
    } else if (errorMessageNoPIC1 != "") {
      errorMessage = errorMessageNoPIC1;
    } else if (errorMessageNoPIC2 != "") {
      errorMessage = errorMessageNoPIC2;
    } else if (errorMessageNoPIC3 != "") {
      errorMessage = errorMessageNoPIC3;
    } else if (companyNameController.value.text == "") {
      errorMessage = "ProfileShipperErrorMessageShopNameEmpty".tr;
    } else if (addressController.value.text == "") {
      errorMessage = "ProfileShipperErrorMessageAddressEmpty".tr;
    } else if (_provinceID.value == "0") {
      errorMessage = "ProfileShipperErrorMessageMustChooseProvinceID".tr;
    } else if (_cityID.value == "0") {
      errorMessage = "ProfileShipperErrorMessageMustChooseCityID".tr;
    } else if (_businessEntityID.value == "0") {
      errorMessage = "ProfileShipperErrorMessageMustChooseBusinessEntityID".tr;
    } else if (_businessFieldID.value == "0") {
      errorMessage = "ProfileShipperErrorMessageMustChooseBusinessFieldID".tr;
    } else if (_categoryCapacityID.value == "0" &&
        profileShipperModel.value.profileAccount ==
            ShipperBuyerRegisterAs.SHIPPER) {
      errorMessage =
          "ProfileShipperErrorMessageMustChooseCategoryCapacityID".tr;
    } else if (errorMessageAverageCapacity != null &&
        profileShipperModel.value.profileAccount ==
            ShipperBuyerRegisterAs.SHIPPER) {
      errorMessage = errorMessageAverageCapacity;
    } else if (postalCodeController.value.text == "") {
      errorMessage = "ProfileShipperErrorMessageEmptyPostalCode".tr;
    }
    if (errorMessage != "") {
      GlobalAlertDialog.showDialogError(
          message: errorMessage, context: Get.context);
      return false;
    }
    return true;
  }

  String validatorMessageAverageCapacity(String value) {
    String message;
    if (value.isEmpty) {
      message = 'ShipperRegisterLabelValidatorAverageCapacity'.tr;
    } else if (_categoryCapacityID == "0") {
      message = 'ShipperRegisterLabelValidatorMustChooseAverageCapacity'.tr;
    } else {
      CategoryCapacityModel dataCapacity = listCategoryCapacity
          .where((data) => data.id == int.parse(_categoryCapacityID.value))
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

  void validateAll() {
    if (_isEnableValidate) {
      bool isShowButton = false;
      for (int i = 0; i < _listTextEditingController.length; i++) {
        if (_listTextEditingController[i].text != _listInitialValue[i] &&
            _listTextEditingController[i].text != "") {
          isShowButton = true;
          break;
        }
      }
      if (!isShowButton) {
        for (int i = 0; i < _listDropDownRxString.length; i++) {
          if (_listDropDownRxString[i].value !=
                  _listInitialDropDownIDValue[i] &&
              _listDropDownRxString[i].value != "0") {
            isShowButton = true;
            break;
          }
        }
      }
      if (!isShowButton && selectedImage.value != null) {
        isShowButton = true;
      }

      isShowSaveButton.value = isShowButton;
    }
  }

  Future _showDialogVerify() async {
    return showDialog(
        context: Get.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                key: _keyDialog,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(alignment: Alignment.bottomCenter, children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomText(
                            "ProfileShipperDialogEditProfileSuccessTitle".tr,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 3, top: 3),
                            child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                  _eventWhenSuccessAndGoBack();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: Color(ListColor.color4),
                                      size: 28,
                                    ))),
                          )),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                                "ProfileShipperDialogEditProfileSuccessDesc".tr,
                                textAlign: TextAlign.center,
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: Color(ListColor.color4)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      onTap: () {
                                        Get.back(result: true);
                                        _eventWhenSuccessAndGoBack();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 10),
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CustomText(
                                                  "ProfileShipperDialogButtonVerifyEditProfileSuccess"
                                                      .tr,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.transparent),
                                              CustomText(
                                                  "ProfileShipperDialogButtonSkipEditProfileSuccess"
                                                      .tr,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      Color(ListColor.color4)),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(ListColor.color4),
                                    border: Border.all(
                                        width: 2,
                                        color: Color(ListColor.color4)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 10),
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CustomText(
                                                  "ProfileShipperDialogButtonSkipEditProfileSuccess"
                                                      .tr,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.transparent),
                                              CustomText(
                                                  "ProfileShipperDialogButtonVerifyEditProfileSuccess"
                                                      .tr,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ]),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  ],
                )),
              ));
        });
  }

  void _eventWhenSuccessAndGoBack() {
    CustomToast.show(
        context: Get.context, message: 'ProfileShipperLabelSuccessSaveData'.tr);
    Get.back(result: true);
  }

  void onClickCity() async {
    var isContinue = true;
    if (listCity.length == 1 && listCity[0].code == 0) {
      isContinue = await _getCity();
    }
    if (isContinue) {
      showDialog(
          context: Get.context,
          builder: (context) => DialogSearchDropdown(
              listItemData: listCity
                  .map((element) => DialogSearchDropdownItemModel(
                      id: element.code.toString(), value: element.city))
                  .toList(),
              onTapItem: (data) {
                setCity(data.value);
              }));
    }
  }

  void onClickProvince() async {
    var isContinue = true;
    if (listProvince.length == 1 && listProvince[0].code == 0) {
      isContinue = await _getProvince();
    }
    if (isContinue) {
      showDialog(
          context: Get.context,
          builder: (context) => DialogSearchDropdown(
              listItemData: listProvince
                  .map((element) => DialogSearchDropdownItemModel(
                      id: element.code.toString(),
                      value: element.descriptionID))
                  .toList(),
              onTapItem: (data) {
                setProvince(data.value);
              }));
    }
  }

  void onClickCategoryCapacity() async {
    var isContinue = true;
    if (listCategoryCapacity.length == 1 && listCategoryCapacity[0].id == 0) {
      isContinue = await _getCategoryCapacity();
    }
    if (isContinue) {
      showDialog(
          context: Get.context,
          builder: (context) => DialogSearchDropdown(
              listItemData: listCategoryCapacity
                  .map((element) => DialogSearchDropdownItemModel(
                      id: element.id.toString(), value: element.descriptionID))
                  .toList(),
              onTapItem: (data) {
                setCategoryCapacity(data.value);
                //setProvince(data.value);
              }));
    }
  }

  void onClickBusinessEntity() async {
    var isContinue = true;
    if (listBusinessEntity.length == 1 && listBusinessEntity[0].id == 0) {
      isContinue = await _getBusinessEntity();
    }
    if (isContinue) {
      showDialog(
          context: Get.context,
          builder: (context) => DialogSearchDropdown(
              listItemData: listBusinessEntity
                  .map((element) => DialogSearchDropdownItemModel(
                      id: element.id.toString(), value: element.descriptionID))
                  .toList(),
              onTapItem: (data) {
                setBusinessEntity(data.value);
              }));
    }
  }

  void onClickBusinessField() async {
    var isContinue = true;
    if (listBusinessField.length == 1 && listBusinessField[0].id == 0) {
      isContinue = await _getBusinessField();
    }
    if (isContinue) {
      showDialog(
          context: Get.context,
          builder: (context) => DialogSearchDropdown(
              listItemData: listBusinessField
                  .map((element) => DialogSearchDropdownItemModel(
                      id: element.id.toString(), value: element.descriptionID))
                  .toList(),
              onTapItem: (data) {
                setBusinessField(data.value);
              }));
    }
  }

  void onClickAddress() {
    showDialog(
        context: Get.context,
        builder: (context) => DialogSearchCityByGoogle(
              onTapItem: (data) {
                addressController.value.text = data.formattedAddress;
                _latLng = data.latLng;
                addressController.refresh();
                validateAll();
              },
              address: addressController.value.text,
            ));
  }
}
