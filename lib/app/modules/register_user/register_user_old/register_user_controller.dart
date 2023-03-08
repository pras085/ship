import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/tac_pap_controller.dart';
import 'package:muatmuat/app/core/function/change_format_number_function.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/google_sign_in_function.dart';
import 'package:muatmuat/app/core/models/point_tac_pap_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_point_model.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_response_model.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_check_duplicate_account_response.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_check_valid_refferal_code.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_response_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_condition_point_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterUserController extends GetxController {
  var fullNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var retypePasswordController = TextEditingController().obs;
  var referralCodeController = TextEditingController().obs;

  //GoogleSignInUserController _googleUserController;
  final _keyDialog = new GlobalKey<State>();
  var userModelTemp = UserModel().obs;
  GoogleSignInFunction _googleSignInFunction = GoogleSignInFunction();
  final isDuplicateAccountEmail = false.obs;
  final isDuplicateAccountPhoneNumber = false.obs;
  final isValidateOnChange = false.obs;
  final emailDuplicate = "".obs;
  final phoneDuplicate = "".obs;
  final formKey = GlobalKey<FormState>().obs;
  final validatorMessage = "".obs;
  final isShowPassword = false.obs;
  final isShowConfirmPassword = false.obs;

  final errorMessageTermsConditionPrivacyPolicy = "".obs;
  final isErrorTermsConditionPrivacyPolicy = false.obs;
  final isSuccessTermsCondition = false.obs;
  final listPointTermsCondition = [].obs;
  final isAllCheckTermCondition = false.obs;

  final isSuccessPrivacyPolicy = false.obs;
  final listPointPrivacyPolicy = [].obs;
  final isAllCheckPrivacyPolicy = false.obs;

  TACPAPController _tacController;
  TACPAPController _papController;

  @override
  void onInit() {
    _tacController = Get.put(
        TACPAPController(
            title: "TACLabelTitle".tr,
            titleNextButton: "TACLabelNext".tr,
            onConfirm: _onAcceptTermsCondition),
        tag: "TACUsersRegister");
    _papController = Get.put(
        TACPAPController(
            title: "PAPLabelTitle".tr,
            titleNextButton: "PAPLabelNext".tr,
            onConfirm: _onAcceptPrivacyPolicy),
        tag: "PAPUsersRegister");
    GlobalVariable.tokenApp = "";
    userModelTemp.value = Get.arguments ?? UserModel();
    _checkIsGoogle();
    // try {
    //   userController = Get.find<UserController>().obs;
    // } catch (err) {
    //   userController = Get.put(UserController()).obs;
    // }
    // try {
    //   _googleUserController = Get.find();
    // } catch (err) {
    //   _googleUserController = Get.put(GoogleSignInUserController());
    // }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  // void setParam(UserModel userModel) {
  //   userController.userModel.value = userModel;
  // }

  // void clearParam() {
  //   userController.value.userModel.value = UserModel();
  // }

  void setUserModelGoogleAccount(UserModel userModel) {
    userModelTemp.value = userModel;
    _checkIsGoogle();
  }

  void _checkIsGoogle() {
    if (userModelTemp.value.isGoogle) {
      userModelTemp.value.name = "";
      fullNameController.value.text = userModelTemp.value.name;
      emailController.value.text = userModelTemp.value.email;
      fullNameController.refresh();
      emailController.refresh();
    }
  }

  void saveDataRegisterToTC() async {
    resetIsDuplicateEmailPhone();
    if (await _checkDuplicateAccount() ?? false) {
      if (userModelTemp.value.referralCode.isEmpty) {
        _showTermsCondition();
      } else if (await _checkValidRefferalCode() ?? false) {
        _showTermsCondition();
      }
    }
  }

  Future registerUser(BuildContext context) async {
    var reponseBody;
    bool isUpdateDataUsersGoogle =
        userModelTemp.value.docID != "" && userModelTemp.value.isGoogle;
    if (!isUpdateDataUsersGoogle)
      reponseBody = await ApiHelper(context: context, isShowDialogLoading: true)
          .fetchRegister(userModelTemp.value, userModelTemp.value.isGoogle);
    else
      reponseBody = await ApiHelper(context: context, isShowDialogLoading: true)
          .fetchUpdateUsersDataForIsGoogle(userModelTemp.value);

    try {
      RegisterResponseModel registerResponse =
          RegisterResponseModel.fromJson(reponseBody, isUpdateDataUsersGoogle);
      if (registerResponse.message.code == 200 &&
          (registerResponse.type == "API_Users" ||
              registerResponse.type == "API_Register_Google")) {
        if (!isUpdateDataUsersGoogle)
          userModelTemp.value.docID = registerResponse.data.docID;
        if (userModelTemp.value.isGoogle)
          Get.offAllNamed(Routes.VERIFY_PHONE, arguments: userModelTemp.value);
        else {
          var result = await Get.toNamed(Routes.VERIFY_EMAIL,
              arguments: userModelTemp.value);
          _checkResultReset(result);
        }
      } else {
        if (registerResponse.message.code == 204 &&
            registerResponse.type == "API_Verify_Running") {
          var result = await Get.toNamed(
              Routes.ERROR_REGISTER_EMAIL_STILL_VERIFY,
              arguments: userModelTemp.value.email);
          _checkResultReset(result);
        } else {
          showAlertDialogError(
              registerResponse.messageReturn == ""
                  ? 'RegisterLabelErrorRegister'.tr
                  : registerResponse.messageReturn,
              context);
        }
      }
    } catch (err) {
      print(err.toString());
    }

    return true;
  }

  void _checkResultReset(var result) {
    if (result != null) {
      if (result['reset'] != null) {
        if (result['reset']) {
          _resetAll();
        }
      }
    }
  }

  Future _checkValidRefferalCode() async {
    var reponseBody;
    reponseBody =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .getCheckValidRefferal(userModelTemp.value);
    try {
      CheckValidRefferalResponseModel checkValidRefferalResponseModel =
          CheckValidRefferalResponseModel.fromJson(reponseBody);
      if (checkValidRefferalResponseModel.message.code != 200) {
        showAlertDialogError(
            checkValidRefferalResponseModel.data == ""
                ? "RegisterErrorInvalidRefferal".tr
                : checkValidRefferalResponseModel.data,
            Get.context);
        return false;
      }
    } catch (err) {
      print('gagal catch');
      return false;
    }
    return true;
  }

  Future _checkDuplicateAccount() async {
    var reponseBody;
    reponseBody =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .fetchCheckDuplicateAccount(userModelTemp.value);
    try {
      CheckDuplicateAccountResponseModel checkDuplicateAccountResponseModel =
          CheckDuplicateAccountResponseModel.fromJson(reponseBody);
      if (checkDuplicateAccountResponseModel.message.code != 200) {
        if (checkDuplicateAccountResponseModel.message.code == 500 &&
            checkDuplicateAccountResponseModel.type ==
                "API_Users_Email_Running") {
          var result = await Get.toNamed(
              Routes.ERROR_REGISTER_EMAIL_STILL_VERIFY,
              arguments: userModelTemp.value.email);
          _checkResultReset(result);
        } else {
          isDuplicateAccountEmail.value =
              checkDuplicateAccountResponseModel.type ==
                  "API_Users_Email_Registered";
          isDuplicateAccountPhoneNumber.value =
              checkDuplicateAccountResponseModel.type ==
                  "API_Users_Phone_Registered";
          if (isDuplicateAccountEmail.value)
            emailDuplicate.value = userModelTemp.value.email;
          else if (isDuplicateAccountPhoneNumber.value)
            phoneDuplicate.value = userModelTemp.value.phone;

          if (isDuplicateAccountPhoneNumber.value ||
              isDuplicateAccountEmail.value) {
            formKey.value.currentState.validate();
          }
          showAlertDialogError(
              checkDuplicateAccountResponseModel.data == ""
                  ? 'RegisterLabelErrorRegister'.tr
                  : checkDuplicateAccountResponseModel.data,
              Get.context);
        }
        return false;
      }
    } catch (err) {
      //showAlertDialogError("", context);
      return false;
    }
    return true;
  }

  void showAlertDialogError(String message, BuildContext context) {
    GlobalAlertDialog.showDialogError(message: message, context: context);
  }

  void signInGoogle(BuildContext context) {
    _googleSignInFunction.signInWithGoogle(true, context);
  }

  void resetIsDuplicateEmailPhone() {
    isDuplicateAccountEmail.value = false;
    isDuplicateAccountPhoneNumber.value = false;
    emailDuplicate.value = "";
    phoneDuplicate.value = "";
  }

  void onSaving() async {
    isValidateOnChange.value = true;
    if (validateAll()) {
      userModelTemp.value.name = fullNameController.value.text;
      userModelTemp.value.email = emailController.value.text;
      userModelTemp.value.phone =
          convertPhoneNumber(phoneController.value.text);
      userModelTemp.value.password = passwordController.value.text;
      userModelTemp.value.referralCode = referralCodeController.value.text;
      userModelTemp.value.isGoogle = userModelTemp.value.isGoogle;
      saveDataRegisterToTC();

      //Get.offNamed(Routes.BIGFLEETS);
    }
  }

  bool validateAll() {
    validatorMessage.value = "";
    return formKey.value.currentState.validate();
  }

  String convertPhoneNumber(String number) {
    return ChangeFormatNumberFunction.convertPhoneNumber(number);
  }

  void addValidatorMessage(String message) {
    validatorMessage.value =
        (validatorMessage.value != "" ? (validatorMessage.value + "\n") : "") +
            message;
  }

  void setIsShowPassword(bool value) {
    isShowPassword.value = value;
  }

  void setIsShowConfirmPassword(bool value) {
    isShowConfirmPassword.value = value;
  }

  void _showTermsCondition() {
    _getDataTermsCondition();
    _tacController.showModalBottomSheetIsGettingDataPointTrue();
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
  //         child: CustomText('TACButtonNext'.tr,
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
    //   // && isAgreeTC2.value
    //   _getDataPrivacyPolicy();
    //   _showPrivacyPolicy();
    //   //Get.toNamed(Routes.PRIVACY_AND_POLICY, arguments: Get.arguments);
    // } else {
    //   _showAlertDialogError('TACLabelErrorCheck'.tr, Get.context);
    // }
  }

  Future _getDataTermsCondition() async {
    isSuccessTermsCondition.value = false;
    listPointTermsCondition.clear();
    _resetError();
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchTermCondition();
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

  void _showPrivacyPolicy() {
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
    //               'PAPLabelTitle'.tr,
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
    registerUser(Get.context);
    // if (_isAllCheckedPrivacyPolicy()) {
    //   // && isAgreeTC2.value
    //   Get.back();
    //   Get.back();
    //   registerUser(Get.context);
    // } else {
    //   _showAlertDialogError('PAPLabelErrorCheck'.tr, Get.context);
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
        .fetchPrivacyPolicy();
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

  List<Widget> _getListPrivacyAndPolicy() {
    List<Widget> list = [];
    if (listPointPrivacyPolicy.length > 0) {
      for (int i = 0; i < listPointPrivacyPolicy.length; i++) {
        PrivacyAndPolicyPointModel privacyAndPolicyPointModel =
            listPointPrivacyPolicy[i];
        list.add(_getDetailPrivacyAndPolicy(privacyAndPolicyPointModel, i));
      }
    }
    if (isSuccessPrivacyPolicy.value)
      list.add(Obx(() => MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              side: isAllCheckPrivacyPolicy.value
                  ? BorderSide.none
                  : BorderSide(
                      color: Color(ListColor.colorDarkGrey), width: 2)),
          color: Color(isAllCheckPrivacyPolicy.value
              ? ListColor.color4
              : ListColor.colorLightGrey),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          onPressed: () {
            if (isAllCheckPrivacyPolicy.value) _onAcceptPrivacyPolicy();
          },
          child: CustomText('PAPButtonNext'.tr,
              fontSize: 14,
              color: isAllCheckPrivacyPolicy.value
                  ? Colors.white
                  : Color(ListColor.colorGrey),
              fontWeight: FontWeight.w600))));
    return list;
  }

  Widget _getDetailPrivacyAndPolicy(
      PrivacyAndPolicyPointModel privacyAndPolicyPointModel, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        index == 0
            ? SizedBox.shrink()
            : Theme(
                data: ThemeData(unselectedWidgetColor: Color(ListColor.color4)),
                child: Checkbox(
                  value: privacyAndPolicyPointModel.isChecked,
                  onChanged: isSuccessPrivacyPolicy.value
                      ? (value) {
                          setCheckboxPrivacyPolicy(value, index);
                        }
                      : null,
                  checkColor: Colors.white,
                  activeColor: Color(ListColor.color4),
                ),
              ),
        Expanded(
          child: Html(
            data: privacyAndPolicyPointModel.data,
            onLinkTap: (url) {
              print("Opening $url...");
              urlLauncher(url);
            },
          ),
        ),
      ],
    );
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12),
    //           border: Border.all(width: 1, color: Colors.grey),
    //         ),
    //         child: Html(
    //           data: privacyAndPolicyPointModel.data,
    //           onLinkTap: (url) {
    //             print("Opening $url...");
    //             controller.urlLauncher(url);
    //           },
    //         )),
    //     Row(
    //       children: [
    //         Checkbox(
    //           value: privacyAndPolicyPointModel.isChecked,
    //           onChanged: controller.isSuccess.value
    //               ? (value) {
    //                   controller.setCheckbox(value, index);
    //                 }
    //               : null,
    //           checkColor: Color(ListColor.colorBlue),
    //           activeColor: Colors.transparent,
    //         ),
    //         Expanded(
    //           child: Text('TACLabelAgree'.tr,
    //               style: TextStyle(
    //                   color: Colors.black, fontWeight: FontWeight.bold)),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }

  void _resetAll() {
    isValidateOnChange.value = false;
    fullNameController.value.text = "";
    emailController.value.text = "";
    phoneController.value.text = "";
    passwordController.value.text = "";
    retypePasswordController.value.text = "";
    referralCodeController.value.text = "";
  }
}
