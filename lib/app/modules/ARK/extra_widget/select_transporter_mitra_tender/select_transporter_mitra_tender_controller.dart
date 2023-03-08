import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_diumumkan_kepada_tender/list_diumumkan_kepada_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SelectTransporterMitraTenderController extends GetxController {
  var validasiSimpan = false;
  var dataAll = [
    {
      'name': 'InfoPraTenderCreateLabelSemuaMitra'.tr,
      'id': 'allMitra',
      'ismitra': 0,
      'isgroup': 0,
      'invited_email': 0,
      'select': false,
      'urutan': 0,
    },
    {
      'name': 'InfoPraTenderCreateLabelSemuaTransporter'.tr,
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

  var jmlMitraTransporter = 0;
  var jmlGroup = 0;

  var dataRuteTenderSebelumSimpan = {}.obs;

  var dataSelectedUrut = [].obs;

  var dataSelectedTampil = [].obs;

  var emailController = [].obs;

  var invitedTransporter = false.obs;

  var form = GlobalKey<FormState>();

  var searchBar = TextEditingController(text: '').obs;
  var isloading = false.obs;

  var urutan = 0;

  @override
  Future<void> onInit() async {
    await getDataTransporter();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void getDataTransporter() async {
    print('init');
    isloading.value = true;
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    var result =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .listTransporterMitraGroup(shipperID);
    if (result['Message']['Code'].toString() == '200') {
      var dataTransporterMitraGroup = result['Data'];
      print("ini data mitra transporter");
      print(dataTransporterMitraGroup);

      //MASUKAN API KE ARRAY
      for (var x = 0; x < dataTransporterMitraGroup.length; x++) {
        dataGroup.add({
          'ismitra': 0,
          'isgroup': 1,
          'invited_email': 0,
          'id': dataTransporterMitraGroup[x]['GroupID'].toString(),
          'name': dataTransporterMitraGroup[x]['Name'],
          'image': dataTransporterMitraGroup[x]['Avatar'],
          'select': false,
          'data': dataTransporterMitraGroup[x]['Mitra'],
          'urutan': 0,
        });
      }

      result = await ApiHelper(context: Get.context, isShowDialogLoading: false)
          .listTransporterSaja(shipperID);

      if (result['Message']['Code'].toString() == '200') {
        var dataTransporterSaja = result['Data'];

        isloading.value = false;

        //MASUKAN API KE ARRAY
        for (var x = 0; x < dataTransporterSaja.length; x++) {
          var id = dataTransporterSaja[x]['TransporterID'];

          if (dataTransporterSaja[x]['MitraID'] != 0) {
            id = dataTransporterSaja[x]['MitraID'];
          }

          dataMitraTransporter.add({
            'ismitra': dataTransporterSaja[x]['IsMitra'],
            'isgroup': 0,
            'invited_email': 0,
            'id': id.toString(),
            'name': dataTransporterSaja[x]['Name'],
            'image': dataTransporterSaja[x]['Avatar'],
            'select': false,
            'urutan': 0,
          });
        }

        //JIKA SUDAH PERNAH DIPILIH, ISI DENGAN YANG LAMA
        for (var x = 0; x < dataAll.length; x++) {
          dataAll[x]['select'] = Get.arguments[0].value[x]['select'];
          dataAll[x]['urutan'] = Get.arguments[0].value[x]['urutan'];
        }

        //GROUP
        for (var x = 0; x < dataGroup.length; x++) {
          for (var y = 0; y < Get.arguments[1].value.length; y++) {
            if (dataGroup[x]['id'] == Get.arguments[1].value[y]['id']) {
              dataGroup[x]['select'] = Get.arguments[1].value[y]['select'];
              dataGroup[x]['urutan'] = Get.arguments[1].value[y]['urutan'];
            }
          }
        }

        //MITRA TRANSPORTER
        for (var x = 0; x < dataMitraTransporter.length; x++) {
          for (var y = 0; y < Get.arguments[2].value.length; y++) {
            if (dataMitraTransporter[x]['id'] ==
                Get.arguments[2].value[y]['id']) {
              dataMitraTransporter[x]['select'] =
                  Get.arguments[2].value[y]['select'];

              dataMitraTransporter[x]['urutan'] =
                  Get.arguments[2].value[y]['urutan'];
            }
          }
        }

        dataEmail.clear();

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

          emailController.add(
              TextEditingController(text: Get.arguments[3].value[x]['name']));

          if (dataEmail[x]['name'] != "") {
            invitedTransporter.value = true;
          }
        }

        collectData();
      }

      jmlGroup = json.decode(json.encode(dataGroup)).length;
      jmlMitraTransporter =
          json.decode(json.encode(dataMitraTransporter)).length;
      print('GROUP : ' + jmlGroup.toString());
      print('MITRA / TRANSPORTER : ' + jmlMitraTransporter.toString());
    }
  }

  void selectTransporter(String id, int ismitra, int isgroup, bool check) {
    //JIKA SEMUA MITRA DICENTANG
    if (check) {
      //JIKA SEMUA TRANSPORTER TERCENTANG, SEMUA TERCENTANG KECUALI SEMUA MITRA
      if (id == "allTransporter") {
        for (var x = 0; x < dataGroup.length; x++) {
          dataGroup[x]['select'] = true;
          dataGroup[x]['urutan'] = urutan;
        }

        for (var x = 0; x < dataMitraTransporter.length; x++) {
          dataMitraTransporter[x]['select'] = true;
          dataMitraTransporter[x]['urutan'] = urutan;
        }
      } else if (id == "allMitra") {
        for (var x = 0; x < dataGroup.length; x++) {
          dataGroup[x]['select'] = true;
          dataGroup[x]['urutan'] = urutan;
        }

        for (var x = 0; x < dataMitraTransporter.length; x++) {
          if (dataMitraTransporter[x]['ismitra'] == 1) {
            dataMitraTransporter[x]['select'] = true;
            dataMitraTransporter[x]['urutan'] = urutan;
          }
        }
      }

      //JIKA GROUP TERCENTANG, SEMUA MITRA ATAS GROUP ITU IKUT TERCENTANG
      else if (isgroup == 1) {
        for (var x = 0; x < dataGroup.length; x++) {
          if (dataGroup[x]['id'] == id) {
            for (var y = 0; y < dataGroup[x]['data'].length; y++) {
              for (var z = 0; z < dataMitraTransporter.length; z++) {
                if (dataMitraTransporter[z]['id'] ==
                        dataGroup[x]['data'][y]['MitraID'].toString() &&
                    dataMitraTransporter[z]['ismitra'] == 1) {
                  dataMitraTransporter[z]['select'] = true;
                  dataMitraTransporter[z]['urutan'] = urutan;
                }
              }
            }
          }
        }
      }
    } else {
      //TIDAK DICENTANG

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
        if (dataAll[0]['select'] == false) {
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
        }

        for (var x = 0; x < dataMitraTransporter.length; x++) {
          if (dataMitraTransporter[x]['ismitra'] == 0) {
            dataMitraTransporter[x]['select'] = false;
            dataMitraTransporter[x]['urutan'] = 0;
          }
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
    }

    dataMitraTransporter.refresh();
    dataGroup.refresh();
    dataAll.refresh();

    collectData();
  }

  void onSearch() {
    searchBar.refresh();
    dataMitraTransporter.refresh();
    dataGroup.refresh();
    dataAll.refresh();
    dataSelectedTampil.refresh();
    dataSelectedUrut.refresh();
  }

  void onClearSearch() {
    searchBar.value.clear();
    searchBar.refresh();
    dataMitraTransporter.refresh();
    dataGroup.refresh();
    dataAll.refresh();
    dataSelectedTampil.refresh();
    dataSelectedUrut.refresh();
  }

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
    emailController.clear();
    for (var x = 0; x < dataEmail.length; x++) {
      emailController.add(TextEditingController(text: ''));
    }

    invitedTransporter.value = false;

    urutan = 0;

    dataSelectedTampil.clear();
    dataSelectedUrut.clear();

    dataSelectedTampil.refresh();
    dataSelectedUrut.refresh();

    onClearSearch();
  }

  void cekEmail() {
    form.currentState.validate();
    //JIKA ADA EMAIL DITAMBAHKAN
    for (var index = 0; index < emailController.length; index++) {
      var cekAda = false;
      //JIKA EMAIL TIDAK VALID, HAPUS
      if (cekFormatEmail(emailController[index].text) != "") {
        dataEmail[index]['urutan'] = 0;
        dataEmail[index]['name'] = "";
      } else if (cekEmailKembar(index) != "") {
        dataEmail[index]['urutan'] = 0;
        dataEmail[index]['name'] = "";
      } else {
        for (var x = 0; x < dataEmail.length; x++) {
          //EMAIL TERSEBUT SUDAH PERNAH ADA ATAU BELUM
          if (emailController[x].text == emailController[index].text &&
              x != index) {
            cekAda = true;
          }
        }
        if (!cekAda) {
          urutan++;
          dataEmail[index]['name'] = emailController[index].text;
          dataEmail[index]['urutan'] = urutan;
        } else {
          dataEmail[index]['name'] = emailController[index].text;
        }
      }
    }

    collectData();
  }

  void onSave() {
    cekEmail();

    //BERSIHKAN EMAIL, JIKA ADA YANG KOSONG
    for (var x = dataEmail.length - 1; x >= 0; x--) {
      if (dataEmail[x]['name'] == "") {
        dataEmail.removeAt(x);
        emailController.removeAt(x);
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
      emailController.add(TextEditingController(text: ''));
    }

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
  Widget expandedWidget(
      Widget title, List<dynamic> data, String tipe, int jmlData) {
    if (searchBar.value.text != "") {
      data = data
          .where((element) => (element['name'] ?? "")
              .toUpperCase()
              .contains(searchBar.value.text.toUpperCase()))
          .toList();
    } else {
      if (tipe == "transporter / mitra") {
        data = data
            .where((element) =>
                element['ismitra'] == 1 || element['select'] == true)
            .toList();
      }
    }
    return jmlData > 0 || searchBar.value.text == ""
        ? Theme(
            data: Theme.of(Get.context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ListTileTheme(
                dense: true,
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  title: title,
                  initiallyExpanded: true,
                  children: [
                    lineDividerWidget(),
                    jmlData > 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                //JIKA DIA TIDAK MENGGUNAKAN PENCARIAN, TAMPILKAN MAKSIMAL 8
                                for (var index = 0;
                                    index <
                                        (data.length > 8 &&
                                                searchBar.value.text == ""
                                            ? 8
                                            : data.length);
                                    index += 2)
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                top: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    15),
                                            width: ((MediaQuery.of(Get.context)
                                                        .size
                                                        .width -
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        44) /
                                                2),
                                            child: GestureDetector(
                                                onTap: () {
                                                  if (data[index]['select']) {
                                                    data[index]['select'] =
                                                        false;
                                                  } else {
                                                    data[index]['select'] =
                                                        true;
                                                  }

                                                  if (data[index]['select']) {
                                                    urutan++;
                                                    data[index]['urutan'] =
                                                        urutan;
                                                  } else {
                                                    data[index]['urutan'] = 0;
                                                  }

                                                  selectTransporter(
                                                      data[index]['id'],
                                                      data[index]['ismitra'],
                                                      data[index]['isgroup'],
                                                      data[index]['select']);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CheckBoxCustom(
                                                        size: 14,
                                                        paddingSize: 5,
                                                        shadowSize: 19,
                                                        isWithShadow: true,
                                                        value: data[index]
                                                            ['select'],
                                                        onChanged: (value) {
                                                          data[index]
                                                                  ['select'] =
                                                              value;
                                                          if (value) {
                                                            urutan++;
                                                            data[index]
                                                                    ['urutan'] =
                                                                urutan;
                                                          } else {
                                                            data[index]
                                                                ['urutan'] = 0;
                                                          }

                                                          selectTransporter(
                                                              data[index]['id'],
                                                              data[index]
                                                                  ['ismitra'],
                                                              data[index]
                                                                  ['isgroup'],
                                                              value);
                                                        }),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            3),
                                                    Container(
                                                        padding: EdgeInsets.only(
                                                            top: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                2),
                                                        child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  width: (MediaQuery.of(Get.context)
                                                                              .size
                                                                              .width /
                                                                          2) -
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          72 +
                                                                      (data[index]['ismitra'] !=
                                                                              0
                                                                          ? 0
                                                                          : GlobalVariable.ratioWidth(Get.context) *
                                                                              18),
                                                                  child:
                                                                      SubstringHighlight(
                                                                          text: data[index]
                                                                              [
                                                                              'name'],
                                                                          term: searchBar
                                                                              .value
                                                                              .text,
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'AvenirNext',
                                                                            color:
                                                                                Color(ListColor.colorGrey4),
                                                                            fontSize:
                                                                                GlobalVariable.ratioWidth(Get.context) * 12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                          textStyleHighlight: TextStyle(
                                                                              fontFamily: 'AvenirNext',
                                                                              fontSize: GlobalVariable.ratioWidth(Get.context) * 12,
                                                                              color: Color(ListColor.colorGrey4),
                                                                              fontWeight: FontWeight.w700))),
                                                              data[index]['ismitra'] !=
                                                                      0
                                                                  ? SvgPicture.asset(
                                                                      GlobalVariable
                                                                              .imagePath +
                                                                          "ic_mitra.svg",
                                                                      width:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              18,
                                                                      height:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              18)
                                                                  : SizedBox()
                                                            ]))
                                                  ],
                                                ))),
                                        SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12,
                                        ),
                                        (index + 1) < data.length
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    top:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            15),
                                                width: ((MediaQuery.of(Get.context).size.width -
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            44) /
                                                    2),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (data[index + 1]
                                                          ['select']) {
                                                        data[index + 1]
                                                            ['select'] = false;
                                                      } else {
                                                        data[index + 1]
                                                            ['select'] = true;
                                                      }

                                                      if (data[index + 1]
                                                          ['select']) {
                                                        urutan++;
                                                        data[index + 1]
                                                            ['urutan'] = urutan;
                                                      } else {
                                                        data[index + 1]
                                                            ['urutan'] = 0;
                                                      }

                                                      selectTransporter(
                                                          data[index + 1]['id'],
                                                          data[index + 1]
                                                              ['ismitra'],
                                                          data[index + 1]
                                                              ['isgroup'],
                                                          data[index + 1]
                                                              ['select']);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CheckBoxCustom(
                                                            size: 14,
                                                            paddingSize: 5,
                                                            shadowSize: 19,
                                                            isWithShadow: true,
                                                            value:
                                                                data[index + 1]
                                                                    ['select'],
                                                            onChanged: (value) {
                                                              data[index + 1][
                                                                      'select'] =
                                                                  value;
                                                              if (value) {
                                                                urutan++;
                                                                data[index + 1][
                                                                        'urutan'] =
                                                                    urutan;
                                                              } else {
                                                                data[index + 1][
                                                                    'urutan'] = 0;
                                                              }

                                                              selectTransporter(
                                                                  data[index +
                                                                      1]['id'],
                                                                  data[index +
                                                                          1][
                                                                      'ismitra'],
                                                                  data[index +
                                                                          1][
                                                                      'isgroup'],
                                                                  value);
                                                            }),
                                                        SizedBox(
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                3),
                                                        Container(
                                                            padding: EdgeInsets.only(
                                                                top: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    2),
                                                            child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                      width: (MediaQuery.of(Get.context).size.width / 2) -
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              72 +
                                                                          (data[index + 1]['ismitra'] != 0
                                                                              ? 0
                                                                              : GlobalVariable.ratioWidth(Get.context) * 18),
                                                                      child: SubstringHighlight(
                                                                          text: data[index + 1]['name'],
                                                                          term: searchBar.value.text,
                                                                          textStyle: TextStyle(
                                                                            fontFamily:
                                                                                'AvenirNext',
                                                                            color:
                                                                                Color(ListColor.colorGrey4),
                                                                            fontSize:
                                                                                GlobalVariable.ratioWidth(Get.context) * 12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                          textStyleHighlight: TextStyle(fontFamily: 'AvenirNext', fontSize: GlobalVariable.ratioWidth(Get.context) * 12, color: Color(ListColor.colorGrey4), fontWeight: FontWeight.w700))),
                                                                  data[index + 1]
                                                                              [
                                                                              'ismitra'] !=
                                                                          0
                                                                      ? SvgPicture.asset(
                                                                          GlobalVariable.imagePath +
                                                                              "ic_mitra.svg",
                                                                          width: GlobalVariable.ratioWidth(Get.context) *
                                                                              18,
                                                                          height:
                                                                              GlobalVariable.ratioWidth(Get.context) * 18)
                                                                      : SizedBox()
                                                                ]))
                                                      ],
                                                    )))
                                            : SizedBox(
                                                width: (MediaQuery.of(Get.context)
                                                            .size
                                                            .width -
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            44) /
                                                    2),
                                      ])
                              ])
                        : tipe != ""
                            ? Center(
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16),
                                    child: CustomText(
                                        tipe == "group"
                                            ? 'InfoPraTenderCreateLabelNoGroup'
                                                .tr // Anda tidak memiliki group
                                            : tipe == "transporter / mitra"
                                                ? 'InfoPraTenderCreateLabelNoMitraTransporter' // Anda tidak memiliki transporter / mitra
                                                    .tr
                                                : "",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.center,
                                        color: Color(ListColor.colorGrey4))))
                            : SizedBox(),
                    tipe == "group"
                        ? Column(
                            children: [
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18),
                              jmlData > 8 && searchBar.value.text == ""
                                  ? Container(
                                      width:
                                          MediaQuery.of(Get.context).size.width,
                                      padding: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(Get.context) *
                                              7,
                                          right: GlobalVariable.ratioWidth(Get.context) *
                                              7,
                                          bottom: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              2),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Color(ListColor.colorBlue)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6))),
                                      child: Column(
                                        children: [
                                          CustomText(
                                              'InfoPraTenderCreateLabelInfoJumlahMitraTransporter'
                                                      .tr +
                                                  ' ' + //Terdapat
                                                  (jmlData).toString() +
                                                  ' ' +
                                                  'InfoPraTenderCreateLabelGroup'
                                                      .tr,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              textAlign: TextAlign.center,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                          CustomText(
                                              'InfoPraTenderCreateLabelPlaceholderCariGroup'
                                                  .tr //Gunakan pencarian untuk mencari group
                                                  .tr,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.center,
                                              color: Color(ListColor.colorBlue))
                                        ],
                                      ))
                                  : SizedBox()
                            ],
                          )
                        : tipe == "transporter / mitra"
                            ? Column(
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          18),
                                  jmlData > 8 && searchBar.value.text == ""
                                      ? Container(
                                          width: MediaQuery.of(Get.context)
                                              .size
                                              .width,
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7,
                                              bottom:
                                                  GlobalVariable.ratioWidth(Get.context) *
                                                      2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(ListColor.colorBlue)),
                                              borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6))),
                                          child: Column(
                                            children: [
                                              CustomText(
                                                  'InfoPraTenderCreateLabelInfoJumlahMitraTransporter'
                                                          .tr +
                                                      ' ' + //Terdapat
                                                      (jmlData).toString() +
                                                      ' ' +
                                                      'InfoPraTenderCreateLabelInfoMitraTransporter' //Mitra/Transporter
                                                          .tr,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  textAlign: TextAlign.center,
                                                  color: Color(
                                                      ListColor.colorBlue)),
                                              CustomText(
                                                  'InfoPraTenderCreateLabelPlaceholderCariMitraTransporter' // Gunakan pencarian untuk mencari mitra / transporter
                                                      .tr,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  textAlign: TextAlign.center,
                                                  color: Color(
                                                      ListColor.colorBlue))
                                            ],
                                          ))
                                      : SizedBox()
                                ],
                              )
                            : SizedBox(
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    18),
                  ],
                )))
        : SizedBox();
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

  Widget emailInvitationWidget() {
    return Container(
        child: Column(
      children: [
        for (var index = 0; index < dataEmail.value.length; index++)
          Container(
              margin: EdgeInsets.only(
                  bottom: GlobalVariable.ratioWidth(Get.context) * 15),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: GlobalVariable.ratioWidth(Get.context) * 34,
                        child: CustomText(
                          "InfoPraTenderCreateLabelEmail".tr, //Email
                          color: Color(ListColor.colorGrey4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        textSize: 12,
                        context: Get.context,
                        newContentPadding: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                          //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                        ),
                        newInputDecoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefix: SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 7),
                          suffix: SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 7),
                          isDense: true,
                          isCollapsed: true,
                          hintText:
                              "InfoPraTenderCreateLabelEmailPlaceholderNoTransporter"
                                  .tr, //Email yang ingin diundang
                          hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onEditingComplete: () {
                          cekEmail();
                        },
                        controller: emailController[index],
                        validator: (value) {
                          var error = "";

                          error = cekFormatEmail(value);

                          if (error == "") {
                            error = cekEmailKembar(index);
                          }

                          if (error == "") {
                            return null;
                          } else {
                            return error;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10),
                    dataEmail.length > 1
                        ? GestureDetector(
                            onTap: () {
                              hapusEmail(index);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 34,
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        'minus_square.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)))
                        : SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 20),
                    dataEmail.length > 1
                        ? SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 14)
                        : SizedBox(),
                    index == dataEmail.length - 1
                        ? GestureDetector(
                            onTap: () {
                              tambahEmail();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 34,
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        'plus_square.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)))
                        : SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 20),
                  ]))
      ],
    ));
  }

  void tambahEmail() {
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
    emailController.add(TextEditingController(text: ''));
    dataEmail.refresh();
    emailController.refresh();
    cekEmail();
  }

  void hapusEmail(int index) {
    //KHUSUS HAPUS PINDAHKAN DLU
    for (var x = 0; x < emailController.length; x++) {
      if (x != emailController.length - 1 && x == index) {
        emailController[x].text = emailController[x + 1].text;
      }
    }

    if (dataEmail.length == 1) {
      dataEmail[index]['name'] = "";
      emailController[index].clear();
    } else {
      dataEmail.removeAt(index);
      emailController.removeAt(index);
    }

    dataEmail.refresh();
    emailController.refresh();
    cekEmail();
  }

  Widget selectedTransporterWidget(data, int index) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      index < 5
          ? Container(
              decoration: BoxDecoration(
                  color: data['isgroup'] == 1 ||
                          data['id'] == 'allMitra' ||
                          data['id'] == 'allTransporter'
                      ? Color(ListColor.colorLightGrey10)
                      : Color(ListColor.colorLightGrey),
                  border: Border.all(color: Color(ListColor.colorLightGrey10)),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 4)),
              margin: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 6,
                  bottom: GlobalVariable.ratioWidth(Get.context) * 6),
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 4,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    data['name'],
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 7,
                  ),
                  GestureDetector(
                    child: SvgPicture.asset(
                        GlobalVariable.imagePath + 'ic_close.svg',
                        width: GlobalVariable.ratioWidth(Get.context) * 14,
                        height: GlobalVariable.ratioWidth(Get.context) * 14,
                        color: Color(ListColor.colorDarkGrey3)),
                    onTap: () async {
                      print(data['invited_email']);
                      //JIKA BUKAN INVITED EMAIL
                      if (data['invited_email'] == 0) {
                        data['select'] = false;
                        data['urutan'] = 0;
                        selectTransporter(data['id'], data['ismitra'],
                            data['isgroup'], false);
                      } else {
                        for (var x = 0; x < dataEmail.length; x++) {
                          if (emailController[x].text == data['name']) {
                            hapusEmail(x);
                          }
                        }
                      }
                    },
                  ),
                ],
              ))
          : Container(
              margin: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 6,
                  bottom: GlobalVariable.ratioWidth(Get.context) * 6),
              child: GestureDetector(
                child: Material(
                    elevation: 5,
                    color: Colors.transparent,
                    child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          minWidth: GlobalVariable.ratioWidth(Get.context) * 22,
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 22,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Color(ListColor.colorBlue)),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 4)),
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 4,
                        ),
                        child: CustomText(
                            "+" +
                                (dataSelectedTampil.value.length - 5)
                                    .toString(),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorBlue)))),
                onTap: () async {
                  print('TRANSPORTER');
                  for (var x = 0; x < dataSelectedTampil.value.length; x++) {
                    print((x + 1).toString() +
                        " " +
                        dataSelectedTampil.value[x]['name']);
                  }
                  print('TRANSPORTER');
                  var data = await GetToPage.toNamed<
                          ListDiumumkanKepadaTenderController>(
                      Routes.LIST_DIUMUMKAN_KEPADA_TENDER,
                      arguments: [
                        dataAll,
                        dataGroup,
                        dataMitraTransporter,
                        dataEmail,
                        'SELECT_TRANSPORTER_MITRA_TENDER'
                      ]);
                  if (data != null) {
                    dataAll.value = data[0];
                    dataGroup.value = data[1];
                    dataMitraTransporter.value = data[2];
                    dataEmail.value = data[3];

                    dataAll.refresh();
                    dataGroup.refresh();
                    dataMitraTransporter.refresh();
                    dataEmail.refresh();

                    collectData();
                  }
                },
              ))
    ]);
  }

  void collectData() {
    FocusManager.instance.primaryFocus.unfocus();
    var semuaMitra = false;
    var semuaTransporter = false;
    dataSelectedUrut.clear();
    dataSelectedTampil.clear();

    //JIKA DICENTANG DATA SEMUA MITRA
    if (dataAll[0]['select']) {
      dataSelectedUrut.add(dataAll[0]);
      semuaMitra = true;
    }
    //JIKA DICENTANG DATA SEMUA TRANSPORTER
    if (dataAll[1]['select']) {
      dataSelectedUrut.add(dataAll[1]);
      semuaTransporter = true;
    }

    //UNTUK MITRA YANG ADA PADA DATA GROUP
    var idMitraTermasukGroup = [];

    if (!semuaMitra && !semuaTransporter) {
      //GROUP
      for (var x = 0; x < dataGroup.length; x++) {
        if (dataGroup[x]['select']) {
          dataSelectedUrut.add(dataGroup[x]);
          for (var y = 0; y < dataGroup[x]['data'].length; y++) {
            //CEK APAKAH ADA DATA KEBAR TERHADAP LIST INI
            if (idMitraTermasukGroup
                    .where((element) =>
                        element ==
                        dataGroup[x]['data'][y]['MitraID'].toString())
                    .toList()
                    .length ==
                0) {
              idMitraTermasukGroup
                  .add(dataGroup[x]['data'][y]['MitraID'].toString());
            }
          }
        }
      }

      //MITRA
      for (var x = 0; x < dataMitraTransporter.length; x++) {
        //CEK JIKA DIA DICENTANG, MITRA, DAN TIDAK MASUK GRUP
        if (dataMitraTransporter[x]['select'] &&
            dataMitraTransporter[x]['ismitra'] == 1 &&
            idMitraTermasukGroup
                    .where((element) =>
                        element == dataMitraTransporter[x]['id'].toString())
                    .toList()
                    .length ==
                0) {
          dataSelectedUrut.add(dataMitraTransporter[x]);
        }
      }
    }

    if (!semuaTransporter) {
      for (var x = 0; x < dataMitraTransporter.length; x++) {
        if (dataMitraTransporter[x]['select'] &&
            dataMitraTransporter[x]['ismitra'] == 0) {
          dataSelectedUrut.add(dataMitraTransporter[x]);
        }
      }
    }

    //CEK DATA EMAIL INVITATION
    for (var x = 0; x < dataEmail.length; x++) {
      if (dataEmail[x]['name'] != "") {
        dataSelectedUrut.add({
          'id': '0',
          'name': dataEmail[x]['name'],
          'ismitra': 0,
          'isgroup': 0,
          'invited_email': 1,
          'image': '',
          'urutan': dataEmail[x]['urutan'],
        });
      }
    }

    //SORT DENGAN URUTAN, DAPATKAN YANG URUTAN TERBESAR
    var urutanTerbesar = 0;
    for (var x = 0; x < dataSelectedUrut.length; x++) {
      if (dataSelectedUrut[x]['urutan'] > 0 &&
          urutanTerbesar < dataSelectedUrut[x]['urutan']) {
        urutanTerbesar = dataSelectedUrut[x]['urutan'];
      }
    }

    urutan = urutanTerbesar;

    //URUTKAN DIMULAI 1, KARENA NOL BERARTI TIDAK DIPILIH
    for (var x = 1; x <= urutanTerbesar; x++) {
      for (var y = 0; y < dataSelectedUrut.length; y++) {
        if (x == dataSelectedUrut[y]['urutan']) {
          dataSelectedTampil.add(dataSelectedUrut[y]);
        }
      }
    }

    dataSelectedTampil.refresh();
    dataSelectedUrut.refresh();

    print(dataSelectedUrut);
    print(dataSelectedTampil);
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
          dataEmail[y]['name'] != "" &&
          index != y) {
        print("Pernah Diundang".tr);
        return "InfoPraTenderDetailEmailSudahAda".tr;
      }
    }

    return "";
  }
}
