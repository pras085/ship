import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/history_search_model.dart';
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
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchListPilihPemenangController extends GetxController {
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listPeserta = [].obs;
  var searchOn = false.obs;
  final isShowClearSearch = false.obs;
  var idrute = '';

  var alokasiController = TextEditingController();

  var idTender = '';
  var satuanTender = 0;
  var satuanVolume = '';
  var nilaiMuatan = '';
  var sisaMuatan = '';
  var namaTruk = '';
  var lokasi = '';
  var statusErrorAlokasi = "".obs;
  var totalPesertaDipilih = 0.obs;
  var datapemenang = [];
  var status = "";

  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;

  var link1 = "".obs;
  var nama_file1 = "".obs;
  var link2 = "".obs;
  var nama_file2 = "".obs;
  int fileke = 0;

  String filePath1 = "";
  String filePath2 = "";

  var countData = 1.obs;
  var countSearch = 1.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN

  var sortBy = ''.obs; //UNTUK SORT BERDASARKAN APA
  var sortType = ''.obs; //UNTUK URUTAN SORTNYA
  Map<String, dynamic> mapSort = {}; //UNTUK URUTAN SORTNYA
  var pencarian = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD

  String sortTag = 'search_list_pilih_pemenang';

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  SortingController _sortingController;

  List<DataListSortingModel> sort = [];

  @override
  void onInit() {
    super.onInit();

    idTender = Get.arguments[0];
    satuanTender = Get.arguments[1];
    satuanVolume = Get.arguments[2];
    nilaiMuatan = Get.arguments[3].toString();
    lokasi = Get.arguments[4];
    namaTruk = Get.arguments[5];
    datapemenang = Get.arguments[6];
    status = Get.arguments[7];
    idrute = Get.arguments[8];

    sort = [
      DataListSortingModel(
          'ProsesTenderLihatPesertaLabelNamaTransporter'.tr,
          'nama_transporter',
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
          'ProsesTenderLihatPesertaLabelHargaPenawaran'.tr,
          'penawaran',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
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

    getListPeserta(1);

    hitungPemenang();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    //FocusScope.of(Get.context).unfocus();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void shareData(String link, bool usingBaseFileLink) async {
    var namaFile = GlobalVariable.formatNamaFile(link.split("/").last);

    var savedLocation = await _getLocalPath() + "/" + namaFile;
    print(savedLocation);
    var existed = await File(savedLocation).exists();
    print(existed);
    //JIKA SUDAH PERNAH DIDOWNLOAD ARAHKAN KE LOCAL
    if (existed) {
      var status = await Permission.storage.request();
      print(status);
      if (status.isGranted) {
        Share.shareFiles([savedLocation]);
      } else {
        print('Permission Denied!');
      }
    } else {
      //KARENA KETIKA DOWNLOAD, DAN TAP DOWNLOADNYA FALSE, DIA LANGSUNG SHARE
      if (fileke == 1) {
        filePath1 = savedLocation;
      } else if (fileke == 2) {
        filePath2 = savedLocation;
      }
      await download(link, namaFile, usingBaseFileLink);
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

  static void downloadCallBack(id, status, progress) {
    SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, "downloader_send_port");
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen((message) {
      onProgress.value = message[2] / 100;
      print(message[2].toString());
      if (message[2] == 100.0 && onDownloading.value) {
        onDownloading.value = false;
        Get.back();
        print(tapDownload);
        if (tapDownload) {
          CustomToast.show(
              context: Get.context,
              message: "DetailTransporterLabelDownloadComplete".tr);
        } else {
          if (fileke == 1) {
            Share.shareFiles([filePath1]);
          } else if (fileke == 2) {
            Share.shareFiles([filePath2]);
          }
        }
      } else if (message[2] == -1) {
        Get.back();
      }
    });
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping("downloader_send_port");
  }

  Future<void> download(
      String url, String fileNameDownload, bool usingBaseFileLink) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
              child: WillPopScope(
                  onWillPop: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 8))),
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 30),
                      padding: EdgeInsets.all(
                          GlobalVariable.ratioWidth(Get.context) * 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(ListColor.color4)),
                              value: onProgress.value)),
                          Container(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                          Obx(() => RichText(
                              text: TextSpan(
                                  text: "Downloading " +
                                      (onProgress.value * 100)
                                          .toInt()
                                          .toString() +
                                      " %", // Menampilkan hasil untuk
                                  style: TextStyle(
                                    fontFamily: "AvenirNext",
                                    color: Color(ListColor.colorBlack),
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                  ),
                                  children: [])))
                        ],
                      ))));
        });
    var status = await Permission.storage.request();
    String urlFile = "";
    // if (!url.contains(GlobalVariable.urlFile)) {
    //   urlFile = GlobalVariable.urlFile;
    // }
    if (status.isGranted) {
      var savedLocation = await _getLocalPath();
      onDownloading.value = true;
      String downloadId = await FlutterDownloader.enqueue(
          url: urlFile + url,
          // savedDir: externalDir.path,
          savedDir: savedLocation,
          saveInPublicStorage: true,
          showNotification: true,
          fileName: fileNameDownload,
          openFileFromNotification: true);
    } else {
      print('Permission Denied!');
    }
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0";
    // return ExtStorage.getExternalStorageDirectory();
  }

  void onSearch() async {
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
        .fetchPilihPemenang(idrute, ID, '10', page.toString(), sortBy.value,
            searchController.value.text, sortType.value);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countData.value -= 1;
      }

      (data as List).forEach((element) {
        var ada = false;
        for (var x = 0; x < datapemenang.length; x++) {
          if (datapemenang[x]['id'].toString() ==
              ((element['TransporterID'] ?? "") == ""
                  ? '0'
                  : element['TransporterID'].toString())) {
            ada = true;
          }
        }
        if (!ada) {
          listPeserta.add({
            'id': ((element['TransporterID'] ?? "") == ""
                ? '0'
                : element['TransporterID'].toString()),
            'transporter': element['NamaPT'] ?? "",
            'kota': element['AlamatPT'] ?? "",
            'hargaPenawaran': ((element['HargaPenawaranRaw'] ?? "") == ""
                ? '0'
                : element['HargaPenawaranRaw']),
            'alokasi': '',
          });
        }
      });
    }
    refreshController.loadComplete();
    listPeserta.refresh();
    print('ea');
    print(listPeserta);
    isLoadingData.value = false;
  }

  void pilih(index) async {
    //KETIKA UBAH ALOKASI
    alokasiController.text = "";
    statusErrorAlokasi.value = "";
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "ProsesTenderLihatPesertaLabelMasukkanAlokasi"
            .tr, //Masukkan Alokasi
        customMessage: Column(children: [
          Container(
              margin: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 13,
                  right: GlobalVariable.ratioWidth(Get.context) * 13),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 13,
                    ),
                    CustomText(
                        "ProsesTenderLihatPesertaLabelJumlahAlokasi"
                            .tr, //Jumlah Alokasi
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorLightGrey4)),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    CustomTextFormField(
                      context: Get.context,
                      newContentPadding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                        //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                      ),
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
                        DecimalInputFormatter(
                            digit: 13,
                            digitAfterComma: 3,
                            controller: alokasiController)
                      ],
                      textSize: 12,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorLightGrey4),
                      ),
                      newInputDecoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefix: SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12),
                        suffix: SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12),
                        suffixIconConstraints: BoxConstraints(minHeight: 0.0),
                        suffixIcon: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          width: GlobalVariable.ratioWidth(Get.context) * 40,
                          child: CustomText(
                              (satuanTender == 2
                                  ? "Unit"
                                  : (satuanTender == 1
                                      ? "Ton"
                                      : satuanVolume.tr)),
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.right,
                              fontSize: 12),
                        ),
                        isDense: true,
                        isCollapsed: true,
                        hintText: "ProsesTenderLihatPesertaPlaceholderContoh99"
                            .tr, //Ex : 99
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey2),
                        ),
                      ),
                      controller: alokasiController,
                    ),
                    Obx(() => statusErrorAlokasi.value == "1"
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomText(
                                    "ProsesTenderLihatPesertaAlertBelumMenentukanAlokasi"
                                        .tr,
                                    overflow: TextOverflow.ellipsis,
                                    wrapSpace: true,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    height: 1.2,
                                    maxLines: 2,
                                    color: Color(ListColor.colorRed),
                                  )),
                                  SizedBox(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          74)
                                ],
                              ),
                            ],
                          )
                        : statusErrorAlokasi.value == "2"
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          text: TextSpan(
                                              text: "ProsesTenderLihatPesertaAlertAlokasiMelebihiBatasMaksimal"
                                                      .tr +
                                                  " ", //Alokasi melebihi batas maksimal
                                              style: TextStyle(
                                                fontFamily: "AvenirNext",
                                                color:
                                                    Color(ListColor.colorRed),
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    12,
                                                height: 1.2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              children: [
                                                TextSpan(
                                                    text: GlobalVariable
                                                        .formatCurrencyDecimal(
                                                            nilaiMuatan),
                                                    style: TextStyle(
                                                      fontFamily: "AvenirNext",
                                                      color: Color(
                                                          ListColor.colorRed),
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: (satuanTender ==
                                                                  2
                                                              ? " Unit"
                                                              : satuanTender ==
                                                                      1
                                                                  ? " Ton"
                                                                  : " " +
                                                                      satuanVolume
                                                                          .tr),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "AvenirNext",
                                                            color: Color(
                                                                ListColor
                                                                    .colorRed),
                                                            fontSize: GlobalVariable
                                                                    .ratioFontSize(
                                                                        Get.context) *
                                                                12,
                                                            height: 1.2,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          children: [])
                                                    ])
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox()),
                  ]))
        ]),
        labelButtonPriority1: "ProsesTenderEditStatusProsesTenderSimpan".tr,
        isDirectBack: false,
        onTapPriority1: () async {
          await cekAlokasi();
          if (statusErrorAlokasi.value == "") {
            //KETIKA BARU TAMBAH ALOKASI

            var alokasi;
            if (satuanTender == 2) {
              alokasi = int.parse(alokasiController.text == ""
                  ? "0"
                  : GlobalVariable.formatDoubleDecimal(alokasiController.text));
            } else if (satuanTender == 1) {
              alokasi = double.parse(alokasiController.text == ""
                  ? "0.0"
                  : GlobalVariable.formatDoubleDecimal(alokasiController.text));
            } else if (satuanTender == 3) {
              alokasi = double.parse(alokasiController.text == ""
                  ? "0.0"
                  : GlobalVariable.formatDoubleDecimal(alokasiController.text));
            }

            datapemenang.add({
              "id": listPeserta[index]['id'],
              "alokasi": alokasi.toString(),
              "transporter": listPeserta[index]['transporter'],
              "kota": listPeserta[index]['kota'],
              "hargaPenawaran": listPeserta[index]['hargaPenawaran'],
            });

            await hitungPemenang();
            listPeserta.removeAt(index);
            listPeserta.refresh();
            Get.back();
          }
        });
  }

  Future getPenawaranTransporter(int index) async {
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
        .getPenawaranTransporter(idTender, listPeserta[index]['id']);

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

  void hitungPemenang() {
    totalPesertaDipilih.value = datapemenang.length;
    sisaMuatan = "0";
    var alokasi;

    if (satuanTender == 2) {
      alokasi = 0;
      for (var x = 0; x < datapemenang.length; x++) {
        alokasi += int.parse(datapemenang[x]['alokasi'].toString());
      }
      sisaMuatan = (int.parse(nilaiMuatan) - alokasi).toString();
    } else if (satuanTender == 1) {
      alokasi = 0.0;
      for (var x = 0; x < datapemenang.length; x++) {
        alokasi += double.parse(datapemenang[x]['alokasi'].toString());
      }
      sisaMuatan = (double.parse(nilaiMuatan) - alokasi).toString();
    } else if (satuanTender == 3) {
      alokasi = 0.0;
      for (var x = 0; x < datapemenang.length; x++) {
        alokasi += double.parse(datapemenang[x]['alokasi'].toString());
      }
      sisaMuatan = (double.parse(nilaiMuatan) - alokasi).toString();
    }
    print('PEMENANG');
    print(datapemenang);
  }

  void cekAlokasi() {
    var sisa;
    if (alokasiController.text == "") {
      statusErrorAlokasi.value = "1"; //Belum menentukan alokasi
    } else if (satuanTender == 2) {
      var alokasi = int.parse(alokasiController.text == ""
          ? "0"
          : GlobalVariable.formatDoubleDecimal(alokasiController.text));
      sisa = int.parse(nilaiMuatan);
      for (var x = 0; x < datapemenang.length; x++) {
        sisa -= int.parse(datapemenang[x]['alokasi'].toString());
      }
      print(nilaiMuatan);
      print(alokasi);

      sisa -= alokasi;
    } else if (satuanTender == 1) {
      var alokasi = double.parse(alokasiController.text == ""
          ? "0.0"
          : GlobalVariable.formatDoubleDecimal(alokasiController.text));
      sisa = double.parse(nilaiMuatan);
      for (var x = 0; x < datapemenang.length; x++) {
        sisa -= double.parse(datapemenang[x]['alokasi'].toString());
      }
      sisa -= alokasi;
    } else if (satuanTender == 3) {
      var alokasi = double.parse(alokasiController.text == ""
          ? "0.0"
          : GlobalVariable.formatDoubleDecimal(alokasiController.text));
      sisa = double.parse(nilaiMuatan);
      for (var x = 0; x < datapemenang.length; x++) {
        sisa -= double.parse(datapemenang[x]['alokasi'].toString());
      }
      sisa -= alokasi;
    }

    if (alokasiController.text != "" && sisa < 0) {
      statusErrorAlokasi.value = "2"; //Alokasi melebihi batas maksimal
    } else if (alokasiController.text != "") {
      statusErrorAlokasi.value = "";
    }
  }
}
