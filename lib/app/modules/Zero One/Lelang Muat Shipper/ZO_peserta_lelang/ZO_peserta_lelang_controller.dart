import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/function/api/get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang_search/ZO_peserta_lelang_search_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_lelang/ZO_pilih_pemenang_lelang_controller.dart';
// import 'package:muatmuat/app/modules/chat/chat_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoPesertaLelangController extends GetxController {
  var loginas = "".obs;
  var idlelang = "".obs;
  var type = "".obs;
  var listPick = [].obs;
  var listDest = [].obs;
  var listDataBid = [].obs;
  var noBid = "".obs;
  var idBid = "".obs;
  var listParticipant = [].obs;
  var isLoading = false.obs;
  var issort = false.obs;

  String downloadId;

  final refreshPesertaLelang = RefreshController(initialRefresh: false);

  var permintaanHarga = TextEditingController().obs;

  var limitInisial = 0.obs;
  var limitnya = 10.obs;

  var dataHubTransporter = Map().obs;
  var isloadingHubTransportasi = false.obs;

  var sort = Map().obs;

  SortingController _sortingController;
  var transporterSort = [
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleNamaTransporter".tr,
        "transporter_name",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleHargaLelang".tr,
        "offer_price",
        "Terendah",
        "Tertinggi",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleJumlahDitawarkan".tr,
        "truck_offer",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleCatatanTambahan".tr,
        "notes",
        "A-Z",
        "Z-A",
        "".obs),
  ];

  @override
  Future<void> onInit() async {
    _sortingController = Get.put(
        SortingController(
            listSort: transporterSort,
            onRefreshData: (map) {
              sort.clear();
              sort.addAll(map);
              refreshData();
            }),
        tag: "SortPesertaLelang");
    idlelang.value = Get.arguments[0];
    type.value = Get.arguments[1];
    isLoading.value = true;
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      loginas.value = resLoginAs["LoginAs"].toString();
      getDataPesertaLelang("", "", "10", "false", "");
    }

    FlutterDownloader.registerCallback(downloadCallBack);
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void showSort() {
    _sortingController.showSort();
  }

  static void downloadCallBack(id, status, progress) {
    SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void download(String url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // var savedLocation =
      //     (await _findLocalPath()) + Platform.pathSeparator + 'Download';

      final externalDir = await getExternalStorageDirectory();
      // print("SFKALFAKFS $externalDir");

      downloadId = await FlutterDownloader.enqueue(
          url: url,
          savedDir: externalDir.path,
          // savedDir: savedLocation,
          saveInPublicStorage: true,
          showNotification: true,
          openFileFromNotification: true);
    } else {
      print("Permission Denied");
    }
    // final externalDir = await getExternalStorageDirectory();
  }

  // Future<String> _findLocalPath() async {
  //   if (!Platform.isAndroid) {
  //     var directory = await getApplicationDocumentsDirectory();
  //     return directory.path;
  //   }
  //   return "/storage/emulated/0/";
  //   // return ExtStorage.getExternalStorageDirectory();
  // }

  void refreshData() async {
    try {
      sortAction();
    } catch (e) {
      GlobalAlertDialog.showDialogError(
          message: e.toString(),
          context: Get.context,
          onTapPriority1: () {},
          labelButtonPriority1: "LoginLabelButtonCancel".tr);
    }
  }

  void sortAction() {
    var multiOrder = "false";
    var order = "";
    var modeorder = "";
    var limit;

    isLoading.value = true;
    if (sort.isNotEmpty) {
      issort.value = true;
      limit = limitnya.value;
      if (sort.keys.toList().length > 1) {
        multiOrder = "true";
        order = sort.keys.toList().join(",");
        modeorder = sort.values.toList().join(",");
      } else {
        multiOrder = "false";
        order = sort.keys.first;
        modeorder = sort.values.first;
      }
    } else {
      issort.value = false;

      multiOrder = "false";
      order = "";
      modeorder = "";
    }
    getDataPesertaLelang(order, modeorder, limit.toString(), multiOrder, "");
  }

  String converttoIDR(int number) {
    NumberFormat currFormater =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return currFormater.format(number);
  }

  void loadData() {
    isLoading.value = false;
    if (limitInisial.value <= limitnya.value) {
      limitnya.value = limitnya.value;
    } else {
      limitnya.value += 10;
    }
    if (issort.value) {
      refreshData();
    } else {
      getDataPesertaLelang("", "", limitnya.value.toString(), "false", "");
    }

    isLoading.value = false;
  }

  void refreshDataSmart() {
    // limitAktif.value = 10;
    isLoading.value = false;
    getDataPesertaLelang("", "", limitnya.value.toString(), "false", "");
    isLoading.value = false;
  }

  getDataPesertaLelang(String orderby, String ordermode, String limit,
      String multiorder, String q) async {
    isLoading.value = true;

    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListPesertaLelang(idlelang.value, loginas.value, orderby, ordermode,
            limit, multiorder, q);
    listPick.clear();
    listDest.clear();
    listDataBid.clear();
    listParticipant.clear();

    if (res != null &&
        res["Message"] != null &&
        res["Message"]["Code"] == 200) {
      (res["Data"]["BidLocation"] as List).forEach((valloc) {
        if (valloc["Type"] == "0") {
          listPick.add(valloc);
        }
        if (valloc["Type"] == "1") {
          listDest.add(valloc);
        }
      });
      noBid.value = res["Data"]["DataInformationBid"]["BidNo"];
      idBid.value = res["Data"]["DataInformationBid"]["ID"].toString();
      listDataBid.add(res["Data"]["DataInformationBid"]);

      (res["Data"]["DataParticipant"] as List).forEach((valparticipant) {
        listParticipant.add(valparticipant);
      });
      refreshPesertaLelang.resetNoData();
      refreshPesertaLelang.refreshCompleted();
      refreshPesertaLelang.loadComplete();
    } else {
      CustomToast.show(
          context: Get.context, message: "GlobalLabelErrorNullResponse".tr);
    }
    isLoading.value = false;
  }

  getContactTransporter(String transportasiID) async {
    isloadingHubTransportasi.value = true;
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getContactTransporter(transportasiID);
    dataHubTransporter.value.clear();

    if (res["Message"]["Code"] == 200) {
      dataHubTransporter.value = res["Data"];
      isloadingHubTransportasi.value = false;
    }
  }

  kirimPermintaanHarga(String idLelang, String idParticipant, String price,
      String nametransporter) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .postPermintaanHarga(
            idLelang, idParticipant, price.replaceAll(".", ""), loginas.value);

    if (res["Message"]["Code"] == 200) {
      if (sort.isNotEmpty) {
        sortAction();
      } else {
        isLoading.value = true;
        getDataPesertaLelang("", "", limitnya.toString(), "false", "");
      }
      CustomToast.show(
          context: Get.context,
          sizeRounded: 6,
          message:
              "LelangMuatPesertaLelangPesertaLelangLabelTitlePopBerhasilNegoHarga"
                      .tr +
                  " " +
                  nametransporter);
    }
  }

  Future<void> searchPesertaLelang() async {
    var result = await GetToPage.toNamed<ZoPesertaLelangSearchController>(
        Routes.ZO_PESERTA_LELANG_SEARCH,
        arguments: [idlelang.value, loginas.value, type.value],
        preventDuplicates: false);
    if (result != null) {
      // getListLelangMuatan(type);
      // tempFilterLokasiDestinasi.value = result;
    }
  }

  Future<void> topilihpemenang() async {
    var result = await GetToPage.toNamed<ZoPilihPemenangLelangController>(
        Routes.ZO_PILIH_PEMENANG_LELANG,
        arguments: [idlelang.value, loginas.value],
        preventDuplicates: false);
    if (result != null) {
      // getListLelangMuatan(type);
      // tempFilterLokasiDestinasi.value = result;
    }
  }

  void hubungiInbox(String userId) async {
    // var result = await GetToPage.toNamed<ChatController>(Routes.CHAT,
    //     arguments: [userId, ""], preventDuplicates: false);
    // if (result != null) {}
  }
}
