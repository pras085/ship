import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/core/controllers/filter_controller_custom.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/search_area_pickup_response_model.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/detail_ltsm/detail_ltsm_response_model.dart';
import 'package:muatmuat/app/modules/detail_ltsm/marker_truck.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class DetailLTSMController extends GetxController {
  final mapController = MapController().obs;

  ScrollController scrollController = ScrollController();

  ContactPartnerModalSheetBottomController _contactModalBottomSheetController;

  SnappingSheetController snappingSheetController = SnappingSheetController();

  final isSnippingAtEnd = false.obs;
  final isShowDetail = false.obs;
  final isShowDetailMarker = false.obs;
  final isUsingSort = false.obs;
  final isUsingFilter = false.obs;

  PopupController popupController = PopupController();

  final listMarker = [].obs;
  List<MarkerTruck> _listMarkerBackup = [];

  // final listSnapPosition = [].obs;

  List<SnappingPosition> get listSnapLocation => [
    SnappingPosition.factor(
      positionFactor: 0.0,
      snappingCurve: Curves.easeOutExpo,
      snappingDuration: Duration(milliseconds: 300),
      grabbingContentOffset: GrabbingContentOffset.top,
    ),
    SnappingPosition.pixels(
      positionPixels: isDetailLocationOnly.value ? 343 : 386,
      grabbingContentOffset: GrabbingContentOffset.bottom,
      snappingCurve: Curves.easeOutExpo, // Curves.easeInExpo,
      snappingDuration: Duration(milliseconds: 300),
    )
  ];

  // List<SnappingPosition> _listSnapAllLocation = [
  //   SnappingPosition.factor(
  //     positionFactor: 0.0,
  //     snappingCurve: Curves.easeOutExpo,
  //     snappingDuration: Duration(milliseconds: 300),
  //     grabbingContentOffset: GrabbingContentOffset.top,
  //   ),
  //   SnappingPosition.factor(
  //     positionFactor: 1,
  //     grabbingContentOffset: GrabbingContentOffset.bottom,
  //     snappingCurve: Curves.easeOutExpo, // Curves.easeInExpo,
  //     snappingDuration: Duration(milliseconds: 300),
  //   )
  // ];

  // List<SnappingPosition> _listSnapDetailLocation = [
  //   SnappingPosition.factor(
  //       positionFactor: 0.0, grabbingContentOffset: GrabbingContentOffset.top),
  //   SnappingPosition.pixels(
  //       positionPixels: 430,
  //       grabbingContentOffset: GrabbingContentOffset.bottom)
  // ];

  bool _firstInit = true;
  bool _isMinimizeMode = true;
  var isDetailLocationOnly = false.obs;
  bool isGoldTransporter = false;
  final isShowLoadingManual = false.obs;

  int _maxTruck = 0;

  double _positionSnapping = 0;

  String transporterName = "";
  String transporterID = "";

  SortingController _sortingController;
  List<DataListSortingModel> allLocationSort = [
    DataListSortingModel("Kode", "DocNumber", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LTSMSLabelPickupArea".tr, "Address", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LTSMSLabelTruckPosition".tr, "truck_position", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LTSMSLabelDestination".tr, "destinasi_text", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Jenis Truk".tr, "truk_text", "Z-A", "A-Z", "".obs,
        isTitleASCFirst: false),
    DataListSortingModel("LTSMSLabelNumberOfTruck".tr, "QtyOpen",
        "LTSMSLabelLeast".tr, "LTSMSLabelMost".tr, "".obs,
        isTitleASCFirst: false),
  ];

  List<WidgetFilterModel> listWidgetFilter = [
    WidgetFilterModel(
        label: ["LTSMSLabelNumTruck".tr],
        typeInFilter: TypeInFilter.UNIT,
        keyParam: "unit",
        customValue: [0.0, 0.0]
        //costumValue: [true],
        ),
    WidgetFilterModel(
        label: ["LTSMSLabelPickupArea".tr],
        typeInFilter: TypeInFilter.AREA_PICKUP_TRANSPORTER,
        keyParam: "pickup",
        customValue: ["0"]),
    WidgetFilterModel(
        label: ["LTSMSLabelDestination".tr],
        typeInFilter: TypeInFilter.CITY,
        keyParam: "destination"),
    WidgetFilterModel(
        label: ["LTSMSLabelTypeOfTruck".tr],
        typeInFilter: TypeInFilter.TRUCK,
        keyParam: "jenisTruk"),
    WidgetFilterModel(
        label: ["LTSMSLabelTypeOfCarrier".tr],
        typeInFilter: TypeInFilter.CARRIER,
        keyParam: "jenisCarrier"),
  ];

  final _keyDialog = GlobalKey<State>();

  FilterCustomController _filtercontroller;

  Map<String, dynamic> _mapSort = {};
  Map<String, dynamic> _mapFilter = {};

  double get _positionPixelsMinimizeAllLocation =>
      MediaQuery.of(Get.context).size.height * 2 / 3;

  @override
  void onInit() async {
    super.onInit();
    // _listSnapAllLocation.insert(
    //     1,
    //     SnappingPosition.pixels(
    //         positionPixels: _positionPixelsMinimizeAllLocation,
    //         grabbingContentOffset: GrabbingContentOffset.bottom));
    // listSnapLocation.clear();
    // listSnapLocation.addAll(_listSnapAllLocation);
    var argms = Get.arguments;
    // transporterID = "14";
    // transporterName = "Asia Mart Center";
    // isGoldTransporter = true;

    isDetailLocationOnly.value = argms[0];
    if (isDetailLocationOnly.value) {
      MarkerTruck markerTruck = argms[1];
      markerTruck.baseLTSMMarkerModel.onTapWhenChoose = hideAllPopUp;
      listMarker.add(markerTruck);
      transporterID = markerTruck.baseLTSMMarkerModel.transporterID;
      transporterName = markerTruck.baseLTSMMarkerModel.transporterName;
      isGoldTransporter = markerTruck.baseLTSMMarkerModel.isGold;
      await mapController.value.onReady;
      mapController.value.move(markerTruck.point, GlobalVariable.zoomMap);
      popupController.showPopupFor(listMarker[0]);
    } else {
      transporterID = argms[1];
      transporterName = argms[2];
      isGoldTransporter = argms[3];
    }
    listWidgetFilter[0] = WidgetFilterModel(
        label: ["LTSMSLabelNumTruck".tr],
        typeInFilter: TypeInFilter.UNIT,
        keyParam: "unit",
        customValue: [0.0, 0.0, _getMaxTruck]
        //costumValue: [true],
        );
    listWidgetFilter[1] = WidgetFilterModel(
        label: ["LTSMSLabelPickupArea".tr],
        typeInFilter: TypeInFilter.AREA_PICKUP_TRANSPORTER,
        keyParam: "pickup",
        customValue: [transporterID]);

    _sortingController = Get.put(
        SortingController(
            listSort: allLocationSort,
            enableCustomSort: false,
            onRefreshData: (map) {
              _mapSort.clear();
              _mapSort.addAll(map);
              isUsingSort.value = _mapSort.length > 0;
              isShowLoadingManual.value = true;
              _getDataAllLocation();
            }),
        tag: "DetailLTSM");
    _contactModalBottomSheetController =
        Get.put(ContactPartnerModalSheetBottomController(), tag: "DetailLTSM");
    _filtercontroller = Get.put(
        FilterCustomController(
            returnData: (map) {
              _mapFilter.clear();
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
              _mapFilter.addAll(map);
              isUsingFilter.value = _mapFilter.length > 0;
              isShowLoadingManual.value = true;
              _getDataAllLocation();
            },
            listWidgetInFilter: listWidgetFilter),
        tag: "DetailLTSM");
  }

  Future<bool> _getDataAllLocationWithoutErrorDialog() async {
    return await _getDataAllLocation(isShowDialogError: false);
  }

  List<Future Function()> _listFunctionOnComplete = [];
  int _indexFunctionOnComplete = 0;
  void onCompleteBuildWidget() async {
    if (_firstInit) {
      _firstInit = false;
      _listFunctionOnComplete = [
        _getDataAllLocationWithoutErrorDialog,
        //_getMaxTruck
      ];

      //listMarker[0].baseLTSMMarkerModel.isChoosen = true;
      if (isDetailLocationOnly.value) {
        listMarker.refresh();
        checkDetail(listMarker[0]);
      } else {
        // _showDialogLoading();
        // bool isError = false;
        // for (int i = _indexFunctionOnComplete;
        //     i < _listFunctionOnComplete.length;
        //     i++) {
        //   _indexFunctionOnComplete = i;
        //   var result = await _listFunctionOnComplete[i]();
        //   if (!result) {
        //     isError = true;
        //     break;
        //   }
        // }
        // Get.back();
        // if (isError) {
        //   GlobalAlertDialog.showDialogError(
        //     title: "Error",
        //     message: "LTSMSFailedGetData".tr,
        //     labelButtonPriority1: "GlobalButtonTryAgain".tr, labelButtonPriority2: "GlobalButtonCancel".tr, l
        //   );
        // }

        // if (!await _getDataAllLocation()) {
        //   Get.back();
        //   return;
        // }
        // await _getMaxTruck();

        // listMarker.addAll([
        //   MarkerTruck(
        //       baseLTSMMarkerModel: BaseLTSMMarkerModel(
        //           truck: "pertama",
        //           destinasi: "desc pertama",
        //           lat: -7.280186794277672,
        //           lng: 112.74147525005432,
        //           onTapWhenChoose: () {
        //             hideAllPopUp();
        //           })),
        //   MarkerTruck(
        //       baseLTSMMarkerModel: BaseLTSMMarkerModel(
        //           truck: "kedua",
        //           destinasi: "desc kedua",
        //           lat: -7.274381138462091,
        //           lng: 112.72542586235572,
        //           onTapWhenChoose: () {
        //             hideAllPopUp();
        //           })),
        // ]);
        _getDataOnComplete(() {
          //Get.back();
          if (listMarker.length == 0) {
            GlobalAlertDialog.showAlertDialogCustom(
                context: Get.context,
                isDismissible: false,
                isShowCloseButton: false,
                title: "Warning",
                message: "There is no data",
                labelButtonPriority1: 'OK',
                onTapPriority1: () {
                  Get.back();
                });
          } else {
            _listMarkerBackup = List.from(listMarker
                .map((element) => MarkerTruck.copy(element as MarkerTruck))
                .toList());
            listMarker.refresh();
            _setCameraFitBoundsCustom(
                listMarker
                    .map((e) => LatLng(
                        e.baseLTSMMarkerModel.lat, e.baseLTSMMarkerModel.lng))
                    .toList(),
                paddingBottom: _positionPixelsMinimizeAllLocation + 30);
            snappingSheetController.snapToPosition(listSnapLocation[1]);
          }
        });
      }
    }
  }

  void _getDataOnComplete(void Function() onSuccess) async {
    _showDialogLoading();
    bool isError = false;
    for (int i = _indexFunctionOnComplete;
        i < _listFunctionOnComplete.length;
        i++) {
      _indexFunctionOnComplete = i;
      var result = await _listFunctionOnComplete[i]();
      if (!result) {
        isError = true;
        break;
      }
    }
    Get.back();
    if (isError) {
      GlobalAlertDialog.showDialogError(
          title: "Error",
          message: "LTSMSFailedGetData".tr,
          labelButtonPriority1: "GlobalButtonTryAgain".tr,
          labelButtonPriority2: "GlobalButtonCancel".tr,
          isDismissible: false,
          onTapPriority1: () {
            _getDataOnComplete(onSuccess);
          },
          onTapPriority2: () {
            Get.back();
          });
    } else {
      onSuccess();
    }
  }

  void setPositionSnapping(double position) {
    _positionSnapping = position;
    if (isSnippingAtEnd.value) {
      isSnippingAtEnd.value = false;
      isSnippingAtEnd.refresh();
    }
    print("position snipping: " + _positionSnapping.toString());
  }

  void checkWhenEndSnapping() {
    if (_positionSnapping < 1 || isDetailLocationOnly.value) {
      isSnippingAtEnd.value = false;
      if (_positionSnapping > 0) {
        _isMinimizeMode = true;
      } else {
        _isMinimizeMode = false;
      }
    } else {
      isSnippingAtEnd.value = true;
      _isMinimizeMode = false;
    }

    isSnippingAtEnd.refresh();
    print("checkWhenEndSnapping: complete");
  }

  Future _setCameraFitBoundsCustom(List<LatLng> points,
      {double paddingBottom = 30}) async {
    await mapController.value.onReady;
    if (points.length > 0) {
      mapController.value.fitBounds(LatLngBounds.fromPoints(points),
          options: FitBoundsOptions(
              padding: EdgeInsets.fromLTRB(60.0, 60.0, 60.0, paddingBottom)));
    }
  }

  Future<bool> onWillPop() async {
    if (isDetailLocationOnly.value) return Future.value(true);
    if (isShowDetailMarker.value) {
      isShowDetailMarker.value = false;

      listMarker.clear();
      listMarker
          .addAll(_listMarkerBackup.map((e) => MarkerTruck.copy(e)).toList());
      // listSnapLocation.clear();
      // listSnapLocation.addAll(_listSnapAllLocation);
      snappingSheetController.snapToPosition(listSnapLocation[0]);
      listMarker.refresh();
      popupController.hidePopup();
      _setCameraFitBoundsCustom(listMarker
          .map((e) =>
              LatLng(e.baseLTSMMarkerModel.lat, e.baseLTSMMarkerModel.lng))
          .toList());
      return Future.value(false);
    }
    return Future.value(true);

    // if (isShowDetail.value ||
    //     isShowAllLocation.value ||
    //     isShowPerDistrict.value) {
    //   if (isShowDetail.value && isShowAllLocation.value) {
    //     isShowDetail.value = false;
    //     _setCameraFitBoundsAllLocationTransporter();
    //   } else {
    //     if (isShowDetail.value) {
    //       isShowDetail.value = false;
    //       _resetScrollController();
    //       _setCameraFitBoundsDefault();
    //     } else if (isShowPerDistrict.value) {
    //       isShowPerDistrict.value = false;
    //       listMarkerCircle.clear();
    //       _clearAllMarkerExceptFromDest();
    //       _generateListMarkerTransporter();
    //       _refreshAllData();
    //       _setCameraFitBoundsDefault();
    //     } else {
    //       isShowAllLocation.value = false;
    //       _setToDefault();
    //     }
    //   }

    //   return Future.value(false);
    // }
  }

  void onWhenPopup(MarkerTruck marker) {
    int pos = listMarker.indexWhere((element) => element.point == marker.point);

    if (pos >= 0) {
      if (!listMarker[pos].baseLTSMMarkerModel.isChoosen) {
        print("onWhenPopUp " + pos.toString());
        for (int i = 0; i < listMarker.length; i++) {
          listMarker[i].baseLTSMMarkerModel.isChoosen = i == pos;
        }
        isShowDetailMarker.value = true;
        MarkerTruck markerTruck = listMarker[pos];
        if (isDetailLocationOnly.value) {
          listMarker.clear();
          listMarker.add(markerTruck);
          // listSnapLocation.clear();
          // listSnapLocation.addAll(_listSnapDetailLocation);
          snappingSheetController.snapToPosition(listSnapLocation[1]);
        }
        _setCameraFitBoundsCustom([markerTruck.point],
            paddingBottom: isDetailLocationOnly.value ||
                    (!isDetailLocationOnly.value && !_isMinimizeMode)
                ? GlobalVariable.ratioHeight(Get.context) * 300
                : _positionPixelsMinimizeAllLocation - 50);
        listMarker.refresh();
        //mapController.refresh();
      }
    }
  }

  void hideAllPopUp() {
    popupController.hidePopup();
    for (int i = 0; i < listMarker.length; i++) {
      listMarker[i].baseLTSMMarkerModel.isChoosen = false;
    }
    //mapController.refresh();
    listMarker.refresh();
  }

  void showExpired() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        message: "LTSMSLabelExpired".tr,
        title: "",
        labelButtonPriority1: "LTSMSLabelOK".tr);
  }

  void checkDetail(MarkerTruck marker) async {
    if (DateTime.now().isAfter(
        marker.baseLTSMMarkerModel.lastUpdateRaw.add(Duration(hours: 24)))) {
      showExpired();
    } else {
      if (!isDetailLocationOnly.value) {
        var check = await checkAvailable(marker);
        if (check)
          lookMapMarker(marker);
        else
          showExpired();
      } else {
        lookMapMarker(marker);
      }
    }
  }

  Future<bool> checkAvailable(MarkerTruck marker) async {
    _showDialogLoading();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchLTSMAllLocation(
            transporterID: transporterID,
            sort: _mapSort,
            filter: _mapFilter,
            search: marker.baseLTSMMarkerModel.kode);
    try {
      Get.back();
      if (result != null) {
        DetailLTSMResponseModel detailLTSMResponseModel =
            DetailLTSMResponseModel.fromJson(Get.context, result, hideAllPopUp);
        return (detailLTSMResponseModel.message.code == 200 &&
            detailLTSMResponseModel.listMarkerTruck.isNotEmpty);
      } else {
        return false;
      }
    } catch (err) {
      print(err.toString());
    }
    return false;
  }

  void lookMapMarker(MarkerTruck marker) {
    popupController.hidePopup();
    // snappingSheetController
    //     .snapToPosition(snappingSheetController.s[0]);
    int pos = listMarker.indexWhere((element) => element.point == marker.point);
    listMarker[pos].baseLTSMMarkerModel.isChoosen = false;
    popupController.showPopupFor(marker);
    // for (int i = 0; i < listMarker.length; i++) {
    //   if (i != pos)
    //     listMarker[i].baseLTSMMarkerModel.isChoosen = false;
    //   else
    //     listMarker[pos].baseLTSMMarkerModel.isChoosen = true;
    // }
    // listMarker.refresh();
    // //mapController.refresh();
    // _setCameraFitBoundsCustom(
    //     [LatLng(marker.point.latitude, marker.point.longitude)]);
  }

  Future<bool> _getDataAllLocation({bool isShowDialogError = true}) async {
    try {
      listMarker.clear();
      var response = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: isShowDialogError)
          .fetchLTSMAllLocation(
              transporterID: transporterID, sort: _mapSort, filter: _mapFilter);
      if (response != null) {
        DetailLTSMResponseModel detailLTSMResponseModel =
            DetailLTSMResponseModel.fromJson(
                Get.context, response, hideAllPopUp);
        listMarker.addAll(detailLTSMResponseModel.listMarkerTruck);
        isShowLoadingManual.value = false;
        listMarker.refresh();
        return true;
      }
    } catch (err) {}
    return false;
  }

  Future<int> _getMaxTruck() async {
    try {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: false)
              .fetchAreaPickupTransporter(transporterID);
      if (response != null) {
        SearchAreaPickupFilteResponseModel searchAreaPickupFilteResponseModel =
            // SearchAreaPickupFilteResponseModel.fromJson(response);
            SearchAreaPickupFilteResponseModel.fromJson(response, "");
        _maxTruck = searchAreaPickupFilteResponseModel.maxTruk;
        // _filtercontroller.updateListFilterModel(
        //   0,
        //   WidgetFilterModel(
        //     label: ["LTSMSLabelNumTruck".tr],
        //     typeInFilter: TypeInFilter.UNIT,
        //     keyParam: "unit",
        //     customValue: [0.0, double.parse(_maxTruck.toString())],
        //   ),
        // );
        return _maxTruck;
      }
    } catch (err) {}
    return null;
  }

  void showGoldInfo() {
    showDialog(
        context: Get.context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            title: CustomText("DetailTransporterLabelKelengkapanDokumen".tr),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(Get.context) * 10,
                        GlobalVariable.ratioHeight(Get.context) * 12,
                        GlobalVariable.ratioWidth(Get.context) * 10,
                        GlobalVariable.ratioHeight(Get.context) * 11),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: GlobalVariable.ratioHeight(Get.context) * 2),
                          child: CustomText('GlobalFilterGoldenTransporter'.tr,
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.close,
                                  color: Color(ListColor.color4))),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(Get.context) * 17,
                        0,
                        GlobalVariable.ratioWidth(Get.context) * 17,
                        GlobalVariable.ratioHeight(Get.context) * 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            "\t" +
                                "DetailTransporterLabelKelengkapanDokumen".tr,
                            textAlign: TextAlign.justify,
                            height: 1.39,
                            color: Color(ListColor.colorDarkGrey3),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                        Container(
                            height:
                                GlobalVariable.ratioHeight(Get.context) * 8),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioHeight(Get.context) * 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: FontTopPadding.getSize(12),
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: Icon(Icons.check,
                                      color: Color(ListColor.colorBlue),
                                      size: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          9)),
                              Expanded(
                                child: CustomText(
                                    'DetailTransporterLabelCopySTNK'.tr,
                                    textAlign: TextAlign.left,
                                    height: 1.2,
                                    color: Color(ListColor.colorDarkGrey3),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioHeight(Get.context) * 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: FontTopPadding.getSize(12),
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: Icon(Icons.check,
                                      color: Color(ListColor.colorBlue),
                                      size: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          9)),
                              Expanded(
                                child: CustomText(
                                    'DetailTransporterLabelMelengkapiProfilPerusahaan'
                                        .tr,
                                    textAlign: TextAlign.left,
                                    height: 1.2,
                                    color: Color(ListColor.colorDarkGrey3),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioHeight(Get.context) * 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: FontTopPadding.getSize(12),
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: Icon(Icons.check,
                                      color: Color(ListColor.colorBlue),
                                      size: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          9)),
                              Expanded(
                                child: CustomText(
                                    'DetailTransporterLabelKelengkapanPersyaratan'
                                        .tr,
                                    textAlign: TextAlign.left,
                                    height: 1.2,
                                    color: Color(ListColor.colorDarkGrey3),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height:
                                GlobalVariable.ratioHeight(Get.context) * 8),
                        CustomText("\t" + "DetailTransporterLabelKeputusan".tr,
                            textAlign: TextAlign.justify,
                            height: 1.39,
                            color: Color(ListColor.colorDarkGrey3),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showSort() {
    _sortingController.showSort();
  }

  void showFilter() {
    _filtercontroller.showFilter();
  }

  void showContact(MarkerTruck marker) {
    _contactModalBottomSheetController.showContact(
        "",
        transporterID: marker.baseLTSMMarkerModel.transporterID,
        onReceiveContact: (data) {
          int pos = _listMarkerBackup
              .indexWhere((element) => element.point == marker.point);
          _listMarkerBackup[pos].baseLTSMMarkerModel.contact = data;
          listMarker[0].baseLTSMMarkerModel.contact = data;
          listMarker.refresh();
        });
  }

  void goToDetailTransporter(MarkerTruck marker) {
    GetToPage.toNamed<TransporterController>(Routes.TRANSPORTER, arguments: [
      marker.baseLTSMMarkerModel.transporterID,
      marker.baseLTSMMarkerModel.transporterName,
      "",
      marker.baseLTSMMarkerModel.isGold
    ]);
    // Get.toNamed(Routes.TRANSPORTER, arguments: [
    //   marker.baseLTSMMarkerModel.transporterID,
    //   marker.baseLTSMMarkerModel.transporterName,
    //   "",
    //   marker.baseLTSMMarkerModel.isGold
    // ]);
  }

  Future _showDialogLoading() async {
    return showDialog(
        context: Get.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: _keyDialog,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'GlobalLabelDialogLoading'.tr,
                          color: Colors.blueAccent,
                        )
                      ]),
                    )
                  ]));
        });
  }
}
