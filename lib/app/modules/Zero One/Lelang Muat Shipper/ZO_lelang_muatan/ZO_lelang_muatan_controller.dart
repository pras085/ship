import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart'
    as ark_global;
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_detail_lelang_muatan/ZO_detail_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_jenis_truk_lelang_muatan/ZO_filter_jenis_truk_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan_filter/ZO_filter_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_muatan/ZO_list_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_notifikasi_shipper/ZO_list_notifikasi_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang/ZO_peserta_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/Zo_search_lelang_muatan_list/Zo_search_lelang_muatan_list_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/shared_preferences_helper_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/checkbox_custom_widget_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'dart:math' as math;

import 'package:pull_to_refresh/pull_to_refresh.dart';

//
class ZoLelangMuatanController extends GetxController
    with SingleGetTickerProviderMixin {
  var loading = false.obs;
  TabController tabController;
  final refreshLelangMuatanTabAktifController =
      RefreshController(initialRefresh: false);
  final refreshLelangMuatanTabHistoryController =
      RefreshController(initialRefresh: false);
  var isLoadingTabAktif = false.obs;
  var isLoadingTabHistory = false.obs;
  var limitTabAktif = 0.obs;
  var limitTabHistory = 0.obs;
  var limitAktif = 10.obs;
  var limitHistory = 10.obs;

  final searchTextEditingController = TextEditingController().obs;
  final startDateFilterTanggalBuatController = TextEditingController().obs;
  final endDateFilterTanggalBuatController = TextEditingController().obs;
  final startDateFilterPeriodeLelangController = TextEditingController().obs;
  final endDateFilterPeriodeLelangController = TextEditingController().obs;
  final startDateFilterWaktuPickupController = TextEditingController().obs;
  final endDateFilterWaktuPickupController = TextEditingController().obs;
  final startDateFilterEstimasiKedatanganController =
      TextEditingController().obs;
  final endDateFilterEstimasiKedatanganController = TextEditingController().obs;
  final isShowClearSearch = false.obs;
  Rx<RangeValues> _rangeValuesJmlKebutuhan = RangeValues(0.0, 1500.0).obs;
  Rx<RangeValues> _rangeValuesJmlKoli = RangeValues(0.0, 1500.0).obs;
  final startJumlahKebutuhan = TextEditingController().obs;
  final endJumlahKebutuhan = TextEditingController().obs;
  final startJumlahKoli = TextEditingController().obs;
  final endJumlahKoli = TextEditingController().obs;

  final panjang = TextEditingController().obs;
  final lebar = TextEditingController().obs;
  final tinggi = TextEditingController().obs;
  final volume = TextEditingController().obs;

  var _selectedsatuandimensi = "m".obs;
  List _listSatuanDimensi = ["m", "cm"];

  List<DropdownMenuItem> buildDropdownSatuanDimensi(List _listSatuanDimensi) {
    List<DropdownMenuItem> items = [];
    for (var i in _listSatuanDimensi) {
      items.add(DropdownMenuItem(
        value: i,
        child: CustomText(i,
            fontWeight: FontWeight.w600,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            color: Color(ListColor.colorLightGrey4)),
      ));
    }
    return items;
  }

  List<DropdownMenuItem> _dropdownSatuanDimensi = [];

  onChangeDropdownSatuanDimensi(select) {
    _selectedsatuandimensi.value = select;
  }

  var _selectedsatuanvolume = "m3".obs;
  List _listSatuanVolume = ["m3", "Lt"];

  List<DropdownMenuItem> buildDropdownSatuanVolume(List _listSatuanVolume) {
    List<DropdownMenuItem> items = [];
    for (var i in _listSatuanVolume) {
      items.add(DropdownMenuItem(
        value: i,
        child: CustomText(i,
            fontWeight: FontWeight.w600,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            color: Color(ListColor.colorLightGrey4)),
      ));
    }
    return items;
  }

  List<DropdownMenuItem> _dropdownSatuanVolume = [];

  onChangeDropdownSatuanVolume(select) {
    _selectedsatuanvolume.value = select;
  }

  var searchValue = "".obs;
  var showInfoTooltip = true.obs;

  var istidakadadata = false.obs;

  var sort = Map().obs;
  var sortHistory = Map().obs;

  SortingController _sortingController;
  var transporterSort = [
    DataListSortingModel("LelangMuatTabAktifTabAktifLableTitleSortNumber".tr,
        "bid_no", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortCreatedDate".tr,
        "Created",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortRoute".tr,
        "rute", "A-Z", "Z-A", "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortPeriod".tr,
        "periode", "A-Z", "Z-A", "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortReqQty".tr,
        "truck_qty", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortPickupTime".tr,
        "pickup_eta",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortExpectedArrival".tr,
        "destination_eta",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortStatusTransporter".tr,
        "viewers",
        "A-Z",
        "Z-A",
        "".obs),
  ];

  SortingController _sortingControllerhistory;
  var transporterSorthistory = [
    DataListSortingModel("LelangMuatTabAktifTabAktifLableTitleSortNumber".tr,
        "bid_no", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortCreatedDate".tr,
        "Created",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortRoute".tr,
        "rute", "A-Z", "Z-A", "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortPeriod".tr,
        "periode", "A-Z", "Z-A", "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortReqQty".tr,
        "truck_qty", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortPickupTime".tr,
        "pickup_eta",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortExpectedArrival".tr,
        "destination_eta",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortStatusTransporter".tr,
        "viewers",
        "A-Z",
        "Z-A",
        "".obs),
  ];

  var listFilterLokasiPickup = [].obs;
  var filterLokasiPickup = [].obs;
  var tempFilterLokasiPickup = [].obs;
  var getListFilterLokasiPickup = false.obs;

  var listFilterLokasiDestinasi = [].obs;
  var filterLokasiDestinasi = [].obs;
  var tempFilterLokasiDestinasi = [].obs;
  var getListFilterLokasiDestinasi = false.obs;

  var listFilterJenisTruck = [].obs;
  var filterJenisTruck = [].obs;
  var tempFilterJenisTruck = [].obs;
  var getListFilterJenisTruck = false.obs;

  var listFilterJenisTruckimg = [].obs;
  var tempFilterJenisTruckimg = [].obs;
  // var tempFilterJenisTruckId = [].obs;

  var listFilterJenisCarrier = [].obs;
  var filterJenisCarrier = [].obs;
  var tempFilterJenisCarrier = [].obs;
  var getListFilterJenisCarrier = false.obs;

  var listFilterJenisCarrierimg = [].obs;
  var tempFilterJenisCarrierimg = [].obs;

  var listFilterProvince = [].obs;
  var filterProvince = [].obs;
  var tempFilterProvince = [].obs;
  var getListFilterProvince = false.obs;
  var totalAll = 0.obs;

  var listDataLelangMuatan = [].obs;
  var listDataLelangMuatanHistory = [].obs;
  var listcountDataLelangmuatan = [].obs;

  var listMuatan = [].obs;
  var tempMuatan = [].obs;
  // var listSelectedMuatan = [].obs;

  var listDataNotifikasi = [].obs;

  var listJenisMuatan = [].obs;
  var tempJenisMuatan = [].obs;
//LelangMuatTabHistoryTabHistoryLabelTitleDitutup
  var listStatus = [
    {"id": 5, "val": "LelangMuatTabHistoryTabHistoryLabelTitleSelesai".tr},
    {"id": 3, "val": "LelangMuatTabHistoryTabHistoryLabelTitleBatal".tr},
    {"id": 4, "val": "LelangMuatTabHistoryTabHistoryLabelTitleDitutup".tr},
  ].obs;
  var tempStatus = [].obs;

  var firstTime = true;
  var failedGetListFilter = false.obs;
  var limitWrap = 5;
  var langTemp = "";

  var isFilter = false.obs;
  var isFilterHistory = false.obs;
  var issort = false.obs;
  var issortHistory = false.obs;

  var isLoading = true.obs;
  final listChoosen = {}.obs;

  var limitMuatanView = 3;
  var firsttimelelangMuatan = false.obs;

  var iserorstartkebutuhan = "".obs;
  var iserorendkebutuhan = "".obs;
  var iserorstartkoli = "".obs;
  var iserorendkoli = "".obs;

  var iserorstartkebutuhankelebihan = "".obs;
  var iserorstartkolikelebihan = "".obs;

  DateTime inisialDateEndPickerTglBuat = DateTime.now();
  DateTime inisialDateEndPickerPeriodeLelang = DateTime.now();
  DateTime inisialDateEndPickerWaktuPickup = DateTime.now();
  DateTime inisialDateEndPickerEstimasiKedatangan = DateTime.now();
  DateTime inisialDateStartPickerTglBuat = DateTime.now();
  DateTime inisialDateStartPickerPeriodeLelang = DateTime.now();
  DateTime inisialDateStartPickerWaktuPickup = DateTime.now();
  DateTime inisialDateStartPickerEstimasiKedatangan = DateTime.now();
  var isSelectStartDateTglBuat = false.obs;
  var isSelectStartDatePeriodeLelang = false.obs;
  var isSelectStartDateWaktuPickup = false.obs;
  var isSelectStartDateEstimasiKedatangan = false.obs;
  DateTime firstdateTglBuat;
  DateTime firstdatePeriodeLelang;
  DateTime firstdateWaktuPickup;
  DateTime firstdateEstimasiKedatangan;

  var isSearchAktifOrHistory = "aktif".obs;
  var lengthPickup = [].obs;
  var lengthDestinasi = [].obs;
  var lengthPickupHistory = [].obs;
  var lengthDestinasiHistory = [].obs;

  var loginAsVal = "".obs;
  var linkShareBid = "".obs;

  var isNewNotif = false.obs;

  final bannerItems = <String>[].obs;

  Future<void> initBanner() async {
    bannerItems.clear();

    final fetchResult = await ApiHelper(
      context: Get.context,
      isShowDialogLoading: false,
      isShowDialogError: false,
    ).fetchBanner();

    if (fetchResult != null &&
        fetchResult['Message'] != null &&
        fetchResult['Message']['Code'] == 200) {
      if (fetchResult['Data'] != null &&
          fetchResult['Data']['LelangMuat'] != null) {
        if (fetchResult['Data']['LelangMuat'] is List) {
          final items = (fetchResult['Data']['LelangMuat'] as List)
              .map((e) => '$e')
              .toList();

          bannerItems.addAll(items.take(10));
        }
      }
    }
    bannerItems.refresh();
  }

  @override
  void onInit() async {
    initBanner();
    _dropdownSatuanDimensi = buildDropdownSatuanDimensi(_listSatuanDimensi);
    _dropdownSatuanVolume = buildDropdownSatuanVolume(_listSatuanVolume);
    _sortingController = Get.put(
        SortingController(
            listSort: transporterSort,
            onRefreshData: (map) {
              sort.clear();
              sort.addAll(map);
              refreshData("aktif");
            }),
        tag: "SortLelangMuatan");

    _sortingControllerhistory = Get.put(
        SortingController(
            listSort: transporterSorthistory,
            onRefreshData: (map) {
              sortHistory.clear();
              sortHistory.addAll(map);
              refreshData("history");
            }),
        tag: "SortLelangMuatanHistory");

    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      loginAsVal.value = resLoginAs["LoginAs"].toString();
    }
    // refreshData();
    getListLelangMuatan("aktif", limit: "10");
    getJenisMuatan();
    getNotifikasiListData();
    getSharePDF("aktif");
    listDataLelangMuatan.add({"tooltip": 0});
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      if (tabController.index == 0) {
        getSharePDF("aktif");
        isSearchAktifOrHistory.value = "aktif";
        limitAktif.value = 10;
        // issort.value = false;
        // sort.clear();
        if (issort.value) {
          refreshData("aktif");
        } else {
          if (isFilter.value) {
            filterAction("aktif");
          } else {
            getListLelangMuatan("aktif", limit: "10");
          }
        }
      }
      if (tabController.index == 1) {
        getSharePDF("history");
        isSearchAktifOrHistory.value = "history";
        limitHistory.value = 10;
        // issortHistory.value = false;
        // sortHistory.clear();
        if (issortHistory.value) {
          refreshData("history");
        } else {
          if (isFilterHistory.value) {
            filterAction("history");
          } else {
            getListLelangMuatan("history", limit: "10");
          }
        }
      }
    });

    getFirstTimeResult();

    super.onInit();
  }

  getSharePDF(String type) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getSharePDF(loginAsVal.value, type);
    linkShareBid.value = "";

    if (res["Message"]["Code"] == 200) {
      linkShareBid.value = res["Data"]["Link"];
    }
  }

  getVlidatoreror(String valnya, String param) {
    if (int.parse(valnya.replaceAll('.', '')) > 1500) {
      if (param == "startkebutuhan") {
        iserorstartkebutuhan.value = "nilai kelebihan";
      }
      if (param == "endkebutuhan") {
        iserorendkebutuhan.value = "nilai kelebihan";
      }
      if (param == "startkoli") {
        iserorstartkoli.value = "nilai kelebihan";
      }
      if (param == "endkoli") {
        iserorendkoli.value = "nilai kelebihan";
      }
    } else {
      if (param == "startkebutuhan") {
        iserorstartkebutuhan.value = "";
      }
      if (param == "endkebutuhan") {
        iserorendkebutuhan.value = "";
      }
      if (param == "startkoli") {
        iserorstartkoli.value = "";
      }
      if (param == "endkoli") {
        iserorendkoli.value = "";
      }
    }
  }

  getValidateerorkelebihan(String param) {
    if (param == "startkebutuhan") {
      iserorstartkebutuhankelebihan.value = "nilai melebihi nilai akhir";
    }
    if (param == "endkebutuhan") {
      iserorstartkebutuhankelebihan.value = "nilai melebihi nilai akhir";
    }
    if (param == "startkoli") {
      iserorstartkolikelebihan.value = "nilai melebihi nilai akhir";
    }
    if (param == "endkoli") {
      iserorstartkolikelebihan.value = "nilai melebihi nilai akhir";
    }
  }

  getFirstTimeResult() async {
    var resFirstime = await SharedPreferencesHelper.getFirstTimeLelangMuatan();
    firsttimelelangMuatan.value = resFirstime;
  }

  setFirstTimeResult(bool isfirsttime) async {
    await SharedPreferencesHelper.setFirstTimeLelangMuatan(isfirsttime);
    getFirstTimeResult();
  }

  void onCheckMuatan(int index, bool value) {
    if (value) {
      listChoosen[listMuatan[index]] = listMuatan[index];
    } else {
      listChoosen.removeWhere((key, value) => key == listMuatan[index]);
    }
    listMuatan.refresh();
  }

  void onCheckMuatanFirst(int index, bool value) {
    if (value) {
      tempMuatan.add(listMuatan[index]);
    } else {
      tempMuatan.removeWhere((element) => element == listMuatan[index]);
    }
    tempMuatan.refresh();
  }

  Widget get messageBottomNav {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        margin: EdgeInsets.fromLTRB(
            0, 15, 0, GlobalVariable.ratioWidth(Get.context) * 38),
        width: GlobalVariable.ratioWidth(Get.context) * 148,
        height: GlobalVariable.ratioWidth(Get.context) * 67,
        child: Stack(children: [
          Container(
            width: GlobalVariable.ratioWidth(Get.context) * 148,
            height: GlobalVariable.ratioWidth(Get.context) * 59,
            decoration: BoxDecoration(
              color: Color(ListColor.colorDarkGrey4),
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                    color: Color(ListColor.colorLightGrey18), blurRadius: 18)
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorDarkGrey4),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                          color: Color(ListColor.colorLightGrey18),
                          blurRadius: 18)
                    ],
                  ),
                ),
              )),
          Container(
              width: GlobalVariable.ratioWidth(Get.context) * 148,
              height: GlobalVariable.ratioWidth(Get.context) * 66,
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(ListColor.colorDarkGrey4),
                borderRadius: BorderRadius.circular(9),
              ),
              child: CustomText(
                  "LelangMuatBuatLelangBuatLelangLabelTitlePressGetStarted".tr,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                  height: GlobalVariable.ratioFontSize(Get.context) * (26 / 14),
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.color2),
                  textAlign: TextAlign.center)),
        ]),
      ),
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void refreshData(String type) async {
    try {
      sortAction(type);
    } catch (e) {
      GlobalAlertDialog.showDialogError(
          message: e.toString(),
          context: Get.context,
          onTapPriority1: () {},
          labelButtonPriority1: "LoginLabelButtonCancel".tr);
    }
  }

  Future getJenisMuatan() async {
    var resJenisMuatan = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getJenisMuatan();

    if (resJenisMuatan["Message"]["Code"] == 200) {
      listJenisMuatan.clear();
      (resJenisMuatan["Data"] as List).forEach((element) {
        listJenisMuatan.add(element["Description"]);
      });
    }
  }

  void getListLelangMuatan(String type,
      {String word = "",
      String search = "false",
      String filter = "false",
      String startdate = "",
      String enddate = "",
      String startcreateddate = "",
      String endcreateddate = "",
      String startpickupdate = "",
      String endpickupdate = "",
      String startdestinationdate = "",
      String enddestinationdate = "",
      String mintrukqty = "",
      String maxtrukqty = "",
      String minkoliqty = "",
      String maxkoliqty = "",
      String dimension = "",
      String length = '',
      String width = '',
      String height = '',
      String dimensionUnit = '',
      String volume = "",
      List idcargotype,
      List status,
      List cargo,
      List pickuplocation,
      List destinationlocation,
      List province,
      List headid,
      List carrierid,
      String orderBy = "",
      String orderMode = "",
      String multiOrder = "false",
      String limit = "",
      String offset = ""}) async {
    if (type == "aktif") {
      isLoadingTabAktif.value = true;
    }
    if (type == "history") {
      isLoadingTabHistory.value = true;
    }
    // var resLoginAs = await ApiHelper(
    //         context: Get.context,
    //         isShowDialogLoading: false,
    //         isShowDialogError: false)
    //     .getUserShiper(GlobalVariable.role);

    // if (resLoginAs["Message"]["Code"] == 200) {
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListLelangMuatan(type, search, filter, loginAsVal.value,
            word: word,
            startdate: startdate,
            enddate: enddate,
            startcreateddate: startcreateddate,
            endcreateddate: endcreateddate,
            startpickupdate: startpickupdate,
            endpickupdate: endpickupdate,
            startdestinationdate: startdestinationdate,
            enddestinationdate: enddestinationdate,
            mintrukqty: mintrukqty,
            maxtrukqty: maxtrukqty,
            minkoliqty: minkoliqty,
            maxkoliqty: maxkoliqty,
            dimension: dimension,
            length: length,
            width: width,
            height: height,
            dimensionUnit: dimensionUnit,
            volume: volume,
            idcargotype: idcargotype,
            status: status,
            cargo: cargo,
            pickuplocation: pickuplocation,
            destinationlocation: destinationlocation,
            province: province,
            headid: headid,
            carrierid: carrierid,
            orderBy: orderBy,
            orderMode: orderMode,
            multiOrder: multiOrder,
            limit: limit);

    if (resultCity["Message"]["Code"] == 200) {
      if (type == "aktif") {
        isLoadingTabAktif.value = false;
        refreshLelangMuatanTabAktifController.resetNoData();
        refreshLelangMuatanTabAktifController.refreshCompleted();
        refreshLelangMuatanTabAktifController.loadComplete();
      }
      if (type == "history") {
        isLoadingTabHistory.value = false;
        refreshLelangMuatanTabHistoryController.resetNoData();
        refreshLelangMuatanTabHistoryController.refreshCompleted();
        refreshLelangMuatanTabHistoryController.loadComplete();
      }
      if (type == "aktif") {
        listDataLelangMuatan.clear();
        listcountDataLelangmuatan.clear();
        listDataLelangMuatan.add({"tooltip": 0});
        lengthPickup.clear();
        lengthDestinasi.clear();
      }
      if (type == "history") {
        listDataLelangMuatanHistory.clear();
        lengthPickupHistory.clear();
        lengthDestinasiHistory.clear();
      }

      if (type == "aktif") {
        lengthPickup.add(0);
        lengthDestinasi.add(0);
        limitTabAktif.value = resultCity["SupportingData"]["NoLimitCount"];
      }
      if (type == "history") {
        limitTabHistory.value = resultCity["SupportingData"]["NoLimitCount"];
      }

      (resultCity["Data"] as List).forEach((element) {
        var idx = resultCity["Data"].indexOf(element);

        if (type == "aktif") {
          lengthPickup.add(0);
          lengthDestinasi.add(0);
          listDataLelangMuatan.add(element);
          listcountDataLelangmuatan.add(element);
        }
        if (type == "history") {
          lengthPickupHistory.add(0);
          lengthDestinasiHistory.add(0);
          listDataLelangMuatanHistory.add(element);
        }

        var listpickhis = [];
        var listdeshis = [];
        var listpick = [];
        var listdes = [];
        (element["Location"] as List).forEach((el) {
          if (type == "aktif") {
            if (el["Type"] == "0") {
              listpick.add(el);
            }
            if (el["Type"] == "1") {
              listdes.add(el);
            }
          }

          if (type == "history") {
            if (el["Type"] == "0") {
              listpickhis.add(el);
            }
            if (el["Type"] == "1") {
              listdeshis.add(el);
            }
          }
        });

        if (type == "aktif") {
          lengthPickup[idx + 1] = listpick.length;
          lengthDestinasi[idx + 1] = listdes.length;
        }
        if (type == "history") {
          lengthPickupHistory[idx] = listpickhis.length;
          lengthDestinasiHistory[idx] = listdeshis.length;
        }
      });

      if (type == "aktif") {
        if (listcountDataLelangmuatan.isEmpty) {
          istidakadadata.value = true;
        }
      }
      if (type == "history") {
        if (listDataLelangMuatanHistory.isEmpty) {
          istidakadadata.value = true;
        }
      }
    } else {
      isLoading.value = false;
    }
    // } else {
    //   isLoading.value = false;
    // }
  }

  void loadData({bool isRefresh = false}) {
    isLoadingTabAktif.value = false;
    if (!isRefresh) {
      if (limitTabAktif.value <= limitAktif.value) {
        limitAktif.value = limitAktif.value;
      } else {
        limitAktif.value += 10;
      }
    }
    if (isFilter.value) {
      filterAction("aktif");
    } else if (issort.value) {
      refreshData("aktif");
    } else {
      getListLelangMuatan("aktif", limit: limitAktif.value.toString());
    }

    isLoadingTabAktif.value = false;
  }

  void refreshDataSmart() {
    // // limitAktif.value = 10;
    // isLoadingTabAktif.value = false;
    // getListLelangMuatan("aktif", limit: limitAktif.value.toString());
    // isLoadingTabAktif.value = false;
    loadData(isRefresh: true);
  }

  void loadDataHistory({bool isRefresh = false}) {
    isLoadingTabHistory.value = false;
    if (!isRefresh) {
      if (limitTabHistory.value <= limitHistory.value) {
        limitHistory.value = limitHistory.value;
      } else {
        limitHistory.value += 10;
      }
    }
    if (isFilterHistory.value) {
      filterAction("history");
    } else if (issortHistory.value) {
      refreshData("history");
    } else {
      getListLelangMuatan("history", limit: limitHistory.value.toString());
    }

    isLoadingTabHistory.value = false;
  }

  void refreshDataSmartHistory() {
    // // limitHistory.value = 10;
    // isLoadingTabHistory.value = false;
    // getListLelangMuatan("history", limit: limitHistory.value.toString());
    // isLoadingTabHistory.value = false;
    loadDataHistory(isRefresh: true);
  }

  void showSort() {
    _sortingController.showSort();
  }

  void showSortHistory() {
    _sortingControllerhistory.showSort();
  }

  void addTextSearchCity(String value, String type) {
    if (value != "") {
      searchValue.value = value;
    } else {
      // listDataLelangMuatan.clear();
      // listcountDataLelangmuatan.clear();
      getListLelangMuatan(type, limit: "10");
    }
  }

  void onSubmitSearch(String type) {
    if (searchValue.isNotEmpty) {
      isShowClearSearch.value = searchValue.isNotEmpty;
      // listDataLelangMuatan.clear();
      // listcountDataLelangmuatan.clear();
      getListLelangMuatan(type,
          word: searchValue.toString(), search: 'true', limit: "10");
    } else {
      // listDataLelangMuatan.clear();
      // listcountDataLelangmuatan.clear();
      getListLelangMuatan(type, limit: "10");
    }
  }

  void onClearSearch(String type) {
    searchTextEditingController.value.text = "";
    searchValue.value = "";
    addTextSearchCity("", type);
  }

  void showFilter(String type) async {
    // tempFilterLokasiPickup.value = List.from(filterLokasiPickup.value);
    // tempFilterLokasiDestinasi.value = List.from(filterLokasiDestinasi.value);
    // tempFilterProvince.value = List.from(filterProvince.value);
    if (firstTime || failedGetListFilter.value) getListFilter(type);
    firstTime = false;
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(Get.context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 4,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 16),
                  height: GlobalVariable.ratioWidth(Get.context) * 3,
                  width: GlobalVariable.ratioWidth(Get.context) * 38,
                  color: Color(ListColor.colorLightGrey16),
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 12,
                        right: GlobalVariable.ratioWidth(Get.context) * 18,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: CustomText("GlobalFilterTitle".tr,
                                fontWeight: FontWeight.w700,
                                color: Color(ListColor.color4),
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14)),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                child: Icon(
                              Icons.close_rounded,
                              size: GlobalVariable.ratioFontSize(Get.context) *
                                  24,
                            )),
                          ),
                        ),
                        Obx(
                          () => !failedGetListFilter.value &&
                                  !getListFilterLokasiPickup.value &&
                                  !getListFilterLokasiDestinasi.value &&
                                  !getListFilterProvince.value &&
                                  !getListFilterJenisTruck.value &&
                                  !getListFilterJenisCarrier.value
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        child: CustomText(
                                          "GlobalFilterButtonReset".tr,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(ListColor.color4),
                                        ),
                                        onTap: () {
                                          resetFilter();
                                        }),
                                  ),
                                )
                              : SizedBox.shrink(),
                        )
                      ],
                    )),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(Get.context).size.height - 200,
                        minHeight: 0,
                        minWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 18),
                      child: Obx(
                        () => (getListFilterLokasiPickup.value ||
                                getListFilterLokasiDestinasi.value ||
                                getListFilterProvince.value)
                            ? Container(
                                width: MediaQuery.of(Get.context).size.width,
                                height: 200,
                                child: Center(
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator())))
                            : !failedGetListFilter.value
                                ? (listFilterLokasiPickup.isNotEmpty ||
                                        listFilterLokasiDestinasi.isNotEmpty ||
                                        listFilterProvince.isNotEmpty)
                                    ? ListView(
                                        shrinkWrap: true,
                                        children: [
                                          _formFilterLokasiPickUp(),
                                          _listseparator(),
                                          _formFilterLokasiDestinasi(),
                                          _listseparator(),
                                          _formFilterProvinsi(),
                                          _listseparator(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      "LelangMuatTabAktifTabAktifLabelTitleSortCreatedDate"
                                                          .tr,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                              Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              _formFilterDate("tanggalBuat"),
                                            ],
                                          ),
                                          _listseparator(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      "LelangMuatTabAktifTabAktifLabelTitleBidPeriod"
                                                          .tr,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                              Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              _formFilterDate("periodeLelang"),
                                            ],
                                          ),
                                          _listseparator(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      "LelangMuatTabAktifTabAktifLabelTitleSortPickupTime"
                                                          .tr,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                              Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              _formFilterDate("waktuPickup"),
                                            ],
                                          ),
                                          _listseparator(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      "LelangMuatTabAktifTabAktifLabelTitleEstimationArrival"
                                                          .tr,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                              Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              _formFilterDate(
                                                  "estimasiKedatangan"),
                                            ],
                                          ),
                                          _listseparator(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      "LelangMuatTabAktifTabAktifLabelTitleSortReqQty"
                                                          .tr,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                              Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              _formFilterRangeHargaJmlKebutuhan()
                                            ],
                                          ),
                                          _listseparator(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      "LelangMuatTabAktifTabAktifLabelTitleColiQty"
                                                          .tr,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                              Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              _formFilterRangeHargaJmlKoli()
                                              // _formFilterRangeHarga(
                                              //     "jumlahKoli")
                                            ],
                                          ),
                                          _listseparator(),
                                          _formFilterJenisTruck(),
                                          _listseparator(),
                                          _formFilterJenisCarrier(),
                                          _listseparator(),
                                          _formFilterMuatan(),
                                          _listseparator(),
                                          _formFilterJenisMuatan(),
                                          _listseparator(),
                                          if (type == "history")
                                            _formFilterStatus(),
                                          if (type == "history")
                                            _listseparator(),
                                          _formFilterDimensiMuatanKoli(),
                                          _listseparator(),
                                          _formFilterVolume(),
                                          SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    context) *
                                                24,
                                          )
                                        ],
                                      )
                                    : SizedBox.shrink()
                                : Container(
                                    width:
                                        MediaQuery.of(Get.context).size.width,
                                    height: 200,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 10),
                                          CustomText(
                                            'GlobalLabelErrorNoCTypection'.tr,
                                            textAlign: TextAlign.center,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    14,
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                              onTap: () {
                                                getListFilter(type);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: CustomText(
                                                  'GlobalButtonTryAgain'.tr,
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      14,
                                                  color:
                                                      Color(ListColor.color4),
                                                ),
                                              ))
                                        ])),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 10,
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 10),
                  height: GlobalVariable.ratioWidth(context) * 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x54000000),
                          spreadRadius: 2,
                          blurRadius: 80,
                        ),
                      ]),
                  child: Row(
                    children: [
                      Expanded(child: _buttonPrioritySecondary()),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 8,
                      ),
                      Expanded(child: _buttonPriorityPrimary(type)),
                    ],
                  ),
                )
              ],
            ),
          ));
        });
  }

  double tryParseFormattedDouble(String text) {
    var parsed = double.tryParse(
      '$text'.trim().replaceAll('.', '').replaceAll(',', '.'),
    );
    debugPrint('debug-tryParseFormattedDouble: $text => $parsed');
    return parsed;
  }

  void sortAction(String type) {
    var multiOrder = "false";
    var order = "";
    var modeorder = "";
    var limit;
    if (type == "aktif") {
      if (sort.isNotEmpty) {
        issort.value = true;
        limit = limitAktif.value;
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
    }

    if (type == "history") {
      if (sortHistory.isNotEmpty) {
        issortHistory.value = true;
        limit = limitHistory.value;

        if (sortHistory.keys.toList().length > 1) {
          multiOrder = "true";
          order = sortHistory.keys.toList().join(",");
          modeorder = sortHistory.values.toList().join(",");
        } else {
          multiOrder = "false";
          order = sortHistory.keys.first;
          modeorder = sortHistory.values.first;
        }
      } else {
        issortHistory.value = false;

        multiOrder = "false";
        order = "";
        modeorder = "";
      }
    }

    String startdatetxt = "";
    String enddatetxt = "";
    String startcreatedatetxt = "";
    String endcreatedatetxt = "";
    String startpickupdatetxt = "";
    String endpickupdatetxt = "";
    String startdestinasidatetxt = "";
    String enddestinasidatetxt = "";
    if (startDateFilterTanggalBuatController.value.text != "" &&
        endDateFilterTanggalBuatController.value.text != "") {
      var startdate =
          startDateFilterTanggalBuatController.value.text.split("/");
      var enddate = endDateFilterTanggalBuatController.value.text.split("/");
      startdatetxt = "${startdate[2]}-${startdate[1]}-${startdate[0]}";
      enddatetxt = "${enddate[2]}-${enddate[1]}-${enddate[0]}";
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (startDateFilterPeriodeLelangController.value.text != "" &&
        endDateFilterPeriodeLelangController.value.text != "") {
      var startcreateddate =
          startDateFilterPeriodeLelangController.value.text.split("/");
      var endcreateddate =
          endDateFilterPeriodeLelangController.value.text.split("/");
      startcreatedatetxt =
          "${startcreateddate[2]}-${startcreateddate[1]}-${startcreateddate[0]}";
      endcreatedatetxt =
          "${endcreateddate[2]}-${endcreateddate[1]}-${endcreateddate[0]}";
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (startDateFilterWaktuPickupController.value.text != "" &&
        endDateFilterWaktuPickupController.value.text != "") {
      var startpickupdate =
          startDateFilterWaktuPickupController.value.text.split("/");
      var endpickupdate =
          endDateFilterWaktuPickupController.value.text.split("/");
      startpickupdatetxt =
          "${startpickupdate[2]}-${startpickupdate[1]}-${startpickupdate[0]}";
      endpickupdatetxt =
          "${endpickupdate[2]}-${endpickupdate[1]}-${endpickupdate[0]}";
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (startDateFilterEstimasiKedatanganController.value.text != "" &&
        endDateFilterEstimasiKedatanganController.value.text != "") {
      var startdestinationdate =
          startDateFilterEstimasiKedatanganController.value.text.split("/");
      var enddestinationdate =
          endDateFilterEstimasiKedatanganController.value.text.split("/");
      startdestinasidatetxt =
          "${startdestinationdate[2]}-${startdestinationdate[1]}-${startdestinationdate[0]}";
      enddestinasidatetxt =
          "${enddestinationdate[2]}-${enddestinationdate[1]}-${enddestinationdate[0]}";
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (startJumlahKebutuhan.value.text != "" &&
        endJumlahKebutuhan.value.text != "") {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (startJumlahKoli.value.text != "" && endJumlahKoli.value.text != "") {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    var jenistruk = [];
    if (tempFilterJenisTruck.isNotEmpty) {
      tempFilterJenisTruck.forEach((element) {
        jenistruk.add(element["ID"]);
      });
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    var jeniscarriertruk = [];
    if (tempFilterJenisCarrier.isNotEmpty) {
      tempFilterJenisCarrier.forEach((element) {
        jeniscarriertruk.add(element["ID"]);
      });
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    var listProvinci = [];
    if (tempFilterProvince.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
        tempFilterProvince.forEach((element) {
          if (element["Code"] == null) {
            listProvinci.add(element["ID"]);
          } else {
            listProvinci.add(element["Code"]);
          }
        });
      }
      if (type == "history") {
        isFilterHistory.value = true;
        tempFilterProvince.forEach((element) {
          if (element["Code"] == null) {
            listProvinci.add(element["ID"]);
          } else {
            listProvinci.add(element["Code"]);
          }
        });
      }
    }

    if (tempFilterLokasiPickup.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (tempFilterLokasiDestinasi.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (tempJenisMuatan.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (tempStatus.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (tempMuatan.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    var length = '';
    var width = '';
    var height = '';
    var dimensionUnit = '';

    if (panjang.value.text != "") {
      length = '${tryParseFormattedDouble(panjang.value.text) ?? ''}';
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (lebar.value.text != "") {
      width = '${tryParseFormattedDouble(lebar.value.text) ?? ''}';
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (tinggi.value.text != "") {
      height = '${tryParseFormattedDouble(tinggi.value.text) ?? ''}';
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (length.isNotEmpty || width.isNotEmpty || height.isNotEmpty) {
      dimensionUnit = _selectedsatuandimensi.value;
    }

    String dimensi = "";
    if (panjang.value.text != "" ||
        lebar.value.text != "" ||
        tinggi.value.text != "") {
      dimensi = panjang.value.text.replaceAll('.', '') +
          "${panjang.value.text.isEmpty ? '0' : ''}" +
          "${panjang.value.text.contains(',') ? '' : ',00'}" +
          "*_*_*" +
          lebar.value.text.replaceAll('.', '') +
          "${lebar.value.text.isEmpty ? '0' : ''}" +
          "${lebar.value.text.contains(',') ? '' : ',00'}" +
          "*_*_*" +
          tinggi.value.text.replaceAll('.', '') +
          "${tinggi.value.text.isEmpty ? '0' : ''}" +
          "${tinggi.value.text.contains(',') ? '' : ',00'}" +
          " " +
          _selectedsatuandimensi.value;
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    String vol = "";
    if (volume.value.text != "") {
      vol = volume.value.text.replaceAll('.', '') +
          " " +
          _selectedsatuanvolume.value;
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (startdatetxt == "" &&
        enddatetxt == "" &&
        startcreatedatetxt == "" &&
        endcreatedatetxt == "" &&
        startpickupdatetxt == "" &&
        endpickupdatetxt == "" &&
        startdestinasidatetxt == "" &&
        enddestinasidatetxt == "" &&
        startJumlahKebutuhan.value.text == "" &&
        endJumlahKebutuhan.value.text == "" &&
        startJumlahKoli.value.text == "" &&
        endJumlahKoli.value.text == "" &&
        tempFilterJenisTruck.isEmpty &&
        tempFilterJenisCarrier.isEmpty &&
        tempFilterLokasiPickup.isEmpty &&
        tempFilterLokasiDestinasi.isEmpty &&
        tempFilterProvince.isEmpty &&
        tempJenisMuatan.isEmpty &&
        tempStatus.isEmpty &&
        dimensi.isEmpty &&
        vol == "" &&
        tempMuatan.isEmpty) {
      if (type == "aktif") {
        isFilter.value = false;
      }
      if (type == "history") {
        isFilterHistory.value = false;
      }
    }

    getListLelangMuatan(type,
        filter: "true",
        search: "false",
        startdate: startcreatedatetxt,
        enddate: endcreatedatetxt,
        startcreateddate: startdatetxt,
        endcreateddate: enddatetxt,
        startpickupdate: startpickupdatetxt,
        endpickupdate: endpickupdatetxt,
        startdestinationdate: startdestinasidatetxt,
        enddestinationdate: enddestinasidatetxt,
        mintrukqty: startJumlahKebutuhan.value.text.replaceAll('.', ''),
        maxtrukqty: endJumlahKebutuhan.value.text.replaceAll('.', ''),
        minkoliqty: startJumlahKoli.value.text.replaceAll('.', ''),
        maxkoliqty: endJumlahKoli.value.text.replaceAll('.', ''),
        dimension: dimensi,
        length: length,
        width: width,
        height: height,
        dimensionUnit: dimensionUnit,
        volume: vol,
        idcargotype: tempJenisMuatan,
        status: tempStatus,
        cargo: tempMuatan,
        pickuplocation: tempFilterLokasiPickup,
        destinationlocation: tempFilterLokasiDestinasi,
        province: listProvinci,
        headid: jenistruk,
        carrierid: jeniscarriertruk,
        orderBy: order,
        orderMode: modeorder,
        multiOrder: multiOrder,
        limit: limit.toString());
  }

  void filterAction(String type) {
    // listDataLelangMuatan.clear();
    // listcountDataLelangmuatan.clear();

    String startdatetxt = "";
    String enddatetxt = "";
    String startcreatedatetxt = "";
    String endcreatedatetxt = "";
    String startpickupdatetxt = "";
    String endpickupdatetxt = "";
    String startdestinasidatetxt = "";
    String enddestinasidatetxt = "";
    if (startDateFilterTanggalBuatController.value.text != "" &&
        endDateFilterTanggalBuatController.value.text != "") {
      var startdate =
          startDateFilterTanggalBuatController.value.text.split("/");
      var enddate = endDateFilterTanggalBuatController.value.text.split("/");
      startdatetxt = "${startdate[2]}-${startdate[1]}-${startdate[0]}";
      enddatetxt = "${enddate[2]}-${enddate[1]}-${enddate[0]}";
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (startDateFilterPeriodeLelangController.value.text != "" &&
        endDateFilterPeriodeLelangController.value.text != "") {
      var startcreateddate =
          startDateFilterPeriodeLelangController.value.text.split("/");
      var endcreateddate =
          endDateFilterPeriodeLelangController.value.text.split("/");
      startcreatedatetxt =
          "${startcreateddate[2]}-${startcreateddate[1]}-${startcreateddate[0]}";
      endcreatedatetxt =
          "${endcreateddate[2]}-${endcreateddate[1]}-${endcreateddate[0]}";
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (startDateFilterWaktuPickupController.value.text != "" &&
        endDateFilterWaktuPickupController.value.text != "") {
      var startpickupdate =
          startDateFilterWaktuPickupController.value.text.split("/");
      var endpickupdate =
          endDateFilterWaktuPickupController.value.text.split("/");
      startpickupdatetxt =
          "${startpickupdate[2]}-${startpickupdate[1]}-${startpickupdate[0]}";
      endpickupdatetxt =
          "${endpickupdate[2]}-${endpickupdate[1]}-${endpickupdate[0]}";
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (startDateFilterEstimasiKedatanganController.value.text != "" &&
        endDateFilterEstimasiKedatanganController.value.text != "") {
      var startdestinationdate =
          startDateFilterEstimasiKedatanganController.value.text.split("/");
      var enddestinationdate =
          endDateFilterEstimasiKedatanganController.value.text.split("/");
      startdestinasidatetxt =
          "${startdestinationdate[2]}-${startdestinationdate[1]}-${startdestinationdate[0]}";
      enddestinasidatetxt =
          "${enddestinationdate[2]}-${enddestinationdate[1]}-${enddestinationdate[0]}";
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (startJumlahKebutuhan.value.text != "" &&
        endJumlahKebutuhan.value.text != "") {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (startJumlahKoli.value.text != "" && endJumlahKoli.value.text != "") {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    var jenistruk = [];
    if (tempFilterJenisTruck.isNotEmpty) {
      tempFilterJenisTruck.forEach((element) {
        jenistruk.add(element["ID"]);
      });
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    var jeniscarriertruk = [];
    if (tempFilterJenisCarrier.isNotEmpty) {
      tempFilterJenisCarrier.forEach((element) {
        jeniscarriertruk.add(element["ID"]);
      });
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    var listProvinci = [];
    if (tempFilterProvince.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
        tempFilterProvince.forEach((element) {
          if (element["Code"] == null) {
            listProvinci.add(element["ID"]);
          } else {
            listProvinci.add(element["Code"]);
          }
        });
      }
      if (type == "history") {
        isFilterHistory.value = true;
        tempFilterProvince.forEach((element) {
          if (element["Code"] == null) {
            listProvinci.add(element["ID"]);
          } else {
            listProvinci.add(element["Code"]);
          }
        });
      }
    }

    if (tempFilterLokasiPickup.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (tempFilterLokasiDestinasi.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (tempJenisMuatan.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (tempStatus.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (tempMuatan.isNotEmpty) {
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    var length = '';
    var width = '';
    var height = '';
    var dimensionUnit = '';

    if (panjang.value.text != "") {
      length = '${tryParseFormattedDouble(panjang.value.text) ?? ''}';
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (lebar.value.text != "") {
      width = '${tryParseFormattedDouble(lebar.value.text) ?? ''}';
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (tinggi.value.text != "") {
      height = '${tryParseFormattedDouble(tinggi.value.text) ?? ''}';
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }
    if (length.isNotEmpty || width.isNotEmpty || height.isNotEmpty) {
      dimensionUnit = _selectedsatuandimensi.value;
    }

    String dimensi = "";
    if (panjang.value.text != "" ||
        lebar.value.text != "" ||
        tinggi.value.text != "") {
      dimensi = panjang.value.text.replaceAll('.', '') +
          "${panjang.value.text.isEmpty ? '0' : ''}" +
          "${panjang.value.text.contains(',') ? '' : ',00'}" +
          "*_*_*" +
          lebar.value.text.replaceAll('.', '') +
          "${lebar.value.text.isEmpty ? '0' : ''}" +
          "${lebar.value.text.contains(',') ? '' : ',00'}" +
          "*_*_*" +
          tinggi.value.text.replaceAll('.', '') +
          "${tinggi.value.text.isEmpty ? '0' : ''}" +
          "${tinggi.value.text.contains(',') ? '' : ',00'}" +
          " " +
          _selectedsatuandimensi.value;
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    String vol = "";
    if (volume.value.text != "") {
      vol = volume.value.text.replaceAll('.', '') +
          " " +
          _selectedsatuanvolume.value;
      if (type == "aktif") {
        isFilter.value = true;
      }
      if (type == "history") {
        isFilterHistory.value = true;
      }
    }

    if (startdatetxt == "" &&
        enddatetxt == "" &&
        startcreatedatetxt == "" &&
        endcreatedatetxt == "" &&
        startpickupdatetxt == "" &&
        endpickupdatetxt == "" &&
        startdestinasidatetxt == "" &&
        enddestinasidatetxt == "" &&
        startJumlahKebutuhan.value.text == "" &&
        endJumlahKebutuhan.value.text == "" &&
        startJumlahKoli.value.text == "" &&
        endJumlahKoli.value.text == "" &&
        tempFilterJenisTruck.isEmpty &&
        tempFilterJenisCarrier.isEmpty &&
        tempFilterLokasiPickup.isEmpty &&
        tempFilterLokasiDestinasi.isEmpty &&
        tempFilterProvince.isEmpty &&
        tempJenisMuatan.isEmpty &&
        tempStatus.isEmpty &&
        dimensi.isEmpty &&
        vol == "" &&
        tempMuatan.isEmpty) {
      if (type == "aktif") {
        isFilter.value = false;
      }
      if (type == "history") {
        isFilterHistory.value = false;
      }
    }

    var limit;
    if (type == "aktif") {
      limit = limitAktif.value;
    }
    if (type == "history") {
      limit = limitHistory.value;
    }

    getListLelangMuatan(type,
        filter: "true",
        search: "false",
        startdate: startcreatedatetxt,
        enddate: endcreatedatetxt,
        startcreateddate: startdatetxt,
        endcreateddate: enddatetxt,
        startpickupdate: startpickupdatetxt,
        endpickupdate: endpickupdatetxt,
        startdestinationdate: startdestinasidatetxt,
        enddestinationdate: enddestinasidatetxt,
        mintrukqty: startJumlahKebutuhan.value.text.replaceAll('.', ''),
        maxtrukqty: endJumlahKebutuhan.value.text.replaceAll('.', ''),
        minkoliqty: startJumlahKoli.value.text.replaceAll('.', ''),
        maxkoliqty: endJumlahKoli.value.text.replaceAll('.', ''),
        dimension: dimensi,
        length: length,
        width: width,
        height: height,
        dimensionUnit: dimensionUnit,
        volume: vol,
        idcargotype: tempJenisMuatan,
        status: tempStatus,
        cargo: tempMuatan,
        pickuplocation: tempFilterLokasiPickup,
        destinationlocation: tempFilterLokasiDestinasi,
        province: listProvinci,
        headid: jenistruk,
        carrierid: jeniscarriertruk,
        limit: limit.toString());
  }

  Widget _buttonPriorityPrimary(String type) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Color(ListColor.color4),
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        Get.back();
        filterAction(type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Stack(alignment: Alignment.center, children: [
          CustomText(
            "LelangMuatBuatLelangBuatLelangLabelTitleSave".tr,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
          ),
        ]),
      ),
    );
  }

  Widget _buttonPrioritySecondary() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        Get.back();
        resetFilter();
        // if (!disableGetBack) Get.back();
        // if (onTapPriority != null) onTapPriority();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Stack(alignment: Alignment.center, children: [
          CustomText("LelangMuatTabAktifTabAktifLabelTitleCancelFilter".tr,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.color4),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 12),
        ]),
      ),
    );
  }

  void getListFilter(String type) {
    langTemp = GlobalVariable.languageType;
    GlobalVariable.languageType = "id_ID";
    getListLokasiPickup();
    getListLokasiDestinasi();
    getListProvince();
    getListJenisTruck();
    getListJenisCarrierTruck();
    getListMuatan(type);
  }

  void getListMuatan(String type) async {
    // var resLoginAs = await ApiHelper(
    //         context: Get.context,
    //         isShowDialogLoading: false,
    //         isShowDialogError: false)
    //     .getUserShiper(GlobalVariable.role);

    // if (resLoginAs["Message"]["Code"] == 200) {
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListMuatan(GlobalVariable.role, loginAsVal.value, type);
    if (resultCity["Message"]["Code"] == 200) {
      listMuatan.clear();
      (resultCity["Data"]["Data"] as List).forEach((element) {
        listMuatan.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    // } else {
    //   failedGetListFilter.value = true;
    // }
  }

  void getListLokasiPickup() async {
    getListFilterLokasiPickup.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchSearchCity("");
    if (resultCity["Message"]["Code"] == 200) {
      listFilterLokasiPickup.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterLokasiPickup.add(element["City"]);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterLokasiPickup.value = false;
    if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListJenisTruck() async {
    getListFilterJenisTruck.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .listHeadTruck();
    if (resultCity["Message"]["Code"] == 200) {
      listFilterJenisTruck.clear();
      listFilterJenisTruckimg.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterJenisTruck.add(element["Description"]);
        listFilterJenisTruckimg.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterJenisTruck.value = false;
    // if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListJenisCarrierTruck() async {
    getListFilterJenisCarrier.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .listCarrierTruck();
    if (resultCity["Message"]["Code"] == 200) {
      listFilterJenisCarrier.clear();
      listFilterJenisCarrierimg.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterJenisCarrier.add(element["Description"]);
        listFilterJenisCarrierimg.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterJenisCarrier.value = false;
    // if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListLokasiDestinasi() async {
    getListFilterLokasiDestinasi.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchSearchCity("");
    if (resultCity["Message"]["Code"] == 200) {
      listFilterLokasiDestinasi.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterLokasiDestinasi.add(element["City"]);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterLokasiDestinasi.value = false;
    if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListProvince() async {
    getListFilterProvince.value = true;
    var resultProvince = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvince();
    if (resultProvince["Message"]["Code"] == 200) {
      listFilterProvince.clear();
      (resultProvince["Data"] as List).forEach((element) {
        listFilterProvince.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterProvince.value = false;
    if (!getListFilterLokasiPickup.value)
      GlobalVariable.languageType = langTemp;
    if (!getListFilterLokasiDestinasi.value)
      GlobalVariable.languageType = langTemp;
  }

  Widget wrapFilterProvinci(List listShow, List listSelected,
      void Function(bool isChoosen, dynamic value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));
    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrapProvinci(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrapProvinci(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget wrapFilter(List listShow, List listSelected,
      void Function(bool isChoosen, String value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));
    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrap(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrap(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget wrapFilterJenisTrukCarrier(List listShow, List listSelected,
      void Function(bool isChoosen, Map value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));

    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrapJenistruckCarrier(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrapJenistruckCarrier(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget itemWrapJenistruckCarrier(Map name, bool isChoosen,
      void Function(bool isChoosen, Map value) onTapItem) {
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: CustomText(
              name["Description"],
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  Widget wrapFilterMuatan(List listShow) {
    // var listNotSelected = List.from(listShow);
    // listNotSelected.removeWhere((element) => listSelected.contains(element));

    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        if (listShow.length > 5)
          for (var idx = 0; idx < 5; idx++) itemWrapMuatan(listShow[idx], idx)
        else
          for (var idx = 0; idx < listShow.length; idx++)
            itemWrapMuatan(listShow[idx], idx),
        if (listShow.length > 5)
          Container(
            // margin: EdgeInsets.symmetric(
            //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
            width: GlobalVariable.ratioWidth(Get.context) * 40,
            height: GlobalVariable.ratioWidth(Get.context) * 22,
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
            constraints: BoxConstraints(
                minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 22),
                color: Color(ListColor.color4)),
            child: CustomText("+5",
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
      ],
    );
  }

  Widget itemWrapMuatan(String name, int idx) {
    double borderRadius = 20;
    return Container(
      constraints: BoxConstraints(
          maxWidth: GlobalVariable.ratioWidth(Get.context) * 190),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(width: 1, color: Color(ListColor.color4)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            tempMuatan.removeWhere((element) => element == name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    child: CustomText(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: Color(ListColor.color4),
                    ),
                  ),
                ),
                SizedBox(
                  width: GlobalVariable.ratioFontSize(Get.context) * 4,
                ),
                Icon(
                  Icons.close_rounded,
                  size: GlobalVariable.ratioFontSize(Get.context) * 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemWrapProvinci(dynamic name, bool isChoosen,
      void Function(bool isChoosen, dynamic value) onTapItem) {
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: CustomText(
              name["Description"] ?? name["Nama"],
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemWrap(String name, bool isChoosen,
      void Function(bool isChoosen, String value) onTapItem) {
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: CustomText(
              name,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  void resetFilter() {
    startDateFilterTanggalBuatController.value.text = "";
    endDateFilterTanggalBuatController.value.text = "";
    startDateFilterPeriodeLelangController.value.text = "";
    endDateFilterPeriodeLelangController.value.text = "";
    startDateFilterWaktuPickupController.value.text = "";
    endDateFilterWaktuPickupController.value.text = "";
    startDateFilterEstimasiKedatanganController.value.text = "";
    endDateFilterEstimasiKedatanganController.value.text = "";
    startJumlahKebutuhan.value.text = "";
    endJumlahKebutuhan.value.text = "";
    _rangeValuesJmlKebutuhan.value = RangeValues(0.0, 1500.0);
    startJumlahKoli.value.text = "";
    endJumlahKoli.value.text = "";
    _rangeValuesJmlKoli.value = RangeValues(0.0, 1500.0);
    tempFilterLokasiPickup.clear();
    tempFilterLokasiDestinasi.clear();
    tempFilterProvince.clear();
    tempFilterJenisTruck.clear();
    tempFilterJenisTruckimg.clear();
    tempFilterJenisCarrier.clear();
    tempFilterJenisCarrierimg.clear();
    tempMuatan.clear();
    tempJenisMuatan.clear();
    tempStatus.clear();
    panjang.value.text = "";
    lebar.value.text = "";
    tinggi.value.text = "";
    _selectedsatuandimensi.value = "m";
    volume.value.text = "";
    _selectedsatuanvolume.value = "m3";
    iserorstartkebutuhan.value = "";
    iserorendkebutuhan.value = "";
    iserorstartkoli.value = "";
    iserorendkoli.value = "";
    iserorstartkebutuhankelebihan.value = "";
    iserorstartkolikelebihan.value = "";
    isSelectStartDateTglBuat.value = false;
    isSelectStartDatePeriodeLelang.value = false;
    isSelectStartDateWaktuPickup.value = false;
    isSelectStartDateEstimasiKedatangan.value = false;
    inisialDateEndPickerTglBuat = DateTime.now();
    inisialDateEndPickerPeriodeLelang = DateTime.now();
    inisialDateEndPickerWaktuPickup = DateTime.now();
    inisialDateEndPickerEstimasiKedatangan = DateTime.now();
  }

  void cariMuatan() async {
    var result =
        await GetToPage.toNamed<ZoListMuatanController>(Routes.ZO_LIST_MUATAN,
            arguments: [
              List.from(listMuatan.value),
              List.from(tempMuatan.value),
              "LelangMuatTabAktifTabAktifLabelTitleCargo".tr
            ],
            preventDuplicates: false);
    if (result != null) {
      tempMuatan.value = result;
    }
  }

  void showAllDestinasi() async {
    var result = await GetToPage.toNamed<ZoFilterLelangMuatanController>(
        Routes.ZO_FILTER_LELANG_MUATAN,
        arguments: [
          List.from(listFilterLokasiDestinasi.value),
          List.from(tempFilterLokasiDestinasi.value),
          "LelangMuatTabAktifTabAktifLabelTitleDestinationLocation".tr
        ],
        preventDuplicates: false);
    if (result != null) {
      tempFilterLokasiDestinasi.value = result;
    }
  }

  void showAllPickup() async {
    var result = await GetToPage.toNamed<ZoFilterLelangMuatanController>(
        Routes.ZO_FILTER_LELANG_MUATAN,
        arguments: [
          List.from(listFilterLokasiPickup.value),
          List.from(tempFilterLokasiPickup.value),
          "LelangMuatBuatLelangBuatLelangLabelTitleLokasiPickup".tr
        ],
        preventDuplicates: false);
    if (result != null) {
      tempFilterLokasiPickup.value = result;
    }
  }

  void showAllProvinsi() async {
    var result = await GetToPage.toNamed<ZoFilterLelangMuatanController>(
        Routes.ZO_FILTER_LELANG_MUATAN,
        arguments: [
          List.from(listFilterProvince.value),
          List.from(tempFilterProvince.value),
          "LelangMuatTabAktifTabAktifLabelTitleProvince".tr
        ],
        preventDuplicates: false);
    if (result != null) {
      tempFilterProvince.value = result;
    }
  }

  void showAllJenisTruck() async {
    var result =
        await GetToPage.toNamed<ZoFilterJenisTrukLelangMuatanController>(
            Routes.ZO_FILTER_JENIS_TRUK_LELANG_MUATAN,
            arguments: [
              List.from(listFilterJenisTruckimg.value),
              List.from(tempFilterJenisTruck.value),
              "LelangMuatTabAktifTabAktifLabelTitleTruckType".tr
            ],
            preventDuplicates: false);
    if (result != null) {
      tempFilterJenisTruck.value = result;
    }
  }

  void showAllJenisCarrierTruck() async {
    var result =
        await GetToPage.toNamed<ZoFilterJenisTrukLelangMuatanController>(
            Routes.ZO_FILTER_JENIS_TRUK_LELANG_MUATAN,
            arguments: [
              List.from(listFilterJenisCarrierimg.value),
              List.from(tempFilterJenisCarrier.value),
              "LelangMuatTabAktifTabAktifLabelTitleCarrierType".tr
            ],
            preventDuplicates: false);
    if (result != null) {
      tempFilterJenisCarrier.value = result;
    }
  }

  void onSaveFilter() {
    filterLokasiPickup.value = List.from(tempFilterLokasiPickup.value);
    filterLokasiDestinasi.value = List.from(tempFilterLokasiDestinasi.value);
    filterProvince.value = List.from(tempFilterProvince.value);
    tempFilterLokasiPickup.clear();
    tempFilterLokasiDestinasi.clear();
    tempFilterProvince.clear();
    // refreshData();
    Get.back();
  }

  _listseparator() {
    return Container(
        height: 0.5,
        color: Color(ListColor.colorLightGrey10),
        margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(Get.context) * 16,
            bottom: GlobalVariable.ratioWidth(Get.context) * 18));
  }

  _formFilterDate(String isController) {
    var isStartController;
    var isEndController;
    if (isController == "tanggalBuat") {
      isStartController = startDateFilterTanggalBuatController.value;
      isEndController = endDateFilterTanggalBuatController.value;
    }
    if (isController == "periodeLelang") {
      isStartController = startDateFilterPeriodeLelangController.value;
      isEndController = endDateFilterPeriodeLelangController.value;
    }
    if (isController == "waktuPickup") {
      isStartController = startDateFilterWaktuPickupController.value;
      isEndController = endDateFilterWaktuPickupController.value;
    }
    if (isController == "estimasiKedatangan") {
      isStartController = startDateFilterEstimasiKedatanganController.value;
      isEndController = endDateFilterEstimasiKedatanganController.value;
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CustomTextField(
                  key: ValueKey(isController),
                  context: Get.context,
                  readOnly: true,
                  onTap: () {
                    // _datetimeRangePicker(isController);
                    _datestartPicker(isController);
                  },
                  controller: isStartController,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: "hh/bb/tttt", // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      _datestartPicker(isController);
                      // controller.onClearSearch();
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: SvgPicture.asset("assets/ic_calendar.svg",
                            color: Colors.black,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24)),
                  )),
            ],
          ),
        ),
        SizedBox(
          width: GlobalVariable.ratioWidth(Get.context) * 19,
        ),
        Container(
          child: CustomText(
            "LelangMuatTabAktifTabAktifLabelTitleToDate".tr,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        SizedBox(
          width: GlobalVariable.ratioWidth(Get.context) * 19,
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CustomTextField(
                  key: ValueKey("end $isController"),
                  context: Get.context,
                  readOnly: true,
                  onTap: () {
                    // _datetimeRangePicker(isController);
                    if (isSelectStartDateTglBuat.value) {
                      _dateendPicker(isController);
                    } else if (isSelectStartDatePeriodeLelang.value) {
                      _dateendPicker(isController);
                    } else if (isSelectStartDateWaktuPickup.value) {
                      _dateendPicker(isController);
                    } else if (isSelectStartDateEstimasiKedatangan.value) {
                      _dateendPicker(isController);
                    }
                    // if (isSelectStartDatePeriodeLelang.value) {
                    //   _dateendPicker(isController);
                    // }
                    // if (isSelectStartDateWaktuPickup.value) {
                    //   _dateendPicker(isController);
                    // }
                    // if (isSelectStartDateEstimasiKedatangan.value) {
                    //   _dateendPicker(isController);
                    // }
                  },
                  controller: isEndController,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: "hh/bb/tttt", // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // _datetimeRangePicker(isController);
                      if (isSelectStartDateTglBuat.value) {
                        _dateendPicker(isController);
                      } else if (isSelectStartDatePeriodeLelang.value) {
                        _dateendPicker(isController);
                      } else if (isSelectStartDateWaktuPickup.value) {
                        _dateendPicker(isController);
                      } else if (isSelectStartDateEstimasiKedatangan.value) {
                        _dateendPicker(isController);
                      }
                      // controller.onClearSearch();
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: SvgPicture.asset("assets/ic_calendar.svg",
                            color: Colors.black,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24)),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  String formatThousand(num number) {
    if (number == null) return null;
    var format = number is int ? '#,###' : '#,###.###';
    var formattedOriginal = NumberFormat(format).format(number);
    var formatted = formattedOriginal;

    formatted = formatted.replaceAll(',', '.');
    if (formattedOriginal.contains('.')) {
      formatted = formatted.replaceFirst('.', ',', formatted.lastIndexOf('.'));
    }

    return formatted;
  }

  _formFilterRangeHargaJmlKebutuhan() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  CustomTextField(
                      key: ValueKey("startJumlahKebutuhan"),
                      context: Get.context,
                      controller: startJumlahKebutuhan.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        ark_global.DecimalInputFormatter(
                          digit: 10,
                          digitAfterComma: 0,
                          controller: startJumlahKebutuhan.value,
                        ),
                      ],
                      onChanged: (value) {
                        getVlidatoreror(value, "startkebutuhan");

                        if (int.parse(value.replaceAll('.', '')) >
                            int.parse(endJumlahKebutuhan.value.text == ""
                                ? "0"
                                : endJumlahKebutuhan.value.text
                                    .replaceAll('.', ''))) {
                          getValidateerorkelebihan("startkebutuhan");
                        } else {
                          iserorstartkebutuhankelebihan.value = "";
                        }

                        _rangeValuesJmlKebutuhan.value = RangeValues(
                          math.min(
                            1500,
                            math.min(
                              double.parse(value.replaceAll('.', '')),
                              _rangeValuesJmlKebutuhan.value.end,
                            ),
                          ),
                          _rangeValuesJmlKebutuhan.value.end,
                        );

                        // if (int.parse(value.replaceAll('.', '')) > 1500) {
                        // } else {
                        //   if (int.parse(_rangeValuesJmlKebutuhan.value.start
                        //           .toString()
                        //           .replaceAll('.', '')) <
                        //       int.parse(value.replaceAll('.', ''))) {
                        //   } else {
                        //     _rangeValuesJmlKebutuhan.value = RangeValues(
                        //         double.parse(value),
                        //         _rangeValuesJmlKebutuhan.value.end);
                        //   }
                        // }
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "0", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  if (iserorstartkebutuhan.value != "")
                    CustomText(
                      iserorstartkebutuhan.value,
                      color: Color(ListColor.colorRed),
                    ),
                  if (iserorstartkebutuhankelebihan.value != "")
                    CustomText(
                      iserorstartkebutuhankelebihan.value,
                      color: Color(ListColor.colorRed),
                    )
                ])),
            Container(
                height: 1,
                width: GlobalVariable.ratioWidth(Get.context) * 92,
                color: Color(ListColor.colorLightGrey10)),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  CustomTextField(
                      key: ValueKey("endJumlahKebutuhan"),
                      context: Get.context,
                      controller: endJumlahKebutuhan.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        ark_global.DecimalInputFormatter(
                          digit: 10,
                          digitAfterComma: 0,
                          controller: endJumlahKebutuhan.value,
                        ),
                      ],
                      onChanged: (value) {
                        getVlidatoreror(value, "endkebutuhan");

                        if (int.parse(startJumlahKebutuhan.value.text == ""
                                ? "0"
                                : startJumlahKebutuhan.value.text
                                    .replaceAll('.', '')) >
                            int.parse(value.replaceAll('.', ''))) {
                          getValidateerorkelebihan("endkebutuhan");
                        } else {
                          iserorstartkebutuhankelebihan.value = "";
                        }

                        _rangeValuesJmlKebutuhan.value = RangeValues(
                          _rangeValuesJmlKebutuhan.value.start,
                          math.min(
                            1500,
                            math.max(
                              _rangeValuesJmlKebutuhan.value.start,
                              double.parse(value.replaceAll('.', '')),
                            ),
                          ),
                        );

                        // if (int.parse(value) > 1500) {
                        // } else {
                        //   if (int.parse(_rangeValuesJmlKebutuhan.value.start
                        //           .toString()) <
                        //       int.parse(value)) {
                        //   } else {
                        //     _rangeValuesJmlKebutuhan.value = RangeValues(
                        //         _rangeValuesJmlKebutuhan.value.start,
                        //         double.parse(value));
                        //   }
                        // }
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "1.500", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  if (iserorendkebutuhan.value != "")
                    CustomText(
                      iserorendkebutuhan.value,
                      color: Color(ListColor.colorRed),
                    )
                ])),
          ],
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(Get.context) * 12,
        ),
        Obx(
          () => Container(
            child: SliderTheme(
              data: SliderThemeData(
                  trackHeight: 1,
                  activeTrackColor: Color(ListColor.colorBlue),
                  inactiveTrackColor: Color(ListColor.colorGrey),
                  thumbColor: Color(ListColor.colorWhite),
                  overlayShape: RoundSliderOverlayShape(
                      overlayRadius:
                          GlobalVariable.ratioWidth(Get.context) * 10),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0)),
              child: RangeSlider(
                min: 0,
                max: 1500,
                values: _rangeValuesJmlKebutuhan.value,
                onChanged: (values) {
                  _rangeValuesJmlKebutuhan.value = values;

                  startJumlahKebutuhan.value.text =
                      formatThousand(values.start.toInt());
                  endJumlahKebutuhan.value.text =
                      formatThousand(values.end.toInt());
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  _formFilterRangeHargaJmlKoli() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  CustomTextField(
                      key: ValueKey("startJumlahKoli"),
                      context: Get.context,
                      controller: startJumlahKoli.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        ark_global.DecimalInputFormatter(
                          digit: 10,
                          digitAfterComma: 0,
                          controller: startJumlahKoli.value,
                        ),
                      ],
                      onChanged: (value) {
                        getVlidatoreror(value, "startkoli");

                        if (int.parse(value.replaceAll('.', '')) >
                            int.parse(endJumlahKoli.value.text == ""
                                ? "0"
                                : endJumlahKoli.value.text
                                    .replaceAll('.', ''))) {
                          getValidateerorkelebihan("startkoli");
                        } else {
                          iserorstartkolikelebihan.value = "";
                        }

                        _rangeValuesJmlKoli.value = RangeValues(
                          math.min(
                            1500,
                            math.min(
                              double.parse(value.replaceAll('.', '')),
                              _rangeValuesJmlKoli.value.end,
                            ),
                          ),
                          _rangeValuesJmlKoli.value.end,
                        );

                        // if (int.parse(value) > 1500) {
                        // } else {
                        //   if (int.parse(
                        //           _rangeValuesJmlKoli.value.start.toString()) <
                        //       int.parse(value)) {
                        //   } else {
                        //     _rangeValuesJmlKoli.value = RangeValues(
                        //         double.parse(value),
                        //         _rangeValuesJmlKoli.value.end);
                        //   }
                        // }
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "0", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  if (iserorstartkoli.value != "")
                    CustomText(
                      iserorstartkoli.value,
                      color: Color(ListColor.colorRed),
                    ),
                  if (iserorstartkolikelebihan.value != "")
                    CustomText(
                      iserorstartkolikelebihan.value,
                      color: Color(ListColor.colorRed),
                    )
                ])),
            Container(
                height: 1,
                width: GlobalVariable.ratioWidth(Get.context) * 92,
                color: Color(ListColor.colorLightGrey10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    key: ValueKey("endJumlahKoli"),
                    context: Get.context,
                    controller: endJumlahKoli.value,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ark_global.DecimalInputFormatter(
                        digit: 10,
                        digitAfterComma: 0,
                        controller: endJumlahKoli.value,
                      ),
                    ],
                    onChanged: (value) {
                      getVlidatoreror(value, "endkoli");

                      if (int.parse(startJumlahKoli.value.text == ""
                              ? "0"
                              : startJumlahKoli.value.text
                                  .replaceAll('.', '')) >
                          int.parse(value.replaceAll('.', ''))) {
                        getValidateerorkelebihan("endkoli");
                      } else {
                        iserorstartkolikelebihan.value = "";
                      }

                      _rangeValuesJmlKoli.value = RangeValues(
                        _rangeValuesJmlKoli.value.start,
                        math.min(
                          1500,
                          math.max(
                            _rangeValuesJmlKoli.value.start,
                            double.parse(value.replaceAll('.', '')),
                          ),
                        ),
                      );

                      // if (int.parse(value) > 1500) {
                      // } else {
                      //   if (int.parse(
                      //           _rangeValuesJmlKoli.value.start.toString()) <
                      //       int.parse(value)) {
                      //   } else {
                      //     _rangeValuesJmlKoli.value = RangeValues(
                      //         _rangeValuesJmlKoli.value.start,
                      //         double.parse(value));
                      //   }
                      // }
                    },
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorLightGrey4),
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14),
                    newContentPadding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                        vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                    textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    newInputDecoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      hintText: "1.500", // "Cari Area Pick Up",
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(
                          color: Color(ListColor.colorLightGrey4),
                          fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (iserorendkoli.value != "")
                    CustomText(
                      iserorendkoli.value,
                      color: Color(ListColor.colorRed),
                    )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(Get.context) * 12,
        ),
        Obx(
          () => Container(
            child: SliderTheme(
              data: SliderThemeData(
                  trackHeight: 1,
                  activeTrackColor: Color(ListColor.colorBlue),
                  inactiveTrackColor: Color(ListColor.colorGrey),
                  thumbColor: Color(ListColor.colorWhite),
                  overlayShape: RoundSliderOverlayShape(
                      overlayRadius:
                          GlobalVariable.ratioWidth(Get.context) * 10),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0)),
              child: RangeSlider(
                min: 0,
                max: 1500,
                values: _rangeValuesJmlKoli.value,
                onChanged: (values) {
                  _rangeValuesJmlKoli.value = values;

                  startJumlahKoli.value.text =
                      formatThousand(values.start.toInt());
                  endJumlahKoli.value.text = formatThousand(values.end.toInt());
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  _formFilterLokasiPickUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                "LelangMuatBuatLelangBuatLelangLabelTitleLokasiPickup".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterLokasiPickup.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterLokasiPickup.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showAllPickup();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilter(
                listFilterLokasiPickup.value, tempFilterLokasiPickup.value,
                (bool onSelect, String value) {
              if (onSelect)
                tempFilterLokasiPickup.add(value);
              else
                tempFilterLokasiPickup.remove(value);
            }))
      ],
    );
  }

  _formFilterLokasiDestinasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                "LelangMuatTabAktifTabAktifLabelTitleDestinationLocation".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterLokasiDestinasi.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterLokasiDestinasi.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showAllDestinasi();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilter(listFilterLokasiDestinasi.value,
                tempFilterLokasiDestinasi.value, (bool onSelect, String value) {
              if (onSelect)
                tempFilterLokasiDestinasi.add(value);
              else
                tempFilterLokasiDestinasi.remove(value);
            }))
      ],
    );
  }

  _formFilterProvinsi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("LabelSortProvinceSaveLocation".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterProvince.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterProvince.length.toString(),
                      fontWeight: FontWeight.w600,
                      color: tempFilterProvince.isEmpty
                          ? Colors.transparent
                          : Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showAllProvinsi();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilterProvinci(
                listFilterProvince.value, tempFilterProvince.value,
                (bool onSelect, dynamic value) {
              if (onSelect)
                tempFilterProvince.add(value);
              else
                tempFilterProvince.remove(value);
            }))
      ],
    );
  }

  _formFilterJenisTruck() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("LelangMuatTabAktifTabAktifLabelTitleTruckType".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterJenisTruck.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterJenisTruck.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // showAll(0);
                    showAllJenisTruck();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilterJenisTrukCarrier(
                listFilterJenisTruckimg.value, tempFilterJenisTruck.value,
                (bool onSelect, Map value) {
              if (onSelect) {
                tempFilterJenisTruck.add(value);
              } else {
                tempFilterJenisTruck.remove(value);
              }
            }))
      ],
    );
  }

  _formFilterJenisCarrier() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("LelangMuatTabAktifTabAktifLabelTitleCarrierType".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterJenisCarrier.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterJenisCarrier.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // showAll(0);
                    showAllJenisCarrierTruck();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilterJenisTrukCarrier(
                listFilterJenisCarrierimg.value, tempFilterJenisCarrier.value,
                (bool onSelect, Map value) {
              if (onSelect)
                tempFilterJenisCarrier.add(value);
              else
                tempFilterJenisCarrier.remove(value);
            }))
      ],
    );
  }

  _jenismuatanForm(String name, int idx) {
    return Row(
      children: [
        CheckBoxCustom(
            size: GlobalVariable.ratioFontSize(Get.context) * 16,
            shadowSize: GlobalVariable.ratioFontSize(Get.context) * 19,
            isWithShadow: true,
            borderColor: Color(ListColor.color4),
            colorBG: Colors.white,
            border: 1,
            value: tempJenisMuatan.value.contains(name),
            onChanged: (value) {
              if (value) {
                tempJenisMuatan.add(name);
              } else {
                if (tempJenisMuatan.length == 1) {
                  tempJenisMuatan.clear();
                } else {
                  tempJenisMuatan.removeWhere((element) => element == name);
                }
              }
            }),
        Container(
          child: GestureDetector(
            onTap: () {
              if (!tempJenisMuatan.contains(name)) {
                tempJenisMuatan.add(name);
              } else {
                if (tempJenisMuatan.length == 1) {
                  tempJenisMuatan.clear();
                } else {
                  tempJenisMuatan.removeWhere((element) => element == name);
                }
              }
            },
            child: CustomText(
              name,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        )
      ],
    );
  }

  _formFilterMuatan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("LelangMuatTabAktifTabAktifLabelTitleCargo".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
              key: ValueKey("carimuatan"),
              context: Get.context,
              readOnly: true,
              onTap: () {
                cariMuatan();
              },
              onChanged: (value) {
                // controller.addTextSearchCity(value);
              },
              // controller:
              //     controller.searchTextEditingController.value,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                // controller.onSubmitSearch();
              },
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              newContentPadding: EdgeInsets.symmetric(
                  horizontal: 42,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 9),
              textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              newInputDecoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                hintText: "ex: Kardus", // "Cari Area Pick Up",
                fillColor: Color(ListColor.colorStroke).withOpacity(0.1),
                filled: true,
                hintStyle: TextStyle(
                    color: Color(ListColor.colorStroke),
                    fontWeight: FontWeight.w600),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(ListColor.colorLightGrey10), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(ListColor.colorLightGrey10), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(ListColor.colorLightGrey10), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 7),
              child: SvgPicture.asset(
                "assets/search_magnifition_icon.svg",
                width: GlobalVariable.ratioFontSize(Get.context) * 28,
                height: GlobalVariable.ratioFontSize(Get.context) * 28,
              ),
            ),
          ],
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(Get.context) * 12,
        ),
        Obx(() => wrapFilterMuatan(tempMuatan)),
        if (listMuatan.value.length > 0)
          if (listMuatan.value.length > limitMuatanView)
            for (var i = 0; i < limitMuatanView; i++)
              Row(children: [
                CheckBoxCustom(
                    borderColor: Color(ListColor.colorLightGrey14),
                    size: GlobalVariable.ratioFontSize(Get.context) * 16,
                    shadowSize: GlobalVariable.ratioFontSize(Get.context) * 19,
                    isWithShadow: true,
                    colorBG: Colors.white,
                    border: 1,
                    value:
                        tempMuatan.any((element) => element == listMuatan[i]),
                    onChanged: (value) {
                      onCheckMuatanFirst(i, value);
                    }),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                CustomText(
                  listMuatan.value[i],
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.colorLightGrey4),
                )
              ])
          else
            for (var i = 0; i < listMuatan.value.length; i++)
              Row(children: [
                CheckBoxCustom(
                    size: GlobalVariable.ratioFontSize(Get.context) * 16,
                    shadowSize: GlobalVariable.ratioFontSize(Get.context) * 19,
                    borderColor: Color(ListColor.colorLightGrey14),
                    isWithShadow: true,
                    border: 1,
                    colorBG: Colors.white,
                    value:
                        tempMuatan.any((element) => element == listMuatan[i]),
                    onChanged: (value) {
                      onCheckMuatanFirst(i, value);
                    }),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                CustomText(
                  listMuatan.value[i],
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.colorLightGrey4),
                )
              ]),
      ],
    );
  }

  _formFilterJenisMuatan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("LelangMuatBuatLelangBuatLelangLabelTitleJenisMuatan".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        for (var index = 0; index < listJenisMuatan.length; index++)
          _jenismuatanForm(listJenisMuatan[index], index),
      ],
    );
  }

  _formFilterStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("Status".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        for (var index = 0; index < listStatus.length; index++)
          _statusForm(listStatus[index]["val"],
              listStatus[index]["id"].toString(), index),
      ],
    );
  }

  _statusForm(String name, String id, int idx) {
    return Row(
      children: [
        CheckBoxCustom(
            size: GlobalVariable.ratioFontSize(Get.context) * 16,
            shadowSize: GlobalVariable.ratioFontSize(Get.context) * 19,
            isWithShadow: true,
            borderColor: Color(ListColor.color4),
            colorBG: Colors.white,
            border: 1,
            value: tempStatus.value.contains(id),
            onChanged: (value) {
              if (value) {
                tempStatus.add(id);
              } else {
                if (tempStatus.length == 1) {
                  tempStatus.clear();
                } else {
                  tempStatus.removeWhere((element) => element == id);
                }
              }
            }),
        Container(
          child: GestureDetector(
            onTap: () {
              if (!tempStatus.contains(id)) {
                tempStatus.add(id);
              } else {
                if (tempStatus.length == 1) {
                  tempStatus.clear();
                } else {
                  tempStatus.removeWhere((element) => element == id);
                }
              }
            },
            child: CustomText(
              name,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorLightGrey4),
            ),
          ),
        )
      ],
    );
  }

  _formFilterDimensiMuatanKoli() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                "LelangMuatBuatLelangBuatLelangLabelTitleDimensiMuatanKoli".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Container(
          // color: Colors.blue,
          width: MediaQuery.of(Get.context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  // width: GlobalVariable.ratioWidth(Get.context) * 228,
                  // width: MediaQuery.of(Get.context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color(ListColor.colorLightGrey19)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextField(
                            key: ValueKey("panjang"),
                            context: Get.context,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9\,]")),
                              ark_global.DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 3,
                                controller: panjang.value,
                              ),
                            ],
                            newContentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            controller: panjang.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            textSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            newInputDecoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey2)),
                              hintText:
                                  "LelangMuatTabAktifTabAktifLabelTitlePlaceholderLength"
                                      .tr,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            )),
                      ),
                      Container(
                        // width: GlobalVariable.ratioWidth(Get.context) * 36,
                        child: Center(
                          child: CustomText(
                            "x",
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            color: Color(ListColor.colorLightGrey4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                            key: ValueKey("lebar"),
                            context: Get.context,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9\,]")),
                              ark_global.DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 3,
                                controller: lebar.value,
                              ),
                            ],
                            newContentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            controller: lebar.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            textSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            newInputDecoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey2)),
                              hintText:
                                  "LelangMuatTabAktifTabAktifLabelTitlePlaceholderWidth"
                                      .tr,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            )),
                      ),
                      Container(
                        // width: GlobalVariable.ratioWidth(Get.context) * 36,
                        child: Center(
                          child: CustomText(
                            "x",
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            color: Color(ListColor.colorLightGrey4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                            key: ValueKey("tinggi"),
                            context: Get.context,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9\,]")),
                              ark_global.DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 3,
                                controller: tinggi.value,
                              ),
                            ],
                            newContentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            controller: tinggi.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            textSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            newInputDecoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey2)),
                              hintText:
                                  "LelangMuatTabAktifTabAktifLabelTitlePlaceholderHeight"
                                      .tr,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Container(
                  child: DropdownBelow(
                key: ValueKey("selectedsatuandimensi"),
                items: [
                  DropdownMenuItem(
                    child: CustomText("m",
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorLightGrey4)),
                    value: "m",
                  ),
                  DropdownMenuItem(
                    child: CustomText("cm",
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorLightGrey4)),
                    value: "cm",
                  )
                ],
                onChanged: (value) {
                  // controller.selectedDimensiKoli.value = value;
                  _selectedsatuandimensi.value = value;
                },
                itemWidth: 100,
                itemTextstyle: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w400,
                    color: Color(ListColor.colorLightGrey4)),
                boxTextstyle: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w400,
                    color: Color(ListColor.colorLightGrey4)),
                boxPadding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 8,
                    right: GlobalVariable.ratioWidth(Get.context) * 8),
                // boxPadding: EdgeInsets.symmetric(
                //     horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                //     vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                boxWidth: 100,
                // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 45,
                boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
                    GlobalVariable.ratioWidth(Get.context) * 13.5 +
                    GlobalVariable.ratioWidth(Get.context) * 13.5,
                boxDecoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: Color(ListColor.colorLightGrey19)),
                    borderRadius: BorderRadius.circular(6)),
                icon: Icon(Icons.keyboard_arrow_down_outlined,
                    color: Color(ListColor.colorLightGrey19)),
                hint: CustomText(_selectedsatuandimensi.value,
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    color: Color(ListColor.colorLightGrey4)),
                value: _selectedsatuandimensi.value,
              ))
              // Container(
              //     child: DropdownBelow(
              //   items: _dropdownSatuanDimensi,
              //   onChanged: onChangeDropdownSatuanDimensi,
              //   itemWidth: 100,
              //   itemTextstyle: TextStyle(
              //       fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
              //       fontWeight: FontWeight.w400,
              //       color: Color(ListColor.colorLightGrey4)),
              //   boxTextstyle: TextStyle(
              //       fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
              //       fontWeight: FontWeight.w400,
              //       color: Color(ListColor.colorLightGrey4)),
              //   boxPadding: EdgeInsets.fromLTRB(13, 12, 13, 12),
              //   boxWidth: 100,
              //   boxHeight: GlobalVariable.ratioWidth(Get.context) * 35,
              //   boxDecoration: BoxDecoration(
              //       color: Colors.transparent,
              //       border: Border.all(
              //           width: 1, color: Color(ListColor.colorLightGrey19)),
              //       borderRadius: BorderRadius.circular(6)),
              //   icon: Icon(Icons.keyboard_arrow_down_outlined,
              //       color: Color(ListColor.colorLightGrey19)),
              //   hint: Text(_selectedsatuandimensi.value),
              //   value: _selectedsatuandimensi.value,
              // ))
            ],
          ),
        )
      ],
    );
  }

  _formFilterVolume() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("LelangMuatTabAktifTabAktifLabelTitleVolume".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: CustomTextField(
                    key: ValueKey("volume"),
                    context: Get.context,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ark_global.DecimalInputFormatter(
                        digit: 10,
                        digitAfterComma: 0,
                        controller: volume.value,
                      ),
                    ],
                    newContentPadding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                        vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                    controller: volume.value,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                    textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    newInputDecoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey2)),
                      hintText:
                          "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderQty"
                              .tr,
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(ListColor.colorLightGrey19),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    )),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Container(
                  child: DropdownBelow(
                      key: ValueKey("selectedsatuanvolume"),
                      items: [
                        DropdownMenuItem(
                          child: Html(
                              style: {
                                "body": Style(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero)
                              },
                              data:
                                  '<span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 14}; color: #676767;">m<sup>3<sup></span'),

                          //  CustomText("m3",
                          //     fontWeight: FontWeight.w600,
                          //     fontSize:
                          //         GlobalVariable.ratioFontSize(Get.context) * 14,
                          //     color: Color(ListColor.colorLightGrey4)),
                          value: "m3",
                        ),
                        DropdownMenuItem(
                          child: CustomText("Lt",
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              color: Color(ListColor.colorLightGrey4)),
                          value: "Lt",
                        )
                      ],
                      onChanged: (value) {
                        _selectedsatuanvolume.value = value;
                      },
                      itemWidth: 100,
                      itemTextstyle: TextStyle(
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          fontWeight: FontWeight.w400,
                          color: Color(ListColor.colorLightGrey4)),
                      boxTextstyle: TextStyle(
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          fontWeight: FontWeight.w400,
                          color: Color(ListColor.colorLightGrey4)),
                      boxPadding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      // boxPadding: EdgeInsets.symmetric(
                      //     horizontal:
                      //         GlobalVariable.ratioWidth(Get.context) * 8,
                      //     vertical:
                      //         GlobalVariable.ratioWidth(Get.context) * 9),
                      boxWidth: 100,
                      // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 44,
                      boxHeight: GlobalVariable.ratioWidth(Get.context) * 12.5 +
                          GlobalVariable.ratioWidth(Get.context) * 12.5,
                      boxDecoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: Color(ListColor.colorLightGrey19)),
                          borderRadius: BorderRadius.circular(6)),
                      icon: Icon(Icons.keyboard_arrow_down_outlined,
                          color: Color(ListColor.colorLightGrey19)),
                      hint: _selectedsatuanvolume == "m3"
                          ? Html(
                              style: {
                                  "body": Style(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero)
                                },
                              data:
                                  '<span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 14}; color: #676767;">m<sup>3<sup></span')
                          : CustomText(_selectedsatuanvolume.value,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              color: Color(ListColor.colorLightGrey4)),
                      value: _selectedsatuanvolume.value))
              // Container(
              //     child: DropdownBelow(
              //   items: _dropdownSatuanVolume,
              //   onChanged: (value) {
              //     onChangeDropdownSatuanVolume(value);
              //   },
              //   itemWidth: 100,
              //   itemTextstyle: TextStyle(
              //       fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
              //       fontWeight: FontWeight.w400,
              //       color: Color(ListColor.colorLightGrey4)),
              //   boxTextstyle: TextStyle(
              //       fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
              //       fontWeight: FontWeight.w400,
              //       color: Color(ListColor.colorLightGrey4)),
              //   boxPadding: EdgeInsets.fromLTRB(13, 12, 13, 12),
              //   boxWidth: 100,
              //   boxHeight: GlobalVariable.ratioWidth(Get.context) * 35,
              //   boxDecoration: BoxDecoration(
              //       color: Colors.transparent,
              //       border: Border.all(
              //           width: 1, color: Color(ListColor.colorLightGrey19)),
              //       borderRadius: BorderRadius.circular(6)),
              //   icon: Icon(Icons.keyboard_arrow_down_outlined,
              //       color: Color(ListColor.colorLightGrey19)),
              //   hint: Text(_selectedsatuanvolume.value),
              //   value: _selectedsatuanvolume.value,
              // ))
            ],
          ),
        )
      ],
    );
  }

  _datestartPicker(String isForm) async {
    var inisialDateStartPicker = DateTime.now();
    if (isForm == "tanggalBuat") {
      inisialDateStartPicker = inisialDateStartPickerTglBuat;
    }
    if (isForm == "periodeLelang") {
      inisialDateStartPicker = inisialDateStartPickerPeriodeLelang;
    }
    if (isForm == "waktuPickup") {
      inisialDateStartPicker = inisialDateStartPickerWaktuPickup;
    }
    if (isForm == "estimasiKedatangan") {
      inisialDateStartPicker = inisialDateStartPickerEstimasiKedatangan;
    }
    var picked = await showDatePicker(
        context: Get.context,
        initialDate: inisialDateStartPicker,
        firstDate: DateTime(2000),
        lastDate: DateTime(2200));

    if (picked != null) {
      String isMonth = "";
      if (picked.month.toString().length > 1) {
        isMonth = "${picked.month}";
      } else {
        isMonth = "0${picked.month}";
      }

      String isDay = "";
      if (picked.day.toString().length > 1) {
        isDay = "${picked.day}";
      } else {
        isDay = "0${picked.day}";
      }

      if (isForm == "tanggalBuat") {
        inisialDateStartPickerTglBuat = picked;
        inisialDateEndPickerTglBuat = picked;
        isSelectStartDateTglBuat.value = true;
        startDateFilterTanggalBuatController.value.text =
            "$isDay/$isMonth/${picked.year}";
        if (firstdateTglBuat.isBefore(picked)) {
          firstdateTglBuat = picked;
          endDateFilterTanggalBuatController.value.text =
              "$isDay/$isMonth/${picked.year}";
        }
      }

      if (isForm == "periodeLelang") {
        inisialDateStartPickerPeriodeLelang = picked;
        inisialDateEndPickerPeriodeLelang = picked;
        isSelectStartDatePeriodeLelang.value = true;
        startDateFilterPeriodeLelangController.value.text =
            "$isDay/$isMonth/${picked.year}";
        if (firstdatePeriodeLelang.isBefore(picked)) {
          firstdatePeriodeLelang = picked;
          endDateFilterPeriodeLelangController.value.text =
              "$isDay/$isMonth/${picked.year}";
        }
      }

      if (isForm == "waktuPickup") {
        inisialDateStartPickerWaktuPickup = picked;
        inisialDateEndPickerWaktuPickup = picked;
        isSelectStartDateWaktuPickup.value = true;
        startDateFilterWaktuPickupController.value.text =
            "$isDay/$isMonth/${picked.year}";
        if (firstdateWaktuPickup.isBefore(picked)) {
          firstdateWaktuPickup = picked;
          endDateFilterWaktuPickupController.value.text =
              "$isDay/$isMonth/${picked.year}";
        }
      }
      if (isForm == "estimasiKedatangan") {
        inisialDateStartPickerEstimasiKedatangan = picked;
        inisialDateEndPickerEstimasiKedatangan = picked;
        isSelectStartDateEstimasiKedatangan.value = true;
        startDateFilterEstimasiKedatanganController.value.text =
            "$isDay/$isMonth/${picked.year}";
        if (firstdateEstimasiKedatangan.isBefore(picked)) {
          firstdateEstimasiKedatangan = picked;
          endDateFilterEstimasiKedatanganController.value.text =
              "$isDay/$isMonth/${picked.year}";
        }
      }
    }
  }

  _dateendPicker(String isForm) async {
    var inisialDateEndPicker = DateTime.now();
    var firstdate;
    if (isForm == "tanggalBuat") {
      inisialDateEndPicker = inisialDateEndPickerTglBuat;
      firstdate = firstdateTglBuat;
    }

    if (isForm == "periodeLelang") {
      inisialDateEndPicker = inisialDateEndPickerPeriodeLelang;
      firstdate = firstdatePeriodeLelang;
    }

    if (isForm == "waktuPickup") {
      inisialDateEndPicker = inisialDateEndPickerWaktuPickup;
      firstdate = firstdateWaktuPickup;
    }
    if (isForm == "estimasiKedatangan") {
      inisialDateEndPicker = inisialDateEndPickerEstimasiKedatangan;
      firstdate = firstdateEstimasiKedatangan;
    }
    var picked = await showDatePicker(
        context: Get.context,
        initialDate: firstdate == null ? inisialDateEndPicker : firstdate,
        firstDate: inisialDateEndPicker,
        lastDate: DateTime(2200));

    if (picked != null) {
      String isMonthend = "";
      if (picked.month.toString().length > 1) {
        isMonthend = "${picked.month}";
      } else {
        isMonthend = "0${picked.month}";
      }

      String isDayend = "";
      if (picked.day.toString().length > 1) {
        isDayend = "${picked.day}";
      } else {
        isDayend = "0${picked.day}";
      }

      if (isForm == "tanggalBuat") {
        firstdateTglBuat = picked;
        endDateFilterTanggalBuatController.value.text =
            "$isDayend/$isMonthend/${picked.year}";
      }

      if (isForm == "periodeLelang") {
        firstdatePeriodeLelang = picked;
        endDateFilterPeriodeLelangController.value.text =
            "$isDayend/$isMonthend/${picked.year}";
      }

      if (isForm == "waktuPickup") {
        firstdateWaktuPickup = picked;
        endDateFilterWaktuPickupController.value.text =
            "$isDayend/$isMonthend/${picked.year}";
      }
      if (isForm == "estimasiKedatangan") {
        firstdateEstimasiKedatangan = picked;
        endDateFilterEstimasiKedatanganController.value.text =
            "$isDayend/$isMonthend/${picked.year}";
      }
    }
  }

  // _datetimeRangePicker(String isForm) async {
  //   DateTimeRange picked = await showDateRangePicker(
  //       context: Get.context,
  //       firstDate: DateTime(DateTime.now().year - 5),
  //       lastDate: DateTime(DateTime.now().year + 5),
  //       // initialDateRange: DateTimeRange(
  //       //     start: DateTime.now(),
  //       //     end: DateTime(DateTime.now().year, DateTime.now().month,
  //       //         DateTime.now().day + 1)),
  //       builder: (context, child) {
  //         return Padding(
  //           padding: EdgeInsets.fromLTRB(
  //               GlobalVariable.ratioWidth(context) * 30,
  //               GlobalVariable.ratioWidth(context) * 100,
  //               GlobalVariable.ratioWidth(context) * 30,
  //               GlobalVariable.ratioWidth(context) * 100),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Expanded(
  //                 child: ConstrainedBox(
  //                   constraints: BoxConstraints(
  //                       maxHeight: MediaQuery.of(context).size.height),
  //                   child: child,
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });

  //   if (picked != null) {
  //     String isMonthend = "";
  //     if (picked.end.month.toString().length > 1) {
  //       isMonthend = "${picked.end.month}";
  //     } else {
  //       isMonthend = "0${picked.end.month}";
  //     }

  //     String isDayend = "";
  //     if (picked.end.day.toString().length > 1) {
  //       isDayend = "${picked.end.day}";
  //     } else {
  //       isDayend = "0${picked.end.day}";
  //     }

  //     String isMonth = "";
  //     if (picked.start.month.toString().length > 1) {
  //       isMonth = "${picked.start.month}";
  //     } else {
  //       isMonth = "0${picked.start.month}";
  //     }

  //     String isDay = "";
  //     if (picked.start.day.toString().length > 1) {
  //       isDay = "${picked.start.day}";
  //     } else {
  //       isDay = "0${picked.start.day}";
  //     }

  //     if (isForm == "tanggalBuat") {
  //       startDateFilterTanggalBuatController.value.text =
  //           "$isDay/$isMonth/${picked.start.year}";
  //       endDateFilterTanggalBuatController.value.text =
  //           "$isDayend/$isMonthend/${picked.end.year}";
  //     }

  //     if (isForm == "periodeLelang") {
  //       startDateFilterPeriodeLelangController.value.text =
  //           "$isDay/$isMonth/${picked.start.year}";
  //       endDateFilterPeriodeLelangController.value.text =
  //           "$isDayend/$isMonthend/${picked.end.year}";
  //     }

  //     if (isForm == "waktuPickup") {
  //       startDateFilterWaktuPickupController.value.text =
  //           "$isDay/$isMonth/${picked.start.year}";
  //       endDateFilterWaktuPickupController.value.text =
  //           "$isDayend/$isMonthend/${picked.end.year}";
  //     }
  //     if (isForm == "estimasiKedatangan") {
  //       startDateFilterEstimasiKedatanganController.value.text =
  //           "$isDay/$isMonth/${picked.start.year}";
  //       endDateFilterEstimasiKedatanganController.value.text =
  //           "$isDayend/$isMonthend/${picked.end.year}";
  //     }
  //   }
  // }

  Future<void> searchLelangMuatan(String type) async {
    var result = await GetToPage.toNamed<ZoSearchLelangMuatanController>(
        Routes.ZO_SEARCH_LELANG_MUATAN,
        arguments: [type],
        preventDuplicates: false);
    if (result != null) {
      getListLelangMuatan(type, limit: "10");
      // tempFilterLokasiDestinasi.value = result;
    }
  }

  Future<void> tutupLelang(String id, String type) async {
    // var resLoginAs = await ApiHelper(
    //         context: Get.context,
    //         isShowDialogLoading: false,
    //         isShowDialogError: false)
    //     .getUserShiper(GlobalVariable.role);

    // if (resLoginAs["Message"]["Code"] == 200) {
    var resTutupLelang = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .postCloseLelang(id, loginAsVal.value, GlobalVariable.role);

    if (resTutupLelang["Message"]["Code"] == 200) {
      CustomToast.show(
          context: Get.context,
          sizeRounded: 6,
          message: 'LelangMuatTabAktifTabAktifLabelTitleCloseBidLelang'.tr);
      getListLelangMuatan(type, limit: limitAktif.toString());
    }
    // }
  }

  Future<void> batalLelang(String id, String type) async {
    // var resLoginAs = await ApiHelper(
    //         context: Get.context,
    //         isShowDialogLoading: false,
    //         isShowDialogError: false)
    //     .getUserShiper(GlobalVariable.role);

    // if (resLoginAs["Message"]["Code"] == 200) {
    var resTutupLelang = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .postBatalLelang(id, loginAsVal.value, GlobalVariable.role);

    if (resTutupLelang["Message"]["Code"] == 200) {
      CustomToast.show(
          context: Get.context,
          sizeRounded: 6,
          message:
              'LelangMuatBuatLelangBuatLelangLabelTitleLelangBerhasilBatal'.tr);
      getListLelangMuatan(type, limit: limitAktif.toString());
    }
    // }
  }

  getNotifikasiListData() async {
    // var resLoginAs = await ApiHelper(
    //         context: Get.context,
    //         isShowDialogLoading: false,
    //         isShowDialogError: false)
    //     .getUserShiper(GlobalVariable.role);

    // if (resLoginAs["Message"]["Code"] == 200) {
    var resNotif = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListNotifikasi(loginAsVal.value, GlobalVariable.role);
    //resLoginAs["LoginAs"].toString()

    if (resNotif["Message"]["Code"] == 200) {
      listDataNotifikasi.clear();
      (resNotif["Data"]["data"] as List).forEach((element) {
        listDataNotifikasi.add(element);
        if (element["is_read"] == 0) {
          isNewNotif.value = true;
        } else {
          isNewNotif.value = false;
        }
      });
    }
    // }
  }

  toNotification() async {
    var res = await GetToPage.toNamed<ZoListNotifikasiShipperController>(
        Routes.ZO_LIST_NOTIFIKASI_SHIPPER,
        preventDuplicates: false,
        arguments: [List.from(listDataNotifikasi.value)]);
    if (res != null) {
      getNotifikasiListData();
    }
  }

  Future<void> toDetailLelangMuatan(
      String idLelang, String type, int page) async {
    var res = await GetToPage.toNamed<ZoDetailLelangMuatanController>(
        Routes.ZO_DETAIL_LELANG_MUATAN,
        preventDuplicates: false,
        arguments: [idLelang, page, type]);

    if (res != null) {
      if (res) {
        if (type == "aktif") {
          getListLelangMuatan(type, limit: limitAktif.toString());
        } else {
          getListLelangMuatan(type, limit: limitHistory.toString());
        }
      }
    }
  }

  Future<void> salinData(String idLelang) async {
    var res = await GetToPage.toNamed<ZoBuatLelangMuatanController>(
        Routes.ZO_BUAT_LELANG_MUATAN,
        preventDuplicates: false,
        arguments: [idLelang]);

    if (res != null) {
      // if (res) {
      //   getListLelangMuatan(type);
      // }
    }
  }

  Future<void> toBuatLelang(String type) async {
    var res = await GetToPage.toNamed<ZoBuatLelangMuatanController>(
        Routes.ZO_BUAT_LELANG_MUATAN,
        preventDuplicates: false,
        arguments: [""]);

    if (res != null) {
      if (res) {
        getListLelangMuatan(type, limit: limitAktif.toString());
      }
    }
  }

  toPesertaLelang(String idLelang, String type) async {
    var res = await GetToPage.toNamed<ZoPesertaLelangController>(
        Routes.ZO_PESERTA_LELANG,
        preventDuplicates: false,
        arguments: [idLelang, type]);

    if (res != null) {
      // if (res) {
      //   getListLelangMuatan(type);
      // }
    }
  }

  toPemenangLelang(String idLelang) async {
    Get.toNamed(Routes.ZO_PEMENANG_LELANG + "/$idLelang");
  }
}
