import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListMuatanFilterController extends GetxController {
  final listMuatan = [].obs;
  final listChoosen = [].obs;
  var expandParent = {}.obs;

  final searchTextEditingController = TextEditingController().obs;
  final isShowClearSearch = false.obs;
  var listCheckboxMuatan = <Widget>[].obs;
  var listMuatanTemp = [].obs;
  var hidescroll = false.obs;
  String _searchValue = "";

  var hintText = "".obs;
  var labelText = "".obs;
  ScrollController scrollControllerChoosen = ScrollController();
  ScrollController scrollControllerCheckbox = ScrollController();

  @override
  void onInit() {
    // scrollControllerChoosen = new ScrollController(initialScrollOffset: 1.0);
    // scrollControllerCheckbox = new ScrollController(initialScrollOffset: 1.0);
    listMuatan.value = jsonDecode(jsonEncode(Get.arguments[0]));
    listChoosen.value = jsonDecode(jsonEncode(Get.arguments[1]));
    listMuatanTemp.value = jsonDecode(jsonEncode(Get.arguments[0]));
    hintText.value = Get.arguments[2][1];
    labelText.value = Get.arguments[2][0];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    listChoosen.clear();
    listMuatanTemp.clear();
  }

  void addTextSearchMuatan(String value) {
    _searchValue = value;
    isShowClearSearch.value = _searchValue.isNotEmpty;
    if (_searchValue != "") {
      _searchMuatan();
    } else {
      _showAllMuatan();
    }
  }

  void onSubmitSearch() {
    _searchMuatan();
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearchMuatan("");
  }

// void onChangeText(String textSearch) {
//     isShowClearSearch.value = textSearch != "";
//   }

  void onCheckMuatan(int index, bool value) {
    if (value) {
      listChoosen.value.remove(listMuatan[index]['nama']);
      if (scrollControllerChoosen.offset <= 0.0 &&
          scrollControllerChoosen.positions.length <= 1) {
        hidescroll.value = true;
      }
    } else {
      listChoosen.value.add(listMuatan[index]['nama']);
      if (listChoosen.value.length > 1) {
        scrollControllerChoosen.animateTo(
            scrollControllerChoosen.position.maxScrollExtent + 54,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut);
        if (scrollControllerChoosen.positions.length >= 1) {
          hidescroll.value = false;
        }
      }
    }
    listChoosen.refresh();
    listMuatanTemp.refresh();
    listCheckboxMuatan.refresh();
  }

  void _searchMuatan() {
    listMuatanTemp.clear();
    String query = searchTextEditingController.value.text.toLowerCase();

    var tempResult = new List.from(listMuatan.value.where((data) {
      final nama = data['nama'].toString().toLowerCase();
      return nama.contains(query);
    }).toList());
    listMuatanTemp.value = tempResult;
    listMuatanTemp.refresh();
  }

  void _showAllMuatan() {
    listMuatanTemp.clear();
    listMuatanTemp.value = jsonDecode(jsonEncode(listMuatan.value));
    listMuatan.refresh();
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
    listMuatanTemp.clear();
    listMuatanTemp.value = jsonDecode(jsonEncode(listMuatan.value));
    listMuatanTemp.refresh();
    searchTextEditingController.value.text = "";
  }

  Widget badgeChoosen(value) {
    return Container(
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
    for (int i = 0; i < listMuatanTemp.length; i++) {
      if (listMuatanTemp[i]['nama'] == nama) {
        check = true;
      }
    }
    return check;
  }

  int getIndexList(String nama) {
    int index = 0;
    for (int i = 0; i < listMuatan.length; i++) {
      if (nama == listMuatan[i]['nama']) {
        index = i;
      }
    }
    return index;
  }
}
