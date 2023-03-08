import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_metode_pembayaran.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/api_tm_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pilih_metode_pembayaran/tm_subscription_pilih_metode_pembayaran_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pembayaran_subscription/tm_pembayaran_subscription_response_model.dart';
import 'package:flutter/services.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class TMPembayaranSubscriptionController extends GetxController {
  TMMetodePembayaranModel metodePembayaran = TMMetodePembayaranModel();
  double jumlahPembayaran = 0;
  // DateTime batasPembayaran = DateTime.now().add(Duration(days: 1));
  var batasPembayaran = "";
  var subtotal = 0;
  var totalSubuser = 0;
  var totalFreeSubuser = 0;
  var voucherCode = "";
  var voucherAmount = 0.0;
  var biayaLayanan = 0.0;
  var totalPajak = 0.0;
  var isSubuser = false;
  var orderID = 0;
  var isNext = '0';

  var listLangkahPembayaran = [].obs;
  var listExpanded = [].obs;
  // RxInt selectedCategory = 0.obs;
  // RxInt selectedContent = 0.obs;

  bool _isFirstBuild = true;
  var onLoading = false.obs;
  var loadingUpdate = false.obs;

  var isChangePayment = false.obs;
  // final LoadingDialog _loadingDialog = LoadingDialog(Get.context);

  final scaffoldKey = GlobalKey<ScaffoldState>().obs;
  var dateTimeAPIFormat = DateFormat('yyyy-MM-dd');

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null) {
      metodePembayaran = arguments[0] ?? TMMetodePembayaranModel();
      jumlahPembayaran = arguments[1] ?? 0;
      // batasPembayaran = arguments[2] ?? DateTime.now().add(Duration(days: 1));
      batasPembayaran = arguments[2] ?? "";
      subtotal = arguments[3];
      totalSubuser = arguments[4];
      totalFreeSubuser = arguments[5];
      voucherCode = arguments[6];
      voucherAmount = arguments[7];
      biayaLayanan = arguments[8];
      totalPajak = arguments[9];
      isSubuser = arguments[10];
      orderID = arguments[11];
      isNext = arguments[12] ? "1" : "0";
    }
    _getListLangkahPembayaran();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void afterBuild() {}

  Future<bool> onWillPop() async {
    if (onLoading.value) {
      return Future.value(false);
    }
    getBack();
    return Future.value(true);
  }

  void getBack() {
    if (isChangePayment.value) {
      Get.back(
        result: ["", "justRefresh", metodePembayaran.paymentID == "8",],
      );
    } else {
      Get.back();
    }
  }

  void changeMetode() async {
    var result =
        await GetToPage.toNamed<TMSubscriptionPilihMetodePembayaranController>(
            Routes.TM_SUBSCRIPTION_PILIH_METODE_PEMBAYARAN,
            arguments: [
          subtotal.toDouble(),
          batasPembayaran,
          totalSubuser,
          totalFreeSubuser,
          voucherCode,
          voucherAmount,
          biayaLayanan,
          totalPajak,
          jumlahPembayaran,
          metodePembayaran.paymentID
        ]);
    if (result != null) {
      // metodePembayaran.value = result;
      // metodePembayaran.refresh();
      var metode = TMMetodePembayaranModel(
          paymentID: result[0]["PaymentID"],
          noRek: result[0]["NoRek"],
          paymentName: result[0]["PaymentName"],
          thumbnail: result[0]["Thumbnail"]);
      loadingUpdate.value = true;
      var update = await updateMetode(metode);
      if (update && metode.paymentID == "8") updateStatusPayment();
      if (metode.paymentID != "8") loadingUpdate.value = false;
    }
  }

  Future<bool> updateMetode(TMMetodePembayaranModel metode) async {
    var result = await ApiTMSubscription(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: true)
        .doUpdatePaymentSubscription(
            orderID.toString(), isSubuser ? "1" : "0", metode.paymentID);
    if (result != null) {
      if (result["Message"]["Code"] == 200) {
        isChangePayment.value = true;
        metodePembayaran = metode;
        return Future.value(true);
      } else {
        GlobalAlertDialog.showDialogError(
            context: Get.context,
            title: "",
            message: result["Data"]["Message"],
            labelButtonPriority1: "Ok");
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  void updateStatusPayment() async {
    // if (loadingUpdate.value) {
    //   return;
    // } else {
    loadingUpdate.value = true;
    // }
    var result = !isSubuser
        ? await ApiTMSubscription(
                context: Get.context,
                isShowDialogLoading: false,
                isShowDialogError: true)
            .doUpdateStatusOrderSubscription(orderID.toString())
        : await ApiTMSubscription(
                context: Get.context,
                isShowDialogLoading: false,
                isShowDialogError: true)
            .doUpdateStatusOrderSubuser(orderID.toString(), isNext);
    if (result != null) {
      if (result["Message"]["Code"] == 200) {
        if (isSubuser) {
          Get.back(result: ["", null, metodePembayaran.paymentID == "8",]);
        } else {
          var responseOrder = await ApiTMSubscription(
                  context: Get.context, isShowDialogLoading: false)
              .getDetailOrderByShipper({"OrderID": orderID.toString()});
          if (responseOrder != null) {
            Get.back(result: [
              responseOrder["Footer"][0]["NamaPaket"],
              responseOrder["Footer"][0]["PeriodePaket"],
              metodePembayaran.paymentID == "8",
            ]);
          }
        }
      } else {
        GlobalAlertDialog.showDialogError(
            context: Get.context,
            title: "",
            message: result["Data"]["Message"],
            labelButtonPriority1: "Ok");
      }
    }
    loadingUpdate.value = false;
  }

  Future<void> _getListLangkahPembayaran() async {
    if (_isFirstBuild) {
      _isFirstBuild = false;
      onLoading.value = true;
      // _loadingDialog.showLoadingDialog();
    }
    try {
      var response = await ApiTMSubscription(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: true)
          .getListStepPayment();
      if (response != null) {
        TMPembayaranSubscriptionResponseModel
            pembayaranSubscriptionResponseModel =
            TMPembayaranSubscriptionResponseModel.fromJson(response);
        listLangkahPembayaran.clear();
        listLangkahPembayaran.addAll(
            pembayaranSubscriptionResponseModel.listTipeLangkahPembayaran);
        listExpanded.clear();
        for (int i = 0; i < listLangkahPembayaran.length; i++) {
          listExpanded.add(true);
        }
      }
    } catch (err) {
      print("Debug: Respon = $err.toString()");
    }
    onLoading.value = false;
    // _loadingDialog.dismissDialog();
  }

  Future<bool> simpan() async {
    return true;
  }

  showPopupBerhasilSalinNoRek() {
    CustomToast.show(
        context: Get.context, message: "SubscriptionAlertCopyAccountNumber".tr);
  }

  showPopupBerhasilSalinTotalBayar() {
    CustomToast.show(
        context: Get.context, message: "SubscriptionAlertCopyTotalPayment".tr);
  }

  onClickSalinNoRek() async {
    await Clipboard.setData(
        ClipboardData(text: metodePembayaran.noRek.toString()));
    showPopupBerhasilSalinNoRek();
  }

  onClickSalinTotalBayar() async {
    await Clipboard.setData(
        ClipboardData(text: jumlahPembayaran.round().toString()));
    showPopupBerhasilSalinTotalBayar();
  }

  onClickOk() async {
    bool result = false;
    result = await simpan();

    if (result) {}
  }

  onClickUbahPembayaran() {}
}

class RxDateTime {}
