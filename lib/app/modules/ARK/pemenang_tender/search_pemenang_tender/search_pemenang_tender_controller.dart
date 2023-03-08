import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/history_search_model.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta/list_halaman_peserta_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_pemenang/list_halaman_peserta_detail_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_pilih_pemenang/list_halaman_peserta_pilih_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchPemenangTenderController extends GetxController {
  var jenisTab = "".obs;
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listPemenangTender = [].obs;
  var searchOn = false.obs;
  var listHistorySearch = [].obs;
  final isShowClearSearch = false.obs;
  var lastShow = true.obs;
  var isLoadingLast = false.obs;

  var countData = 1.obs;
  var countSearch = 1.obs;
  var jenisTender = null;

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

  var cekPilihPemenang = false;
  var cekLihatPemenang = false;
  var cekUmumkan = false;
  var cekDetail = false;

  @override
  void onInit() async {
    cekPilihPemenang =
        await SharedPreferencesHelper.getHakAkses("Pilih Pemenang");
    cekUmumkan =
        await SharedPreferencesHelper.getHakAkses("Umumkan Lebih Awal");
    cekLihatPemenang =
        await SharedPreferencesHelper.getHakAkses("Lihat Pemenang");
    cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Tender");
    super.onInit();
    jenisTab.value = Get.arguments[0];
    jenisTender = Get.arguments[5];
    // sortBy.value = Get.arguments[1];
    // sortType.value = Get.arguments[2];
    // mapSort = Get.arguments[3];

    if (jenisTab.value == "BelumDiumumkan") {
      sort = [
        DataListSortingModel(
            'PemenangTenderIndexLabelNomor'.tr,
            'kode_td',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelJudul'.tr,
            'judul',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelTanggalAwalSeleksi'.tr,
            'seleksiAwal',
            'InfoPraTenderIndexLabelPalingLama'.tr,
            'InfoPraTenderIndexLabelPalingBaru'.tr,
            ''.obs,
            isTitleASCFirst: false),
        DataListSortingModel(
            'PemenangTenderIndexLabelTanggalAkhirSeleksi'.tr,
            'seleksiAkhir',
            'InfoPraTenderIndexLabelPalingLama'.tr,
            'InfoPraTenderIndexLabelPalingBaru'.tr,
            'InfoPraTenderIndexLabelPalingLama'.tr.obs,
            isTitleASCFirst: false),
        DataListSortingModel(
            'PemenangTenderIndexLabelTanggalAwalPengumuman'.tr,
            'pengumumanAwal',
            'InfoPraTenderIndexLabelPalingLama'.tr,
            'InfoPraTenderIndexLabelPalingBaru'.tr,
            ''.obs,
            isTitleASCFirst: false),
        DataListSortingModel(
            'PemenangTenderIndexLabelTanggalAkhirPengumuman'.tr,
            'pengumumanAkhir',
            'InfoPraTenderIndexLabelPalingLama'.tr,
            'InfoPraTenderIndexLabelPalingBaru'.tr,
            ''.obs,
            isTitleASCFirst: false),
        DataListSortingModel(
            'PemenangTenderIndexLabelLokasiPickUp'.tr,
            'pickup',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelLokasiDestinasi'.tr,
            'destinasi',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelMuatan'.tr,
            'muatan',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelPemenang'.tr,
            'pemenang',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
      ];
    } else {
      sort = [
        DataListSortingModel(
            'PemenangTenderIndexLabelTanggalDiumumkan'.tr,
            'tanggalDiumumkan',
            'InfoPraTenderIndexLabelPalingLama'.tr,
            'InfoPraTenderIndexLabelPalingBaru'.tr,
            ''.obs,
            isTitleASCFirst: false),
        DataListSortingModel(
            'PemenangTenderIndexLabelNomor'.tr,
            'kode_td',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelJudul'.tr,
            'judul',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelTanggalAwalPengumuman'.tr,
            'pengumumanAwal',
            'InfoPraTenderIndexLabelPalingLama'.tr,
            'InfoPraTenderIndexLabelPalingBaru'.tr,
            ''.obs,
            isTitleASCFirst: false),
        DataListSortingModel(
            'PemenangTenderIndexLabelTanggalAkhirPengumuman'.tr,
            'pengumumanAkhir',
            'InfoPraTenderIndexLabelPalingLama'.tr,
            'InfoPraTenderIndexLabelPalingBaru'.tr,
            ''.obs,
            isTitleASCFirst: false),
        DataListSortingModel(
            'PemenangTenderIndexLabelLokasiPickUp'.tr,
            'pickup',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelLokasiDestinasi'.tr,
            'destinasi',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelMuatan'.tr,
            'muatan',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
        DataListSortingModel(
            'PemenangTenderIndexLabelPemenang'.tr,
            'pemenang',
            'LoadRequestInfoSortingLabelAscending'.tr,
            'LoadRequestInfoSortingLabelDescending'.tr,
            ''.obs),
      ];
    }

    _sortingController = Get.put(
        SortingController(
            listSort: sort,
            initMap: mapSort,
            onRefreshData: (map) async {
              listPemenangTender.clear();
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
    listPemenangTender.clear();
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

    var type;
    if (jenisTab.value == "BelumDiumumkan") {
      type = 'PMTDBD';
    } else if (jenisTab.value == "Diumumkan") {
      type = 'PMTDD';
    }

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getLastSearchTransactionTender(ID, type, 'aktif', isShipper);

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
    SharedPreferencesHelper.setHistorySearchPemenangTender(
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
    var type;
    if (jenisTab.value == "BelumDiumumkan") {
      type = 'PMTDBD';
    } else if (jenisTab.value == "Diumumkan") {
      type = 'PMTDD';
    }

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .deleteAllLastSearchTransactionTender(ID, type, 'aktif', isShipper);

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
    listPemenangTender.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    getListTender(1, jenisTab.value);
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    pencarian.value = '';
    listPemenangTender.clear();
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

    if (pageName == 'Belum Diumumkan') {
      LangLink = 'PemenangTenderBelumDiumumkanGrid';
      RealLink = 'PemenangTenderBelumDiumumkanGrid';
    } else {
      LangLink = 'PemenangTenderDiumumkanGrid';
      RealLink = 'PemenangTenderDiumumkanGrid';
      history = '1';
    }

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListPemenangTender(
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
            history,
            jenisBelumDiumumkan: jenisTender == "BERAKHIR"
                ? "0"
                : jenisTender == "3HARI"
                    ? "1"
                    : null);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countData.value -= 1;
      }

      (data as List).forEach((element) {
        listPemenangTender.add({
          'id': element['ID'].toString(),
          'kode': element['Kode'],
          'tanggalDibuatRaw': element['TanggalDibuatRaw'],
          'tanggalDibuat': element['TanggalDibuat'].split(" ")[0] +
              " " +
              element['TanggalDibuat'].split(" ")[1] +
              " " +
              element['TanggalDibuat'].split(" ")[2],
          'jamDibuat': element['TanggalDibuat'].split(" ")[3],
          'tanggalDiputuskanRaw': element['TanggalDiputuskanRaw'] ?? '',
          'tanggalDiputuskan': element['TanggalDiputuskan'] != null
              ? (element['TanggalDiputuskan'].split(" ")[0] +
                  " " +
                  element['TanggalDiputuskan'].split(" ")[1] +
                  " " +
                  element['TanggalDiputuskan'].split(" ")[2])
              : '',
          'jamDiputuskan': element['TanggalDiputuskan'] != null
              ? element['TanggalDiputuskan'].split(" ")[3]
              : '',
          'zonaWaktu': element['ZonaWaktu'],
          'judul': element['Judul'],
          'rute': element['ImplodedRute'],
          'muatan': element['Muatan'],
          'status': element['StatusKey'].toString(),
          'labelPeriode': false,
          'pemenang': element['Pemenang'],
          'periodeSeleksi': element['TahapSeleksi'] ?? "",
          'periodePengumuman': element['TahapPengumuman'] ?? "",
          'sudahAdaPemenang': element['hasWinner'],
          'sisaHari': element['CounterSeleksi'],
        });
      });

      countSearch.value = result['SupportingData']['RealCountData'];
    }
    refreshController.loadComplete();

    getHistorySearch();

    isLoadingData.value = false;
  }

  void opsi(idTender, sudahAdaPemenang) {
    print(sudahAdaPemenang);
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
                          'PemenangTenderIndexLabelJudulPopUpOpsi'
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
                      'PemenangTenderIndexLabelButtonDetail'.tr, //'Detail',
                      'DETAIL',
                      idTender,
                      cekDetail),
                  jenisTab.value == "BelumDiumumkan" && sudahAdaPemenang
                      ? lineDividerWidget()
                      : SizedBox(),
                  jenisTab.value == "BelumDiumumkan" && sudahAdaPemenang
                      ? listTitleWidget(
                          'PemenangTenderIndexLabelOpsiUmumkanLebihAwal'
                              .tr, //'Umumkan Lebih Awal',
                          'UMUMKAN LEBIH AWAL',
                          idTender,
                          cekUmumkan)
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
      String text, String fungsi, String idTender, bool akses) {
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
        if (fungsi == 'DETAIL') detail(idTender);
        if (fungsi == 'UMUMKAN LEBIH AWAL') umumkan(idTender);
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

  void detail(String idTender) async {
    cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekDetail)) {
      var data = await GetToPage.toNamed<DetailProsesTenderController>(
          Routes.DETAIL_PROSES_TENDER,
          arguments: [idTender, jenisTab.value]);

      if (data == null) {
        refreshAll();
      }
    }
  }

  void umumkan(String idTender) async {
    cekUmumkan =
        await SharedPreferencesHelper.getHakAkses("Umumkan Lebih Awal",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekUmumkan)) {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title:
              "PemenangTenderIndexLabelUmumkanPemenang".tr, //Umumkan Pemenang
          message: "PemenangTenderIndexLabelApakahAndaYakinInginMengumumkan"
              .tr, //Apakah anda yakin ingin mengumumkan
          labelButtonPriority1: GlobalAlertDialog.noLabelButton,
          onTapPriority1: () {},
          onTapPriority2: () async {
            showDialog(
                context: Get.context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return WillPopScope(
                      onWillPop: () {},
                      child: Center(child: CircularProgressIndicator()));
                });

            var result = await ApiHelper(
                    context: Get.context,
                    isShowDialogLoading: false,
                    isShowDialogError: false)
                .setUmumkanLebihAwal(idTender);

            if (result['Message']['Code'].toString() == '200') {
              CustomToast.show(
                  context: Get.context,
                  message:
                      "ProsesTenderDetailLabelBerhasilMengumumkanPemenang".tr);
              Get.back();
              refreshAll();
            }
          },
          labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
    }
  }

  Future getDetail(String idTender, String jenis) async {
    if (jenis == 'PILIH') {
      cekPilihPemenang =
          await SharedPreferencesHelper.getHakAkses("Pilih Pemenang",denganLoading:true);
    } else {
      cekLihatPemenang =
          await SharedPreferencesHelper.getHakAkses("Lihat Pemenang",denganLoading:true);
    }
    if ((cekPilihPemenang && jenis == 'PILIH') ||
        (cekLihatPemenang && jenis == 'LIHAT')) {
      showDialog(
          context: Get.context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () {
                  Get.back();
                },
                child: Center(child: CircularProgressIndicator()));
          });
      String id = await SharedPreferencesHelper.getUserShipperID();

      var result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getDetailProsesTender(id, idTender);

      if (result['Message']['Code'].toString() == '200') {
        var data = result['Data'];

        var dataTahapTender = [];
        var dataTrukTender = [];
        var dataRuteTender = [];

        //First page
        print("FIRST PAGE");

        for (var x = 0; x < data['tahap_tender'].length; x++) {
          //0 Karena Info Pra Tender, jadi dikosongi saja
          if (x == 0) {
            //KALAU TIDAK ADA INFO PRA TENDER< TAMBAHKAN
            if (data['tahap_tender'][x]['tahap_tender'] != 1) {
              dataTahapTender.add({
                'tahap_tender': 1,
                'show_first_date': '',
                'show_last_date': '',
                'min_date': '',
                'max_date': '',
              });

              dataTahapTender.add({
                'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
                'show_first_date': DateFormat('dd MMM yyyy')
                    .format(DateTime.parse(
                        data['tahap_tender'][x]['tanggal_dimulai']))
                    .toString(),
                'show_last_date': DateFormat('dd MMM yyyy')
                    .format(DateTime.parse(
                        data['tahap_tender'][x]['tanggal_akhir']))
                    .toString(),
                'min_date':
                    DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai']),
                'max_date':
                    DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']),
              });
            } else {
              //KALAU ADA INFO PRA TENDER
              dataTahapTender.add({
                'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
                'show_first_date': '',
                'show_last_date': '',
                'min_date': '',
                'max_date': '',
              });
            }
          } else {
            dataTahapTender.add({
              'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
              'show_first_date': DateFormat('dd MMM yyyy')
                  .format(DateTime.parse(
                      data['tahap_tender'][x]['tanggal_dimulai']))
                  .toString(),
              'show_last_date': DateFormat('dd MMM yyyy')
                  .format(
                      DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']))
                  .toString(),
              'min_date':
                  DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai']),
              'max_date':
                  DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']),
            });
          }
        }
        print(dataTahapTender);

        print("THIRD PAGE");
        for (var x = 0; x < data['unit_truk'].length; x++) {
          dataTrukTender.add({
            'truck_id': data['unit_truk'][x]['ID'],
            'jenis_truk': data['unit_truk'][x]['jenis_trukID'],
            'jenis_carrier': data['unit_truk'][x]['jenis_carrierID'],
            'nama_truk': data['unit_truk'][x]['jenis_truk_raw'],
            'nama_carrier': data['unit_truk'][x]['jenis_carrier_raw'],
            'deskripsi': (data['unit_truk'][x]['truk_tonase'] ?? "-") +
                " / " +
                (data['unit_truk'][x]['truk_dimensi'] ?? "-") +
                " / " +
                (data['unit_truk'][x]['truk_volume'] ?? "-"),
            'gambar_truk': data['unit_truk'][x]['truk_image'],
            'jumlah_truck': data['unit_truk'][x]['jumlah'],
          });
        }

        //Fourth page

        print("FOURTH PAGE");
        for (var x = 0; x < data['rute'].length; x++) {
          var ListTruk = [];
          if (data['satuan_tender'] == 2) {
            for (var x1 = 0; x1 < dataTrukTender.length; x1++) {
              var dataAda = false;
              ListTruk.add({
                'jenis_truk': dataTrukTender[x1]['jenis_truk'],
                'nama_truk': dataTrukTender[x1]['nama_truk'],
                'jenis_carrier': dataTrukTender[x1]['jenis_carrier'],
                'nama_carrier': dataTrukTender[x1]['nama_carrier'],
                'error': ''
              });

              for (var y = 0; y < data['rute'][x]['child'].length; y++) {
                if (dataTrukTender[x1]['jenis_truk'] ==
                        data['rute'][x]['child'][y]['jenis_truk'] &&
                    dataTrukTender[x1]['jenis_carrier'] ==
                        data['rute'][x]['child'][y]['jenis_carrier']) {
                  dataAda = true;
                  ListTruk[ListTruk.length - 1]['nilai'] =
                      data['rute'][x]['child'][y]['nilai'];
                }
              }

              if (!dataAda) {
                ListTruk[ListTruk.length - 1]['nilai'] = 0;
              }
            }
          } else {
            for (var y = 0; y < data['rute'][x]['child'].length; y++) {
              ListTruk.add({
                'jenis_truk': data['rute'][x]['child'][y]['jenis_truk'],
                'nama_truk': data['rute'][x]['child'][y]['jenis_truk_name'],
                'jenis_carrier': data['rute'][x]['child'][y]['jenis_carrier'],
                'nama_carrier': data['rute'][x]['child'][y]
                    ['jenis_carrier_name'],
                'nilai': data['rute'][x]['child'][y]['nilai'],
                'error': ''
              });
            }
          }

          dataRuteTender.add({
            'pickup': data['rute'][x]['pickup'],
            'destinasi': data['rute'][x]['destinasi'],
            'data': ListTruk
          });
        }
        print(dataRuteTender);
        var jumlahYangDigunakan = 0;

        if (data['satuan_tender'] == 2) {
          for (var x = 0; x < dataRuteTender.length; x++) {
            for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
              jumlahYangDigunakan += dataRuteTender[x]['data'][y]['nilai'];
            }
          }
        } else if (data['satuan_tender'] == 1) {
          for (var x = 0; x < dataRuteTender.length; x++) {
            jumlahYangDigunakan += dataRuteTender[x]['data'][0]['nilai'];
          }
        } else if (data['satuan_tender'] == 3) {
          for (var x = 0; x < dataRuteTender.length; x++) {
            jumlahYangDigunakan += dataRuteTender[x]['data'][0]['nilai'];
          }
        }

        var arrJenisMuatan = [
          "",
          "Padat",
          "Cair",
          "Curah",
        ];
        var arrSatuanVolume = [
          "",
          "m\u00B3",
          "L",
        ];

        var idPraTender = data['info_pratenderID'].toString();
        var kodePraTender = data['kode_pratender'];
        var idTender = data['ID'];
        var kodeTender = data['kode_td'];
        var judulTender = data['judul'];

        var tipeListPeserta;
        if (dataTahapTender[3]['min_date'].compareTo(
                await GlobalVariable.getDateTimeFromServer(Get.context)) <=
            0) {
          tipeListPeserta = "SEKARANG";
        } else if (dataTahapTender[3]['min_date'].compareTo(
                await GlobalVariable.getDateTimeFromServer(Get.context)) >
            0) {
          tipeListPeserta = "SEBELUM";
        }
        print(jenis);
        Get.back();
        if (jenis == 'PILIH') {
          await GetToPage.toNamed<ListHalamanPesertaPilihPemenangController>(
              Routes.LIST_HALAMAN_PESERTA_PILIH_PEMENANG,
              arguments: [
                dataRuteTender,
                data['satuan_tender'],
                arrSatuanVolume[data['satuan_volume']],
                idTender,
                kodeTender,
                judulTender,
                data['nama_muatan'].toString() +
                    " (" +
                    arrJenisMuatan[data['jenis_muatan']].toString() +
                    ") ",
                jumlahYangDigunakan.toString(),
                tipeListPeserta,
                'TAMBAH'
              ]);
        } else if (jenis == 'LIHAT') {
          await GetToPage.toNamed<ListHalamanPesertaDetailPemenangController>(
              Routes.LIST_HALAMAN_PESERTA_DETAIL_PEMENANG,
              arguments: [
                dataRuteTender,
                data['satuan_tender'],
                arrSatuanVolume[data['satuan_volume']],
                idTender,
                kodeTender,
                judulTender,
                data['nama_muatan'].toString() +
                    " (" +
                    arrJenisMuatan[data['jenis_muatan']].toString() +
                    ") ",
                jumlahYangDigunakan.toString(),
                tipeListPeserta,
              ]);
        }
        refreshAll();
      }
    } else if (jenis == 'PILIH') {
      SharedPreferencesHelper.cekAkses(cekPilihPemenang);
    } else if (jenis == 'LIHAT') {
      SharedPreferencesHelper.cekAkses(cekLihatPemenang);
    }
  }
}
