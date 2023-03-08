import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/core/controllers/filter_controller_custom.dart';
import 'package:muatmuat/app/core/controllers/global_animation_controller.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/search_area_pickup_response_model.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/detail_ltsm/detail_ltsm_controller.dart';
import 'package:muatmuat/app/modules/detail_ltsm/marker_truck.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'list_search_truck_siap_muat_model.dart';

class ListSearchTruckSiapMuatController extends GetxController {
  var filterSearch = "".obs;
  var sort = Map().obs;

  double get _positionPixelsMinimizeAllLocation =>
      MediaQuery.of(Get.context).size.height * 3 / 5;

  SortingController _sortingController;
  var listSort = [
    DataListSortingModel(
        "Nama Transporter", "transporter_name", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Area Pickup", "Address", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Posisi Truk", "truck_position", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "Ekspektasi Destinasi", "destinasi_text", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Jumlah Truk Siap Muat", "QtyOpen", "Paling Sedikit",
        "Paling Banyak", "".obs,
        isTitleASCFirst: false),
    // DataListSortingModel("Lainnya", "Lainnya", "A-Z", "Z-A", "".obs),
  ];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final int maximumLimit = 10;

  var listSnapping = [
    SnappingPosition.factor(
      positionFactor: 0.0,
      snappingCurve: Curves.easeOutExpo,
      snappingDuration: Duration(milliseconds: 300),
      grabbingContentOffset: GrabbingContentOffset.top,
    ),
    SnappingPosition.factor(
      positionFactor: 1,
      grabbingContentOffset: GrabbingContentOffset.bottom,
      snappingCurve: Curves.easeOutExpo, // Curves.easeInExpo,
      snappingDuration: Duration(milliseconds: 300),
    )
  ].obs;

  RxDouble currSheetPosition = 0.00.obs;

  List<WidgetFilterModel> listWidgetFilter = [
    WidgetFilterModel(
        label: ["Nama Transporter"],
        typeInFilter: TypeInFilter.NAME,
        keyParam: "name_transporter"),
    WidgetFilterModel(
        label: ["GlobalFIlterNumberOfTruck".tr],
        typeInFilter: TypeInFilter.UNIT,
        keyParam: "unit"),
    WidgetFilterModel(
        label: ["Area Pickup".tr],
        typeInFilter: TypeInFilter.AREA_PICKUP_SEARCH,
        keyParam: "pickup",
        customValue: ["Kota Surabaya", "Surabaya", "1105", "1", "3"]),
    WidgetFilterModel(
        label: ["Status", "GlobalFilterGoldenTransporter".tr],
        typeInFilter: TypeInFilter.SWITCH,
        keyParam: "is_gold")
  ];

  var showFilter = false.obs;

  var showImage = true.obs;
  var firstActive = true.obs;
  var secondActive = false.obs;
  var thirdActive = false.obs;
  LoadingAnimationController animationController;

  ContactPartnerModalSheetBottomController _contactModalBottomSheetController;

  var showLoading = true.obs;
  var mapController = MapController();
  PopupController popupController = PopupController();
  PopupController popupControllerAreaPickup = PopupController();
  var scrollController = ScrollController();
  FilterCustomController _filterController;

  var listMarker = [].obs;
  var listMarkerAreaPickup = [].obs;
  var searchResult = [].obs;
  var currentActiveMarker = 0.obs;
  var listSearchTrukSiapMuat = [].obs;

  Map<String, dynamic> _mapFilterData = {};

  var jumlahTruk = 0.obs;
  var areaPickup = "".obs;
  var districtPickup = "".obs;
  var cityPickup = "".obs;
  var latlngPickup = LatLng(-7.280783, 112.767224).obs;
  var destinasi = {}.obs;
  var jenisTruk = {}.obs;
  var jenisCarrier = {}.obs;
  var isUsingFilter = false.obs;
  var totalMaxTruk = 0.obs;
  var showRound = true.obs;

  var snappingController = SnappingSheetController();
  var showLoadingDetail = false.obs;

  @override
  void onInit() async {
    _contactModalBottomSheetController =
        Get.put(ContactPartnerModalSheetBottomController());
    _sortingController = Get.put(SortingController(
        listSort: listSort,
        enableCustomSort: false,
        onRefreshData: (map) async {
          sort.clear();
          sort.addAll(map);
          // isUsingSorting.value = _mapSort.length > 0;
          // _onRefreshSorting();
          await getListProcess(1);
        }));
    _filterController = Get.put(
        FilterCustomController(
            returnData: (map) async {
              _mapFilterData.clear();
              for (String key in map.keys.toList()) {
                if (key == "jenisTruk" ||
                    key == "jenisCarrier" ||
                    key == "pickup" ||
                    key == "destination") {
                  String value = map[key];
                  List<int> lvi = [];
                  if (value.isNotEmpty) {
                    List<String> lv = value.split(",");
                    for (String data in lv) {
                      lvi.add(int.parse(data));
                    }
                  }
                  map[key] = lvi;
                }
              }
              _mapFilterData.addAll(map);
              isUsingFilter.value = _mapFilterData.length > 0;
              await getListProcess(1);
            },
            listWidgetInFilter: listWidgetFilter),
        tag: "ListSearchLokasiTruckSiapMuat");
    animationController = Get.put(LoadingAnimationController(
        showImage, firstActive, secondActive, thirdActive));
    areaPickup.value = Get.arguments[0];
    cityPickup.value = Get.arguments[1];
    districtPickup.value = Get.arguments[2];
    latlngPickup.value = Get.arguments[3];
    destinasi.value = Get.arguments[4];
    jenisTruk.value = Get.arguments[5];
    jenisCarrier.value = Get.arguments[6];
    listMarkerAreaPickup.add(Marker(
        // width: GlobalVariable.ratioWidth(Get.context) * 25,
        // height: GlobalVariable.ratioHeight(Get.context) * 30,
        width: GlobalVariable.ratioWidth(Get.context) * 28,
        height: GlobalVariable.ratioWidth(Get.context) * 34,
        point: latlngPickup.value,
        builder: (ctx) => Container(
                child: Image(
              image: AssetImage("assets/marker_transporter_icon.png"),
            ))));
    await mapController.onReady;
    popupControllerAreaPickup.showPopupFor(listMarkerAreaPickup.first);
    mapController.move(listMarkerAreaPickup[0].point, GlobalVariable.zoomMap);
    await getListProcess(1);
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    Get.delete<LoadingAnimationController>();
    Get.delete<FilterCustomController>();
    Get.delete<SortingController>();
  }

  void showSort() {
    _sortingController.showSort();
  }

  void onCompleteBuildWidget() {
    listSnapping.add(SnappingPosition.pixels(
      positionPixels: MediaQuery.of(Get.context).size.height * 3 / 5,
      snappingCurve: Curves.easeOutExpo, // Curves.elasticOut,
      snappingDuration:
          Duration(milliseconds: 300), // Duration(milliseconds: 1750),
    ));
  }

  void optionGroupMitra(
      ListSearchTruckSiapMuatModel listSearchTruckSiapMuatModel, int index) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        context: Get.context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioHeight(context) * 3),
                  color: Color(ListColor.colorLightGrey16),
                  height: GlobalVariable.ratioHeight(context) * 3,
                  width: GlobalVariable.ratioWidth(context) * 38,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 14,
                      GlobalVariable.ratioHeight(Get.context) * 14,
                      GlobalVariable.ratioWidth(Get.context) * 18,
                      GlobalVariable.ratioHeight(Get.context) * 22),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Icon(Icons.close_rounded,
                              size:
                                  GlobalVariable.ratioHeight(Get.context) * 24),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      CustomText("PartnerManagementOpsi".tr,
                          color: Color(ListColor.colorBlue),
                          fontWeight: FontWeight.bold,
                          fontSize: 14)
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      Get.back();
                      openShowAll(listSearchTruckSiapMuatModel);
                    },
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 18,
                        vertical: GlobalVariable.ratioHeight(Get.context) * 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText("Lihat Semua Lokasi",
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                _lineSeparator(),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      Get.back();
                      popupController.hidePopup();
                      popupController.showPopupFor(listMarker[index]);
                      currentActiveMarker.value =
                          int.parse(listSearchTruckSiapMuatModel.id);
                      snappingController.snapToPosition(listSnapping[0]);
                      mapController.move(
                          listMarker[index].point, GlobalVariable.zoomMap);
                    },
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 18,
                        vertical: GlobalVariable.ratioHeight(Get.context) * 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText("Lihat Posisi Truk",
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                _lineSeparator(),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      showContact(listSearchTruckSiapMuatModel);
                    },
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 18,
                        vertical: GlobalVariable.ratioHeight(Get.context) * 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText("Hubungi", fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _lineSeparator() {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 18,
        ),
        height: GlobalVariable.ratioHeight(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10));
  }

  void showContact(ListSearchTruckSiapMuatModel listSearchTruckSiapMuatModel) {
    _contactModalBottomSheetController.showContact(
        "",
        transporterID: listSearchTruckSiapMuatModel.transporterID,
        onReceiveContact: (data) {
          listSearchTruckSiapMuatModel.contacts = data;
        });
  }

  void openDetailTransporter(
      ListSearchTruckSiapMuatModel listSearchTruckSiapMuatModel) {
    GetToPage.toNamed<TransporterController>(Routes.TRANSPORTER, arguments: [
      listSearchTruckSiapMuatModel.transporterID,
      listSearchTruckSiapMuatModel.namaTransporter,
      "",
      listSearchTruckSiapMuatModel.isGold
    ]);
    // Get.toNamed(Routes.TRANSPORTER, arguments: [
    //   listSearchTruckSiapMuatModel.transporterID,
    //   listSearchTruckSiapMuatModel.namaTransporter,
    //   "",
    //   listSearchTruckSiapMuatModel.isGold
    // ]);
  }

  void openDetailLokasi(
      ListSearchTruckSiapMuatModel listSearchTruckSiapMuatModel) async {
    if (DateTime.now().isAfter(
        listSearchTruckSiapMuatModel.lastUpdate.add(Duration(hours: 24)))) {
      showExpired();
    } else {
      // showLoadingDetail.value = true;
      // var check = await checkAvailable(listSearchTruckSiapMuatModel);
      // showLoadingDetail.value = false;
      var check = true;
      if (check) {
        GetToPage.toNamed<DetailLTSMController>(Routes.DETAIL_LTSM, arguments: [
          true,
          MarkerTruck(
            baseLTSMMarkerModel: BaseLTSMMarkerModel(
              id: listSearchTruckSiapMuatModel.id,
              kode: listSearchTruckSiapMuatModel.kode,
              destinasi: listSearchTruckSiapMuatModel.ekspektasiDestinasi,
              truck: listSearchTruckSiapMuatModel.truck,
              address: listSearchTruckSiapMuatModel.areaPickup,
              lastUpdate: listSearchTruckSiapMuatModel.lastUpdateTanggal +
                  " " +
                  listSearchTruckSiapMuatModel.lastUpdateWaktu,
              lastUpdateWaktu: listSearchTruckSiapMuatModel.lastUpdateWaktu,
              lastUpdateRaw: listSearchTruckSiapMuatModel.lastUpdate,
              jumlahTruk:
                  listSearchTruckSiapMuatModel.jumlahTruk.toString(),
              siapMuat: listSearchTruckSiapMuatModel.siapMuat.toString(),
              sudahDipesan:
                  listSearchTruckSiapMuatModel.sudahDipesan.toString(),
              posisiTruk: listSearchTruckSiapMuatModel.posisiTruk,
              truckPosition: listSearchTruckSiapMuatModel.posisiTruk,
              cityTransporter: listSearchTruckSiapMuatModel.kotaTransporter,
              transporterEmail:
                  listSearchTruckSiapMuatModel.emailTransporter,
              transporterName: listSearchTruckSiapMuatModel.namaTransporter,
              transporterID: listSearchTruckSiapMuatModel.transporterID,
              isGold: listSearchTruckSiapMuatModel.isGold,
              lat: listSearchTruckSiapMuatModel.latitude,
              lng: listSearchTruckSiapMuatModel.longitude,
              // isChoosen: bmm.isChoosen,
              // onTapWhenChoose: bmm.onTapWhenChoose,
              contact: listSearchTruckSiapMuatModel.contacts, 
              onTapWhenChoose: null,
            )),
          ],
        );
        // Get.toNamed(Routes.DETAIL_LTSM, arguments: [
        //   true,
        //   MarkerTruck(
        //       baseLTSMMarkerModel: BaseLTSMMarkerModel(
        //           id: listSearchTruckSiapMuatModel.id,
        //           kode: listSearchTruckSiapMuatModel.kode,
        //           destinasi: listSearchTruckSiapMuatModel.ekspektasiDestinasi,
        //           truck: listSearchTruckSiapMuatModel.truck,
        //           address: listSearchTruckSiapMuatModel.areaPickup,
        //           lastUpdate: listSearchTruckSiapMuatModel.lastUpdateTanggal +
        //               " " +
        //               listSearchTruckSiapMuatModel.lastUpdateWaktu,
        //           lastUpdateWaktu: listSearchTruckSiapMuatModel.lastUpdateWaktu,
        //           lastUpdateRaw: listSearchTruckSiapMuatModel.lastUpdate,
        //           jumlahTruk:
        //               listSearchTruckSiapMuatModel.jumlahTruk.toString(),
        //           siapMuat: listSearchTruckSiapMuatModel.siapMuat.toString(),
        //           sudahDipesan:
        //               listSearchTruckSiapMuatModel.sudahDipesan.toString(),
        //           posisiTruk: listSearchTruckSiapMuatModel.posisiTruk,
        //           truckPosition: listSearchTruckSiapMuatModel.posisiTruk,
        //           cityTransporter: listSearchTruckSiapMuatModel.kotaTransporter,
        //           transporterEmail:
        //               listSearchTruckSiapMuatModel.emailTransporter,
        //           transporterName: listSearchTruckSiapMuatModel.namaTransporter,
        //           transporterID: listSearchTruckSiapMuatModel.transporterID,
        //           isGold: listSearchTruckSiapMuatModel.isGold,
        //           lat: listSearchTruckSiapMuatModel.latitude,
        //           lng: listSearchTruckSiapMuatModel.longitude,
        //           // isChoosen: bmm.isChoosen,
        //           // onTapWhenChoose: bmm.onTapWhenChoose,
        //           contact: listSearchTruckSiapMuatModel.contacts))
        // ]);
      } else {
        showExpired();
      }
    }
  }

  void showExpired() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        message: "Data telah expired. Silahkan melihat data lain.",
        title: "",
        labelButtonPriority1: "Oke");
  }

  void openShowAll(ListSearchTruckSiapMuatModel listSearchTruckSiapMuatModel) {
    GetToPage.toNamed<DetailLTSMController>(Routes.DETAIL_LTSM, arguments: [
      false,
      listSearchTruckSiapMuatModel.transporterID,
      listSearchTruckSiapMuatModel.namaTransporter,
      listSearchTruckSiapMuatModel.isGold
    ]);
    // Get.toNamed(Routes.DETAIL_LTSM, arguments: [
    //   false,
    //   listSearchTruckSiapMuatModel.transporterID,
    //   listSearchTruckSiapMuatModel.namaTransporter,
    //   listSearchTruckSiapMuatModel.isGold
    // ]);
  }

  Marker addMarker(int listTruckID, LatLng latlong) {
    return Marker(
        // width: GlobalVariable.ratioWidth(Get.context) * 25,
        // height: GlobalVariable.ratioHeight(Get.context) * 30,
        width: GlobalVariable.ratioWidth(Get.context) * 28,
        height: GlobalVariable.ratioWidth(Get.context) * 34,
        point: latlong,
        builder: (ctx) => Container(
            child: GestureDetector(
                onTap: () {
                  if (listTruckID == currentActiveMarker.value) {
                    currentActiveMarker.value = 0;
                    popupController.hidePopup();
                  } else {
                    popupController.hidePopup();
                    var index = listSearchTrukSiapMuat.indexWhere((element) =>
                        element.id.toString() == listTruckID.toString());
                    popupController.showPopupFor(listMarker[index]);
                    currentActiveMarker.value = listTruckID;
                  }
                },
                child: Obx(() => Image(
                    image: AssetImage(currentActiveMarker.value == listTruckID
                        ? "assets/marker_area_pickup_active.png"
                        : "assets/marker_area_pickup_nonactive.png"))))));
  }

  Future getListProcess(int page) async {
    showLoading.value = page == 1;
    await getMaxTrukValue();
    await getListSearchTruck(page);
    await _setCameraFitBoundsCustom(
        // List.from(listMarker.value).map((e) => (e as Marker).point).toList(),
        List.from(listMarkerAreaPickup.value)
            .map((e) => (e as Marker).point)
            .toList(),
        paddingBottom: _positionPixelsMinimizeAllLocation + 50);
    showLoading.value = false;
  }

  Future _setCameraFitBoundsCustom(List<LatLng> points,
      {double paddingBottom = 30}) async {
    await mapController.onReady;
    if (points.length > 0) {
      mapController.fitBounds(LatLngBounds.fromPoints(points),
          options: FitBoundsOptions(
              padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, paddingBottom)));
    }
  }

  Future<void> getMaxTrukValue() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAreaPickupSearch(
            cityPickup.value,
            districtPickup.value,
            destinasi.keys.first.toString(),
            jenisTruk.keys.first.toString(),
            jenisCarrier.keys.first.toString());
    try {
      if (result != null) {
        SearchAreaPickupFilteResponseModel searchAreaPickupResponseModel =
            // SearchAreaPickupFilteResponseModel.fromJson(result);
            SearchAreaPickupFilteResponseModel.fromJson(result, "");
        if (searchAreaPickupResponseModel.message.code == 200) {
          totalMaxTruk.value = searchAreaPickupResponseModel.maxTruk;
        }
      }
    } catch (err) {
      showLoading.value = false;
    }
  }

  Future<bool> checkAvailable(
      ListSearchTruckSiapMuatModel listSearchTruckSiapMuatModel,
      int page) async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListSearchTruckSiapMuat(
            page.toString(),
            maximumLimit.toString(),
            areaPickup.value,
            cityPickup.value,
            districtPickup.value,
            destinasi.keys.first.toString(),
            jenisTruk.keys.first.toString(),
            jenisCarrier.keys.first.toString(),
            sort.value,
            _mapFilterData,
            search: listSearchTruckSiapMuatModel.kode);
    try {
      if (result != null) {
        return ((result["Data"] as List).isNotEmpty);
      } else {
        return false;
      }
    } catch (err) {
      showLoadingDetail.value = false;
    }
    return false;
  }

  Future<void> getListSearchTruck(int page) async {
    showLoading.value = page == 1;
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListSearchTruckSiapMuat(
            page.toString(),
            maximumLimit.toString(),
            areaPickup.value,
            cityPickup.value,
            districtPickup.value,
            destinasi.keys.first.toString(),
            jenisTruk.keys.first.toString(),
            jenisCarrier.keys.first.toString(),
            sort.value,
            _mapFilterData);
    if (result != null) {
      if (page == 1) {
        listSearchTrukSiapMuat.clear();
        listMarker.clear();
      }
      // var jumlah = 0;  
      (result["Data"] as List).forEach((element) {
        jumlahTruk.value += int.parse(element["JumlahTruk"]);
        var listSearch = ListSearchTruckSiapMuatModel.fromJson(element);
        // jumlah += listSearch.siapMuat;
        listSearchTrukSiapMuat.add(listSearch);
        listMarker.add(addMarker(int.parse(listSearch.id),
            LatLng(listSearch.latitude, listSearch.longitude)));
      });
      // if (page == 1) {
      //   jumlahTruk.value = jumlah;
      // } else {
      //   jumlahTruk.value += jumlah;
      // }
      if (refreshController != null) {
        if (page == 1) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else
          refreshController.loadComplete();

        if ((result["Data"] as List).length < maximumLimit)
          refreshController.loadNoData();
      }
    } else {
      showLoading.value = false;
      if (refreshController != null) {
        if (page == 1) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else
          refreshController.loadComplete();

        if ((result["Data"] as List).length < maximumLimit)
          refreshController.loadNoData();
      }
    }
  }

  void showFilterOption() {
    _filterController.updateListFilterModel(
        1,
        WidgetFilterModel(
            label: ["GlobalFIlterNumberOfTruck".tr],
            typeInFilter: TypeInFilter.UNIT,
            keyParam: "unit",
            customValue: [0.0, double.parse(totalMaxTruk.value.toString())]));
    _filterController.updateListFilterModel(
        2,
        WidgetFilterModel(
            label: ["Area Pickup".tr],
            typeInFilter: TypeInFilter.AREA_PICKUP_SEARCH,
            keyParam: "pickup",
            customValue: [
              cityPickup.value,
              districtPickup.value,
              destinasi.keys.first.toString(),
              jenisTruk.keys.first.toString(),
              jenisCarrier.keys.first.toString()
            ]));
    _filterController.showFilter();
  }
}
