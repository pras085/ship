import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/modules/test_list/test_list_view.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/test_stl.dart';

class FilterController extends GetxController {
  final double _maxRangeValueUnit = 10000;

  var _filterheight = MediaQuery.of(Get.context).size.height - 200;

  Map<String, dynamic> listNotChoosenTransporterLocation = {};
  Map<String, dynamic> listChoosenTransporterLocation = {};
  Map<String, dynamic> listNotChoosenAreaService = {};
  Map<String, dynamic> listChoosenAreaService = {};
  Map<String, dynamic> _listCity = {};

  List<ItemWrap> listAreaService = [];
  List<ItemWrap> listTransporterLocation = [];

  final listChoosenTempAreaService = {}.obs;
  final listChoosenTempTransporterLocation = {}.obs;
  final listChoosenTempShowAll = {}.obs;
  final listAllShowAll = {}.obs;

  final firstDateText = "".obs;
  final endDateText = "".obs;
  final firstDateBergabungText = "".obs;
  final endDateBergabungText = "".obs;

  final switchTypeOfTransporter = false.obs;
  final _switchTypeOfTransporterTemp = false.obs;
  final _isGettingDataCity = false.obs;

  final rangeValues = RangeValues(0, 10000).obs;
  final _rangeValuesTemp = RangeValues(0, 10000).obs;

  final _startUnitRangeTextEditingController = TextEditingController().obs;
  final _endUnitRangeTextEditingController = TextEditingController().obs;

  DateTime firstDate;
  DateTime firstDateTemp;
  DateTime endDate;
  DateTime endDateTemp;

  DateTime firstDateBergabung;
  DateTime firstDateBergabungTemp;
  DateTime endDateBergabung;
  DateTime endDateBergabungTemp;

  final int _maxDataWrapFilter = 5;

  void Function(Map<String, dynamic>) returnData;

  final String _hintFirstDate = "GlobalFilterHintFirstDate".tr;
  final String _hintEndDate = "GlobalFilterHintEndDate".tr;

  bool _onClickWrap = false;

  FilterController(this.returnData);

  @override
  void onInit() {
    firstDateText.value = _hintFirstDate;
    endDateText.value = _hintEndDate;
    super.onInit();
  }

  Widget _lineSaparator() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        height: 0.5,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey5));
  }

  void _initShowFilter() {
    firstDateTemp = firstDate;
    endDateTemp = endDate;
    listChoosenTempAreaService.clear();
    listChoosenTempTransporterLocation.clear();
    listChoosenTempAreaService.addAll(listChoosenAreaService);
    listChoosenTempTransporterLocation.addAll(listChoosenTransporterLocation);
    _setTextFirstEndDateTime(firstDateText, firstDate, _hintFirstDate);
    _setTextFirstEndDateTime(endDateText, endDate, _hintEndDate);
    _switchTypeOfTransporterTemp.value = switchTypeOfTransporter.value;
    _rangeValuesTemp.value = rangeValues.value;
    _setRangeValueUnit(
        _rangeValuesTemp.value.start, _rangeValuesTemp.value.end);
    if (_listCity.length == 0) {
      _getCity();
    }
  }

  Future showFilter() async {
    _initShowFilter();
    await showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Obx(
            () => Stack(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Color(ListColor.colorLightGrey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: CustomText("GlobalFilterTitle".tr,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.color4),
                                  fontSize: 16)),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 30,
                                  )),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: CustomText(
                                      "GlobalFilterButtonReset".tr,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.color4),
                                    ),
                                  ),
                                  onTap: () {
                                    _resetAll();
                                  }),
                            ),
                          )
                        ],
                      )),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: _filterheight,
                          minHeight: 0,
                          minWidth: double.infinity),
                      child: Container(
                        padding: EdgeInsets.all(13),
                        child: _isGettingDataCity.value
                            ? Container(
                                width: MediaQuery.of(Get.context).size.width,
                                height: 100,
                                child: Center(
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator())))
                            : ListView(
                                shrinkWrap: true,
                                children: [
                                  _textTitle("GlobalFIlterNumberOfTruck".tr),
                                  SizedBox(height: 20),
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                                height: 1,
                                                width:
                                                    MediaQuery.of(Get.context)
                                                        .size
                                                        .width,
                                                color: Color(ListColor
                                                    .colorLightGrey10)),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                    child: CustomTextField(
                                                        context: Get.context,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        enabled: true,
                                                        controller:
                                                            _startUnitRangeTextEditingController
                                                                .value,
                                                        newContentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        16),
                                                        newInputDecoration:
                                                            InputDecoration(
                                                          fillColor: Color(ListColor
                                                              .colorLightGrey3),
                                                          filled: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey10),
                                                                width: 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    ListColor
                                                                        .color4),
                                                                width: 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    ListColor
                                                                        .color4),
                                                                width: 2.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                        onChanged: (value) {
                                                          if (value == "") {
                                                            value = "0";
                                                          }
                                                          _setRangeValueUnit(
                                                              double.parse(
                                                                  value),
                                                              _rangeValuesTemp
                                                                  .value.end,
                                                              isUpdateTextEditingController:
                                                                  false);
                                                        },
                                                        maxLines: 1,
                                                        keyboardType:
                                                            TextInputType
                                                                .number)),
                                                // Container(
                                                //   padding: EdgeInsets.all(10),
                                                //   decoration: BoxDecoration(
                                                //       border: Border.all(
                                                //           color: Color(ListColor
                                                //               .colorLightGrey10),
                                                //           width: 1),
                                                //       borderRadius:
                                                //           BorderRadius.all(
                                                //               Radius.circular(
                                                //                   10)),
                                                //       color: Color(ListColor
                                                //           .colorLightGrey3)),
                                                //   child: Text(_rangeValuesTemp
                                                //       .value.start
                                                //       .round()
                                                //       .toInt()
                                                //       .toString()),
                                                // ),
                                                //),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Expanded(
                                                    child: CustomTextField(
                                                        context: Get.context,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        enabled: true,
                                                        controller:
                                                            _endUnitRangeTextEditingController
                                                                .value,
                                                        newContentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        16),
                                                        newInputDecoration:
                                                            InputDecoration(
                                                          fillColor: Color(ListColor
                                                              .colorLightGrey3),
                                                          filled: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey10),
                                                                width: 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    ListColor
                                                                        .color4),
                                                                width: 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    ListColor
                                                                        .color4),
                                                                width: 2.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                        onChanged: (value) {
                                                          if (value == "") {
                                                            value = "0";
                                                          }
                                                          if (double.parse(
                                                                  value) >
                                                              _maxRangeValueUnit) {
                                                            _endUnitRangeTextEditingController
                                                                    .value
                                                                    .text =
                                                                _maxRangeValueUnit
                                                                    .round()
                                                                    .toString();
                                                          } else {
                                                            _setRangeValueUnit(
                                                                _rangeValuesTemp
                                                                    .value
                                                                    .start,
                                                                double.parse(
                                                                    value),
                                                                isUpdateTextEditingController:
                                                                    false);
                                                          }
                                                        },
                                                        maxLines: 1,
                                                        keyboardType:
                                                            TextInputType
                                                                .number)
                                                    // Container(
                                                    //   padding: EdgeInsets.all(10),
                                                    //   decoration: BoxDecoration(
                                                    //       border: Border.all(
                                                    //           color: Color(ListColor
                                                    //               .colorLightGrey10),
                                                    //           width: 1),
                                                    //       borderRadius:
                                                    //           BorderRadius.all(
                                                    //               Radius.circular(
                                                    //                   10)),
                                                    //       color: Color(ListColor
                                                    //           .colorLightGrey3)),
                                                    //   child: Text(_rangeValuesTemp
                                                    //       .value.end
                                                    //       .round()
                                                    //       .toInt()
                                                    //       .toString()),
                                                    // ),
                                                    )
                                              ],
                                            )
                                          ],
                                        ),
                                        SliderTheme(
                                            data: SliderThemeData(
                                                trackHeight: 1,
                                                activeTrackColor:
                                                    Color(ListColor.colorBlue),
                                                inactiveTrackColor:
                                                    Color(ListColor.colorGrey),
                                                thumbColor:
                                                    Color(ListColor.colorWhite),
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        enabledThumbRadius:
                                                            15.0)),
                                            child: RangeSlider(
                                                min: 0,
                                                max: _maxRangeValueUnit,
                                                values: _rangeValuesTemp.value,
                                                onChanged: (values) {
                                                  _setRangeValueUnit(
                                                      values.start, values.end);
                                                })),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Wrap(
                                        //   children: [
                                        //     _getItemWrap(
                                        //         "", "10 unit - 100 unit", false,
                                        //         (value, key) {
                                        //       _setRangeValueUnit(10, 100);
                                        //     }),
                                        //     _getItemWrap(
                                        //         "",
                                        //         "100 unit - 1000 unit",
                                        //         false, (value, key) {
                                        //       _setRangeValueUnit(100, 1000);
                                        //     }),
                                        //     _getItemWrap(
                                        //         "",
                                        //         "1000 unit - 5000 unit",
                                        //         false, (value, key) {
                                        //       _setRangeValueUnit(1000, 5000);
                                        //     }),
                                        //   ],
                                        // )
                                      ]),
                                  _lineSaparator(),
                                  _textTitle("GlobalFilterYearFounded".tr),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _setFirstDateTimeTemp();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(ListColor
                                                        .colorLightGrey10),
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Color(
                                                    ListColor.colorLightGrey3)),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: CustomText(
                                                        firstDateText.value),
                                                  ),
                                                  SvgPicture.asset(
                                                    "assets/calendar_icon.svg",
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: CustomText("s/d"),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _setEndDateTimeTemp();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(ListColor
                                                        .colorLightGrey10),
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Color(
                                                    ListColor.colorLightGrey3)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: CustomText(
                                                      endDateText.value),
                                                ),
                                                SvgPicture.asset(
                                                  "assets/calendar_icon.svg",
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  _lineSaparator(),
                                  _textTitle("Bergabung sejak".tr),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _setFirstDateTimeBergabungTemp();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(ListColor
                                                        .colorLightGrey10),
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Color(
                                                    ListColor.colorLightGrey3)),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: CustomText(
                                                        firstDateBergabungText
                                                            .value),
                                                  ),
                                                  SvgPicture.asset(
                                                    "assets/calendar_icon.svg",
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: CustomText("s/d"),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _setEndDateTimeBergabungTemp();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(ListColor
                                                        .colorLightGrey10),
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Color(
                                                    ListColor.colorLightGrey3)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: CustomText(
                                                      endDateBergabungText
                                                          .value),
                                                ),
                                                SvgPicture.asset(
                                                  "assets/calendar_icon.svg",
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  _lineSaparator(),
                                  _filterWrap(
                                      "GlobalFilterTransporterLocation".tr,
                                      () async {
                                        // showAllArea(listChoosenTempAreaService,
                                        //     "Area Layanan");
                                        var result = await Get.toNamed(
                                            Routes.LIST_CITY_FILTER,
                                            arguments: [
                                              _listCity,
                                              listChoosenTempTransporterLocation,
                                            ],
                                            preventDuplicates: false);
                                        if (result != null) {
                                          listChoosenTempTransporterLocation
                                              .clear();
                                          listChoosenTempTransporterLocation
                                              .addAll(result);
                                          listChoosenTempTransporterLocation
                                              .refresh();
                                        }
                                      },
                                      // () {
                                      //   showAllArea(
                                      //       listChoosenTempTransporterLocation,
                                      //       "Lokasi Transporter");
                                      // },
                                      listNotChoosenTransporterLocation,
                                      listChoosenTempTransporterLocation.map(
                                          (key, value) => MapEntry(key, value)),
                                      (value, key) {
                                        _onClickWrap = true;
                                        if (!value) {
                                          listChoosenTempTransporterLocation
                                              .remove(key);
                                        } else {
                                          listChoosenTempTransporterLocation[
                                                  key] =
                                              listNotChoosenTransporterLocation[
                                                  key];
                                        }
                                        listChoosenTempTransporterLocation
                                            .refresh();
                                      },
                                      listTransporterLocation),
                                  _lineSaparator(),
                                  _filterWrap(
                                      "GlobalFilterServiceArea".tr,
                                      () async {
                                        // showAllArea(listChoosenTempAreaService,
                                        //     "Area Layanan");
                                        var result = await Get.toNamed(
                                            Routes.LIST_CITY_FILTER,
                                            arguments: [
                                              _listCity,
                                              listChoosenTempAreaService,
                                            ],
                                            preventDuplicates: false);
                                        if (result != null) {
                                          listChoosenTempAreaService.clear();
                                          listChoosenTempAreaService
                                              .addAll(result);
                                          listChoosenTempAreaService.refresh();
                                        }
                                      },
                                      listNotChoosenAreaService,
                                      listChoosenTempAreaService.map(
                                          (key, value) => MapEntry(key, value)),
                                      (value, key) {
                                        _onClickWrap = true;
                                        if (!value) {
                                          listChoosenTempAreaService
                                              .remove(key);
                                        } else {
                                          listChoosenTempAreaService[key] =
                                              listNotChoosenAreaService[key];
                                        }
                                        listChoosenTempAreaService.refresh();
                                      },
                                      listAreaService),
                                  _lineSaparator(),
                                  _textTitle(
                                      "GlobalFilterTypeOfTransporter".tr),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            "GlobalFilterGoldenTransporter".tr,
                                            color: Color(
                                                ListColor.colorLightGrey4),
                                            fontWeight: FontWeight.w600),
                                        FlutterSwitch(
                                            width: 40,
                                            value: _switchTypeOfTransporterTemp
                                                .value,
                                            onToggle: (val) {
                                              _switchTypeOfTransporterTemp
                                                  .value = val;
                                            }),
                                      ]),
                                  SizedBox(height: 20)
                                ],
                              ),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(Get.context).size.width,
                        height: 60,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      width: 1, color: Color(ListColor.color4)),
                                  color: Colors.white,
                                ),
                                child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Center(
                                          child: CustomText(
                                              "GlobalFilterButtonCancel".tr,
                                              color: Color(ListColor.color4),
                                              fontWeight: FontWeight.w700)),
                                    )),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      width: 1, color: Color(ListColor.color4)),
                                  color: Color(ListColor.color4),
                                ),
                                child: Material(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      onTap: () {
                                        _onSaveData();
                                        Get.back();
                                      },
                                      child: Center(
                                          child: CustomText(
                                              "GlobalFilterButtonSave".tr,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                    )),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ]),
          );
        });
  }

  Widget _filterWrap(
      String title,
      void Function() seeAll,
      Map<String, dynamic> mapNotChoosen,
      Map<String, dynamic> mapChoosen,
      void Function(bool value, String key) onTapItem,
      List<ItemWrap> listItem) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _textTitle(title),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      "GlobalFilterButtonShowAll".tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.color4),
                    ),
                  ),
                  onTap: seeAll,
                ),
              )
            ]),
        SizedBox(height: 10),
        Wrap(
          children: _getListWidgetWrap(
              mapNotChoosen, mapChoosen, onTapItem, listItem),
        )
      ],
    );
  }

  List<Widget> _getListWidgetWrap(
      Map<String, dynamic> mapNotChoosen,
      Map<String, dynamic> mapChoosen,
      void Function(bool value, String key) onTapItem,
      List<ItemWrap> listItem) {
    List<Widget> listData = [];
    if (_onClickWrap) {
      _onClickWrap = false;
      for (ItemWrap item in listItem) {
        listData.add(_getItemWrap(
            item.key, item.value, mapChoosen[item.key] != null, onTapItem));
      }
    } else {
      listItem.clear();
      if (mapChoosen.length >= mapNotChoosen.length) {
        mapChoosen.entries.forEach((element) {
          listData
              .add(_getItemWrap(element.key, element.value, true, onTapItem));
          listItem.add(ItemWrap(
              key: element.key, value: element.value, isChoosen: true));
        });
      } else if (mapChoosen.length > 0) {
        var mapNotChoosenCopy = Map.from(mapNotChoosen);
        mapChoosen.entries.forEach((element) {
          listData
              .add(_getItemWrap(element.key, element.value, true, onTapItem));
          listItem.add(ItemWrap(
              key: element.key, value: element.value, isChoosen: true));
          mapNotChoosenCopy.remove(element.key);
        });
        //mapNotChoosenCopy.entries.take(mapNotChoosen.length - mapChoosen.length);
        int count = mapNotChoosen.length - mapChoosen.length;
        int posMapNo = 0;
        for (var data in mapNotChoosenCopy.entries) {
          listData.add(_getItemWrap(data.key, data.value, false, onTapItem));
          listItem.add(
              ItemWrap(key: data.key, value: data.value, isChoosen: false));
          posMapNo++;
          if (posMapNo == count) break;
        }
      } else {
        mapNotChoosen.entries.forEach((element) {
          listData
              .add(_getItemWrap(element.key, element.value, false, onTapItem));
          listItem.add(ItemWrap(
              key: element.key, value: element.value, isChoosen: false));
        });
      }
    }

    return listData;
  }

  Widget _getItemWrap(String key, String title, bool isChoosen,
      void Function(bool value, String key) onTapItem) {
    double borderRadius = 20;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
            onTapItem(!isChoosen, key);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: CustomText(
              title,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textTitle(String title) {
    return CustomText(title,
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
  }

  void _setTextFirstEndDateTime(
      RxString dateTimeText, DateTime dateTime, String valueIfNull) {
    dateTimeText.value = dateTime == null
        ? valueIfNull
        : DateFormat('dd-MM-yyyy').format(dateTime);
  }

  Future<DateTime> _showDateTimePicker(DateTime initialDate) async {
    return await showDatePicker(
        context: Get.context,
        initialDate: initialDate == null ? DateTime.now() : initialDate,
        firstDate: DateTime(1800),
        lastDate: DateTime(2100));
  }

  Future _setFirstDateTimeTemp() async {
    // DateTime dateTime = await _showDateTimePicker(firstDateTemp);
    // if (dateTime != null) {
    //   firstDateTemp = dateTime;
    //   _setTextFirstEndDateTime(firstDateText, firstDateTemp, _hintFirstDate);
    // }
    _showDialogYearPicker(firstDateTemp, (value) {
      if (value != null) {
        firstDateTemp = value;
        _setTextFirstEndDateTime(firstDateText, firstDateTemp, _hintFirstDate);
      }
    });
  }

  Future _setEndDateTimeTemp() async {
    // DateTime dateTime = await _showDateTimePicker(endDateTemp);
    // if (dateTime != null) {
    //   endDateTemp = dateTime;
    //   _setTextFirstEndDateTime(endDateText, endDateTemp, _hintEndDate);
    // }
    _showDialogYearPicker(endDateTemp, (value) {
      if (value != null) {
        endDateTemp = value;
        _setTextFirstEndDateTime(endDateText, endDateTemp, _hintEndDate);
      }
    });
  }

  Future _setFirstDateTimeBergabungTemp() async {
    // DateTime dateTime = await _showDateTimePicker(firstDateTemp);
    // if (dateTime != null) {
    //   firstDateTemp = dateTime;
    //   _setTextFirstEndDateTime(firstDateText, firstDateTemp, _hintFirstDate);
    // }
    _showDialogYearPicker(firstDateBergabungTemp, (value) {
      if (value != null) {
        firstDateBergabungTemp = value;
        _setTextFirstEndDateTime(
            firstDateBergabungText, firstDateBergabungTemp, _hintFirstDate);
      }
    });
  }

  Future _setEndDateTimeBergabungTemp() async {
    // DateTime dateTime = await _showDateTimePicker(endDateTemp);
    // if (dateTime != null) {
    //   endDateTemp = dateTime;
    //   _setTextFirstEndDateTime(endDateText, endDateTemp, _hintEndDate);
    // }
    _showDialogYearPicker(endDateBergabungTemp, (value) {
      if (value != null) {
        endDateBergabungTemp = value;
        _setTextFirstEndDateTime(
            endDateBergabungText, endDateBergabungTemp, _hintEndDate);
      }
    });
  }

  void _resetAll() {
    firstDateTemp = null;
    endDateTemp = null;
    firstDateBergabungTemp = null;
    endDateBergabungTemp = null;
    _setTextFirstEndDateTime(firstDateText, firstDateTemp, _hintFirstDate);
    _setTextFirstEndDateTime(endDateText, endDateTemp, _hintEndDate);
    _setTextFirstEndDateTime(
        firstDateBergabungText, firstDateBergabungTemp, _hintFirstDate);
    _setTextFirstEndDateTime(
        endDateBergabungText, endDateBergabungTemp, _hintEndDate);
    listChoosenTempAreaService.clear();
    listChoosenTempTransporterLocation.clear();
    _switchTypeOfTransporterTemp.value = false;
    _setRangeValueUnit(0, _maxRangeValueUnit);
  }

  void _resetAllIncChoosen() {
    _resetAll();
    listChoosenTransporterLocation.clear();
    listChoosenAreaService.clear();
  }

  String _checkAllFilter() {
    //check date jika salah satu diisi
    if ((firstDateTemp != null || endDateTemp != null) &&
        !(firstDateTemp != null && endDateTemp != null)) {
      if (firstDateTemp == null) {
        firstDateTemp = DateTime(DateTime.now().year - 100, 1);
        _setTextFirstEndDateTime(firstDateText, firstDateTemp, _hintFirstDate);
      } else {
        endDateTemp = DateTime(DateTime.now().year, 1);
        _setTextFirstEndDateTime(endDateText, endDateTemp, _hintEndDate);
      }
    }

    if (firstDateTemp != null && endDateTemp != null) {
      if ((firstDateText.value != _hintFirstDate &&
              endDateText.value != _hintEndDate) &&
          firstDateTemp.year > endDateTemp.year) {
        return "GlobalFilterWarningFoundedYear".tr;
      }
    }

    if ((firstDateBergabungTemp != null || endDateBergabungTemp != null) &&
        !(firstDateBergabungTemp != null && endDateBergabungTemp != null)) {
      if (firstDateBergabungTemp == null) {
        firstDateBergabungTemp = DateTime(DateTime.now().year - 100, 1);
        _setTextFirstEndDateTime(
            firstDateBergabungText, firstDateBergabungTemp, _hintFirstDate);
      } else {
        endDateBergabungTemp = DateTime(DateTime.now().year, 1);
        _setTextFirstEndDateTime(
            endDateBergabungText, endDateBergabungTemp, _hintEndDate);
      }
    }

    if (firstDateBergabungTemp != null && endDateBergabungTemp != null) {
      if ((firstDateBergabungText.value != _hintFirstDate &&
              endDateBergabungText.value != _hintEndDate) &&
          firstDateBergabungTemp.year > endDateBergabungTemp.year) {
        return "GlobalFilterWarningFoundedYear".tr;
      }
    }

    if (double.parse(_startUnitRangeTextEditingController.value.text) >
        double.parse(_endUnitRangeTextEditingController.value.text)) {
      return "GlobalFilterWarningNumberOfTruck".tr;
    }
    return "";
  }

  void _onSaveData() {
    String error = _checkAllFilter();
    if (error == "") {
      firstDate = firstDateTemp;
      endDate = endDateTemp;
      firstDateBergabung = firstDateBergabungTemp;
      endDateBergabung = endDateBergabungTemp;
      rangeValues.value = _rangeValuesTemp.value;
      switchTypeOfTransporter.value = _switchTypeOfTransporterTemp.value;
      listChoosenAreaService.clear();
      listChoosenTransporterLocation.clear();
      listChoosenAreaService.addAll(
          listChoosenTempAreaService.map((key, value) => MapEntry(key, value)));
      listChoosenTransporterLocation.addAll(listChoosenTempTransporterLocation
          .map((key, value) => MapEntry(key, value)));
      Map<String, dynamic> mapData = {};
      if (listChoosenAreaService.length > 0 ||
          listChoosenTransporterLocation.length > 0 ||
          (firstDateText.value != _hintFirstDate &&
              endDateText.value != _hintEndDate) ||
          (firstDateBergabungText.value != _hintFirstDate &&
              endDateBergabungText.value != _hintEndDate) ||
          (rangeValues.value != RangeValues(0, _maxRangeValueUnit)) ||
          switchTypeOfTransporter.value) {
        mapData['Tahun'] = (firstDateText.value == _hintFirstDate ||
                endDateText.value == _hintEndDate)
            ? ""
            : firstDate.year.toString() + "," + endDate.year.toString();
        mapData['Join'] = (firstDateBergabungText.value == _hintFirstDate ||
                endDateBergabungText.value == _hintEndDate)
            ? ""
            : firstDateBergabung.year.toString() +
                "," +
                endDateBergabung.year.toString();
        mapData['Qty'] = rangeValues.value.start.round().toInt().toString() +
            "," +
            rangeValues.value.end.round().toInt().toString();
        mapData['AreaLayanan'] = _convertKey(listChoosenAreaService);
        mapData['TransporterKota'] =
            _convertKey(listChoosenTransporterLocation);
        mapData['Gold'] = switchTypeOfTransporter.value ? "1" : "0";
        mapData['Join'] = "";
      }
      returnData(mapData);
    } else {}
  }

  Future _getCity() async {
    _isGettingDataCity.value = true;
    var resultArea =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchAllCity();
    List dataArea = resultArea["Data"];
    dataArea.forEach((element) {
      _listCity[element["ID"].toString()] = element["Kota"];
      //kota[element["ID"]] = element["Kota"];
    });
    Map<String, dynamic> copyData = {};
    int pos = 0;
    for (var entry in _listCity.entries) {
      copyData[entry.key] = entry.value;
      pos++;
      if (pos == _maxDataWrapFilter) break;
    }
    listNotChoosenTransporterLocation.addAll(copyData);
    listNotChoosenAreaService.addAll(copyData);
    _isGettingDataCity.value = false;
  }

  void showAllArea(RxMap<dynamic, dynamic> listTemp, String title) {
    listChoosenTempShowAll.clear();
    listChoosenTempShowAll.addAll(listTemp);
    listAllShowAll.clear();
    listAllShowAll.addAll(_listCity);
    showModalBottomSheet(
        context: Get.context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 150),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title, fontSize: 18, fontWeight: FontWeight.bold),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          color: Colors.white),
                      child: CustomTextField(
                        context: Get.context,
                        newInputDecoration: InputDecoration(),
                        onChanged: (String str) {
                          listAllShowAll.clear();
                          listAllShowAll.addAll(Map.from(_listCity)
                            ..removeWhere((key, value) => !value
                                .toString()
                                .toLowerCase()
                                .contains(str.toLowerCase())));
                        },
                      )),
                  Expanded(
                      child: Obx(
                    () => ListView.builder(
                      itemCount: listAllShowAll.values.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Theme(
                              data: Theme.of(Get.context).copyWith(
                                  unselectedWidgetColor:
                                      Color(ListColor.color4)),
                              child: Obx(
                                () => CheckboxListTile(
                                  activeColor: Color(ListColor.color4),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                  onChanged: (checked) {
                                    var areaID =
                                        listAllShowAll.keys.elementAt(index);
                                    if (checked) {
                                      listChoosenTempShowAll[areaID] =
                                          listAllShowAll[areaID];
                                      // if (target == "kota") {
                                      //   listTemp[areaID] = _listCity[areaID];
                                      // } else {
                                      //   tempFilterAreaLayanan[areaID] =
                                      //       filteredKota[areaID];
                                      // }
                                    } else {
                                      listChoosenTempShowAll.removeWhere(
                                          (key, value) => key == areaID);
                                      // if (target == "kota") {
                                      //   tempFilterKota.removeWhere(
                                      //       (key, value) => key == areaID);
                                      // } else {
                                      //   tempFilterAreaLayanan.removeWhere(
                                      //       (key, value) => key == areaID);
                                      // }
                                    }
                                    //updateWrap();
                                  },
                                  value: listChoosenTempShowAll.keys.contains(
                                      listAllShowAll.keys.elementAt(index)),
                                  // (target == "kota")
                                  //     ? tempFilterKota.keys
                                  //         .contains(kota.keys.elementAt(index))
                                  //     : tempFilterAreaLayanan.keys.contains(
                                  //         filteredKota.keys.elementAt(index)),
                                  title: CustomText(
                                      listAllShowAll.values.elementAt(index)),
                                ),
                              ),
                            ),
                            index == (listAllShowAll.values.length - 1)
                                ? SizedBox.shrink()
                                : Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    height: 0.5,
                                    color: Color(
                                        ListColor.colorLightGrey5WithOpacity))
                          ],
                        );
                      },
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        listTemp.clear();
                        listTemp.addAll(listChoosenTempShowAll);
                        Navigator.of(Get.context).pop();
                      },
                      child: CustomText("ListTransporterLabelSubmit".tr,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  String _convertKey(Map<String, dynamic> map) {
    String result = "";
    for (var data in map.entries) {
      result += result == "" ? data.key : ("," + data.key);
    }
    return result;
  }

  void clearFilter() {
    _resetAllIncChoosen();
  }

  void setListCityManual(Map<String, dynamic> listCity) {
    _listCity.addAll(listCity);
  }

  Map<String, dynamic> getListCity() {
    return _listCity;
  }

  void _setRangeValueUnit(double start, double end,
      {bool isUpdateRangeValues = true,
      bool isUpdateTextEditingController = true}) {
    if (start <= end && end <= _maxRangeValueUnit) {
      if (isUpdateRangeValues) _rangeValuesTemp.value = RangeValues(start, end);
      if (isUpdateTextEditingController) {
        _startUnitRangeTextEditingController.value.text =
            start.round().toInt().toString();
        _endUnitRangeTextEditingController.value.text =
            end.round().toInt().toString();
      }
    }
  }

  void _showDialogYearPicker(
      DateTime dateTime, void Function(DateTime) onChange) {
    showDialog(
        context: Get.context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: YearPicker(
                      firstDate: DateTime(DateTime.now().year - 100, 1),
                      lastDate: DateTime(DateTime.now().year, 1),
                      initialDate: DateTime.now(),
                      selectedDate: dateTime ?? DateTime.now(),
                      onChanged: (value) {
                        onChange(value);
                        Get.back();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class ItemWrap {
  final String key;
  final String value;
  bool isChoosen;

  ItemWrap({this.key, this.value, this.isChoosen});
}
