import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/history_search_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';

class SearchManajemenRoleController extends GetxController {
  var jenisTab = "".obs;
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listRole = [].obs;
  var searchOn = false.obs;
  final isShowClearSearch = false.obs;

  var kondisiAwal = true;

  var countData = 1.obs;
  var countSearch = 1.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN

  var sortBy = ''.obs; //UNTUK SORT BERDASARKAN APA
  var sortType = ''.obs; //UNTUK URUTAN SORTNYA
  Map<String, dynamic> mapSort = {}; //UNTUK URUTAN SORTNYA
  var pencarian = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD

  String sortTag = 'sort';

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  SortingController _sortingController;

  List<DataListSortingModel> sort = [];

  var cekTambah = false;
  var cekHapus = false;
  var cekAktifNon = false;
  var cekDetail = false;

  @override
  void onInit() async {
    super.onInit();

    cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Role");
    cekHapus = await SharedPreferencesHelper.getHakAkses("Hapus Role");
    cekAktifNon =
        await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Role");
    cekDetail = await SharedPreferencesHelper.getHakAkses("Lihat Detail Role");

    sort = [
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

    _sortingController = Get.put(
        SortingController(
            listSort: sort,
            initMap: mapSort,
            onRefreshData: (map) async {
              listRole.clear();
              countData.value = 1;
              //SET ULANG
              sortBy.value = "";
              sortType.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortBy.value += element;
                if (index < map.keys.length) {
                  sortBy.value += ",";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortType.value += element;
                if (index < map.values.length) {
                  sortType.value += ",";
                }
              });

              mapSort = map;
              print('NEW MAPS');
              print(map);
              isLoadingData.value = true;
              await getListRole(1, jenisTab.value);
            }),
        tag: sortTag);

    isLoadingData.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onSearch() async {
    kondisiAwal = true;
    FocusManager.instance.primaryFocus.unfocus();
    countData.value = 1;
    isLoadingData.value = true;
    listRole.clear();
    if (searchController.value.text != "") {
      searchOn.value = true;
    } else {
      searchOn.value = false;
    }
    await getListRole(1, jenisTab.value);
  }

  void onChangeText(String textSearch) {
    isShowClearSearch.value = textSearch != "";
  }

  void onClearSearch() async {
    searchController.value.text = '';
    onChangeText(searchController.value.text);
  }

  void showSortingDialog() {
    FocusManager.instance.primaryFocus.unfocus();
    _sortingController.showSort();
  }

  void _clearSorting() {
    FocusManager.instance.primaryFocus.unfocus();
    _sortingController.clearSorting();
  }

  void reset() async {
    FocusManager.instance.primaryFocus.unfocus();
    _resetSearchSortingFilter();
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    pencarian.value = '';
    listRole.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    await getListRole(1, jenisTab.value);
  }

  Future getListRole(int page, String pageName) async {
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
      sortBy.value,
      searchController.value.text,
      sortType.value,
      filter,
    );

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countData.value -= 1;
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

      countSearch.value = result['SupportingData']['RealCountData'];
    }
    refreshController.loadComplete();

    isLoadingData.value = false;
    kondisiAwal = false;
  }

  void refreshAll() async {
    FocusManager.instance.primaryFocus.unfocus();
    pencarian.value = '';
    listRole.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    getListRole(1, jenisTab.value);
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
            List<String> namauser = [result['Data']['0']['name_sub_user']];
            roleTidakDapatNonAktif(result['Data']['0']['name'], namauser);
          }
        },
      );
    }
  }

  void roleTidakDapatNonAktif(String namarole, userrole) {
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
