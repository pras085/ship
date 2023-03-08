import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListDiumumkanKepadaTenderController extends GetxController {
  var validasiSimpan = false;
  var form = GlobalKey<FormState>();

  var dataAll = [
    {
      'name': 'Semua Mitra',
      'id': 'allMitra',
      'ismitra': 0,
      'isgroup': 0,
      'invited_email': 0,
      'select': false,
      'urutan': 0,
    },
    {
      'name': 'Semua Transporter',
      'id': 'allTransporter',
      'ismitra': 0,
      'isgroup': 0,
      'invited_email': 0,
      'select': false,
      'urutan': 0,
    }
  ].obs;
  var dataGroup = [].obs;
  var dataMitraTransporter = [].obs;
  var dataEmail = [].obs;

  var mode = "";

  @override
  void onInit() {
    super.onInit();

    mode = Get.arguments[4];
    print(mode);
    print('TES');

    //ALL
    for (var x = 0; x < dataAll.length; x++) {
      dataAll[x]['select'] = Get.arguments[0].value[x]['select'];
      dataAll[x]['urutan'] = Get.arguments[0].value[x]['urutan'];
    }
    //GROUP
    for (var x = 0; x < Get.arguments[1].value.length; x++) {
      dataGroup.add({
        'ismitra': 0,
        'isgroup': 0,
        'invited_email': 0,
        'id': Get.arguments[1].value[x]['id'],
        'name': Get.arguments[1].value[x]['name'],
        'image': Get.arguments[1].value[x]['image'],
        'select': Get.arguments[1].value[x]['select'],
        'data': Get.arguments[1].value[x]['data'],
        'urutan': Get.arguments[1].value[x]['urutan'],
      });
    }

    print(dataGroup);
    //MITRA TRANSPORTER
    for (var x = 0; x < Get.arguments[2].value.length; x++) {
      dataMitraTransporter.add({
        'ismitra': Get.arguments[2].value[x]['ismitra'],
        'isgroup': 0,
        'invited_email': 0,
        'id': Get.arguments[2].value[x]['id'],
        'name': Get.arguments[2].value[x]['name'],
        'image': Get.arguments[2].value[x]['image'],
        'select': Get.arguments[2].value[x]['select'],
        'urutan': Get.arguments[2].value[x]['urutan'],
      });
    }

    //EMAIL
    for (var x = 0; x < Get.arguments[3].value.length; x++) {
      dataEmail.add({
        'ismitra': 0,
        'isgroup': 0,
        'invited_email': 1,
        'id': "0",
        'name': Get.arguments[3].value[x]['name'],
        'image': "",
        'select': false,
        'urutan': Get.arguments[3].value[x]['urutan'],
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onReset() {
    //JIKA DICENTANG DATA SEMUA MITRA
    if (dataAll[0]['select']) {
      dataAll[0]['select'] = false;
      dataAll[0]['urutan'] = 0;
    }
    //JIKA DICENTANG DATA SEMUA TRANSPORTER
    if (dataAll[1]['select']) {
      dataAll[1]['select'] = false;
      dataAll[1]['urutan'] = 0;
    }

    for (var x = 0; x < dataGroup.length; x++) {
      dataGroup[x]['select'] = false;
      dataGroup[x]['urutan'] = 0;
    }

    for (var x = 0; x < dataMitraTransporter.length; x++) {
      dataMitraTransporter[x]['select'] = false;
      dataMitraTransporter[x]['urutan'] = 0;
    }

    dataEmail.clear();
    dataEmail.add({
      'ismitra': 0,
      'isgroup': 0,
      'invited_email': 1,
      'id': "0",
      'name': "",
      'image': "",
      'select': false,
      'urutan': 0,
    });
  }

  void onSave() {
    //BERSIHKAN EMAIL, JIKA ADA YANG KOSONG
    for (var x = dataEmail.length - 1; x >= 0; x--) {
      if (dataEmail[x]['name'] == "") {
        dataEmail.removeAt(x);
      }
    }

    //JIKA SUDAH DIHAPUS SEMUA, SISAKAN 1 KOSONG
    if (dataEmail.length == 0) {
      dataEmail.add({
        'ismitra': 0,
        'isgroup': 0,
        'invited_email': 1,
        'id': "0",
        'name': "",
        'image': "",
        'select': false,
        'urutan': 0,
      });
    }

    //BACK 2x
    Get.back(result: [
      dataAll.value,
      dataGroup.value,
      dataMitraTransporter.value,
      dataEmail.value
    ]);
  }

  /*
    String text = Jenis sort berdasarkan apa
    List<String> urutanSort = Urutan sort yang digunakan
  */
  Widget expandedWidget(String text, List<dynamic> data) {
    return Theme(
        data: Theme.of(Get.context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ListTileTheme(
            dense: true,
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              initiallyExpanded: true,
              title: CustomText(
                text.tr,
                color: Color(ListColor.colorDarkGrey3),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              children: [
                lineDividerWidget(),
                SizedBox(
                  height: GlobalVariable.ratioWidth(Get.context) * 6,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 6),
                    itemCount: data.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var cekAda = false;
                      //JIKA DIA MITRA CEK APAKAH ADA DI GROUP, JIKA ADA TIDAK PERLU TAMPIL
                      //KENAPA DETAIL_INFO_PRA_TENDER TIDAK ADA IF KARENA DIPAKAI DATA GROUPNYA TDK ADA YANG LAIN
                      if (data[index]['ismitra'] == 1 &&
                          mode != "DETAIL_INFO_PRA_TENDER") {
                        for (var x = 0; x < dataGroup.length; x++) {
                          for (var y = 0;
                              y < dataGroup[x]['data'].length;
                              y++) {
                            if (dataGroup[x]['data'][y]['MitraID'].toString() ==
                                    data[index]['id'] &&
                                dataGroup[x]['select'] == true) {
                              cekAda = true;
                            }
                          }
                        }
                      }

                      return !cekAda
                          ? ListTile(
                              contentPadding: EdgeInsets.only(
                                  left: 0,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          6),
                              dense: true,
                              leading: data[index]['invited_email'] == 1
                                  ? null
                                  : data[index]['image'] != ""
                                      ? Material(
                                          shape: CircleBorder(),
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: Container(
                                              width: 40,
                                              height: 40,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    data[index]['image'] ?? "",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                ),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                              )))
                                      : SizedBox(),
                              title: CustomText(data[index]['name'],
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              trailing: mode == "DETAIL_INFO_PRA_TENDER" ||
                                      mode == "EDIT_INFO_PRA_TENDER_SEKARANG" ||
                                      mode == "DETAIL_PROSES_TENDER" ||
                                      mode == "EDIT_PROSES_TENDER_SEKARANG"
                                  ? SizedBox()
                                  : data[index]['invited_email'] == 1 &&
                                          data[index]['name'] == ""
                                      ? SizedBox()
                                      : GestureDetector(
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'ic_close.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12,
                                              color: Color(
                                                  ListColor.colorDarkGrey3)),
                                          onTap: () async {
                                            if (data[index]['invited_email'] ==
                                                0) {
                                              data[index]['select'] = false;
                                              data[index]['urutan'] = 0;
                                              selectTransporter(
                                                  data[index]['id'],
                                                  data[index]['ismitra'],
                                                  data[index]['isgroup'],
                                                  false);
                                            } else {
                                              for (var x = 0;
                                                  x < dataEmail.length;
                                                  x++) {
                                                if (dataEmail[x]['name'] ==
                                                    data[index]['name']) {
                                                  hapusEmail(x);
                                                }
                                              }
                                            }
                                          },
                                        ))
                          : SizedBox();
                    })
              ],
            )));
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorListTransporter),
        height: GlobalVariable.ratioWidth(Get.context) *
            1, //DIKASIH TINGGI SUPAYA GARISNYA MUNCUL
      ),
    );
  }

  void selectTransporter(String id, int ismitra, int isgroup, bool check) {
    print('MASUK');
    //HAPUS
    if (id == "allMitra") {
      for (var x = 0; x < dataGroup.length; x++) {
        dataGroup[x]['select'] = false;
        dataGroup[x]['urutan'] = 0;
      }
      for (var x = 0; x < dataMitraTransporter.length; x++) {
        if (dataMitraTransporter[x]['ismitra'] == 1) {
          dataMitraTransporter[x]['select'] = false;
          dataMitraTransporter[x]['urutan'] = 0;
        }
      }
    } else if (id == "allTransporter") {
      for (var x = 0; x < dataGroup.length; x++) {
        dataGroup[x]['select'] = false;
        dataGroup[x]['urutan'] = 0;
      }
      for (var x = 0; x < dataMitraTransporter.length; x++) {
        dataMitraTransporter[x]['select'] = false;
        dataMitraTransporter[x]['urutan'] = 0;
      }
    } else if (isgroup == 1) {
      for (var x = 0; x < dataGroup.length; x++) {
        if (dataGroup[x]['id'] == id) {
          for (var y = 0; y < dataGroup[x]['data'].length; y++) {
            for (var z = 0; z < dataMitraTransporter.length; z++) {
              if (dataMitraTransporter[z]['id'] ==
                      dataGroup[x]['data'][y]['MitraID'].toString() &&
                  dataMitraTransporter[z]['ismitra'] == 1) {
                //JIKA ADA MITRANYA CEK KEMBALI, APAKAH MITRA INI TERKAIT DENGAN GRUP LAIN YANG TERPILIH
                var cekAda = false;
                for (var x1 = 0; x1 < dataGroup.length; x1++) {
                  for (var y1 = 0; y1 < dataGroup[x1]['data'].length; y1++) {
                    if (dataMitraTransporter[z]['id'] ==
                            dataGroup[x1]['data'][y1]['MitraID'].toString() &&
                        dataGroup[x1]['select'] == true) {
                      cekAda = true;
                    }
                  }
                }
                if (!cekAda) {
                  dataMitraTransporter[z]['select'] = false;
                  dataMitraTransporter[z]['urutan'] = 0;
                }
              }
            }
          }
        }
      }

      dataAll[0]['select'] = false;
      dataAll[0]['urutan'] = 0;
      dataAll[1]['select'] = false;
      dataAll[1]['urutan'] = 0;
    } else if (ismitra == 1) {
      //JIKA MITRA UNCENTANG, UNCENTANG SEMUA GRUP YANG TERKAIT,  SEMUA MITRA, DAN SEMUA TRANSPORTER
      List<int> groupIndex = [];

      //CARI GROUP YANG ADA MITRA INI, LALU DI FALSE KAN
      for (var x = 0; x < dataGroup.length; x++) {
        for (var y = 0; y < dataGroup[x]['data'].length; y++) {
          if (dataGroup[x]['data'][y]['MitraID'].toString() == id) {
            dataGroup[x]['select'] = false;
            dataGroup[x]['urutan'] = 0;
          }
        }
      }

      dataAll[0]['select'] = false;
      dataAll[0]['urutan'] = 0;
      dataAll[1]['select'] = false;
      dataAll[1]['urutan'] = 0;
    } else {
      //JIKA HANYA TRANSPORTER YANG UNCENTANG, BERARTI UNCENTANG SEMUA TRANSPORTER
      dataAll[1]['select'] = false;
      dataAll[1]['urutan'] = 0;
    }

    dataMitraTransporter.refresh();
    dataGroup.refresh();
    dataAll.refresh();
  }

  void hapusEmail(int index) {
    if (dataEmail.length == 1) {
      dataEmail[index]['name'] = "";
    } else {
      dataEmail.removeAt(index);
    }
    dataEmail.refresh();
  }
}
