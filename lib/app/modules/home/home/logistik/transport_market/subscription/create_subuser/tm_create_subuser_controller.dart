import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/onchange_textfield_number.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_metode_pembayaran.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/api_tm_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pilih_metode_pembayaran/tm_subscription_pilih_metode_pembayaran_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_subuser/tm_choose_subuser_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_voucher/tm_choose_voucher_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pembayaran_subscription/tm_pembayaran_subscription_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class TMCreateSubuserController extends GetxController {
  var biayaLayanan = 0.obs;
  var pajak = 0.obs;
  var biayaLayananString = "BiayaLayanan";
  var pajakString = "Pajak";

  var orderID = "".obs;
  var paketSubscriptionID = "".obs;
  var paketSubscriptionName = "".obs;
  var isNext = false;
  var paketSubscriptionPeriode = "".obs;
  var paketSubscriptionPeriodeAwalFull = "".obs;
  var paketSubscriptionPeriodeAkhirFull = "".obs;
  var paketSubscriptionDotAkhirFull = "".obs;
  var paketSubscriptionPeriodeAwal = DateTime.now().obs;
  var paketSubscriptionPeriodeAkhir = DateTime.now().obs;

  var needRefresh = true;
  var loadTotalSubuser = false.obs;
  var loadTimeline = false.obs;
  var onDeleting = false;
  var totalSemuaPaketSubuser = 0.obs;
  var jumlahPaketSubuser = 1.obs;
  var listPaketSubuser = [].obs;
  var totalHargaSubuser = 0.obs;
  var subuserTax = "Tax";
  var subuserLayanan = "AdditionalFee";
  var subuserID = "PaketID";
  var subuserName = "PaketName";
  var subuserDurasi = "Durasi";
  var subuserHarga = "Harga";
  var subuserQtySubuser = "QtySubUsers";
  var subuserDescription = "Description";
  var subuserInfo = "StrInfo";
  var subuserTotal = "Total";
  var subuserSubTotal = "SubTotal";
  var subUserController = "SubuserController";

  var paketLanggananIDName = "paketLanggananID";
  var usedPaketSubuserName = "usedPaketSubuser";
  var nextLanggananName = "nextLangganan";
  var fromBigfleetName = "fromBigfleet";

  var listVoucher = [].obs;
  var voucherPaketID = "PaketID";
  var voucherID = "VoucherID";
  var voucherCode = "VoucherCode";
  var voucherAmount = "Amount";
  var voucherFreeUser = "FreeUser";
  var voucherHargaPaket = "HargaPaket";
  var voucherDiskon = "Diskon";

  var metodePembayaran = [].obs;
  var paymentID = "PaymentID";
  var paymentName = "PaymentName";
  var paymentNoRek = "NoRek";
  var paymentThumbnail = "Thumbnail";
  var selectedCategory = "SelectedCategory";
  var selectedContent = "SelectedContent";

  var subtotal = 0.obs;
  var totalSubuser = 0.obs;
  var totalFreeSubuser = 0.obs;
  var totalPajak = 0.0.obs;
  var totalPesanan = 0.0.obs;

  var cekPaketID = "ID";
  var cekPaketQty = "Qty";

  var listNeedRefreshPeriode = [].obs;

  var dateTimeAPIFormat = DateFormat('yyyy-MM-dd');
  // var dateTimeFormat = DateFormat('dd MMM yyyy');
  var dateTimeFullFormat = DateFormat('dd MMM yyyy HH:mm');

  var listPeriodeSubuser = [].obs;
  var selectedPeriodeSubuser = [].obs;
  var periodePeriodeString = "Periode";
  var periodeStartDateString = "StartDate";
  var periodeEndDateString = "EndDate";
  var periodeFullStartDateString = "FullStartDate";
  var periodeFullEndDateString = "FullEndDate";
  var periodeDotEndDateString = "DotEndDate";

  var addPaketSubuserID = "PaketSubUsersID";
  var addPaketSubuserQty = "QtyPaket";
  var addPaketSubuserTanggal = "Tanggal";

  var loadingCreate = false.obs;

  @override
  void onInit() {
    orderID.value = Get.arguments[0];
    paketSubscriptionID.value = Get.arguments[1];
    paketSubscriptionName.value = Get.arguments[2];
    isNext = Get.arguments[3];
    paketSubscriptionPeriodeAwal.value = Get.arguments[4];
    paketSubscriptionPeriodeAkhir.value = Get.arguments[5];

    paketSubscriptionPeriodeAwalFull.value = Get.arguments[6];
    paketSubscriptionPeriodeAkhirFull.value = Get.arguments[7];
    paketSubscriptionDotAkhirFull.value = Get.arguments[8];

    paketSubscriptionPeriode.value =
        "${Get.arguments[6]} - ${Get.arguments[7]}";
    // paketSubscriptionPeriodeAwalFull.value = listData[0]["FullStartDate"];
    // paketSubscriptionPeriodeAkhirFull.value = listData.last["FullEndDate"];
    // paketSubscriptionDotAkhirFull.value =
    //     response["SupportingData"]["FullEndDate"];

    resetSubuser();
    getTotalPaketSubuser();
    // getTimelineListString();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<bool> onWillPop() {
    if (!loadingCreate.value &&
        selectedPeriodeSubuser.isNotEmpty &&
        selectedPeriodeSubuser[0] != "0") {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title: "SubscriptionCreateLabelKonfirmasiPembatalan".tr,
          message: ("SubscriptionCreateLabelPertanyaanKeluar".tr)
              .replaceAll("\\n", "\n"),
          isDismissible: false,
          isShowCloseButton: true,
          labelButtonPriority1: GlobalAlertDialog.noLabelButton,
          labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
          onTapPriority1: () {},
          onTapPriority2: () {
            Get.back();
          },
          positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
    } else {
      return Future.value(!loadingCreate.value);
    }
    return Future.value(false);
  }

  void onBack() {
    if (!loadingCreate.value &&
        selectedPeriodeSubuser.isNotEmpty &&
        selectedPeriodeSubuser[0] != "0") {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title: "SubscriptionCreateLabelKonfirmasiPembatalan".tr,
          message: ("SubscriptionCreateLabelPertanyaanKeluar".tr)
              .replaceAll("\\n", "\n"),
          isDismissible: false,
          isShowCloseButton: true,
          labelButtonPriority1: GlobalAlertDialog.noLabelButton,
          labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
          onTapPriority1: () {},
          onTapPriority2: () {
            Get.back();
          },
          positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
    } else if (!loadingCreate.value) {
      Get.back();
    }
  }

  // getTimelineListString() async {
  //   loadTimeline.value = true;
  //   var response =
  //       await ApiHelper(context: Get.context, isShowDialogLoading: false)
  //           .getTimelineSubscription({
  //     "Role": "2",
  //     "IsDashboard": "false",
  //     "IsNext": isNext ? "1" : "0",
  //   });

  //   if (response != null) {
  //     var listData = response["Data"] as List;
  //     paketSubscriptionPeriode.value =
  //         "${listData[0]["FullStartDate"]} - ${listData.last["FullEndDate"]}";
  //     paketSubscriptionPeriodeAwalFull.value = listData[0]["FullStartDate"];
  //     paketSubscriptionPeriodeAkhirFull.value = listData.last["FullEndDate"];
  //     paketSubscriptionDotAkhirFull.value =
  //         response["SupportingData"]["FullEndDate"];
  //   }
  //   loadTimeline.value = false;
  // }

  void resetSubuser({int index}) {
    if (index != null) {
      listPeriodeSubuser[index] = [];
      selectedPeriodeSubuser[index] = "0";
      listPaketSubuser[index][subuserID] = 0;
      listPaketSubuser[index][subuserName] = "";
      listPaketSubuser[index][subuserDurasi] = 0;
      listPaketSubuser[index][subuserDescription] = "";
      listPaketSubuser[index][subuserInfo] = "";
      listPaketSubuser[index][subuserHarga] = 0;
      listPaketSubuser[index][subuserTotal] = 0;
      listPaketSubuser[index][subuserSubTotal] = 0;
    } else {
      listPeriodeSubuser.clear();
      selectedPeriodeSubuser.clear();
      listVoucher.clear();
      listVoucher.refresh();
      listPaketSubuser.value = [
        {
          subuserID: 0,
          subuserName: "",
          subuserDurasi: 0,
          subuserDescription: "",
          subuserInfo: "",
          subuserHarga: 0,
          subuserTotal: 0,
          subuserSubTotal: 0,
          subUserController: TextEditingController(text: "0")
        }
      ];
      listPeriodeSubuser.add([]);
      selectedPeriodeSubuser.add("0");
      jumlahPaketSubuser.value = 1;
      countAllSubuser();
    }
  }

  void getTotalPaketSubuser() async {
    loadTotalSubuser.value = true;
    var result = await ApiTMSubscription(
            context: Get.context,
            isShowDialogError: false,
            isShowDialogLoading: false)
        .fetchPaketLanggananSubuser(int.parse(paketSubscriptionID.value), "",
            fromBigfleet: false, nextLangganan: isNext);
    if (result != null) {
      totalSemuaPaketSubuser.value = (result["Data"] as List).length;
    }
    loadTotalSubuser.value = false;
  }

  void countTotalHargaSubuser() {
    var total = 0;
    listPaketSubuser.forEach((element) {
      element[subuserSubTotal] = element[subuserTotal] * element[subuserHarga];
      total += element[subuserSubTotal];
    });
    totalHargaSubuser.value = total;
    listPaketSubuser.refresh();
    updateTotalPembayaran();
  }

  void choosePaketSubuser(int index) async {
    if (!onDeleting) {
      var usedPaket = "";
      var newList = List.from(listPaketSubuser.value);
      newList.removeAt(index);
      newList.forEach((element) {
        usedPaket +=
            (usedPaket.isEmpty ? "" : ",") + element[subuserID].toString();
      });
      var result = await GetToPage.toNamed<TMChooseSubuserController>(
          Routes.TM_CHOOSE_SUBUSER,
          arguments: {
            paketLanggananIDName: int.parse(paketSubscriptionID.value),
            usedPaketSubuserName: usedPaket,
            fromBigfleetName: false,
            'nextLangganan': isNext
          });
      if (result != null) {
        listVoucher.clear();
        listVoucher.refresh();
        pajak.value = (result as Map)[subuserTax];
        biayaLayanan.value = (result as Map)[subuserLayanan];
        listPaketSubuser[index][subuserID] = (result as Map)[subuserID];
        listPaketSubuser[index][subuserName] = (result as Map)[subuserName];
        listPaketSubuser[index][subuserDurasi] = (result as Map)[subuserDurasi];
        listPaketSubuser[index][subuserDescription] =
            (result as Map)[subuserDescription];
        listPaketSubuser[index][subuserInfo] = (result as Map)[subuserInfo];
        listPaketSubuser[index][subuserHarga] = (result as Map)[subuserHarga];
        listPaketSubuser[index][subuserQtySubuser] =
            (result as Map)[subuserQtySubuser];
        listPaketSubuser[index][subuserTotal] = 1;
        listPaketSubuser[index][subuserSubTotal] =
            1 * (result as Map)[subuserHarga];
        listPaketSubuser[index][subUserController].text = "1";
        listPaketSubuser.refresh();
        await getSubuserPeriode(index);
        countAllSubuser();
        countTotalHargaSubuser();
      }
    }
  }

  void addSubuser() {
    listPaketSubuser.add({
      subuserID: 0,
      subuserName: "",
      subuserDescription: "",
      subuserInfo: "",
      subuserHarga: 0,
      subuserTotal: 0,
      subuserSubTotal: 0,
      subUserController: TextEditingController(text: "0")
    });
    jumlahPaketSubuser.value++;
    listPeriodeSubuser.add([]);
    selectedPeriodeSubuser.add("0");
  }

  void deleteSubuser(index) {
    onDeleting = true;
    listPaketSubuser.removeAt(index);
    jumlahPaketSubuser.value--;
    listPeriodeSubuser.removeAt(index);
    selectedPeriodeSubuser.removeAt(index);
    listVoucher.clear();
    listVoucher.refresh();
    onDeleting = false;
    countAllSubuser();
    countTotalHargaSubuser();
  }

  // void onChangeTotalSubuser(
  //     int index, String value, TextEditingController textController) {
  //   textController.text = value;
  //   listVoucher.clear();
  //   listVoucher.refresh();
  //   if (index != listPaketSubuser.length - 1 &&
  //       (value.isEmpty || int.parse(value) == 0)) {
  //     textController.text = "1";
  //     listPaketSubuser[index][subuserTotal] = 1;
  //     textController.selection = TextSelection.fromPosition(
  //         TextPosition(offset: textController.text.length));
  //   } else if ((index == listPaketSubuser.length - 1) &&
  //       (listPaketSubuser[index][subuserID] == 0 ||
  //           (listPaketSubuser[index][subuserID] != 0 &&
  //               (value.isEmpty || int.parse(value) == 0)))) {
  //     textController.text = "0";
  //     textController.selection = TextSelection.fromPosition(
  //         TextPosition(offset: textController.text.length));
  //     resetSubuser(index: index);
  //     countTotalHargaSubuser();
  //   } else {
  //     OnChangeTextFieldNumber.checkNumber(() => textController, value, true);
  //     listPaketSubuser[index][subuserTotal] = int.parse(textController.text);
  //     textController.selection = TextSelection.fromPosition(
  //         TextPosition(offset: textController.text.length));
  //   }
  //   countAllSubuser();
  //   countTotalHargaSubuser();
  // }

  void onChangeTotalSubuser(
      int index, String value, TextEditingController textController) {
    textController.text = value;
    listVoucher.clear();
    listVoucher.refresh();
    if ((value.isEmpty || value == "0" || value == "00") &&
        listPaketSubuser[index][subuserID] != 0) {
      textController.text = "1";
      listPaketSubuser[index][subuserTotal] = 1;
      textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
    } else {
      try {
        OnChangeTextFieldNumber.checkNumber(() => textController, value, true);
      } catch (err) {}
      listPaketSubuser[index][subuserTotal] = int.parse(textController.text);
      textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
    }
    countAllSubuser();
    countTotalHargaSubuser();
  }

  void countAllSubuser() {
    totalSubuser.value = 0;
    listPaketSubuser.forEach((element) {
      if (element[subuserTotal] > 0)
        totalSubuser += (element[subuserTotal] * element[subuserQtySubuser]);
    });
    totalFreeSubuser.value = 0;
    listVoucher.forEach((element) {
      totalFreeSubuser += element[voucherFreeUser];
    });
  }

  void updateTotalPembayaran() {
    subtotal.value = 0;
    subtotal += totalHargaSubuser.value;
    var totalDiskon = listVoucher.isEmpty ? 0 : listVoucher[0][voucherAmount];
    totalPesanan.value =
        (subtotal.value - totalDiskon + biayaLayanan.value).toDouble();
    totalPajak.value =
        (totalPesanan.value * pajak.value / 100).ceil().toDouble();

    // totalPajak.value = (totalPajak.value / 100).ceil().toDouble() * 100;
    totalPesanan.value += totalPajak.value;
  }

  void chooseVoucher() async {
    //Pengecekan apabila sudah ada paket subuser yang sudah dipilih dan periode sudah dipilih dan tidak ada proses loading dan tidak lagi menghapus
    if (listPaketSubuser.any((element) => element != null) &&
        listPaketSubuser.any((element) => element[subuserID] != 0) &&
        listPeriodeSubuser.any((element) => element != null) &&
        listPeriodeSubuser.any((element) => (element as List).isNotEmpty) &&
        !onDeleting) {
      var arguments = [];
      listPaketSubuser.forEach((element) {
        if (element[subuserTotal] > 0)
          arguments.add({
            cekPaketID: element[subuserID],
            cekPaketQty: element[subuserTotal].toString(),
            'voucherId': null,
          });
      });
      if (listVoucher.isNotEmpty) {
        arguments[0]['voucherId'] = listVoucher[0]['VoucherID'].toString();
      }
      var result = await GetToPage.toNamed<TMChooseVoucherController>(
          Routes.TM_CHOOSE_VOUCHER,
          arguments: arguments);
      if (result != null) {
        listVoucher.clear();
        if ((result as List).isNotEmpty) {
          listVoucher.value = result;
          // metodePembayaran.clear();
          listVoucher.refresh();
        }
        updateTotalPembayaran();
      }
      countAllSubuser();
      updateTotalPembayaran();
    }
  }

  Future<void> getSubuserPeriode(int index) async {
    listPeriodeSubuser[index] = [];
    listPeriodeSubuser.refresh();
    var result = await ApiTMSubscription(
            context: Get.context,
            isShowDialogError: true,
            isShowDialogLoading: false)
        .getPeriodePaketSubuser(
            orderID.value, listPaketSubuser[index][subuserID].toString());
    try {
      if (result != null) {
        var list = result["Data"] as List;
        var cekList =
            await cekTotalPaketSubuser(index, list[0][periodeStartDateString]);
        if (cekList.isNotEmpty) {
          list.forEach((element) {
            // var getIndex = list.indexOf(element);
            var getIndex =
                int.parse(element[periodePeriodeString].toString()) - 1;
            element[periodeEndDateString] =
                cekList[(getIndex + listPaketSubuser[index][subuserDurasi] - 1)]
                    [periodeEndDateString];
            element[periodeFullEndDateString] =
                cekList[(getIndex + listPaketSubuser[index][subuserDurasi] - 1)]
                    [periodeFullEndDateString];
            // validate jika end date dari layanan != subuser end date
            if (element[periodeEndDateString] != dateTimeAPIFormat.format(paketSubscriptionPeriodeAkhir.value) && (getIndex + listPaketSubuser[index][subuserDurasi]) > (cekList.length - 1)) {
              resetSubuser(index: index);
              CustomToast.show(
                context: Get.context, 
                message: "Oops!, invalid subscription date!",
              );
              throw("END DATE LAYANAN TIDAK SAMA DENGAN SUBUSER");
            }
            element[periodeDotEndDateString] = element[periodeEndDateString] ==
                    dateTimeAPIFormat
                        .format(paketSubscriptionPeriodeAkhir.value)
                ? paketSubscriptionDotAkhirFull.value
                : cekList[(getIndex + listPaketSubuser[index][subuserDurasi])]
                    [periodeFullStartDateString];
          });
          listPeriodeSubuser[index] = list;
          selectedPeriodeSubuser[index] =
              list.first[periodePeriodeString].toString();
          listPeriodeSubuser.refresh();
        } else {
          listNeedRefreshPeriode.add(index);
        }
      } else {
        listNeedRefreshPeriode.add(index);
      }
    } catch (err) {
      print(err);
    }
  }

  Future<List> cekTotalPaketSubuser(int index, String tanggal) async {
    var result = await ApiTMSubscription(
            context: Get.context,
            isShowDialogError: false,
            isShowDialogLoading: false)
        .cekPeriodePaketSubuser(orderID.value,
            listPaketSubuser[index][subuserID].toString(), tanggal);
    if (result != null) {
      return result["Data"];
    }
    return [];
  }

  Future<void> onSaving() async {
    loadingCreate.value = true;
    var listSendSubuser = [];
    var listSubuser = List.from(listPaketSubuser.value)
        .where((element) => element[subuserTotal] > 0)
        .toList();
    listSubuser.forEach((element) {
      var index = listSubuser.indexOf(element);
      var listIndexPeriode = listPeriodeSubuser[index];
      listSendSubuser.add({
        addPaketSubuserID: element[subuserID],
        addPaketSubuserQty: element[subuserTotal],
        addPaketSubuserTanggal: (listIndexPeriode as List)
            .where((element) =>
                element[periodePeriodeString].toString() ==
                selectedPeriodeSubuser[index])
            .toList()[0][periodeStartDateString]
            .toString()
      });
    });
    var result = await ApiTMSubscription(
            context: Get.context,
            isShowDialogError: true,
            isShowDialogLoading: false)
        .doAddSubuser(
            listSendSubuser,
            orderID.value,
            listVoucher.isEmpty ? "" : listVoucher[0][voucherID].toString(),
            metodePembayaran[0][paymentID].toString(),
            isNext ? 1 : 0);
    if (result != null) {
      if (result["Message"]["Code"] == 200) {
        if (metodePembayaran[0][paymentID].toString() == "8") {
          Get.back(result: true);
        } else {
          //Virtual Account
          var responseOrder = await ApiTMSubscription(
                  context: Get.context, isShowDialogLoading: false)
              .getDetailOrderSubusersByShipper(
                  {"OrderID": result["Data"]["DocID"].toString()});
          if (responseOrder != null) {
            loadingCreate.value = false;
            var content = TMMetodePembayaranModel(
                paymentID: metodePembayaran[0][paymentID],
                noRek: metodePembayaran[0][paymentNoRek],
                paymentName: metodePembayaran[0][paymentName],
                thumbnail: metodePembayaran[0][paymentThumbnail]);
            var resultPayment =
                await GetToPage.toNamed<TMPembayaranSubscriptionController>(
                    Routes.TM_PEMBAYARAN_SUBSCRIPTION,
                    arguments: [
                  content,
                  totalPesanan.value,
                  responseOrder['Footer'][0]['PaymentExpired'],
                  subtotal.value,
                  totalSubuser.value,
                  totalFreeSubuser.value,
                  listVoucher.isEmpty ? "" : listVoucher[0][voucherCode],
                  listVoucher.isEmpty
                      ? 0.0
                      : listVoucher[0][voucherAmount].toDouble(),
                  biayaLayanan.value.toDouble(),
                  totalPajak.value,
                  true,
                  result["Data"]["DocID"],
                  responseOrder["IsNext"] == 1
                ]);
            if (resultPayment != null && resultPayment[1] != "justRefresh") {
              // result payment [1] == "justRefresh" means, it not came from ubah pembayaran
              Get.back(result: true);
            } else {
              Get.back();
            }
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
    loadingCreate.value = false;
  }

  void chooseMetodePembayaran(BuildContext context) async {
    FocusScope.of(context).unfocus();
    // waiting onFocusChange() called before move screen
    await Future.delayed(Duration(milliseconds: 100));
    if (!(listPaketSubuser.length == 1 &&
        (listPaketSubuser[0][subuserID] == 0 ||
            (listPaketSubuser[0][subuserID] != 0 &&
                (selectedPeriodeSubuser[0] == "0" ||
                    selectedPeriodeSubuser[0] == null))))) {
      var result = await GetToPage.toNamed<
              TMSubscriptionPilihMetodePembayaranController>(
          Routes.TM_SUBSCRIPTION_PILIH_METODE_PEMBAYARAN,
          arguments: [
            subtotal.value.toDouble(),
            dateTimeFullFormat.format(DateTime.now().add(Duration(hours: 1))),
            totalSubuser.value,
            totalFreeSubuser.value,
            listVoucher.isEmpty ? "" : listVoucher[0][voucherCode],
            listVoucher.isEmpty
                ? 0.0
                : listVoucher[0][voucherAmount].toDouble(),
            biayaLayanan.value.toDouble(),
            totalPajak.value,
            totalPesanan.value,
            metodePembayaran.isEmpty ? null : metodePembayaran[0][paymentID]
            // : [
            //     metodePembayaran[0][selectedCategory].toString(),
            //     metodePembayaran[0][selectedContent].toString()
            //   ]
          ]);
      if (result != null) {
        metodePembayaran.value = result;
        metodePembayaran.refresh();
      }
    }
  }
}
