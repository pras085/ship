import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/terms_and_conditions_subscription_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_controller.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_menu_model.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_model.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_response_model.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';

class ProfileShipperController extends GetxController {
  final profileShipperModel = ProfileShipperModel().obs;
  final listMenu = [].obs;

  bool _isCompleteBuildWidget = false;

  @override
  void onInit() {
    super.onInit();
    //FlutterStatusbarManager.setColor(Colors.transparent);
    _addListMenu();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onCompleteBuildWidget() {
    if (!_isCompleteBuildWidget) {
      _isCompleteBuildWidget = true;
      getProfileShipper();
    }
  }

  Future getProfileShipper() async {
    try {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchProfileShipper();
      if (response != null) {
        ProfileShipperResponseModel data =
            ProfileShipperResponseModel.fromJson(response);
        profileShipperModel.value = data.profileShipperModel;
        if (profileShipperModel.value.type != "Perusahaan") {
          listMenu[3].isEnabled = false;
          listMenu[4].isEnabled = false;
          listMenu[5].isEnabled = false;
          listMenu.refresh();
        }
      }
    } catch (err) {
      printError(info: err.toString());
    }
  }

  void signOut() async {
    LoginFunction().signOut();
  }

  void _addListMenu() {
    listMenu.addAll([
      ProfileShipperMenuModel(
          "ProfileShipperLabelProfil".tr, "assets/profil_icon.svg", onTap: () {
        _getToDetailProfile();
      }),
      ProfileShipperMenuModel("ProfileShipperLabelPengaturanAkun".tr,
          "assets/pengaturan_akun_icon.svg",
          onTap: () {}),
      ProfileShipperMenuModel("ProfileShipperLabelManajemenLokasi".tr,
          "assets/manajemen_lokasi_icon.svg", onTap: () {
        // Get.toNamed(Routes.LIST_MANAGEMENT_LOKASI, preventDuplicates: true);
        GetToPage.toNamed<ListManagementLokasiController>(
            Routes.LIST_MANAGEMENT_LOKASI);
      }),
      ProfileShipperMenuModel("ProfileShipperLabelManajemenNotifikasi".tr,
          "assets/manajemen_notifikasi_icon.svg", onTap: () async {
        GlobalVariable.isDebugMode = !GlobalVariable.isDebugMode;
        CustomToast.show(
            context: Get.context,
            message: GlobalVariable.isDebugMode.toString());

        // bool isThereHistoryOrderData =
        //     await checkIsThereDataHistoryOrderSubscription();
        // if (isThereHistoryOrderData != null) {
        //   if (!isThereHistoryOrderData && isFirstTime)
        //     GetToPage.toNamed<TermsAndConditionsSubscriptionController>(
        //         Routes.TERMS_AND_CONDITIONS_SUBSCRIPTION);
        //   else
        // GetToPage.offNamed<SubscriptionHomeController>(
        //     Routes.SUBSCRIPTION_HOME);
        // }
        // else
        // GetToPage.toNamed<TermsAndConditionsSubscriptionController>(
        //     Routes.TERMS_AND_CONDITIONS_SUBSCRIPTION);
      }),
      ProfileShipperMenuModel("ProfileShipperLabelManajemenUser".tr,
          "assets/manajemen_user_icon.svg"),
      ProfileShipperMenuModel("ProfileShipperLabelManajemenRole".tr,
          "assets/manajemen_role_icon.svg"),
      ProfileShipperMenuModel(
          "ProfileShipperLabelAuditTrail".tr, "assets/audit_trail_icon.svg"),
      ProfileShipperMenuModel("ProfileShipperLabelSwitchAccount".tr,
          "assets/switch_account_icon.svg"),
    ]);
  }

  Future _getToDetailProfile() async {
    GetToPage.toNamed<ProfilePerusahaanController>(Routes.PROFILE_PERUSAHAAN);
    // if (profileShipperModel.value.type == "Individu") {
    //   var reload = await Get.toNamed(Routes.DETAIL_PROFIL_SHIPPER,
    //       arguments: profileShipperModel.value);
    //   if (reload != null) {
    //     if (reload) getProfileShipper();
    //   }
    // } else {
    //   var reload = await Get.toNamed(Routes.DETAIL_PROFIL_SHIPPER_COMPANY,
    //       arguments: profileShipperModel.value);
    //   if (reload != null) {
    //     if (reload) getProfileShipper();
    //   }
    // }
  }
}
