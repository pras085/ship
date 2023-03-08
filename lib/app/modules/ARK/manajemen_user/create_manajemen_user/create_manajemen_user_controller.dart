import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class CreateManajemenUserController extends GetxController {
  var loading = true.obs;
  var isEdit = false.obs;
  var id = "".obs;
  var namaController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var validasiSimpan = true;
  var validasiNama = "".obs;
  var validasiEmail = "".obs;
  var validasiPhone = "".obs;
  var isChanged = false.obs;
  var dataawal = {"name": "", "email": "", "phone": ""}.obs;
  var formKey = GlobalKey<FormState>();
  var cekTambah = false;

  @override
  void onInit() async {
    isEdit.value = Get.arguments[0] ?? false;
    if (isEdit.value) {
      var dataUser = Get.arguments[1];
      namaController.text = dataUser['name'];
      emailController.text = dataUser['email'];
      phoneController.text = dataUser['phone'];
      dataawal.value = {
        "name": dataUser['name'].toString(),
        "email": dataUser['email'].toString(),
        "phone": dataUser['phone'].toString(),
      };
      id.value = dataUser['id'];
    }
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void checkChange() {
    bool change = false;
    if (namaController.text != dataawal['name']) {
      change = true;
    }
    if (emailController.text != dataawal['email']) {
      change = true;
    }
    if (phoneController.text != dataawal['phone']) {
      change = true;
    }
    isChanged.value = change;
  }

  void onSubmit() async {
    cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Sub User",
        denganLoading: true);
    if (SharedPreferencesHelper.cekAkses(cekTambah)) {
      showDialog(
          context: Get.context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () {},
                child: Center(child: CircularProgressIndicator()));
          });
      bool valid = true;
      if (namaController.text == "") {
        validasiNama.value =
            "ManajemenUserTambahUserAndaBelumMengisiNamaLengkap".tr;
        valid = false;
      } else {
        validasiNama.value = "";
      }
      if (emailController.text == "") {
        validasiEmail.value = "ManajemenUserTambahUserAndaBelumMengisiEmail".tr;
        valid = false;
      } else {
        validasiEmail.value = "";
      }
      if (phoneController.text == "") {
        validasiPhone.value =
            "ManajemenUserTambahUserAndaBelumMengisiNoWhatsapp".tr;
        valid = false;
      } else {
        validasiPhone.value = "";
      }
      if (valid) {
        var result = await ApiHelper(
                context: Get.context,
                isShowDialogLoading: false,
                isShowDialogError: false)
            .createSubUser(id.toString(), namaController.text,
                emailController.text, phoneController.text);

        if (result != null && result['Message']['Code'].toString() == '200') {
          print("BERHASIL SIMPAN");
          Get.back();
          Get.back(result: true);

          if (isEdit.value) {
            CustomToast.show(
                context: Get.context,
                message: "ManajemenUserTambahUserLabelUser".tr +
                    " " +
                    namaController.text +
                    " " +
                    "ManajemenUserTambahUserUserBerhasilDiEdit".tr);
          } else {
            CustomToast.show(
                context: Get.context,
                message: "ManajemenUserTambahUserBerhasilMenambahkanUser1".tr +
                    " " +
                    namaController.text +
                    "ManajemenUserTambahUserBerhasilMenambahkanUser2".tr);
          }
        } else if (result != null &&
            result['Message']['Code'].toString() == '500') {
          var dataResponse = result['Data'] ?? {};
          if (dataResponse['email'] != null) {
            validasiEmail.value = dataResponse["email"] ?? "";
            valid = false;
          }
          if (dataResponse['phone'] != null) {
            validasiPhone.value = dataResponse["phone"] ?? "";
            valid = false;
          } else {
            validasiPhone.value = "";
          }
          Get.back();
        }
      } else {
        Get.back();
      }
      formKey.currentState.validate();
    }
  }
}
