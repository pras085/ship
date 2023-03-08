import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/function/loading_dialog.dart';
import 'package:muatmuat/app/core/models/place_details_from_dest.dart';
import 'package:muatmuat/app/core/models/transporter_location_truck_ready_model.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_from_dest_model.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_result_model.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_result_per_district_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/global_variable.dart';

class LocationTruckReadyController extends GetxController {
  final isShowMarkerCenter = false.obs;
  final isGetLocationUser = false.obs;
  final isShowFromAddress = false.obs;
  final isShowSummary = false.obs;
  final isShowDetail = false.obs;
  final isShowAllLocation = false.obs;
  final isShowPerDistrict = false.obs;

  final detailTransporter = LocationTruckReadyResultModel().obs;

  final currentLocation = LatLng(0, 0).obs;

  bool _isGetLocationUser = false;
  bool _isFirstInit = true;

  final listMarker = [].obs;
  final listMarkerCircle = [].obs;
  final listLocationTruckReadyResultModel = [].obs;
  final listAllLocationTransporterTruckReady = [].obs;
  final listRoute = [].obs;

  List<Marker> _listMarkerDefault = [];
  List<LatLng> _listRouteDefault = [];
  List<LatLng> _listLatLngMarkerDefault = [];
  List<LocationTruckReadyResultModel> _listCircle = [];
  List<LocationTruckReadyResultPerDistrictModel> _listPerDistrict = [];
  List<LocationTruckReadyFromDestModel> _listLocationFromDest = [];
  List<LatLng> _listLatLngAllLocationTransporter = [];

  var _location = Location();

  final textEditingCityFromController = TextEditingController().obs;
  final textEditingCityDestController = TextEditingController().obs;

  final markerDest = "marker_dest_icon.png".obs;
  final markerFrom = "marker_from_icon.png".obs;

  final placeDetailsFromDest = PlaceDetailsFromDest().obs;
  final mapController = MapController().obs;

  final scaffoldKey = GlobalKey<ScaffoldState>().obs;
  final scrollController = ScrollController(keepScrollOffset: true).obs;

  double _posScroll = 0;

  final LoadingDialog _loadingDialog = LoadingDialog(Get.context);

  int _indexRemovedCircle = 0;

  List<TransporterLocationTruckReadyModel> _listTransporterData;

  @override
  void onInit() {
    Map<String, dynamic> args = Get.arguments;
    placeDetailsFromDest.value = args["FromDest"];
    _listTransporterData = args["ListTransporter"];
    _showDataToMap();
    //untuk testing
    //_getTransporterData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void _getLocationUser() {
    _location.onLocationChanged.listen((LocationData current) {
      if (current.accuracy < 50) {
        if (!_isGetLocationUser) {
          _isGetLocationUser = true;
          currentLocation.value = LatLng(current.latitude, current.longitude);
          _addMarkertoList(currentLocation.value, 0);
          isGetLocationUser.value = true;
        }
      }
    });
  }

  Future _setCameraFitBoundsDefault() async {
    await mapController.value.onReady;
    _setCameraFitBoundsCustom(
        (MediaQuery.of(Get.context).size.height * 0.4) + 30,
        _listLatLngMarkerDefault);
    // mapController.value.fitBounds(
    //     LatLngBounds.fromPoints([
    //       placeDetailsFromDest.value.fromAddressGooglePlaceDetailsModel.latLng,
    //       placeDetailsFromDest.value.destAddressGooglePlaceDetailsModel.latLng
    //     ]),
    //     options: FitBoundsOptions(
    //         padding: EdgeInsets.fromLTRB(60.0, 60.0, 60.0,
    //             (MediaQuery.of(Get.context).size.height * 0.4) + 30)));
  }

  Future _setCameraFitBoundsCustom(
      double paddingBottom, List<LatLng> points) async {
    await mapController.value.onReady;
    mapController.value.fitBounds(LatLngBounds.fromPoints(points),
        options: FitBoundsOptions(
            padding: EdgeInsets.fromLTRB(60.0, 60.0, 60.0, paddingBottom)));
  }

  void _addMarkertoList(LatLng latLng, int index) {
    if (listMarker.length > 0 && index < listMarker.length) {
      listMarker[index] = latLng;
    } else {
      listMarker.add(latLng);
    }
  }

  Future gotoSearchCityFromDest() async {
    var result = await Get.toNamed(Routes.FROM_DEST_SEARCH_LOCATION);
    if (result != null) {
      placeDetailsFromDest.value = result;
      _clearAllData();
      _showDataToMap();
    }
  }

  void _generateAllListMarker() {
    for (LocationTruckReadyFromDestModel data in _listLocationFromDest) {
      listMarker.add(_getMarkerFromDest(
          data.latLng, data.widthHeightMarker, data.urlMarker));
    }
    _generateListMarkerTransporter();
    _generateListMarkerCircle();
    // LatLng testLatLng = _getCenterFromAllMarker();
    // listMarker.add(Marker(
    //   width: 90,
    //   height: 90,
    //   point: testLatLng,
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   builder: (ctx) => GestureDetector(
    //     onTap: () {
    //       //_testChangeCircleToMarker();
    //     },
    //     child: Container(
    //       width: 90,
    //       height: 90,
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //         color: Color(ListColor.color4).withOpacity(0.5),
    //       ),
    //     ),
    //   ),
    // ));
  }

  void _generateListMarkerTransporter() {
    for (int i = 0; i < listLocationTruckReadyResultModel.length; i++) {
      listMarker.add(Marker(
        width: listLocationTruckReadyResultModel[i].widthHeightMarker,
        height: listLocationTruckReadyResultModel[i].widthHeightMarker,
        point: LatLng(listLocationTruckReadyResultModel[i].latLng.latitude,
            listLocationTruckReadyResultModel[i].latLng.longitude),
        anchorPos: AnchorPos.align(AnchorAlign.top),
        builder: (ctx) => Container(
          child: Image(
            image: AssetImage(
                "assets/" + listLocationTruckReadyResultModel[i].urlMarker),
            width: listLocationTruckReadyResultModel[i].widthHeightMarker,
            height: listLocationTruckReadyResultModel[i].widthHeightMarker,
          ),
          // child: Transform.translate(
          //   offset: Offset(0, -20),
          //   child: Image(
          //     image: AssetImage(
          //         "assets/" + listLocationTruckReadyResultModel[i].urlMarker),
          //     width: listLocationTruckReadyResultModel[i].widthHeightMarker,
          //     height: listLocationTruckReadyResultModel[i].widthHeightMarker,
          //   ),
          // ),
        ),
      ));
    }
  }

  void _generateListMarkerCircle() {
    for (int i = 0; i < _listCircle.length; i++) {
      listMarkerCircle.add(_setMarkerCircle(i));
    }
  }

  Marker _setMarkerCircle(int i) {
    return Marker(
      width: _listCircle[i].widthHeightMarker,
      height: _listCircle[i].widthHeightMarker,
      point: LatLng(
          _listCircle[i].latLng.latitude, _listCircle[i].latLng.longitude),
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (ctx) => GestureDetector(
        onTap: () {
          _changeCircleToMarker(i);
        },
        child: Container(
          width: _listCircle[i].widthHeightMarker,
          height: _listCircle[i].widthHeightMarker,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(ListColor.color4).withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  void _addMarkerTruck(
      LatLng latLng,
      String title,
      String address,
      String locationNameTransporter,
      String locationNameDestination,
      String idDistrict,
      String districtName) {
    listLocationTruckReadyResultModel.add(LocationTruckReadyResultModel(
        idTransporter: "TD-02",
        title: title,
        latLng: latLng,
        urlMarker: "marker_truck_icon.png",
        widthHeightMarker: 40.0,
        address: address,
        locationNameDestination: locationNameDestination,
        locationNameTransporter: locationNameTransporter,
        idTypeOfTruck: "0",
        typeOfTruckName: "Tronton/Wingbox",
        numberOfTruck: 10,
        lastUpdate: "05/03/2021 11.00 WIB",
        typeOfTransporter: "Gold Transporter",
        idDistrict: idDistrict,
        districtName: districtName));
  }

  void _addCircleMarker(LatLng latLng, String title, String address) {
    _listCircle.add(LocationTruckReadyResultModel(
        title: title,
        latLng: latLng,
        urlMarker: "",
        widthHeightMarker: 40.0,
        address: address));
  }

  Future _getListLatLng() async {
    await mapController.value.onReady;
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: true,
            isShowDialogError: true)
        .fetchDirectionAPI(
            placeDetailsFromDest
                .value.fromAddressGooglePlaceDetailsModel.latLng,
            placeDetailsFromDest
                .value.destAddressGooglePlaceDetailsModel.latLng);
    if (responseBody != null) {
      try {
        listRoute.addAll(responseBody);
      } catch (err) {}
    }
    _refreshAllData();
    if (_isFirstInit) {
      _isFirstInit = false;
      _loadingDialog.showLoadingDialog();
      _listMarkerDefault
          .addAll(listMarker.map<Marker>((data) => data as Marker).toList());
      _listRouteDefault
          .addAll(listRoute.map<LatLng>((data) => data as LatLng).toList());
      _setAllLatLngMarker();
      Timer(Duration(seconds: 1), () async {
        _setCameraFitBoundsDefault();
        _loadingDialog.dismissDialog();
      });
    }
  }

  void _setAllLatLngMarker() {
    _listLatLngMarkerDefault.addAll([
      placeDetailsFromDest.value.fromAddressGooglePlaceDetailsModel.latLng,
      placeDetailsFromDest.value.destAddressGooglePlaceDetailsModel.latLng
    ]);
    for (int i = 0; i < _listMarkerDefault.length; i++) {
      _listLatLngMarkerDefault.add(_listMarkerDefault[i].point);
    }
  }

  void _showDataToMap() {
    textEditingCityFromController.value.text = placeDetailsFromDest
        .value.fromAddressGooglePlaceDetailsModel.formattedAddress;
    textEditingCityDestController.value.text = placeDetailsFromDest
        .value.destAddressGooglePlaceDetailsModel.formattedAddress;
    _listLocationFromDest.add(LocationTruckReadyFromDestModel(
        title: "From",
        latLng: placeDetailsFromDest
            .value.fromAddressGooglePlaceDetailsModel.latLng,
        urlMarker: "marker_from_icon.png",
        widthHeightMarker: 40.0,
        address: placeDetailsFromDest
            .value.fromAddressGooglePlaceDetailsModel.formattedAddress));
    _listLocationFromDest.add(LocationTruckReadyFromDestModel(
        title: "Dest",
        latLng: placeDetailsFromDest
            .value.destAddressGooglePlaceDetailsModel.latLng,
        urlMarker: "marker_dest_icon.png",
        widthHeightMarker: 40.0,
        address: placeDetailsFromDest
            .value.destAddressGooglePlaceDetailsModel.formattedAddress));
    _getTransporterData();
    _generateAllListMarker();
    _getListLatLng();
  }

  void _getTransporterData() {
    for (TransporterLocationTruckReadyModel data in _listTransporterData) {
      _addMarkerTruck(data.latLng, data.name, data.address, "Kota Surabaya",
          data.serviceArea, "1", "Kecamatan Sawahan");
    }
    // _addMarkerTruck(LatLng(-7.280186794277672, 112.74147525005432), "PT. X",
    //     "Jl X", "Kota Surabaya", "Kota Semarang", "1", "Kecamatan Sawahan");
    // _addMarkerTruck(LatLng(-7.274381138462091, 112.72542586235572), "PT. Y",
    //     "Jl Y", "Kota Surabaya", "Kota Semarang", "1", "Kecamatan Sawahan");
    // _addMarkerTruck(LatLng(-7.269741466932627, 112.7168808050866), "PT. Z",
    //     "Jl Z", "Kota Surabaya", "-", "1", "Kecamatan Sawahan");
    // _addMarkerTruck(LatLng(-7.284913, 112.697518), "PT. A", "Jl AZ",
    //     "Kota Surabaya", "-", "2", "Kecamatan Sukomanunggal");
    // _addMarkerTruck(LatLng(-7.264282134776441, 112.69147716764483), "PT. B",
    //     "Jl BZ", "Kota Surabaya", "-", "2", "Kecamatan Sukomanunggal");
  }

  void setCameraManual() {
    _setCameraFitBoundsDefault();
  }

  void _refreshAllData() {
    listMarker.refresh();
    listRoute.refresh();
    listMarkerCircle.refresh();
  }

  void _clearAllMarkerExceptFromDest() {
    if (listMarker.length > 2) listMarker.removeRange(2, listMarker.length);
  }

  void _clearAllData() {
    listMarker.clear();
    listRoute.clear();
    //listLocationTruckReadyResultModel.clear();
    _refreshAllData();
  }

  String nameMarker(LatLng latLng) {
    String result = "";
    var data = _getDataFromLatLng(latLng);
    result = data.title ?? "";
    return result;
  }

  String addressMarker(LatLng latLng) {
    String result = "";
    var data = _getDataFromLatLng(latLng);
    result = data.address ?? "";
    return result;
  }

  _getDataFromLatLng(LatLng latLng) {
    var result;
    for (LocationTruckReadyFromDestModel data in _listLocationFromDest) {
      if (data.latLng == latLng) {
        result = data;
        break;
      }
    }
    if (result != null) return result;
    for (LocationTruckReadyResultModel data
        in listLocationTruckReadyResultModel) {
      if (data.latLng == latLng) {
        result = data;
        break;
      }
    }
    return result;
  }

  void _changeCircleToMarker(int index) {
    if (listMarkerCircle.length < _listPerDistrict.length) {
      _clearAllMarkerExceptFromDest();
      listMarkerCircle.insert(
          _indexRemovedCircle, _setMarkerCircle(_indexRemovedCircle));
    }
    _indexRemovedCircle = index;
    try {
      for (LocationTruckReadyResultModel data
          in _listPerDistrict[index].listTransporterLocation)
        listMarker.add(_getMarkerTruck(data.latLng, 40.0, 40.0));
      listMarkerCircle.removeAt(index);
      _refreshAllData();
    } catch (err) {
      GlobalVariable.showMessageToastDebug("err: " + err.toString());
    }
  }

  Marker _getMarkerFromDest(
      LatLng point, double widthHeight, String urlMarker) {
    return _getMarker(
        point,
        widthHeight,
        widthHeight,
        GestureDetector(
          onTap: () {},
          child: Image(
            image: AssetImage("assets/" + urlMarker),
            width: widthHeight,
            height: widthHeight,
          ),
        ));
  }

  Marker _getMarkerTruck(LatLng point, double width, double height) {
    return _getMarker(
        point,
        width,
        height,
        Image(
          image: AssetImage("assets/marker_truck_icon.png"),
          width: 40,
          height: 40,
        ));
  }

  Marker _getMarker(
      LatLng point, double width, double height, Widget childWidget) {
    return Marker(
      width: width,
      height: height,
      point: point,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (ctx) => Container(
        child: childWidget,
        // child: Transform.translate(
        //   offset: Offset(0, -20),
        //   child: Image(
        //     image: AssetImage(
        //         "assets/" + listLocationTruckReadyResultModel[i].urlMarker),
        //     width: listLocationTruckReadyResultModel[i].widthHeightMarker,
        //     height: listLocationTruckReadyResultModel[i].widthHeightMarker,
        //   ),
        // ),
      ),
    );
  }

  void showDetailTransporter(int index) {
    detailTransporter.value = listLocationTruckReadyResultModel[index];
    isShowDetail.value = true;
    mapController.value.fitBounds(
        LatLngBounds.fromPoints([detailTransporter.value.latLng]),
        options: FitBoundsOptions(
            padding: EdgeInsets.fromLTRB(60.0, 60.0, 60.0,
                (MediaQuery.of(Get.context).size.height * 0.4) + 50)));
    //_animatedMapMove(detailTransporter.value.latLng, 18.0);
  }

  void showDetailTransporterFromAllLocation(int index) {
    detailTransporter.value = listAllLocationTransporterTruckReady[index];
    isShowDetail.value = true;
    mapController.value.fitBounds(
        LatLngBounds.fromPoints([detailTransporter.value.latLng]),
        options: FitBoundsOptions(
            padding: EdgeInsets.fromLTRB(60.0, 60.0, 60.0,
                (MediaQuery.of(Get.context).size.height * 0.4) + 50)));
    //_animatedMapMove(detailTransporter.value.latLng, 18.0);
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // // Create some tweens. These serve to split up the transition from one location to another.
    // // In our case, we want to split the transition be<tween> our current map center and the destination.
    // final _latTween = Tween<double>(
    //     begin: mapController.value.center.latitude, end: destLocation.latitude);
    // final _lngTween = Tween<double>(
    //     begin: mapController.value.center.longitude,
    //     end: destLocation.longitude);
    // final _zoomTween =
    //     Tween<double>(begin: mapController.value.zoom, end: destZoom);

    // // Create a animation controller that has a duration and a TickerProvider.
    // var controller = AnimationController(
    //     duration: const Duration(milliseconds: 500), vsync: this);
    // // The animation determines what path the animation will take. You can try different Curves values, although I found
    // // fastOutSlowIn to be my favorite.
    // Animation<double> animation =
    //     CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    // controller.addListener(() {
    //   mapController.value.move(
    //       LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
    //       _zoomTween.evaluate(animation));
    // });

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.dispose();
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.dispose();
    //   }
    // });

    // controller.forward();
  }

  Future<bool> onWillPop() async {
    if (isShowDetail.value ||
        isShowAllLocation.value ||
        isShowPerDistrict.value) {
      if (isShowDetail.value && isShowAllLocation.value) {
        isShowDetail.value = false;
        _setCameraFitBoundsAllLocationTransporter();
      } else {
        if (isShowDetail.value) {
          isShowDetail.value = false;
          _resetScrollController();
          _setCameraFitBoundsDefault();
        } else if (isShowPerDistrict.value) {
          isShowPerDistrict.value = false;
          listMarkerCircle.clear();
          _clearAllMarkerExceptFromDest();
          _generateListMarkerTransporter();
          _refreshAllData();
          _setCameraFitBoundsDefault();
        } else {
          isShowAllLocation.value = false;
          _setToDefault();
        }
      }

      return Future.value(false);
    }
    return Future.value(true);
  }

  void showAllLocationTransporter(int index) {
    _listLatLngAllLocationTransporter.clear();
    detailTransporter.value = listLocationTruckReadyResultModel[index];
    isShowAllLocation.value = true;
    listAllLocationTransporterTruckReady.clear();
    listRoute.clear();
    listAllLocationTransporterTruckReady.add(LocationTruckReadyResultModel(
        idTransporter: "TD-02",
        title: "",
        latLng: LatLng(-6.2092038842657375, 106.84633771059123),
        urlMarker: "marker_truck_icon.png",
        widthHeightMarker: 40.0,
        address: "Jl. Sultan Agung Jakarta Selatan",
        locationNameDestination: "Kota Surabaya",
        locationNameTransporter: "Kota Jakarta",
        idTypeOfTruck: "0",
        typeOfTruckName: "Tronton/Wingbox",
        numberOfTruck: 10,
        lastUpdate: "05/03/2021 11.00 WIB",
        typeOfTransporter: "Gold Transporter"));
    listAllLocationTransporterTruckReady
        .add(listLocationTruckReadyResultModel[index]);
    listMarker.clear();
    for (LocationTruckReadyResultModel data
        in listAllLocationTransporterTruckReady) {
      listMarker.add(_getMarkerTruck(data.latLng, 40.0, 40.0));
      _listLatLngAllLocationTransporter.add(data.latLng);
    }
    listAllLocationTransporterTruckReady.refresh();
    _refreshAllData();
    _setCameraFitBoundsAllLocationTransporter();
  }

  void showPerDistrict() {
    if (!isShowPerDistrict.value) {
      isShowPerDistrict.value = true;
      try {
        _setListPerDistrict();
        _clearAllMarkerExceptFromDest();
        _addListPerDistrictToListMarker();
        _refreshAllData();
        setCameraManual();
      } catch (err) {
        GlobalVariable.showMessageToastDebug("error: " + err.toString());
      }
    }
  }

  void _setCameraFitBoundsAllLocationTransporter() {
    _setCameraFitBoundsCustom(
        (MediaQuery.of(Get.context).size.height * 0.4) + 30,
        _listLatLngAllLocationTransporter);
  }

  void _setToDefault() {
    _clearAllData();
    listMarker.addAll(_listMarkerDefault);
    listRoute.addAll(_listRouteDefault);
    _refreshAllData();
    setCameraManual();
  }

  LatLng _getCenterFromAllMarker(
      List<LocationTruckReadyResultModel> listLatLng) {
    if (listLatLng.length == 1) {
      return listLatLng[0].latLng;
    }

    double x = 0;
    double y = 0;
    double z = 0;

    for (LocationTruckReadyResultModel point in listLatLng) {
      var latitude = point.latLng.latitude * math.pi / 180;
      var longitude = point.latLng.longitude * math.pi / 180;

      x += math.cos(latitude) * math.cos(longitude);
      y += math.cos(latitude) * math.sin(longitude);
      z += math.sin(latitude);
    }

    var total = listMarker.length;

    x = x / total;
    y = y / total;
    z = z / total;

    var centralLongitude = math.atan2(y, x);
    var centralSquareRoot = math.sqrt(x * x + y * y);
    var centralLatitude = math.atan2(z, centralSquareRoot);

    return LatLng(
        centralLatitude * 180 / math.pi, centralLongitude * 180 / math.pi);
  }

  //set _listPerDistrict
  void _setListPerDistrict() {
    _listPerDistrict.clear();
    for (LocationTruckReadyResultModel data
        in listLocationTruckReadyResultModel) {
      if (_listPerDistrict.length == 0) {
        _addListPerDistrict(data);
      } else {
        bool isAlreadySaved = false;
        for (int i = 0; i < _listPerDistrict.length; i++) {
          if (_listPerDistrict[i].idDistrict == data.idDistrict) {
            isAlreadySaved = true;
            _addDetailListPerDistrict(i, data);
            break;
          }
        }
        if (!isAlreadySaved) {
          _addListPerDistrict(data);
        }
      }
    }
  }

  void _addListPerDistrictToListMarker() {
    _listCircle.clear();
    for (LocationTruckReadyResultPerDistrictModel data in _listPerDistrict) {
      _addCircleMarker(data.centerLatLng, data.districtName, "");
    }
    _generateListMarkerCircle();
  }

  void _addListPerDistrict(LocationTruckReadyResultModel data) {
    _listPerDistrict.add(LocationTruckReadyResultPerDistrictModel(
        idDistrict: data.idDistrict, districtName: data.districtName));
    _addDetailListPerDistrict(_listPerDistrict.length - 1, data);
  }

  void _addDetailListPerDistrict(
      int index, LocationTruckReadyResultModel data) {
    _listPerDistrict[index].listTransporterLocation.add(data);
    _listPerDistrict[index].centerLatLng = _getCenterFromAllMarker(
        _listPerDistrict[index].listTransporterLocation);
  }

  bool isShowAllTransporter() {
    return !isShowAllLocation.value &&
        !isShowDetail.value &&
        !isShowPerDistrict.value;
  }

  void afterDone() {
    _setScrollControllerListener();
  }

  void _resetScrollController() {
    scrollController.value = null;
    scrollController.value = ScrollController(initialScrollOffset: _posScroll);
    _setScrollControllerListener();
  }

  void _setScrollControllerListener() {
    scrollController.value.addListener(() {
      _posScroll = scrollController.value.offset;
    });
  }
}
