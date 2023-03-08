import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/edit_info_pra_tender/edit_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/create_proses_tender/create_proses_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchInfoPraTenderController extends GetxController {
  var jenisTab = "".obs;
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listInfoPraTender = [].obs;
  var searchOn = false.obs;
  var listHistorySearch = [].obs;
  final isShowClearSearch = false.obs;
  var lastShow = true.obs;
  var isLoadingLast = false.obs;

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

  var cekTambahTender = false;
  var cekTambah = false;
  var cekEdit = false;
  var cekDetail = false;

  @override
  void onInit() async {
    cekTambahTender =
        await SharedPreferencesHelper.getHakAkses("Buat Proses Tender");
    cekTambah =
        await SharedPreferencesHelper.getHakAkses("Buat Info Pra Tender");
    cekEdit = await SharedPreferencesHelper.getHakAkses("Edit Info Pra Tender");
    cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Pra Tender");
    super.onInit();
    print(Get.arguments[3]);
    print(Get.arguments[4]);
    jenisTab.value = Get.arguments[0];
    // sortBy.value = Get.arguments[1];
    // sortType.value = Get.arguments[2];
    // mapSort = Get.arguments[3];

    sort = [
      DataListSortingModel(
          'InfoPraTenderIndexLabelNomor'.tr,
          'kode_td',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelTanggalDibuat'.tr,
          'Created',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'InfoPraTenderIndexLabelJudul'.tr,
          'judul',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelLokasiPickUp'.tr,
          'pickup',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelLokasiDestinasi'.tr,
          'destinasi',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelMuatan'.tr,
          'muatan',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    _sortingController = Get.put(
        SortingController(
            listSort: sort,
            initMap: mapSort,
            onRefreshData: (map) async {
              listInfoPraTender.clear();
              countData.value = 1;
              //SET ULANG
              sortBy.value = "";
              sortType.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortBy.value += element;
                if (index < map.keys.length) {
                  sortBy.value += ", ";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortType.value += element;
                if (index < map.values.length) {
                  sortType.value += ", ";
                }
              });

              mapSort = map;
              print('NEW MAPS');
              print(map);
              isLoadingData.value = true;
              await getListTender(1, jenisTab.value);
            }),
        tag: sortTag);

    //getListTender(1, jenisTab.value);
    isLoadingLast.value = true;
    isLoadingData.value = false;
    getHistorySearch();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onSearch() async {
    lastShow.value = false;
    FocusManager.instance.primaryFocus.unfocus();
    countData.value = 1;
    isLoadingData.value = true;
    listInfoPraTender.clear();
    if (searchController.value.text != "") {
      searchOn.value = true;
    } else {
      searchOn.value = false;
    }
    await getListTender(1, jenisTab.value);
  }

  void getHistorySearch() async {
    var isShipper = "1";
    var ID = await SharedPreferencesHelper.getUserShipperID();

    listHistorySearch.clear();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getLastSearchTransactionTender(ID, 'PT', jenisTab.value, isShipper);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (var x = 0; x < data.length; x++) {
        var json = {
          'idsearch': data[x]['ID'].toString(),
          'search': data[x]['search'].toString(),
        };
        listHistorySearch.add(json);
      }
      listHistorySearch.refresh();
    }

    print('GET HISTORY SEARCH');

    print(listHistorySearch);
    isLoadingLast.value = false;
  }

  void chooseHistorySearch(index) async {
    searchController.value.text = listHistorySearch[index]['search'].toString();
    onSearch();
  }

  void hapusHistorySearch(index) async {
    var isShipper = "1";
    var ID = await SharedPreferencesHelper.getUserShipperID();
    var idsearch = listHistorySearch[index]['idsearch'];

    listHistorySearch.removeAt(index);
    //SET PREFERENCES
    SharedPreferencesHelper.setHistorySearchProsesTender(
        jsonEncode(listHistorySearch), jenisTab.value);

    listHistorySearch.refresh();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .deleteLastSearchTransactionTender(idsearch);

    print('HAPUS HISTORY SEARCH');
  }

  void clearHistorySearch() async {
    listHistorySearch.clear();
    listHistorySearch.refresh();

    var isShipper = "1";
    var ID = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .deleteAllLastSearchTransactionTender(
            ID, 'PT', jenisTab.value, isShipper);

    print('CLEAR HISTORY SEARCH');
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

  void refreshAll() async {
    FocusManager.instance.primaryFocus.unfocus();
    pencarian.value = '';
    listInfoPraTender.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    getListTender(1, jenisTab.value);
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    pencarian.value = '';
    listInfoPraTender.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    await getListTender(1, jenisTab.value);
  }

  Future getListTender(int page, String pageName) async {
    String ID = "";
    String isShipper = "";
    isShipper = "1";
    ID = await SharedPreferencesHelper.getUserShipperID();

    String LangLink = '';
    String RealLink = '';
    String history = '0';

    if (pageName == 'Aktif') {
      LangLink = 'InfoPraTenderAktifGrid';
      RealLink = 'infoPraTenderAktifGrid';
    } else {
      LangLink = 'InfoPraTenderHistoryGrid';
      RealLink = 'infoPraTenderHistoryGrid';
      history = '1';
    }

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListInfoPratender(
            ID,
            '10',
            page.toString(),
            sortBy.value,
            searchController.value.text,
            sortType.value,
            filter,
            pageName,
            LangLink,
            RealLink,
            isShipper,
            history);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countData.value -= 1;
      }

      (data as List).forEach((element) {
        listInfoPraTender.add({
          'id': element['ID'].toString(),
          'kode': element['Kode'],
          'tanggalDibuatRaw': element['TanggalDibuatRaw'],
          'tanggalDibuat': element['TanggalDibuat'].split(" ")[0] +
              " " +
              element['TanggalDibuat'].split(" ")[1] +
              " " +
              element['TanggalDibuat'].split(" ")[2],
          'jamDibuat': element['TanggalDibuat'].split(" ")[3],
          'zonaWaktu': element['ZonaWaktu'],
          'judul': element['Judul'],
          'rute': element['ImplodedRute'],
          'muatan': element['Muatan'],
          'transporter': element['AllInvites'],
          'status': element['StatusKey'].toString(),
        });
      });

      countSearch.value = result['SupportingData']['RealCountData'];
    }
    refreshController.loadComplete();

    getHistorySearch();

    isLoadingData.value = false;
  }

  void opsi(idPraTender) {
    FocusManager.instance.primaryFocus.unfocus();
    showModalBottomSheet(
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 3,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 14),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 2.0,
                      color: Color(ListColor.colorLightGrey16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_simple.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                        onTap: () async {
                          Get.back();
                        },
                      ),
                      CustomText(
                          'InfoPraTenderIndexLabelJudulPopUpOpsi'
                              .tr, //'Opsi'.tr,
                          color: Color(ListColor.colorBlue),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 18)
                    ],
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  listTitleWidget(
                      'InfoPraTenderIndexLabelOpsiBuatTender'
                          .tr, //'Buat Tender',
                      'BUAT',
                      idPraTender,
                      cekTambahTender),
                  lineDividerWidget(),
                  listTitleWidget(
                      'InfoPraTenderIndexLabelOpsiSalinTender'.tr, //'Salin',
                      'SALIN',
                      idPraTender,
                      cekTambah),
                  jenisTab.value != "History"
                      ? Column(
                          children: [
                            lineDividerWidget(),
                            listTitleWidget(
                                'InfoPraTenderIndexLabelOpsiEditTender'
                                    .tr, // 'Edit',
                                'EDIT',
                                idPraTender,
                                cekEdit),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ));
  }

  /*
    String text = nama tile
    String fungsi = nama fungsi
  */
  Widget listTitleWidget(
      String text, String fungsi, String idPraTender, bool akses) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(Get.context).size.width -
            GlobalVariable.ratioWidth(Get.context) * 32,
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 12),
        alignment: Alignment.topLeft,
        child: CustomText(text.tr,
            color: akses ? Colors.black : Color(ListColor.colorAksesDisable),
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Get.back();
        FocusManager.instance.primaryFocus.unfocus();
        if (fungsi == 'BUAT') buat(idPraTender);
        if (fungsi == 'SALIN') salin(idPraTender);
        if (fungsi == 'EDIT') edit(idPraTender);
      },
    );
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

  void buat(String idPraTender) async {
    cekTambahTender =
        await SharedPreferencesHelper.getHakAkses("Buat Proses Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekTambahTender)) {
      var data = await GetToPage.toNamed<CreateProsesTenderController>(
        Routes.CREATE_PROSES_TENDER,
      );
      if (data != null) {
        refreshAll();
      }
    }
  }

  void salin(String idPraTender) async {
    cekTambah =
        await SharedPreferencesHelper.getHakAkses("Buat Info Pra Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekTambah)) {
      var data = await GetToPage.toNamed<CreateInfoPraTenderController>(
          Routes.CREATE_INFO_PRA_TENDER,
          arguments: [idPraTender, 0]);
      if (data != null) {
        refreshAll();
      }
    }
  }

  void edit(String idPraTender) async {
    cekEdit = await SharedPreferencesHelper.getHakAkses("Edit Info Pra Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekEdit)) {
      var data = await GetToPage.toNamed<EditInfoPraTenderController>(
          Routes.EDIT_INFO_PRA_TENDER,
          arguments: [idPraTender, 0]);

      if (data != null) {
        refreshAll();
      }
    }
  }
}
