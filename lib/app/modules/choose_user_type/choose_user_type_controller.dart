import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/check_after_register_login_go_to_home_function.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/modules/choose_user_type/choose_user_check_role_register_response_model.dart';
import 'package:muatmuat/app/modules/choose_user_type/choose_user_type_check_user_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:open_appstore/open_appstore.dart';

import 'choose_user_type_model.dart';

class ChooseUserTypeController extends GetxController {
  //final listData = [].obs;
  final listDataLogin = [].obs;
  final listDataRegister = [].obs;

  List<ChooseUserTypeModel> listDataAllMenu = [];

  bool _isFirstLoad = true;
  final isError = false.obs;

  @override
  void onInit() {
    listDataAllMenu.addAll([
      ChooseUserTypeModel(
          title: "LabelShipperBuyer".tr,
          onTap: () {
            checkUser();
          },
          urlIcon: "shipper_buyer_icon.png"),
      ChooseUserTypeModel(
          title: "LabelTransporter".tr,
          onTap: () {
            openOtherApps("com.azlogistik.muatmuat");
          },
          urlIcon: "transporter_icon.png"),
      ChooseUserTypeModel(
          title: "LabelSeller".tr,
          onTap: () {
            openOtherApps("com.azlogistik.muatmuat");
          },
          urlIcon: "seller_icon.png"),
      ChooseUserTypeModel(
          title: "LabelJobSeeker".tr,
          onTap: () {
            openOtherApps("com.azlogistik.muatmuat");
          },
          urlIcon: "human_capital_icon.png"),
    ]);
    listDataRegister.addAll(listDataAllMenu);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void openOtherApps(String packageName) async {
    AppAvailability.launchApp(packageName).then((_) {
      print("App launched!");
    }).catchError((err) {
      print("App not found!");
      OpenAppstore.launch(
          androidAppId: "com.sonyericsson.music", iOSAppId: "");
    });
    // if(result){

    // }
  }

  Future checkUser() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogError: true,
            isShowDialogLoading: true)
        .fetchCheckUser();
    try {
      if (result != null) {
        ChooseUserTypeCheckUserResponseModel
            chooseUserTypeCheckUserResponseModel =
            ChooseUserTypeCheckUserResponseModel.fromJson(result);
        if (chooseUserTypeCheckUserResponseModel.message.code == 200) {
          if (chooseUserTypeCheckUserResponseModel.shipperID != "0") {
            await SharedPreferencesHelper.setUserShipperID(
                chooseUserTypeCheckUserResponseModel.shipperID);
            CheckAfterRegisterLoginGoToHome.checkGoToHome();
          } else {
            CustomToast.show(context: Get.context, message: "test 6");
            Get.toNamed(Routes.SHIPPER_BUYER_REGISTER);
          }

          //listCarrierTruck.addAll(carrierTruckResponseModel.listData);
        }
      }
    } catch (err) {}
  }

  Future checkRoleRegister() async {
    isError.value = false;
    listDataLogin.clear();
    listDataRegister.clear();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogError: false,
            isShowDialogLoading: true)
        .fetchCheckRoleRegister();
    try {
      if (result != null) {
        ChooseUserCheckRoleRegisterResponseModel
            chooseUserTypeCheckUserResponseModel =
            ChooseUserCheckRoleRegisterResponseModel.fromJson(result);
        if (chooseUserTypeCheckUserResponseModel.message.code == 200) {
          if (chooseUserTypeCheckUserResponseModel.isRegisteredAsShipper) {
            listDataLogin.add(listDataAllMenu[0]);
          } else if (!chooseUserTypeCheckUserResponseModel
              .isRegisteredAsShipper) {
            listDataRegister.add(listDataAllMenu[0]);
          }
          if (chooseUserTypeCheckUserResponseModel.isRegisteredAsTransporter) {
            listDataLogin.add(listDataAllMenu[1]);
          } else if (!chooseUserTypeCheckUserResponseModel
              .isRegisteredAsTransporter) {
            listDataRegister.add(listDataAllMenu[1]);
          }
          if (chooseUserTypeCheckUserResponseModel.isRegisteredAsSeller) {
            listDataLogin.add(listDataAllMenu[2]);
          } else if (!chooseUserTypeCheckUserResponseModel
              .isRegisteredAsSeller) {
            listDataRegister.add(listDataAllMenu[2]);
          }
          if (chooseUserTypeCheckUserResponseModel.isRegisteredAsJobSeeker) {
            listDataLogin.add(listDataAllMenu[3]);
          } else if (!chooseUserTypeCheckUserResponseModel
              .isRegisteredAsJobSeeker) {
            listDataRegister.add(listDataAllMenu[3]);
          }
        }
        listDataLogin.refresh();
      } else {
        isError.value = true;
      }
    } catch (err) {}
  }

  void goToInformationPage() {
    Get.toNamed(Routes.USER_TYPE_INFORMATION);
  }

  void onCompleteBuild() async {
    if (_isFirstLoad) {
      _isFirstLoad = false;
      await checkRoleRegister();
    }
  }
}
