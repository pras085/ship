import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListTransporterNotifController extends GetxController {
  final listDiumumkan = [].obs;
  final listChoosen = [].obs;
  var expandParent = {}.obs;

  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  var listDiumumkanTemp = [].obs;
  String _searchValue = "";

  var hintText = "".obs;
  var labelText = "".obs;
  ScrollController scrollControllerChoosen = ScrollController();
  ScrollController scrollControllerCheckbox = ScrollController();
  var hidescroll = false.obs;

  @override
  void onInit() {
    listDiumumkan.value = jsonDecode(jsonEncode(Get.arguments[0]));
    listDiumumkanTemp.value = jsonDecode(jsonEncode(Get.arguments[0]));
    hintText.value = Get.arguments[1];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    listChoosen.clear();
    listDiumumkanTemp.clear();
  }

  void addTextSearchDiumumkan(String value) {
    _searchValue = value;
    isShowClearSearch.value = _searchValue.isNotEmpty;
    if (_searchValue != "") {
      _searchDiumumkan();
    } else {
      _showAllDiumumkan();
    }
  }

  void onSubmitSearch() {
    _searchDiumumkan();
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearchDiumumkan("");
  }

  void onCheckDiumumkan(data) {
    // print(data);
    Get.back(result: data);
  }

  void _searchDiumumkan() {
    listDiumumkanTemp.clear();
    String query = searchTextEditingController.value.text.toLowerCase();

    var tempResult = new List.from(listDiumumkan.value.where((data) {
      final nama = data['nama'].toString().toLowerCase();
      return nama.contains(query);
    }).toList());
    listDiumumkanTemp.value = tempResult;
    listDiumumkanTemp.refresh();
  }

  void _showAllDiumumkan() {
    listDiumumkanTemp.clear();
    listDiumumkanTemp.value = jsonDecode(jsonEncode(listDiumumkan.value));
    listDiumumkan.refresh();
  }

  void onSubmit() {
    Get.back(result: listChoosen);
  }

  void onReset() {
    listChoosen.clear();
  }

  void _setListInitialsPos(Map<String, dynamic> data) {}

  String getInitial(String key) {}

  void resetAll() {
    listChoosen.clear();
    listDiumumkanTemp.clear();
    listDiumumkanTemp.value = jsonDecode(jsonEncode(listDiumumkan.value));
    listDiumumkanTemp.refresh();
    searchTextEditingController.value.text = "";
  }

  Widget badgeChoosen(value) {
    return Container(
      // height: GlobalVariable.ratioWidth(Get.context) * 18,
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
            child: CustomText(
              value.toString().replaceAll("", "\u{200B}"),
              color: Color(ListColor.colorLightGrey4),
              fontWeight: FontWeight.w500,
              fontSize: 12,
              height: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: GlobalVariable.ratioWidth(Get.context) * 7,
          ),
          GestureDetector(
            child: SvgPicture.asset(GlobalVariable.imagePath + 'ic_close.svg',
                width: GlobalVariable.ratioWidth(Get.context) * 14,
                height: GlobalVariable.ratioWidth(Get.context) * 14,
                color: Color(ListColor.colorDarkGrey3)),
            onTap: () async {
              listChoosen.remove(value);
              if (scrollControllerChoosen.offset <= 0.0 &&
                  scrollControllerChoosen.positions.length <= 1) {
                hidescroll.value = true;
              }
            },
          ),
        ],
      ),
    );
  }

  bool isChoosenInListTemp(String nama) {
    bool check = false;
    for (int i = 0; i < listDiumumkanTemp.length; i++) {
      if (listDiumumkanTemp[i]['nama'] == nama) {
        check = true;
      }
    }
    return check;
  }

  int getIndexList(String nama) {
    int index = 0;
    for (int i = 0; i < listDiumumkan.length; i++) {
      if (nama == listDiumumkan[i]['nama']) {
        index = i;
      }
    }
    return index;
  }
}
