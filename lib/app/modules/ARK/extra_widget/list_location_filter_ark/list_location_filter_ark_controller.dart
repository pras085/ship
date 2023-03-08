import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/scroll_controller.dart';

class ListLocationFilterArkController extends GetxController {
  final listCity = {}.obs;
  final listChoosen = {}.obs;

  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  Map<String, dynamic> _listAllCityTemp = {};
  Map<String, dynamic> _listAllCityInitialPosTemp = {};
  Map<String, dynamic> _listAllCityInitialPos = {};
  String _searchValue = "";

  ScrollController scrollControllerChoosen = ScrollController();
  ScrollController scrollControllerCheckbox = ScrollController();

  var hidescroll = false.obs;
  var hintText = "".obs;
  var choosenLabelText = "".obs;

  @override
  void onInit() {
    listCity.addAll(_getSortingByValue(
        Map<String, dynamic>.from(jsonDecode(jsonEncode(Get.arguments[0])))));
    listChoosen.addAll(jsonDecode(jsonEncode(Get.arguments[1])));
    if (Get.arguments[2] != null)
      hintText.value = jsonDecode(jsonEncode(Get.arguments[2]));
    _listAllCityTemp.addAll(Map.from(listCity));
    _setListInitialsPos(Map.from(listCity));
    _listAllCityInitialPosTemp.addAll(_listAllCityInitialPos);
    if (Get.arguments[3] != null) choosenLabelText.value = Get.arguments[3];
    super.onInit();
  }

  Map<String, dynamic> _getSortingByValue(Map<String, dynamic> data) {
    var sortedKeys = data.entries.toList(growable: false)
      ..sort((k1, k2) {
        return k1.value.compareTo(k2.value);
      });
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k.key, value: (k) => k.value);
    return Map<String, dynamic>.from(sortedMap);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void addTextSearchCity(String value) {
    _searchValue = value;
    isShowClearSearch.value = _searchValue.isNotEmpty;
    if (_searchValue != "") {
      _searchCity();
    } else {
      _showAllCity();
    }
  }

  void onSubmitSearch() {
    _searchCity();
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearchCity("");
  }

  void onCheckCity(int index, bool value) {
    if (value) {
      listChoosen[listCity.keys.elementAt(index)] =
          listCity.values.elementAt(index);
      if (listChoosen.value.length > 1) {
        scrollControllerChoosen.animateTo(
            scrollControllerChoosen.position.maxScrollExtent + 54,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut);
        if (scrollControllerChoosen.positions.length >= 1) {
          hidescroll.value = false;
        }
      }
    } else {
      listChoosen
          .removeWhere((key, value) => key == listCity.keys.elementAt(index));
      if (scrollControllerChoosen.offset <= 0.0 &&
          scrollControllerChoosen.positions.length <= 1) {
        hidescroll.value = true;
      }
    }
    listChoosen.refresh();

    // _setListInitialsPos(Map.from(listCity));
  }

  void _searchCity() {
    listCity.clear();
    _listAllCityInitialPos.clear();
    Map<String, dynamic> listMap = {};
    for (var data in _listAllCityTemp.entries) {
      if (data.value.toLowerCase().contains(_searchValue.toLowerCase())) {
        listMap[data.key] = data.value;
        if (!_listAllCityInitialPos.containsKey(data.value[0]))
          _listAllCityInitialPos[data.value[0]] = data.key;
      }
    }

    // _setListInitialsPos(listMap);
    // Map<String, dynamic> listMap = Map.from(_listAllCityTemp)
    //   ..removeWhere((key, value) =>
    //       !value.toString().toLowerCase().contains(_searchValue.toLowerCase()));
    // _setListInitialsPos(listMap);
    listCity(listMap);
    listCity.refresh();
  }

  void _showAllCity() {
    listCity.clear();
    _listAllCityInitialPos.clear();
    _listAllCityInitialPos.addAll(_listAllCityInitialPosTemp);
    listCity(Map.from(_listAllCityTemp));
    listCity.refresh();
  }

  void onSubmit() {
    Get.back(result: listChoosen);
  }

  void _setListInitialsPos(Map<String, dynamic> data) {
    _listAllCityInitialPos.clear();
    data.entries.forEach((element) {
      if (!_listAllCityInitialPos.containsKey(element.value[0]))
        _listAllCityInitialPos[element.value[0]] = element.key;
    });
  }

  String getInitial(String key) {
    return _listAllCityInitialPos.keys.firstWhere(
        (element) => _listAllCityInitialPos[element] == key,
        orElse: () => "");
  }

  void resetAll() {
    listChoosen.clear();
    listCity.clear();
    listCity.addAll(_listAllCityTemp);
    listCity.refresh();
    _setListInitialsPos(_listAllCityTemp);
    searchTextEditingController.value.text = "";
  }

  int getListCityIndex(String keys) {
    int index = 0;
    for (int i = 0; i < listCity.length; i++) {
      if (listCity.keys.elementAt(i).toString() == keys) {
        index = i;
      }
    }
    return index;
  }

  Widget badgeChoosen(int index) {
    return Container(
      // height: GlobalVariable.ratioWidth(Get.context) * 19,
      decoration: BoxDecoration(
          color: Color(ListColor.colorLightGrey10),
          border: Border.all(color: Color(ListColor.colorLightGrey10)),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 4)),
      margin: EdgeInsets.only(
          right: GlobalVariable.ratioWidth(Get.context) * 6,
          bottom: GlobalVariable.ratioWidth(Get.context) * 10),
      // padding: EdgeInsets.fromLTRB(
      //     GlobalVariable.ratioWidth(Get.context) * 4,
      //     GlobalVariable.ratioWidth(Get.context) * 1,
      //     GlobalVariable.ratioWidth(Get.context) * 2,
      //     GlobalVariable.ratioWidth(Get.context) * 1),
      // constraints: BoxConstraints(maxWidth: 190),
      height: GlobalVariable.ratioWidth(Get.context) * 22,
      padding: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(Get.context) * 4,
        right: GlobalVariable.ratioWidth(Get.context) * 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: GlobalVariable.ratioWidth(Get.context) * 163),
            margin: EdgeInsets.only(
                right: GlobalVariable.ratioWidth(Get.context) * 7),
            child: CustomText(
              listChoosen.values
                  .elementAt(index)
                  .toString()
                  .replaceAll("", "\u{200B}"),
              color: Color(ListColor.colorLightGrey4),
              fontWeight: FontWeight.w500,
              fontSize: 12,
              height: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // SizedBox(
          //   width: GlobalVariable.ratioWidth(Get.context) * 7,
          // ),
          GestureDetector(
            child: SvgPicture.asset(GlobalVariable.imagePath + 'ic_close.svg',
                width: GlobalVariable.ratioWidth(Get.context) * 14,
                height: GlobalVariable.ratioWidth(Get.context) * 14,
                color: Color(ListColor.colorDarkGrey3)),
            onTap: () async {
              listChoosen.removeWhere(
                  (key, value) => key == listChoosen.keys.elementAt(index));
              if (scrollControllerChoosen.offset <= 0.0 &&
                  scrollControllerChoosen.positions.length <= 1) {
                hidescroll.value = true;
              }
            },
          ),
        ],
      ),
      // child: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Container(
      //       constraints: BoxConstraints(maxWidth: 163),
      //       child: CustomText(
      //         listChoosen.values.elementAt(index),
      //         color: Color(ListColor.colorLightGrey4),
      //         fontWeight: FontWeight.w500,
      //         fontSize: 12,
      //         overflow: TextOverflow.ellipsis,
      //       ),
      //     ),
      //     SizedBox(
      //       width: GlobalVariable.ratioWidth(Get.context) * 7,
      //     ),
      //     GestureDetector(
      //       child: SvgPicture.asset(GlobalVariable.imagePath+'ic_close.svg',
      //           width: GlobalVariable.ratioWidth(Get.context) * 14,
      //           height: GlobalVariable.ratioWidth(Get.context) * 14,
      //           color: Color(ListColor.colorDarkGrey3)),
      //       onTap: () async {
      //         listChoosen.removeWhere(
      //             (key, value) => key == listChoosen.keys.elementAt(index));
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
