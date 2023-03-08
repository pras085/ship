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
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_ark_contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/list_data_design_type_button_corner_right_enum.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_ark_get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/checkbox_filter_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_list_halaman_peserta/search_list_halaman_peserta_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListHalamanPesertaController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;
  var posTab = 0.obs;
  var isLoadingData = true.obs;
  var listPeserta = [].obs;
  var jumlahData = 0.obs;
  var maxHarga = 0.0.obs;
  var countData = 1.obs;
  var mode = 'TAMBAH';

  String tag = "halaman_peserta";

  String filePath = "";

  var filter = {}.obs; //UNTUK FILTER PENCARIAN AKTIF
  bool isFilter = false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK

  var sortBy = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSort = {}; //UNTUK DAPATKAN DATA MAP SORT AKTIF
  var sortType = ''.obs; //UNTUK URUTAN SORTNYA
  var search = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD
  var listMuatan = [].obs;
  var listDiumumkan = [].obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  SortingController _sortingController;

  FilterCustomControllerArk _filterCustomController;
  CustomARKContactPartnerModalSheetBottomController
      _contactModalBottomSheetController;

  var tglPengumumanPemenangAw = '';
  var tglPengumumanPemenangAk = '';
  var muatan = '';
  var noTender = '';
  var idTender = '';
  var noPraTender = '';
  var judulTender = '';
  var satuanTender = 0;
  var satuanVolume = '';
  var totalKebutuhan = ''; //DIBUAT STRING KARENA BISA KOMA
  var dataRuteTender = [].obs;
  var tipeListPeserta = '';

  var expand = false.obs;

  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;
  List<DataListSortingModel> sort = [];

  var dataMaxJumlahUnitTruck = 0.0.obs;
  var dataMaxJumlahBerat = 0.0.obs;
  var dataMaxJumlahVolume = 0.0.obs;
  var dataMaxJumlah = 0.0.obs;
  var dataMaxKoli = 0.0.obs;
  var masaSeleksi = false;

  var link1 = "".obs;
  var nama_file1 = "".obs;
  var link2 = "".obs;
  var nama_file2 = "".obs;

  var cekPilihPemenang = false;
  var cekLihatPemenang = false;

  @override
  void onInit() async {
    print("reset filter");

    cekPilihPemenang =
        await SharedPreferencesHelper.getHakAkses("Pilih Pemenang");
    cekLihatPemenang =
        await SharedPreferencesHelper.getHakAkses("Lihat Pemenang");

    idTender = Get.arguments[0];
    noTender = Get.arguments[1];
    noPraTender = Get.arguments[2];
    judulTender = Get.arguments[3];
    muatan = Get.arguments[4];
    tglPengumumanPemenangAw = Get.arguments[5];
    tglPengumumanPemenangAk = Get.arguments[6];
    var tglPengumumanPemenangAwRaw = Get.arguments[7];
    var dataRute = Get.arguments[8];
    satuanTender = Get.arguments[9];
    satuanVolume = Get.arguments[10];
    totalKebutuhan = Get.arguments[11].toString();
    var tglSeleksiPemenangAwRaw = Get.arguments[12];
    _contactModalBottomSheetController =
        Get.put(CustomARKContactPartnerModalSheetBottomController());

    print(noPraTender);
    print(muatan);
    print(satuanTender);
    print(satuanVolume);
    print(totalKebutuhan);
    print(tglSeleksiPemenangAwRaw);

    //SET DATA RUTE TENDER, BUANG YANG NILAINYA NOL
    var listTruk = [];
    for (var x = 0; x < dataRute.length; x++) {
      listTruk = [];
      for (var y = 0; y < dataRute[x]['data'].length; y++) {
        var data_values = {
          'jenis_truk': dataRute[x]['data'][y]['jenis_truk'],
          'nama_truk': dataRute[x]['data'][y]['nama_truk'],
          'jenis_carrier': dataRute[x]['data'][y]['jenis_carrier'],
          'nama_carrier': dataRute[x]['data'][y]['nama_carrier'],
          'nilai': dataRute[x]['data'][y]['nilai'],
          'error': '',
        };
        if (dataRute[x]['data'][y]['nilai'] != 0) {
          listTruk.add(data_values);
        }
      }

      var dataHeader = {
        'pickup': dataRute[x]['pickup'],
        'destinasi': dataRute[x]['destinasi'],
        'data': listTruk,
      };

      dataRuteTender.add(dataHeader);
    }

    print(dataRuteTender);

    if (tglPengumumanPemenangAwRaw.compareTo(
            await GlobalVariable.getDateTimeFromServer(Get.context)) <=
        0) {
      tipeListPeserta = "SEKARANG";
    } else if (tglPengumumanPemenangAwRaw.compareTo(
            await GlobalVariable.getDateTimeFromServer(Get.context)) >
        0) {
      tipeListPeserta = "SEBELUM";
    }

    if (tglSeleksiPemenangAwRaw.compareTo(
            await GlobalVariable.getDateTimeFromServer(Get.context)) <=
        0) {
      masaSeleksi = true;
    } else {
      masaSeleksi = false;
    }

    print(tipeListPeserta);

    try {
      Get.delete<FilterCustomControllerArk>(tag: "");
    } catch (e) {
      print(e);
    }

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
              countData.value = 1;
              print('AKTIF');
              listPeserta.clear();
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

              print(isLoadingData);
              await getListPeserta(1, filter);
            }),
        tag: tag);

    await getListPeserta(1, filter);

    isLoadingData.value = false;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void showSortingDialog() async {
    print("MAP SORT AKTIF");
    _sortingController.showSort();
  }

  void _clearSorting() {
    _sortingController.clearSorting();
  }

  void contactPartner(String transporterid) async {
    _contactModalBottomSheetController.showContact(
      transporterID: transporterid,
      contactDataParam: null,
    );
  }

  void showFilter() async {
    _filterCustomController.updateListFilterModel(
      1,
      WidgetFilterModel(
          label: ['ProsesTenderLihatPesertaLabelHarga'.tr],
          typeInFilter: TypeInFilter.UNIT,
          customValue: [0.0, maxHarga.value],
          keyParam: 'harga'),
    );
    _filterCustomController.updateListFilterModel(
      0,
      WidgetFilterModel(
          label: [
            'ProsesTenderLihatPesertaLabelNamaPeserta'.tr,
            "ProsesTenderLihatPesertaLabbelSearchPlaceholderCariNamaPeserta".tr,
            "ProsesTenderLihatPesertaLabelexPTAjinomoto".tr,
          ],
          typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
          customValue: listDiumumkan.value,
          keyParam: 'nama_transporter'),
    );

    _filterCustomController.showFilter();
  }

  void reset() async {
    _resetSearchSortingFilter();
  }

  void refreshAll() async {
    listPeserta.clear();
    isLoadingData.value = true;
    countData.value = 1;
    await getListPeserta(1, filter);
  }

  void goToSearchPage() async {
    var sortBy = "";
    var sortType = "";
    var mapSort = {};
    var sortList = [];

    sortList = sort;

    var data = await GetToPage.toNamed<SearchListHalamanPesertaController>(
        Routes.SEARCH_LIST_HALAMAN_PESERTA,
        arguments: [idTender, satuanTender, satuanVolume, dataRuteTender]);

    if (data != null) {
      isLoadingData.value = true;
      listPeserta.clear();
      listPeserta.refresh();
      await getListPeserta(1, filter);
    }
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    search.value = '';
    listPeserta.clear();
    countData.value = 1;
    filter.clear();
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    await getListPeserta(1, filter);
  }

  Future getListPeserta(int page, datafilter) async {
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
      search.value,
      sortType.value,
      filter,
    );

    print(filter);
    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      maxHarga.value = 0;

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
      jumlahData.value = result['SupportingData']['RealCountData'];
      refreshController.loadComplete();

      Map<String, dynamic> _mapFilter = {};
      maxHarga.value = result['SupportingData']['MaxHarga'].toDouble();

      // listMuatan.value = result['SupportingData']['DataMuatan'];
      // listDiumumkan.value = result['SupportingData']['DataDiumumkan'];
      listDiumumkan.value = result['SupportingData']['Transporter'];
      print("ini list diumumkan");
      print(maxHarga);

      List<WidgetFilterModel> listWidgetFilter = [
        WidgetFilterModel(
            label: [
              'ProsesTenderLihatPesertaLabelNamaPeserta'.tr,
              "ProsesTenderLihatPesertaLabbelSearchPlaceholderCariNamaPeserta"
                  .tr,
              "ProsesTenderLihatPesertaLabelexPTAjinomoto".tr,
            ],
            typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
            customValue: listDiumumkan.value,
            keyParam: 'diumumkankepada'),
        WidgetFilterModel(
            label: ['ProsesTenderLihatPesertaLabelHarga'.tr],
            typeInFilter: TypeInFilter.UNIT,
            customValue: [0.0, maxHarga.value],
            keyParam: 'harga'),
        WidgetFilterModel(
          label: [
            'ProsesTenderLihatPesertaLabelLokasiPeserta'.tr,
            "ProsesTenderLihatPesertaLabelSearchPlaceholderCariLokasiPeserta"
                .tr,
            "ProsesTenderLihatPesertaLabelLokasiPeserta".tr
          ],
          typeInFilter: TypeInFilter.CITY,
          isIdAsParameter: true,
          keyParam: 'nama_kota',
        ),
      ];

      _filterCustomController = Get.put(
          FilterCustomControllerArk(
            returnData: (data) async {
              _mapFilter.clear();
              _mapFilter.addAll(data);

              isLoadingData.value = true;
              // print(dataval);
              isFilter = false;
              // print(data);
              for (int i = 0; i < data.values.length; i++) {
                if (data.values.elementAt(i).length > 0) {
                  isFilter = true;
                }
              }

              var urutan = 0;
              filter.value = data;
              filter.refresh();

              listPeserta.clear();
              listPeserta.refresh();
              countData.value = 1;

              await getListPeserta(1, data);
            },
            listWidgetInFilter: listWidgetFilter,
          ),
          tag: "");
    }
    refreshController.loadComplete();
    listPeserta.refresh();
    await getDetailPemenang();
    isLoadingData.value = false;
  }

  Future getDetailPemenang() async {
    String ID = "";
    ID = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDetailPemenang(
      idTender,
      ID,
    );

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      //CEK SUDAH ADA PEMENANG ATAU BELUM, KALAU BELUM BERARTI PILIH PEENANG
      for (var x = 0; x < data.length; x++) {
        for (var y = 0; y < data[x]['detail'].length; y++) {
          if (data[x]['detail'][y]['tanpa_pemenang'] != 0 ||
              data[x]['detail'][y]['detail'].length != 0) {
            mode = "UBAH";
          }
        }
      }
      print(mode);
    }
  }

  void opsi(idtransporter) {
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
                  lineDividerWidget(),
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

  void lihatprofil(String idtransporter) async {
    var data = await GetToPage.toNamed<TransporterController>(
        Routes.TRANSPORTER,
        arguments: [idtransporter]);
  }

  void hubungi(String idtransporter) {
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
      print(link1.value.toString());
      print(link2.value.toString());
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
                    borderRadius: BorderRadius.all(Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 12)),
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
                              topLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                              bottomLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 12)),
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
                    borderRadius: BorderRadius.all(Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 12)),
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
                              topLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                              bottomLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 12)),
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
