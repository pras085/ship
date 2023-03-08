import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/contact_partner_info_pra_tender_transporter_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_with_sub_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/search_manajemen_role/search_manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ManajemenRoleController extends GetxController
    with SingleGetTickerProviderMixin {
  var posTab = 0.obs;
  var isLoadingData = true.obs;
  var listRole = [].obs;
  var jumlahDataRole = 0.obs;
  var countDataRole = 1.obs;
  var firstTimeRole = true;

  String tagRole = "0";

  var showFirstTime = true.obs;
  String filePath = "";
  var jenisTab = 'Role'.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN Role
  bool isFilter = false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK

  var sortByRole = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSortByRole = {}; //UNTUK DAPATKAN DATA MAP SORT Role
  var sortTypeRole = ''.obs; //UNTUK URUTAN SORTNYA

  var search = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD

  RefreshController refreshRoleController =
      RefreshController(initialRefresh: false);

  SortingController _sortingRoleController;

  FilterCustomControllerArk _filterRoleCustomController;

  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;
  List<DataListSortingModel> RoleSort = [];
  List<DataListSortingModel> historySort = [];

  var listFilterRole = [].obs;
  var listfiltermenu = <CheckboxWithSubFilterModel>[].obs;

  var cekTambah = false;
  var cekHapus = false;
  var cekAktifNon = false;
  var cekDetail = false;

  @override
  void onInit() async {
    print("reset filter");
    try {
      Get.delete<FilterCustomControllerArk>(tag: "");
    } catch (e) {
      print(e);
    }

    cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Role");
    cekHapus = await SharedPreferencesHelper.getHakAkses("Hapus Role");
    cekAktifNon =
        await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Role");
    cekDetail = await SharedPreferencesHelper.getHakAkses("Lihat Detail Role");

    listfiltermenu.value = await getDataMenuFilter();
    listfiltermenu.refresh();
    RoleSort = [
      DataListSortingModel(
          'ManajemenRoleIndexRole'.tr,
          'name',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'ManajemenRoleIndexMenu'.tr,
          'SuperMenu.ID',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    _sortingRoleController = Get.put(
        SortingController(
            listSort: RoleSort,
            initMap: mapSortByRole,
            onRefreshData: (map) async {
              countDataRole.value = 1;
              print('Role');
              listRole.clear();
              //SET ULANG
              sortByRole.value = "";
              sortTypeRole.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortByRole.value += element;
                if (index < map.keys.length) {
                  sortByRole.value += ",";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortTypeRole.value += element;
                if (index < map.values.length) {
                  sortTypeRole.value += ",";
                }
              });

              mapSortByRole = map;

              print('NEW MAPS');
              print(map);

              isLoadingData.value = true;

              print(isLoadingData);
              print(firstTimeRole);
              await getListRole(1, filter);
            }),
        tag: tagRole);

    await getListRole(1, filter);

    isLoadingData.value = false;

    print(firstTimeRole);
    print(isLoadingData);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void showSortingDialog() async {
    print("MAP SORT Role");
    print(mapSortByRole);

    if (jenisTab.value == "Role") {
      _sortingRoleController.showSort();
      print('Role');
    }
  }

  void _clearSorting() {
    if (jenisTab.value == "Role") {
      _sortingRoleController.clearSorting();
      print('Role');
    }
  }

  void showFilter() async {
    _filterRoleCustomController.updateListFilterModel(
        0,
        WidgetFilterModel(
          label: [
            'ManajemenRoleIndexRole'.tr,
            "ManajemenRoleIndexCariRole".tr,
            "ManajemenRoleIndexCariRole".tr,
          ],
          isIdAsParameter: true,
          typeInFilter: TypeInFilter.MUATAN,
          customValue: listFilterRole.value,
          keyParam: 'RoleID',
        ));
    _filterRoleCustomController.showFilter();
  }

  void reset() async {
    _resetSearchSortingFilter();
  }

  void refreshAll() async {
    listRole.clear();
    isLoadingData.value = true;
    countDataRole.value = 1;
    await getListRole(1, filter);
  }

  void goToSearchPage() async {
    var sortBy = "";
    var sortType = "";
    var mapSort = {};
    var sortList = [];

    var data = await GetToPage.toNamed<SearchManajemenRoleController>(
        Routes.SEARCH_MANAJEMEN_ROLE,
        arguments: []);

    if (data != null) {
      isLoadingData.value = true;
      listRole.clear();
      listRole.refresh();
      await getListRole(1, filter);
    }
  }

  Future getDataRoleFilter() async {
    List<dynamic> resultrole = [];
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDataRoleUserRole();

    if (result['Message']['Code'] == 200) {
      var data = result["Data"];
      for (var i = 0; i < data.length; i++) {
        resultrole.add({
          "id": data[i]['ID'],
          "nama": data[i]['name'],
        });
      }
    }
    return resultrole;
  }

  Future getDataMenuFilter() async {
    List<CheckboxWithSubFilterModel> resultMenu = [];
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDataMenuUserRole();
    if (result['Message']['Code'] == 200) {
      var data = result["Data"];
      for (var i = 0; i < data.length; i++) {
        var subdata = data[i]['SubMenu'];
        List<dynamic> listsub = [];
        for (var j = 0; j < subdata.length; j++) {
          listsub.add({
            "id": subdata[j]['ID'].toString(),
            "nama": subdata[j]['Menu'],
          });
        }
        resultMenu.add(CheckboxWithSubFilterModel(
          id: data[i]['ID'].toString(),
          value: data[i]['SuperMenu'],
          subdata: listsub,
          canHide: true,
          hideIndex: i * 2 + 2,
        ));
      }
    }
    return resultMenu;
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    search.value = '';

    listRole.clear();
    countDataRole.value = 1;
    filter.clear();
    sortByRole.value = '';
    sortTypeRole.value = 'DESC';

    isLoadingData.value = true;
    await getListRole(1, filter);
  }

  Future getListRole(int page, datafilter) async {
    String ID = "";
    ID = await SharedPreferencesHelper.getUserID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListManajemenRole(
      ID,
      '10',
      (page - 1).toString(),
      sortByRole.value,
      search.value,
      sortTypeRole.value,
      filter,
    );

    print(filter);
    if (result['Message']['Code'].toString() == '200') {
      listFilterRole.value = await getDataRoleFilter();
      listFilterRole.refresh();
      firstTimeRole = false;
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countDataRole.value -= 1;
      }

      (data as List).forEach((element) {
        String listkerja = "";
        String listakses = "";
        for (var x = 0; x < element['subdata'].length; x++) {
          listkerja += element['subdata'][x]['SubMenu'] + ", ";
          for (var y = 0; y < element['subdata'][x]['subdata'].length; y++) {
            listakses += element['subdata'][x]['subdata'][y]['HakAkses'] + ", ";
          }
        }
        if (listkerja.length > 1) {
          listkerja = listkerja.substring(0, listkerja.length - 2);
        }
        if (listakses.length > 1) {
          listakses = listakses.substring(0, listakses.length - 2);
        }

        listRole.add({
          'id': element['ID'].toString(),
          'nama': element['name'],
          'pekerjaan': element['deskripsi'],
          'menu': element['Menu'],
          'status': element['status'],
          'listkerja': listkerja,
          'listakses': listakses,
          'hapus': element['can_delete']
        });
      });
      jumlahDataRole.value = result['SupportingData']['RealCountData'];

      Map<String, dynamic> _mapFilter = {};
      // var listfiltermenu = [
      //   CheckboxWithSubFilterModel(
      //     id: "bigfleetsShipper",
      //     value: "Big Fleets - Shipper",
      //     canHide: true,
      //     hideIndex: 2,
      //     subdata: [
      //       {
      //         "id": "infopratender1",
      //         "nama": "Info Pra Tender 1",
      //       },
      //       {
      //         "id": "infopratender2",
      //         "nama": "Info Pra Tender2",
      //       },
      //       {
      //         "id": "infopratender3",
      //         "nama": "Info Pra Tender3",
      //       },
      //     ],
      //   ),
      // ];

      List<WidgetFilterModel> listWidgetFilter = [
        WidgetFilterModel(
          label: [
            'ManajemenRoleIndexRole'.tr,
            "ManajemenRoleIndexCariRole".tr,
            "ManajemenRoleIndexCariRole".tr,
          ],
          typeInFilter: TypeInFilter.MUATAN,
          customValue: listFilterRole.value,
          isIdAsParameter: true,
          keyParam: 'RoleID',
        ),
      ];

      if (listfiltermenu.value.length <= 0) {
        listWidgetFilter.add(WidgetFilterModel(
          label: ["ManajemenRoleIndexMenu".tr],
          typeInFilter: TypeInFilter.CHECKBOX_WITH_HIDE,
          customValue: [],
          keyParam: "SuperMenuID",
          hideTitle: false,
          hideLine: false,
        ));
      }

      for (int i = 0; i < listfiltermenu.value.length; i++) {
        listWidgetFilter.add(WidgetFilterModel(
          label: ["ManajemenRoleIndexMenu".tr],
          typeInFilter: TypeInFilter.CHECKBOX_WITH_HIDE,
          customValue: [listfiltermenu.value[i]],
          keyParam: "SuperMenuID",
          hideTitle: i == 0 ? false : true,
          hideLine: i == 0 ? false : true,
        ));
        listWidgetFilter.add(WidgetFilterModel(
          label: [
            "ManajemenRoleIndexSubMenu".tr,
            "ManajemenRoleIndexCariSubMenu".tr,
            "ManajemenRoleIndexCariSubMenu".tr,
          ],
          typeInFilter: TypeInFilter.MUATAN,
          customValue: listfiltermenu.value[i].subdata,
          canBeHide: true,
          isIdAsParameter: true,
          numberHideFilter: listfiltermenu.value[i].hideIndex - 1,
          keyParam: "data_" + i.toString(),
          hideLine: true,
          hideTitle: true,
          paddingLeft: GlobalVariable.ratioWidth(Get.context) * 33,
          heightPaddingBottom: 0,
          heightPaddingBottomWhenHidden: 14,
        ));
      }

      _filterRoleCustomController = Get.put(
          FilterCustomControllerArk(
            returnData: (data) async {
              print(data);
              var datasubmenu = [];
              for (int i = 0; i < listfiltermenu.value.length; i++) {
                datasubmenu.addAll(data['data_' + i.toString()]);
              }
              Map<String, dynamic> dataresult = {
                "RoleID": data['RoleID'],
                "SuperMenuID": data['SuperMenuID'],
                "MenuMuatID": datasubmenu
              };
              _mapFilter.clear();
              _mapFilter.addAll(dataresult);

              isLoadingData.value = true;
              // print(dataval);
              isFilter = false;
              for (int i = 0; i < data.values.length; i++) {
                if (data.values.elementAt(i).length > 0) {
                  isFilter = true;
                }
              }

              var urutan = 0;
              filter.value = dataresult;
              filter.refresh();
              listRole.clear();
              await getListRole(1, dataresult);
            },
            listWidgetInFilter: listWidgetFilter,
          ),
          tag: "");

      refreshRoleController.loadComplete();
    }

    listRole.refresh();
    isLoadingData.value = false;
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10),
        height: 0,
      ),
    );
  }

  void hapusRole(String id, String nama, int index, bool hapus) async {
    if (hapus) {
      GlobalAlertDialog.showAlertDialogCustom(
        title: "ManajemenRoleIndexKonfirmasiHapus".tr, // Konfirmasi Hapus
        customMessage: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ManajemenRoleIndexApakahAndaYakinMenghapusRole".tr +
                    ' ', //Apakah Anda yakin ingin menghapus
                style: TextStyle(
                  fontFamily: "AvenirNext",
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                ),
                children: [
                  TextSpan(
                      text: nama,
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w700,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: []),
                  TextSpan(
                      text: " ?",
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: [])
                ])),
        context: Get.context,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          showDialog(
              context: Get.context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              });
          var result = await ApiHelper(
                  context: Get.context,
                  isShowDialogLoading: false,
                  isShowDialogError: false)
              .hapusRole(id);

          if (result['Message']['Code'].toString() == '200') {
            Get.back();
            listRole.removeAt(index);
            listRole.refresh();
            jumlahDataRole.value = jumlahDataRole.value - 1;
            CustomToast.show(
                context: Get.context,
                message:
                    'ManajemenRoleIndexBerhasilMenghapusRole'.tr + " " + nama);
          }
        },
      );
    } else {
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
                    padding: EdgeInsets.only(
                        bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                    child: Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                            child: Stack(children: [
                          Positioned(
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20,
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            right: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                          ),
                                          child: CustomText(
                                              "ManajemenRoleIndexRoleTidakDapatDihapus"
                                                  .tr, //Role ini tidak dapat digunakan
                                              fontSize: 14,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w500,
                                              height: 1.8,
                                              color: Colors.black)),
                                    ],
                                  ))),
                          Positioned(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
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
                                                  24,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              color: Color(ListColor.color4),
                                            ))),
                                          ))
                                    ],
                                  ))),
                        ])))));
          });
    }
  }

  void aktifNonRole(String id, String nama, int index, bool value) async {
    if (value) {
      GlobalAlertDialog.showAlertDialogCustom(
        title: "ManajemenRoleIndexKonfirmasiAktifkan".tr, // Konfirmasi Aktifkan
        customMessage: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ManajemenRoleIndexApakahAndaYakinMengaktifkanRole".tr +
                    ' ', //Apakah Anda yakin ingin mengaktifkan
                style: TextStyle(
                  fontFamily: "AvenirNext",
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                ),
                children: [
                  TextSpan(
                      text: nama,
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w700,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: []),
                  TextSpan(
                      text: " ?",
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: [])
                ])),
        context: Get.context,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          showDialog(
              context: Get.context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              });
          var result = await ApiHelper(
                  context: Get.context,
                  isShowDialogLoading: false,
                  isShowDialogError: false)
              .aktifNonRole(id, "1");

          if (result['Message']['Code'].toString() == '200') {
            Get.back();
            listRole[index]['status'] = 1;
            listRole.refresh();
            CustomToast.show(
                context: Get.context,
                message: 'ManajemenRoleIndexBerhasilMengaktifkanRole'.tr +
                    " " +
                    nama);
          }
        },
      );
    } else {
      GlobalAlertDialog.showAlertDialogCustom(
        title: "ManajemenRoleIndexKonfirmasiNonaktifkan"
            .tr, // Konfirmasi No Aktifkan
        customMessage: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ManajemenRoleIndexApakahAndaYakinMenonaktifkanRole".tr +
                    ' ', //Apakah Anda yakin ingin menonaktifkan
                style: TextStyle(
                  fontFamily: "AvenirNext",
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                ),
                children: [
                  TextSpan(
                      text: nama,
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w700,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: []),
                  TextSpan(
                      text: " ?",
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: [])
                ])),
        context: Get.context,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          showDialog(
              context: Get.context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              });
          var result = await ApiHelper(
                  context: Get.context,
                  isShowDialogLoading: false,
                  isShowDialogError: false)
              .aktifNonRole(id, "0");

          if (result['Message']['Code'].toString() == '200') {
            Get.back();
            listRole[index]['status'] = 0;
            listRole.refresh();
            CustomToast.show(
                context: Get.context,
                message: 'ManajemenRoleIndexBerhasilMenonaktifkanRole'.tr +
                    " " +
                    nama);
          } else if (result['Message']['Code'].toString() == '500' &&
              result['Data'].toString() != "") {
            Get.back();
            List<String> namauser = [];
            result['Data'].keys.forEach((key) {
              if (key != "Message") {
                namauser.add(result['Data'][key.toString()]['name_sub_user']);
              }
            });

            roleTidakDapatNonAktif(result['Data']['0']['name'], namauser);
          }
        },
      );
    }
  }

  void roleTidakDapatNonAktif(String namarole, List<String> userrole) {
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
                                margin: EdgeInsets.only(
                                    left: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        27,
                                    right: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        27,
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            22,
                                    bottom:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: "Role",
                                        style: TextStyle(
                                          height: 1.4,
                                          fontFamily: "AvenirNext",
                                          color: Color(ListColor.colorBlack),
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  14,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: " " + namarole + " ",
                                              style: TextStyle(
                                                height: 1.4,
                                                fontFamily: "AvenirNext",
                                                color:
                                                    Color(ListColor.colorBlack),
                                                fontWeight: FontWeight.w700,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14,
                                              ),
                                              children: []),
                                          TextSpan(
                                              text:
                                                  "ManajemenRoleIndexRoleTidakDapatDinonaktifkan"
                                                          .tr +
                                                      " ",
                                              style: TextStyle(
                                                height: 1.4,
                                                fontFamily: "AvenirNext",
                                                color:
                                                    Color(ListColor.colorBlack),
                                                fontWeight: FontWeight.w500,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14,
                                              ),
                                              children: []),
                                          for (var x = 0;
                                              x < userrole.length;
                                              x++)
                                            userrole.length == 1
                                                ? TextSpan(
                                                    text: userrole[x],
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontFamily: "AvenirNext",
                                                      color: Color(
                                                          ListColor.colorBlack),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                    ),
                                                    children: [])
                                                : x == userrole.length - 1
                                                    ? TextSpan(
                                                        text:
                                                            "ManajemenRoleIndexDan"
                                                                    .tr +
                                                                " ",
                                                        style: TextStyle(
                                                          height: 1.4,
                                                          fontFamily:
                                                              "AvenirNext",
                                                          color: Color(ListColor
                                                              .colorBlack),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      Get.context) *
                                                              14,
                                                        ),
                                                        children: [
                                                            TextSpan(
                                                                text: (userrole[
                                                                    x]),
                                                                style:
                                                                    TextStyle(
                                                                  height: 1.4,
                                                                  fontFamily:
                                                                      "AvenirNext",
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorBlack),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      GlobalVariable.ratioFontSize(
                                                                              Get.context) *
                                                                          14,
                                                                ),
                                                                children: [])
                                                          ])
                                                    : TextSpan(
                                                        text: (userrole[x] +
                                                            ", "),
                                                        style: TextStyle(
                                                          height: 1.4,
                                                          fontFamily:
                                                              "AvenirNext",
                                                          color: Color(ListColor
                                                              .colorBlack),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      Get.context) *
                                                              14,
                                                        ),
                                                        children: []),
                                          TextSpan(
                                              text: ". " +
                                                  "ManajemenRoleIndexSilahkanMenggantiRole"
                                                      .tr +
                                                  ".",
                                              style: TextStyle(
                                                height: 1.4,
                                                fontFamily: "AvenirNext",
                                                color:
                                                    Color(ListColor.colorBlack),
                                                fontWeight: FontWeight.w500,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14,
                                              ),
                                              children: []),
                                        ]))),
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
                                              24,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          color: Color(ListColor.color4),
                                        ))),
                                      ))))
                        ],
                      )))));
        });
  }
}
