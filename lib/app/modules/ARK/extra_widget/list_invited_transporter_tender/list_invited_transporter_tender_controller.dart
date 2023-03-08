import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:email_validator/email_validator.dart';

class ListInvitedTransporterTenderController extends GetxController {
  var validasiSimpan = false;
  var emailController = [].obs;
  var dataEmail = [];
  var idPraTender = "0";
  var form = GlobalKey<FormState>();
  var jenisTransaksi = "";

  @override
  void onInit() {
    super.onInit();
    idPraTender = Get.arguments[0];
    dataEmail = Get.arguments[1];
    jenisTransaksi = Get.arguments[2];
    emailController.addAll([
      TextEditingController(text: ''),
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onSave() {
    kirim();
  }

  Future kirim() async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {},
              child: Center(child: CircularProgressIndicator()));
        });

    String shipperID = await SharedPreferencesHelper.getUserShipperID();

    var dataEmail = [];

    for (var x = 0; x < emailController.length; x++) {
      if (emailController[x].text != "") {
        dataEmail.add(emailController[x].text);
      }
    }
    //JIKA TIDAK ADA EMAIL, KEMBALI SEPERTI BIASA
    if (dataEmail.length > 0) {
      if (jenisTransaksi == "PT") {
        var result = await ApiHelper(
                context: Get.context,
                isShowDialogLoading: false,
                isShowDialogError: false)
            .sendEmailInfoPraTender(shipperID, idPraTender, dataEmail);

        if (result['Message']['Code'].toString() == '200') {
          Get.back();
          print("BERHASIL SIMPAN");
          Get.back(result: true);
          CustomToast.show(
              context: Get.context,
              message:
                  "InfoPraTenderDetailLabelTeksBerhasilMengirimInvitedTransporter"
                      .tr); //Berhasil mengirim invited Transporter. Anda dapat mengirim kembali setelah 1 jam
        } else {
          Get.back();
        }
      } else if (jenisTransaksi == "TD") {
        var result = await ApiHelper(
                context: Get.context,
                isShowDialogLoading: false,
                isShowDialogError: false)
            .sendEmailProsesTender(shipperID, idPraTender, dataEmail);

        if (result['Message']['Code'].toString() == '200') {
          Get.back();
          print("BERHASIL SIMPAN");
          Get.back(result: true);
          CustomToast.show(
              context: Get.context,
              message:
                  "ProsesTenderDetailLabelTeksBerhasilMengirimInvitedTransporter"
                      .tr); //Berhasil mengirim invited Transporter. Anda dapat mengirim kembali setelah 1 jam
        } else {
          Get.back();
        }
      }
    } else {
      Get.back();
      Get.back();
    }
  }

  void tambahEmail() {
    FocusManager.instance.primaryFocus.unfocus();
    emailController.add(
      TextEditingController(text: ''),
    );
    emailController.refresh();
    form.currentState.validate();
  }

  void hapusEmail(int index) {
    FocusManager.instance.primaryFocus.unfocus();
    for (var x = 0; x < emailController.length; x++) {
      if (x != emailController.length - 1 && x == index) {
        emailController[x].text = emailController[x + 1].text;
      }
    }
    emailController.removeAt(index);
    emailController.refresh();
    form.currentState.validate();
  }

  String cekFormatEmail(value) {
    if (value.isEmpty || value == "") {
      return "InfoPraTenderCreateLabelAlertEmailHarusDiisi".tr;
    } else if (!EmailValidator.validate(value)) {
      return "InfoPraTenderCreateLabelAlertFormatEmail"
          .tr; // FORMAT EMAIL TIDAK BENAR
    } else {
      return "";
    }
  }

  String cekEmailKosong(index) {
    for (var y = 0; y < emailController.length; y++) {
      if (emailController[index].text == emailController[y].text) {
        return "Email Tidak Boleh Kosong"; // "InfoPraTenderCreateEmailKosong".tr
      }
    }

    return "";
  }

  String cekEmailKembar(index) {
    var indexAwal = 0;
    var awal = true;
    //CEK KE DIRI SENDIRI APA ADA YANG KEMBAR YAANG AWAL
    for (var y = 0; y < emailController.length; y++) {
      if (emailController[index].text == emailController[y].text &&
          emailController[index].text != "" &&
          emailController[y].text != "" &&
          awal) {
        indexAwal = y;
        awal = false;
      }
    }
    //CEK KE DIRI SENDIRI JIKA DIA AWAL SKIP
    if (indexAwal != index && emailController[index].text != "") {
      print("Kembar".tr);
      return "InfoPraTenderCreateEmailSudahAda".tr;
    }

    //CEK KE DATA EMAIL YANG SUDAH PERNAH DIBUAT APA ADA YANG KEMBAR
    for (var y = 0; y < dataEmail.length; y++) {
      if (emailController[index].text == dataEmail[y]['name'] &&
          emailController[index].text != "" &&
          dataEmail[y]['name'] != "") {
        print("Pernah Diundang".tr);
        return "InfoPraTenderDetailEmailSudahAda".tr;
      }
    }

    return "";
  }
}
