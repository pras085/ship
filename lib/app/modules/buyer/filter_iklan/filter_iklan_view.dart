import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/template/dialog/dialog_buyer.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_view.dart';
import 'package:muatmuat/app/template/widgets/checkbox_buyer/checkbox_buyer.dart';
import 'package:muatmuat/app/template/widgets/dropdown_truck_carrier/dropdown_truck_carrier.dart';
import 'package:muatmuat/app/template/widgets/periode_picker/periode_picker_buyer.dart';
import 'package:muatmuat/app/template/widgets/range/range_buyer.dart';
import 'package:muatmuat/app/template/widgets/text_field/double_text_field.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';

import '../api_buyer.dart';
import '../rules_buyer.dart';
import '../selected_location_controller.dart';

class FilterIklanView extends StatefulWidget {
  @override
  _FilterIklanViewState createState() => _FilterIklanViewState();
}

class _FilterIklanViewState extends State<FilterIklanView> {

  // get location data, you do not dispose it from here.
  final locationController = Get.find<SelectedLocationController>();

  var argsData;
  Map filterArgs;
  var filter = {};
  List<Map> formFields;
  var dataModelResponse = ResponseState<List<Map>>();
  _TruckCarrierModel dataListTruckCarrier;
  List<String> dataListTruck = [];
  List<String> dataListCarrier = [];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args['filter'] != null && args['filter'] is Map) {
      filterArgs = args['filter'];
    }
    if (args['data'] != null) {
      argsData = args['data'];
    }
    formFields = RulesBuyer.getFilterDataBySubKategoriId("${args['ID']}");
    fetchDataFilterIklan();
  }

  void fetchDataFilterIklan({isRefresh = true}) async {
    try {
      if (isRefresh) { 
        setState(() {
          dataModelResponse = ResponseState.loading();
        });
      }
      
      final response =
          await ApiBuyer(context: Get.context).getFormByTagFrontend({
        'TagFrontEnd': jsonEncode(formFields.map((e) => e['tag_frontend']).toList()),
      });
      
      /// do fetch when [formFields] have a tag named [truckcarrierdropdowndouble]
      if (formFields.where((e) => "${e['tag_frontend']}".contains("truckcarrierdropdowndouble")).isNotEmpty) {
        final responseDataListTruckCarrier = await ApiBuyer(context: Get.context).getTransporterTruckList({});
        if (
          responseDataListTruckCarrier != null 
          && responseDataListTruckCarrier['Data'] != null
        ) {
          dataListTruckCarrier = _TruckCarrierModel.fromJson(responseDataListTruckCarrier['Data']);
          dataListTruck = dataListTruckCarrier.heads.map((e) => e.description).toList();
        } else throw("failed to fetch data!");
      }

      if (response != null) {
        if (response["Message"] != null && response["Message"]["Code"] == 200) {
          // sorting by field
          final responseList = (response["Data"]["boFormComponent"] as List);
          final tempList = List<Map>.from(responseList);
          final List<Map> result = [];
          for (var rules in formFields) {
            final List<Map> list = tempList.where((e) => e['tag_frontend'] == rules['tag_frontend']).toList();
            if (list.isNotEmpty) {
              final api = list.first;
              // update key
              api['key'] = rules['key'];
              api['property']['title'] = rules['title'];
              
              // double field case
              api['property']['group_by_title'] = rules['group_by_title'];
              api['property']['number_type'] = rules['number_type'];

              // adjust the value with supportingData 'max' from getData()
              if (rules['dynamic_min_key'] != null) {
                api['property']['min_value'] = rules['min_value'];
              }
              if (rules['dynamic_max_key'] != null) {
                api['property']['max_value'] = argsData[rules['dynamic_max_key']];
              }
              result.add(
                api,
              );
            } else {
              // add statically. adjust with the api version.
              final d = {
                'key': rules['key'],
                'tag_frontend': rules['tag_frontend'],
                'property': {
                  'title': rules['title'],
                  ...rules,
                },
              };
              // adjust the value with supportingData 'max' from getData()
              if (rules['dynamic_max_key'] != null && argsData is Map) {
                d['property']['max_value'] = argsData[rules['dynamic_max_key']];
              }
              result.add(d);
            }
          }
          // sukses
          if (kDebugMode) print("Result : $result");
          dataModelResponse = ResponseState.complete(result);
          // mapping data for filter
          for (var o in dataModelResponse.data) {
            // save filter data by it's 'key', all values are String.
            int tipe = 0;
            if (
              o['tag_frontend'].split("-").last == "radiofield" 
              || o['tag_frontend'].split("-").last == "smarttextfielddouble"
              || o['tag_frontend'].split("-").last == "truckcarrierdropdowndouble"
              || o['tag_frontend'].split("-").last == "periodepromofield"
              || o['tag_frontend'].split("-").last == "checkboxfretextfield"
            ) tipe = 1; // use for string
            else if (o['tag_frontend'].split("-").last == "checkboxfield") tipe = 3; // use for infinite list
            else if (o['tag_frontend'].split("-").last == "rangefield") tipe = 2; // use for list with max length 2
            filter.addAll({
              o['key']: {
                'tipe': tipe,
                // use for HUMAN CAPITAL | JOB SEEKER
                if (o['tag_frontend'].split("-").last == "checkboxfretextfield")
                  'isChecked': filterArgs != null ? filterArgs[o['key']] != null ? filterArgs[o['key']]['isChecked'] ?? false : false : false,
                // INIT TEXTEDITING CONTROLLER TO Create initial value
                if (o['tag_frontend'].split("-").last == "checkboxfretextfield")
                  'textController': TextEditingController(text: "${filterArgs != null ? filterArgs[o['key']] != null ? filterArgs[o['key']]['value'] ?? '' : '' : ''}"),
                if (tipe == 1) // use for string
                  'value': filterArgs != null ? filterArgs[o['key']] != null ? filterArgs[o['key']]['value'] : null : null
                else if (tipe == 3) // use for infinite list
                  'value': filterArgs != null ? filterArgs[o['key']] != null && (filterArgs[o['key']]['value'] is List && (filterArgs[o['key']]['value'] as List).isNotEmpty) ? filterArgs[o['key']]['value'] ?? [] : [] : []
                else if (tipe == 2) // use for list with max length 2
                  'value': filterArgs != null ? filterArgs[o['key']] != null && (filterArgs[o['key']]['value'] is List && (filterArgs[o['key']]['value'] as List).isNotEmpty) ? filterArgs[o['key']]['value'] ?? [] : [] : []
                else 'value': null,
              },
            });
          }
          setState(() {});
        } else {
          // error
          if (response["Message"] != null &&
              response["Message"]["Text"] != null) {
            throw ("${response["Message"]["Text"]}");
          }
          throw ("failed to fetch data!");
        }
      } else {
        // error
        throw ("failed to fetch data!");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataModelResponse = ResponseState.error("$error");
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String jumlahFilter = "0";
    if (filter != null) {
      final jumlah = filter.entries.where((el) {
        if (el.value['value'] != null) {
          if (el.value['value'] is List && (el.value['value'] as List).isNotEmpty) {
            return true;
          } else {
            if (
              el.value['value'] is String 
              && (
                (el.value['value'] as String).isNotEmpty
                || "${el.value['value']}" != "0"
              )
            ) return true;
            return false;
          }
        }
        return false;
      }).length;
      jumlahFilter = "$jumlah";
    }
    return Scaffold(
      appBar: AppBarDetailBuyer(
        title: "Filter",
        isWithPrefix: false,
        onClickBack: Get.back,
      ),
      body: Builder(
        builder: (ctx) {
          if (dataModelResponse.state == ResponseStates.COMPLETE) {
            // all data
            final data = dataModelResponse.data;
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(context) * 20,
                horizontal: GlobalVariable.ratioWidth(context) * 16,
              ),
              itemCount: data.length,
              separatorBuilder: (_, i) {
                // here is the exceptional divider. usually use for double field
                if (
                  (
                    data[i]['tag_frontend'].split("-").last == "truckcarrierdropdowndouble"
                    || data[i]['tag_frontend'].split("-").last == "smarttextfielddouble" 
                    || data[i]['tag_frontend'].split("-").last == "periodepromofield" 
                  )
                  // find the last index of group by title. thanks to andy for the idea.
                  && i == data.indexWhere((e) => e['property']['group_by_title'] == data[i]['property']['group_by_title'])
                ) {
                  return SizedBox.shrink();
                }

                if (
                  (
                    data[i]['tag_frontend'].split("-").last == "rangefield"
                    || data[i]['tag_frontend'].split("-").last == "checkboxfretextfield"
                  ) 
                  && data[i]['property']['header'] != null
                  && i != data.indexWhere((e) => e['property']['header'] == data[i]['property']['header'])
                ) {
                  return SizedBox.shrink();
                }

                return _divider();
              },
              itemBuilder: (ctx, i) {
                if (data[i]['tag_frontend'].split("-").last == "radiofield") {
                  print("RUNNN: " + data[i]['property'].toString());
                  print("RUNNN: " + data[i]['property']['title']);
                  return SortingTileDialogBuyer(
                    context: context,
                    // label: "${data[i]['property']['title']}".capitalize,
                    label: "${data[i]['property']['title']}",
                    childCount:
                        ("${data[i]['property']['value']}".split(",")).length,
                    childBuilder: (_, idx) {
                      // Start to render the view for radio button and its label.
                      final o = ("${data[i]['property']['value']}".split(",").map((e) => e.trim()).toList())[idx];
                      final oAlias = data[i]['property']['value_alias'] != null ? ("${data[i]['property']['value_alias']}".split(",").map((e) => e.trim()).toList())[idx] : null;
                      return SortingTileContentDialogBuyer(
                        context: context,
                        // kondisi_kendaraan is from key.
                        groupValue: filter[data[i]['key']]['value'], // newest value, change this with your variable
                        // combination
                        value: o, // default value for each radio button.
                        // text: oAlias ?? o.capitalize, // label for the item.
                        text: oAlias ?? o, // label for the item.
                        onTap: () {
                          filter[data[i]['key']]['value'] = o;
                          setState(() {});
                        },
                      );
                    },
                  );
                } else if (data[i]['tag_frontend'].split("-").last == "lokasifield") {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              "Lokasi",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              withoutExtraPadding: true,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final res = await Get.to(SelectLocationBuyerView());
                              if (res != null && res is SelectLocationBuyerModel) {
                                locationController.location.value = res;
                              } else if (res != null && res is int) {
                                locationController.location.value = null;
                              }
                            },
                            child: CustomText(
                              "Ubah Lokasi",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              withoutExtraPadding: true,
                              textAlign: TextAlign.end,
                              color: Color(ListColor.colorBlueTemplate1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 12,
                      ),
                      Obx(() => CustomText(
                        locationController.location.value != null ? locationController.location.value.description : "Indonesia",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorGreyTemplate3),
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  );
                } else if (data[i]['tag_frontend'].split("-").last == "checkboxfield") {
                  return CheckboxBuyer(
                    // title: "${data[i]['property']['title']}".capitalize,
                    title: "${data[i]['property']['title']}",
                    listCheckbox: !"${data[i]['property']['value']}".contains(",,") ? "${data[i]['property']['value']}".split(",").map((e) => e.trim()).toList() : "${data[i]['property']['value']}".split(",,").map((e) => e.trim()).toList(),
                    listAliasCheckbox: data[i]['property']['value_alias'] != null ? "${data[i]['property']['value_alias']}".split(",").map((e) => e.trim()).toList() : null,
                    selectedListCheckbox: filter[data[i]['key']]['value'] ?? [],
                    onCheckboxTap: (value) {
                      final selectedListC = filter[data[i]['key']]['value'] ?? [];
                      // check if the value is already checked or not.
                      if (!selectedListC.contains(value)) {
                        if (selectedListC.contains(''))
                          selectedListC.clear();
                        selectedListC.add(value);
                        filter[data[i]['key']]['value'] = selectedListC;
                      } else {
                        selectedListC.remove(value);
                        filter[data[i]['key']]['value'] = selectedListC;
                      }
                      setState(() {});
                    },
                    onUpdate: (values) {
                      // update the list, right after back from checkbox page.
                      filter[data[i]['key']]['value'] = values;
                      setState(() {});
                    },
                  );
                } else if (data[i]['tag_frontend'].split("-").last == "rangefield" && data[i]['property']['header'] == null) {
                  double interval = (double.parse("${data[i]['property']['max_value']}")-double.parse("${data[i]['property']['min_value']}"));
                  int divisions = (interval/10).round();
                  return RangeBuyer(
                    // title: "${data[i]['property']['title']}".capitalize,
                    title: "${data[i]['property']['title']}",
                    start: filter[data[i]['key']]['value'] is List && (filter[data[i]['key']]['value'] as List).length > 1 ? filter[data[i]['key']]['value'][0] ?? "${data[i]['property']['min_value']}" : "${data[i]['property']['min_value']}",
                    end: filter[data[i]['key']]['value'] is List && (filter[data[i]['key']]['value'] as List).length > 1 ? filter[data[i]['key']]['value'][1] ?? "${data[i]['property']['max_value']}" : "${data[i]['property']['max_value']}",
                    minValue: double.parse("${data[i]['property']['min_value']}"),
                    maxValue: double.parse("${data[i]['property']['max_value']}"),
                    divisions: divisions < 10 ? interval.toInt() : divisions,
                    numberType: data[i]['property']['number_type'],
                    onChange: (values) {
                      // reset jika value sama dengan min dan max
                      if (
                        "${values.start.round()}" == "${data[i]['property']['min_value']}" 
                        && "${values.end.round()}" == "${data[i]['property']['max_value']}"
                      ) {
                        filter[data[i]['key']]['value'] = [];
                      } else {
                        filter[data[i]['key']]['value'] = [
                          "${values.start.round()}",
                          "${values.end.round()}",
                        ];
                      }
                      setState(() {});
                    },
                  );
                } 
                else if (
                  data[i]['tag_frontend'].split("-").last == "rangefield" 
                  && data[i]['property']['header'] != null
                  && i == data.indexWhere((e) => e['property']['header'] == data[i]['property']['header'])
                ) {
                  final fields = data.where((e) {
                    return e['property']['header'] == data[i]['property']['header'];
                  }).toList();

                  final List<Widget> widgets = [];

                  for (var j = 0; j < fields.length; j++) {
                    int index = data.indexOf(fields[j]);
                    double interval = (double.parse("${data[index]['property']['max_value']}")-double.parse("${data[index]['property']['min_value']}"));
                    int divisions = (interval/10).round();

                    widgets.add(Padding(
                      padding: EdgeInsets.only(
                        bottom: GlobalVariable.ratioWidth(context) * (j == fields.length - 1 ? 0 : 20)
                      ),
                      child: RangeBuyer(
                        title: "${data[index]['property']['title']}".capitalize,
                        start: filter[data[index]['key']]['value'] is List && (filter[data[index]['key']]['value'] as List).length > 1 ? filter[data[index]['key']]['value'][0] ?? "${data[index]['property']['min_value']}" : "${data[index]['property']['min_value']}",
                        end: filter[data[index]['key']]['value'] is List && (filter[data[index]['key']]['value'] as List).length > 1 ? filter[data[index]['key']]['value'][1] ?? "${data[index]['property']['max_value']}" : "${data[index]['property']['max_value']}",
                        minValue: double.parse("${data[index]['property']['min_value']}"),
                        maxValue: double.parse("${data[index]['property']['max_value']}"),
                        divisions: divisions < 10 ? interval.toInt() : divisions,
                        numberType: data[index]['property']['number_type'],
                        fontWeight: FontWeight.w500,
                        onChange: (values) {
                          filter[data[index]['key']]['value'] = [
                            "${values.start.round()}",
                            "${values.end.round()}",
                          ];
                          setState(() {});
                        },
                      ),
                    ));
                  }
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data[i]['property']['header'],
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.2,
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                      ...widgets
                    ],
                  );
                }
                else if (
                  data[i]['tag_frontend'].split("-").last == "checkboxfretextfield" 
                  && data[i]['property']['header'] != null
                  && i == data.indexWhere((e) => e['property']['header'] == data[i]['property']['header'])
                ) {
                  final fields = data.where((e) {
                    return e['property']['header'] == data[i]['property']['header'];
                  }).toList();

                  final List<Widget> widgets = [];

                  for (var j = 0; j < fields.length; j++) {
                    int index = data.indexOf(fields[j]);

                    widgets.add(Padding(
                      padding: EdgeInsets.only(
                        bottom: GlobalVariable.ratioWidth(context) * (j == fields.length - 1 ? 0 : 20)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckBoxCustom(
                            border: 1,
                            size: 20,
                            isWithShadow: true,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingRight: 0,
                            paddingBottom: 0,
                            value: filter[data[index]['key']]['isChecked'] ?? false, 
                            onChanged: (val) {
                              filter[data[index]['key']]['isChecked'] = !(filter[data[index]['key']]['isChecked'] ?? false);
                              setState(() {});
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(" ${data[index]['property']['title']}",
                                  withoutExtraPadding: true,
                                  height: 1.4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF676767),
                                ),
                                SizedBox(
                                  height: GlobalVariable.ratioWidth(context) * 10,
                                ),
                                Container(
                                  height: GlobalVariable.ratioWidth(context) * 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
                                    border: Border.all(
                                      width: GlobalVariable.ratioWidth(context) * 1,
                                      color: Color(filter[data[index]['key']]['isChecked'] ? 0xFF176CF7 : 0xFF868686),
                                    ),
                                    color: Color(filter[data[index]['key']]['isChecked'] ? 0xFFFFFFFF : 0xFFD7D7D7),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: GlobalVariable.ratioWidth(context) * 12,
                                  ),
                                  child: Center(
                                    child: TextField(
                                      controller: filter[data[index]['key']]['textController'],
                                      decoration: new InputDecoration.collapsed(
                                        hintText: '${data[index]['property']['hint']}',
                                        hintStyle: TextStyle(
                                          fontFamily: 'AvenirNext', 
                                          color: Color(0xFF868686),
                                          fontWeight: FontWeight.w500, 
                                          fontSize: GlobalVariable.ratioWidth(context) * 12,
                                          height: 14.4/(GlobalVariable.ratioWidth(context) * 12),
                                        ),
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(100),
                                      ],
                                      style: TextStyle(
                                        fontFamily: 'AvenirNext', 
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500, 
                                        fontSize: GlobalVariable.ratioWidth(context) * 12,
                                        height: 14.4/(GlobalVariable.ratioWidth(context) * 12),
                                      ),
                                      onChanged: (String str) async {
                                        filter[data[index]['key']]['value'] = str;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
                  }
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data[i]['property']['header'],
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.2,
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                      ...widgets
                    ],
                  );
                }
                else if (
                  data[i]['tag_frontend'].split("-").last == "smarttextfielddouble" 
                  // find the last index of group by title. thanks to andy for the idea.
                  && i == data.lastIndexWhere((e) => e['property']['group_by_title'] == data[i]['property']['group_by_title'])
                ) {
                  // Posisi Widget DoubleTextField ada pada index terakhir dari tag_frontend smarttextfielddouble
                  // Kemudian mendapatkan semua yang tag_frontendnya smarttextfielddouble
                  final smartTextFieldDouble = data.where((e) {
                    return e['property']['group_by_title'] == data[i]['property']['group_by_title'];
                  }).toList();

                  // Melakukan pengecekan jika ada 2 data dengan tag_frontend smarttextdouble, jika ada lebih dari 2 yang diambil hanya data pertama dan kedua.
                  if (smartTextFieldDouble.length > 1) {
                    // find the real index from data
                    final findIdx0 = data.indexWhere((e) => e['key'] == smartTextFieldDouble[0]['key']);
                    final findIdx1 = data.indexWhere((e) => e['key'] == smartTextFieldDouble[1]['key']);
                    return DoubleTextField(
                      groupTitle: data  [i]['property']['group_by_title'],
                      editTextProperty1: EditTextProperty(
                        title: smartTextFieldDouble[0]['property']['title'],
                        hintText: filter[data[findIdx0]['key']]['value'] ?? "0",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          filter[data[findIdx0]['key']]['value'] = value;
                          setState(() {});
                        }
                      ),
                      editTextProperty2: EditTextProperty(
                        title: smartTextFieldDouble[1]['property']['title'],
                        hintText: filter[data[findIdx1]['key']]['value'] ?? "0",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          filter[data[findIdx1]['key']]['value'] = value;
                          setState(() {});
                        }
                      ),
                    );
                  }
                }
                else if (
                  data[i]['tag_frontend'].split("-").last == "truckcarrierdropdowndouble" 
                  // find the last index of group by title. thanks to andy for the idea.
                  && i == data.lastIndexWhere((e) => e['property']['group_by_title'] == data[i]['property']['group_by_title'])
                ) {
                  
                  // get all data group by title.
                  // on this circumstance, we can savely call previous data.
                  // thanks to the method lastIndexWhere.
                  List<Map> dataTruckCarrier = data.where((e) {
                    return e['property']['group_by_title'] == data[i]['property']['group_by_title'];
                  }).toList();

                  if (dataTruckCarrier.length > 1) {
                    // find the real index from data
                    final findIdx0 = data.indexWhere((el) => el['key'] == dataTruckCarrier[0]['key']);
                    final findIdx1 = data.indexWhere((el) => el['key'] == dataTruckCarrier[1]['key']);
                    return DropdownTruckCarrierBuyer(
                      title: data[i]['property']['group_by_title'], 
                      valueTruck: filter[data[findIdx0]['key']]['value'], 
                      valueCarrier: filter[data[findIdx1]['key']]['value'], 
                      onSelectedTruck: (value) {
                        filter[data[findIdx0]['key']]['value'] = value;
                        dataListCarrier = dataListTruckCarrier.carrierWithTrucks.where((e) => e.headDescription == value).map((e) => e.description).toList();
                        setState(() {});
                      }, 
                      onSelectedCarrier: (value) {
                        filter[data[findIdx1]['key']]['value'] = value;
                        setState(() {});
                      }, 
                      dataListTruck: dataListTruck, 
                      dataListCarrier: dataListCarrier,
                    );
                  }
                }
                else if (
                  data[i]['tag_frontend'].split("-").last == "periodepromofield" 
                  // find the last index of group by title. thanks to andy for the idea.
                  && i == data.lastIndexWhere((e) => e['property']['group_by_title'] == data[i]['property']['group_by_title'])
                ) {
                  
                  // get all data group by title.
                  // on this circumstance, we can savely call previous data.
                  // thanks to the method lastIndexWhere.
                  List<Map> periode = data.where((e) {
                    return e['property']['group_by_title'] == data[i]['property']['group_by_title'];
                  }).toList();

                  if (periode.length > 1) {
                    // find the real index from data
                    final findIdx0 = data.indexWhere((el) => el['key'] == periode[0]['key']);
                    final findIdx1 = data.indexWhere((el) => el['key'] == periode[1]['key']);
                    return PeriodePickerBuyer(
                      title: data[i]['property']['group_by_title'], 
                      startValue: filter[data[findIdx0]['key']]['value'], 
                      endValue: filter[data[findIdx1]['key']]['value'], 
                      onStartSubmitted: (value) {
                        filter[data[findIdx0]['key']]['value'] = value;
                        setState(() {});
                      },
                      onEndSubmitted: (value) {
                        filter[data[findIdx1]['key']]['value'] = value;
                        setState(() {});
                      }, 
                    );
                  }
                }
                return Container();
              },
            );
          } else if (dataModelResponse.state == ResponseStates.ERROR) {
            return ErrorDisplayComponent(
              "${dataModelResponse.exception}",
              onRefresh: () => fetchDataFilterIklan(),
            );
          }
          return LoadingComponent();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
            topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, GlobalVariable.ratioWidth(context) * -3),
              blurRadius: GlobalVariable.ratioWidth(context) * 55,
              color: Colors.black.withOpacity(0.16),
            ),
          ],
        ),
        height: GlobalVariable.ratioWidth(context) * 56,
        padding: EdgeInsets.symmetric(
          vertical: GlobalVariable.ratioWidth(context) * 12,
          horizontal: GlobalVariable.ratioWidth(context) * 16,
        ),
        child: Row(
          children: [
            _button(
              context: context,
              width: 160,
              height: 32,
              text: "Reset",
              // add check, disable it if only user doesn't select the filter and
              // initial value was null (history before)
              onTap: (filterArgs == null || (filterArgs != null && filterArgs.isEmpty)) && jumlahFilter == "0" ? null : () {
                Get.back(
                  result: {},
                );
              },
              color: (filterArgs == null || (filterArgs != null && filterArgs.isEmpty)) && jumlahFilter == "0" ? Color(0xFF676767) : Color(ListColor.colorBlueTemplate1),
              borderColor: (filterArgs == null || (filterArgs != null && filterArgs.isEmpty)) && jumlahFilter == "0" ? Color(0xFFC6CBD4) : Color(ListColor.colorBlueTemplate1),
              backgroundColor: Colors.white,
              borderSize: 1.5,
              borderRadius: 26,
              useBorder: true,
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(context) * 8,
            ),
            _button(
              context: context,
              // add check, disable it if only user doesn't select the filter and
              // initial value was null (history before)
              onTap: (filterArgs == null || (filterArgs != null && filterArgs.isEmpty)) && jumlahFilter == "0" ? null : () {
                for (var a in filter.keys.toList()) {
                  (filter[a] as Map).remove('textController');
                }
                // reset if the user want to unselect all after use the filter
                if (filterArgs != null && filterArgs.isNotEmpty && jumlahFilter == "0") {
                  Get.back(
                    result: {},
                  );
                } else {
                  Get.back(
                    result: filter,
                  );
                }
              },
              width: 160,
              height: 32,
              text: "Terapkan",
              // add check, disable it if only user doesn't select the filter and
              // initial value was null (history before)
              color: (filterArgs == null || (filterArgs != null && filterArgs.isEmpty)) && jumlahFilter == "0" ? Color(0xFF676767) : Colors.white,
              backgroundColor: (filterArgs == null || (filterArgs != null && filterArgs.isEmpty)) && jumlahFilter == "0" ? Color(0xFFCECECE) : Color(ListColor.colorBlueTemplate1),
              borderRadius: 26,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 0.5,
      margin: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 20,
      ),
      color: Color(ListColor.colorGreyTemplate2),
    );
  }

  // PRIVATE CUSTOM BUTTON 
  Widget _button({
    @required BuildContext context,
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * marginLeft,
        GlobalVariable.ratioWidth(context) * marginTop,
        GlobalVariable.ratioWidth(context) * marginRight,
        GlobalVariable.ratioWidth(context) * marginBottom
      ),
      width: width == null ? maxWidth ? MediaQuery.of(context).size.width : null : GlobalVariable.ratioWidth(context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(context) * height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: useShadow
          ? <BoxShadow>[
              BoxShadow(
                color: Color(ListColor.shadowColor).withOpacity(0.08),
                blurRadius: GlobalVariable.ratioWidth(context) * 4,
                spreadRadius: 0,
                offset:
                    Offset(0, GlobalVariable.ratioWidth(context) * 2),
              ),
            ]
          : null,
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius),
        border: useBorder
          ? Border.all(
              width: GlobalVariable.ratioWidth(context) * borderSize,
              color: borderColor ?? Color(ListColor.colorBlue),
            )
          : null
      ),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius),
          ),
          onTap: () {
            onTap();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * paddingLeft,
              GlobalVariable.ratioWidth(context) * paddingTop,
              GlobalVariable.ratioWidth(context) * paddingRight,
              GlobalVariable.ratioWidth(context) * paddingBottom
            ),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            child: customWidget == null
              ? CustomText(
                  text ?? "",
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                )
              : customWidget,
          )
        ),
      ),
    );
  }
}

class _TruckCarrierModel {
  String message;
  List<_TruckList> truckList;
  List<_CarrierWithTrucks> carrierWithTrucks;
  List<_Heads> heads;
  List<_Carriers> carriers;

  _TruckCarrierModel(
      {this.message,
      this.truckList,
      this.carrierWithTrucks,
      this.heads,
      this.carriers});

  _TruckCarrierModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['TruckList'] != null) {
      truckList = new List<_TruckList>();
      json['TruckList'].forEach((v) {
        truckList.add(new _TruckList.fromJson(v));
      });
    }
    if (json['CarrierWithTrucks'] != null) {
      carrierWithTrucks = new List<_CarrierWithTrucks>();
      json['CarrierWithTrucks'].forEach((v) {
        carrierWithTrucks.add(new _CarrierWithTrucks.fromJson(v));
      });
    }
    if (json['Heads'] != null) {
      heads = new List<_Heads>();
      json['Heads'].forEach((v) {
        heads.add(new _Heads.fromJson(v));
      });
    }
    if (json['Carriers'] != null) {
      carriers = new List<_Carriers>();
      json['Carriers'].forEach((v) {
        carriers.add(new _Carriers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    if (this.truckList != null) {
      data['TruckList'] = this.truckList.map((v) => v.toJson()).toList();
    }
    if (this.carrierWithTrucks != null) {
      data['CarrierWithTrucks'] =
          this.carrierWithTrucks.map((v) => v.toJson()).toList();
    }
    if (this.heads != null) {
      data['Heads'] = this.heads.map((v) => v.toJson()).toList();
    }
    if (this.carriers != null) {
      data['Carriers'] = this.carriers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _TruckList {
  num iD;
  num qty;
  num headID;
  num carrierID;
  num capacityMin;
  num capacityMax;
  String capacityMeasure;
  num p;
  num l;
  num t;
  String dimensionMeasure;
  num fileID;
  String pictureName;
  String picturePath;
  String headTxt;
  String carrierTxt;
  String capacityTxt;
  String dimensionTxt;

  _TruckList(
      {this.iD,
      this.qty,
      this.headID,
      this.carrierID,
      this.capacityMin,
      this.capacityMax,
      this.capacityMeasure,
      this.p,
      this.l,
      this.t,
      this.dimensionMeasure,
      this.fileID,
      this.pictureName,
      this.picturePath,
      this.headTxt,
      this.carrierTxt,
      this.capacityTxt,
      this.dimensionTxt});

  _TruckList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    qty = json['Qty'];
    headID = json['HeadID'];
    carrierID = json['CarrierID'];
    capacityMin = json['CapacityMin'];
    capacityMax = json['CapacityMax'];
    capacityMeasure = json['CapacityMeasure'];
    p = json['P'];
    l = json['L'];
    t = json['T'];
    dimensionMeasure = json['DimensionMeasure'];
    fileID = json['FileID'];
    pictureName = json['PictureName'];
    picturePath = json['PicturePath'];
    headTxt = json['HeadTxt'];
    carrierTxt = json['CarrierTxt'];
    capacityTxt = json['CapacityTxt'];
    dimensionTxt = json['DimensionTxt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Qty'] = this.qty;
    data['HeadID'] = this.headID;
    data['CarrierID'] = this.carrierID;
    data['CapacityMin'] = this.capacityMin;
    data['CapacityMax'] = this.capacityMax;
    data['CapacityMeasure'] = this.capacityMeasure;
    data['P'] = this.p;
    data['L'] = this.l;
    data['T'] = this.t;
    data['DimensionMeasure'] = this.dimensionMeasure;
    data['FileID'] = this.fileID;
    data['PictureName'] = this.pictureName;
    data['PicturePath'] = this.picturePath;
    data['HeadTxt'] = this.headTxt;
    data['CarrierTxt'] = this.carrierTxt;
    data['CapacityTxt'] = this.capacityTxt;
    data['DimensionTxt'] = this.dimensionTxt;
    return data;
  }
}

class _CarrierWithTrucks {
  num iD;
  String description;
  num imageCarrierID;
  num length;
  num width;
  num height;
  num volume;
  num headID;
  String headDescription;

  _CarrierWithTrucks({
    this.iD,
    this.description,
    this.imageCarrierID,
    this.length,
    this.width,
    this.height,
    this.volume,
    this.headID,
    this.headDescription,
  });

  _CarrierWithTrucks.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    description = json['Description'];
    imageCarrierID = json['ImageCarrierID'];
    length = json['Length'];
    width = json['Width'];
    height = json['Height'];
    volume = json['Volume'];
    headID = json['HeadID'];
    headDescription = json['HeadDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Description'] = this.description;
    data['ImageCarrierID'] = this.imageCarrierID;
    data['Length'] = this.length;
    data['Width'] = this.width;
    data['Height'] = this.height;
    data['Volume'] = this.volume;
    data['HeadID'] = this.headID;
    data['HeadDescription'] = this.headDescription;
    return data;
  }
}

class _Heads {
  num iD;
  String description;
  num imageHeadID;

  _Heads({this.iD, this.description, this.imageHeadID});

  _Heads.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    description = json['Description'];
    imageHeadID = json['ImageHeadID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Description'] = this.description;
    data['ImageHeadID'] = this.imageHeadID;
    return data;
  }
}

class _Carriers {
  num iD;
  String description;
  num imageCarrierID;
  num length;
  num width;
  num height;
  num volume;

  _Carriers(
      {this.iD,
      this.description,
      this.imageCarrierID,
      this.length,
      this.width,
      this.height,
      this.volume});

  _Carriers.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    description = json['Description'];
    imageCarrierID = json['ImageCarrierID'];
    length = json['Length'];
    width = json['Width'];
    height = json['Height'];
    volume = json['Volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Description'] = this.description;
    data['ImageCarrierID'] = this.imageCarrierID;
    data['Length'] = this.length;
    data['Width'] = this.width;
    data['Height'] = this.height;
    data['Volume'] = this.volume;
    return data;
  }
}
