import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/loading_dialog.dart';
import 'package:muatmuat/app/core/function/validator/phoine_number_validator.dart';
import 'package:muatmuat/app/core/models/dialog_search_dropdown_item_model.dart';
import 'package:muatmuat/app/modules/detail_profil_shipper/detail_profil_shipper_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/category_capacity_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/city_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/province_model.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_as_enum.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_category_capacity_response.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_city_response.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_province_response.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/core/function/dialog_search_city_by_google.dart';
import 'package:muatmuat/app/core/function/dialog_search_dropdown.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class DetailProfilShipperController extends GetxController {
  final profileShipperModel = ProfileShipperModel().obs;

  final fullNameController = TextEditingController().obs;
  final numberWhatssappController = TextEditingController().obs;
  final shopNameController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final provinceController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final averageCapacityController = TextEditingController().obs;

  final fullNameFocusNode = FocusNode().obs;
  final numberWhatssappFocusNode = FocusNode().obs;
  final shopNameFocusNode = FocusNode().obs;
  final addressFocusNode = FocusNode().obs;
  final provinceFocusNode = FocusNode().obs;
  final cityFocusNode = FocusNode().obs;
  final postalCodeFocusNode = FocusNode().obs;
  final averageCapacityFocusNode = FocusNode().obs;

  final isShowSaveButton = false.obs;

  final formKey = GlobalKey<FormState>().obs;
  final verifyKey = GlobalKey().obs;

  final listProvince = [].obs;
  final listCity = [].obs;
  final listCategoryCapacity = [].obs;

  final province = "".obs;
  final city = "".obs;
  final categoryCapacity = "".obs;
  final _provinceID = "0".obs;
  final _cityID = "0".obs;
  final _categoryCapacityID = "0".obs;

  final contentPaddingTextFormFieldVerify = EdgeInsets.zero.obs;

  final globalKeyContainerAddress = GlobalKey<FormState>();

  double widthAddressContainer = 0;
  double heightAddressContainer = 0;
  LatLng _latLng;

  List<TextEditingController> _listTextEditingController = [];
  List<String> _listInitialValue = [];
  List<String> _listInitialDropDownIDValue = [];
  List<RxString> _listDropDownRxString = [];
  List<Rx<FocusNode>> _listInitialFocusNode = [];

  final String _defaultProvince = "ProfileShipperLabelDefaultProvince".tr;
  final String _defaultCity = "ProfileShipperLabelDefaultCity".tr;
  final String _defaultCategoryCapacity =
      "ProfileShipperLabelDefaultCategoryCapacity".tr;

  bool _isCompleteBuildWidget = false;
  bool _isEnableValidate = false;

  var selectedImage = File("").obs;

  final _keyDialog = new GlobalKey<State>();

  ProfileShipperModel _profileTemp;

  int _posGetData = 0;
  //final shopNameController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    selectedImage.value = null;
    profileShipperModel.value = Get.arguments;
    _profileTemp = ProfileShipperModel.copy(profileShipperModel.value);
    if (profileShipperModel.value.latitude != "" &&
        profileShipperModel.value.longitude != "") {
      _latLng = LatLng(double.parse(profileShipperModel.value.latitude),
          double.parse(profileShipperModel.value.longitude));
    }
    _addFirstData();
    _initialListController();
    _initialListInitialValue();
    _initialFocusNode();
    _addListenerAllFocusNode();
    _initialDropDownRxString();
    _initialDropDownValue();
    // numberWhatssappFocusNode.value.addListener(() {
    //   numberWhatssappFocusNode.refresh();
    // });
    // addressFocusNode.value.addListener(() {
    //   addressFocusNode.refresh();
    // });
    // provinceFocusNode.value.addListener(() {
    //   provinceFocusNode.refresh();
    // });
    // cityFocusNode.value.addListener(() {
    //   cityFocusNode.refresh();
    // });
    // postalCodeFocusNode.value.addListener(() {
    //   postalCodeFocusNode.refresh();
    // });
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
    fullNameController.value.text = profileShipperModel.value.username;
    shopNameController.value.text = profileShipperModel.value.shopName;
    postalCodeController.value.text = profileShipperModel.value.postalCode;
    addressController.value.text = profileShipperModel.value.address;
    averageCapacityController.value.text = profileShipperModel.value.capacity;
    numberWhatssappController.value.text =
        profileShipperModel.value.numberWhatssapp;
    _listTextEditingController = [
      fullNameController.value,
      numberWhatssappController.value,
      shopNameController.value,
      addressController.value,
      provinceController.value,
      cityController.value,
      postalCodeController.value,
      averageCapacityController.value
    ];
  }

  void _initialListInitialValue() {
    _listInitialValue = [
      fullNameController.value.text,
      numberWhatssappController.value.text,
      shopNameController.value.text,
      addressController.value.text,
      provinceController.value.text,
      cityController.value.text,
      postalCodeController.value.text,
      averageCapacityController.value.text,
    ];
  }

  void _initialFocusNode() {
    _listInitialFocusNode = [
      fullNameFocusNode,
      numberWhatssappFocusNode,
      shopNameFocusNode,
      addressFocusNode,
      provinceFocusNode,
      cityFocusNode,
      postalCodeFocusNode,
      averageCapacityFocusNode,
    ];
  }

  void _initialDropDownRxString() {
    _listDropDownRxString = [_provinceID, _cityID, _categoryCapacityID];
  }

  void _initialDropDownValue() {
    _listInitialDropDownIDValue = [
      profileShipperModel.value.provinceCode,
      profileShipperModel.value.cityID,
      profileShipperModel.value.categoryCapacityID
    ];
  }

  void _addListenerAllFocusNode() {
    for (int i = 0; i < _listInitialFocusNode.length; i++) {
      _listInitialFocusNode[i].value.addListener(() {
        _listInitialFocusNode[i].refresh();
      });
    }
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
  }

  Future setProvince(String value) async {
    //isShowCity.value = false;
    province.value = value;
    setCity(_defaultCity);
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

  Future<bool> _getCity() async {
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
      response = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: true,
              isShowDialogError: true)
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
              isShowDialogLoading: true,
              isShowDialogError: true)
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
        _processSaving();
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future _processSaving() async {
    try {
      profileShipperModel.value.numberWhatssapp =
          numberWhatssappController.value.text;
      profileShipperModel.value.username = fullNameController.value.text;
      profileShipperModel.value.shopName = shopNameController.value.text;
      profileShipperModel.value.address = addressController.value.text;
      profileShipperModel.value.provinceCode = _provinceID.value;
      profileShipperModel.value.cityID = _cityID.value;
      profileShipperModel.value.categoryCapacityID = _categoryCapacityID.value;
      profileShipperModel.value.capacity = averageCapacityController.value.text;
      profileShipperModel.value.postalCode = postalCodeController.value.text;
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
          // Fluttertoast.showToast(
          //     msg: 'ProfileShipperLabelSuccessSaveData'.tr);
          //Get.back(result: true);
          if (_profileTemp.shopName != profileShipperModel.value.shopName ||
              _profileTemp.username != profileShipperModel.value.username) {
            _showDialogVerify();
          } else {
            _eventWhenSuccessAndGoBack();
          }
        }
      }
    } catch (err) {
      print(err.toString());
    }
  }

  void _eventWhenSuccessAndGoBack() {
    CustomToast.show(
        context: Get.context, message: 'ProfileShipperLabelSuccessSaveData'.tr);
    Get.back(result: true);
  }

  bool checkAllEdit() {
    String errorMessageAverageCapacity =
        validatorMessageAverageCapacity(averageCapacityController.value.text);
    String errorMessage = "";
    String errorMessageWA = PhoneNumberValidator.validate(
            value: numberWhatssappController.value.text,
            warningIfEmpty: "ProfileShipperErrorMessageWAEmpty".tr,
            warningIfFormatNotMatch:
                "ProfileShipperErrorMessageWAFalseFormat".tr) ??
        "";
    if (fullNameController.value.text == "") {
      errorMessage = "ProfileShipperErrorFullNameEmpty".tr;
    } else if (errorMessageWA != "") {
      errorMessage = errorMessageWA;
    } else if (shopNameController.value.text == "") {
      errorMessage = "ProfileShipperErrorMessageShopNameEmpty".tr;
    } else if (addressController.value.text == "") {
      errorMessage = "ProfileShipperErrorMessageAddressEmpty".tr;
    } else if (_provinceID.value == "0") {
      errorMessage = "ProfileShipperErrorMessageMustChooseProvinceID".tr;
    } else if (_cityID.value == "0") {
      errorMessage = "ProfileShipperErrorMessageMustChooseCityID".tr;
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

  Future _getAllData() async {
    bool isError = false;
    LoadingDialog loadingDialog = LoadingDialog(Get.context);
    loadingDialog.showLoadingDialog();
    for (int i = _posGetData; i < 2; i++) {
      _posGetData = i;
      switch (i) {
        case 0:
          isError = !await _getCategoryCapacity();
          break;
        case 1:
          isError = !await _getProvince();
          break;
      }

      if (isError) {
        break;
      }
    }

    loadingDialog.dismissDialog();
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
