import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/onchange_textfield_number.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/metode_pembayaran.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/api_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_subuser/choose_subuser_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_voucher/choose_voucher_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/check_segmented_user.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pembayaran_subscription/pembayaran_subscription_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/terms_and_conditions_subscription_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class CreateSubscriptionController extends GetxController {
  var slideIndex = 0.obs;
  var pageController = PageController();
  var title = "".obs;
  var loadingCreate = false.obs;

  var isFirst = true;

  // var dateFormat = DateFormat('yyyy-MM-dd kk:mm:ss');
  var biayaLayanan = 0.obs;
  var pajak = 0.obs;
  var biayaLayananString = "BiayaLayanan";
  var pajakString = "Pajak";

  var showClosePopup = false;

  var addPaketSubuserID = "PaketSubUsersID";
  var addPaketSubuserQty = "QtyPaket";
  var onDeleting = false;

  //First Page
  var loadSubscription = false.obs;
  var listPaketSubscription = [].obs;
  var selectedPaketSubscription = "".obs;
  var listPerPage = 10;
  var subscriptionID = "PaketID";
  var subscriptionName = "PaketName";
  var subscriptionPrice = "Harga";
  var subscriptionFree = "FreeUser";
  var fullPeriodeAkhir;
  var fullNextPeriode;

  //Second Page
  var needRefresh = true;
  var loadTotalSubuser = false.obs;
  var totalSemuaPaketSubuser = 0.obs;
  var jumlahPaketSubuser = 1.obs;
  var listPaketSubuser = [].obs;
  var totalHargaSubuser = 0.obs;
  var subuserID = "PaketID";
  var subuserName = "PaketName";
  var subuserHarga = "Harga";
  var subuserQtySubuser = "QtySubUsers";
  var subuserDescription = "Description";
  var subuserInfo = "StrInfo";
  var subuserTotal = "Total";
  var subuserJumlah = "Jumlah";
  var subuserSubTotal = "SubTotal";
  var subUserController = "SubuserController";

  var paketLanggananIDName = "paketLanggananID";
  var usedPaketSubuserName = "usedPaketSubuser";
  var nextLanggananName = "nextLangganan";
  var fromBigfleetName = "fromBigfleet";
  var nextLangganan;

  //Third Page
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
  // var selectedCategory = "SelectedCategory";
  // var selectedContent = "SelectedContent";

  var subtotal = 0.obs;
  var totalSubuser = 0.obs;
  var totalFreeSubuser = 0.obs;
  var totalPajak = 0.0.obs;
  var totalPesanan = 0.0.obs;

  var cekPaketID = "ID";
  var cekPaketQty = "Qty";

  var dateTimeAPIFormat = DateFormat('yyyy-MM-dd');
  var dateTimeFullFormat = DateFormat('dd MMM yyyy HH:mm');

  bool firstTooltip = true;

  @override
  void onInit() {
    super.onInit();
    nextLangganan = Get.arguments[0];
    isFirst = Get.arguments[1];
    fullPeriodeAkhir = Get.arguments[2];
    fullNextPeriode = Get.arguments[3];
    updateTitle();
    resetSubuser();
    getPaketSubscription();
    // if (nextLangganan) showInfoKadaluarsa();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void updateTitle() {
    switch (slideIndex.value) {
      case 0:
        {
          title.value = "SubscriptionCreateLabelPaketLangganan".tr;
          break;
        }
      case 1:
        {
          title.value = "SubscriptionCreateLabelPaketUser".tr;
          break;
        }
      case 2:
        {
          title.value = "SubscriptionCreateLabelDetailPesanan".tr;
          break;
        }
    }
  }

  void checkFirst() async {
    if (metodePembayaran.isEmpty) {
      CustomToast.show(
          context: Get.context, message: "Pilih metode pembayaran dulu");
    } else {
      loadingCreate.value = true;
      var response = await ApiSubscription(
              context: Get.context, isShowDialogLoading: false)
          .getCheckSegmented(
              role: "2",
              roleUserId: await SharedPreferencesHelper.getUserShipperID());
      try {
        var dataCek = CheckSegmentedUserModel.fromJson(response['Data']);
        if (dataCek.isFirst == 1) {
          loadingCreate.value = false;
          var result =
              await GetToPage.toNamed<TermsAndConditionsSubscriptionController>(
                  Routes.TERMS_AND_CONDITIONS_SUBSCRIPTION);
          if (result != null && result == true) onSave();
        } else {
          onSave();
        }
      } catch (error) {
        loadingCreate.value = false;
        GlobalAlertDialog.showDialogError(
            title: "Error",
            message: error.toString(),
            labelButtonPriority1: "OK",
            isDismissible: false,
            onTapPriority1: () {
              Get.back();
            });
      }
    }
  }

  void onSave() async {
    loadingCreate.value = true;
    var listSendSubuser = [];
    var listSubuser = List.from(listPaketSubuser.value)
        .where((element) => element[subuserTotal] > 0)
        .toList();
    listSubuser.forEach((element) {
      listSendSubuser.add({
        addPaketSubuserID: element[subuserID].toString(),
        addPaketSubuserQty: element[subuserTotal].toString()
      });
    });
    var result = await ApiSubscription(
            context: Get.context,
            isShowDialogError: true,
            isShowDialogLoading: false)
        .doAddSubscription(
            listSendSubuser,
            selectedPaketSubscription.value,
            listVoucher.isEmpty ? "" : listVoucher[0][voucherID].toString(),
            metodePembayaran[0][paymentID].toString());
    if (result != null) {
      if (result["Message"]["Code"] == 200) {
        if (metodePembayaran[0][paymentID].toString() == "8") {
          var responseOrder = await ApiSubscription(
                  context: Get.context, isShowDialogLoading: false)
              .getDetailOrderByShipper(
                  {"OrderID": result["Data"]["DocID"].toString()});
          if (responseOrder != null) {
            Get.back(result: [
              (listPaketSubscription.where((element) =>
                      element[subscriptionID].toString() ==
                      selectedPaketSubscription.value)).toList()[0]
                  [subscriptionName],
              responseOrder["Footer"][0]["PeriodePaket"],
              true
            ]);
          }
        } else {
          //Virtual Account
          var responseOrder = await ApiSubscription(
                  context: Get.context, isShowDialogLoading: false)
              .getDetailOrderByShipper(
                  {"OrderID": result["Data"]["DocID"].toString()});
          if (responseOrder != null) {
            var content = MetodePembayaranModel(
                paymentID: metodePembayaran[0][paymentID],
                noRek: metodePembayaran[0][paymentNoRek],
                paymentName: metodePembayaran[0][paymentName],
                thumbnail: metodePembayaran[0][paymentThumbnail]);
            var resultPayment =
                await GetToPage.toNamed<PembayaranSubscriptionController>(
                    Routes.PEMBAYARAN_SUBSCRIPTION,
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
                  false,
                  result["Data"]["DocID"],
                  false
                ]);

            // update color status bar
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

            if (resultPayment != null &&
                ((resultPayment[0] is String) &&
                    (resultPayment[0] as String).length > 0)) {
              Get.back(result: resultPayment);
            } else if (resultPayment != null &&
                resultPayment[1] == "justRefresh") {
              Get.back(); // back to subs home
            } else {
              Get.back();
            }
          }
        }
      } else
        GlobalAlertDialog.showDialogError(
            context: Get.context,
            title: "",
            message: result["Data"]["Message"],
            labelButtonPriority1: "Ok");
    }
    loadingCreate.value = false;
  }

  Future<bool> onWillPop() {
    if (!loadingCreate.value && selectedPaketSubscription.isNotEmpty) {
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
    if (!loadingCreate.value && selectedPaketSubscription.isNotEmpty) {
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

  void onJumlahNol(int index, TextEditingController textController) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "SubscriptionCreateLabelKonfirmasiHapus".tr,
        message: "SubscriptionCreateLabelPertanyaanHapusUserTambahan"
            .tr
            .replaceAll("\\n", "\n"),
        isDismissible: false,
        isShowCloseButton: true,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority1: () {
          textController.text = "1";
          listPaketSubuser[index][subuserTotal] = 1;
          textController.selection = TextSelection.fromPosition(
              TextPosition(offset: textController.text.length));
        },
        onTapPriority2: () {
          if (listPaketSubuser.length == 1) {
            resetSubuser(index: index);
            countTotalHargaSubuser();
          } else {
            deleteSubuser(index);
          }
        },
        onTapCloseButton: () {
          textController.text = "1";
          listPaketSubuser[index][subuserTotal] = 1;
          textController.selection = TextSelection.fromPosition(
              TextPosition(offset: textController.text.length));
        },
        positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
  }

  //First Page
  void getPaketSubscription() async {
    loadSubscription.value = true;
    listPaketSubscription.clear();
    var result = await ApiSubscription(
            context: Get.context,
            isShowDialogError: false,
            isShowDialogLoading: false)
        .fetchPaketLangganan();
    if (result != null) {
      (result["Data"] as List).forEach((element) {
        pajak.value = element[pajakString];
        biayaLayanan.value = element[biayaLayananString];
        listPaketSubscription.add({
          subscriptionID: element[subscriptionID],
          subscriptionName: element[subscriptionName],
          subscriptionPrice: element[subscriptionPrice],
          subscriptionFree: element[subscriptionFree],
        });
      });
    }
    loadSubscription.value = false;
  }

  void resetSubuser({int index}) {
    if (index != null) {
      listPaketSubuser[index][subuserID] = 0;
      listPaketSubuser[index][subuserName] = "";
      listPaketSubuser[index][subuserDescription] = "";
      listPaketSubuser[index][subuserInfo] = "";
      listPaketSubuser[index][subuserHarga] = 0;
      listPaketSubuser[index][subuserTotal] = 0;
      listPaketSubuser[index][subuserSubTotal] = 0;
    } else {
      listVoucher.clear();
      listVoucher.refresh();
      listPaketSubuser.value = [
        {
          subuserID: 0,
          subuserName: "",
          subuserDescription: "",
          subuserInfo: "",
          subuserHarga: 0,
          subuserTotal: 0,
          subuserSubTotal: 0,
          subUserController: TextEditingController(text: "0")
        }
      ];
      jumlahPaketSubuser.value = 1;
      countAllSubuser();
    }
  }

  //Second Page
  void getTotalPaketSubuser() async {
    loadTotalSubuser.value = true;
    var result = await ApiSubscription(
            context: Get.context,
            isShowDialogError: false,
            isShowDialogLoading: false)
        .fetchPaketLanggananSubuser(
            int.parse(selectedPaketSubscription.value), "",
            nextLangganan: nextLangganan);
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
      var result = await GetToPage.toNamed<ChooseSubuserController>(
          Routes.CHOOSE_SUBUSER,
          arguments: {
            paketLanggananIDName: int.parse(selectedPaketSubscription.value),
            usedPaketSubuserName: usedPaket,
            nextLanggananName: nextLangganan
          });

      // update color status bar
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

      if (result != null) {
        listVoucher.clear();
        listVoucher.refresh();
        listPaketSubuser[index][subuserID] = (result as Map)[subuserID];
        listPaketSubuser[index][subuserName] = (result as Map)[subuserName];
        listPaketSubuser[index][subuserDescription] =
            (result as Map)[subuserDescription];
        listPaketSubuser[index][subuserJumlah] =
            (result as Map)[subuserDescription];
        listPaketSubuser[index][subuserInfo] = (result as Map)[subuserInfo];
        listPaketSubuser[index][subuserHarga] = (result as Map)[subuserHarga];
        listPaketSubuser[index][subuserQtySubuser] =
            (result as Map)[subuserQtySubuser];
        listPaketSubuser[index][subuserTotal] = 1;
        listPaketSubuser[index][subuserSubTotal] =
            1 * (result as Map)[subuserHarga];
        listPaketSubuser[index][subUserController].text = "1";
        countTotalHargaSubuser();
      }
    }
  }

  void addSubuser() {
    listPaketSubuser.add({
      subuserID: 0,
      subuserName: "",
      subuserDescription: "",
      subuserJumlah: "",
      subuserInfo: "",
      subuserHarga: 0,
      subuserTotal: 0,
      subuserSubTotal: 0,
      subUserController: TextEditingController(text: "0")
    });
    jumlahPaketSubuser.value++;
    countTotalHargaSubuser();
  }

  void deleteSubuser(index) {
    onDeleting = true;
    listPaketSubuser.removeAt(index);
    jumlahPaketSubuser.value--;
    listVoucher.clear();
    listVoucher.refresh();
    countTotalHargaSubuser();
    onDeleting = false;
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
  //   countTotalHargaSubuser();
  // }
  void onChangeTotalSubuser(
      int index, String value, TextEditingController textController) {
    textController.text = value;
    listVoucher.clear();
    listVoucher.refresh();
    if ((value.isEmpty || value == "0" || value == "00") &&
        listPaketSubuser[index][subuserID] != 0) {
      onJumlahNol(index, textController);
    }
    // (index != listPaketSubuser.length - 1 &&
    //     (value.isEmpty || int.parse(value) == 0)) {
    // textController.text = "1";
    // listPaketSubuser[index][subuserTotal] = 1;
    // textController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: textController.text.length));
    // }
    // else if ((index == listPaketSubuser.length - 1) &&
    //     (listPaketSubuser[index][subuserID] == 0 ||
    //         (listPaketSubuser[index][subuserID] != 0 &&
    //             (value.isEmpty || int.parse(value) == 0)))) {
    //   textController.text = "0";
    //   textController.selection = TextSelection.fromPosition(
    //       TextPosition(offset: textController.text.length));
    //   resetSubuser(index: index);
    //   countTotalHargaSubuser();
    // }
    else {
      try {
        OnChangeTextFieldNumber.checkNumber(() => textController, value, true);
      } catch (err) {}
      listPaketSubuser[index][subuserTotal] = int.parse(textController.text);
      var hitungJumlah = listPaketSubuser[index][subuserQtySubuser] *
          listPaketSubuser[index][subuserTotal];
      var textHitungJumlah = "";
      var first = true;
      (listPaketSubuser[index][subuserDescription] as String)
          .split(" ")
          .forEach((element) {
        if (first) {
          textHitungJumlah += hitungJumlah.toString();
          first = false;
        } else {
          textHitungJumlah += " $element";
        }
      });
      listPaketSubuser[index][subuserJumlah] = textHitungJumlah;
      listPaketSubuser[index][subuserTotal] = int.parse(textController.text);
      textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
    }
    countTotalHargaSubuser();
  }

  //Third Page
  void countAllSubuser() {
    totalSubuser.value = 0;
    listPaketSubuser.forEach((element) {
      if (element[subuserTotal] > 0)
        totalSubuser += (element[subuserTotal] * element[subuserQtySubuser]);
    });
    totalFreeSubuser.value = 0;
    List.from(listPaketSubscription)
        .where((element) =>
            element[subscriptionID].toString() ==
            selectedPaketSubscription.value)
        .toList()
        .forEach((element) {
      totalFreeSubuser += element[subscriptionFree];
    });
    listVoucher.forEach((element) {
      totalFreeSubuser += element[voucherFreeUser];
    });
  }

  void updateTotalPembayaran() {
    subtotal.value = 0;
    List.from(listPaketSubscription)
        .where((element) =>
            element[subscriptionID].toString() ==
            selectedPaketSubscription.value)
        .toList()
        .forEach((element) {
      subtotal += element[subscriptionPrice];
    });
    subtotal += totalHargaSubuser.value;
    var totalDiskon = listVoucher.isEmpty ? 0 : listVoucher[0][voucherAmount];
    totalPesanan.value =
        (subtotal.value - totalDiskon + biayaLayanan.value).toDouble();
    totalPajak.value =
        (totalPesanan.value * pajak.value / 100).ceil().toDouble();
    // totalPajak.value = (totalPajak.value / 100).ceil().toDouble() * 100;
    totalPesanan += totalPajak.value;
  }

  void chooseVoucher() async {
    var arguments = [
      {
        cekPaketID: selectedPaketSubscription.value,
        cekPaketQty: 1.toString(),
        "voucherId": null,
      }
    ];
    listPaketSubuser.forEach((element) {
      if (element[subuserTotal] > 0)
        arguments.add({
          cekPaketID: element[subuserID].toString(),
          cekPaketQty: element[subuserTotal].toString()
        });
    });
    if (listVoucher.isNotEmpty) {
      arguments[0]['voucherId'] = listVoucher[0]['VoucherID'].toString();
    }
    var result = await GetToPage.toNamed<ChooseVoucherController>(
      Routes.CHOOSE_VOUCHER,
      arguments: arguments,
    );

    // update color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

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

  void chooseMetodePembayaran() async {
    var result = await Get.toNamed(Routes.SUBSCRIPTION_PILIH_METODE_PEMBAYARAN,
        arguments: [
          subtotal.value.toDouble(),
          dateTimeFullFormat.format(DateTime.now().add(Duration(hours: 1))),
          totalSubuser.value,
          totalFreeSubuser.value,
          listVoucher.isEmpty ? "" : listVoucher[0][voucherCode],
          listVoucher.isEmpty ? 0.0 : listVoucher[0][voucherAmount].toDouble(),
          biayaLayanan.value.toDouble(),
          totalPajak.value,
          totalPesanan.value,
          metodePembayaran.isEmpty ? null : metodePembayaran[0][paymentID]
          // : [
          //     metodePembayaran[0][selectedCategory].toString(),
          //     metodePembayaran[0][selectedContent].toString()
          //   ]
        ]);
    // update color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    if (result != null) {
      metodePembayaran.value = result;
      metodePembayaran.refresh();
    }
  }

  void showInfoKadaluarsa() {
    GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          isDismissible: false,
          // title: "SubscriptionLabelSelamatBerhasil".tr,
          message:
              "SubscriptionAlertSubscriptionNext"
                                  .tr
                                  // "Anda masih memiliki Paket Berlangganan Hingga $fullPeriodeAkhir. Jika Anda membeli paket langganan baru maka paket selanjutnya akan berlaku pada Tanggal $fullNextPeriode"
                                  // .tr
                                  .replaceAll("#1", fullPeriodeAkhir)
                                  .replaceAll("#2", fullNextPeriode),
          labelButtonPriority1: "SubscriptionContinue".tr,
          positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
  }
}
