import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/onchange_textfield_number.dart';
import 'package:muatmuat/app/core/models/head_truck_response_model.dart';
import 'package:muatmuat/app/core/models/radio_button_filter_model.dart';
import 'package:muatmuat/app/core/models/checkbox_filter_model.dart';
import 'package:muatmuat/app/core/models/search_area_pickup_filter_model.dart';
import 'package:muatmuat/app/core/models/search_area_pickup_response_model.dart';
import 'package:muatmuat/app/core/models/transporter_area_pickup_filter_model.dart';
import 'package:muatmuat/app/core/models/transporter_area_pickup_response_model.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_response_model.dart';
import 'package:muatmuat/app/core/models/head_truck_model.dart';
import 'package:muatmuat/app/modules/choose_ekspetasi_destinasi/choose_ekspetasi_destinasi_controller.dart';
import 'package:muatmuat/app/modules/list_area_pickup_search_filter/list_area_pickup_search_filter_controller.dart';
import 'package:muatmuat/app/modules/list_area_pickup_transporter_filter/list_area_pickup_transporter_filter_controller.dart';
import 'package:muatmuat/app/modules/list_city_filter/list_city_filter_controller.dart';
import 'package:muatmuat/app/modules/list_truck_carrier_filter/list_truck_carrier_filter_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class FilterCustomController extends GetxController {
  double _maxRangeValueUnit = 10000;

  //KEY MAP
  //Date
  final String _firstDateTextKey = "FirstDateText";
  final String _endDateTextKey = "EndDateText";
  final String _firstDateKey = "FirstDate";
  final String _endDateKey = "EndDate";
  final String _firstDateTempKey = "FirstDateTemp";
  final String _endDateTempKey = "EndDateTemp";
  final String _firstDefaultTextKey = "FirstDefaultText";
  final String _endDefaultTextKey = "EndDefaultText";
  final String _errorMessageDateKey = "ErrorMessageDate";

  //Switch
  final String _switchKey = "Switch";
  final String _switchTempKey = "SwitchTemp";

  //City / Wrap Item / Truck/ Carrier / Area Pickup Search / Area Pickup Transporter
  final String _listNotChoosenKey = "ListNotChoosen";
  final String _listChoosenKey = "ListChoosen";
  final String _listChoosenTempKey = "ListNotChoosenTemp";
  final String _listDataInViewKey = "ListDataInView";
  final String _isFromSeeAllOrFirstTimeKey = "IsFromSeeAll";
  int indexAreaPickupSearch = 0;
  int indexAreaPickupTransporter = 0;

  //Unit
  final String _rangeValuesKey = "rangeValues";
  final String _rangeValuesTempKey = "rangeValuesTemp";
  final String _startUnitRangeTextEditingControllerKey =
      "StartUnitRangeTextEditingController";
  final String _endUnitRangeTextEditingControllerKey =
      "EndUnitRangeTextEditingController";
  final String _errorMessageUnitKey = "ErrorMessageUnit";
  final String _isAlreadyLoadDataKey = "IsAlreadyLoadData";
  final String _loadDataUnitKey = "LoadDataUnit";

  //Radio Button
  final String _radioButtonKey = "RadioButton";
  final String _radioButtonTempKey = "RadioButtonTemp";

  //Checkbox
  final String _checkboxKey = "CheckBox";
  final String _checkboxTempKey = "CheckBoxTemp";

  //Name
  final String _nameKey = "Name";
  final String _nameTempKey = "NameTemp";
  final String _nameTextEditingControllerKey = "NameTextEditingController";

  // final String _radioButtonValueKey = "RadioButtonValue";
  // final String _radioButtonValueTempKey = "RadioButtonValueTemp";

  Map<String, dynamic> _listCity = {};
  Map<String, dynamic> _listTruck = {};
  Map<String, dynamic> _listCarrier = {};
  Map<String, dynamic> _listAreaPickupSearch = {};
  Map<String, dynamic> _listAreaPickupTransporter = {};
  Map<String, dynamic> _listEkspektasiDestinasi = {};

  List<HeadTruckModel> _listTruckModel = [];
  List<CarrierTruckModel> _listCarrierModel = [];
  List<SearchAreaPickupFilterModel> _listAreaPickupSearchModel = [];
  List<SearchAreaPickupFilterModel> _listAreaPickupSearchModelFull = [];
  List<TransporterAreaPickupFilterModel> _listAreaPickupTransporterModel = [];
  List<TransporterAreaPickupFilterModel> _listAreaPickupTransporterModelFull =
      [];

  var _filterheight = MediaQuery.of(Get.context).size.height - 200;
  final _listVariable = {}.obs;

  final _isGettingData = false.obs;
  final _isSuccessGettingData = true.obs;

  final int _maxDataWrapFilter = 5;

  void Function(Map<String, dynamic>) returnData;
  final List<WidgetFilterModel> listWidgetInFilter;

  final String _hintFirstDate = "GlobalFilterHintFirstDate".tr;
  final String _hintEndDate = "GlobalFilterHintEndDate".tr;
  final String _hintFirstYear = "GlobalFilterHintFirstYear".tr;
  final String _hintEndYear = "GlobalFilterHintEndYear".tr;

  bool _isCity = false;
  bool _isUnit = false;
  bool _isTruck = false;
  bool _isCarrier = false;
  bool _isAreaPickupSearch = false;
  bool _isAreaPickupTransporter = false;
  bool _isEkspektasiDestinasi = false;

  FilterCustomController(
      {@required this.returnData, @required this.listWidgetInFilter});

  @override
  void onInit() {
    _showPrint("_checkListWidgetInFilter: onInit");
    _checkListWidgetInFilter(onDate: (index) {
      _listVariable[index.toString()] = {
        _firstDateTextKey:
            listWidgetInFilter[index].typeInFilter == TypeInFilter.YEAR
                ? _hintFirstYear
                : _hintFirstDate,
        _endDateTextKey:
            listWidgetInFilter[index].typeInFilter == TypeInFilter.YEAR
                ? _hintEndYear
                : _hintEndDate,
        _firstDateKey: DateTime.now(),
        _endDateKey: DateTime.now(),
        _firstDateTempKey: DateTime.now(),
        _endDateTempKey: DateTime.now(),
        _firstDefaultTextKey:
            listWidgetInFilter[index].typeInFilter == TypeInFilter.YEAR
                ? _hintFirstYear
                : _hintFirstDate,
        _endDefaultTextKey:
            listWidgetInFilter[index].typeInFilter == TypeInFilter.YEAR
                ? _hintEndYear
                : _hintEndDate,
        _errorMessageDateKey: ""
      };
      _listVariable[index.toString()][_firstDateKey] = null;
      _listVariable[index.toString()][_endDateKey] = null;
      _listVariable[index.toString()][_firstDateTempKey] = null;
      _listVariable[index.toString()][_endDateTempKey] = null;
    }, onCity: (index) {
      _initForWrap(index);
    }, onSwitch: (index) {
      _listVariable[index.toString()] = {
        _switchKey: false,
        _switchTempKey: false
      };
    }, onUnit: (index) {
      double min = 0;
      double max = _maxRangeValueUnit;
      //_listVariable[index.toString()][_loadDataUnitKey] = null;

      if (listWidgetInFilter[index].customValue != null) {
        min = listWidgetInFilter[index].customValue[0];
        max = listWidgetInFilter[index].customValue[1];
      }
      _listVariable[index.toString()] = {
        _rangeValuesKey: RangeValues(
            min,
            (listWidgetInFilter[index].initValue ?? []).length > min
                ? (double.tryParse(listWidgetInFilter[index].initValue[0]) ??
                    max)
                : max),
        _rangeValuesTempKey: RangeValues(
            min,
            (listWidgetInFilter[index].initValue ?? []).length > min
                ? (double.tryParse(listWidgetInFilter[index].initValue[0]) ??
                    max)
                : max),
        _startUnitRangeTextEditingControllerKey: TextEditingController(),
        _endUnitRangeTextEditingControllerKey: TextEditingController(),
        _errorMessageUnitKey: "",
        _isAlreadyLoadDataKey: false,
      };
      if (listWidgetInFilter[index].customValue != null &&
          listWidgetInFilter[index].customValue.length > 2) {
        _listVariable[index.toString()][_loadDataUnitKey] =
            listWidgetInFilter[index].customValue[2];
      }
      _setRangeValueUnit(
          _listVariable[index.toString()][_rangeValuesTempKey].start,
          _listVariable[index.toString()][_rangeValuesTempKey].end,
          index,
          isUpdateTextEditingController: true);
    }, onTruck: (index) {
      _initForWrap(index);
    }, onCarrier: (index) {
      _initForWrap(index);
    }, onRadioButton: (index) {
      _listVariable[index.toString()] = {
        _radioButtonKey: "",
        _radioButtonTempKey: "",
      };
    }, onCheckbox: (index) {
      _listVariable[index.toString()] = {
        _checkboxKey: [],
        _checkboxTempKey: [],
      };
    }, onEkspektasiDestinasi: (index) {
      _initForWrap(index);
    }, onName: (index) {
      _listVariable[index.toString()] = {
        _nameKey: "",
        _nameTempKey: "",
        _nameTextEditingControllerKey: TextEditingController(),
      };
    }, onAreaPickupSearch: (index) {
      indexAreaPickupSearch = index;
      _initForWrap(index);
    }, onAreaPickupTransporter: (index) {
      indexAreaPickupTransporter = index;
      _initForWrap(index);
    });
    super.onInit();
  }

  void _initForWrap(int index) {
    _listVariable[index.toString()] = {
      _listNotChoosenKey: {},
      _listChoosenKey: {},
      _listChoosenTempKey: {},
      _listDataInViewKey: List<ItemWrap>.from([]),
      _isFromSeeAllOrFirstTimeKey: true,
    };
  }

  void _addWidgetToContent(List<Widget> listWidgetContent, Widget widget) {
    if (listWidgetContent.length > 0) listWidgetContent.add(_lineSeparator());
    listWidgetContent.add(widget);
  }

  List<Widget> _getListWidgetCotent() {
    List<Widget> listWidgetContent = [];
    _showPrint("_checkListWidgetInFilter: _getListWidgetCotent");
    _checkListWidgetInFilter(
      onDate: (index) {
        _addWidgetToContent(
          listWidgetContent,
          _dateWidget(listWidgetInFilter[index].label[0], _listVariable[index.toString()], index)
        );
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onCity: (index) {
        _addWidgetCityWrapToContent(index, listWidgetContent);
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onSwitch: (index) {
        _addWidgetToContent(
          listWidgetContent,
          _switchWidget(listWidgetInFilter[index].label, index)
        );
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onUnit: (index) {
        _addWidgetToContent(
          listWidgetContent,
          _unitWidget(listWidgetInFilter[index].label, index));
      }, 
      onTruck: (index) {
        _addWidgetTruckWrapToContent(index, listWidgetContent);
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onCarrier: (index) {
        _addWidgetCarrierWrapToContent(index, listWidgetContent);
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onRadioButton: (index) {
        _addWidgetToContent(
          listWidgetContent,
          _radioButtonWidget(listWidgetInFilter[index].label, index, listWidgetInFilter[index].customValue)
        );
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onCheckbox: (index) {
        _addWidgetToContent(
          listWidgetContent,
          _checkboxWidget(listWidgetInFilter[index].label, index, listWidgetInFilter[index].customValue)
        );
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onEkspektasiDestinasi: (index) {
        _addWidgetEkspektasiDestinasiWrapToContent(index, listWidgetContent);
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onName: (index) {
        _addWidgetToContent(
          listWidgetContent, 
          _nameWidget(listWidgetInFilter[index].label, index)
        );
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onAreaPickupSearch: (index) {
        indexAreaPickupSearch = index;
        _addWidgetAreaPickupSearchToContent(index, listWidgetContent);
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }, 
      onAreaPickupTransporter: (index) {
        indexAreaPickupTransporter = index;
        _addWidgetAreaPickupTransporterToContent(index, listWidgetContent);
        listWidgetContent.add(SizedBox(height: GlobalVariable.ratioHeight(Get.context) * 20));
      }
    );
    
    return listWidgetContent;
  }

  void _addWidgetCityWrapToContent(int index, List<Widget> listWidgetContent) {
    _addWidgetToContent(
        listWidgetContent,
        _wrapItemWidget(listWidgetInFilter[index].label[0], index,
            seeAll: () async {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(_listVariable[index.toString()]);
          var result = await GetToPage.toNamed<ListCityFilterController>(
              Routes.LIST_CITY_FILTER,
              arguments: [
                _listCity,
                mapData[_listChoosenTempKey],
                listWidgetInFilter[index].label[1] ?? "",
                listWidgetInFilter[index].label[2] ?? "",
              ],
              preventDuplicates: false);
          // var result = await Get.toNamed(Routes.LIST_CITY_FILTER,
          //     arguments: [
          //       _listCity,
          //       mapData[_listChoosenTempKey],
          //       "Cari Ekspektasi Destinasi"
          //     ],
          //     preventDuplicates: false);
          if (result != null) {
            _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
            mapData[_listChoosenTempKey].clear();
            mapData[_listChoosenTempKey].addAll(result);
            _listVariable.refresh();
          }
        }));
  }

  void _addWidgetEkspektasiDestinasiWrapToContent(
      int index, List<Widget> listWidgetContent) {
    _addWidgetToContent(
        listWidgetContent,
        _wrapItemWidget(listWidgetInFilter[index].label[0], index,
            seeAll: () async {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(_listVariable[index.toString()]);
          var result =
              await GetToPage.toNamed<ChooseEkspetasiDestinasiController>(
                  Routes.CHOOSE_EKSPETASI_DESTINASI,
                  arguments: [mapData[_listChoosenTempKey]],
                  preventDuplicates: false);
          // var result = await Get.toNamed(Routes.CHOOSE_EKSPETASI_DESTINASI,
          //     arguments: [mapData[_listChoosenTempKey]],
          //     preventDuplicates: false);
          if (result != null) {
            _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
            mapData[_listChoosenTempKey].clear();
            mapData[_listChoosenTempKey].addAll(result);
            _listVariable.refresh();
          }
          Timer(Duration(milliseconds: 300), () {
            Get.delete<ChooseEkspetasiDestinasiController>();
          });
        }));
  }

  void _addWidgetTruckWrapToContent(int index, List<Widget> listWidgetContent) {
    _addWidgetToContent(
        listWidgetContent,
        _wrapItemWidget(listWidgetInFilter[index].label[0], index,
            seeAll: () async {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(_listVariable[index.toString()]);
          var result =
              await GetToPage.toNamed<ListTruckCarrierFilterController>(
                  Routes.LIST_TRUCK_CARRIER_FILTER,
                  arguments: [
                    List.from(_listTruckModel),
                    mapData[_listChoosenTempKey],
                    "Jenis Truck".tr,
                  ],
                  preventDuplicates: false);
          // var result = await Get.toNamed(Routes.LIST_TRUCK_CARRIER_FILTER,
          //     arguments: [
          //       List.from(_listTruckModel),
          //       mapData[_listChoosenTempKey],
          //       "Jenis Truck".tr,
          //     ],
          //     preventDuplicates: false);
          if (result != null) {
            _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
            mapData[_listChoosenTempKey].clear();
            mapData[_listChoosenTempKey].addAll(result);
            _listVariable.refresh();
          }
          Timer(Duration(milliseconds: 300), () {
            Get.delete<ListTruckCarrierFilterController>();
          });
        }));
  }

  void _addWidgetCarrierWrapToContent(
      int index, List<Widget> listWidgetContent) {
    _addWidgetToContent(
        listWidgetContent,
        _wrapItemWidget(listWidgetInFilter[index].label[0], index,
            seeAll: () async {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(_listVariable[index.toString()]);
          var result =
              await GetToPage.toNamed<ListTruckCarrierFilterController>(
                  Routes.LIST_TRUCK_CARRIER_FILTER,
                  arguments: [
                    List.from(_listCarrierModel),
                    mapData[_listChoosenTempKey],
                    "Jenis Carrier".tr,
                  ],
                  preventDuplicates: false);
          if (result != null) {
            _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
            mapData[_listChoosenTempKey].clear();
            mapData[_listChoosenTempKey].addAll(result);
            _listVariable.refresh();
          }
          Timer(Duration(milliseconds: 300), () {
            Get.delete<ListTruckCarrierFilterController>();
          });
        }));
  }

  void _addWidgetAreaPickupSearchToContent(
      int index, List<Widget> listWidgetContent) {
    _addWidgetToContent(
        listWidgetContent,
        _searchAreaPickupWidget(listWidgetInFilter[index].label[0], index,
            seeAll: () async {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(_listVariable[index.toString()]);
          var result =
              await GetToPage.toNamed<ListAreaPickupSearchFilterController>(
                  Routes.LIST_AREA_PICKUP_SEARCH_FILTER,
                  arguments: [
                    _listAreaPickupSearchModelFull,
                    mapData[_listChoosenTempKey],
                  ],
                  preventDuplicates: false);
          // var result = await Get.toNamed(Routes.LIST_AREA_PICKUP_SEARCH_FILTER,
          //     arguments: [
          //       _listAreaPickupSearchModelFull,
          //       mapData[_listChoosenTempKey],
          //     ],
          //     preventDuplicates: false);
          if (result != null) {
            _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
            try {
              mapData[_listChoosenTempKey].clear();
              mapData[_listChoosenTempKey].addAll(result);
              _listVariable.refresh();
            } catch (error) {
              print(error.toString());
            }
          }
          Timer(Duration(milliseconds: 300), () {
            Get.delete<ListAreaPickupSearchFilterController>();
          });
        }));
  }

  void _addWidgetAreaPickupTransporterToContent(
      int index, List<Widget> listWidgetContent) {
    _addWidgetToContent(
        listWidgetContent,
        _transporterAreaPickupWidget(listWidgetInFilter[index].label[0], index,
            seeAll: () async {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(_listVariable[index.toString()]);
          var listParent = [];
          _listAreaPickupTransporterModelFull.forEach((element) {
            var indexPosition =
                _listAreaPickupTransporterModelFull.indexOf(element);
            if (indexPosition == 0 ||
                _listAreaPickupTransporterModelFull[indexPosition - 1]
                        .kategori !=
                    _listAreaPickupTransporterModelFull[indexPosition]
                        .kategori) {
              listParent.add(element.kategori);
            }
          });
          var result = await GetToPage.toNamed<
                  ListAreaPickupTransporterFilterController>(
              Routes.LIST_AREA_PICKUP_TRANSPORTER_FILTER,
              arguments: [
                _listAreaPickupTransporterModelFull,
                listParent,
                mapData[_listChoosenTempKey],
              ],
              preventDuplicates: false);
          // var result =
          //     await Get.toNamed(Routes.LIST_AREA_PICKUP_TRANSPORTER_FILTER,
          //         arguments: [
          //           _listAreaPickupTransporterModelFull,
          //           listParent,
          //           mapData[_listChoosenTempKey],
          //         ],
          //         preventDuplicates: false);
          if (result != null) {
            _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
            try {
              mapData[_listChoosenTempKey].clear();
              mapData[_listChoosenTempKey].addAll(result);
              _listVariable.refresh();
            } catch (error) {
              print(error.toString());
            }
          }
          Timer(Duration(milliseconds: 300), () {
            Get.delete<ListAreaPickupTransporterFilterController>();
          });
        }));
  }

  void _addWidgetWrapToContent(int index, List<Widget> listWidgetContent) {
    _addWidgetToContent(listWidgetContent,
        _wrapItemWidget(listWidgetInFilter[index].label[0], index));
  }

  Widget _lineSeparator() {
    return Container(
        margin: EdgeInsets.only(bottom: 16),
        // margin: EdgeInsets.symmetric(vertical: 16),
        height: 0.5,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey5).withOpacity(0.29));
  }

  Future _initShowFilter() async {
    _showPrint("_checkListWidgetInFilter: _initShowFilter");
    _checkListWidgetInFilter(onDate: (index) {
      _listVariable[index.toString()][_firstDateTempKey] =
          _listVariable[index.toString()][_firstDateKey];
      _listVariable[index.toString()][_endDateTempKey] =
          _listVariable[index.toString()][_endDateKey];
      _setTextFirstEndDateTime(
          _listVariable[index.toString()],
          _firstDateTextKey,
          _listVariable[index.toString()][_firstDateTempKey],
          _listVariable[index.toString()][_firstDefaultTextKey],
          index);
      _setTextFirstEndDateTime(
          _listVariable[index.toString()],
          _endDateTextKey,
          _listVariable[index.toString()][_endDateTempKey],
          _listVariable[index.toString()][_endDefaultTextKey],
          index);
    }, onCity: (index) {
      _isCity = true;
      _onInitShowFilterWrap(index);
    }, onSwitch: (index) {
      _listVariable[index.toString()][_switchTempKey] =
          _listVariable[index.toString()][_switchKey];
    }, onUnit: (index) {
      _isUnit = true;
      if (listWidgetInFilter[index].customValue != null) {
        double min = _listVariable[index.toString()][_rangeValuesTempKey].start;
        double max = _listVariable[index.toString()][_rangeValuesTempKey].end;
        if (listWidgetInFilter[index].customValue[0] >
            _listVariable[index.toString()][_rangeValuesTempKey].start) {
          min = listWidgetInFilter[index].customValue[0];
        }
        if (listWidgetInFilter[index].customValue[1] <
            _listVariable[index.toString()][_rangeValuesTempKey].end) {
          max = listWidgetInFilter[index].customValue[1];
        }
        _setRangeValueUnit(min, max, index,
            isUpdateRangeValues: true, isUpdateTextEditingController: true);
      } else {
        _listVariable[index.toString()][_rangeValuesTempKey] =
            _listVariable[index.toString()][_rangeValuesKey];
        _setRangeValueUnit(
            _listVariable[index.toString()][_rangeValuesTempKey].start,
            _listVariable[index.toString()][_rangeValuesTempKey].end,
            index,
            isUpdateTextEditingController: true);
      }
    }, onTruck: (index) {
      _isTruck = true;
      _onInitShowFilterWrap(index);
    }, onCarrier: (index) {
      _isCarrier = true;
      _onInitShowFilterWrap(index);
    }, onRadioButton: (index) {
      _listVariable[index.toString()][_radioButtonTempKey] =
          _listVariable[index.toString()][_radioButtonKey];
    }, onCheckbox: (index) {
      _listVariable[index.toString()][_checkboxTempKey] =
          _listVariable[index.toString()][_checkboxKey];
    }, onEkspektasiDestinasi: (index) {
      _isEkspektasiDestinasi = true;
      _onInitShowFilterWrap(index);
    }, onName: (index) {
      _listVariable[index.toString()][_nameTempKey] =
          _listVariable[index.toString()][_nameKey];
      _listVariable[index.toString()][_nameTextEditingControllerKey].text =
          _listVariable[index.toString()][_nameTempKey];
    }, onAreaPickupSearch: (index) {
      indexAreaPickupSearch = index;
      _isAreaPickupSearch = true;
      _onInitShowFilterWrap(index);
    }, onAreaPickupTransporter: (index) {
      indexAreaPickupTransporter = index;
      _isAreaPickupTransporter = true;
      _onInitShowFilterWrap(index);
    });

    await _gettingDataVariable();
  }

  Future _gettingDataVariable() async {
    _isGettingData.value = true;
    //_isSuccessGettingData.value = true;
    bool success = true;

    if (_isUnit) {
      for (int index = 0; index < listWidgetInFilter.length; index++) {
        if (listWidgetInFilter[index].typeInFilter == TypeInFilter.UNIT) {
          if (!_listVariable[index.toString()][_isAlreadyLoadDataKey] &&
              _listVariable[index.toString()].containsKey(_loadDataUnitKey)) {
            var result =
                await _listVariable[index.toString()][_loadDataUnitKey]();
            if (result != null) {
              _listVariable[index.toString()][_isAlreadyLoadDataKey] = true;
              //_isSuccessGettingData.value = true;
              success = true;
              _maxRangeValueUnit = result.toDouble();
              listWidgetInFilter[index].customValue[1] = _maxRangeValueUnit;
              _listVariable[index.toString()][_rangeValuesKey] = RangeValues(
                  0,
                  (listWidgetInFilter[index].initValue ?? []).length > 0
                      ? (double.tryParse(
                              listWidgetInFilter[index].initValue[0]) ??
                          _maxRangeValueUnit)
                      : _maxRangeValueUnit);
              _setRangeValueUnit(0.0, _maxRangeValueUnit, index);
            } else {
              //_isSuccessGettingData.value = false;
              success = true;
            }
          }
        }
      }
    }

    if (success && _isCity && _listCity.length == 0) {
      //_isSuccessGettingData.value = await _getCity();
      success = await _getCity();
    }

    if (success && _isTruck && _listTruck.length == 0) {
      success = await _getHeadTruck();
    }

    if (success && _isCarrier && _listCarrier.length == 0) {
      success = await _getCarrierTruck();
    }

    if (_isSuccessGettingData.value &&
        _isAreaPickupSearch &&
        _listAreaPickupSearch.length == 0) {
      var getCustomValue =
          listWidgetInFilter[indexAreaPickupSearch].customValue;
      success = await _getAreaPickupSearch(getCustomValue[0], getCustomValue[1],
          getCustomValue[2], getCustomValue[3], getCustomValue[4]);
    }

    if (success &&
        _isAreaPickupTransporter &&
        _listAreaPickupTransporter.length == 0) {
      var getCustomValue =
          listWidgetInFilter[indexAreaPickupTransporter].customValue;
      success = await _getAreaPickupTransporter(getCustomValue[0]);
    }

    if (success &&
        _isEkspektasiDestinasi &&
        _listEkspektasiDestinasi.length == 0) {
      success = await _getEkspektasiDestinasi();
    }
    _isGettingData.value = false;
    _isSuccessGettingData.value = success;
  }

  void _onInitShowFilterWrap(int index) {
    _listVariable[index.toString()][_listChoosenTempKey].clear();
    _listVariable[index.toString()][_listChoosenTempKey]
        .addAll(_listVariable[index.toString()][_listChoosenKey]);
  }

  Future showFilter() async {
    _initShowFilter();
    await showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20))),
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
                        bottom: GlobalVariable.ratioWidth(Get.context) * 17),
                    child: Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: GlobalVariable.ratioWidth(Get.context) * 3,
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey16),
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 4))),
                    )),
                Container(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 12,
                        right: GlobalVariable.ratioWidth(Get.context) * 12,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: CustomText("GlobalFilterTitle".tr,
                                fontWeight: FontWeight.w700,
                                color: Color(ListColor.color4),
                                fontSize: 14)),
                        Padding(
                          padding: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: SvgPicture.asset(
                                  "assets/ic_close1,5.svg",
                                  color: Color(ListColor.colorBlack),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                ))),
                          ),
                        ),
                        Obx(
                          () => _isSuccessGettingData.value &&
                                  !_isGettingData.value
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      16),
                                          child: CustomText(
                                            "GlobalFilterButtonReset".tr,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor.color4),
                                          ),
                                        ),
                                        onTap: () {
                                          _resetAll();
                                        }),
                                  ),
                                )
                              : SizedBox.shrink(),
                        )
                      ],
                    )),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: _filterheight,
                        minHeight: 0,
                        minWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 15),
                      child: Obx(
                        () => _isGettingData.value
                            ? Container(
                                width: MediaQuery.of(Get.context).size.width,
                                height: 200,
                                child: Center(
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator())))
                            : _isSuccessGettingData.value
                                ? (_listVariable.isNotEmpty
                                    ? ListView(
                                        shrinkWrap: true,
                                        children: _getListWidgetCotent(),
                                      )
                                    : SizedBox.shrink())
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
                                            fontSize: 14,
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                              onTap: () {
                                                _gettingDataVariable();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: CustomText(
                                                  'GlobalButtonTryAgain'.tr,
                                                  fontSize: 14,
                                                  color:
                                                      Color(ListColor.color4),
                                                ),
                                              ))
                                          // OutlinedButton(
                                          //   style: OutlinedButton.styleFrom(
                                          //       backgroundColor:
                                          //           Color(ListColor.color4),
                                          //       side: BorderSide(
                                          //           width: 2,
                                          //           color: Color(
                                          //               ListColor.color4)),
                                          //       shape: RoundedRectangleBorder(
                                          //         borderRadius:
                                          //             BorderRadius.all(
                                          //                 Radius.circular(20)),
                                          //       )),
                                          //   onPressed: () {
                                          //     _gettingDataVariable(
                                          //         setIsSuccesFalse: false);
                                          //   },
                                          //   child: Container(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 25, vertical: 10),
                                          //     child: Text(
                                          //         "GlobalButtonTryAgain".tr,
                                          //         style: TextStyle(
                                          //             fontWeight:
                                          //                 FontWeight.w600,
                                          //             color: Color(ListColor.color4))),
                                          //   ),
                                          // ),
                                        ])),
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16,
                          vertical:
                              GlobalVariable.ratioHeight(Get.context) * 10),
                      width: MediaQuery.of(Get.context).size.width,
                      height: GlobalVariable.ratioHeight(Get.context) * 56,
                      child: Obx(
                        () => _isSuccessGettingData.value &&
                                !_isGettingData.value
                            ? Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.back();
                                      },
                                      child: Container(
                                        height: GlobalVariable.ratioWidth(Get.context) * 32,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(ListColor.color4),
                                            width: GlobalVariable.ratioWidth(Get.context) * 1
                                          )                                                                                    ,
                                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 26),
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            "GlobalFilterButtonCancel".tr,
                                            color: Color(ListColor.color4),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            height: 1.2,
                                          )
                                        )
                                      )
                                    )
                                  ),
                                  SizedBox(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        _onSaveData();
                                      },
                                      child: Container(
                                        height: GlobalVariable.ratioWidth(Get.context) * 32,
                                        decoration: BoxDecoration(
                                          color: Color(ListColor.color4),
                                          border: Border.all(
                                            color: Color(ListColor.color4),
                                            width: GlobalVariable.ratioWidth(Get.context) * 1
                                          ),                                                                                    
                                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 26),
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            "GlobalFilterButtonSave".tr,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            height: 1.2,
                                          )
                                        )
                                      )
                                    )
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      )),
                )
              ],
            ),
          ));
        });
  }

  Widget _filterWrap(
      String title,
      void Function() seeAll,
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textTitle(title),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioHeight(Get.context) * 1,
                      ),
                      child: countBadge(_listVariable[index.toString()]
                              [_listChoosenTempKey]
                          .length),
                    ),
                  ],
                )),
                seeAll != null
                    ? Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 10,
                                // right:
                                //     GlobalVariable.ratioWidth(Get.context) * 10,
                                top: GlobalVariable.ratioHeight(Get.context) *
                                    1),
                            child: CustomText(
                              "GlobalFilterButtonShowAll".tr,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.color4),
                            ),
                          ),
                          onTap: seeAll,
                        ),
                      )
                    : SizedBox.shrink()
              ]),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
          Wrap(
            spacing: GlobalVariable.ratioWidth(Get.context) * 8,
            children: _getListWidgetWrap(onTapItem, index),
          )
        ],
      ),
    );
  }

  Widget countBadge(int isi) {
    return Container(
      height: GlobalVariable.ratioHeight(Get.context) * 22,
      width: GlobalVariable.ratioWidth(Get.context) * 22,
      margin: EdgeInsets.zero,
      // padding: EdgeInsets.only(
      //   // top: GlobalVariable.ratioHeight(Get.context) * 0.5,
      //   bottom: GlobalVariable.ratioHeight(Get.context) * 1,
      // ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isi == 0 ? Colors.white : Color(ListColor.colorBlue)),
      child: Center(
        child: CustomText(
          isi.toString(),
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w600,
          fontSize: isi > 99 ? 12 : 14,
          textAlign: TextAlign.center,
          color: Color(ListColor.colorWhite),
        ),
      ),
    );
  }

  List<Widget> getListCityWrap(
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    List<Widget> cityWrap = <Widget>[];
    Map<String, dynamic> mapChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listChoosenTempKey]);
    // int jumlah = mapChoosen.length > 5 ? 5 : mapChoosen.length;
    int jumlah = 0;
    mapChoosen.entries.forEach((element) {
      if (jumlah < 5) {
        cityWrap.add(_getItemWrap(element.key,
            element.value.toString().split(" - ")[0], true, onTapItem));
        jumlah++;
      }
    });
    int ctr = 0;
    while (jumlah < 5) {
      if (ctr >= _listCity.length) {
        jumlah = 5;
      } else {
        bool check = false;
        mapChoosen.entries.forEach((element) {
          if (element.key == _listCity.keys.elementAt(ctr)) {
            check = true;
          }
        });
        if (!check) {
          cityWrap.add(_getItemWrap(
              _listCity.keys.elementAt(ctr),
              _listCity.values.elementAt(ctr).toString().split(" - ")[0],
              false,
              onTapItem));
          jumlah++;
        }
      }
      ctr++;
    }
    return cityWrap;
  }

  List<Widget> _getListWidgetWrap(
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    List<ItemWrap> listItem =
        _listVariable[index.toString()][_listDataInViewKey];
    Map<String, dynamic> mapNotChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listNotChoosenKey]);
    Map<String, dynamic> mapChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listChoosenTempKey]);
    List<Widget> listData = [];
    if (_listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey]) {
      _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = false;
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
    } else {
      for (ItemWrap item in listItem) {
        listData.add(_getItemWrap(
            item.key, item.value, mapChoosen[item.key] != null, onTapItem));
      }
    }
    return listData;
  }

  Widget _filterAreaPickupTransporter(
      String title,
      void Function() seeAll,
      void Function(bool isChoosen, String key, String value) onTapItem,
      void Function(String ategori, bool value) onTapItemParent,
      int index) {
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
              seeAll != null
                  ? Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomText(
                            "GlobalFilterButtonShowAll".tr,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.color4),
                          ),
                        ),
                        onTap: seeAll,
                      ),
                    )
                  : SizedBox.shrink()
            ]),
        SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getListWidgetAreaPickupTransporter(
              onTapItem, onTapItemParent, index),
        )
      ],
    );
  }

  Widget _filterAreaPickupSearch(
      String title,
      void Function() seeAll,
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
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
              seeAll != null
                  ? Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomText(
                            "GlobalFilterButtonShowAll".tr,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.color4),
                          ),
                        ),
                        onTap: seeAll,
                      ),
                    )
                  : SizedBox.shrink()
            ]),
        SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getListWidgetAreaPickupSearch(onTapItem, index),
        )
      ],
    );
  }

  List<Widget> _getListWidgetAreaPickupSearch(
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    List<ItemWrap> listItem =
        _listVariable[index.toString()][_listDataInViewKey];
    Map<String, dynamic> mapNotChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listNotChoosenKey]);
    Map<String, dynamic> mapChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listChoosenTempKey]);
    List<Widget> listData = [];
    if (_listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey]) {
      _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = false;
      listItem.clear();
      if (mapChoosen.length > 0) {
        mapChoosen.entries.forEach((element) {
          if (listData.length < 4) {
            listData.add(_getItemAreaPickupSearch(element.key, element.value,
                mapChoosen[element.key] != null, onTapItem));
            listItem.add(ItemWrap(
                key: element.key, value: element.value, isChoosen: true));
          }
        });
      } else {
        mapNotChoosen.entries.forEach((element) {
          if (listData.length < 4) {
            listData.add(_getItemAreaPickupSearch(element.key, element.value,
                mapChoosen[element.key] != null, onTapItem));
            listItem.add(ItemWrap(
                key: element.key, value: element.value, isChoosen: false));
          }
        });
      }
    } else {
      for (ItemWrap item in listItem) {
        listData.add(_getItemAreaPickupSearch(
            item.key, item.value, mapChoosen[item.key] != null, onTapItem));
      }
    }
    return listData;
  }

  List<Widget> _getListWidgetAreaPickupTransporter(
      void Function(bool isChoosen, String key, String value) onTapItem,
      void Function(String kategori, bool value) onTapItemParent,
      int index) {
    List<ItemWrap> listItem =
        _listVariable[index.toString()][_listDataInViewKey];
    Map<String, dynamic> mapNotChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listNotChoosenKey]);
    Map<String, dynamic> mapChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listChoosenTempKey]);
    List<Widget> listData = [];
    if (_listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey]) {
      _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = false;
      listItem.clear();
      if (mapChoosen.length > 0) {
        var limitData = 0;
        var first = true;
        mapChoosen.entries.forEach((element) {
          if (limitData < 6) {
            var getArea = _listAreaPickupTransporterModelFull.firstWhere(
                (listElement) =>
                    listElement.id.toString() == element.key.toString());
            var showKategori = false;
            var indexArea = mapChoosen.keys
                .toList()
                .indexWhere((keyElement) => keyElement == getArea.id);
            if (indexArea == 0) {
              showKategori = true;
              limitData++;
            } else if (mapChoosen.entries.toList().length > 1) {
              var getAreaBefore = _listAreaPickupTransporterModelFull
                  .firstWhere((listElement) =>
                      listElement.id.toString() ==
                      mapChoosen.entries
                          .toList()[indexArea - 1]
                          .key
                          .toString());
              if (getArea.kategori != getAreaBefore.kategori) limitData++;
              showKategori = getArea.kategori != getAreaBefore.kategori;
            }
            listData.add(_getItemAreaPickupTransporter(
                showKategori,
                getArea.kategori,
                element.key,
                element.value,
                mapChoosen[element.key] != null,
                mapChoosen.keys.any((element) =>
                    _listAreaPickupTransporterModelFull
                        .where(
                            (element) => element.kategori == getArea.kategori)
                        .toList()
                        .any((elementKategori) =>
                            elementKategori.id.toString() ==
                            element.toString())),
                limitData < 6,
                onTapItem,
                onTapItemParent));
            listItem.add(ItemWrap(
                key: element.key, value: element.value, isChoosen: true));
            limitData++;
          }
          first = false;
        });
      } else {
        var limitData = 0;
        mapNotChoosen.entries.forEach((element) {
          if (limitData < 6) {
            var getArea = _listAreaPickupTransporterModelFull.firstWhere(
                (listElement) =>
                    listElement.id.toString() == element.key.toString());
            var showKategori = false;
            var indexArea = mapNotChoosen.keys
                .toList()
                .indexWhere((keyElement) => keyElement == getArea.id);
            if (indexArea == 0) {
              showKategori = true;
              limitData++;
            } else if (mapNotChoosen.entries.toList().length > 1) {
              var getAreaBefore = _listAreaPickupTransporterModelFull
                  .firstWhere((listElement) =>
                      listElement.id.toString() ==
                      mapNotChoosen.entries
                          .toList()[indexArea - 1]
                          .key
                          .toString());
              if (getArea.kategori != getAreaBefore.kategori) limitData++;
              showKategori = getArea.kategori != getAreaBefore.kategori;
            }
            listData.add(_getItemAreaPickupTransporter(
                showKategori,
                getArea.kategori,
                element.key,
                element.value,
                mapChoosen[element.key] != null,
                mapChoosen.keys.any((element) =>
                    _listAreaPickupTransporterModelFull
                        .where(
                            (element) => element.kategori == getArea.kategori)
                        .toList()
                        .any((elementKategori) =>
                            elementKategori.id.toString() ==
                            element.toString())),
                limitData < 6,
                onTapItem,
                onTapItemParent));
            listItem.add(ItemWrap(
                key: element.key, value: element.value, isChoosen: true));
          }
          limitData++;
        });
      }
    } else {
      var limitData = 0;
      for (ItemWrap item in listItem) {
        var getArea = _listAreaPickupTransporterModelFull.firstWhere(
            (listElement) => listElement.id.toString() == item.key.toString());
        var showKategori = false;
        var indexArea = listItem.indexOf(item);
        if (indexArea == 0) {
          showKategori = true;
          limitData++;
        } else if (listItem.length > 1) {
          var getAreaBefore = _listAreaPickupTransporterModelFull.firstWhere(
              (listElement) =>
                  listElement.id.toString() ==
                  listItem[indexArea - 1].key.toString());
          if (getArea.kategori != getAreaBefore.kategori) limitData++;
          showKategori = getArea.kategori != getAreaBefore.kategori;
        }
        listData.add(_getItemAreaPickupTransporter(
            showKategori,
            getArea.kategori,
            item.key,
            item.value,
            mapChoosen[item.key] != null,
            mapChoosen.keys.any((element) => _listAreaPickupTransporterModelFull
                .where((element) => element.kategori == getArea.kategori)
                .toList()
                .any((elementKategori) =>
                    elementKategori.id.toString() == element.toString())),
            limitData < 6,
            onTapItem,
            onTapItemParent));
        limitData++;
      }
    }
    return listData;
  }

  Widget _getItemAreaPickupSearch(String key, String title, bool isChoosen,
      void Function(bool isChoosen, String key, String value) onTapItem) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: GlobalVariable.ratioHeight(Get.context) * 2, horizontal: 0),
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTapItem(!isChoosen, key, title);
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CheckBoxCustom(
                size: 15,
                shadowSize: 17,
                isWithShadow: true,
                disableBorderColor: Color(ListColor.colorGrey3),
                onChanged: (onChanged) {
                  onTapItem(!isChoosen, key, title);
                },
                value: isChoosen,
              ),
              Expanded(
                child: CustomText(
                  title,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.colorDarkBlue2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getItemAreaPickupTransporter(
      bool showKategori,
      String kategori,
      String key,
      String title,
      bool isChoosen,
      bool isParentChoosen,
      bool showChild,
      void Function(bool isChoosen, String key, String value) onTapItem,
      void Function(String kategori, bool value) onTapItemParent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !showKategori
            ? SizedBox.shrink()
            : Container(
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                width: double.infinity,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      onTapItem(!isChoosen, key, title);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CheckBoxCustom(
                          size: 15,
                          shadowSize: 19,
                          isWithShadow: true,
                          onChanged: (onChanged) {
                            onTapItemParent(kategori, onChanged);
                          },
                          value: isParentChoosen,
                        ),
                        Expanded(
                          child: CustomText(
                            kategori,
                            overflow: TextOverflow.ellipsis,
                            color: Color(ListColor.color4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        !showChild
            ? Container(height: 2)
            : Container(
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                width: double.infinity,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      onTapItem(!isChoosen, key, title);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: 30),
                        CheckBoxCustom(
                          size: 15,
                          shadowSize: 19,
                          isWithShadow: true,
                          onChanged: (onChanged) {
                            onTapItem(!isChoosen, key, title);
                          },
                          value: isChoosen,
                        ),
                        Expanded(
                          child: CustomText(
                            title,
                            overflow: TextOverflow.ellipsis,
                            color: Color(ListColor.color4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _getItemWrap(String key, String title, bool isChoosen,
      void Function(bool isChoosen, String key, String value) onTapItem) {
    double borderRadius = GlobalVariable.ratioWidth(Get.context) * 17;
    return Container(
      margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: 0),
      constraints: BoxConstraints(
        maxWidth: GlobalVariable.ratioWidth(Get.context) * 328
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * 1,
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
            onTapItem(!isChoosen, key, title);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16, 
              vertical: GlobalVariable.ratioWidth(Get.context) * 2),
            child: CustomText(
              title,
              fontSize: 14,
              height: 1.2,
              fontWeight: FontWeight.w500,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorGrey3),
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

  void _setTextFirstEndDateTime(Map<String, dynamic> data, String key,
      DateTime dateTime, String valueIfNull, int index) {
    data[key] = dateTime == null
        ? valueIfNull
        : DateFormat(listWidgetInFilter[index].typeInFilter == TypeInFilter.DATE
                ? 'dd-MM-yyyy'
                : 'yyyy')
            .format(dateTime);
    _listVariable[index.toString()][_errorMessageDateKey] =
        _errorMessageDate(index);
  }

  Future<DateTime> _showDateTimePicker(DateTime initialDate) async {
    return await showDatePicker(
        context: Get.context,
        initialDate: initialDate == null ? DateTime.now() : initialDate,
        firstDate: DateTime(1800),
        lastDate: DateTime(2100));
  }

  Future _setFirstDateTimeTemp(Map<String, dynamic> data, TypeInFilter type,
      String defaultIfNull, int indexListVariable) async {
    if (type == TypeInFilter.DATE) {
      showDatePicker(
              context: Get.context,
              initialDate: data[_firstDateTempKey] == null
                  ? DateTime.now()
                  : data[_firstDateTempKey],
              firstDate: DateTime(1800),
              lastDate: DateTime(DateTime.now().year, 12))
          .then((value) {
        if (value != null) {
          data[_firstDateTempKey] = value;
          _setTextFirstEndDateTime(data, _firstDateTextKey,
              data[_firstDateTempKey], defaultIfNull, indexListVariable);
          _listVariable.refresh();
        }
      });
    } else {
      _showDialogYearPicker(data[_firstDateTempKey], (value) {
        if (value != null) {
          data[_firstDateTempKey] = value;
          _setTextFirstEndDateTime(data, _firstDateTextKey,
              data[_firstDateTempKey], defaultIfNull, indexListVariable);
          _listVariable.refresh();
        }
      });
    }
  }

  Future _setEndDateTimeTemp(Map<String, dynamic> data, TypeInFilter type,
      String defaultIfNull, int indexListVariable) async {
    if (type == TypeInFilter.DATE) {
      showDatePicker(
              context: Get.context,
              initialDate: data[_endDateTempKey] == null
                  ? DateTime.now()
                  : data[_endDateTempKey],
              firstDate: DateTime(1800),
              lastDate: DateTime(DateTime.now().year, 12, 31))
          .then((value) {
        if (value != null) {
          data[_endDateTempKey] = value;
          _setTextFirstEndDateTime(data, _endDateTextKey, data[_endDateTempKey],
              defaultIfNull, indexListVariable);
          _listVariable.refresh();
        }
      });
    } else {
      _showDialogYearPicker(data[_endDateTempKey], (value) {
        if (value != null) {
          data[_endDateTempKey] = value;
          _setTextFirstEndDateTime(data, _endDateTextKey, data[_endDateTempKey],
              defaultIfNull, indexListVariable);
          _listVariable.refresh();
        }
      });
    }
  }

  void _resetAll({bool isIncludeChoosen = false}) {
    _showPrint("_checkListWidgetInFilter: _resetAll");
    _checkListWidgetInFilter(onCity: (index) {
      _resetWrapData(index, isIncludeChoosen);
    }, onTruck: (index) {
      _resetWrapData(index, isIncludeChoosen);
    }, onCarrier: (index) {
      _resetWrapData(index, isIncludeChoosen);
    }, onDate: (index) {
      _listVariable[index.toString()][_firstDateTempKey] = null;
      _listVariable[index.toString()][_endDateTempKey] = null;
      _setTextFirstEndDateTime(
          _listVariable[index.toString()],
          _firstDateTextKey,
          _listVariable[index.toString()][_firstDateTempKey],
          _listVariable[index.toString()][_firstDefaultTextKey],
          index);
      _setTextFirstEndDateTime(
          _listVariable[index.toString()],
          _endDateTextKey,
          _listVariable[index.toString()][_endDateTempKey],
          _listVariable[index.toString()][_endDefaultTextKey],
          index);
      if (isIncludeChoosen) {
        _listVariable[index.toString()][_firstDateKey] = null;
        _listVariable[index.toString()][_endDateKey] = null;
      }
    }, onSwitch: (index) {
      _listVariable[index.toString()][_switchTempKey] = false;
      if (isIncludeChoosen) _listVariable[index.toString()][_switchKey] = false;
    }, onUnit: (index) {
      _listVariable[index.toString()][_rangeValuesTempKey] =
          listWidgetInFilter[index].customValue != null
              ? RangeValues(listWidgetInFilter[index].customValue[0],
                  listWidgetInFilter[index].customValue[1])
              : RangeValues(0, _maxRangeValueUnit);
      if (listWidgetInFilter[index].customValue != null) {
        _setRangeValueUnit(listWidgetInFilter[index].customValue[0],
            listWidgetInFilter[index].customValue[1], index);
      } else {
        _setRangeValueUnit(0, _maxRangeValueUnit, index);
      }

      if (isIncludeChoosen)
        _listVariable[index.toString()][_rangeValuesKey] =
            listWidgetInFilter[index].customValue != null
                ? RangeValues(listWidgetInFilter[index].customValue[0],
                    listWidgetInFilter[index].customValue[1])
                : RangeValues(0, _maxRangeValueUnit);
    }, onRadioButton: (index) {
      _listVariable[index.toString()][_radioButtonTempKey] = "";
    }, onCheckbox: (index) {
      _listVariable[index.toString()][_checkboxTempKey] = "";
    }, onEkspektasiDestinasi: (index) {
      _resetWrapData(index, isIncludeChoosen);
    }, onName: (index) {
      _listVariable[index.toString()][_nameTempKey] = "";
      _listVariable[index.toString()][_nameTextEditingControllerKey].text = "";
    }, onAreaPickupSearch: (index) {
      _resetWrapData(index, isIncludeChoosen);
    }, onAreaPickupTransporter: (index) {
      _resetWrapData(index, isIncludeChoosen);
    });
    _listVariable.refresh();
  }

  void _resetWrapData(int index, bool isIncludeChoosen) {
    _listVariable[index.toString()][_listChoosenTempKey].clear();
    _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
    if (isIncludeChoosen)
      _listVariable[index.toString()][_listChoosenKey].clear();
  }

  void _resetAllIncChoosen() {
    _resetAll(isIncludeChoosen: true);
  }

  String _checkAllFilter() {
    String errorMessage = "";
    //check date jika salah satu diisi
    for (int i = 0; i < listWidgetInFilter.length; i++) {
      if (listWidgetInFilter[i].typeInFilter == TypeInFilter.DATE ||
          listWidgetInFilter[i].typeInFilter == TypeInFilter.YEAR) {
        if ((_listVariable[i.toString()][_firstDateTempKey] != null ||
                _listVariable[i.toString()][_endDateTempKey] != null) &&
            !(_listVariable[i.toString()][_firstDateTempKey] != null &&
                _listVariable[i.toString()][_endDateTempKey] != null)) {
          if (_listVariable[i.toString()][_firstDateTempKey] == null) {
            _listVariable[i.toString()][_firstDateTempKey] = DateTime(1800, 1);
            _setTextFirstEndDateTime(
                _listVariable[i.toString()],
                _firstDateTextKey,
                _listVariable[i.toString()][_firstDateTempKey],
                _listVariable[i.toString()][_firstDefaultTextKey],
                i);
          } else {
            _listVariable[i.toString()][_endDateTempKey] =
                listWidgetInFilter[i].typeInFilter == TypeInFilter.YEAR
                    ? DateTime(DateTime.now().year, 1)
                    : DateTime(DateTime.now().year, 12, 31);
            _setTextFirstEndDateTime(
                _listVariable[i.toString()],
                _endDateTextKey,
                _listVariable[i.toString()][_endDateTempKey],
                _listVariable[i.toString()][_endDefaultTextKey],
                i);
          }
        }
        errorMessage = _listVariable[i.toString()][_errorMessageDateKey];

        //   if (_listVariable[i.toString()][_firstDateTempKey] != null &&
        //       _listVariable[i.toString()][_endDateTempKey] != null) {
        //     if ((_listVariable[i.toString()][_firstDateTextKey] !=
        //             _listVariable[i.toString()][_firstDefaultTextKey] &&
        //         _listVariable[i.toString()][_endDateTextKey] !=
        //             _listVariable[i.toString()][_endDefaultTextKey])) {
        //       if (listWidgetInFilter[i].typeInFilter == TypeInFilter.YEAR &&
        //           _listVariable[i.toString()][_firstDateTempKey].year >
        //               _listVariable[i.toString()][_endDateTempKey].year) {
        //         errorMessage = "GlobalFilterWarningFoundedYear".tr;
        //         break;
        //       } else if (listWidgetInFilter[i].typeInFilter ==
        //               TypeInFilter.DATE &&
        //           _listVariable[i.toString()][_firstDateTempKey]
        //               .isAfter(_listVariable[i.toString()][_endDateTempKey])) {
        //         errorMessage = "Error".tr;
        //         break;
        //       }
        //     }
        //   }
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.UNIT) {
        errorMessage = _listVariable[i.toString()][_errorMessageUnitKey];
      }
      if (errorMessage != "") break;
    }
    return errorMessage;
  }

  String _errorMessageDate(int i) {
    if (_listVariable[i.toString()][_firstDateTempKey] != null &&
        _listVariable[i.toString()][_endDateTempKey] != null) {
      if ((_listVariable[i.toString()][_firstDateTextKey] !=
              _listVariable[i.toString()][_firstDefaultTextKey] &&
          _listVariable[i.toString()][_endDateTextKey] !=
              _listVariable[i.toString()][_endDefaultTextKey])) {
        if (listWidgetInFilter[i].typeInFilter == TypeInFilter.YEAR &&
            _listVariable[i.toString()][_firstDateTempKey].year >
                _listVariable[i.toString()][_endDateTempKey].year) {
          return "GlobalFilterWarningFoundedYear".tr;
        } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.DATE &&
            _listVariable[i.toString()][_firstDateTempKey]
                .isAfter(_listVariable[i.toString()][_endDateTempKey])) {
          return "GlobalFilterErrorStartDateAfterEndDate".tr;
        }
      }
    }
    return "";
  }

  void _onSaveData() {
    String error = _checkAllFilter();
    if (error == "") {
      _showPrint("_checkListWidgetInFilter: _onSaveData1");
      _checkListWidgetInFilter(onDate: (index) {
        _listVariable[index.toString()][_firstDateKey] =
            _listVariable[index.toString()][_firstDateTempKey];
        _listVariable[index.toString()][_endDateKey] =
            _listVariable[index.toString()][_endDateTempKey];
      }, onCity: (index) {
        _setWrapFromTempToReal(index);
      }, onSwitch: (index) {
        _listVariable[index.toString()][_switchKey] =
            _listVariable[index.toString()][_switchTempKey];
      }, onUnit: (index) {
        _listVariable[index.toString()][_rangeValuesKey] =
            _listVariable[index.toString()][_rangeValuesTempKey];
      }, onTruck: (index) {
        _setWrapFromTempToReal(index);
      }, onCarrier: (index) {
        _setWrapFromTempToReal(index);
      }, onRadioButton: (index) {
        _listVariable[index.toString()][_radioButtonKey] =
            _listVariable[index.toString()][_radioButtonTempKey];
      }, onCheckbox: (index) {
        _listVariable[index.toString()][_checkboxKey] =
            _listVariable[index.toString()][_checkboxTempKey];
      }, onEkspektasiDestinasi: (index) {
        _setWrapFromTempToReal(index);
      }, onName: (index) {
        _listVariable[index.toString()][_nameKey] =
            _listVariable[index.toString()][_nameTempKey];
      }, onAreaPickupSearch: (index) {
        _setWrapFromTempToReal(index);
      }, onAreaPickupTransporter: (index) {
        _setWrapFromTempToReal(index);
      });
      bool isSavingData = false;

      Map<String, dynamic> mapData = {};
      _showPrint("_checkListWidgetInFilter: _onSaveData2");
      _checkListWidgetInFilter(onDate: (index) {
        if ((_listVariable[index.toString()][_firstDateTextKey] !=
                _listVariable[index.toString()][_firstDefaultTextKey] &&
            _listVariable[index.toString()][_endDateTextKey] !=
                _listVariable[index.toString()][_endDefaultTextKey])) {
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_firstDateTextKey] +
                  "," +
                  _listVariable[index.toString()][_endDateTextKey];

          isSavingData = true;
        } else {
          mapData[listWidgetInFilter[index].keyParam] = "";
        }
      }, onCity: (index) {
        Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
        isSavingData =
            isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
        mapData[listWidgetInFilter[index].keyParam] = returnDataWrap["MapData"];
      }, onTruck: (index) {
        Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
        isSavingData =
            isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
        mapData[listWidgetInFilter[index].keyParam] = returnDataWrap["MapData"];
      }, onCarrier: (index) {
        Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
        isSavingData =
            isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
        mapData[listWidgetInFilter[index].keyParam] = returnDataWrap["MapData"];
      }, onSwitch: (index) {
        mapData[listWidgetInFilter[index].keyParam] =
            _listVariable[index.toString()][_switchKey] == true ? "1" : "0";
        if (mapData[listWidgetInFilter[index].keyParam] == "1") {
          isSavingData = true;
        }
      }, onUnit: (index) {
        double min = 0;
        double max = _maxRangeValueUnit;
        if (listWidgetInFilter[index].customValue != null) {
          min = listWidgetInFilter[index].customValue[0];
          max = listWidgetInFilter[index].customValue[1];
        }
        try {
          if (_listVariable[index.toString()][_rangeValuesKey].start != min ||
              _listVariable[index.toString()][_rangeValuesKey].end != max) {
            isSavingData = true;
            mapData[listWidgetInFilter[index].keyParam] =
                _listVariable[index.toString()][_rangeValuesKey]
                        .start
                        .round()
                        .toInt()
                        .toString() +
                    "," +
                    _listVariable[index.toString()][_rangeValuesKey]
                        .end
                        .round()
                        .toInt()
                        .toString();
          } else {
            mapData[listWidgetInFilter[index].keyParam] = "";
          }
        } catch (error) {
          print(error);
        }
      }, onRadioButton: (index) {
        mapData[listWidgetInFilter[index].keyParam] =
            _listVariable[index.toString()][_radioButtonKey] ?? "";
        if (mapData[listWidgetInFilter[index].keyParam] != "") {
          isSavingData = true;
        }
      }, onCheckbox: (index) {
        // var checkboxID = "";
        // (_listVariable[index.toString()][_checkboxKey] as List).forEach((element) {
        //   if(checkboxID.isEmpty)
        //     checkboxID = element;
        //   else
        //     checkboxID += ",$element";
        // });
        mapData[listWidgetInFilter[index].keyParam] =
            (_listVariable[index.toString()][_checkboxKey] as List);
        if (mapData[listWidgetInFilter[index].keyParam] != "") {
          isSavingData = true;
        }
      }, onEkspektasiDestinasi: (index) {
        Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
        isSavingData =
            isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
        mapData[listWidgetInFilter[index].keyParam] = returnDataWrap["MapData"];
      }, onName: (index) {
        mapData[listWidgetInFilter[index].keyParam] =
            _listVariable[index.toString()][_nameKey] ?? "";
        isSavingData = mapData[listWidgetInFilter[index].keyParam] != "";
      }, onAreaPickupSearch: (index) {
        Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
        isSavingData =
            isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
        mapData[listWidgetInFilter[index].keyParam] =
            (returnDataWrap["MapData"] as String);
        // .split(",")
        // .map((e) => int.parse(e.toString()))
        // .toList();
      }, onAreaPickupTransporter: (index) {
        Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
        isSavingData =
            isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
        mapData[listWidgetInFilter[index].keyParam] =
            (returnDataWrap["MapData"] as String);
        // .split(",")
        // .map((e) => int.parse(e.toString()))
        // .toList();
      });
      if ((!isSavingData)) mapData.clear();
      returnData(mapData);
      Get.back();
    }
  }

  void _setWrapFromTempToReal(int index) {
    _listVariable[index.toString()][_listChoosenKey].clear();
    _listVariable[index.toString()][_listChoosenKey]
        .addAll(_listVariable[index.toString()][_listChoosenTempKey]);
  }

  Map<String, dynamic> _setWrapToMapData(int index) {
    Map<String, dynamic> returnData = {"IsSavingData": false};
    if (_listVariable[index.toString()][_listChoosenKey].length > 0) {
      returnData["MapData"] = _convertKey(Map<String, dynamic>.from(
          _listVariable[index.toString()][_listChoosenKey]));
      returnData["IsSavingData"] = true;
    } else
      returnData["MapData"] = "";
    return returnData;
  }

  Future _getCity() async {
    var resultArea = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAllCity();
    List dataArea = resultArea["Data"];
    dataArea.forEach((element) {
      _listCity[element["ID"].toString()] = element["Kota"];
      //kota[element["ID"]] = element["Kota"];
    });
    if (resultArea != null) {
      Map<String, dynamic> copyData = {};
      int pos = 0;
      for (var entry in _listCity.entries) {
        copyData[entry.key] = entry.value;
        pos++;
        if (pos == _maxDataWrapFilter) break;
      }
      _showPrint("_checkListWidgetInFilter: _getCity");
      _checkListWidgetInFilter(
          onCity: (index) {
            _listVariable[index.toString()][_listNotChoosenKey]
                .addAll(copyData);
          },
          onDate: null,
          onCarrier: null,
          onSwitch: null,
          onTruck: null,
          onUnit: null,
          onRadioButton: null,
          onCheckbox: null,
          onName: null,
          onAreaPickupSearch: null,
          onAreaPickupTransporter: null);
      return true;
    }
    return false;
  }

  Future _getEkspektasiDestinasi() async {
    var resultArea = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAllCity();
    List dataArea = resultArea["Data"];
    dataArea.forEach((element) {
      _listCity[element["ID"].toString()] = element["Kota"];
      //kota[element["ID"]] = element["Kota"];
    });
    if (resultArea != null) {
      Map<String, dynamic> copyData = {};
      int pos = 0;
      for (var entry in _listCity.entries) {
        copyData[entry.key] = entry.value;
        pos++;
        if (pos == _maxDataWrapFilter) break;
      }
      _showPrint("_checkListWidgetInFilter: _getEkspektasiDestinasi");
      _checkListWidgetInFilter(
          onCity: null,
          onDate: null,
          onCarrier: null,
          onSwitch: null,
          onTruck: null,
          onUnit: null,
          onRadioButton: null,
          onCheckbox: null,
          onEkspektasiDestinasi: (index) {
            _listVariable[index.toString()][_listNotChoosenKey]
                .addAll(copyData);
          },
          onName: null,
          onAreaPickupSearch: null,
          onAreaPickupTransporter: null);
      return true;
    }
    return false;
  }

  Future _getHeadTruck() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchHeadTruck();
    try {
      if (result != null) {
        HeadTruckResponseModel headTruckResponseModel =
            HeadTruckResponseModel.fromJson(result);
        if (headTruckResponseModel.message.code == 200) {
          _listTruckModel.addAll(headTruckResponseModel.listData);
          for (HeadTruckModel data in headTruckResponseModel.listData) {
            _listTruck[data.id.toString()] = data.description;
          }
          _showPrint("_checkListWidgetInFilter: _getHeadTruck");
          _checkListWidgetInFilter(
              onDate: null,
              onCity: null,
              onSwitch: null,
              onCarrier: null,
              onUnit: null,
              onRadioButton: null,
              onCheckbox: null,
              onTruck: (index) {
                _listVariable[index.toString()][_listNotChoosenKey]
                    .addAll(_listTruck);
              },
              onName: null,
              onAreaPickupSearch: null,
              onAreaPickupTransporter: null);
          return true;
        }
      }
    } catch (err) {}
    return false;
  }

  Future _getCarrierTruck() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchCarrierTruck();
    try {
      if (result != null) {
        CarrierTruckResponseModel carrierTruckResponseModel =
            CarrierTruckResponseModel.fromJson(result);
        if (carrierTruckResponseModel.message.code == 200) {
          _listCarrierModel.addAll(carrierTruckResponseModel.listData);
          for (CarrierTruckModel data in carrierTruckResponseModel.listData) {
            _listCarrier[data.id] = data.description;
          }
          _showPrint("_checkListWidgetInFilter: _getCarrierTruck");
          _checkListWidgetInFilter(
              onDate: null,
              onCity: null,
              onSwitch: null,
              onTruck: null,
              onUnit: null,
              onRadioButton: null,
              onCheckbox: null,
              onCarrier: (index) {
                _listVariable[index.toString()][_listNotChoosenKey]
                    .addAll(_listCarrier);
              },
              onName: null,
              onAreaPickupSearch: null,
              onAreaPickupTransporter: null);
          return true;
        }
      }
    } catch (err) {
      print(err.toString());
    }
    return false;
  }

  Future _getAreaPickupSearch(String cityPickup, String districtPickup,
      String cityDestination, String jenisTruk, String jenisCarrier) async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAreaPickupSearch(cityPickup, districtPickup, cityDestination,
            jenisTruk, jenisCarrier);
    try {
      if (result != null) {
        SearchAreaPickupFilteResponseModel searchAreaPickupResponseModel =
            // SearchAreaPickupFilteResponseModel.fromJson(result);
            SearchAreaPickupFilteResponseModel.fromJson(result, districtPickup);
        if (searchAreaPickupResponseModel.message.code == 200) {
          _listAreaPickupSearchModel
              .addAll(searchAreaPickupResponseModel.listData);
          _listAreaPickupSearchModelFull
              .addAll(searchAreaPickupResponseModel.listDataFull);
          for (SearchAreaPickupFilterModel data
              in searchAreaPickupResponseModel.listData) {
            _listAreaPickupSearch[data.id] = data.description;
          }
          _showPrint("_checkListWidgetInFilter: _getAreaPickupSearch");
          _checkListWidgetInFilter(
              onDate: null,
              onCity: null,
              onSwitch: null,
              onTruck: null,
              onUnit: null,
              onRadioButton: null,
              onCheckbox: null,
              onCarrier: null,
              onName: null,
              onAreaPickupSearch: (index) {
                _listVariable[index.toString()][_listNotChoosenKey]
                    .addAll(_listAreaPickupSearch);
              },
              onAreaPickupTransporter: null);
          return true;
        }
      }
    } catch (err) {
      print(err.toString());
    }
    return false;
  }

  Future _getAreaPickupTransporter(String transporterID) async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAreaPickupTransporter(transporterID);
    try {
      if (result != null) {
        TransporterAreaPickupFilteResponseModel
            transporterAreaPickupFilteResponseModel =
            TransporterAreaPickupFilteResponseModel.fromJson(result);
        if (transporterAreaPickupFilteResponseModel.message.code == 200) {
          _listAreaPickupTransporterModel
              .addAll(transporterAreaPickupFilteResponseModel.listDataFront);
          _listAreaPickupTransporterModelFull
              .addAll(transporterAreaPickupFilteResponseModel.listDataFull);
          for (TransporterAreaPickupFilterModel data
              in transporterAreaPickupFilteResponseModel.listDataFull) {
            _listAreaPickupTransporter[data.id] = data.description;
          }
          _showPrint("_checkListWidgetInFilter: _getAreaPickupTransporter");
          _checkListWidgetInFilter(
              onDate: null,
              onCity: null,
              onSwitch: null,
              onTruck: null,
              onUnit: null,
              onRadioButton: null,
              onCheckbox: null,
              onCarrier: null,
              onName: null,
              onAreaPickupSearch: null,
              onAreaPickupTransporter: (index) {
                _listVariable[index.toString()][_listNotChoosenKey]
                    .addAll(_listAreaPickupTransporter);
              });
          return true;
        }
      }
    } catch (err) {
      print(err.toString());
    }
    return false;
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

  void _setRangeValueUnit(double start, double end, int index,
      {bool isUpdateRangeValues = true,
      bool isUpdateTextEditingController = true}) {
    double max = _maxRangeValueUnit;
    if (listWidgetInFilter[index].customValue != null) {
      max = listWidgetInFilter[index].customValue[1];
    }
    if (start <= end && end <= max) {
      if (isUpdateRangeValues) {
        _listVariable[index.toString()][_rangeValuesTempKey] =
            RangeValues(start, end);
        _listVariable.refresh();
      }
      if (isUpdateTextEditingController) {
        _listVariable[index.toString()][_startUnitRangeTextEditingControllerKey]
            .text = start.round().toInt().toString();
        _listVariable[index.toString()][_endUnitRangeTextEditingControllerKey]
            .text = end.round().toInt().toString();
        _listVariable.refresh();
      }
      _listVariable[index.toString()][_errorMessageUnitKey] = "";
    } else {
      _listVariable[index.toString()][_errorMessageUnitKey] =
          "GlobalFilterErrorStartUnitAfterEndUnit".tr;
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

  //LIST WIDGET FILTER

  Widget _dateWidget(
      String title, Map<String, dynamic> data, int indexListWidgetInFilter) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textTitle(title),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _setFirstDateTimeTemp(
                      data,
                      listWidgetInFilter[indexListWidgetInFilter].typeInFilter,
                      _listVariable[indexListWidgetInFilter.toString()]
                          [_firstDefaultTextKey],
                      indexListWidgetInFilter);
                },
                child: Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 32,
                  padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: data[_errorMessageDateKey] != ""
                              ? Colors.red
                              : Color(ListColor.colorGrey6),
                          width: GlobalVariable.ratioWidth(Get.context) * 1),
                      borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 8)),
                      color: Color(ListColor.colorLightGrey3)),
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: CustomText(
                              data[_firstDateTextKey],
                              fontSize: 12,
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/calendar_icon.svg",
                            color: Colors.black,
                            width: GlobalVariable.ratioWidth(Get.context) * 16,
                            height: GlobalVariable.ratioWidth(Get.context) * 16
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 19),
              child: CustomText("s/d", fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _setEndDateTimeTemp(
                      data,
                      listWidgetInFilter[indexListWidgetInFilter].typeInFilter,
                      _listVariable[indexListWidgetInFilter.toString()]
                          [_endDefaultTextKey],
                      indexListWidgetInFilter);
                },
                child: Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 32,
                  padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: data[_errorMessageDateKey] != ""
                              ? Colors.red
                              : Color(ListColor.colorGrey6),
                          width: GlobalVariable.ratioWidth(Get.context) * 1),
                      borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 8)),
                      color: Color(ListColor.colorLightGrey3)),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CustomText(data[_endDateTextKey], fontSize: 12),
                        ),
                        SvgPicture.asset(
                          "assets/calendar_icon.svg",
                          color: Colors.black,
                          width: GlobalVariable.ratioWidth(Get.context) * 16,
                          height: GlobalVariable.ratioWidth(Get.context) * 16
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        data[_errorMessageDateKey] != ""
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(data[_errorMessageDateKey],
                      color: Colors.red, fontSize: 12),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _wrapItemWidget(String title, int indexListVariable,
      {void Function() seeAll}) {
    Map<String, dynamic> mapData =
        Map<String, dynamic>.from(_listVariable[indexListVariable.toString()]);
    return _filterWrap(title, seeAll, (isChoosen, key, value) {
      if (!isChoosen) {
        mapData[_listChoosenTempKey].remove(key);
      } else {
        mapData[_listChoosenTempKey][key] = value;
      }
      _listVariable.refresh();
    }, indexListVariable);
  }

  Widget _searchAreaPickupWidget(String title, int indexListVariable,
      {void Function() seeAll}) {
    Map<String, dynamic> mapData =
        Map<String, dynamic>.from(_listVariable[indexListVariable.toString()]);
    return _filterAreaPickupSearch(title, seeAll, (isChoosen, key, value) {
      if (!isChoosen) {
        mapData[_listChoosenTempKey].remove(key);
      } else {
        mapData[_listChoosenTempKey][key] = value;
      }
      _listVariable.refresh();
    }, indexListVariable);
  }

  Widget _transporterAreaPickupWidget(String title, int indexListVariable,
      {void Function() seeAll}) {
    Map<String, dynamic> mapData =
        Map<String, dynamic>.from(_listVariable[indexListVariable.toString()]);
    return _filterAreaPickupTransporter(title, seeAll, (isChoosen, key, value) {
      if (!isChoosen) {
        mapData[_listChoosenTempKey].remove(key);
      } else {
        mapData[_listChoosenTempKey][key] = value;
      }
      _listVariable.refresh();
    }, (kategori, isChecked) {
      var getAreaWithKategori = List.from(_listAreaPickupTransporterModelFull)
          .where((element) => element.kategori == kategori)
          .toList();
      if (isChecked) {
        getAreaWithKategori.forEach((element) {
          mapData[_listChoosenTempKey][element.id.toString()] =
              element.description;
        });
      } else {
        getAreaWithKategori.forEach((element) {
          mapData[_listChoosenTempKey].remove(element.id.toString());
        });
      }
      _listVariable.refresh();
    }, indexListVariable);
  }

  Widget _switchWidget(List<String> label, int indexListVariable) {
    Map<String, dynamic> mapData =
        Map<String, dynamic>.from(_listVariable[indexListVariable.toString()]);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textTitle(label[0]),
        SizedBox(
          height: 15,
        ),
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(label[1],
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
              FlutterSwitch(
                  width: GlobalVariable.ratioWidth(Get.context) * 40,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                  toggleSize: GlobalVariable.ratioWidth(Get.context) * 20,
                  padding: GlobalVariable.ratioWidth(Get.context) * 2,
                  value: mapData[_switchTempKey],
                  activeColor: Color(ListColor.color4),
                  onToggle: (val) {
                    _listVariable[indexListVariable.toString()]
                        [_switchTempKey] = val;
                    _listVariable.refresh();
                  }),
            ]),
      ],
    );
  }

  Widget _radioButtonWidget(List<String> label, int indexListVariable,
      List<dynamic> listCustomValue) {
    List<RadioButtonFilterModel> listRadioButton =
        listCustomValue.map((data) => data as RadioButtonFilterModel).toList();
    Map<String, dynamic> mapData =
        Map<String, dynamic>.from(_listVariable[indexListVariable.toString()]);
    List<Widget> listWidget = [
      _textTitle(label[0]),
      SizedBox(
        height: 15,
      ),
    ];
    for (RadioButtonFilterModel data in listRadioButton) {
      listWidget.add(
        FlatButton(
          padding: EdgeInsets.zero,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            _onChooseRadioButton(indexListVariable, data);
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Radio(
                toggleable: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: mapData[_radioButtonTempKey],
                // groupValue: sortChoice.value,
                value: data.id,
                onChanged: (val) {
                  _onChooseRadioButton(indexListVariable, data);
                },
              ),
              CustomText(data.value, fontSize: 12),
            ],
          ),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listWidget,
    );
  }

  Widget _checkboxWidget(List<String> label, int indexListVariable,
      List<dynamic> listCustomValue) {
    List<CheckboxFilterModel> listcheckbox =
        listCustomValue.map((data) => data as CheckboxFilterModel).toList();
    List<Widget> listWidget = [
      _textTitle(label[0]),
      SizedBox(
        height: 15,
      ),
    ];
    listWidget.add(Wrap(children: [
      for (CheckboxFilterModel data in listcheckbox)
        FractionallySizedBox(
          widthFactor: 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => CheckBoxCustom(
                  size: 15,
                  shadowSize: 17,
                  isWithShadow: true,
                  value: (_listVariable[indexListVariable.toString()]
                          [_checkboxTempKey] as List)
                      .contains(data.id),
                  onChanged: (checked) {
                    _onChooseCheckbox(indexListVariable, data, checked);
                  },
                ),
              ),
              Container(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 2),
                      child: CustomText(data.value, fontSize: 12, color: Color(ListColor.colorLightGrey4), fontWeight: FontWeight.w500,)))
            ],
          )
        ),
    ]));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listWidget,
    );
  }

  void _onChooseRadioButton(
      int indexListVariable, RadioButtonFilterModel data) {
    if (_listVariable[indexListVariable.toString()][_radioButtonTempKey] ==
        data.id) {
      _listVariable[indexListVariable.toString()][_radioButtonTempKey] = "";
    } else {
      _listVariable[indexListVariable.toString()][_radioButtonTempKey] =
          data.id;
    }
    _listVariable.refresh();
  }

  void _onChooseCheckbox(
      int indexListVariable, CheckboxFilterModel data, bool isChoosen) {
    if (!isChoosen) {
      (_listVariable[indexListVariable.toString()][_checkboxTempKey] as List)
          .remove(data.id);
    } else {
      (_listVariable[indexListVariable.toString()][_checkboxTempKey] as List)
          .add(data.id);
    }
    _listVariable.refresh();
  }

  Widget _unitWidget(List<String> label, int indexListVariable) {
    //_listVariable[indexListVariable.toString()][_rangeValuesTempKey];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textTitle(label[0]),
        SizedBox(height: 15),
        Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: 1,
                      width: MediaQuery.of(Get.context).size.width,
                      color: Color(ListColor.colorLightGrey10)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: _textFieldUnitWidget((value) {
                          _setRangeValueUnit(
                              double.parse(value),
                              _listVariable[indexListVariable.toString()]
                                      [_rangeValuesTempKey]
                                  .end,
                              indexListVariable,
                              isUpdateTextEditingController: false);
                        }, indexListVariable,
                            _startUnitRangeTextEditingControllerKey),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 92,
                      ),
                      Expanded(
                        child: _textFieldUnitWidget((value) {
                          _setRangeValueUnit(
                              _listVariable[indexListVariable.toString()]
                                      [_rangeValuesTempKey]
                                  .start,
                              double.parse(value),
                              indexListVariable,
                              isUpdateTextEditingController: false);
                        }, indexListVariable,
                            _endUnitRangeTextEditingControllerKey),
                      )
                    ],
                  )
                ],
              ),
              _listVariable[indexListVariable.toString()]
                          [_errorMessageUnitKey] !=
                      ""
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        CustomText(
                            _listVariable[indexListVariable.toString()]
                                [_errorMessageUnitKey],
                            color: Colors.red,
                            fontSize: 12),
                      ],
                    )
                  : SizedBox.shrink(),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Divider(
                  //   thickness: 2,
                  //   color: Color(ListColor.colorGrey),
                  // ),
                  SliderTheme(
                      data: SliderThemeData(
                          trackHeight: 1,
                          activeTrackColor: Color(ListColor.colorBlue),
                          inactiveTrackColor: Color(ListColor.colorGrey),
                          thumbColor: Color(ListColor.colorWhite),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0)),
                      child: RangeSlider(
                          min: listWidgetInFilter[indexListVariable]
                                      .customValue ==
                                  null
                              ? 0.0
                              : listWidgetInFilter[indexListVariable]
                                  .customValue[0],
                          max: listWidgetInFilter[indexListVariable]
                                      .customValue ==
                                  null
                              ? _maxRangeValueUnit
                              : listWidgetInFilter[indexListVariable]
                                  .customValue[1],
                          values: _listVariable[indexListVariable.toString()]
                              [_rangeValuesTempKey],
                          onChanged: (values) {
                            _setRangeValueUnit(
                                values.start, values.end, indexListVariable);
                          })),
                ],
              ),
              // Wrap(
              //   children: [
              //     _getItemWrap("", "10 unit - 100 unit", false,
              //         (isChoosen, key, value) {
              //       _setRangeValueUnit(10, 100, indexListVariable);
              //     }),
              //     _getItemWrap("", "100 unit - 1000 unit", false,
              //         (isChoosen, key, value) {
              //       _setRangeValueUnit(100, 1000, indexListVariable);
              //     }),
              //     _getItemWrap("", "1000 unit - 5000 unit", false,
              //         (isChoosen, key, value) {
              //       _setRangeValueUnit(1000, 5000, indexListVariable);
              //     }),
              //   ],
              // )
            ]),
      ],
    );
  }

  Widget _textFieldUnitWidget(void Function(String) onChangeText,
      int indexListVariable, String keyTextEditingController) {
    return CustomTextField(
        textInputAction: TextInputAction.done,
        enabled: true,
        controller: _listVariable[indexListVariable.toString()]
            [keyTextEditingController],
        context: Get.context,
        textSize: 12,
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 7,
            vertical: GlobalVariable.ratioHeight(Get.context) * 9),
        style: TextStyle(color: Color(ListColor.colorLightGrey4)),
        newInputDecoration: InputDecoration(
          fillColor: Color(ListColor.colorLightGrey3),
          hintStyle: TextStyle(color: Color(ListColor.colorLightGrey2)),
          isDense: true,
          isCollapsed: true,
          // contentPadding:
          //     // isPassword
          //     //     ? EdgeInsets.fromLTRB(13.0, 16.0, 70.0, 16.0)
          //     //     :
          //     // EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          //     EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(ListColor.colorLightGrey7), width: 1.0),
            borderRadius: BorderRadius.circular(6),
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(ListColor.colorLightGrey7), width: 1.0),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(ListColor.colorLightGrey7), width: 2.0),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onChanged: (value) {
          OnChangeTextFieldNumber.checkNumber(
              () => _listVariable[indexListVariable.toString()]
                  [keyTextEditingController],
              value,
              true);

          onChangeText(_listVariable[indexListVariable.toString()]
                  [keyTextEditingController]
              .text);
        },
        maxLines: 1,
        keyboardType: TextInputType.number);
  }

  Widget _nameWidget(List<String> label, int indexListVariable) {
    var showClose = false.obs;
    showClose.value =
        _listVariable[indexListVariable.toString()][_nameTempKey].isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textTitle(label[0]),
        SizedBox(height: 15),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                textInputAction: TextInputAction.done,
                enabled: true,
                controller: _listVariable[indexListVariable.toString()]
                    [_nameTextEditingControllerKey],
                context: Get.context,
                textSize: 12,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: GlobalVariable.ratioHeight(Get.context) * 9),
                newInputDecoration: InputDecoration(
                  fillColor: Color(ListColor.colorLightGrey3),
                  // prefix: Icon(Icons.search, color: Color(ListColor.color4)),
                  isDense: true,
                  isCollapsed: true,
                  // contentPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey10), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  hintText: "Cari Nama Transporter",
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey2),
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey7), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey7), width: 2.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onChanged: (value) {
                  _listVariable[indexListVariable.toString()][_nameTempKey] =
                      value;
                  showClose.value = value.isNotEmpty;
                },
                maxLines: 1),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(Icons.search,
                    color: Color(ListColor.color4),
                    size: GlobalVariable.ratioHeight(Get.context) * 18)),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Obx(() => !showClose.value
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            _listVariable[indexListVariable.toString()]
                                [_nameTempKey] = "";
                            _listVariable[indexListVariable.toString()]
                                    [_nameTextEditingControllerKey]
                                .text = "";
                          },
                          child: Icon(
                            Icons.close,
                            color: Color(ListColor.colorGrey4),
                            size: GlobalVariable.ratioHeight(Get.context) * 20,
                          ))),
                )),
          ],
        ),
      ],
    );
  }

  void _checkListWidgetInFilter({
    @required void Function(int) onDate,
    @required void Function(int) onCity,
    @required void Function(int) onSwitch,
    @required void Function(int) onUnit,
    @required void Function(int) onTruck,
    @required void Function(int) onCarrier,
    @required void Function(int) onRadioButton,
    @required void Function(int) onCheckbox,
    @required void Function(int) onEkspektasiDestinasi,
    @required void Function(int) onName,
    @required void Function(int) onAreaPickupSearch,
    @required void Function(int) onAreaPickupTransporter,
  }) {
    print("checkListWidgetInFilter");
    for (int i = 0; i < listWidgetInFilter.length; i++) {
      if (listWidgetInFilter[i].typeInFilter == TypeInFilter.DATE ||
          listWidgetInFilter[i].typeInFilter == TypeInFilter.YEAR) {
        if (onDate != null) onDate(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.CITY) {
        if (onCity != null) onCity(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.SWITCH) {
        if (onSwitch != null) onSwitch(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.UNIT) {
        if (onUnit != null) onUnit(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.TRUCK) {
        if (onTruck != null) onTruck(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.CARRIER) {
        if (onCarrier != null) onCarrier(i);
      } else if (listWidgetInFilter[i].typeInFilter ==
          TypeInFilter.RADIO_BUTTON) {
        if (onRadioButton != null) onRadioButton(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.CHECKBOX) {
        if (onCheckbox != null) onCheckbox(i);
      } else if (listWidgetInFilter[i].typeInFilter ==
          TypeInFilter.EKSPEKTASI_DESTINASI) {
        if (onEkspektasiDestinasi != null) onEkspektasiDestinasi(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.NAME) {
        if (onName != null) onName(i);
      } else if (listWidgetInFilter[i].typeInFilter ==
          TypeInFilter.AREA_PICKUP_SEARCH) {
        if (onAreaPickupSearch != null) onAreaPickupSearch(i);
      } else if (listWidgetInFilter[i].typeInFilter ==
          TypeInFilter.AREA_PICKUP_TRANSPORTER) {
        if (onAreaPickupTransporter != null) onAreaPickupTransporter(i);
      }
    }
  }

  String _getValueRadioButton(String id, int index) {
    String result = "";
    List<RadioButtonFilterModel> listRadioButton =
        listWidgetInFilter[index].customValue.map((data) {
      RadioButtonFilterModel radioData = data as RadioButtonFilterModel;
      if (radioData.id == id) result = radioData.value;
      return data as RadioButtonFilterModel;
    }).toList();
    return result;
  }

  void updateListFilterModel(int index, WidgetFilterModel widget) {
    listWidgetInFilter[index] = widget;
    //_resetAll();
  }

  void _showPrint(String message) {
    if (kDebugMode) print("result message:" + message);
  }
}

class ItemWrap {
  final String key;
  final String value;
  bool isChoosen;

  ItemWrap({this.key, this.value, this.isChoosen});
}
