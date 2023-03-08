import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
class ZoBuatHargaPromoController extends GetxController {
  var slideIndex = 0.obs;
  var pageController = PageController();
  var title = "".obs;

  var isKosongPeriodeAwal = false.obs;
  var isKosongPeriodeAkhir = false.obs;
  var isKosongPembayaran = false.obs;
  var selectedPembayaran = "".obs;

  final periodeAwalController = TextEditingController().obs;
  final periodeAkhirController = TextEditingController().obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  // datestartPicker() async {
  //   var picked = await showDatePicker(
  //       context: Get.context,
  //       initialDate: curdate,
  //       firstDate: curdate,
  //       lastDate: DateTime(20200));

  //   if (picked != null) {
  //     inisialDateEndPicker = picked;
  //     isSelectStartDate.value = true;

  //     String isMonth = "";
  //     if (picked.month.toString().length > 1) {
  //       isMonth = "${picked.month}";
  //     } else {
  //       isMonth = "0${picked.month}";
  //     }

  //     String isDay = "";
  //     if (picked.day.toString().length > 1) {
  //       isDay = "${picked.day}";
  //     } else {
  //       isDay = "0${picked.day}";
  //     }

  //     dateAwal.value = "${picked.year}-$isMonth-$isDay";
  //     periodeAwalController.value.text = "$isDay/$isMonth/${picked.year}";
  //     isKosongPeriodeAwal.value = false;
  //   }
  // }

  // dateendPicker() async {
  //   var picked = await showDatePicker(
  //       context: Get.context,
  //       initialDate: firstdate == null ? inisialDateEndPicker : firstdate,
  //       firstDate: inisialDateEndPicker,
  //       lastDate: DateTime(inisialDateEndPicker.year,
  //           inisialDateEndPicker.month, inisialDateEndPicker.day + 3));

  //   if (picked != null) {
  //     firstExpWaktu.value = picked;
  //     firstdate = picked;
  //     String isDayend = "";
  //     if (picked.day.toString().length > 1) {
  //       isDayend = "${picked.day}";
  //     } else {
  //       isDayend = "0${picked.day}";
  //     }

  //     String isMonthend = "";
  //     if (picked.month.toString().length > 1) {
  //       isMonthend = "${picked.month}";
  //     } else {
  //       isMonthend = "0${picked.month}";
  //     }

  //     dateAkhir.value = "${picked.year}-$isMonthend-$isDayend";
  //     periodeAkhirController.value.text =
  //         "$isDayend/$isMonthend/${picked.year}";
  //     isKosongPeriodeAkhir.value = false;
  //   }
  // }

  void updateTitle() {
    switch (slideIndex.value) {
      case 0:
        {
          title.value = "Pilih Lokai/Area Pickup".tr;
          break;
        }
      case 1:
        {
          title.value = "Pilih Lokai/Area Destinasi".tr;
          break;
        }
      case 2:
        {
          title.value = "Tarif dan Kuota Promo".tr;
          break;
        }
      case 3:
        {
          title.value = "Spesifikasi Promo".tr;
          break;
        }
    }
  }
}
