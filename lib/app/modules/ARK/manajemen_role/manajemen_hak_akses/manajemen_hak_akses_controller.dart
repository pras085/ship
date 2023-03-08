import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/contact_partner_info_pra_tender_transporter_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/models/radio_button_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'dart:math' as math;

class ManajemenHakAksesController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;
  var searchController = TextEditingController().obs;
  var posTab = 0.obs;
  var isLoadingData = true.obs;
  var listHakAksesFull;
  var listHakAkses = [].obs;
  var validasiSimpan = true;
  var idListHakAkses = [];
  var idListTerbuka = [];
  var tampilkanSemua = false.obs;
  var dataSebelumnya = '';
  var form = GlobalKey<FormState>();
  String idmenu = '';
  String namarole = '';
  String deskripsirole = '';
  String namamenu = '';
  String error = "";
  String mode = "";
  String idrole = "";

  String tagHakAkses = "0";

  var filterHakAkses = {}.obs; //UNTUK FILTER PENCARIAN HakAkses
  bool isFilterHakAkses =
      false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK

  var resultfilter = "semua".obs;
  FilterCustomControllerArk _filterHakAksesCustomController;
  var status = 0.obs;
  var listWidgetCheckbox = [].obs;
  var isCardNotEmpty = true.obs;

  var cekTambah = false;

  @override
  void onInit() async {
    idmenu = Get.arguments[0].toString(); //
    namarole = Get.arguments[1];
    namamenu = Get.arguments[2];
    deskripsirole = Get.arguments[3];
    idListHakAkses = Get.arguments[4];
    mode = Get.arguments[5];
    dataSebelumnya = Get.arguments[6];
    idrole = Get.arguments[7];

    print(idListHakAkses);
    print("reset filter");
    try {
      Get.delete<FilterCustomControllerArk>(tag: "Hak_Akses");
    } catch (e) {
      print(e);
    }

    await getListHakAkses(filterHakAkses, tipe: "AWAL");

    isLoadingData.value = false;

    print(isLoadingData);
    print('dataSebelumnya');
    print(dataSebelumnya);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void contactPartner(String shipperID) async {}

  void onChangeTab(int pos) {
    tabController.animateTo(pos);
  }

  void showFilter() async {
    _filterHakAksesCustomController.showFilter();
  }

  void reset() async {
    _resetSearchSortingFilter();
  }

  void refreshAll() async {
    isLoadingData.value = true;
    await getListHakAkses(filterHakAkses);
  }

  void onSearch() async {
    searchController.refresh();
    isLoadingData.value = true;
    if (searchController.value.text == "") {
      await getListHakAkses(filterHakAkses);
    } else {
      await getListHakAkses(filterHakAkses, tipe: 'SEARCH');
    }
  }

  void onClearSearch() async {
    searchController.value.clear();
    searchController.refresh();
    isLoadingData.value = true;
    await getListHakAkses(filterHakAkses);
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    filterHakAkses.clear();
    searchController.value.clear();

    isLoadingData.value = true;
    await getListHakAkses(filterHakAkses);
  }

  Future getListHakAkses(datafilter, {String tipe = 'UMUM'}) async {
    print(filterHakAkses);
    print(tipe);

    var result;
    var data;
    var tutup = true;
    listHakAkses.clear();

    if (tipe == 'AWAL') {
      result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchListManajemenHakAkses(
              idmenu, searchController.value.text, filterHakAkses);
      if (result['Message']['Code'].toString() == '200') {
        data = result['Data'];
        listHakAksesFull = result['Data'];
      }
    } else if (tipe == 'SEARCH') {
      tutup = false;
      data = listHakAksesFull;
      print(data);
    } else {
      data = listHakAksesFull;
    }

    for (var x = 0; x < data.length; x++) {
      var listHakAksesLvl2 = [];

      var searchDitemukan2 = false;
      for (var y = 0; y < data[x]['subdata'].length; y++) {
        var listHakAksesLvl3 = [];

        var searchDitemukan3 = false;
        for (var z = 0; z < data[x]['subdata'][y]['subdata'].length; z++) {
          var listHakAksesLvl4 = [];

          var searchDitemukan4 = false;
          for (var a1 = 0;
              a1 < data[x]['subdata'][y]['subdata'][z]['subdata'].length;
              a1++) {
            var choose = false;
            var insert = false;
            for (var i = 0; i < idListHakAkses.length; i++) {
              if (idListHakAkses[i] ==
                  data[x]['subdata'][y]['subdata'][z]['subdata'][a1]['ID']) {
                choose = true;
              }
            }

            if (tipe == 'SEARCH') {
              if (data[x]['subdata'][y]['subdata'][z]['subdata'][a1]
                      ['title_menu_id']
                  .toUpperCase()
                  .contains(searchController.value.text.toUpperCase())) {
                insert = true;
                searchDitemukan4 = true;
                searchDitemukan3 = true;
                searchDitemukan2 = true;
              }
            } else {
              insert = true;
            }

            if (insert) {
              print('LVL 4 : ' +
                  data[x]['subdata'][y]['subdata'][z]['subdata'][a1]
                      ['title_menu_id']);
              listHakAksesLvl4.add({
                'parentID': data[x]['subdata'][y]['subdata'][z]['subdata'][a1]
                    ['parent'],
                'ID': data[x]['subdata'][y]['subdata'][z]['subdata'][a1]['ID'],
                'title_menu_id': data[x]['subdata'][y]['subdata'][z]['subdata']
                    [a1]['title_menu_id'],
                'subdata': [],
                'choose': choose,
                'tutup': tutup,
                'jenis': 'CHECK',
              });
            }
          }

          var choose = false;
          var insert = false;
          for (var i = 0; i < idListHakAkses.length; i++) {
            if (idListHakAkses[i] ==
                data[x]['subdata'][y]['subdata'][z]['ID']) {
              choose = true;
            }
          }

          if (tipe == 'SEARCH') {
            if (data[x]['subdata'][y]['subdata'][z]['title_menu_id']
                .toUpperCase()
                .contains(searchController.value.text.toUpperCase())) {
              insert = true;
              searchDitemukan3 = true;
              searchDitemukan2 = true;
            }

            if (searchDitemukan4) {
              insert = true;
            }
          } else {
            insert = true;
          }
          if (insert) {
            print('LVL 3 : ' +
                data[x]['subdata'][y]['subdata'][z]['title_menu_id']);
            listHakAksesLvl3.add({
              'parentID': data[x]['subdata'][y]['subdata'][z]['parent'],
              'ID': data[x]['subdata'][y]['subdata'][z]['ID'],
              'title_menu_id': data[x]['subdata'][y]['subdata'][z]
                  ['title_menu_id'],
              'subdata': listHakAksesLvl4,
              'choose': choose,
              'tutup': tutup,
              'jenis': 'CHECK',
            });
          }
        }

        var choose = false;
        var insert = false;
        for (var i = 0; i < idListHakAkses.length; i++) {
          if (idListHakAkses[i] == data[x]['subdata'][y]['ID']) {
            choose = true;
          }
        }

        if (tipe == 'SEARCH') {
          if (data[x]['subdata'][y]['title_menu_id']
              .toUpperCase()
              .contains(searchController.value.text.toUpperCase())) {
            insert = true;
            searchDitemukan2 = true;
          }

          if (searchDitemukan3) {
            insert = true;
          }
        } else {
          insert = true;

          //PILIH SEMUA
          if (y == 0) {
            //CEK DATA ADA BANYAK
            bool banyak = false;

            if (data[x]['subdata'].length > 1) {
              banyak = true;
            }

            for (var y = 0; y < data[x]['subdata'].length; y++) {
              if (data[x]['subdata'][y]['subdata'].length > 0) {
                banyak = true;
              }
              for (var z = 0;
                  z < data[x]['subdata'][y]['subdata'].length;
                  z++) {
                if (data[x]['subdata'][y]['subdata'][z]['subdata'].length > 0) {
                  banyak = true;
                }
              }
            }
            if (banyak) {
              listHakAksesLvl2.add({
                'parentID': data[x]['subdata'][y]['parent'],
                'ID': data[x]['ID'],
                'title_menu_id': 'ManajemenRoleTambahRolePilihSemua'.tr,
                'subdata': [],
                'choose': false,
                'tutup': tutup,
                'jenis': 'CHECKALL',
              });
            }
          }
          //PILIH SEMUA
        }

        if (insert) {
          print('LVL 2 : ' + data[x]['subdata'][y]['title_menu_id']);
          listHakAksesLvl2.add({
            'parentID': data[x]['subdata'][y]['parent'],
            'ID': data[x]['subdata'][y]['ID'],
            'title_menu_id': data[x]['subdata'][y]['title_menu_id'],
            'subdata': listHakAksesLvl3,
            'choose': choose,
            'tutup': tutup,
            'jenis': 'CHECK',
          });
        }
      }

      var choose = false;
      var insert = false;
      for (var i = 0; i < idListHakAkses.length; i++) {
        if (idListHakAkses[i] == data[x]['ID']) {
          choose = true;
        }
      }

      for (var i = 0; i < idListTerbuka.length; i++) {
        if (idListTerbuka[i] == data[x]['ID']) {
          tutup = false;
        }
      }

      print(choose);

      if (tipe == 'SEARCH') {
        if (searchDitemukan2) {
          insert = true;
        }
      } else {
        insert = true;
      }

      if (insert) {
        print('LVL 1 : ' + data[x]['title_menu_id']);
        listHakAkses.add({
          'parentID': 0,
          'ID': data[x]['ID'],
          'title_menu_id': data[x]['title_menu_id'],
          'subdata': listHakAksesLvl2,
          'choose': choose,
          'tutup': tutup,
          'jenis': 'CHECK',
        });
      }

      Map<String, dynamic> _mapFilter = {};
      List<WidgetFilterModel> listWidgetFilter = [
        WidgetFilterModel(
          label: [
            '',
          ],
          typeInFilter: TypeInFilter.RADIO_BUTTON,
          customValue: [
            RadioButtonFilterModel(
                id: "semua", value: "ManajemenRoleTambahRoleTampilkanSemua".tr),
            RadioButtonFilterModel(
                id: "dipilih", value: "ManajemenRoleTambahRoleTelahDipilih".tr),
            RadioButtonFilterModel(
                id: "tidak", value: "ManajemenRoleTambahRoleTidakDipilih".tr),
          ],
          keyParam: 'filter',
          hideTitle: true,
        ),
      ];
      _filterHakAksesCustomController = Get.put(
          FilterCustomControllerArk(
            returnData: (data) async {
              _mapFilter.clear();
              _mapFilter.addAll(data);

              isLoadingData.value = true;
              // print(dataval);
              isFilterHakAkses = false;
              // print(data);
              for (int i = 0; i < data.values.length; i++) {
                if (data.values.elementAt(i).length > 0) {
                  isFilterHakAkses = true;
                }
              }
              if (data.values.length > 0) {
                resultfilter.value = data.values.elementAt(0);
              } else {
                resultfilter.value = "semua";
              }

              var urutan = 0;
              filterHakAkses.value = data;
              filterHakAkses.refresh();
              listHakAkses.refresh();

              makeAccessCheckbox();
              isLoadingData.value = false;
              // await getListHakAkses(datafilter);
            },
            listWidgetInFilter: listWidgetFilter,
          ),
          tag: "Hak_Akses");
    }

    listHakAkses.refresh();
    print('LIST HAK AKSES');
    print(listHakAkses);
    makeAccessCheckbox();
    checkAllFromChildren();
    bukaSemuaFromChildren();
    isLoadingData.value = false;
  }

  void makeAccessCheckbox() {
    listWidgetCheckbox.clear();
    isCardNotEmpty.value = false;
    for (int index = 0; index < listHakAkses.length; index++) {
      var widget = false;
      var subdata = listHakAkses[index]["subdata"];
      bool isHide = false;
      if (resultfilter.value == "dipilih") {
        if (listHakAkses[index]["choose"]) {
          widget = true;
        } else {
          widget = false;
        }
        if (listHakAkses[index]["jenis"] == 'CHECKALL') {
          widget = false;
        }
      } else if (resultfilter.value == "tidak") {
        if (!listHakAkses[index]["choose"]) {
          // if (subdata.length > 0) {
          //   widget = true;
          // } else {
          //   widget = false;
          // }
          widget = true;
        } else {
          widget = subdata.length > 0 ? checkAllDataFalse(subdata) : false;
          // widget = false;
          if (listHakAkses[index]["jenis"] != 'CHECKALL') {
            isHide = true;
          }
        }
      } else {
        widget = true;
      }
      if (widget) {
        isCardNotEmpty.value = true;
      }
      listWidgetCheckbox.value.add({
        "access": widget,
        "isHide": isHide,
        "subdata": subdata.length > 0 ? getAccessSubData(subdata) : [],
      });
    }
    listWidgetCheckbox.refresh();
    // print(listWidgetCheckbox);
    // print(listHakAkses);
  }

  bool checkSubDataIsFalse(datasub) {
    bool widget = false;
    for (int index = 0; index < datasub.length; index++) {
      var subdata = datasub[index]["subdata"];
      if (!datasub[index]["choose"]) {
        widget = true;
        print(datasub[index]['title_menu_id']);
      } else {
        if (subdata.length > 0) {
          if (!checkSubDataIsFalse(subdata)) {
            widget = true;
            print(datasub[index]['title_menu_id']);
          }
        }
      }
    }
    // if (widget == true) {
    //   print(datasub);
    // }
    return widget;
  }

  bool checkAllDataFalse(subdata1) {
    bool widget = false;
    for (int index = 0; index < subdata1.length; index++) {
      if (subdata1[index]["choose"] == false) {
        widget = true;
      }
      var subdata2 = subdata1[index]['subdata'];
      if (subdata2.length > 0) {
        for (int index2 = 0; index2 < subdata2.length; index2++) {
          if (subdata2[index2]["choose"] == false) {
            widget = true;
          }
          var subdata3 = subdata2[index2]['subdata'];
          if (subdata3.length > 0) {
            for (int index3 = 0; index3 < subdata3.length; index3++) {
              if (subdata3[index3]["choose"] == false) {
                widget = true;
              }
            }
          }
        }
      }
    }
    return widget;
  }

  List<dynamic> getAccessSubData(datasub) {
    List<dynamic> listdata = [];
    for (int index = 0; index < datasub.length; index++) {
      var widget;
      var subdata = datasub[index]["subdata"];
      bool isHide = false;
      if (resultfilter.value == "dipilih") {
        if (datasub[index]["choose"]) {
          widget = true;
        } else {
          widget = false;
        }
        if (datasub[index]["jenis"] == 'CHECKALL') {
          widget = false;
        }
      } else if (resultfilter.value == "tidak") {
        if (!datasub[index]["choose"]) {
          widget = true;
        } else {
          widget = subdata.length > 0 ? checkSubDataIsFalse(subdata) : false;
          // widget = false;
          if (datasub[index]["jenis"] != 'CHECKALL') {
            isHide = true;
          }
        }
      } else {
        widget = true;
      }
      listdata.add({
        "access": widget,
        "isHide": isHide,
        "subdata": subdata.length > 0 ? getAccessSubData(subdata) : [],
        // "subdata": getAccessSubData(subdata),
      });
    }
    return listdata;
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Expanded(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10),
        height: 0,
      ),
    );
  }

  Widget expandedWidget(int level, data, int index, dataAccess) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            topRight:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            bottomLeft:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            bottomRight:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
          ),
          // color: Color(ListColor.colorHeaderListTender),
          color: GlobalVariable.cardHeaderManajemenColor,
        ),
        padding: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 1,
          right: GlobalVariable.ratioWidth(Get.context) * 1,
          bottom: GlobalVariable.ratioWidth(Get.context) * 1,
        ),
        margin: EdgeInsets.only(
          bottom: (index != (listHakAkses.length - 1))
              ? GlobalVariable.ratioWidth(Get.context) * 16
              : 0,
        ),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  if (data['tutup']) {
                    data['tutup'] = false;
                  } else {
                    data['tutup'] = true;
                  }
                  bukaSemuaFromChildren();
                  listHakAkses.refresh();
                  print(data['tutup']);
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          topRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                        ),
                        color: Colors.transparent),
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                        vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: SubstringHighlight(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: data['title_menu_id'],
                                    term: searchController.value.text,
                                    textStyle: TextStyle(
                                      fontFamily: 'AvenirNext',
                                      color: Colors.black,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textStyleHighlight: TextStyle(
                                        fontFamily: 'AvenirNext',
                                        fontSize: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)))),
                        Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            child: Transform.rotate(
                                angle: (!data['tutup']
                                    ? (-math.pi / 2)
                                    : (math.pi / 2)),
                                child: SvgPicture.asset(
                                  'assets/ic_arrow.svg',
                                  color: Colors.black,
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                ))),
                      ],
                    ))),
            !data['tutup'] && data['subdata'].length != 0
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                        )),
                    // margin: EdgeInsets.only(
                    //     bottom: GlobalVariable.ratioWidth(Get.context) * 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data['subdata'].length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (dataAccess['subdata'][index]['access']) {
                            return detailWidget(
                                (level + 1),
                                data['subdata'][index],
                                index,
                                (listHakAkses.length - 1),
                                dataAccess['subdata'][index]);
                          } else {
                            return Container();
                          }
                        }))
                : SizedBox(),
          ],
        ));
  }

  Widget detailWidget(int level, data, int index, int lastindex, dataAccess) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: !dataAccess["isHide"]
          ? [
              index != 0 || level > 2
                  ? Row(
                      children: [
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 14),
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) *
                                27 *
                                ((level - 3) < 0
                                    ? 0
                                    : (level - 3))), //(level - 3)
                        lineDividerWidget(),
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 14)
                      ],
                    )
                  : SizedBox(),
              GestureDetector(
                  onTap: () {
                    data['choose'] = !data['choose'];
                    ruleCentangan(
                      data['ID'],
                      level,
                      data['choose'],
                      data['jenis'],
                    );
                    listHakAkses.refresh();
                    print(data['choose']);
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          level > 2
                              ? SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          27 *
                                          (level - 2)) //level - 2
                              : SizedBox(),
                          CheckBoxCustom(
                              size: GlobalVariable.ratioWidth(Get.context) * 12,
                              shadowSize:
                                  GlobalVariable.ratioWidth(Get.context) * 18,
                              borderWidth: 1,
                              paddingSize: 0,
                              isWithShadow: false,
                              value: data['choose'],
                              onChanged: (value) {
                                data['choose'] = !data['choose'];

                                ruleCentangan(
                                  data['ID'],
                                  level,
                                  data['choose'],
                                  data['jenis'],
                                );
                                listHakAkses.refresh();
                                // data.refresh();
                              }),
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          3),
                                  child: SubstringHighlight(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      text: data['title_menu_id'],
                                      term: searchController.value.text,
                                      textStyle: TextStyle(
                                        fontFamily: 'AvenirNext',
                                        color: Colors.black,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textStyleHighlight: TextStyle(
                                          fontFamily: 'AvenirNext',
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)))),
                        ],
                      ))),
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data['subdata'].length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (dataAccess['subdata'][index]['access']) {
                          return detailWidget(
                              (level + 1),
                              data['subdata'][index],
                              index,
                              (data['subdata'].length - 1),
                              dataAccess['subdata'][index]);
                        } else {
                          return Container();
                        }
                      })),
            ]
          : [
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data['subdata'].length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        // if (dataAccess['subdata'][index]['access']) {
                        return detailWidget(
                            (level + 1),
                            data['subdata'][index],
                            index,
                            (data['subdata'].length - 1),
                            dataAccess['subdata'][index]);
                        // } else {
                        //   return Container();
                        // }
                      })),
            ],
    );
  }

  void checkHakAkses() {
    idListHakAkses.clear();
    var data = listHakAkses;
    for (var x = 0; x < data.length; x++) {
      for (var y = 0; y < data[x]['subdata'].length; y++) {
        for (var z = 0; z < data[x]['subdata'][y]['subdata'].length; z++) {
          for (var a1 = 0;
              a1 < data[x]['subdata'][y]['subdata'][z]['subdata'].length;
              a1++) {
            if (data[x]['subdata'][y]['subdata'][z]['subdata'][a1]['choose'] &&
                data[x]['subdata'][y]['subdata'][z]['subdata'][a1]['jenis'] ==
                    'CHECK') {
              idListHakAkses.add(
                  data[x]['subdata'][y]['subdata'][z]['subdata'][a1]['ID']);
            }
          }
          if (data[x]['subdata'][y]['subdata'][z]['choose'] &&
              data[x]['subdata'][y]['subdata'][z]['jenis'] == 'CHECK') {
            idListHakAkses.add(data[x]['subdata'][y]['subdata'][z]['ID']);
          }
        }

        if (data[x]['subdata'][y]['choose'] &&
            data[x]['subdata'][y]['jenis'] == 'CHECK') {
          idListHakAkses.add(data[x]['subdata'][y]['ID']);
        }
      }

      if (data[x]['choose'] && data[x]['jenis'] == 'CHECK') {
        idListHakAkses.add(data[x]['ID']);
      }
    }

    //JIKA ANAKNYA DICEK SEMUA MAKA
    print('AKSES : ' + idListHakAkses.toString());
    listHakAkses.refresh();
  }

  void bukaSemua() {
    tampilkanSemua.value = !tampilkanSemua.value;

    for (var x = 0; x < listHakAkses.length; x++) {
      listHakAkses[x]['tutup'] = !tampilkanSemua.value;
    }
    listHakAkses.refresh();
    bukaSemuaFromChildren();
  }

  void bukaSemuaFromChildren() {
    idListTerbuka.clear();
    int jmlTerbuka = 0;
    for (var x = 0; x < listHakAkses.length; x++) {
      if (!listHakAkses[x]['tutup']) {
        jmlTerbuka++;
        idListTerbuka.add(listHakAkses[x]['ID']);
      }
    }

    if (listHakAkses.length == jmlTerbuka) {
      tampilkanSemua.value = true;
    } else {
      tampilkanSemua.value = false;
    }

    listHakAkses.refresh();

    print('TERBUKA : ' + idListTerbuka.toString());
  }

  void ruleCentangan(ID, level, check, jenis) {
    var data = listHakAkses;
    if (jenis == 'CHECKALL' && level == 2) {
      for (var x = 0; x < data.length; x++) {
        if (data[x]['ID'] == ID) {
          for (var y = 0; y < data[x]['subdata'].length; y++) {
            for (var z = 0; z < data[x]['subdata'][y]['subdata'].length; z++) {
              for (var a1 = 0;
                  a1 < data[x]['subdata'][y]['subdata'][z]['subdata'].length;
                  a1++) {
                data[x]['subdata'][y]['subdata'][z]['subdata'][a1]['choose'] =
                    check;
              }
              data[x]['subdata'][y]['subdata'][z]['choose'] = check;
            }
            data[x]['subdata'][y]['choose'] = check;
          }
          data[x]['choose'] = check;
        }
      }
    } else {
      if (check) {
        if (level == 3) {
          for (var x = 0; x < data.length; x++) {
            for (var y = 0; y < data[x]['subdata'].length; y++) {
              for (var z = 0;
                  z < data[x]['subdata'][y]['subdata'].length;
                  z++) {
                if (data[x]['subdata'][y]['subdata'][z]['ID'] == ID) {
                  data[x]['subdata'][y]['choose'] = check;

                  // for (var a1 = 0;
                  //     a1 <
                  //         data[x]['subdata'][y]['subdata'][z]['subdata'].length;
                  //     a1++) {
                  //   data[x]['subdata'][y]['subdata'][z]['subdata'][a1]
                  //       ['choose'] = check;
                  // }
                }
              }
            }
          }
        }
        //MAKA ANAK2xNYA TERCENTANG, DAN PARENTNYA IKUT TERCENTANG
        else if (level == 4) {
          for (var x = 0; x < data.length; x++) {
            for (var y = 0; y < data[x]['subdata'].length; y++) {
              for (var z = 0;
                  z < data[x]['subdata'][y]['subdata'].length;
                  z++) {
                for (var a1 = 0;
                    a1 < data[x]['subdata'][y]['subdata'][z]['subdata'].length;
                    a1++) {
                  if (data[x]['subdata'][y]['subdata'][z]['subdata'][a1]
                          ['ID'] ==
                      ID) {
                    data[x]['subdata'][y]['subdata'][z]['choose'] = check;
                    data[x]['subdata'][y]['choose'] = check;
                  }
                }
              }
            }
          }
        }
      } else {
        if (level == 2) {
          for (var x = 0; x < data.length; x++) {
            for (var y = 0; y < data[x]['subdata'].length; y++) {
              if (data[x]['subdata'][y]['ID'] == ID) {
                for (var z = 0;
                    z < data[x]['subdata'][y]['subdata'].length;
                    z++) {
                  data[x]['subdata'][y]['subdata'][z]['choose'] = check;
                  for (var a1 = 0;
                      a1 <
                          data[x]['subdata'][y]['subdata'][z]['subdata'].length;
                      a1++) {
                    data[x]['subdata'][y]['subdata'][z]['subdata'][a1]
                        ['choose'] = check;
                  }
                }
              }
            }
          }
        } else if (level == 3) {
          for (var x = 0; x < data.length; x++) {
            for (var y = 0; y < data[x]['subdata'].length; y++) {
              for (var z = 0;
                  z < data[x]['subdata'][y]['subdata'].length;
                  z++) {
                if (data[x]['subdata'][y]['subdata'][z]['ID'] == ID) {
                  for (var a1 = 0;
                      a1 <
                          data[x]['subdata'][y]['subdata'][z]['subdata'].length;
                      a1++) {
                    data[x]['subdata'][y]['subdata'][z]['subdata'][a1]
                        ['choose'] = check;
                  }
                }
              }
            }
          }
        }
      }

      //CHECK UNTUK HEADER
      for (var x = 0; x < data.length; x++) {
        var adamenutercentang = false;
        for (var y = 0; y < data[x]['subdata'].length; y++) {
          for (var z = 0; z < data[x]['subdata'][y]['subdata'].length; z++) {
            for (var a1 = 0;
                a1 < data[x]['subdata'][y]['subdata'][z]['subdata'].length;
                a1++) {
              if (data[x]['subdata'][y]['subdata'][z]['subdata'][a1]
                  ['choose']) {
                adamenutercentang = true;
              }
            }

            if (data[x]['subdata'][y]['subdata'][z]['choose']) {
              adamenutercentang = true;
            }
          }
          if (data[x]['subdata'][y]['choose']) {
            adamenutercentang = true;
          }
        }
        data[x]['choose'] = adamenutercentang;
      }
    }

    //JIKA ANAKNYA DICEK SEMUA MAKA
    if (jenis == 'CHECK') {
      checkAllFromChildren();
    }
    //JIKA ANAKNYA DICEK SEMUA MAKA

    checkHakAkses();
  }

  void checkAllFromChildren() {
    var data = listHakAkses;
    for (var x = 0; x < data.length; x++) {
      var checkAll = true;
      int jmlcheckLv2 = 0;
      for (var y = 0; y < data[x]['subdata'].length; y++) {
        int jmlcheckLv3 = 0;
        for (var z = 0; z < data[x]['subdata'][y]['subdata'].length; z++) {
          int jmlcheckLv4 = 0;
          for (var a1 = 0;
              a1 < data[x]['subdata'][y]['subdata'][z]['subdata'].length;
              a1++) {
            if (data[x]['subdata'][y]['subdata'][z]['subdata'][a1]['choose'] &&
                data[x]['subdata'][y]['subdata'][z]['subdata'][a1]['jenis'] ==
                    'CHECK') {
              jmlcheckLv4++;
            }
          }

          if (jmlcheckLv4 ==
                  data[x]['subdata'][y]['subdata'][z]['subdata']
                      .where((element) => element['jenis'] == 'CHECK')
                      .toList()
                      .length &&
              checkAll) {
            checkAll = true;
          } else {
            checkAll = false;
          }

          if (data[x]['subdata'][y]['subdata'][z]['choose'] &&
              data[x]['subdata'][y]['subdata'][z]['jenis'] == 'CHECK') {
            jmlcheckLv3++;
          }
        }

        if (jmlcheckLv3 ==
                data[x]['subdata'][y]['subdata']
                    .where((element) => element['jenis'] == 'CHECK')
                    .toList()
                    .length &&
            checkAll) {
          checkAll = true;
        } else {
          checkAll = false;
        }

        if (data[x]['subdata'][y]['choose'] &&
            data[x]['subdata'][y]['jenis'] == 'CHECK') {
          jmlcheckLv2++;
        }
      }

      if (jmlcheckLv2 ==
              data[x]['subdata']
                  .where((element) => element['jenis'] == 'CHECK')
                  .toList()
                  .length &&
          checkAll) {
        checkAll = true;
      } else {
        checkAll = false;
      }

      if (data[x]['subdata'].length > 0) {
        if (data[x]['subdata'][0]['jenis'] == 'CHECKALL') {
          data[x]['subdata'][0]['choose'] = checkAll;
        }
      }
    }
  }

  void onSave() async {
    validasiSimpan = true;
    if (idListHakAkses.length == 0) {
      validasiSimpan = false;
      showDialog(
          context: Get.context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 32,
                    right: GlobalVariable.ratioWidth(Get.context) * 32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10)),
                child: Container(
                    child: Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                            child: Stack(
                          children: [
                            Positioned(
                                child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    bottom:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                  ),
                                  child: CustomText(
                                      "ManajemenRoleTambahRoleWajibMemilihHakAkses"
                                          .tr, //Maaf, untuk menambahkan role Anda
                                      fontSize: 14,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2,
                                      color: Color(ListColor
                                          .colorLabelBelumDitentukanPemenang))),
                            )),
                            Positioned(
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          right: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                              child: GestureDetector(
                                                  child: SvgPicture.asset(
                                            'assets/ic_close_blue.svg',
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            color: Color(ListColor.color4),
                                          ))),
                                        ))))
                          ],
                        )))));
          });
    }

    if (validasiSimpan) {
      cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Role",
          denganLoading: true);
      if (SharedPreferencesHelper.cekAkses(cekTambah)) {
        error = "";
        showDialog(
            context: Get.context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
            });

        var params = {
          "name": namarole,
          "deskripsi": deskripsirole,
          "SuperMenu": idmenu,
          "role_profile": GlobalVariable.role,
          "MenuMuat": idListHakAkses,
        };

        var result;
        if (mode == 'TAMBAH') {
          result = await ApiHelper(
                  context: Get.context,
                  isShowDialogLoading: false,
                  isShowDialogError: false)
              .simpanManajemenRole(jsonEncode(params));

          if (result['Message']['Code'].toString() == '200') {
            print('MASUK');
            var name = result['Data']['Data']['name'];
            Get.back();
            Get.back();
            Get.back(result: ["TERSIMPAN"]);
            CustomToast.show(
                context: Get.context,
                message: "ManajemenRoleTambahRoleRole" // Role
                        .tr +
                    " " +
                    name +
                    " " +
                    "ManajemenRoleTambahRoleBerhasilDitambahkan"
                        .tr); // Berhasil mengirim response
          } else {
            if (result['Data']['Message'] != "") {
              error = "ManajemenRoleTambahRoleNamaRoleTelahDigunakan".tr;
            }
            Get.back();
            Get.back(result: [error, idListHakAkses]);
          }
        } else if (mode == 'UBAH' || mode == 'UBAH_DETAIL') {
          params['id'] = idrole;
          result = await ApiHelper(
                  context: Get.context,
                  isShowDialogLoading: false,
                  isShowDialogError: false)
              .simpanManajemenRole(jsonEncode(params));
          if (result['Message']['Code'].toString() == '200') {
            print('MASUK');
            var name = result['Data']['Data']['name'];
            Get.back();
            Get.back();
            Get.back(result: ["TERSIMPAN"]);
            if (mode == 'UBAH') {
              CustomToast.show(
                  context: Get.context,
                  message: "ManajemenRoleEditRoleRole" // Role
                          .tr +
                      " " +
                      name +
                      " " +
                      "ManajemenRoleEditRoleBerhasilDiedit"
                          .tr); // Berhasil diedit
            } else if (mode == 'UBAH_DETAIL') {
              CustomToast.show(
                  marginBottom: GlobalVariable.ratioWidth(Get.context) * 0,
                  context: Get.context,
                  message: "ManajemenRoleEditRoleRole" // Role
                          .tr +
                      " " +
                      name +
                      " " +
                      "ManajemenRoleEditRoleBerhasilDiedit"
                          .tr); // Berhasil diedit
            }
          } else {
            if (result['Data']['Message'] != "") {
              error = "ManajemenRoleTambahRoleNamaRoleTelahDigunakan".tr;
            }
            Get.back();
            Get.back(result: [error, idListHakAkses]);
          }
        }
      }
    }
  }

  void onSetData(jenis) {
    if (jenis == 'SET') {
      dataSebelumnya =
          (namarole + deskripsirole + idmenu + jsonEncode(idListHakAkses));
    } else if (jenis == 'COMPARE') {
      var dataSekarang =
          (namarole + deskripsirole + idmenu + jsonEncode(idListHakAkses));
      print('POPUP KELUAR');
      print('dataSebelumnya : ' + dataSebelumnya);
      print('dataSekarang : ' + dataSekarang);

      if (dataSekarang.toString() != dataSebelumnya.toString()) {
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
