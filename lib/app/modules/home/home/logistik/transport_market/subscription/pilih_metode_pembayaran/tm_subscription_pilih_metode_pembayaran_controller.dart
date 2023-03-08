import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_category_metode_pembayaran.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_metode_pembayaran.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/api_tm_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pilih_metode_pembayaran/tm_subscription_pilih_metode_pembayaran_response_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/kartu_kredit_debiit_online/tm_kartu_kredit_debit_online_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class TMSubscriptionPilihMetodePembayaranController extends GetxController {
  double jumlahPembayaran = 0;
  // DateTime batasPembayaran = DateTime.now().add(Duration(days: 1));
  String batasPembayaran = "";
  // List paket = [];
  // List harga = [];
  int subuser = 0;
  int freeSubuser = 0;
  String kodeVoucher = "";
  double discVoucher = 0;
  double biayaLayanan = 0;
  double pajak = 0;
  double totalPesanan;
  String selectedPaymentID;

  var listMetodePembayaran = [].obs;
  var listExpanded = [].obs;
  RxString selectedCategory = "0".obs;
  RxString selectedContent = "0".obs;

  bool _isFirstBuild = true;
  var onLoading = false.obs;
  // final LoadingDialog _loadingDialog = LoadingDialog(Get.context);

  final scaffoldKey = GlobalKey<ScaffoldState>().obs;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null) {
      jumlahPembayaran = Get.arguments[0] ?? 0;
      // batasPembayaran =
      //     Get.arguments[1] ?? DateTime.now().add(Duration(days: 1));
      batasPembayaran = Get.arguments[1] ?? "";
      // paket = Get.arguments[2] ?? [];
      // harga = Get.arguments[3] ?? [];
      subuser = Get.arguments[2] ?? 0;
      freeSubuser = Get.arguments[3] ?? 0;
      kodeVoucher = Get.arguments[4] ?? "";
      discVoucher = Get.arguments[5] ?? 0;
      biayaLayanan = Get.arguments[6] ?? 0;
      pajak = Get.arguments[7] ?? 0;
      totalPesanan = Get.arguments[8] ?? 0;
    }
    if (Get.arguments.length > 9 && Get.arguments[9] != null) {
      selectedPaymentID = Get.arguments[9];
      // selectedCategory.value = Get.arguments[9][0];
      // selectedContent.value = Get.arguments[9][1];
    }
    _getListMetodePembayaran();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void afterBuild() {}

  Future<bool> onWillPop() async {
    print('Debug: ' + 'onLoading = ' + onLoading.value.toString());
    if (onLoading.value) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> _getListMetodePembayaran() async {
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
          .getListPaymentMethod();
      if (response != null) {
        TMSubscriptionPilihMetodePembayaranResponseModel
            pilihMetodePembayaranResponseModel =
            TMSubscriptionPilihMetodePembayaranResponseModel.fromJson(response);
        if (selectedPaymentID != null && selectedPaymentID.isNotEmpty) {
          pilihMetodePembayaranResponseModel.listCategoryMetodePembayaran
              .forEach((element) {
            element.content.forEach((contentElement) {
              if (contentElement.paymentID == selectedPaymentID) {
                selectedCategory.value = element.categoryID;
                selectedContent.value = selectedPaymentID;
              }
            });
          });
        }
        listMetodePembayaran.clear();
        listMetodePembayaran.addAll(
            pilihMetodePembayaranResponseModel.listCategoryMetodePembayaran);
        listExpanded.clear();
        for (int i = 0; i < listMetodePembayaran.length; i++) {
          if (i == 0)
            listExpanded.add(true);
          else
            listExpanded.add(false);
        }
      }
    } catch (err) {
      print("Debug: Respon = $err.toString()");
    }
    onLoading.value = false;
    // _loadingDialog.dismissDialog();
  }

  updateSelected(String _categoryID, String _paymentID) {
    print('Debug: ' +
        'updateSelected ' +
        _categoryID.toString() +
        ' ' +
        _paymentID.toString());
    selectedCategory.value = _categoryID;
    selectedContent.value = _paymentID;
  }

  onClickOk() async {
    TMCategoryMetodePembayaranModel category;
    TMMetodePembayaranModel content;
    category = listMetodePembayaran
        .firstWhere((element) => element.categoryID == selectedCategory.value);
    if (category != null) {
      content = category.content
          .firstWhere((element) => element.paymentID == selectedContent.value);
    }

    print('Debug: ' + 'content = ' + content.paymentName.toString());

    if (selectedCategory.value == "1") {
      Get.back(result: [
        {
          "PaymentID": content.paymentID,
          "PaymentName": content.paymentName,
          "NoRek": content.noRek,
          "Thumbnail": content.thumbnail,
          "SelectedCategory": selectedCategory,
          "SelectedContent": selectedContent
        }
      ]);
    } else if (selectedCategory.value == "2") {
      var result = await GetToPage.toNamed<TMKartuKreditDebitOnlineController>(
          Routes.TM_KARTU_KREDIT_DEBIT_ONLINE,
          arguments: [
            content,
            jumlahPembayaran,
            batasPembayaran,
            // paket,
            // harga,
            subuser,
            freeSubuser,
            kodeVoucher,
            discVoucher,
            biayaLayanan,
            pajak,
            totalPesanan,
          ]);
      if (result != null && result == true) {
        Get.back(result: [
          {
            "PaymentID": content.paymentID,
            "PaymentName": content.paymentName,
            "NoRek": content.noRek,
            "Thumbnail": content.thumbnail,
            "SelectedCategory": selectedCategory,
            "SelectedContent": selectedContent
          }
        ]);
      }
    }
  }
}
