import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_ark_contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchListHalamanPesertaController extends GetxController {
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listPeserta = [].obs;
  var searchOn = false.obs;
  var idTender = "";
  var listHistorySearch = [].obs;
  var lastShow = true.obs;
  var isLoadingLast = false.obs;
  final isShowClearSearch = false.obs;

  var countData = 1.obs;
  var countSearch = 1.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN

  var sortBy = ''.obs; //UNTUK SORT BERDASARKAN APA
  var sortType = ''.obs; //UNTUK URUTAN SORTNYA
  Map<String, dynamic> mapSort = {}; //UNTUK URUTAN SORTNYA
  var pencarian = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD
  var satuanTender = 0;
  var satuanVolume = '';
  var dataRuteTender = [].obs;
  CustomARKContactPartnerModalSheetBottomController
      _contactModalBottomSheetController;

  String sortTag = 'sort';

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  SortingController _sortingController;

  List<DataListSortingModel> sort = [];

  var link1 = "".obs;
  var nama_file1 = "".obs;
  var link2 = "".obs;
  var nama_file2 = "".obs;

  @override
  void onInit() {
    super.onInit();
    idTender = Get.arguments[0];
    satuanTender = Get.arguments[1];
    satuanVolume = Get.arguments[2];
    dataRuteTender = Get.arguments[3];
    _contactModalBottomSheetController =
        Get.put(CustomARKContactPartnerModalSheetBottomController());

    sort = [
      DataListSortingModel(
          'ProsesTenderLihatPesertaLabelNamaTransporter'.tr,
          'nama_transporter',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'ProsesTenderLihatPesertaLabelHargaPenawaran'.tr,
          'penawaran',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'ProsesTenderLihatPesertaLabelLokasi'.tr,
          'nama_kota',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'ProsesTenderLihatPesertaLabelTanggalKirimPenawaran'.tr,
          'Created',
          'ProsesTenderLihatPesertaLabelPalingLama'.tr,
          'ProsesTenderLihatPesertaLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
    ];

    _sortingController = Get.put(
        SortingController(
            listSort: sort,
            initMap: mapSort,
            onRefreshData: (map) async {
              listPeserta.clear();
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
              await getListPeserta(1);
            }),
        tag: sortTag);
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
    listPeserta.clear();
    if (searchController.value.text != "") {
      searchOn.value = true;
    } else {
      searchOn.value = false;
    }
    await getListPeserta(1);
  }

  void contactPartner(String transporterid) async {
    print("transporterid=" + transporterid);
    _contactModalBottomSheetController.showContact(
      transporterID: transporterid,
      contactDataParam: null,
    );
  }

  void getHistorySearch() async {
    var isShipper = "1";
    var ID = await SharedPreferencesHelper.getUserShipperID();

    listHistorySearch.clear();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getLastSearchTransactionTender(ID, 'TDPS', 'aktif', isShipper);

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
        .deleteAllLastSearchTransactionTender(ID, 'TDPS', 'aktif', isShipper);

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
    listPeserta.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    getListPeserta(1);
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    pencarian.value = '';
    listPeserta.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    await getListPeserta(1);
  }

  Future getListPeserta(int page) async {
    String ID = "";
    ID = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListPeserta(
      idTender,
      ID,
      '10',
      page.toString(),
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
        listPeserta.add({
          'id': element['ID'].toString(),
          'tanggalDibuatRaw': element['TanggalRaw'].toString(),
          'tanggalDibuat': element['Tanggal'].split(" ")[0] +
              " " +
              element['Tanggal'].split(" ")[1] +
              " " +
              element['Tanggal'].split(" ")[2],
          'jamDibuat': element['Tanggal'].split(" ")[3],
          'zonaWaktu': element['ZonaWaktu'],
          'transporter': element['NamaPT'],
          'idtransporter': element['TransporterID'].toString(),
          'kota': element['AlamatPT'],
          'hargaPenawaranTerkecil':
              element['HargaPenawaranMin']["hargaRaw"].toString(),
          'hargaPenawaranTerbesar':
              element['HargaPenawaranMax']["hargaRaw"].toString(),
        });
      });

      countSearch.value = result['SupportingData']['RealCountData'];
    }
    refreshController.loadComplete();

    getHistorySearch();

    isLoadingData.value = false;
  }

  void opsi(idtransporter) {
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
                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 11),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 3.0,
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 3),
                        child: CustomText(
                            'ProsesTenderLihatPesertaLabelOpsi'.tr, //'Opsi'.tr,
                            color: Color(ListColor.colorBlue),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 18)
                    ],
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  listTitleWidget(
                      'ProsesTenderLihatPesertaLabelLihatProfil'
                          .tr, //'Lihat Profile',
                      'LIHAT PROFIL',
                      idtransporter),
                  lineDividerWidget(),
                  listTitleWidget(
                      'ProsesTenderLihatPesertaLabelHubungi'.tr, //'Hubungi',
                      'HUBUNGI',
                      idtransporter),
                  listTitleWidget(
                      'ProsesTenderLihatPesertaLabelLihatDokumenPenawaran'
                          .tr, //'Lihat Dokumen Penawaran',
                      'LIHAT DOKUMEN PENAWARAN',
                      idtransporter),
                ],
              ),
            ));
  }

  /*
    String text = nama tile
    String fungsi = nama fungsi
  */
  Widget listTitleWidget(String text, String fungsi, String idtransporter) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(Get.context).size.width -
            GlobalVariable.ratioWidth(Get.context) * 32,
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 12),
        alignment: Alignment.topLeft,
        child: CustomText(text.tr,
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Get.back();
        if (fungsi == 'LIHAT PROFIL') lihatprofil(idtransporter);
        if (fungsi == 'HUBUNGI') hubungi(idtransporter);
        if (fungsi == 'LIHAT DOKUMEN PENAWARAN')
          getPenawaranTransporter(idtransporter);
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

  Future<void> lihatprofil(idtransporter) async {
    var data = await GetToPage.toNamed<TransporterController>(
        Routes.TRANSPORTER,
        arguments: [idtransporter]);
  }

  void hubungi(idtransporter) {
    contactPartner(idtransporter);
  }

  Future getPenawaranTransporter(String idtransporter) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {},
              child: Center(child: CircularProgressIndicator()));
        });
    String ID = "";
    ID = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getPenawaranTransporter(idTender, idtransporter);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      nama_file1.value = data['filename_dok1'];
      nama_file2.value = data['filename_dok2'] ?? "";
      link1.value = data['link_dok1'];
      link2.value = data['link_dok2'];
      Get.back();
      await lihatDokumen();
    }
  }

  void lihatDokumen() async {
    if (nama_file1.value != "" && nama_file2.value != "") {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title: "ProsesTenderLihatPesertaLabelDokumenPenawaran"
              .tr, //Dokumen Penawaran
          isShowButton: false,
          customMessage: Column(children: [
            GestureDetector(
              onTap: () async {
                lihat(link1.value, nama_file1.value);
              },
              child: Container(
                  width: MediaQuery.of(Get.context).size.width,
                  margin: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 4,
                      GlobalVariable.ratioWidth(Get.context) * 4,
                      GlobalVariable.ratioWidth(Get.context) * 4,
                      0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: GlobalVariable.ratioWidth(Get.context) * 1,
                        color: Color(ListColor.colorLightGrey10)),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.1),
                    //     blurRadius: 10,
                    //     spreadRadius: 2,
                    //     offset: Offset(0, 5),
                    //   ),
                    // ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey10)
                              .withOpacity(0.4),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12),
                              bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(Get.context) * 12,
                            GlobalVariable.ratioWidth(Get.context) * 16,
                            GlobalVariable.ratioWidth(Get.context) * 12,
                            GlobalVariable.ratioWidth(Get.context) * 16),
                        child: Image.asset(
                          GlobalVariable.imagePath + "popup_file.png",
                          width: GlobalVariable.ratioWidth(Get.context) * 32,
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(Get.context).size.width -
                              GlobalVariable.ratioWidth(Get.context) * 160,
                          padding: EdgeInsets.fromLTRB(
                              GlobalVariable.ratioWidth(Get.context) * 12,
                              0,
                              GlobalVariable.ratioWidth(Get.context) * 12,
                              0),
                          child: CustomText(
                            nama_file1.value,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            color: Color(ListColor.colorBlue),
                          )), // No. Tender
                    ],
                  )),
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 24,
            ),
            GestureDetector(
              onTap: () async {
                lihat(link2.value, nama_file2.value);
              },
              child: Container(
                  width: MediaQuery.of(Get.context).size.width,
                  margin: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 4,
                      GlobalVariable.ratioWidth(Get.context) * 4,
                      GlobalVariable.ratioWidth(Get.context) * 4,
                      0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: GlobalVariable.ratioWidth(Get.context) * 1,
                        color: Color(ListColor.colorLightGrey10)),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.1),
                    //     blurRadius: 10,
                    //     spreadRadius: 2,
                    //     offset: Offset(0, 5),
                    //   ),
                    // ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey10)
                              .withOpacity(0.4),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12),
                              bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(Get.context) * 12,
                            GlobalVariable.ratioWidth(Get.context) * 16,
                            GlobalVariable.ratioWidth(Get.context) * 12,
                            GlobalVariable.ratioWidth(Get.context) * 16),
                        child: Image.asset(
                          GlobalVariable.imagePath + "popup_file.png",
                          width: GlobalVariable.ratioWidth(Get.context) * 32,
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(Get.context).size.width -
                              GlobalVariable.ratioWidth(Get.context) * 160,
                          padding: EdgeInsets.fromLTRB(
                              GlobalVariable.ratioWidth(Get.context) * 12,
                              0,
                              GlobalVariable.ratioWidth(Get.context) * 12,
                              0),
                          child: CustomText(
                            nama_file2.value,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            color: Color(ListColor.colorBlue),
                          )), // No. Tender
                    ],
                  )),
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 6,
            ),
          ]));
    } else {
      lihat(link1.value, nama_file1.value);
    }
  }

  void lihat(String link, String fileNameDownload) async {
    var savedLocation = await _getLocalPath() + "/" + fileNameDownload;
    var linkFile = link;
    // if (!link.contains(GlobalVariable.urlFile)) {
    //   linkFile = GlobalVariable.urlFile + link;
    // }

    //JIKA SUDAH PERNAH DIDOWNLOAD ARAHKAN KE LOCAL
    if (await File(savedLocation).exists()) {
      linkFile = savedLocation;
    }

    print(linkFile);
    if (linkFile.split(":").first == "https") {
      print('Debug: Opening File Document Via Internet');
      // Get.toNamed(Routes.LIHAT_PDF, arguments: [fileNameDownload, linkFile]);
      if (await canLaunch(linkFile)) {
        await launch(linkFile);
      } else {
        throw "Could not launch $linkFile";
      }
    } else {
      File myFile = File(linkFile);
      if (myFile.existsSync()) {
        print('Debug: Opening File Document');
        var result = await OpenFile.open(linkFile);
      } else {
        print('Debug: Failed Opening File Document');
      }
    }
  }

  Future<String> _getLocalPath() async {
    return (await _findLocalPath()) + Platform.pathSeparator + 'Download';
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0";
    // return ExtStorage.getExternalStorageDirectory();
  }
}
