import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_hak_akses/manajemen_hak_akses_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class EditManajemenRoleController extends GetxController {
  var namaController = TextEditingController().obs;
  var deskripsiController = TextEditingController().obs;
  var listMenu = [].obs;
  var idListHakAkses = [];
  var isLoading = true.obs;
  var errorNama = "".obs;
  var errorMenu = "".obs;
  var indexMenu = (-1).obs;
  var validasiSimpan = true;
  var idrole = "";
  var idmenu = 0;
  var mode = '';
  var form = GlobalKey<FormState>();
  var dataSebelumnya = '';

  @override
  void onInit() async {
    idrole = Get.arguments[0];
    mode = Get.arguments[1];
    await getData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorLightGrey12),
        height: 0,
      ),
    );
  }

  void getData() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDropdownMenu();

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      listMenu.clear();

      (data as List).forEach((element) {
        listMenu.add({
          'id': int.parse(element['ID'].toString()),
          'nama': element['Name'],
        });
      });

      print(listMenu);
    }

    String iduser = await SharedPreferencesHelper.getUserID();
    result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDetailRole(iduser, idrole);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'][0];

      namaController.value.text = data['name'];
      deskripsiController.value.text = data['deskripsi'];
      var aplikasi = "";
      if (data['role_profile'].toString() == '2') {
        aplikasi = "Shipper";
      } else {
        aplikasi = "Transporter";
      }
      print("CEK PILIHAN MENU");
      for (var x = 0; x < listMenu.length; x++) {
        if (listMenu[x]['nama'] == data['menu']) {
          indexMenu.value = x;
          idmenu = listMenu[x]['id'];
        }
      }
      print(data['Menu'].toString());
      var menu = data['Menu'].toString().split('ID: ');

      idListHakAkses.clear();
      //[1].split(',')[0]
      for (var x = 1; x < menu.length; x++) {
        idListHakAkses.add(int.parse(menu[x].split(',')[0]));
      }
      print(idListHakAkses);
      onSetData('SET');
      isLoading.value = false;
    }
  }

  void onSave() async {
    errorNama.value = "";
    errorMenu.value = "";
    validasiSimpan = form.currentState.validate();
    //JIA BELUM PILIH MENU
    if (indexMenu.value == -1) {
      validasiSimpan = false;
      errorMenu.value = "ManajemenRoleTambahRoleAndaBelumMemilihMenuRole".tr;
    }

    if (validasiSimpan) {
      var data = await GetToPage.toNamed<ManajemenHakAksesController>(
          Routes.MANAJEMEN_HAK_AKSES,
          arguments: [
            idmenu.toString(),
            namaController.value.text,
            listMenu[indexMenu.value]['nama'].toString(),
            deskripsiController.value.text,
            idListHakAkses,
            mode,
            dataSebelumnya,
            idrole
          ]);
      if (data != null) {
        errorNama.value = data[0];
        idListHakAkses = data[1];
        print('a');
        print(data[0]);
        form.currentState.validate();
      }
    }
  }

  void onSetData(jenis) {
    if (jenis == 'SET') {
      dataSebelumnya = (namaController.value.text +
          deskripsiController.value.text +
          idmenu.toString() +
          jsonEncode(idListHakAkses));

      print(dataSebelumnya);
    } else if (jenis == 'COMPARE') {
      var dataSekarang = (namaController.value.text +
          deskripsiController.value.text +
          idmenu.toString() +
          jsonEncode(idListHakAkses));

      print(dataSebelumnya);
      print(dataSekarang);

      if (dataSekarang.toString() != dataSebelumnya.toString()) {
        print('POPUP KELUAR');
        GlobalAlertDialog.showAlertDialogCustom(
            context: Get.context,
            title: "ProsesTenderCreateLabelInfoKonfirmasiPembatalan"
                .tr, //Konfirmasi Pembatalan
            message: "ProsesTenderCreateLabelInfoApakahAndaYakinInginKembali"
                    .tr +
                "\n" +
                "ProsesTenderCreateLabelInfoDataTidakDisimpan"
                    .tr, //Apakah anda yakin ingin kembali? Data yang telah diisi tidak akan disimpan
            labelButtonPriority1: GlobalAlertDialog.noLabelButton,
            onTapPriority1: () {},
            onTapPriority2: () async {
              Get.back();
            },
            labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
      } else {
        print('LANGSUNG KELUAR');
        Get.back();
      }
    }
  }
}
