import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/onchange_textfield_number_ark.dart';
import 'package:muatmuat/app/core/models/head_truck_response_model.dart';
import 'package:muatmuat/app/core/models/radio_button_filter_model.dart';
import 'package:muatmuat/app/core/models/checkbox_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/search_area_pickup_filter_model.dart';
import 'package:muatmuat/app/core/models/search_area_pickup_response_model.dart';
import 'package:muatmuat/app/core/models/transporter_area_pickup_filter_model.dart';
import 'package:muatmuat/app/core/models/transporter_area_pickup_response_model.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_response_model.dart';
import 'package:muatmuat/app/core/models/head_truck_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/radio_button_custom_with_text_widget_ark.dart';
import 'package:muatmuat/app/modules/choose_ekspetasi_destinasi/choose_ekspetasi_destinasi_controller.dart';
import 'package:muatmuat/app/modules/list_area_pickup_search_filter/list_area_pickup_search_filter_controller.dart';
import 'package:muatmuat/app/modules/list_area_pickup_transporter_filter/list_area_pickup_transporter_filter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_carrier_filter_ark/list_carrier_filter_ark_controller.dart';
import 'package:muatmuat/app/modules/list_city_filter/list_city_filter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_city_filter_ark/list_city_filter_ark_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_destinasi_filter_ark/list_destinasi_filter_ark_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_diumumkan_kepada_filter/list_diumumkan_kepada_filter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_muatan_filter/list_muatan_filter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_province_filter_ark/list_province_filter_ark_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_truck_carrier_filter/list_truck_carrier_filter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_truck_filter_ark/list_truck_filter_ark_controller.dart';
// import 'package:muatmuat/app/modules/ARK/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:quiver/strings.dart';
import 'package:validators/sanitizers.dart';

class FilterCustomControllerArk extends GetxController {
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

  //City / Wrap Item / Area Pickup Search / Area Pickup Transporter
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
  var jumlahMax = 0.obs;

  //Radio Button
  final String _radioButtonKey = "RadioButton";
  final String _radioButtonTempKey = "RadioButtonTemp";

  //Checkbox
  final String _checkboxKey = "CheckBox";
  final String _checkboxTempKey = "CheckBoxTemp";

  //Checkbox with hide
  final String _checkboxHideKey = "CheckBoxHide";
  final String _checkboxHideTempKey = "CheckBoxHideTemp";
  final String _hide = "Hide";
  final String _hideTemp = "HideTemp";

  //Name
  final String _nameKey = "Name";
  final String _nameTempKey = "NameTemp";
  final String _nameTextEditingControllerKey = "NameTextEditingController";

  //Satuan Tender

  // final String _radioButtonValueKey = "RadioButtonValue";
  // final String _radioButtonValueTempKey = "RadioButtonValueTemp";

  //Muatan
  final String _muatanKey = "Muatan";
  final String _muatanTempKey = "MuatanTemp";
  final String _muatanIDKey = "MuatanID";
  final String _muatanIDTempKey = "MuatanIDTemp";

  //Diumumkan Kepada
  final String _diumumkanKey = "Diumumkan";
  final String _diumumkanTempKey = "DiumumkanTemp";

  //unit&satuan
  final String _satuanKey = "Satuan";
  final String _satuanTempKey = "SatuanTemp";

  //provinsi
  final String _provinceName = "ProvinceName";
  final String _provinceNameTemp = "ProvinceNameTemp";
  final String _provinceIDTemp = "ProvinceIDTemp";
  final String _provinceID = "ProvinceID";
  final String _rawDataProvince = "rawDataProvince";

  //truck
  final String _truckName = "TruckName";
  final String _truckNameTemp = "TruckNameTemp";
  final String _truckIDTemp = "TruckIDTemp";
  final String _truckID = "TruckID";
  final String _rawDataTruck = "rawDataTruck";

  //carrier
  final String _carrierName = "CarrierName";
  final String _carrierNameTemp = "CarrierNameTemp";
  final String _carrierIDTemp = "CarrierIDTemp";
  final String _carrierID = "CarrierID";
  final String _rawDataCarrier = "rawDataCarrier";

  //volume
  final String _satuanVolume = "SatuanVolume";
  final String _satuanVolumeTemp = "SatuanVolumeTemp";
  final String _satuanVolumeKey = "SatuanVolumeKey";
  final String _satuanVolumeKeyTemp = "SatuanVolumeKeyTemp";
  final String _nilaiVolume = "NilaiVolume";
  final String _nilaiVolumeTemp = "NilaiVolumeTemp";
  final String _nilaiController = "NilaiController";
  final String _nilaiControllerTemp = "NilaiControllerTemp";

  //kapasitas
  final String _satuanKapasitas = "satuanKapasitas";
  final String _satuanKapasitasTemp = "satuanKapasitasTemp";
  final String _satuanKapasitasKey = "satuanKapasitasKey";
  final String _satuanKapasitasKeyTemp = "satuanKapasitasKeyTemp";
  final String _nilaiKapasitasMin = "nilaiKapasitasMin";
  final String _nilaiKapasitasMinTemp = "nilaiKapasitasMinTemp";
  final String _nilaiKapasitasMinController = "nilaiKapasitasMinController";
  final String _nilaiKapasitasMinControllerTemp =
      "nilaiKapasitasMinControllerTemp";
  final String _nilaiKapasitasMax = "nilaiKapasitasMax";
  final String _nilaiKapasitasMaxTemp = "nilaiKapasitasMaxTemp";
  final String _nilaiKapasitasMaxController = "nilaiKapasitasMaxController";
  final String _nilaiKapasitasMaxControllerTemp =
      "nilaiKapasitasMaxControllerTemp";

  //dimension
  final String _panjang = "Panjang";
  final String _panjangTemp = "PanjangTemp";
  final String _lebarTemp = "LebarTemp";
  final String _lebar = "Lebar";
  final String _tinggiTemp = "TinggiTemp";
  final String _tinggi = "Tinggi";
  final String _satuanDimension = "SatuanDimension";
  final String _satuanDimensionTemp = "SatuanDimensionTemp";
  final String _separatorDimension = "SeparatorDimension";
  final String _satuanDimensionKey = "SatuanDimensionKey";
  final String _satuanDimensionKeyTemp = "SatuanDimensionKeyTemp";

  Map<String, dynamic> _listCity = {};
  Map<String, dynamic> _listProvince = {};
  Map<String, dynamic> _listAreaPickupSearch = {};
  Map<String, dynamic> _listAreaPickupTransporter = {};
  Map<String, dynamic> _listEkspektasiDestinasi = {};
  Map<String, dynamic> _listMuatan = {};

  List<dynamic> _listTruck = [];
  List<dynamic> _listCarrier = [];
  List<SearchAreaPickupFilterModel> _listAreaPickupSearchModel = [];
  List<SearchAreaPickupFilterModel> _listAreaPickupSearchModelFull = [];
  List<TransporterAreaPickupFilterModel> _listAreaPickupTransporterModel = [];
  List<TransporterAreaPickupFilterModel> _listAreaPickupTransporterModelFull =
      [];

  var isReset = false.obs;
  var _filterheight = MediaQuery.of(Get.context).size.height - 200;
  final _listVariable = {}.obs;

  final _isGettingData = false.obs;
  final _isSuccessGettingData = true.obs;

  final int _maxDataWrapFilter = 5;

  void Function(Map<String, dynamic>) returnData;
  final List<WidgetFilterModel> listWidgetInFilter;

  final String _hintFirstDate = "InfoPraTenderIndexHintDate"
      .tr; //hh-bb-tttt //"GlobalFilterHintFirstDate".tr -> dari tanggal
  final String _hintEndDate = "InfoPraTenderIndexHintDate"
      .tr; //"GlobalFilterHintEndDate".tr -> sampai tanggal
  final String _hintFirstYear = "GlobalFilterHintFirstYear".tr;
  final String _hintEndYear = "GlobalFilterHintEndYear".tr;

  bool _isDestinasi = false;
  bool _isCity = false;
  bool _isUnit = false;
  bool _isProvince = false;
  bool _isTruck = false;
  bool _isCarrier = false;
  bool _isAreaPickupSearch = false;
  bool _isAreaPickupTransporter = false;
  bool _isEkspektasiDestinasi = false;

  FilterCustomControllerArk({
    @required this.returnData,
    @required this.listWidgetInFilter,
  });

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
      _listVariable[index.toString()] = {
        _listNotChoosenKey: {},
        _listChoosenKey: {},
        _listChoosenTempKey: {},
        _listDataInViewKey: List<ItemWrap>.from([]),
        _isFromSeeAllOrFirstTimeKey: true,
      };
    }, onLocation: (index) {
      _listVariable[index.toString()] = {
        _listNotChoosenKey: {},
        _listChoosenKey: {},
        _listChoosenTempKey: {},
        _listDataInViewKey: List<ItemWrap>.from([]),
        _isFromSeeAllOrFirstTimeKey: true,
      };
    }, onSwitch: (index) {
      _listVariable[index.toString()] = {
        _switchKey: false,
        _switchTempKey: false
      };
    }, onDestinasi: (index) {
      _listVariable[index.toString()] = {
        _listNotChoosenKey: {},
        _listChoosenKey: {},
        _listChoosenTempKey: {},
        _listDataInViewKey: List<ItemWrap>.from([]),
        _isFromSeeAllOrFirstTimeKey: true,
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
          index,
          _listVariable[index.toString()][_rangeValuesTempKey].start,
          _listVariable[index.toString()][_rangeValuesTempKey].end,
          index,
          isUpdateTextEditingController: true);
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
    }, onCheckboxWithHide: (index) {
      List<dynamic> datahide = [];
      List<dynamic> dataCheckbox = listWidgetInFilter[index].customValue;
      for (int i = 0; i < dataCheckbox.length; i++) {
        if (dataCheckbox[i].canHide) {
          datahide.add({
            "hide": true,
            "hideIndex": dataCheckbox[i].hideIndex,
            "checkboxIndex": i,
          });
        }
      }
      _listVariable[index.toString()] = {
        _checkboxHideKey: [],
        _checkboxHideTempKey: [],
        _hide: jsonDecode(jsonEncode(datahide)),
        _hideTemp: jsonDecode(jsonEncode(datahide)),
      };
      _listVariable.refresh();
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
    }, onMuatan: (index) {
      _listVariable[index.toString()] = {
        _muatanKey: [],
        _muatanIDKey: [],
        _muatanTempKey: [],
        _muatanIDTempKey: [],
      };
    }, onDiumumkanKepada: (index) {
      _listVariable[index.toString()] = {
        _diumumkanKey: [],
        _diumumkanTempKey: [],
      };
    }, onUnitSatuan: (index) {
      double min = 0;
      double max = 0;
      //_listVariable[index.toString()][_loadDataUnitKey] = null;

      // if (listWidgetInFilter[index].customValue != null) {
      //   min = listWidgetInFilter[index].customValue[0];
      //   max = listWidgetInFilter[index].customValue[1];
      // }
      _listVariable[index.toString()] = {
        _rangeValuesKey: RangeValues(
            min,
            (listWidgetInFilter[index].initValue ?? []).length > min
                ? (double.tryParse(listWidgetInFilter[index].initValue[0]) ??
                    max)
                : max),
        _rangeValuesTempKey: RangeValues(min, max),
        _startUnitRangeTextEditingControllerKey:
            TextEditingController(text: "0"),
        _endUnitRangeTextEditingControllerKey: TextEditingController(text: "0"),
        _errorMessageUnitKey: "",
        _isAlreadyLoadDataKey: false,
      };
      if (listWidgetInFilter[index].customValue != null &&
          listWidgetInFilter[index].customValue.length > 2) {
        _listVariable[index.toString()][_loadDataUnitKey] =
            listWidgetInFilter[index].customValue[2];
      }
      _setRangeValueUnit(
          index,
          _listVariable[index.toString()][_rangeValuesTempKey].start,
          _listVariable[index.toString()][_rangeValuesTempKey].end,
          index,
          isUpdateTextEditingController: true);
    }, onSatuan: (index) {
      _listVariable[index.toString()] = {
        _satuanKey: [],
        _satuanTempKey: [],
        "min": double.parse('0'),
        "max": double.parse('0'),
        "enable": false,
        "minKey": double.parse('0'),
        "maxKey": double.parse('0'),
        "enableKey": false,
        "isDecimal": false,
      };
    }, onVolume: (index) {
      _listVariable[index.toString()] = {
        _nilaiVolume: "",
        _nilaiVolumeTemp: "",
        _satuanVolume: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['label'],
        _satuanVolumeTemp: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['label'],
        _satuanVolumeKey: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['key'],
        _satuanVolumeKeyTemp: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['key'],
        _nilaiController: TextEditingController(),
        _nilaiControllerTemp: TextEditingController(),
      };
    }, onCapacity: (index) {
      _listVariable[index.toString()] = {
        _nilaiKapasitasMin: "",
        _nilaiKapasitasMinTemp: "",
        _nilaiKapasitasMax: "",
        _nilaiKapasitasMaxTemp: "",
        _satuanKapasitas: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['label'],
        _satuanKapasitasTemp: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['label'],
        _satuanKapasitasKey: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['key'],
        _satuanKapasitasKeyTemp:
            listWidgetInFilter[index].customValue.length == 0
                ? ""
                : listWidgetInFilter[index].customValue[0]['key'],
        _nilaiKapasitasMinController: TextEditingController(),
        _nilaiKapasitasMinControllerTemp: TextEditingController(),
        _nilaiKapasitasMaxController: TextEditingController(),
        _nilaiKapasitasMaxControllerTemp: TextEditingController(),
      };
    }, onDimension: (index) {
      _listVariable[index.toString()] = {
        _panjang: TextEditingController(),
        _panjangTemp: TextEditingController(),
        _lebar: TextEditingController(),
        _lebarTemp: TextEditingController(),
        _tinggi: TextEditingController(),
        _tinggiTemp: TextEditingController(),
        _separatorDimension: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['separator'],
        _satuanDimension: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['satuan'][0]['label'],
        _satuanDimensionTemp: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['satuan'][0]['label'],
        _satuanDimensionKey: listWidgetInFilter[index].customValue.length == 0
            ? ""
            : listWidgetInFilter[index].customValue[0]['satuan'][0]['key'],
        _satuanDimensionKeyTemp:
            listWidgetInFilter[index].customValue.length == 0
                ? ""
                : listWidgetInFilter[index].customValue[0]['satuan'][0]['key'],
      };
    }, onProvince: (index) {
      _listVariable[index.toString()] = {
        _listNotChoosenKey: {},
        _listChoosenKey: {},
        _listChoosenTempKey: {},
        _listDataInViewKey: List<ItemWrap>.from([]),
        _isFromSeeAllOrFirstTimeKey: true,
      };
    }, onTruck: (index) {
      _listVariable[index.toString()] = {
        _truckID: [],
        _truckIDTemp: [],
        _truckName: [],
        _truckNameTemp: [],
      };
    }, onCarrier: (index) {
      _listVariable[index.toString()] = {
        _carrierID: [],
        _carrierIDTemp: [],
        _carrierName: [],
        _carrierNameTemp: [],
      };
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
    if (listWidgetContent.length > 0)
      listWidgetContent.add(Padding(
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 15,
          ),
          child: _lineSeparator()));
    listWidgetContent.add(widget);
  }

  void _addWidgetCityToContent(List<Widget> listWidgetContent, Widget widget) {
    if (listWidgetContent.length > 0)
      listWidgetContent.add(Padding(
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 15,
          ),
          child: _lineSeparatorCity()));
    listWidgetContent.add(widget);
  }

  Widget _lineSeparatorCity() {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        // margin: EdgeInsets.symmetric(vertical: 16),
        height: 0.5,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey5).withOpacity(0.29));
  }

  List<Widget> _getListWidgetCotent() {
    List<Widget> listWidgetContent = [];
    _showPrint("_checkListWidgetInFilter: _getListWidgetCotent");
    _checkListWidgetInFilter(
      onDate: (index) {
        _addWidgetToContent(
            listWidgetContent,
            _dateWidget(listWidgetInFilter[index].label[0],
                _listVariable[index.toString()], index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onCity: (index) {
        _addWidgetCityWrapToContent(index, listWidgetContent);
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12));
      },
      onLocation: (index) {
        _addWidgetLocationWrapToContent(index, listWidgetContent);
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12));
      },
      onDestinasi: (index) {
        _addWidgetToContent(listWidgetContent, addDestinasi(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12));
      },
      onSwitch: (index) {
        _addWidgetToContent(listWidgetContent,
            _switchWidget(listWidgetInFilter[index].label, index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onUnit: (index) {
        _addWidgetToContent(listWidgetContent,
            _unitWidget(listWidgetInFilter[index].label, index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 5));
      },
      onRadioButton: (index) {
        _addWidgetToContent(
            listWidgetContent,
            _radioButtonWidget(listWidgetInFilter[index].label, index,
                listWidgetInFilter[index].customValue));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onCheckbox: (index) {
        // _addWidgetToContent(
        //     listWidgetContent,
        //     _checkboxWidget(listWidgetInFilter[index].label, index,
        //         listWidgetInFilter[index].customValue));
        _addWidgetToContent(listWidgetContent, addCheckbox(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onCheckboxWithHide: (index) {
        // _addWidgetToContent(
        //     listWidgetContent,
        //     _checkboxWidget(listWidgetInFilter[index].label, index,
        //         listWidgetInFilter[index].customValue));
        listWidgetInFilter[index].hideLine
            ? listWidgetContent.add(addCheckboxWithHide(index))
            : _addWidgetToContent(
                listWidgetContent, addCheckboxWithHide(index));
        // listWidgetContent
        //     .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onEkspektasiDestinasi: (index) {
        _addWidgetEkspektasiDestinasiWrapToContent(index, listWidgetContent);
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onName: (index) {
        _addWidgetToContent(listWidgetContent,
            _nameWidget(listWidgetInFilter[index].label, index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onAreaPickupSearch: (index) {
        indexAreaPickupSearch = index;
        _addWidgetAreaPickupSearchToContent(index, listWidgetContent);
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onAreaPickupTransporter: (index) {
        indexAreaPickupTransporter = index;
        _addWidgetAreaPickupTransporterToContent(index, listWidgetContent);
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onMuatan: (index) {
        int indexDataHide = 0;
        int checkHideIndex = listWidgetInFilter[index].numberHideFilter;
        if (listWidgetInFilter[index].canBeHide == true) {
          List<dynamic> datahide =
              _listVariable[checkHideIndex.toString()][_hideTemp];
          for (int i = 0; i < datahide.length; i++) {
            if (datahide[i]['hideIndex'] == index) {
              indexDataHide = i;
            }
          }
        }
        _listVariable.refresh();
        listWidgetInFilter[index].hideLine
            ? listWidgetInFilter[index].canBeHide == true
                ? listWidgetContent.add(
                    Obx(
                      () => _listVariable[checkHideIndex.toString()][_hideTemp]
                                  [indexDataHide]['hide'] ==
                              true
                          ? Container()
                          : addMuatan(index),
                    ),
                  )
                : listWidgetContent.add(addMuatan(index))
            : _addWidgetToContent(listWidgetContent, addMuatan(index));
        listWidgetContent.add(SizedBox(
          height: GlobalVariable.ratioWidth(Get.context) *
              listWidgetInFilter[index].heightPaddingBottom,
        ));
      },
      onDiumumkanKepada: (index) {
        int indexDataHide = 0;
        int checkHideIndex = listWidgetInFilter[index].numberHideFilter;
        if (listWidgetInFilter[index].canBeHide == true) {
          List<dynamic> datahide =
              _listVariable[checkHideIndex.toString()][_hideTemp];
          for (int i = 0; i < datahide.length; i++) {
            if (datahide[i]['hideIndex'] == index) {
              indexDataHide = i;
            }
          }
        }
        _listVariable.refresh();
        listWidgetInFilter[index].hideLine
            ? listWidgetInFilter[index].canBeHide == true
                ? listWidgetContent.add(
                    Obx(
                      () => _listVariable[checkHideIndex.toString()][_hideTemp]
                                  [indexDataHide]['hide'] ==
                              true
                          ? Container()
                          : addDiumumkan(index),
                    ),
                  )
                : listWidgetContent.add(addDiumumkan(index))
            : _addWidgetToContent(listWidgetContent, addDiumumkan(index));

        listWidgetContent.add(SizedBox(
          height: GlobalVariable.ratioWidth(Get.context) *
              listWidgetInFilter[index].heightPaddingBottom,
        ));
      },
      onSatuan: (index) {
        _addWidgetToContent(listWidgetContent, addSatuan(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 2));
      },
      onUnitSatuan: (index) {
        listWidgetContent.add(addUnitSatuan(index));

        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 5));
        // listWidgetContent
        //     .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onProvince: (index) {
        _addWidgetToContent(listWidgetContent, addProvince(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12));
      },
      onVolume: (index) {
        _addWidgetToContent(listWidgetContent, addVolume(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onCapacity: (index) {
        _addWidgetToContent(listWidgetContent, addCapacity(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onDimension: (index) {
        _addWidgetToContent(listWidgetContent, addDimension(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onTruck: (index) {
        _addWidgetToContent(listWidgetContent, addTruck(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
      onCarrier: (index) {
        _addWidgetToContent(listWidgetContent, addCarrier(index));
        listWidgetContent
            .add(SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20));
      },
    );
    return listWidgetContent;
  }

  Widget addProvince(int index) {
    return _wrapItemProvinceWidget(listWidgetInFilter[index].label[0], index,
        seeAll: () async {
      Map<String, dynamic> mapData =
          Map<String, dynamic>.from(_listVariable[index.toString()]);
      var result = await GetToPage.toNamed<ListProvinceFilterArkController>(
          Routes.LIST_PROVINCE_FILTER_ARK,
          arguments: [
            _listProvince,
            _listVariable[index.toString()][_listChoosenTempKey],
            listWidgetInFilter[index].label[1] ?? "",
            listWidgetInFilter[index].label[2] ?? "",
          ],
          preventDuplicates: false);
      if (result != null) {
        _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
        _listVariable[index.toString()][_listChoosenTempKey].clear();
        _listVariable[index.toString()][_listChoosenTempKey].addAll(result);
        _listVariable.refresh();
      }
    });
  }

  Widget _wrapItemProvinceWidget(String title, int indexListVariable,
      {void Function() seeAll}) {
    Map<String, dynamic> mapData =
        Map<String, dynamic>.from(_listVariable[indexListVariable.toString()]);
    return _filterWrapProvince(title, seeAll, (isChoosen, key, value) {
      if (!isChoosen) {
        mapData[_listChoosenTempKey].remove(key);
      } else {
        mapData[_listChoosenTempKey][key] = value;
      }
      _listVariable.refresh();
    }, indexListVariable);
  }

  Widget _filterWrapProvince(
      String title,
      void Function() seeAll,
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textTitle(title),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: GlobalVariable.ratioWidth(Get.context) * 1),
                //   child: _textTitle(title),
                // ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 1,
                        // bottom: GlobalVariable.ratioWidth(Get.context) * 1,
                      ),
                      child: countBadge(_listVariable[index.toString()]
                              [_listChoosenTempKey]
                          .length),
                    ),
                  ],
                )),
                // Expanded(
                //   child: countBadge(_listVariable[index.toString()]
                //           [_listChoosenTempKey]
                //       .length),
                // ),
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
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 1),
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
          SizedBox(height: 18),
          Wrap(
            spacing: GlobalVariable.ratioWidth(Get.context) * 8,
            children: getListProvinceWrap(onTapItem, index),
          )
        ],
      ),
    );
  }

  List<Widget> getListProvinceWrap(
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    List<Widget> cityWrap = <Widget>[];
    Map<String, dynamic> mapChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listChoosenTempKey]);
    // int jumlah = mapChoosen.length > 5 ? 5 : mapChoosen.length;
    int jumlah = 0;
    mapChoosen.entries.forEach((element) {
      if (jumlah < 5) {
        cityWrap.add(_getItemWrap(
            element.key, element.value.toString(), true, onTapItem));
        jumlah++;
      }
    });
    int ctr = 0;
    var sortProvince = _getSortingByValue(_listProvince);
    while (jumlah < 5) {
      if (ctr >= sortProvince.length) {
        jumlah = 5;
      } else {
        bool check = false;
        mapChoosen.entries.forEach((element) {
          if (element.key == sortProvince.keys.elementAt(ctr)) {
            check = true;
          }
        });
        if (!check) {
          cityWrap.add(_getItemWrap(sortProvince.keys.elementAt(ctr),
              sortProvince.values.elementAt(ctr), false, onTapItem));
          jumlah++;
        }
      }
      ctr++;
    }
    return cityWrap;
  }

  Widget addCapacity(int index) {
    List<dynamic> arrSatuanVolume = listWidgetInFilter[index].customValue;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: _textTitle(listWidgetInFilter[index].label[0]),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: CustomTextFormField(
                context: Get.context,
                textSize: 12,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
                  DecimalInputFormatter(
                      digit: 13,
                      digitAfterComma: 3,
                      controller: _listVariable[index.toString()]
                          [_nilaiKapasitasMinControllerTemp])
                ],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorLightGrey4),
                ),
                newContentPadding: EdgeInsets.symmetric(
                  // vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                  // horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                ),
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      listWidgetInFilter[index].label[1] ?? "", // Contoh : 50
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey2),
                  ),
                ),
                controller: _listVariable[index.toString()]
                    [_nilaiKapasitasMinControllerTemp],
              )),
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                  ),
                  child: Center(
                    child: CustomText(
                      "s/d",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Expanded(
                  child: CustomTextFormField(
                context: Get.context,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
                  DecimalInputFormatter(
                      digit: 13,
                      digitAfterComma: 3,
                      controller: _listVariable[index.toString()]
                          [_nilaiKapasitasMaxControllerTemp])
                ],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorLightGrey4),
                ),
                newContentPadding: EdgeInsets.symmetric(
                  // vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                  //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                ),
                textSize: 12,
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      listWidgetInFilter[index].label[1] ?? "", // Contoh : 50
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey2),
                  ),
                ),
                controller: _listVariable[index.toString()]
                    [_nilaiKapasitasMaxControllerTemp],
              )),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
              Obx(
                () => DropdownBelow(
                  itemWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                  itemTextstyle: TextStyle(
                      color: Color(ListColor.colorGrey3),
                      fontWeight: FontWeight.w500,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 12),
                  boxTextstyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w500,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 12),
                  boxPadding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 11,
                      right: GlobalVariable.ratioWidth(Get.context) * 7),
                  boxWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                  // boxHeight: GlobalVariable.ratioWidth(Get.context) * 44,
                  boxHeight: GlobalVariable.ratioWidth(Get.context) * 32,
                  boxDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6),
                      border: Border.all(
                          width: 1, color: Color(ListColor.colorGrey2))),
                  icon: Icon(Icons.keyboard_arrow_down_sharp,
                      size: GlobalVariable.ratioWidth(Get.context) * 16,
                      color: Color(ListColor.colorGrey4)),
                  value: _listVariable[index.toString()]
                      [_satuanKapasitasKeyTemp],
                  // hint: CustomText(arrSatuanVolume[0]['label'],
                  //     color: Color(ListColor.colorLightGrey4),
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w600),
                  hint: CustomText(
                      _listVariable[index.toString()][_satuanKapasitasTemp] !=
                              ""
                          ? _listVariable[index.toString()]
                              [_satuanKapasitasTemp]
                          : arrSatuanVolume[0]['label'] ?? "",
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  items: [
                    for (int i = 0; i < arrSatuanVolume.length; i++)
                      DropdownMenuItem(
                        child: CustomText(arrSatuanVolume[i]['label'],
                            color: Color(ListColor.colorLightGrey4),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        value: arrSatuanVolume[i]['key'],
                      ),
                  ],
                  onChanged: (value) {
                    FocusManager.instance.primaryFocus.unfocus();
                    _listVariable[index.toString()][_satuanKapasitasKeyTemp] =
                        value;
                    for (int i = 0; i < arrSatuanVolume.length; i++) {
                      if (arrSatuanVolume[i]['key'] == value) {
                        _listVariable[index.toString()][_satuanKapasitasTemp] =
                            arrSatuanVolume[i]['label'];
                      }
                    }
                    _listVariable.refresh();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addVolume(int index) {
    List<dynamic> arrSatuanVolume = listWidgetInFilter[index].customValue;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: _textTitle(listWidgetInFilter[index].label[0]),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: CustomTextFormField(
                context: Get.context,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
                  DecimalInputFormatter(
                      digit: 13,
                      digitAfterComma: 3,
                      controller: _listVariable[index.toString()]
                          [_nilaiControllerTemp])
                ],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorLightGrey4),
                ),
                newContentPadding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                  //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                ),
                textSize: 14,
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      listWidgetInFilter[index].label[1] ?? "", // Contoh : 50
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey2),
                  ),
                ),
                controller: _listVariable[index.toString()]
                    [_nilaiControllerTemp],
              )),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
              Obx(
                () => DropdownBelow(
                  itemWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                  itemTextstyle: TextStyle(
                      color: Color(ListColor.colorGrey3),
                      fontWeight: FontWeight.w500,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 12),
                  boxTextstyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w500,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 12),
                  boxPadding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 11,
                      right: GlobalVariable.ratioWidth(Get.context) * 7),
                  boxWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                  boxHeight: GlobalVariable.ratioWidth(Get.context) * 44,
                  boxDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6),
                      border: Border.all(
                          width: 1, color: Color(ListColor.colorGrey2))),
                  icon: Icon(Icons.keyboard_arrow_down_sharp,
                      size: GlobalVariable.ratioWidth(Get.context) * 16,
                      color: Color(ListColor.colorGrey4)),
                  value: _listVariable[index.toString()][_satuanVolumeKeyTemp],
                  // hint: CustomText(arrSatuanVolume[0]['label'],
                  //     color: Color(ListColor.colorLightGrey4),
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w600),
                  hint: CustomText(
                      _listVariable[index.toString()][_satuanVolumeTemp] != ""
                          ? _listVariable[index.toString()][_satuanVolumeTemp]
                          : arrSatuanVolume[0]['label'] ?? "",
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  items: [
                    for (int i = 0; i < arrSatuanVolume.length; i++)
                      DropdownMenuItem(
                        child: CustomText(arrSatuanVolume[i]['label'],
                            color: Color(ListColor.colorLightGrey4),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        value: arrSatuanVolume[i]['key'],
                      ),
                  ],
                  onChanged: (value) {
                    FocusManager.instance.primaryFocus.unfocus();
                    _listVariable[index.toString()][_satuanVolumeKeyTemp] =
                        value;
                    for (int i = 0; i < arrSatuanVolume.length; i++) {
                      if (arrSatuanVolume[i]['key'] == value) {
                        _listVariable[index.toString()][_satuanVolumeTemp] =
                            arrSatuanVolume[i]['label'];
                      }
                    }
                    _listVariable.refresh();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addDimension(int index) {
    List<dynamic> arrSatuanDimensi =
        listWidgetInFilter[index].customValue[0]['satuan'];

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: _textTitle(listWidgetInFilter[index].label[0]),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        // vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                        vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                        // horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Color(ListColor.colorBorderTextbox)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 6))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 42,
                            child: CustomTextField(
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9\,]")),
                                DecimalInputFormatter(
                                    digit: 5,
                                    digitAfterComma: 2,
                                    controller: _listVariable[index.toString()]
                                        [_panjangTemp])
                              ],
                              textAlign: TextAlign.center,
                              context: Get.context,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      12),
                              newInputDecoration: InputDecoration(
                                // contentPadding: EdgeInsets.only(
                                //   top: GlobalVariable.ratioWidth(Get.context) *
                                //       2,
                                // ),
                                fillColor: Colors.white,
                                filled: true,
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                isDense: true,
                                isCollapsed: true,
                                hintText: "ProsesTenderCreateLabelP".tr, //p
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      12,
                                  color: Color(ListColor.colorLightGrey2),
                                ),
                              ),
                              controller: _listVariable[index.toString()]
                                  [_panjangTemp],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 2,
                              left: GlobalVariable.ratioWidth(Get.context) * 0,
                              right: GlobalVariable.ratioWidth(Get.context) * 0,
                            ),
                            child: CustomText(
                              "x".tr,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 42,
                            child: CustomTextField(
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9\,]")),
                                DecimalInputFormatter(
                                  digit: 5,
                                  digitAfterComma: 2,
                                  controller: _listVariable[index.toString()]
                                      [_lebarTemp],
                                )
                              ],
                              textAlign: TextAlign.center,
                              context: Get.context,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      12),
                              newInputDecoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                // contentPadding: EdgeInsets.only(
                                //   top: GlobalVariable.ratioWidth(Get.context) *
                                //       2,
                                // ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                isDense: true,
                                isCollapsed: true,
                                hintText: "ProsesTenderCreateLabelL".tr, //l
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      12,
                                  color: Color(ListColor.colorLightGrey2),
                                ),
                              ),
                              controller: _listVariable[index.toString()]
                                  [_lebarTemp],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 2,
                              left: GlobalVariable.ratioWidth(Get.context) * 0,
                              right: GlobalVariable.ratioWidth(Get.context) * 0,
                            ),
                            child: CustomText(
                              "x".tr,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 42,
                              child: CustomTextField(
                                keyboardType: TextInputType.text,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9\,]")),
                                  DecimalInputFormatter(
                                    digit: 5,
                                    digitAfterComma: 2,
                                    controller: _listVariable[index.toString()]
                                        [_tinggiTemp],
                                  )
                                ],
                                textAlign: TextAlign.center,
                                context: Get.context,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorLightGrey4),
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        12),
                                newInputDecoration: InputDecoration(
                                  // contentPadding: EdgeInsets.only(
                                  //   top: GlobalVariable.ratioWidth(
                                  //           Get.context) *
                                  //       2,
                                  // ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText: "ProsesTenderCreateLabelT".tr, // t
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        12,
                                    color: Color(ListColor.colorLightGrey2),
                                  ),
                                ),
                                controller: _listVariable[index.toString()]
                                    [_tinggiTemp],
                              ))
                        ],
                      ))),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
              Obx(() => DropdownBelow(
                    itemWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                    itemTextstyle: TextStyle(
                        color: Color(ListColor.colorGrey3),
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12),
                    boxTextstyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12),
                    boxPadding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 11,
                        right: GlobalVariable.ratioWidth(Get.context) * 7),
                    boxWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                    boxHeight: GlobalVariable.ratioWidth(Get.context) * 32,
                    boxDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 6),
                        border: Border.all(
                            width: 1, color: Color(ListColor.colorGrey2))),
                    icon: Icon(Icons.keyboard_arrow_down_sharp,
                        size: GlobalVariable.ratioWidth(Get.context) * 16,
                        color: Color(ListColor.colorGrey4)),
                    value: _listVariable[index.toString()]
                        [_satuanDimensionKeyTemp],
                    hint: CustomText(
                        _listVariable[index.toString()][_satuanDimensionTemp] !=
                                ""
                            ? _listVariable[index.toString()]
                                [_satuanDimensionTemp]
                            : arrSatuanDimensi[0]['label'] ?? "",
                        color: Color(ListColor.colorLightGrey4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    items: [
                      for (int i = 0; i < arrSatuanDimensi.length; i++)
                        DropdownMenuItem(
                          child: CustomText(arrSatuanDimensi[i]['label'],
                              color: Color(ListColor.colorLightGrey4),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                          value: arrSatuanDimensi[i]['key'],
                        ),
                    ],
                    onChanged: (value) {
                      FocusManager.instance.primaryFocus.unfocus();
                      _listVariable[index.toString()][_satuanDimensionKeyTemp] =
                          value;
                      for (int i = 0; i < arrSatuanDimensi.length; i++) {
                        if (arrSatuanDimensi[i]['key'] == value) {
                          _listVariable[index.toString()]
                                  [_satuanDimensionTemp] =
                              arrSatuanDimensi[i]['label'];
                        }
                      }
                      _listVariable.refresh();
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget addTruck(int index) {
    List<Widget> badgeWrap = [];
    int lengthDataChoosen =
        (_listVariable[index.toString()][_truckIDTemp] as List).length;
    var dataIDTruck = _listVariable[index.toString()][_truckIDTemp] as List;
    var dataNamaTruck = _listVariable[index.toString()][_truckNameTemp] as List;
    for (int i = 0; i < (lengthDataChoosen > 5 ? 5 : lengthDataChoosen); i++) {
      badgeWrap.add(_getItemWrap(
          _listVariable[index.toString()][_truckIDTemp][i],
          _listVariable[index.toString()][_truckNameTemp][i],
          true, (choosen, key, value) {
        var dataIDTruck = _listVariable[index.toString()][_truckIDTemp] as List;
        var dataNamaTruck =
            _listVariable[index.toString()][_truckNameTemp] as List;
        if (!choosen) {
          dataIDTruck.remove(key);
          dataNamaTruck.remove(value);
        } else {
          dataIDTruck.add(key);
          dataNamaTruck.add(value);
        }
        _listVariable[index.toString()][_truckIDTemp] = dataIDTruck;
        _listVariable[index.toString()][_truckNameTemp] = dataNamaTruck;
        _listVariable.refresh();
      }));
    }

    int ctr = 0;
    while (lengthDataChoosen < 5) {
      if (ctr >= _listTruck.length) {
        lengthDataChoosen = 5;
      } else {
        if (!dataIDTruck.contains(_listTruck[ctr]['id'].toString())) {
          badgeWrap.add(_getItemWrap(
              _listTruck[ctr]['id'].toString(), _listTruck[ctr]['name'], false,
              (choosen, key, value) {
            var dataIDTruck =
                _listVariable[index.toString()][_truckIDTemp] as List;
            var dataNamaTruck =
                _listVariable[index.toString()][_truckNameTemp] as List;
            if (!choosen) {
              dataIDTruck.remove(key);
              dataNamaTruck.remove(value);
            } else {
              dataIDTruck.add(key);
              dataNamaTruck.add(value);
            }
            _listVariable[index.toString()][_truckIDTemp] = dataIDTruck;
            _listVariable[index.toString()][_truckNameTemp] = dataNamaTruck;
            _listVariable.refresh();
          }));
          lengthDataChoosen++;
        }
      }
      ctr++;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textTitle(listWidgetInFilter[index].label[0]),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 1,
                        // bottom: GlobalVariable.ratioWidth(Get.context) * 1,
                      ),
                      child: countBadge(
                          _listVariable[index.toString()][_truckIDTemp].length),
                    ),
                  ],
                )),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 10,
                          // right:
                          //     GlobalVariable.ratioWidth(Get.context) * 10,
                          top: GlobalVariable.ratioWidth(Get.context) * 1),
                      child: CustomText(
                        "GlobalFilterButtonShowAll".tr,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.color4),
                      ),
                    ),
                    onTap: () async {
                      Map<String, dynamic> mapData = Map<String, dynamic>.from(
                          _listVariable[index.toString()]);
                      var result =
                          await GetToPage.toNamed<ListTruckFilterArkController>(
                              Routes.LIST_TRUCK_FILTER_ARK,
                              arguments: [
                                _listTruck,
                                {
                                  "id": mapData[_truckIDTemp],
                                  "nama": mapData[_truckNameTemp],
                                },
                                listWidgetInFilter[index].label,
                              ],
                              preventDuplicates: false);
                      if (result != null) {
                        mapData[_truckIDTemp].clear();
                        mapData[_truckIDTemp].addAll(result['id']);
                        mapData[_truckNameTemp].clear();
                        mapData[_truckNameTemp].addAll(result['nama']);
                        _listVariable.refresh();
                      }
                    },
                  ),
                )
              ]),
          SizedBox(height: 18),
          Wrap(
            spacing: GlobalVariable.ratioWidth(Get.context) * 8,
            children: badgeWrap,
          )
        ],
      ),
    );
  }

  Widget addCarrier(int index) {
    List<Widget> badgeWrap = [];
    int lengthDataChoosen =
        (_listVariable[index.toString()][_carrierIDTemp] as List).length;
    var dataIDCarrier = _listVariable[index.toString()][_carrierIDTemp] as List;
    var dataNamaCarrier =
        _listVariable[index.toString()][_carrierNameTemp] as List;
    for (int i = 0; i < (lengthDataChoosen > 5 ? 5 : lengthDataChoosen); i++) {
      badgeWrap.add(_getItemWrap(
          _listVariable[index.toString()][_carrierIDTemp][i],
          _listVariable[index.toString()][_carrierNameTemp][i],
          true, (choosen, key, value) {
        var dataIDCarrier =
            _listVariable[index.toString()][_carrierIDTemp] as List;
        var dataNamaCarrier =
            _listVariable[index.toString()][_carrierNameTemp] as List;
        if (!choosen) {
          dataIDCarrier.remove(key);
          dataNamaCarrier.remove(value);
        } else {
          dataIDCarrier.add(key);
          dataNamaCarrier.add(value);
        }
        _listVariable[index.toString()][_carrierIDTemp] = dataIDCarrier;
        _listVariable[index.toString()][_carrierNameTemp] = dataNamaCarrier;
        _listVariable.refresh();
      }));
    }

    int ctr = 0;
    while (lengthDataChoosen < 5) {
      if (ctr >= _listCarrier.length) {
        lengthDataChoosen = 5;
      } else {
        if (!dataIDCarrier.contains(_listCarrier[ctr]['id'].toString())) {
          badgeWrap.add(_getItemWrap(_listCarrier[ctr]['id'].toString(),
              _listCarrier[ctr]['name'], false, (choosen, key, value) {
            var dataIDCarrier =
                _listVariable[index.toString()][_carrierIDTemp] as List;
            var dataNamaCarrier =
                _listVariable[index.toString()][_carrierNameTemp] as List;
            if (!choosen) {
              dataIDCarrier.remove(key);
              dataNamaCarrier.remove(value);
            } else {
              dataIDCarrier.add(key);
              dataNamaCarrier.add(value);
            }
            _listVariable[index.toString()][_carrierIDTemp] = dataIDCarrier;
            _listVariable[index.toString()][_carrierNameTemp] = dataNamaCarrier;
            _listVariable.refresh();
          }));
          lengthDataChoosen++;
        }
      }
      ctr++;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textTitle(listWidgetInFilter[index].label[0]),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 1,
                        // bottom: GlobalVariable.ratioWidth(Get.context) * 1,
                      ),
                      child: countBadge(_listVariable[index.toString()]
                              [_carrierIDTemp]
                          .length),
                    ),
                  ],
                )),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 10,
                          // right:
                          //     GlobalVariable.ratioWidth(Get.context) * 10,
                          top: GlobalVariable.ratioWidth(Get.context) * 1),
                      child: CustomText(
                        "GlobalFilterButtonShowAll".tr,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.color4),
                      ),
                    ),
                    onTap: () async {
                      Map<String, dynamic> mapData = Map<String, dynamic>.from(
                          _listVariable[index.toString()]);
                      var result = await GetToPage.toNamed<
                              ListCarrierFilterArkController>(
                          Routes.LIST_CARRIER_FILTER_ARK,
                          arguments: [
                            _listCarrier,
                            {
                              "id": mapData[_carrierIDTemp],
                              "nama": mapData[_carrierNameTemp],
                            },
                            listWidgetInFilter[index].label,
                          ],
                          preventDuplicates: false);
                      if (result != null) {
                        mapData[_carrierIDTemp].clear();
                        mapData[_carrierIDTemp].addAll(result['id']);
                        mapData[_carrierNameTemp].clear();
                        mapData[_carrierNameTemp].addAll(result['nama']);
                        _listVariable.refresh();
                      }
                    },
                  ),
                )
              ]),
          SizedBox(height: 18),
          Wrap(
            spacing: GlobalVariable.ratioWidth(Get.context) * 8,
            children: badgeWrap,
          )
        ],
      ),
    );
  }

  Widget addDestinasi(int index) {
    return _wrapItemWidget(listWidgetInFilter[index].label[0], index,
        seeAll: () async {
      Map<String, dynamic> mapData =
          Map<String, dynamic>.from(_listVariable[index.toString()]);
      // try {
      //   Get.delete<ListDestinasiFilterInfoPraTenderArkController>();
      //   Get.delete<ListCityFilterInfoPraTenderArkController>();
      //   Get.put<ListDestinasiFilterInfoPraTenderArkController>(
      //       ListDestinasiFilterInfoPraTenderArkController());
      //   Get.put<ListCityFilterInfoPraTenderArkController>(
      //       ListCityFilterInfoPraTenderArkController());
      // } catch (e) {
      //   print(e);
      // }
      var result = await GetToPage.toNamed<ListDestinasiFilterArkController>(
          Routes.LIST_DESTINASI_FILTER_ARK,
          arguments: [
            _listCity,
            _listVariable[index.toString()][_listChoosenTempKey],
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
        // mapData[_listChoosenTempKey].clear();
        // mapData[_listChoosenTempKey].addAll(result);
        // print(mapData[_listChoosenTempKey]);
        _listVariable[index.toString()][_listChoosenTempKey].clear();
        _listVariable[index.toString()][_listChoosenTempKey].addAll(result);
        _listVariable.refresh();
      }
    });
  }

  Widget addCheckbox(int index) {
    var dataValue = listWidgetInFilter[index].customValue;
    return Container(
      padding: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(Get.context) * 10,
        right: GlobalVariable.ratioWidth(Get.context) * 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 5),
            child: _textTitle(listWidgetInFilter[index].label[0]),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
          for (int i = 0; i < (dataValue.length); i++)
            GestureDetector(
              onTap: () {
                if ((_listVariable[index.toString()][_checkboxTempKey] as List)
                    .contains(dataValue[i].id)) {
                  (_listVariable[index.toString()][_checkboxTempKey] as List)
                      .remove(dataValue[i].id);
                } else {
                  (_listVariable[index.toString()][_checkboxTempKey] as List)
                      .add(dataValue[i].id);
                }
                _listVariable.refresh();
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => CheckBoxCustom(
                          size: 14,
                          paddingSize: 5,
                          shadowSize: 19,
                          isWithShadow: true,
                          borderColor: ListColor.colorBlue,
                          borderWidth: 1,
                          value: (_listVariable[index.toString()]
                                  [_checkboxTempKey] as List)
                              .contains(dataValue[i].id),
                          onChanged: (checked) {
                            if (checked) {
                              (_listVariable[index.toString()][_checkboxTempKey]
                                      as List)
                                  .add(dataValue[i].id);
                            } else {
                              (_listVariable[index.toString()][_checkboxTempKey]
                                      as List)
                                  .remove(dataValue[i].id);
                            }
                          },
                        )),
                    Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 8),
                    Expanded(
                      child: Container(
                        child: CustomText(
                          dataValue[i].value,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(ListColor.colorLightGrey14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget addCheckboxWithHide(int index) {
    var dataValue = listWidgetInFilter[index].customValue;
    bool hideTitle = listWidgetInFilter[index].hideTitle;
    return Container(
      padding: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(Get.context) * 10,
        right: GlobalVariable.ratioWidth(Get.context) * 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hideTitle
              ? Container()
              : Container(
                  margin: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 5),
                  child: _textTitle(listWidgetInFilter[index].label[0]),
                ),
          SizedBox(
            height: hideTitle ? 0 : GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          for (int i = 0; i < (dataValue.length); i++)
            Container(
              margin: EdgeInsets.only(
                  bottom: GlobalVariable.ratioWidth(Get.context) * 12),
              child: GestureDetector(
                onTap: () {
                  if ((_listVariable[index.toString()][_checkboxHideTempKey]
                          as List)
                      .contains(dataValue[i].id)) {
                    (_listVariable[index.toString()][_checkboxHideTempKey]
                            as List)
                        .remove(dataValue[i].id);
                    if (dataValue[i].canHide) {
                      List<dynamic> datahide =
                          _listVariable[index.toString()][_hideTemp];
                      for (int j = 0; j < datahide.length; j++) {
                        if (datahide[j]['checkboxIndex'] == i) {
                          datahide[j]['hide'] = true;
                        }
                      }
                      _listVariable[index.toString()][_hideTemp] = datahide;
                    }
                  } else {
                    (_listVariable[index.toString()][_checkboxHideTempKey]
                            as List)
                        .add(dataValue[i].id);
                    if (dataValue[i].canHide) {
                      List<dynamic> datahide =
                          _listVariable[index.toString()][_hideTemp];
                      for (int j = 0; j < datahide.length; j++) {
                        if (datahide[j]['checkboxIndex'] == i) {
                          datahide[j]['hide'] = false;
                        }
                      }
                      _listVariable[index.toString()][_hideTemp] = datahide;
                    }
                  }
                  _listVariable.refresh();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => CheckBoxCustom(
                          size: 14,
                          paddingSize: 5,
                          shadowSize: 19,
                          isWithShadow: true,
                          borderColor: ListColor.colorBlue,
                          borderWidth: 1,
                          value: (_listVariable[index.toString()]
                                  [_checkboxHideTempKey] as List)
                              .contains(dataValue[i].id),
                          onChanged: (checked) {
                            if (checked) {
                              (_listVariable[index.toString()]
                                      [_checkboxHideTempKey] as List)
                                  .add(dataValue[i].id);
                              if (dataValue[i].canHide) {
                                List<dynamic> datahide =
                                    _listVariable[index.toString()][_hideTemp];
                                for (int j = 0; j < datahide.length; j++) {
                                  if (datahide[j]['checkboxIndex'] == i) {
                                    datahide[j]['hide'] = false;
                                  }
                                }
                                _listVariable[index.toString()][_hideTemp] =
                                    datahide;
                              }
                            } else {
                              (_listVariable[index.toString()]
                                      [_checkboxHideTempKey] as List)
                                  .remove(dataValue[i].id);
                              if (dataValue[i].canHide) {
                                List<dynamic> datahide =
                                    _listVariable[index.toString()][_hideTemp];
                                for (int j = 0; j < datahide.length; j++) {
                                  if (datahide[j]['checkboxIndex'] == i) {
                                    datahide[j]['hide'] = true;
                                  }
                                }
                                _listVariable[index.toString()][_hideTemp] =
                                    datahide;
                              }
                            }
                            print("datahide");
                            print(_listVariable[index.toString()][_hideTemp]);
                            _listVariable.refresh();
                          },
                        )),
                    Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 8),
                    Expanded(
                      child: Container(
                        child: CustomText(
                          dataValue[i].value,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(ListColor.colorLightGrey14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget addSatuan(int index) {
    var dataValue = listWidgetInFilter[index].customValue;
    return Container(
      padding: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(Get.context) * 10,
        right: GlobalVariable.ratioWidth(Get.context) * 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 5,
            ),
            child: _textTitle(listWidgetInFilter[index].label[0]),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
          for (int i = 0; i < (dataValue.length); i++)
            Container(
              margin: EdgeInsets.only(
                  bottom: GlobalVariable.ratioWidth(Get.context) * 12),
              child: GestureDetector(
                onTap: () {
                  if ((_listVariable[index.toString()][_satuanTempKey] as List)
                      .contains(dataValue[i].id)) {
                    (_listVariable[index.toString()][_satuanTempKey] as List)
                        .remove(dataValue[i].id);
                  } else {
                    (_listVariable[index.toString()][_satuanTempKey] as List)
                        .add(dataValue[i].id);
                  }
                  // print("check" +
                  //     (_listVariable[index.toString()][_satuanTempKey] as List)
                  //         .contains(dataValue[i].id)
                  //         .toString());
                  setMaxSatuan(index);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => CheckBoxCustom(
                          size: 14,
                          paddingSize: 5,
                          shadowSize: 19,
                          isWithShadow: true,
                          borderColor: ListColor.colorBlue,
                          borderWidth: 1,
                          value: (_listVariable[index.toString()]
                                  [_satuanTempKey] as List)
                              .contains(dataValue[i].id),
                          onChanged: (checked) {
                            if (checked) {
                              (_listVariable[index.toString()][_satuanTempKey]
                                      as List)
                                  .add(dataValue[i].id);
                            } else {
                              (_listVariable[index.toString()][_satuanTempKey]
                                      as List)
                                  .remove(dataValue[i].id);
                            }
                            setMaxSatuan(index);
                          },
                        )),
                    Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 8),
                    Expanded(
                      child: Container(
                        child: CustomText(
                          dataValue[i].value,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(ListColor.colorLightGrey14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  setMaxSatuan(index) {
    // var dataValue = listWidgetInFilter[index].customValue;
    List<SatuanFilterModel> dataValue = listWidgetInFilter[index]
        .customValue
        .map((data) => data as SatuanFilterModel)
        .toList();
    double max = 0;
    double min = 0;
    bool isDecimal = false;
    var choose = _listVariable[index.toString()][_satuanTempKey];
    if ((choose as List).contains("Volume") ||
        (choose as List).contains("Berat")) {
      isDecimal = true;
    }
    for (int i = 0; i < dataValue.length; i++) {
      for (int j = 0; j < choose.length; j++) {
        if (dataValue[i].id == choose[j]) {
          if (max < dataValue[i].max) {
            max = dataValue[i].max;
          }
        }
      }
    }
    // print("isi datavalue");
    // print(max);
    // print("min " + min.toString());
    // print("max " + max.toString());
    _setRangeValueUnit(index + 1, min, max, index + 1,
        isUpdateTextEditingController: false, isUpdateRangeValues: false);
    _listVariable[index.toString()]['min'] = min;
    _listVariable[index.toString()]['max'] = max;
    _listVariable[index.toString()]['enable'] =
        choose.length > 0 && max > 0 ? true : false;
    _listVariable[index.toString()]['isDecimal'] = isDecimal;
    _listVariable[(index + 1).toString()][_rangeValuesTempKey] =
        RangeValues(min, max);
    _listVariable[(index + 1).toString()][_endUnitRangeTextEditingControllerKey]
            .text =
        GlobalVariable.formatCurrencyDecimal(max.round().toInt().toString());
    _listVariable[(index + 1).toString()]
                [_startUnitRangeTextEditingControllerKey]
            .text =
        GlobalVariable.formatCurrencyDecimal(min.round().toInt().toString());
    _listVariable.refresh();
    print(_listVariable[index.toString()]);
  }

  Widget addUnitSatuan(int index) {
    var dataValue = listWidgetInFilter[index].customValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
          // child: _textTitle(listWidgetInFilter[index].label[0]),
          child: CustomText(
            listWidgetInFilter[index].label[0],
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _listVariable[(index - 1).toString()]['enable']
                ? Colors.black
                : Color(ListColor.colorLightGrey2),
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
                      width: MediaQuery.of(Get.context).size.width -
                          (GlobalVariable.ratioWidth(Get.context) * 30),
                      color: Color(ListColor.colorLightGrey10)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            GlobalVariable.ratioWidth(Get.context) * 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: _textFieldUnitSatuanWidget(
                            (value) {
                              String isi = value.replaceAll('.', '');
                              _setRangeValueUnit(
                                  index,
                                  double.parse(isi),
                                  _listVariable[index.toString()]
                                          [_rangeValuesTempKey]
                                      .end,
                                  index,
                                  isUpdateTextEditingController: false);
                            },
                            index,
                            _startUnitRangeTextEditingControllerKey,
                            _listVariable[(index - 1).toString()]['max'],
                            _listVariable[(index - 1).toString()]['enable'],
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 92,
                        ),
                        Expanded(
                          child: _textFieldUnitSatuanWidget(
                            (value) {
                              String isi = value.replaceAll('.', '');
                              _setRangeValueUnit(
                                  index,
                                  _listVariable[index.toString()]
                                          [_rangeValuesTempKey]
                                      .start,
                                  double.parse(isi),
                                  index,
                                  isUpdateTextEditingController: false);
                            },
                            index,
                            _endUnitRangeTextEditingControllerKey,
                            _listVariable[(index - 1).toString()]['max'],
                            _listVariable[(index - 1).toString()]['enable'],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _listVariable[index.toString()][_errorMessageUnitKey] != ""
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 15),
                          child: CustomText(
                              _listVariable[index.toString()]
                                  [_errorMessageUnitKey],
                              color: Color(ListColor.colorRed),
                              fontSize: 12),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 2),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(() {
                      return SliderTheme(
                          data: SliderTheme.of(Get.context).copyWith(
                            trackHeight:
                                GlobalVariable.ratioWidth(Get.context) * 2,
                            activeTrackColor:
                                (_listVariable[(index - 1).toString()]
                                            ['enable'] ??
                                        false)
                                    ? Color(ListColor.colorBlue)
                                    : Color(ListColor.colorLightGrey12),
                            inactiveTrackColor:
                                (_listVariable[(index - 1).toString()]
                                            ['enable'] ??
                                        false)
                                    ? Color(ListColor.colorLightGrey4)
                                    : Color(ListColor.colorLightGrey12),
                            thumbColor: Color(ListColor.colorWhite),
                            // thumbColor: Color(ListColor.colorLightGrey7),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 15.0,
                            ),
                            // overlayColor: Color(ListColor.colorLightGrey7),
                            // thumbShape: CircleThumbShape(thumbRadius: 15),
                          ),
                          child: IgnorePointer(
                              ignoring: !(_listVariable[(index - 1).toString()]
                                      ['enable'] ??
                                  false),
                              child: RangeSlider(
                                  min: 0.0,
                                  max: _listVariable[(index - 1).toString()]
                                          ['max'] ??
                                      0,
                                  values: _listVariable[index.toString()]
                                      [_rangeValuesTempKey],
                                  onChanged: (values) {
                                    _setRangeValueUnit(
                                        index, values.start, values.end, index);
                                  })));
                    })
                  ],
                ),
              ),
            ]),
      ],
    );
  }

  Widget _textFieldUnitSatuanWidget(
      void Function(String) onChangeText,
      int indexListVariable,
      String keyTextEditingController,
      double max,
      bool enable) {
    return CustomTextFormField(
        textInputAction: TextInputAction.done,
        enabled: enable,
        controller: _listVariable[indexListVariable.toString()]
            [keyTextEditingController],
        context: Get.context,
        textSize: 12,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: indexListVariable.toString() ==
                    "2" // KHUSUS JUMLAH YANG MENGACU KE SATUAN TENDER
                ? _listVariable["1"][_satuanTempKey].length > 0
                    ? Color(ListColor.colorLightGrey4)
                    : Color(ListColor.colorLightGrey2)
                : Color(ListColor.colorLightGrey4)),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 7,
            vertical: GlobalVariable.ratioWidth(Get.context) * 9),
        newInputDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
              borderSide: BorderSide(color: Color(ListColor.colorGrey2))),
          // fillColor: indexListVariable.toString() ==
          //         "2" // KHUSUS JUMLAH YANG MENGACU KE SATUAN TENDER
          //     ? _listVariable["1"][_satuanTempKey].length > 0
          //         ? Colors.white
          //         : Color(ListColor.colorLightGrey12)
          // : Colors.white,
          fillColor: enable ? Colors.white : Color(ListColor.colorLightGrey12),
          isDense: true,
          isCollapsed: true,
          filled: true,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          // FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
          // FilteringTextInputFormatter.allow(RegExp(r'(^[0-9]*\,?[0-9]{0,2})')),
          DecimalInputFormatter(
            digit: 99,
            digitAfterComma: 0,
            controller: _listVariable[indexListVariable.toString()]
                [keyTextEditingController],
          ),
        ],
        onChanged: (value) {
          String isi = value.replaceAll('.', '').replaceAll(',', '.');
          if (double.parse(isi) > max) {
            isi = max.toString();
            _listVariable[indexListVariable.toString()]
                    [keyTextEditingController]
                .text = GlobalVariable.formatCurrencyDecimal(isi);
          }
          // OnChangeTextFieldNumber.checkNumber(
          //     () => _listVariable[indexListVariable.toString()]
          //         [keyTextEditingController],
          //     value.replaceAll(',', '').replaceAll('.', ''));

          onChangeText(_listVariable[indexListVariable.toString()]
                  [keyTextEditingController]
              .text);
        },
        maxLines: 1,
        keyboardType: TextInputType.number);
  }

  Widget addMuatan(int index) {
    var searchControl = TextEditingController(text: '').obs;
    var dataValue = listWidgetInFilter[index].customValue;
    double paddingLeft = listWidgetInFilter[index].paddingLeft;
    bool canBeHide = listWidgetInFilter[index].canBeHide;
    bool hideTitle = listWidgetInFilter[index].hideTitle;
    List<Widget> listcheckbox = <Widget>[
      //title
      hideTitle
          ? Container()
          : Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 5,
              ),
              child: _textTitle(
                listWidgetInFilter[index].label[0],
              ),
            ),
      SizedBox(
        height: hideTitle ? 0 : GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      //search
      Padding(
        padding: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    child: Obx(
                      () => CustomTextField(
                        readOnly: true,
                        onTap: () async {
                          Map<String, dynamic> mapData =
                              Map<String, dynamic>.from(
                                  _listVariable[index.toString()]);
                          var result = await GetToPage.toNamed<
                                  ListMuatanFilterController>(
                              Routes.LIST_MUATAN_FILTER,
                              arguments: [
                                dataValue,
                                mapData[_muatanTempKey],
                                listWidgetInFilter[index].label,
                              ],
                              preventDuplicates: false);
                          if (result != null) {
                            mapData[_muatanTempKey].clear();
                            mapData[_muatanTempKey].addAll(result);
                            _listVariable.refresh();
                          }
                          print(result);
                          searchControl.value.clear();
                        },
                        controller: searchControl.value,
                        textInputAction: TextInputAction.search,
                        context: Get.context,
                        textSize: 14,
                        newContentPadding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 38,
                            right: GlobalVariable.ratioWidth(Get.context) * 10,
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                        // newContentPadding: EdgeInsets.symmetric(
                        //     horizontal: 42,
                        //     vertical:
                        //         GlobalVariable.ratioWidth(context) * 6),
                        newInputDecoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintText: listWidgetInFilter[index].label[2],
                          fillColor: Color(ListColor.colorLightGrey20),
                          filled: true,
                          hintStyle: TextStyle(
                              color: Color(ListColor.colorLightGrey2),
                              fontSize:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 12,
                        right: GlobalVariable.ratioWidth(Get.context) * 2),
                    child: SvgPicture.asset(
                      GlobalVariable.imagePath + "ic_search_blue.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => searchControl.value.text.isEmpty
                          ? SizedBox.shrink()
                          : Container(
                              margin: EdgeInsets.only(right: 7),
                              child: GestureDetector(
                                onTap: () {
                                  searchControl.refresh();
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  size: GlobalVariable.ratioWidth(Get.context) *
                                      24,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
    ];
    var dataTemp = (_listVariable[index.toString()][_muatanTempKey] as List);
    if (dataTemp.length > 0) {
      listcheckbox.add(SizedBox(
        height: GlobalVariable.ratioWidth(Get.context) * 12,
      ));

      var badgeList = <Widget>[].obs;
      for (int i = 0; i < (dataTemp.length > 5 ? 5 : dataTemp.length); i++) {
        String nama = dataTemp[i];
        badgeList.value.add(
          badgeWithCloseIcon(dataTemp[i], () {
            dataTemp.remove(nama);
            _listVariable.refresh();
          }),
        );
      }
      if (dataTemp.length > 5) {
        badgeList.value.add(GestureDetector(
            onTap: () async {
              Map<String, dynamic> mapData =
                  Map<String, dynamic>.from(_listVariable[index.toString()]);
              var result = await GetToPage.toNamed<ListMuatanFilterController>(
                  Routes.LIST_MUATAN_FILTER,
                  arguments: [
                    dataValue,
                    mapData[_muatanTempKey],
                    listWidgetInFilter[index].label
                  ],
                  preventDuplicates: false);
              if (result != null) {
                mapData[_muatanTempKey].clear();
                mapData[_muatanTempKey].addAll(result);
                _listVariable.refresh();
              }
              print(result);
            },
            child: indicatorBadge(dataTemp.length > 5
                ? "+" + (dataTemp.length - 5).toString()
                : dataTemp.length.toString())));
      }
      listcheckbox.add(
        Container(
          margin: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * 4,
          ),
          child: Wrap(
            children: badgeList.value,
          ),
        ),
      );
    }

    //checkbox
    var choosenList = (_listVariable[index.toString()][_muatanTempKey] as List);
    int jumlahCheck = choosenList.length > 3 ? 3 : choosenList.length;

    for (int i = 0; i < jumlahCheck; i++) {
      Widget checkbox = GestureDetector(
        onTap: () {
          (_listVariable[index.toString()][_muatanTempKey] as List)
              .remove(choosenList[i]);
          _listVariable.refresh();
          // if ((_listVariable[index.toString()][_muatanTempKey] as List)
          //     .contains(dataValue[i]['nama'])) {
          //   _onChooseCheckboxMuatan(
          //       index, dataValue[i], false, _muatanTempKey);
          // } else {
          //   _onChooseCheckboxMuatan(
          //       index, dataValue[i], true, _muatanTempKey);
          // }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CheckBoxCustom(
                size: 14,
                paddingSize: 5,
                shadowSize: 19,
                isWithShadow: true,
                borderColor: ListColor.colorBlue,
                borderWidth: 1,
                value: true,
                onChanged: (checked) {
                  // _onChooseCheckboxMuatan(
                  //     index, dataValue[i], checked, _muatanTempKey);
                  (_listVariable[index.toString()][_muatanTempKey] as List)
                      .remove(choosenList[i]);
                  _listVariable.refresh();
                },
              ),
              Container(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Expanded(
                child: Container(
                  child: CustomText(
                    choosenList[i],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      listcheckbox.add(checkbox);
    }

    for (int i = 0; i < dataValue.length; i++) {
      Widget checkbox = GestureDetector(
        onTap: () {
          if ((_listVariable[index.toString()][_muatanTempKey] as List)
              .contains(dataValue[i]['nama'])) {
            _onChooseCheckboxMuatan(index, dataValue[i], false, _muatanTempKey);
          } else {
            _onChooseCheckboxMuatan(index, dataValue[i], true, _muatanTempKey);
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => CheckBoxCustom(
                    size: 14,
                    paddingSize: 5,
                    shadowSize: 19,
                    isWithShadow: true,
                    borderColor: ListColor.colorBlue,
                    borderWidth: 1,
                    value: (_listVariable[index.toString()][_muatanTempKey]
                            as List)
                        .contains(dataValue[i]['nama']),
                    onChanged: (checked) {
                      _onChooseCheckboxMuatan(
                          index, dataValue[i], checked, _muatanTempKey);
                    },
                  )),
              Container(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Expanded(
                child: Container(
                  child: CustomText(
                    dataValue[i]['nama'],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      if ((_listVariable[index.toString()][_muatanTempKey] as List)
                  .contains(dataValue[i]['nama']) ==
              false &&
          jumlahCheck < 3) {
        listcheckbox.add(checkbox);
        jumlahCheck++;
      }
    }

    listcheckbox.add(Container(
      height: GlobalVariable.ratioWidth(Get.context) *
          listWidgetInFilter[index].heightPaddingBottomWhenHidden,
    ));

    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 10,
          right: GlobalVariable.ratioWidth(Get.context) * 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listcheckbox,
        ),
      ),
    );
  }

  Widget addDiumumkan(int index) {
    var searchControl = TextEditingController(text: '').obs;
    var dataValue = listWidgetInFilter[index].customValue;
    double paddingLeft = listWidgetInFilter[index].paddingLeft;
    bool canBeHide = listWidgetInFilter[index].canBeHide;
    bool hideTitle = listWidgetInFilter[index].hideTitle;
    List<Widget> listcheckbox = <Widget>[
      //title
      hideTitle
          ? Container()
          : Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 5,
              ),
              child: _textTitle(
                listWidgetInFilter[index].label[0],
              ),
            ),
      SizedBox(
        height: hideTitle ? 0 : GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      //search
      Padding(
        padding: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    child: Obx(
                      () => CustomTextField(
                        readOnly: true,
                        onTap: () async {
                          Map<String, dynamic> mapData =
                              Map<String, dynamic>.from(
                                  _listVariable[index.toString()]);
                          print(dataValue);
                          var result = await GetToPage.toNamed<
                                  ListDiumumkanKepadaFilterController>(
                              Routes.LIST_DIUMUMKAN_KEPADA_FILTER,
                              arguments: [
                                dataValue,
                                mapData[_diumumkanTempKey],
                                listWidgetInFilter[index].label
                              ],
                              preventDuplicates: false);
                          if (result != null) {
                            mapData[_diumumkanTempKey].clear();
                            mapData[_diumumkanTempKey].addAll(result);
                            _listVariable.refresh();
                          }
                          print(result);
                          searchControl.value.clear();
                        },
                        controller: searchControl.value,
                        textInputAction: TextInputAction.search,
                        context: Get.context,
                        textSize: 14,
                        newContentPadding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 38,
                            right: GlobalVariable.ratioWidth(Get.context) * 10,
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                        // newContentPadding: EdgeInsets.symmetric(
                        //     horizontal: 42,
                        //     vertical:
                        //         GlobalVariable.ratioWidth(context) * 6),
                        newInputDecoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintText: listWidgetInFilter[index].label[2],
                          fillColor: Color(ListColor.colorLightGrey20),
                          filled: true,
                          hintStyle: TextStyle(
                              color: Color(ListColor.colorLightGrey2),
                              fontSize:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 12,
                      right: GlobalVariable.ratioWidth(Get.context) * 2,
                    ),
                    child: SvgPicture.asset(
                      GlobalVariable.imagePath + "ic_search_blue.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => searchControl.value.text.isEmpty
                          ? SizedBox.shrink()
                          : Container(
                              margin: EdgeInsets.only(right: 7),
                              child: GestureDetector(
                                onTap: () {
                                  searchControl.refresh();
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  size: GlobalVariable.ratioWidth(Get.context) *
                                      24,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    var dataTemp = (_listVariable[index.toString()][_diumumkanTempKey] as List);
    if (dataTemp.length > 0) {
      listcheckbox.add(SizedBox(
        height: GlobalVariable.ratioWidth(Get.context) * 12,
      ));

      var badgeList = <Widget>[].obs;
      for (int i = 0; i < (dataTemp.length > 5 ? 5 : dataTemp.length); i++) {
        String nama = dataTemp[i];
        badgeList.value.add(
          badgeWithCloseIcon(dataTemp[i], () {
            dataTemp.remove(nama);
            _listVariable.refresh();
          }),
        );
      }
      if (dataTemp.length > 5) {
        badgeList.value.add(GestureDetector(
            onTap: () async {
              Map<String, dynamic> mapData =
                  Map<String, dynamic>.from(_listVariable[index.toString()]);
              var result = await GetToPage.toNamed<ListMuatanFilterController>(
                  Routes.LIST_DIUMUMKAN_KEPADA_FILTER,
                  arguments: [
                    dataValue,
                    mapData[_diumumkanTempKey],
                    listWidgetInFilter[index].label
                  ],
                  preventDuplicates: false);
              if (result != null) {
                mapData[_diumumkanTempKey].clear();
                mapData[_diumumkanTempKey].addAll(result);
                _listVariable.refresh();
              }
              print(result);
            },
            child: indicatorBadge(dataTemp.length > 5
                ? "+" + (dataTemp.length - 5).toString()
                : dataTemp.length.toString())));
      }
      listcheckbox.add(
        Container(
          margin: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * 4,
          ),
          child: Wrap(
            children: badgeList.value,
          ),
        ),
      );
    }
    //checkbox
    var choosenList =
        (_listVariable[index.toString()][_diumumkanTempKey] as List);
    int jumlahCheck = choosenList.length > 3 ? 3 : choosenList.length;
    for (int i = 0; i < jumlahCheck; i++) {
      Widget checkbox = Container(
        margin: EdgeInsets.only(
          top: GlobalVariable.ratioWidth(Get.context) * (i == 0 ? 8 : 12),
        ),
        child: GestureDetector(
          onTap: () {
            (_listVariable[index.toString()][_diumumkanTempKey] as List)
                .remove(choosenList[i]);
            _listVariable.refresh();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CheckBoxCustom(
                size: 14,
                paddingSize: 5,
                shadowSize: 19,
                isWithShadow: true,
                borderColor: ListColor.colorBlue,
                borderWidth: 1,
                value: true,
                onChanged: (checked) {
                  (_listVariable[index.toString()][_diumumkanTempKey] as List)
                      .remove(choosenList[i]);
                  _listVariable.refresh();
                },
              ),
              Container(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Expanded(
                child: Container(
                  child: CustomText(
                    choosenList[i],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      listcheckbox.add(checkbox);
    }

    // int i = 0;
    // while (jumlahCheck < 3) {
    //   if ((_listVariable[index.toString()][_diumumkanTempKey] as List)
    //           .contains(dataValue[i]['nama']) ==
    //       false) {
    //     Widget checkbox = Container(
    //       margin: EdgeInsets.only(
    //           top: GlobalVariable.ratioWidth(Get.context) * (i == 0 ? 8 : 12)),
    //       child: GestureDetector(
    //         onTap: () {
    //           // _onChooseCheckboxMuatan(
    //           //     index, dataValue[i], false, _diumumkanTempKey);
    //           (_listVariable[index.toString()][_diumumkanTempKey] as List)
    //               .add(dataValue[i]['nama']);
    //           _listVariable.refresh();
    //           // if ((_listVariable[index.toString()][_diumumkanTempKey] as List)
    //           //     .contains(dataValue[i]['nama'])) {
    //           //   _onChooseCheckboxMuatan(
    //           //       index, dataValue[i], false, _diumumkanTempKey);
    //           // } else {
    //           //   _onChooseCheckboxMuatan(
    //           //       index, dataValue[i], true, _diumumkanTempKey);
    //           // }
    //         },
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             CheckBoxCustom(
    //               size: 14,
    //               paddingSize: 5,
    //               shadowSize: 19,
    //               isWithShadow: true,
    //               borderColor: ListColor.colorBlue,
    //               borderWidth: 1,
    //               value: false,
    //               onChanged: (checked) {
    //                 (_listVariable[index.toString()][_diumumkanTempKey] as List)
    //                     .add(dataValue[i]['nama']);
    //                 _listVariable.refresh();
    //               },
    //             ),
    //             Container(width: GlobalVariable.ratioWidth(Get.context) * 9),
    //             Expanded(
    //               child: Container(
    //                 child: CustomText(
    //                   dataValue[i]['nama'],
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 14,
    //                   color: Color(ListColor.colorLightGrey14),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //     listcheckbox.add(checkbox);
    //     jumlahCheck++;
    //   }
    //   i++;
    // }

    for (int i = 0; i < dataValue.length; i++) {
      Widget checkbox = Container(
        margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(Get.context) * (i == 0 ? 8 : 12)),
        child: GestureDetector(
          onTap: () {
            if ((_listVariable[index.toString()][_diumumkanTempKey] as List)
                .contains(dataValue[i]['nama'])) {
              _onChooseCheckboxMuatan(
                  index, dataValue[i], false, _diumumkanTempKey);
            } else {
              _onChooseCheckboxMuatan(
                  index, dataValue[i], true, _diumumkanTempKey);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => CheckBoxCustom(
                    size: 14,
                    paddingSize: 5,
                    shadowSize: 19,
                    isWithShadow: true,
                    borderColor: ListColor.colorBlue,
                    borderWidth: 1,
                    value: (_listVariable[index.toString()][_diumumkanTempKey]
                            as List)
                        .contains(dataValue[i]['nama']),
                    onChanged: (checked) {
                      _onChooseCheckboxMuatan(
                          index, dataValue[i], checked, _diumumkanTempKey);
                    },
                  )),
              Container(width: GlobalVariable.ratioWidth(Get.context) * 9),
              Expanded(
                child: Container(
                  child: CustomText(
                    dataValue[i]['nama'],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(ListColor.colorLightGrey14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      if ((_listVariable[index.toString()][_diumumkanTempKey] as List)
                  .contains(dataValue[i]['nama']) ==
              false &&
          jumlahCheck < 3) {
        listcheckbox.add(checkbox);
        jumlahCheck++;
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 10,
          right: GlobalVariable.ratioWidth(Get.context) * 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listcheckbox,
        ),
      ),
    );
  }

  void _onChooseCheckboxMuatan(
      int indexListVariable, var data, bool isChoosen, var tempKey) {
    if (!isChoosen) {
      (_listVariable[indexListVariable.toString()][tempKey] as List)
          .remove(data['nama']);
    } else {
      (_listVariable[indexListVariable.toString()][tempKey] as List)
          .add(data['nama']);
    }
    _listVariable.refresh();
  }

  Widget indicatorBadge(String isi) {
    // return Container(
    //   height: GlobalVariable.ratioWidth(Get.context) * 23,
    //   decoration: BoxDecoration(
    //       color: Color(ListColor.colorBlue),
    //       borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
    //       border: Border.all(
    //         width: 1,
    //         color: Color(ListColor.colorBlue),
    //       )),
    //   padding: EdgeInsets.fromLTRB(
    //     GlobalVariable.ratioWidth(Get.context) * 8,
    //     GlobalVariable.ratioWidth(Get.context) * 0.5,
    //     GlobalVariable.ratioWidth(Get.context) * 8,
    //     GlobalVariable.ratioWidth(Get.context) * 2,
    //   ),
    //   margin: EdgeInsets.only(
    //     right: GlobalVariable.ratioWidth(Get.context) * 4,
    //     bottom: GlobalVariable.ratioWidth(Get.context) * 8,
    //   ),
    //   child: CustomText(
    //     isi,
    //     color: Color(ListColor.colorWhite),
    //     fontSize: 14,
    //     fontWeight: FontWeight.w500,
    //   ),
    // );
    double borderRadius = 20;
    return Container(
      margin: EdgeInsets.only(
        bottom: GlobalVariable.ratioWidth(Get.context) * 8,
        right: GlobalVariable.ratioWidth(Get.context) * 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(
          width: 1,
          color: Color(ListColor.color4),
        ),
        color: Color(ListColor.colorBlue),
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          constraints: BoxConstraints(maxWidth: 150),
          child: CustomText(
            isi.toString().replaceAll("", "\u{200B}"),
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget badgeWithCloseIcon(var nama, Function closeFunction) {
    // return Container(
    //   // height: GlobalVariable.ratioWidth(Get.context) * 23,
    //   height: 23,
    //   constraints: BoxConstraints(
    //     minWidth: 0,
    //     maxWidth: GlobalVariable.ratioWidth(Get.context) * 190,
    //   ),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.all(
    //           Radius.circular(GlobalVariable.ratioWidth(Get.context) * 17)),
    //       border: Border.all(
    //         width: 1,
    //         color: Color(ListColor.colorBlue),
    //       )),
    //   // padding: EdgeInsets.only(
    //   //   left: GlobalVariable.ratioWidth(Get.context) * 8,
    //   //   top: GlobalVariable.ratioWidth(Get.context) * 2,
    //   //   right: GlobalVariable.ratioWidth(Get.context) * 8,
    //   //   bottom: GlobalVariable.ratioWidth(Get.context) * 2,
    //   // ),
    //   padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
    //   margin: EdgeInsets.only(
    //     right: GlobalVariable.ratioWidth(Get.context) * 4,
    //     bottom: GlobalVariable.ratioWidth(Get.context) * 8,
    //   ),
    //   child: Wrap(
    //     children: [
    //       Container(
    //         constraints: BoxConstraints(
    //             maxWidth: GlobalVariable.ratioWidth(Get.context) * 150),
    //         child: CustomText(
    //           nama.toString(),
    //           color: Color(ListColor.colorBlue),
    //           fontSize: 14,
    //           fontWeight: FontWeight.w500,
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //       ),
    //       SizedBox(
    //         width: GlobalVariable.ratioWidth(Get.context) * 7,
    //       ),
    //       GestureDetector(
    //         onTap: () async {
    //           closeFunction();
    //         },
    //         child: Padding(
    //           padding: EdgeInsets.only(
    //             // top: GlobalVariable.ratioWidth(Get.context) * 5,
    //             top: 3,
    //           ),
    //           child: SvgPicture.asset(GlobalVariable.imagePath+'ic_close.svg',
    //               width: 11, height: 11, color: Colors.black),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    double borderRadius = 20;
    return Container(
      margin: EdgeInsets.only(
        bottom: GlobalVariable.ratioWidth(Get.context) * 8,
        right: GlobalVariable.ratioWidth(Get.context) * 4,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
            width: 1,
            color: Color(ListColor.color4),
          ),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            closeFunction();
          },
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.only(left: 10, right: 7, top: 5, bottom: 5),
                constraints: BoxConstraints(maxWidth: 150),
                child: CustomText(
                  nama.toString().replaceAll("", "\u{200B}"),
                  color: Color(ListColor.color4),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     // top: GlobalVariable.ratioWidth(Get.context) * 5,
              //     top: 8,
              //     right: 10,
              //   ),
              //   child: SvgPicture.asset(GlobalVariable.imagePath+'ic_close.svg',
              //       width: 11, height: 11, color: Colors.black),
              // ),
              Container(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: SvgPicture.asset(
                    GlobalVariable.imagePath + 'ic_close.svg',
                    width: 11,
                    height: 11,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addWidgetLocationWrapToContent(
      int index, List<Widget> listWidgetContent) {
    _addWidgetCityToContent(
        listWidgetContent,
        _wrapLocationItemWidget(listWidgetInFilter[index].label[0], index,
            seeAll: () async {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(_listVariable[index.toString()]);
          var result = await GetToPage.toNamed<ListCityFilterArkController>(
              Routes.LIST_LOCATION_FILTER_ARK,
              arguments: [
                listWidgetInFilter[index].customValue[0],
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
            print(mapData[_listChoosenTempKey]);
            // _listVariable[index.toString()][_listChoosenTempKey].clear();
            // _listVariable[index.toString()][_listChoosenTempKey].addAll(result);
            _listVariable.refresh();
          }
        }));
  }

  void _addWidgetCityWrapToContent(int index, List<Widget> listWidgetContent) {
    _addWidgetCityToContent(
        listWidgetContent,
        _wrapItemWidget(listWidgetInFilter[index].label[0], index,
            seeAll: () async {
          Map<String, dynamic> mapData =
              Map<String, dynamic>.from(_listVariable[index.toString()]);
          var result = await GetToPage.toNamed<ListCityFilterArkController>(
              Routes.LIST_CITY_FILTER_ARK,
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
            print(mapData[_listChoosenTempKey]);
            // _listVariable[index.toString()][_listChoosenTempKey].clear();
            // _listVariable[index.toString()][_listChoosenTempKey].addAll(result);
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

  // void _addWidgetTruckWrapToContent(int index, List<Widget> listWidgetContent) {
  //   _addWidgetToContent(
  //       listWidgetContent,
  //       _wrapItemWidget(listWidgetInFilter[index].label[0], index,
  //           seeAll: () async {
  //         Map<String, dynamic> mapData =
  //             Map<String, dynamic>.from(_listVariable[index.toString()]);
  //         var result =
  //             await GetToPage.toNamed<ListTruckCarrierFilterController>(
  //                 Routes.LIST_TRUCK_CARRIER_FILTER,
  //                 arguments: [
  //                   List.from(_listTruckModel),
  //                   mapData[_listChoosenTempKey],
  //                   "Jenis Truck".tr,
  //                 ],
  //                 preventDuplicates: false);
  //         // var result = await Get.toNamed(Routes.LIST_TRUCK_CARRIER_FILTER,
  //         //     arguments: [
  //         //       List.from(_listTruckModel),
  //         //       mapData[_listChoosenTempKey],
  //         //       "Jenis Truck".tr,
  //         //     ],
  //         //     preventDuplicates: false);
  //         if (result != null) {
  //           _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
  //           mapData[_listChoosenTempKey].clear();
  //           mapData[_listChoosenTempKey].addAll(result);
  //           _listVariable.refresh();
  //         }
  //         Timer(Duration(milliseconds: 300), () {
  //           Get.delete<ListTruckCarrierFilterController>();
  //         });
  //       }));
  // }

  // void _addWidgetCarrierWrapToContent(
  //     int index, List<Widget> listWidgetContent) {
  //   _addWidgetToContent(
  //       listWidgetContent,
  //       _wrapItemWidget(listWidgetInFilter[index].label[0], index,
  //           seeAll: () async {
  //         Map<String, dynamic> mapData =
  //             Map<String, dynamic>.from(_listVariable[index.toString()]);
  //         var result =
  //             await GetToPage.toNamed<ListTruckCarrierFilterController>(
  //                 Routes.LIST_TRUCK_CARRIER_FILTER,
  //                 arguments: [
  //                   List.from(_listCarrierModel),
  //                   mapData[_listChoosenTempKey],
  //                   "Jenis Carrier".tr,
  //                 ],
  //                 preventDuplicates: false);
  //         // var result = await Get.toNamed(Routes.LIST_TRUCK_CARRIER_FILTER,
  //         //     arguments: [
  //         //       List.from(_listCarrierModel),
  //         //       mapData[_listChoosenTempKey],
  //         //       "Jenis Carrier".tr,
  //         //     ],
  //         //     preventDuplicates: false);
  //         if (result != null) {
  //           _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
  //           mapData[_listChoosenTempKey].clear();
  //           mapData[_listChoosenTempKey].addAll(result);
  //           _listVariable.refresh();
  //         }
  //         Timer(Duration(milliseconds: 300), () {
  //           Get.delete<ListTruckCarrierFilterController>();
  //         });
  //       }));
  // }

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
    _checkListWidgetInFilter(
      onDate: (index) {
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
      },
      onCity: (index) {
        _isCity = true;
        _onInitShowFilterWrap(index);
      },
      onLocation: (index) {
        _isCity = true;
        _onInitShowFilterWrap(index);
      },
      onSwitch: (index) {
        _listVariable[index.toString()][_switchTempKey] =
            _listVariable[index.toString()][_switchKey];
      },
      onUnit: (index) {
        _isUnit = true;
        if (listWidgetInFilter[index].customValue != null) {
          _listVariable[index.toString()][_rangeValuesTempKey] =
              _listVariable[index.toString()][_rangeValuesKey];
          double min =
              _listVariable[index.toString()][_rangeValuesTempKey].start;
          double max = _listVariable[index.toString()][_rangeValuesTempKey].end;
          if (listWidgetInFilter[index].customValue[0] >
              _listVariable[index.toString()][_rangeValuesTempKey].start) {
            min = listWidgetInFilter[index].customValue[0];
          }
          if (listWidgetInFilter[index].customValue[1] <
              _listVariable[index.toString()][_rangeValuesTempKey].end) {
            max = listWidgetInFilter[index].customValue[1];
          }
          _setRangeValueUnit(index, min, max, index,
              isUpdateRangeValues: true, isUpdateTextEditingController: true);
        } else {
          _listVariable[index.toString()][_rangeValuesTempKey] =
              _listVariable[index.toString()][_rangeValuesKey];
          _setRangeValueUnit(
              index,
              _listVariable[index.toString()][_rangeValuesKey].start,
              _listVariable[index.toString()][_rangeValuesKey].end,
              index,
              isUpdateTextEditingController: true);
        }
      },
      onRadioButton: (index) {
        _listVariable[index.toString()][_radioButtonTempKey] =
            _listVariable[index.toString()][_radioButtonKey];
      },
      onCheckbox: (index) {
        _listVariable[index.toString()][_checkboxTempKey] =
            _listVariable[index.toString()][_checkboxKey];
      },
      onCheckboxWithHide: (index) {
        _listVariable[index.toString()][_checkboxHideTempKey] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_checkboxHideKey]));
        _listVariable[index.toString()][_hideTemp] =
            jsonDecode(jsonEncode(_listVariable[index.toString()][_hide]));
        _listVariable.refresh();
      },
      onEkspektasiDestinasi: (index) {
        _isEkspektasiDestinasi = true;
        _onInitShowFilterWrap(index);
      },
      onName: (index) {
        _listVariable[index.toString()][_nameTempKey] =
            _listVariable[index.toString()][_nameKey];
        _listVariable[index.toString()][_nameTextEditingControllerKey].text =
            _listVariable[index.toString()][_nameTempKey];
      },
      onAreaPickupSearch: (index) {
        indexAreaPickupSearch = index;
        _isAreaPickupSearch = true;
        _onInitShowFilterWrap(index);
      },
      onAreaPickupTransporter: (index) {
        indexAreaPickupTransporter = index;
        _isAreaPickupTransporter = true;
        _onInitShowFilterWrap(index);
      },
      onMuatan: (index) {
        _listVariable[index.toString()][_muatanTempKey] =
            jsonDecode(jsonEncode(_listVariable[index.toString()][_muatanKey]));
        _listVariable[index.toString()][_muatanIDTempKey] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_muatanIDKey]));
      },
      onDiumumkanKepada: (index) {
        _listVariable[index.toString()][_diumumkanTempKey] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_diumumkanKey]));
      },
      onSatuan: (index) {
        // _listVariable[index.toString()][_satuanTempKey] =
        //     _listVariable[index.toString()][_satuanKey];
        _listVariable[index.toString()] = {
          _satuanKey: _listVariable[index.toString()][_satuanKey],
          _satuanTempKey: jsonDecode(
              jsonEncode(_listVariable[index.toString()][_satuanKey])),
          "min": _listVariable[index.toString()]["minKey"],
          "max": _listVariable[index.toString()]["maxKey"],
          "minKey": _listVariable[index.toString()]["minKey"],
          "maxKey": _listVariable[index.toString()]["maxKey"],
          "enable": _listVariable[index.toString()]["enableKey"],
          "enableKey": _listVariable[index.toString()]["enableKey"],
          "isDecimal": false,
        };
      },
      onUnitSatuan: (index) {
        _isUnit = true;
        if (listWidgetInFilter[index].customValue != null) {
          _listVariable[index.toString()][_rangeValuesTempKey] =
              _listVariable[index.toString()][_rangeValuesKey];
          double min =
              _listVariable[index.toString()][_rangeValuesTempKey].start;
          double max = _listVariable[index.toString()][_rangeValuesTempKey].end;
          if (listWidgetInFilter[index].customValue[0] >
              _listVariable[index.toString()][_rangeValuesTempKey].start) {
            min = listWidgetInFilter[index].customValue[0];
          }
          if (listWidgetInFilter[index].customValue[1] <
              _listVariable[index.toString()][_rangeValuesTempKey].end) {
            max = listWidgetInFilter[index].customValue[1];
          }
          _setRangeValueUnit(index, min, max, index,
              isUpdateRangeValues: true, isUpdateTextEditingController: true);
        } else {
          _listVariable[index.toString()][_rangeValuesTempKey] =
              _listVariable[index.toString()][_rangeValuesKey];
          _setRangeValueUnit(
              index,
              _listVariable[index.toString()][_rangeValuesKey].start,
              _listVariable[index.toString()][_rangeValuesKey].end,
              index,
              isUpdateTextEditingController: true);
        }
      },
      onDestinasi: (index) {
        _isDestinasi = true;
        _onInitShowFilterWrap(index);
      },
      onProvince: (index) {
        _onInitShowFilterWrap(index);
        _isProvince = true;
      },
      onVolume: (index) {
        _listVariable[index.toString()][_nilaiVolumeTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_nilaiVolume]));
        _listVariable[index.toString()][_satuanVolumeTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanVolume]));
        _listVariable[index.toString()][_satuanVolumeKeyTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanVolumeKey]));
        TextEditingController copas = new TextEditingController();
        copas.text = _listVariable[index.toString()][_nilaiController].text;
        _listVariable[index.toString()][_nilaiControllerTemp] = copas;
      },
      onCapacity: (index) {
        _listVariable[index.toString()][_nilaiKapasitasMinTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_nilaiKapasitasMin]));
        _listVariable[index.toString()][_nilaiKapasitasMaxTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_nilaiKapasitasMax]));
        _listVariable[index.toString()][_satuanKapasitasTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanKapasitas]));
        _listVariable[index.toString()][_satuanKapasitasKeyTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanKapasitasKey]));
        TextEditingController copasMin = new TextEditingController();
        copasMin.text =
            _listVariable[index.toString()][_nilaiKapasitasMinController].text;
        _listVariable[index.toString()][_nilaiKapasitasMinControllerTemp] =
            copasMin;
        TextEditingController copasMax = new TextEditingController();
        copasMax.text =
            _listVariable[index.toString()][_nilaiKapasitasMaxController].text;
        _listVariable[index.toString()][_nilaiKapasitasMaxControllerTemp] =
            copasMax;
      },
      onDimension: (index) {
        _listVariable[index.toString()][_panjangTemp].text =
            _listVariable[index.toString()][_panjang].text;
        _listVariable[index.toString()][_lebarTemp].text =
            _listVariable[index.toString()][_lebar].text;
        _listVariable[index.toString()][_tinggiTemp].text =
            _listVariable[index.toString()][_tinggi].text;
        _listVariable[index.toString()][_satuanDimensionTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanDimension]));
        _listVariable[index.toString()][_satuanDimensionKeyTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanDimensionKey]));

        _listVariable.refresh();
      },
      onTruck: (index) {
        _listVariable[index.toString()][_truckNameTemp] =
            jsonDecode(jsonEncode(_listVariable[index.toString()][_truckName]));
        _listVariable[index.toString()][_truckIDTemp] =
            jsonDecode(jsonEncode(_listVariable[index.toString()][_truckID]));
        _isTruck = true;
      },
      onCarrier: (index) {
        _listVariable[index.toString()][_carrierIDTemp] =
            jsonDecode(jsonEncode(_listVariable[index.toString()][_carrierID]));
        _listVariable[index.toString()][_carrierNameTemp] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_carrierName]));
        _isCarrier = true;
      },
    );

    await _gettingDataVariable();
  }

  Future _gettingDataVariable() async {
    _isGettingData.value = true;
    //_isSuccessGettingData.value = true;
    bool success = true;
    print("ambil variable");

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
              _setRangeValueUnit(index, 0.0, _maxRangeValueUnit, index);
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

    if (success && _isDestinasi && _listCity.length == 0) {
      //_isSuccessGettingData.value = await _getCity();
      print("get data city");
      success = await _getCity();
    }

    if (success && _isTruck && _listTruck.length == 0) {
      print("get data Truck");
      success = await _getHeadTruck();
    }

    if (success && _isCarrier && _listCarrier.length == 0) {
      print("get data carrier");
      success = await _getCarrierTruck();
    }

    if (success && _isProvince && _listProvince.length == 0) {
      print("get data province");
      success = await _getProvince();
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
    // _listVariable[index.toString()][_listChoosenTempKey] =
    //     _listVariable[index.toString()][_listChoosenKey];
    _listVariable[index.toString()][_listChoosenTempKey].clear();
    _listVariable[index.toString()][_listChoosenTempKey]
        .addAll(_listVariable[index.toString()][_listChoosenKey]);
  }

  Future cancelFilter() {
    _checkListWidgetInFilter(onDate: (index) {
      _listVariable[index.toString()][_firstDateKey] =
          _listVariable[index.toString()][_firstDateTempKey];
      _listVariable[index.toString()][_endDateKey] =
          _listVariable[index.toString()][_endDateTempKey];
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
    });
    _listVariable.refresh();
  }

  Future showFilter() async {
    var getwidget = await _getListWidgetCotent();
    print(getwidget.length);
    _initShowFilter();
    await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 17),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 17))),
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
                    bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                  ),
                  child: Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 3,
                    width: GlobalVariable.ratioWidth(Get.context) * 38,
                    decoration: BoxDecoration(
                      color: Color(ListColor.colorLightGrey16),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 2),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(
                //       top: GlobalVariable.ratioWidth(Get.context) * 24),
                //   //   child: Container(
                //   //     width: 50,
                //   //     height: 5,
                //   //     decoration: BoxDecoration(
                //   //         color: Color(ListColor.colorLightGrey),
                //   //         borderRadius:
                //   //             BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20))),
                //   // )
                // ),
                Container(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 12,
                        right: GlobalVariable.ratioWidth(Get.context) * 12,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CustomText(
                                        "GlobalFilterTitle".tr,
                                        fontWeight: FontWeight.w700,
                                        color: Color(ListColor.color4),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child:
                                Expanded(
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Obx(
                                        () => _isSuccessGettingData.value &&
                                                !_isGettingData.value
                                            ? Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                    child: Container(
                                                      // padding: EdgeInsets.symmetric(
                                                      //     horizontal: 10),
                                                      padding: EdgeInsets.only(
                                                        top: (2 * 2.3 / 11),
                                                        right: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            10,
                                                      ),
                                                      child: CustomText(
                                                        "GlobalFilterButtonReset"
                                                            .tr,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                            ListColor.color4),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      isReset.value = true;
                                                      _resetAll();
                                                    }),
                                              )
                                            : SizedBox.shrink(),
                                      ),
                                    ),
                                  ),
                                )
                                // )
                              ],
                            ),
                          ),
                        ),
                        // Material(
                        //   color: Colors.transparent,
                        //   child: InkWell(
                        //     onTap: () {
                        //       Get.back();
                        //     },
                        //     child: Container(
                        //         child: Icon(
                        //       Icons.close_rounded,
                        //       size:
                        //           GlobalVariable.ratioWidth(Get.context) * 24,
                        //     )),
                        //   ),
                        // ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath +
                                    'ic_close_simple.svg',
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24),
                            onTap: () async {
                              // saveTemporary();
                              Get.back();
                            },
                          ),
                        ),
                        // Obx(
                        //   () => _isSuccessGettingData.value &&
                        //           !_isGettingData.value
                        //       ? Align(
                        //           alignment: Alignment.bottomRight,
                        //           child: Material(
                        //             color: Colors.transparent,
                        //             child: InkWell(
                        //                 child: Container(
                        //                   // padding: EdgeInsets.symmetric(
                        //                   //     horizontal: 10),
                        //                   // padding: EdgeInsets.only(
                        //                   //   top: GlobalVariable.ratioWidth(
                        //                   //           Get.context) *
                        //                   //       6,
                        //                   //   left: GlobalVariable.ratioWidth(
                        //                   //           Get.context) *
                        //                   //       10,
                        //                   //   right: GlobalVariable.ratioWidth(
                        //                   //           Get.context) *
                        //                   //       10,
                        //                   // ),
                        //                   child: CustomText(
                        //                     "GlobalFilterButtonReset".tr,
                        //                     fontSize: 12,
                        //                     fontWeight: FontWeight.w600,
                        //                     color: Color(ListColor.color4),
                        //                   ),
                        //                 ),
                        //                 onTap: () {
                        //                   _resetAll();
                        //                 }),
                        //           ),
                        //         )
                        //       : SizedBox.shrink(),
                        // )
                      ],
                    )),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: _filterheight,
                        minHeight: 0,
                        minWidth: double.infinity),
                    child: Container(
                      // padding: EdgeInsets.symmetric(
                      //     horizontal:
                      //         GlobalVariable.ratioWidth(Get.context) * 15),
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
                                          //                 Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 23,
                      GlobalVariable.ratioWidth(Get.context) * 10,
                      GlobalVariable.ratioWidth(Get.context) * 23,
                      GlobalVariable.ratioWidth(Get.context) * 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          topRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color:
                              Color(ListColor.colorLightGrey).withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 4,
                        ),
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  width: 2, color: Color(ListColor.color4)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                              )),
                          onPressed: () async {
                            // await cancelFilter();
                            // saveTemporary();
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child:
                                Stack(alignment: Alignment.center, children: [
                              CustomText("GlobalFilterButtonCancel".tr,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.color4)),
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(ListColor.color4),
                              side: BorderSide(
                                  width: 2, color: Color(ListColor.color4)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                              )),
                          onPressed: () {
                            _onSaveData();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child:
                                Stack(alignment: Alignment.center, children: [
                              CustomText("GlobalFilterButtonSave".tr,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //       decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                //               topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
                //           boxShadow: <BoxShadow>[
                //             BoxShadow(
                //               color: Color(ListColor.colorLightGrey)
                //                   .withOpacity(0.5),
                //               blurRadius: 10,
                //               spreadRadius: 4,
                //             ),
                //           ]),
                //       padding: EdgeInsets.symmetric(
                //           horizontal:
                //               GlobalVariable.ratioWidth(Get.context) * 16,
                //           vertical:
                //               GlobalVariable.ratioWidth(Get.context) * 12),
                //       width: MediaQuery.of(Get.context).size.width,
                //       height: 56,
                //       child: Obx(
                //         () => _isSuccessGettingData.value &&
                //                 !_isGettingData.value
                //             ? Row(
                //                 mainAxisSize: MainAxisSize.max,
                //                 children: [
                //                   Expanded(
                //                     child: Container(
                //                       decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.all(
                //                             Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                //                         border: Border.all(
                //                             width: 1,
                //                             color: Color(ListColor.color4)),
                //                         color: Colors.white,
                //                       ),
                //                       child: Material(
                //                           borderRadius: BorderRadius.all(
                //                               Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                //                           color: Colors.transparent,
                //                           child: InkWell(
                //                             borderRadius: BorderRadius.all(
                //                                 Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                //                             onTap: () async {
                //                               await cancelFilter();
                //                               Get.back();
                //                             },
                //                             child: Center(
                //                                 child: CustomText(
                //                               "GlobalFilterButtonCancel"
                //                                   .tr, //batal
                //                               color: Color(ListColor.color4),
                //                               fontWeight: FontWeight.w600,
                //                               fontSize: 12,
                //                             )),
                //                           )),
                //                     ),
                //                   ),
                //                   SizedBox(
                //                       width: GlobalVariable.ratioWidth(
                //                               Get.context) *
                //                           8),
                //                   Expanded(
                //                     child: Container(
                //                       decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.all(
                //                             Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                //                         border: Border.all(
                //                             width: 1,
                //                             color: Color(ListColor.color4)),
                //                         color: Color(ListColor.color4),
                //                       ),
                //                       child: Material(
                //                           color: Colors.transparent,
                //                           borderRadius: BorderRadius.all(
                //                               Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                //                           child: InkWell(
                //                             borderRadius: BorderRadius.all(
                //                                 Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                //                             onTap: () {
                //                               _onSaveData();
                //                             },
                //                             child: Center(
                //                                 child: CustomText(
                //                               "GlobalFilterButtonSave"
                //                                   .tr, //simpan
                //                               color: Colors.white,
                //                               fontWeight: FontWeight.w600,
                //                               fontSize: 12,
                //                             )),
                //                           )),
                //                     ),
                //                   ),
                //                 ],
                //               )
                //             : SizedBox.shrink(),
                //       )),
                // )
              ],
            ),
          ));
        }).then((value) {
      // bool isSave = true;
      // if (isReset.value) {
      //   isSave = checkTempKey();

      //   print("issave=" + isSave.toString());
      // }
      // if (isSave == true) {
      //   saveTemporary();
      // }
      // isReset.value = false;
    });
  }

  bool checkTempKey() {
    bool check = false;
    _checkListWidgetInFilter(
      onDate: (index) {
        if (_listVariable[index.toString()][_firstDateTempKey] != null ||
            _listVariable[index.toString()][_endDateTempKey] != null) {
          check = true;
          print("check date " + check.toString());
        }
      },
      onCity: (index) {
        if (_listVariable[index.toString()][_listChoosenTempKey].length > 0) {
          check = true;
          print("check city " + check.toString());
        }
      },
      onLocation: (index) {
        if (_listVariable[index.toString()][_listChoosenTempKey].length > 0) {
          check = true;
          print("check city " + check.toString());
        }
      },
      onDestinasi: (index) {
        if (_listVariable[index.toString()][_listChoosenTempKey].length > 0) {
          check = true;
          print("check destinasi " + check.toString());
        }
      },
      onSwitch: (index) {
        if (_listVariable[index.toString()][_switchTempKey] != false) {
          check = true;
          print("check switch " + check.toString());
        }
      },
      onUnit: (index) {
        RangeValues isi = RangeValues(0.0, 0.0);
        if (listWidgetInFilter[index].customValue != null) {
          isi = RangeValues(listWidgetInFilter[index].customValue[0],
              listWidgetInFilter[index].customValue[1]);
        } else {
          isi = RangeValues(0.0, _maxRangeValueUnit);
        }
        if (_listVariable[index.toString()][_rangeValuesTempKey] != isi) {
          check = true;
          print("check unit " + check.toString());
        }
      },
      onTruck: (index) {
        if (_listVariable[index.toString()][_truckID].length > 0) {
          check = true;
          print("check truck " + check.toString());
        }
      },
      onCarrier: (index) {
        if (_listVariable[index.toString()][_carrierID].length > 0) {
          check = true;
          print("check carrier " + check.toString());
        }
      },
      onRadioButton: (index) {
        if (_listVariable[index.toString()][_radioButtonTempKey] != "") {
          check = true;
          print("check radio button " + check.toString());
        }
      },
      onCheckbox: (index) {
        if (_listVariable[index.toString()][_checkboxTempKey] != "") {
          check = true;
          print("check checkbox " + check.toString());
        }
      },
      onCheckboxWithHide: (index) {
        if (_listVariable[index.toString()][_checkboxHideTempKey] != "") {
          check = true;
          print("check checkbox " + check.toString());
        }
      },
      onEkspektasiDestinasi: (index) {
        if (_listVariable[index.toString()][_listChoosenTempKey].length > 0) {
          check = true;
          print("check ekspektasi destinasi " + check.toString());
        }
      },
      onName: (index) {
        if (_listVariable[index.toString()][_nameKey] != "") {
          check = true;
          print("check name " + check.toString());
        }
      },
      onAreaPickupSearch: (index) {
        if (_listVariable[index.toString()][_listChoosenTempKey].length > 0) {
          check = true;
          print("check area pickup search " + check.toString());
        }
      },
      onAreaPickupTransporter: (index) {
        if (_listVariable[index.toString()][_listChoosenTempKey].length > 0) {
          check = true;
          print("check area pickup transporter " + check.toString());
        }
      },
      onMuatan: (index) {
        if (_listVariable[index.toString()][_muatanTempKey].length > 0) {
          check = true;
          print("check muatan= " + check.toString());
        }
      },
      onDiumumkanKepada: (index) {
        if (_listVariable[index.toString()][_diumumkanTempKey].length > 0) {
          check = true;
          print("check diumumkan kepada= " + check.toString());
        }
      },
      onSatuan: (index) {
        print("Isi satuan= " +
            _listVariable[index.toString()][_satuanTempKey].toString());
        if (_listVariable[index.toString()][_satuanTempKey].length > 0) {
          check = true;
          print("check satuan= " + check.toString());
        }
      },
      onUnitSatuan: (index) {
        if (_listVariable[index.toString()][_rangeValuesTempKey] !=
            RangeValues(0, 0)) {
          check = true;
          print("check unit satuan= " + check.toString());
        }
      },
      onProvince: (index) {
        if (_listVariable[index.toString()][_provinceIDTemp].length > 0) {
          check = true;
          print("check Provinsi " + check.toString());
        }
      },
      onVolume: (index) {
        if (_listVariable[index.toString()][_nilaiControllerTemp].text != "") {
          check = true;
          print("check city " + check.toString());
        }
      },
      onCapacity: (index) {
        if (_listVariable[index.toString()][_nilaiKapasitasMinTemp].text !=
                "" ||
            _listVariable[index.toString()][_nilaiKapasitasMaxTemp].text !=
                "") {
          check = true;
          print("check capacity " + check.toString());
        }
      },
      onDimension: (index) {
        if (_listVariable[index.toString()][_panjangTemp] != "") {
          check = true;
          print("check Dimension " + check.toString());
        }
      },
    );
    return check;
  }

  void saveTemporary() {
    print("start save data");
    _checkListWidgetInFilter(
      onDate: (index) {
        _listVariable[index.toString()][_firstDateKey] =
            _listVariable[index.toString()][_firstDateTempKey];
        _listVariable[index.toString()][_endDateKey] =
            _listVariable[index.toString()][_endDateTempKey];
      },
      onCity: (index) {
        _listVariable[index.toString()][_listChoosenKey] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_listChoosenTempKey]));
      },
      onLocation: (index) {
        _listVariable[index.toString()][_listChoosenKey] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_listChoosenTempKey]));
      },
      onDestinasi: (index) {
        _listVariable[index.toString()][_listChoosenKey].clear();
        _listVariable[index.toString()][_listChoosenKey]
            .addAll(_listVariable[index.toString()][_listChoosenTempKey]);
      },
      onSwitch: (index) {
        _listVariable[index.toString()][_switchKey] =
            _listVariable[index.toString()][_switchTempKey];
      },
      onUnit: (index) {
        _listVariable[index.toString()][_rangeValuesKey] =
            _listVariable[index.toString()][_rangeValuesTempKey];
      },
      onRadioButton: (index) {
        _listVariable[index.toString()][_radioButtonKey] =
            _listVariable[index.toString()][_radioButtonTempKey];
      },
      onCheckbox: (index) {
        _listVariable[index.toString()][_checkboxKey] =
            _listVariable[index.toString()][_checkboxTempKey];
      },
      onCheckboxWithHide: (index) {
        _listVariable[index.toString()][_checkboxHideKey] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_checkboxHideTempKey]));
        _listVariable[index.toString()][_hide] =
            jsonDecode(jsonEncode(_listVariable[index.toString()][_hideTemp]));
        _listVariable.refresh();
      },
      onEkspektasiDestinasi: (index) {
        _setWrapFromTempToReal(index);
      },
      onName: (index) {
        _listVariable[index.toString()][_nameKey] =
            _listVariable[index.toString()][_nameTempKey];
      },
      onAreaPickupSearch: (index) {
        _setWrapFromTempToReal(index);
      },
      onAreaPickupTransporter: (index) {
        _setWrapFromTempToReal(index);
      },
      onMuatan: (index) {
        _listVariable[index.toString()][_muatanKey] =
            _listVariable[index.toString()][_muatanTempKey];
        _listVariable[index.toString()][_muatanIDKey] =
            _listVariable[index.toString()][_muatanIDTempKey];
      },
      onDiumumkanKepada: (index) {
        _listVariable[index.toString()][_diumumkanKey] =
            _listVariable[index.toString()][_diumumkanTempKey];
      },
      onSatuan: (index) {
        _listVariable[index.toString()] = {
          _satuanKey: _listVariable[index.toString()][_satuanTempKey],
          _satuanTempKey: _listVariable[index.toString()][_satuanTempKey],
          "min": _listVariable[index.toString()]["min"],
          "max": _listVariable[index.toString()]["max"],
          "minKey": _listVariable[index.toString()]["min"],
          "maxKey": _listVariable[index.toString()]["max"],
          "enable": _listVariable[index.toString()]["enable"],
          "enableKey": _listVariable[index.toString()]["enable"],
          "isDecimal": false,
        };
      },
      onUnitSatuan: (index) {
        RangeValues isi = _listVariable[index.toString()][_rangeValuesTempKey];
        _listVariable[index.toString()][_rangeValuesKey] = isi;
      },
      onProvince: (index) {
        _listVariable[index.toString()][_listChoosenKey] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_listChoosenTempKey]));
      },
      onVolume: (index) {
        _listVariable[index.toString()][_nilaiVolume] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_nilaiVolumeTemp]));
        _listVariable[index.toString()][_satuanVolume] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanVolumeTemp]));
        _listVariable[index.toString()][_satuanVolumeKey] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanVolumeKeyTemp]));
        TextEditingController copas = new TextEditingController();
        copas.text = _listVariable[index.toString()][_nilaiControllerTemp].text;
        _listVariable[index.toString()][_nilaiController] = copas;
      },
      onCapacity: (index) {
        _listVariable[index.toString()][_nilaiKapasitasMin] = jsonDecode(
            jsonEncode(
                _listVariable[index.toString()][_nilaiKapasitasMinTemp]));
        _listVariable[index.toString()][_nilaiKapasitasMax] = jsonDecode(
            jsonEncode(
                _listVariable[index.toString()][_nilaiKapasitasMaxTemp]));
        _listVariable[index.toString()][_satuanKapasitas] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanKapasitasTemp]));
        _listVariable[index.toString()][_satuanKapasitasKey] = jsonDecode(
            jsonEncode(
                _listVariable[index.toString()][_satuanKapasitasKeyTemp]));
        TextEditingController copasMin = new TextEditingController();
        copasMin.text = _listVariable[index.toString()]
                [_nilaiKapasitasMinControllerTemp]
            .text;
        _listVariable[index.toString()][_nilaiKapasitasMinController] =
            copasMin;
        TextEditingController copasMax = new TextEditingController();
        copasMax.text = _listVariable[index.toString()]
                [_nilaiKapasitasMaxControllerTemp]
            .text;
        _listVariable[index.toString()][_nilaiKapasitasMaxController] =
            copasMax;
      },
      onDimension: (index) {
        _listVariable[index.toString()][_panjang].text =
            _listVariable[index.toString()][_panjangTemp].text;
        _listVariable[index.toString()][_lebar].text =
            _listVariable[index.toString()][_lebarTemp].text;
        _listVariable[index.toString()][_tinggi].text =
            _listVariable[index.toString()][_tinggiTemp].text;
        _listVariable[index.toString()][_satuanDimension] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_satuanDimensionTemp]));
        _listVariable[index.toString()][_satuanDimensionKey] = jsonDecode(
            jsonEncode(
                _listVariable[index.toString()][_satuanDimensionKeyTemp]));
        _listVariable.refresh();
      },
      onTruck: (index) {
        _listVariable[index.toString()][_truckID] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_truckIDTemp]));
        _listVariable[index.toString()][_truckName] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_truckNameTemp]));
      },
      onCarrier: (index) {
        _listVariable[index.toString()][_carrierID] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_carrierIDTemp]));
        _listVariable[index.toString()][_carrierName] = jsonDecode(
            jsonEncode(_listVariable[index.toString()][_carrierNameTemp]));
      },
    );
    _listVariable.refresh();
  }

  Widget _filterWrap(
      String title,
      void Function() seeAll,
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textTitle(title),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: GlobalVariable.ratioWidth(Get.context) * 1),
                //   child: _textTitle(title),
                // ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 1,
                        // bottom: GlobalVariable.ratioWidth(Get.context) * 1,
                      ),
                      child: countBadge(_listVariable[index.toString()]
                              [_listChoosenTempKey]
                          .length),
                    ),
                  ],
                )),
                // Expanded(
                //   child: countBadge(_listVariable[index.toString()]
                //           [_listChoosenTempKey]
                //       .length),
                // ),
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
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 1),
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
          SizedBox(height: 18),
          Wrap(
            spacing: GlobalVariable.ratioWidth(Get.context) * 8,
            children: getListCityWrap(onTapItem, index),
          )
        ],
      ),
    );
  }

  Widget _filterLocationWrap(
      String title,
      void Function() seeAll,
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textTitle(title),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: GlobalVariable.ratioWidth(Get.context) * 1),
                //   child: _textTitle(title),
                // ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 1,
                        // bottom: GlobalVariable.ratioWidth(Get.context) * 1,
                      ),
                      child: countBadge(_listVariable[index.toString()]
                              [_listChoosenTempKey]
                          .length),
                    ),
                  ],
                )),
                // Expanded(
                //   child: countBadge(_listVariable[index.toString()]
                //           [_listChoosenTempKey]
                //       .length),
                // ),
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
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 1),
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
          SizedBox(height: 18),
          Wrap(
            spacing: GlobalVariable.ratioWidth(Get.context) * 8,
            children: getListLocationWrap(onTapItem, index),
          )
        ],
      ),
    );
  }

  Widget countBadge(int isi) {
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 22,
      width: GlobalVariable.ratioWidth(Get.context) * 22,
      margin: EdgeInsets.zero,
      // padding: EdgeInsets.only(
      //   // top: GlobalVariable.ratioWidth(Get.context) * 0.5,
      //   bottom: GlobalVariable.ratioWidth(Get.context) * 1,
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

  List<Widget> getListLocationWrap(
      void Function(bool isChoosen, String key, String value) onTapItem,
      int index) {
    List<Widget> cityWrap = <Widget>[];
    var listLocation = listWidgetInFilter[index].customValue[0];
    Map<String, dynamic> mapChoosen = Map<String, dynamic>.from(
        _listVariable[index.toString()][_listChoosenTempKey]);
    // int jumlah = mapChoosen.length > 5 ? 5 : mapChoosen.length;
    int jumlah = 0;
    mapChoosen.entries.forEach((element) {
      if (jumlah < 5) {
        cityWrap.add(_getItemWrap(
            element.key, element.value.toString(), true, onTapItem));
        jumlah++;
      }
    });
    int ctr = 0;
    while (jumlah < 5) {
      if (ctr >= listLocation.length) {
        jumlah = 5;
      } else {
        bool check = false;
        mapChoosen.entries.forEach((element) {
          if (element.key == listLocation.keys.elementAt(ctr)) {
            check = true;
          }
        });
        if (!check) {
          cityWrap.add(_getItemWrap(listLocation.keys.elementAt(ctr),
              listLocation.values.elementAt(ctr).toString(), false, onTapItem));
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
          vertical: GlobalVariable.ratioWidth(Get.context) * 2, horizontal: 0),
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
    double borderRadius = 20;
    return Container(
      margin:
          EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 8),
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
            onTapItem(!isChoosen, key, title);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            constraints: BoxConstraints(maxWidth: 190),
            child: CustomText(
              title.toString().replaceAll("", "\u{200B}"),
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _textTitle(String title) {
    return CustomText(
      title,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      overflow: TextOverflow.ellipsis,
    );
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
        initialDate: initialDate == null
            ? await GlobalVariable.getDateTimeFromServer(Get.context)
            : initialDate,
        firstDate: DateTime(1800),
        lastDate: DateTime(2100));
  }

  Future _setFirstDateTimeTemp(Map<String, dynamic> data, TypeInFilter type,
      String defaultIfNull, int indexListVariable) async {
    if (type == TypeInFilter.DATE) {
      showDatePicker(
              context: Get.context,
              initialDate: data[_firstDateTempKey] == null
                  ? await GlobalVariable.getDateTimeFromServer(Get.context)
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
                  ? await GlobalVariable.getDateTimeFromServer(Get.context)
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

  resetFromPage() {
    print("reset filter");
    _resetAll(isIncludeChoosen: true);
  }

  void _resetAll({bool isIncludeChoosen = false}) {
    print("isincludechoosen =" + isIncludeChoosen.toString());
    _showPrint("_checkListWidgetInFilter: _resetAll");
    _checkListWidgetInFilter(
      onCity: (index) {
        _resetWrapData(index, isIncludeChoosen);
      },
      onLocation: (index) {
        _resetWrapData(index, isIncludeChoosen);
      },
      onDestinasi: (index) {
        _resetWrapData(index, isIncludeChoosen);
      },
      onDate: (index) {
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
        // if (isIncludeChoosen) {
        //   _listVariable[index.toString()][_firstDateKey] = null;
        //   _listVariable[index.toString()][_endDateKey] = null;
        // }
      },
      onSwitch: (index) {
        _listVariable[index.toString()][_switchTempKey] = false;
        // if (isIncludeChoosen) _listVariable[index.toString()][_switchKey] = false;
      },
      onUnit: (index) {
        _listVariable[index.toString()][_rangeValuesTempKey] =
            listWidgetInFilter[index].customValue != null
                ? RangeValues(listWidgetInFilter[index].customValue[0],
                    listWidgetInFilter[index].customValue[1])
                : RangeValues(0, _maxRangeValueUnit);
        if (listWidgetInFilter[index].customValue != null) {
          _setRangeValueUnit(index, listWidgetInFilter[index].customValue[0],
              listWidgetInFilter[index].customValue[1], index);
        } else {
          _setRangeValueUnit(index, 0.0, _maxRangeValueUnit, index);
        }

        // if (isIncludeChoosen)
        //   _listVariable[index.toString()][_rangeValuesKey] =
        //       listWidgetInFilter[index].customValue != null
        //           ? RangeValues(listWidgetInFilter[index].customValue[0],
        //               listWidgetInFilter[index].customValue[1])
        //           : RangeValues(0, _maxRangeValueUnit);
      },
      onRadioButton: (index) {
        _listVariable[index.toString()][_radioButtonTempKey] = "";
      },
      onCheckbox: (index) {
        _listVariable[index.toString()][_checkboxTempKey] = [];
      },
      onCheckboxWithHide: (index) {
        List<dynamic> datahide = [];
        List<dynamic> dataCheckbox = listWidgetInFilter[index].customValue;
        for (int i = 0; i < dataCheckbox.length; i++) {
          if (dataCheckbox[i].canHide) {
            datahide.add({
              "hide": true,
              "hideIndex": dataCheckbox[i].hideIndex,
              "checkboxIndex": i,
            });
          }
        }
        _listVariable[index.toString()][_checkboxHideTempKey] = [];
        _listVariable[index.toString()][_hideTemp] = datahide;
        _listVariable.refresh();
      },
      onEkspektasiDestinasi: (index) {
        _resetWrapData(index, isIncludeChoosen);
      },
      onName: (index) {
        _listVariable[index.toString()][_nameTempKey] = "";
        _listVariable[index.toString()][_nameTextEditingControllerKey].text =
            "";
      },
      onAreaPickupSearch: (index) {
        _resetWrapData(index, isIncludeChoosen);
      },
      onAreaPickupTransporter: (index) {
        _resetWrapData(index, isIncludeChoosen);
      },
      onMuatan: (index) {
        // _listVariable[index.toString()][_muatanKey] = [];
        _listVariable[index.toString()][_muatanTempKey] = [];
        _listVariable[index.toString()][_muatanIDTempKey] = [];
      },
      onDiumumkanKepada: (index) {
        // _listVariable[index.toString()][_diumumkanKey] = [];
        _listVariable[index.toString()][_diumumkanTempKey] = [];
      },
      onUnitSatuan: (index) {
        double min = 0;
        double max = 0;
        //_listVariable[index.toString()][_loadDataUnitKey] = null;

        // if (listWidgetInFilter[index].customValue != null) {
        //   min = listWidgetInFilter[index].customValue[0];
        //   max = listWidgetInFilter[index].customValue[1];
        // }
        _listVariable[index.toString()] = {
          _rangeValuesKey: _listVariable[index.toString()][_rangeValuesKey],
          _rangeValuesTempKey: RangeValues(min, max),
          _startUnitRangeTextEditingControllerKey:
              TextEditingController(text: "0"),
          _endUnitRangeTextEditingControllerKey:
              TextEditingController(text: "0"),
          _errorMessageUnitKey: "",
          _isAlreadyLoadDataKey: false,
        };
        if (listWidgetInFilter[index].customValue != null &&
            listWidgetInFilter[index].customValue.length > 2) {
          _listVariable[index.toString()][_loadDataUnitKey] =
              listWidgetInFilter[index].customValue[2];
        }
        _setRangeValueUnit(
            index,
            _listVariable[index.toString()][_rangeValuesTempKey].start,
            _listVariable[index.toString()][_rangeValuesTempKey].end,
            index,
            isUpdateTextEditingController: true);
      },
      onSatuan: (index) {
        _listVariable[index.toString()] = {
          _satuanKey: _listVariable[index.toString()][_satuanKey],
          _satuanTempKey: [],
          "min": double.parse('0'),
          "max": double.parse('0'),
          "minKey": _listVariable[index.toString()]["minKey"],
          "maxKey": _listVariable[index.toString()]["maxKey"],
          "enable": false,
          "enableKey": _listVariable[index.toString()]["enableKey"],
          "isDecimal": false,
        };
      },
      onProvince: (index) {
        _resetWrapData(index, isIncludeChoosen);
      },
      onVolume: (index) {
        _listVariable[index.toString()] = {
          _nilaiVolume: _listVariable[index.toString()][_nilaiVolume],
          _nilaiVolumeTemp: "",
          _satuanVolume: _listVariable[index.toString()][_satuanVolume],
          _satuanVolumeTemp: listWidgetInFilter[index].customValue[0]['label'],
          _satuanVolumeKey: _listVariable[index.toString()][_satuanVolumeKey],
          _satuanVolumeKeyTemp: listWidgetInFilter[index].customValue[0]['key'],
          _nilaiController: _listVariable[index.toString()][_nilaiController],
          _nilaiControllerTemp: TextEditingController(),
        };
      },
      onCapacity: (index) {
        _listVariable[index.toString()][_nilaiKapasitasMinTemp] = "";
        _listVariable[index.toString()][_nilaiKapasitasMaxTemp] = "";
        _listVariable[index.toString()][_satuanKapasitasTemp] =
            listWidgetInFilter[index].customValue.length == 0
                ? ""
                : listWidgetInFilter[index].customValue[0]['label'];
        _listVariable[index.toString()][_satuanKapasitasKeyTemp] =
            listWidgetInFilter[index].customValue.length == 0
                ? ""
                : listWidgetInFilter[index].customValue[0]['key'];
        TextEditingController copasMin = new TextEditingController();

        _listVariable[index.toString()][_nilaiKapasitasMinControllerTemp] =
            copasMin;
        TextEditingController copasMax = new TextEditingController();
        _listVariable[index.toString()][_nilaiKapasitasMaxControllerTemp] =
            copasMax;
      },
      onDimension: (index) {
        List<dynamic> arrSatuanDimensi =
            listWidgetInFilter[index].customValue[0]['satuan'];
        _listVariable[index.toString()] = {
          _panjang: _listVariable[index.toString()][_panjang],
          _panjangTemp: TextEditingController(),
          _lebar: _listVariable[index.toString()][_lebar],
          _lebarTemp: TextEditingController(),
          _tinggi: _listVariable[index.toString()][_tinggi],
          _tinggiTemp: TextEditingController(),
          _separatorDimension: _listVariable[index.toString()]
              [_separatorDimension],
          _satuanDimension: _listVariable[index.toString()][_satuanDimension],
          _satuanDimensionTemp: arrSatuanDimensi[0]['key'] ?? "",
          _satuanDimensionKey: _listVariable[index.toString()]
              [_satuanDimensionKey],
          _satuanDimensionKeyTemp: arrSatuanDimensi[0]['label'] ?? "",
        };
      },
      onTruck: (index) {
        _listVariable[index.toString()][_truckIDTemp] = [];
        _listVariable[index.toString()][_truckNameTemp] = [];
      },
      onCarrier: (index) {
        _listVariable[index.toString()][_carrierIDTemp] = [];
        _listVariable[index.toString()][_carrierNameTemp] = [];
      },
    );
    _listVariable.refresh();
  }

  void _resetWrapData(int index, bool isIncludeChoosen) {
    _listVariable[index.toString()][_listChoosenTempKey].clear();
    _listVariable[index.toString()][_isFromSeeAllOrFirstTimeKey] = true;
    // if (isIncludeChoosen)
    //   _listVariable[index.toString()][_listChoosenKey].clear();
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
      saveTemporary();
      bool isSavingData = false;

      Map<String, dynamic> mapData = {};
      _showPrint("_checkListWidgetInFilter: _onSaveData2");
      _checkListWidgetInFilter(
        onDate: (index) {
          if ((_listVariable[index.toString()][_firstDateTextKey] !=
                  _listVariable[index.toString()][_firstDefaultTextKey] &&
              _listVariable[index.toString()][_endDateTextKey] !=
                  _listVariable[index.toString()][_endDefaultTextKey])) {
            String date =
                "" + _listVariable[index.toString()][_firstDateTextKey];
            List<String> inputFormat = date.split("-");
            // print(inputFormat);
            String startdate =
                inputFormat[2] + '-' + inputFormat[1] + '-' + inputFormat[0];
            date = "" + _listVariable[index.toString()][_endDateTextKey];
            inputFormat = date.split("-");
            String enddate =
                inputFormat[2] + '-' + inputFormat[1] + '-' + inputFormat[0];
            if (listWidgetInFilter[index].isSeparateParameter == false) {
              mapData[listWidgetInFilter[index].keyParam] =
                  startdate + ',' + enddate;
            } else {
              mapData[listWidgetInFilter[index].listSepKeyParameter[0]] =
                  startdate;
              mapData[listWidgetInFilter[index].listSepKeyParameter[1]] =
                  enddate;
            }
            // mapData[listWidgetInFilter[index].keyParam] =
            //     _listVariable[index.toString()][_firstDateTextKey] +
            //         "," +
            //         _listVariable[index.toString()][_endDateTextKey];

            isSavingData = true;
          } else {
            if (listWidgetInFilter[index].isSeparateParameter == false) {
              mapData[listWidgetInFilter[index].keyParam] = "";
            } else {
              mapData[listWidgetInFilter[index].listSepKeyParameter[0] ?? ""] =
                  "";
              mapData[listWidgetInFilter[index].listSepKeyParameter[1] ?? ""] =
                  "";
            }
          }
        },
        onCity: (index) {
          // Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
          // isSavingData =
          //     isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
          // mapData[listWidgetInFilter[index].keyParam] = returnDataWrap["MapData"];
          var dataarr = [];
          Map<String, dynamic> datachoose = Map<String, dynamic>.from(
              _listVariable[index.toString()][_listChoosenKey]);
          for (int i = 0; i < datachoose.length; i++) {
            if (listWidgetInFilter[index].isIdAsParameter) {
              dataarr.add(datachoose.keys.elementAt(i));
            } else {
              dataarr.add(datachoose.values.elementAt(i));
            }
          }
          mapData[listWidgetInFilter[index].keyParam] = dataarr;
          isSavingData = true;
        },
        onLocation: (index) {
          // Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
          // isSavingData =
          //     isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
          // mapData[listWidgetInFilter[index].keyParam] = returnDataWrap["MapData"];
          var dataarr = [];
          Map<String, dynamic> datachoose = Map<String, dynamic>.from(
              _listVariable[index.toString()][_listChoosenKey]);
          for (int i = 0; i < datachoose.length; i++) {
            if (listWidgetInFilter[index].isIdAsParameter) {
              dataarr.add(datachoose.keys.elementAt(i));
            } else {
              dataarr.add(datachoose.values.elementAt(i));
            }
          }
          mapData[listWidgetInFilter[index].keyParam] = dataarr;
          isSavingData = true;
        },
        onDestinasi: (index) {
          var dataarr = [];
          Map<String, dynamic> datachoose = Map<String, dynamic>.from(
              _listVariable[index.toString()][_listChoosenKey]);
          for (int i = 0; i < datachoose.length; i++) {
            dataarr.add(datachoose.keys.elementAt(i));
          }
          mapData[listWidgetInFilter[index].keyParam] = dataarr;
          isSavingData = true;
        },
        onSwitch: (index) {
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_switchKey] == true ? "1" : "0";
          if (mapData[listWidgetInFilter[index].keyParam] == "1") {
            isSavingData = true;
          }
        },
        onUnit: (index) {
          print("save unit");
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
              if (listWidgetInFilter[index].isSeparateParameter == false) {
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
                mapData[listWidgetInFilter[index].listSepKeyParameter[0] ??
                    ""] = _listVariable[index.toString()]
                        [_rangeValuesKey]
                    .start
                    .round()
                    .toInt()
                    .toString();
                mapData[listWidgetInFilter[index].listSepKeyParameter[1] ??
                    ""] = _listVariable[index.toString()]
                        [_rangeValuesKey]
                    .end
                    .round()
                    .toInt()
                    .toString();
              }
            } else {
              // mapData['jumlahMin'] = "";
              // mapData['jumlahMax'] = "";
              if (listWidgetInFilter[index].isSeparateParameter == false) {
                mapData[listWidgetInFilter[index].keyParam] = "";
              } else {
                mapData[listWidgetInFilter[index].listSepKeyParameter[0] ??
                    ""] = "";
                mapData[listWidgetInFilter[index].listSepKeyParameter[1] ??
                    ""] = "";
              }
            }
            isSavingData = true;
          } catch (error) {
            print(error);
          }
          // mapData[listWidgetInFilter[index].keyParam] = "";
        },
        onRadioButton: (index) {
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_radioButtonKey] ?? "";
          if (mapData[listWidgetInFilter[index].keyParam] != "") {
            isSavingData = true;
          }
        },
        onCheckbox: (index) {
          print("save checkbox");
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_checkboxKey];
          isSavingData = true;
          // var checkboxID = "";
          // (_listVariable[index.toString()][_checkboxKey] as List).forEach((element) {
          //   if(checkboxID.isEmpty)
          //     checkboxID = element;
          //   else
          //     checkboxID += ",$element";
          // });
          // mapData[listWidgetInFilter[index].keyParam] = [];
          // mapData[listWidgetInFilter[index].keyParam] =
          //     (_listVariable[index.toString()][_checkboxKey] as List);
          // print(_listVariable[index.toString()][_checkboxKey]);
          // if (mapData[listWidgetInFilter[index].keyParam] != "") {
          //   isSavingData = true;
          // }
        },
        onCheckboxWithHide: (index) {
          List<dynamic> datasaved = [];
          if (mapData[listWidgetInFilter[index].keyParam] != null) {
            datasaved = mapData[listWidgetInFilter[index].keyParam];
          }
          datasaved.addAll(_listVariable[index.toString()][_checkboxHideKey]);
          mapData[listWidgetInFilter[index].keyParam] = datasaved;
          // _listVariable[index.toString()][_checkboxHideKey];
          isSavingData = true;
        },
        onEkspektasiDestinasi: (index) {
          Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
          isSavingData =
              isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
          mapData[listWidgetInFilter[index].keyParam] =
              returnDataWrap["MapData"];
        },
        onName: (index) {
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_nameKey] ?? "";
          isSavingData = mapData[listWidgetInFilter[index].keyParam] != "";
        },
        onAreaPickupSearch: (index) {
          Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
          isSavingData =
              isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
          mapData[listWidgetInFilter[index].keyParam] =
              (returnDataWrap["MapData"] as String);
          // .split(",")
          // .map((e) => int.parse(e.toString()))
          // .toList();
        },
        onAreaPickupTransporter: (index) {
          Map<String, dynamic> returnDataWrap = _setWrapToMapData(index);
          isSavingData =
              isSavingData ? isSavingData : returnDataWrap["IsSavingData"];
          mapData[listWidgetInFilter[index].keyParam] =
              (returnDataWrap["MapData"] as String);
          // .split(",")
          // .map((e) => int.parse(e.toString()))
          // .toList();
        },
        onMuatan: (index) {
          print("save muatan");
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_muatanKey];
          if (!listWidgetInFilter[index].isIdAsParameter) {
            mapData[listWidgetInFilter[index].keyParam] =
                _listVariable[index.toString()][_muatanKey];
          } else {
            var dataValue = listWidgetInFilter[index].customValue;
            var datatemp = [];
            for (int i = 0; i < dataValue.length; i++) {
              for (int j = 0;
                  j < _listVariable[index.toString()][_muatanKey].length;
                  j++) {
                if (dataValue[i]['nama'] ==
                    _listVariable[index.toString()][_muatanKey][j]) {
                  datatemp.add(dataValue[i]['id']);
                }
              }
            }
            mapData[listWidgetInFilter[index].keyParam] = datatemp;
          }
          isSavingData = true;
        },
        onDiumumkanKepada: (index) {
          print("save diumumkan kepada");
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_diumumkanKey];
        },
        onSatuan: (index) {
          print("save satuan");
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_satuanKey];
          isSavingData = true;
        },
        onUnitSatuan: (index) {
          print("save unit satuan");
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
              mapData['jumlahMin'] = _listVariable[index.toString()]
                      [_rangeValuesKey]
                  .start
                  .round()
                  .toInt();
              mapData['jumlahMax'] = _listVariable[index.toString()]
                      [_rangeValuesKey]
                  .end
                  .round()
                  .toInt();
              // mapData[listWidgetInFilter[index].keyParam] =
              //     _listVariable[index.toString()][_rangeValuesKey]
              //             .start
              //             .round()
              //             .toInt()
              //             .toString() +
              //         "," +
              //         _listVariable[index.toString()][_rangeValuesKey]
              //             .end
              //             .round()
              //             .toInt()
              //             .toString();
            } else {
              mapData['jumlahMax'] =
                  _listVariable[(index - 1).toString()]["max"];
              mapData['jumlahMin'] = 0;
              // mapData[listWidgetInFilter[index].keyParam] = "";
            }
            isSavingData = true;
          } catch (error) {
            print(error);
          }
        },
        onProvince: (index) {
          var dataarr = [];
          Map<String, dynamic> datachoose = Map<String, dynamic>.from(
              _listVariable[index.toString()][_listChoosenKey]);
          datachoose.forEach((key, value) {
            dataarr.add(key);
          });
          mapData[listWidgetInFilter[index].keyParam] = dataarr;
          isSavingData = true;
        },
        onVolume: (index) {
          String vol = "";
          String nilai =
              _listVariable[index.toString()][_nilaiController].text ?? "";
          String satuan =
              _listVariable[index.toString()][_satuanVolumeKey] ?? "";
          if (nilai != "" && satuan != "") {
            vol = nilai + " " + satuan;
          }
          mapData[listWidgetInFilter[index].keyParam] = vol;
          isSavingData = true;
        },
        onCapacity: (index) {
          String nilaiMin = _listVariable[index.toString()]
                      [_nilaiKapasitasMinController]
                  .text ??
              "";
          String nilaiMax = _listVariable[index.toString()]
                      [_nilaiKapasitasMaxController]
                  .text ??
              "";
          String satuan =
              _listVariable[index.toString()][_satuanKapasitas] ?? "";
          if (!listWidgetInFilter[index].isSeparateParameter) {
            String vol = "";
            if (nilaiMin != "" && nilaiMax != "" && satuan != "") {
              vol = nilaiMin + " " + nilaiMax + " " + satuan;
            }
            mapData[listWidgetInFilter[index].keyParam] = vol;
          } else {
            var listParameter = listWidgetInFilter[index].listSepKeyParameter;
            mapData[listParameter[0]] = nilaiMin;
            mapData[listParameter[1]] = nilaiMax;
            if (nilaiMin != "" || nilaiMax != "") {
              mapData[listParameter[2]] = satuan;
            } else {
              mapData[listParameter[2]] = "";
            }
          }
          isSavingData = true;
        },
        onDimension: (index) {
          String dim = "";
          String panjang = _listVariable[index.toString()][_panjang].text ?? "";
          String lebar = _listVariable[index.toString()][_lebar].text ?? "";
          String tinggi = _listVariable[index.toString()][_tinggi].text ?? "";
          String separator =
              _listVariable[index.toString()][_separatorDimension] ?? "";
          String satuan =
              _listVariable[index.toString()][_satuanDimensionKey] ?? "";
          if (!listWidgetInFilter[index].isSeparateParameter) {
            if (panjang != "" && lebar != "" && tinggi != "") {
              dim = panjang + separator + lebar + separator + tinggi + satuan;
            }
            mapData[listWidgetInFilter[index].keyParam] = dim;
          } else {
            var listParameter = listWidgetInFilter[index].listSepKeyParameter;
            mapData[listParameter[0]] = panjang;
            mapData[listParameter[1]] = lebar;
            mapData[listParameter[2]] = tinggi;
            if (panjang != "" || lebar != "" || tinggi != "") {
              mapData[listParameter[3]] = satuan;
            } else {
              mapData[listParameter[3]] = "";
            }
          }
          isSavingData = true;
        },
        onTruck: (index) {
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_truckID];
          isSavingData = true;
        },
        onCarrier: (index) {
          mapData[listWidgetInFilter[index].keyParam] =
              _listVariable[index.toString()][_carrierID];
          isSavingData = true;
        },
      );
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
          onDestinasi: (index) {
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
          onDestinasi: null,
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
        if (result["Message"]["Code"] == 200) {
          List<dynamic> datares = result["Data"];
          List<dynamic> dataTruck = [];
          for (int i = 0; i < datares.length; i++) {
            dataTruck.add({
              'id': datares[i]['ID'],
              "name": datares[i]['Description'],
              "image": datares[i]['ImageHead'],
            });
          }
          _listTruck = dataTruck;
          _checkListWidgetInFilter(
              onDate: null,
              onCity: null,
              onDestinasi: null,
              onSwitch: null,
              onCarrier: null,
              onUnit: null,
              onRadioButton: null,
              onCheckbox: null,
              onTruck: (index) {
                _listVariable[index.toString()][_rawDataTruck] = dataTruck;
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
        if (result["Message"]["Code"] == 200) {
          List<dynamic> datares = result["Data"];
          List<dynamic> dataCarrier = [];
          for (int i = 0; i < datares.length; i++) {
            dataCarrier.add({
              'id': datares[i]['ID'],
              "name": datares[i]['Description'],
              "image": datares[i]['ImageCarrier'],
            });
          }
          _listCarrier = dataCarrier;
          _checkListWidgetInFilter(
              onDate: null,
              onCity: null,
              onDestinasi: null,
              onSwitch: null,
              onTruck: null,
              onUnit: null,
              onRadioButton: null,
              onCheckbox: null,
              onCarrier: (index) {
                _listVariable[index.toString()][_rawDataCarrier] = dataCarrier;
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

  Future _getProvince() async {
    var resultArea = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvince();
    List dataArea = resultArea["Data"];
    dataArea.forEach((element) {
      _listProvince[element["Code"].toString()] = element["Description"];
      //kota[element["ID"]] = element["Kota"];
    });
    if (resultArea != null) {
      Map<String, dynamic> copyData = {};
      int pos = 0;
      for (var entry in _listProvince.entries) {
        copyData[entry.key] = entry.value;
        pos++;
        if (pos == _maxDataWrapFilter) break;
      }
      // copyData = _getSortingByValue(copyData);
      // print("ini copy data provinsi");
      // print(copyData);
      _showPrint("_checkListWidgetInFilter: _getProvince");
      _checkListWidgetInFilter(
          onCity: null,
          onDestinasi: null,
          onDate: null,
          onCarrier: null,
          onSwitch: null,
          onTruck: null,
          onUnit: null,
          onRadioButton: null,
          onCheckbox: null,
          onName: null,
          onAreaPickupSearch: null,
          onAreaPickupTransporter: null,
          onProvince: (index) {
            _listVariable[index.toString()][_listNotChoosenKey]
                .addAll(copyData);
          });
      return true;
    }
    return false;
  }

  Map<String, dynamic> _getSortingByValue(Map<String, dynamic> data) {
    var sortedKeys = data.entries.toList(growable: false)
      ..sort((k1, k2) {
        return k1.value.compareTo(k2.value);
      });
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k.key, value: (k) => k.value);
    return Map<String, dynamic>.from(sortedMap);
    // return sortedKeys
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
              onDestinasi: null,
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
              onDestinasi: null,
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

  void _setRangeValueUnit(
      int indexListVariable, double start, double end, int index,
      {bool isUpdateRangeValues = true,
      bool isUpdateTextEditingController = true}) {
    //KHUSUS JUMLAH YANG MENGACU KE SATUAN TENDER
    if (indexListVariable.toString() == "2") {
      if (_listVariable["1"][_satuanTempKey].length == 0) {
        isUpdateRangeValues = false;
        isUpdateTextEditingController = false;
      }
    }
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
                .text =
            GlobalVariable.formatCurrencyDecimal(
                start.round().toInt().toString());
        _listVariable[index.toString()][_endUnitRangeTextEditingControllerKey]
                .text =
            GlobalVariable.formatCurrencyDecimal(
                end.round().toInt().toString());
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 10)),
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
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textTitle(title),
          SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _setFirstDateTimeTemp(
                        data,
                        listWidgetInFilter[indexListWidgetInFilter]
                            .typeInFilter,
                        _listVariable[indexListWidgetInFilter.toString()]
                            [_firstDefaultTextKey],
                        indexListWidgetInFilter);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 8,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 8,
                      left: GlobalVariable.ratioWidth(Get.context) * 7,
                      right: GlobalVariable.ratioWidth(Get.context) * 7,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: data[_errorMessageDateKey] != ""
                              ? Color(ListColor.colorRed)
                              : Color(ListColor.colorGrey6),
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10)),
                      // color: Color(ListColor.colorLightGrey3)
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: CustomText(
                              data[_firstDateTextKey],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: data[_firstDateTextKey] == _hintFirstDate
                                  ? Color(ListColor.colorLightGrey2)
                                  : Color(ListColor.colorLightGrey4),
                            ),
                          ),
                          SvgPicture.asset(
                            GlobalVariable.imagePath + "calendar_icon.svg",
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 19),
                child: CustomText(
                  "InfoPraTenderTransporterIndexLabelsd".tr,
                  fontSize: 12,
                  color: Color(ListColor.colorLightGrey4),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _setEndDateTimeTemp(
                        data,
                        listWidgetInFilter[indexListWidgetInFilter]
                            .typeInFilter,
                        _listVariable[indexListWidgetInFilter.toString()]
                            [_endDefaultTextKey],
                        indexListWidgetInFilter);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 8,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 8,
                      left: GlobalVariable.ratioWidth(Get.context) * 7,
                      right: GlobalVariable.ratioWidth(Get.context) * 7,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: data[_errorMessageDateKey] != ""
                              ? Color(ListColor.colorRed)
                              : Color(ListColor.colorGrey6),
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10)),
                      // color: Color(ListColor.colorLightGrey3)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CustomText(
                            data[_endDateTextKey],
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: data[_endDateTextKey] == _hintFirstDate
                                ? Color(ListColor.colorLightGrey2)
                                : Color(ListColor.colorLightGrey4),
                          ),
                        ),
                        SvgPicture.asset(
                          GlobalVariable.imagePath + "calendar_icon.svg",
                          color: Colors.black,
                        ),
                      ],
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
                        color: Color(ListColor.colorRed), fontSize: 12),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
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

  Widget _wrapLocationItemWidget(String title, int indexListVariable,
      {void Function() seeAll}) {
    Map<String, dynamic> mapData =
        Map<String, dynamic>.from(_listVariable[indexListVariable.toString()]);
    return _filterLocationWrap(title, seeAll, (isChoosen, key, value) {
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
                  width: GlobalVariable.ratioWidth(Get.context) * 42,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                  value: mapData[_switchTempKey],
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
    bool hideTitle = listWidgetInFilter[indexListVariable].hideTitle;
    List<Widget> listWidget = hideTitle
        ? []
        : [
            Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              child: _textTitle(label[0]),
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 10,
            ),
          ];
    int i = 0;
    for (RadioButtonFilterModel data in listRadioButton) {
      listWidget.add(
        // FlatButton(
        //   padding: EdgeInsets.zero,
        //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //   onPressed: () {
        //     _onChooseRadioButton(indexListVariable, data);
        //   },
        //   child: Row(
        //     mainAxisSize: MainAxisSize.max,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     // mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.only(
        //             left: GlobalVariable.ratioWidth(Get.context) * 5),
        //         child: Radio(
        //           toggleable: true,
        //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //           groupValue: mapData[_radioButtonTempKey],
        //           // groupValue: sortChoice.value,
        //           value: data.id,
        //           onChanged: (val) {
        //             _onChooseRadioButton(indexListVariable, data);
        //           },
        //         ),
        //       ),
        //       CustomText(data.value,
        //           fontSize: 14, color: Color(ListColor.colorLightGrey4)),
        //     ],
        //   ),
        // ),
        Container(
          padding: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * 16,
            bottom: i == listRadioButton.length - 1
                ? 0
                : GlobalVariable.ratioWidth(Get.context) * 13,
          ),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus.unfocus();
              _onChooseRadioButton(indexListVariable, data);
            },
            child: AbsorbPointer(
              child: RadioButtonCustomWithText(
                isWithShadow: true,
                toggleable: false,
                isDense: true,
                colorNotSelected: Colors.white,
                radioSize: GlobalVariable.ratioWidth(Get.context) * 14,
                groupValue: mapData[_radioButtonTempKey],
                value: data.id,
                onChanged: (str) {
                  FocusManager.instance.primaryFocus.unfocus();
                  _onChooseRadioButton(indexListVariable, data);
                },
                customTextWidget: Container(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 3),
                  child: CustomText(
                    data.value,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      i++;
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
      SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 5)
    ];
    listWidget.add(Column(children: [
      for (CheckboxFilterModel data in listcheckbox)
        Container(
            margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 13),
            child: GestureDetector(
                onTap: () {
                  if ((_listVariable[indexListVariable.toString()]
                          [_checkboxTempKey] as List)
                      .contains(data.id)) {
                    _onChooseCheckbox(indexListVariable, data, false);
                  } else {
                    _onChooseCheckbox(indexListVariable, data, true);
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => CheckBoxCustom(
                          size: 14,
                          paddingSize: 5,
                          shadowSize: 19,
                          isWithShadow: true,
                          borderColor: ListColor.colorBlue,
                          borderWidth: 1,
                          value: (_listVariable[indexListVariable.toString()]
                                  [_checkboxTempKey] as List)
                              .contains(data.id),
                          onChanged: (checked) {
                            _onChooseCheckbox(indexListVariable, data, checked);
                          },
                        )),
                    Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 9),
                    Expanded(
                        child: Container(
                            child: CustomText(data.value,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(ListColor.colorLightGrey14))))
                  ],
                ))
            // Theme(
            //   data: Theme.of(Get
            //           .context)
            //       .copyWith(
            //           unselectedWidgetColor:
            //               Color(ListColor.color4)),
            //   child: Obx(() =>
            //     CheckboxListTile(
            //       activeColor: Color(ListColor.color4),
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 2lobalVariable.ratioWidth(Get.context) * 2)),
            //       contentPadding: EdgeInsets.zero,
            //       controlAffinity: ListTileControlAffinity.leading,
            //       value: (_listVariable[indexListVariable.toString()][_checkboxTempKey] as List).contains(data.id),
            //       onChanged: (checked) {
            //         _onChooseCheckbox(indexListVariable, data, checked);
            //       },
            //       title: Text(data.value),
            //     ),
            //   ),
            // )
            ),
    ]));
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listWidget,
        ));
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

  Widget _unitWidget(List<String> label, int indexListVariable,
      {bool satuan = false}) {
    //_listVariable[indexListVariable.toString()][_rangeValuesTempKey];
    var enable = true;
    //KHUSUS JUMLAH YANG MENGACU KE SATUAN TENDER
    if (indexListVariable.toString() == "2") {
      if (_listVariable["1"][_satuanTempKey].length == 0) {
        enable = false;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 15),
          child: _textTitle(label[0]),
        ),
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
                      width: MediaQuery.of(Get.context).size.width -
                          (GlobalVariable.ratioWidth(Get.context) * 30),
                      color: Color(ListColor.colorLightGrey10)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            GlobalVariable.ratioWidth(Get.context) * 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: _textFieldUnitWidget((value) {
                            String isi = value.replaceAll('.', '');
                            _setRangeValueUnit(
                                indexListVariable,
                                double.parse(isi),
                                _listVariable[indexListVariable.toString()]
                                        [_rangeValuesTempKey]
                                    .end,
                                indexListVariable,
                                isUpdateTextEditingController: false);
                          },
                              indexListVariable,
                              _startUnitRangeTextEditingControllerKey,
                              listWidgetInFilter[indexListVariable]
                                  .customValue[1],
                              true),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 92,
                        ),
                        Expanded(
                          child: _textFieldUnitWidget((value) {
                            String isi = value.replaceAll('.', '');
                            _setRangeValueUnit(
                                indexListVariable,
                                _listVariable[indexListVariable.toString()]
                                        [_rangeValuesTempKey]
                                    .start,
                                double.parse(isi),
                                indexListVariable,
                                isUpdateTextEditingController: false);
                          },
                              indexListVariable,
                              _endUnitRangeTextEditingControllerKey,
                              listWidgetInFilter[indexListVariable]
                                  .customValue[1],
                              true),
                        )
                      ],
                    ),
                  ),
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 15),
                          child: CustomText(
                              _listVariable[indexListVariable.toString()]
                                  [_errorMessageUnitKey],
                              color: Color(ListColor.colorRed),
                              fontSize: 12),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 2),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Divider(
                    //   thickness: 2,
                    //   color: Color(ListColor.colorGrey),
                    // ),
                    Obx(() {
                      return SliderTheme(
                          data: SliderTheme.of(Get.context).copyWith(
                              // overlappingShapeStrokeColor:
                              //     const Color(0xFFDBE2EA),
                              trackHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 2,
                              activeTrackColor: enable
                                  ? Color(ListColor.colorBlue)
                                  : Color(ListColor.colorLightGrey12),
                              inactiveTrackColor: enable
                                  ? Color(ListColor.colorLightGrey4)
                                  : Color(ListColor.colorLightGrey12),
                              thumbColor: Color(ListColor.colorWhite),
                              // thumbColor: Color(ListColor.colorLightGrey7),
                              // overlayShape:
                              //     RoundSliderOverlayShape(overlayRadius: 1),
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 15.0,
                              )),
                          child: IgnorePointer(
                              ignoring: !enable,
                              child: RangeSlider(
                                  min: 0.0,
                                  max: satuan == true
                                      ? _listVariable[(indexListVariable - 1)
                                          .toString()]['max']
                                      : listWidgetInFilter[indexListVariable]
                                                  .customValue ==
                                              null
                                          ? _maxRangeValueUnit
                                          : listWidgetInFilter[
                                                  indexListVariable]
                                              .customValue[1],
                                  values: _listVariable[indexListVariable
                                      .toString()][_rangeValuesTempKey],
                                  onChanged: (values) {
                                    _setRangeValueUnit(
                                        indexListVariable,
                                        values.start,
                                        values.end,
                                        indexListVariable);
                                  })));
                    })
                  ],
                ),
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

  Widget _textFieldUnitWidget(
      void Function(String) onChangeText,
      int indexListVariable,
      String keyTextEditingController,
      double max,
      bool enable) {
    return CustomTextFormField(
        textInputAction: TextInputAction.done,
        enabled: indexListVariable.toString() ==
                "2" //KHUSUS JUMLAH YANG MENGACU KE SATUAN TENDER
            ? _listVariable["1"][_satuanTempKey].length > 0
            : true,
        controller: _listVariable[indexListVariable.toString()]
            [keyTextEditingController],
        context: Get.context,
        textSize: 12,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: indexListVariable.toString() ==
                    "2" // KHUSUS JUMLAH YANG MENGACU KE SATUAN TENDER
                ? _listVariable["1"][_satuanTempKey].length > 0
                    ? Color(ListColor.colorLightGrey4)
                    : Color(ListColor.colorLightGrey2)
                : Color(ListColor.colorLightGrey4)),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 7,
            vertical: GlobalVariable.ratioWidth(Get.context) * 9),
        newInputDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
              borderSide: BorderSide(color: Color(ListColor.colorGrey2))),
          // fillColor: indexListVariable.toString() ==
          //         "2" // KHUSUS JUMLAH YANG MENGACU KE SATUAN TENDER
          //     ? _listVariable["1"][_satuanTempKey].length > 0
          //         ? Colors.white
          //         : Color(ListColor.colorLightGrey12)
          // : Colors.white,
          fillColor: enable ? Colors.white : Color(ListColor.colorLightGrey12),
          isDense: true,
          isCollapsed: true,
          filled: true,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          // FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
          // FilteringTextInputFormatter.allow(RegExp(r'(^[0-9]*\,?[0-9]{0,2})')),
          DecimalInputFormatter(
            digit: 99,
            digitAfterComma: 0,
            controller: _listVariable[indexListVariable.toString()]
                [keyTextEditingController],
          ),
        ],
        onChanged: (value) {
          String isi = value.replaceAll('.', '').replaceAll(',', '.');
          if (double.parse(isi) > max) {
            isi = max.toString();
            _listVariable[indexListVariable.toString()]
                    [keyTextEditingController]
                .text = GlobalVariable.formatCurrencyDecimal(isi);
          }
          // OnChangeTextFieldNumber.checkNumber(
          //     () => _listVariable[indexListVariable.toString()]
          //         [keyTextEditingController],
          //     value.replaceAll(',', '').replaceAll('.', ''));

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
                    vertical: GlobalVariable.ratioWidth(Get.context) * 9),
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
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 6),
                  ),
                  hintText: "Cari Nama Transporter",
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey2),
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey7), width: 1.0),
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey7), width: 2.0),
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 6),
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
                    size: GlobalVariable.ratioWidth(Get.context) * 18)),
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
                            size: GlobalVariable.ratioWidth(Get.context) * 20,
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
    @required void Function(int) onLocation,
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
    @required void Function(int) onMuatan,
    @required void Function(int) onDiumumkanKepada,
    @required void Function(int) onUnitSatuan,
    @required void Function(int) onSatuan,
    @required void Function(int) onDestinasi,
    @required void Function(int) onCheckboxWithHide,
    @required void Function(int) onProvince,
    @required void Function(int) onVolume,
    @required void Function(int) onCapacity,
    @required void Function(int) onDimension,
  }) {
    print("checkListWidgetInFilter");
    for (int i = 0; i < listWidgetInFilter.length; i++) {
      if (listWidgetInFilter[i].typeInFilter == TypeInFilter.DATE ||
          listWidgetInFilter[i].typeInFilter == TypeInFilter.YEAR) {
        if (onDate != null) onDate(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.CITY) {
        if (onCity != null) onCity(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.LOCATION) {
        if (onLocation != null) onLocation(i);
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
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.MUATAN) {
        if (onMuatan != null) onMuatan(i);
      } else if (listWidgetInFilter[i].typeInFilter ==
          TypeInFilter.DIUMUMKANKEPADA) {
        if (onDiumumkanKepada != null) onDiumumkanKepada(i);
      } else if (listWidgetInFilter[i].typeInFilter ==
          TypeInFilter.UNIT_SATUAN) {
        if (onUnitSatuan != null) onUnitSatuan(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.SATUAN) {
        if (onSatuan != null) onSatuan(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.DESTINASI) {
        if (onDestinasi != null) onDestinasi(i);
      } else if (listWidgetInFilter[i].typeInFilter ==
          TypeInFilter.CHECKBOX_WITH_HIDE) {
        if (onCheckboxWithHide != null) onCheckboxWithHide(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.PROVINSI) {
        if (onProvince != null) onProvince(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.DIMENSION) {
        if (onDimension != null) onDimension(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.VOLUME) {
        if (onVolume != null) onVolume(i);
      } else if (listWidgetInFilter[i].typeInFilter == TypeInFilter.CAPACITY) {
        if (onCapacity != null) onCapacity(i);
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

class CustomTrackShape extends RoundedRectRangeSliderTrackShape {
  @override
  Rect getPreferredRect(
      {RenderBox parentBox,
      Offset offset = Offset.zero,
      SliderThemeData sliderTheme,
      bool isEnabled = false,
      bool isDiscrete = false}) {
    // TODO: implement getPreferredRect
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
