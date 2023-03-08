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
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class CreateManajemenRoleController extends GetxController {
  var namaController = TextEditingController().obs;
  var deskripsiController = TextEditingController().obs;
  var listMenu = [].obs;
  var idListHakAkses = [];
  var isLoading = true.obs;
  var errorNama = "".obs;
  var errorMenu = "".obs;
  var indexMenu = (-1).obs;
  var idmenu = 0;
  var validasiSimpan = true;
  var form = GlobalKey<FormState>();
  var dataSebelumnya = '';

  @override
  void onInit() async {
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
    print(result);
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
      isLoading.value = false;

      onSetData('SET');
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
            'TAMBAH',
            dataSebelumnya,
            '0'
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
