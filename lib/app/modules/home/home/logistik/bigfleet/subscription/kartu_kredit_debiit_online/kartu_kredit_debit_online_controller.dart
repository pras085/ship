import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/metode_pembayaran.dart';
import 'package:muatmuat/app/utils/utils.dart';

class KartuKreditDebitOnlineController extends GetxController {
  MetodePembayaranModel metodePembayaran = MetodePembayaranModel();
  double subtotal = 0;
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

  final textNoKartu = TextEditingController();
  final textMasaBerlaku = TextEditingController();
  final textCVV = TextEditingController();
  var showCVV = false.obs;
  var pilihPembayaran = "0".obs;
  List listPilihPembayaran = ["SubscriptionFull".tr];
  var isExpanded = false.obs;
  var valid = false.obs;

  // var listMetodePembayaran = [].obs;
  // RxInt selectedCategory = 0.obs;
  // RxInt selectedContent = 0.obs;

  var onLoading = false.obs;
  // final LoadingDialog _loadingDialog = LoadingDialog(Get.context);

  final scaffoldKey = GlobalKey<ScaffoldState>().obs;

  @override
  void onInit() {
    pilihPembayaran.value = null;
    var arguments = Get.arguments;
    if (arguments != null) {
      metodePembayaran = Get.arguments[0];
      subtotal = Get.arguments[1] ?? 0;
      // batasPembayaran =
      //     Get.arguments[2] ?? DateTime.now().add(Duration(days: 1));
      batasPembayaran = Get.arguments[2] ?? "";
      // paket = Get.arguments[3] ?? [];
      // harga = Get.arguments[4] ?? [];
      subuser = Get.arguments[3] ?? 0;
      freeSubuser = Get.arguments[4] ?? 0;
      kodeVoucher = Get.arguments[5] ?? "";
      discVoucher = Get.arguments[6] ?? 0;
      biayaLayanan = Get.arguments[7] ?? 0;
      pajak = Get.arguments[8] ?? 0;
      totalPesanan = Get.arguments[9] ?? 0;

      // var numberFormat = new NumberFormat("#,##0.00", "en_US");
      listPilihPembayaran.clear();
      // listPilihPembayaran.add('SubscriptionSelectPayment'.tr);
      listPilihPembayaran.add("SubscriptionFull".tr);
      listPilihPembayaran.add(
          "${'SubscriptionMonthInstallment'.tr} x ${Utils.formatUang(((totalPesanan ?? 0.0) / 12).ceil().toDouble())}");
      print('Debug: ' + 'metodePembayaran = ' + metodePembayaran.toString());
      print('Debug: ' + 'jumlahPembayaran = ' + subtotal.toString());
      print('Debug: ' + 'totalPesanan = ' + totalPesanan.toString());
    }

    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void afterBuild() {
    // _getListMetodePembayaran();
  }

  Future<bool> onWillPop() async {
    if (onLoading.value) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  void checkValid() {
    var textKartu = textNoKartu.text.replaceAll(" ", "");
    var waktu = textMasaBerlaku.text.replaceAll("/", "");
    var cekNoKartu = textKartu.isNotEmpty && textKartu.length == 16;
    var cekMasaBerlaku = waktu.isNotEmpty && waktu.length == 4;
    var cekCVV = textCVV.text.isNotEmpty && textCVV.text.length == 3;
    valid.value =
        cekNoKartu && cekMasaBerlaku && cekCVV && pilihPembayaran.value != null;
  }

  // Future<void> _getListMetodePembayaran() async {
  //   if (_isFirstBuild) {
  //     _isFirstBuild = false;
  //     selectedCategory.value = -1;
  //     selectedContent.value = -1;
  //     _loadingDialog.showLoadingDialog();
  //   }
  //   try {
  //     var response = await ApiHelper(
  //             context: Get.context,
  //             isShowDialogLoading: true,
  //             isShowDialogError: true)
  //         .getListMetodePembayaran();
  //     if (response != null) {
  //       KartuKreditDebitOnlineResponseModel pilihMetodePembayaranResponseModel =
  //           KartuKreditDebitOnlineResponseModel.fromJson(response);
  //       listMetodePembayaran.addAll(
  //           pilihMetodePembayaranResponseModel.listCategoryMetodePembayaran);
  //     }
  //   } catch (err) {
  //     print("Debug: Respon = $err.toString()");
  //   }
  //   _loadingDialog.dismissDialog();
  // }

  Future<bool> simpan() async {
    return true;
  }

  onClickOk() async {
    bool result = false;
    result = await simpan();

    if (result) {
      Get.back(result: true);
    }
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex == 2 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
