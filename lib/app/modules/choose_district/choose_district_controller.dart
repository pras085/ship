import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseDistrictController extends GetxController {
  var districtNameKey = 'District';
  var districtIdKey = 'DistrictID';
  final RegisterShipperBfTmController registercontroller = Get.find();

  var districts = [].obs;
  var districtsTemp = [].obs;
  var searchController = TextEditingController();
  var text = "".obs;

  @override
  void onInit() async {
    super.onInit();
    if(registercontroller.distid.value == ""){
      log(Get.arguments.toString());
      var result = await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).fetchInformationLocationByToken(Get.arguments);
    districts.value = result['Data'];
    districtsTemp.value = result['Data'];
    }
    else{
      final prefs = await SharedPreferences.getInstance();
          double latnow = prefs.getDouble('latfinal');
          double longnow = prefs.getDouble('lngfinal');
    var result = await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).fetchInformationLatlong(latnow.toString(), longnow.toString());
    // log(result['Data'].toString());
    districts.value = result['Data'];
    districtsTemp.value = result['Data'];
    }
  }

  Future search({String search = ""}) async {
    text.value = search;
    districtsTemp.value = text.value == "" ? districts : districts.where((e) => e[districtNameKey].toString().toLowerCase().contains(text.value.toLowerCase())).toList();
  }

  /// Cek kalau yang dicari huruf awal yang sama hanya ada 1
  bool isSingleGroup(List list) {
    List<Map<String, dynamic>> values = List<Map<String, dynamic>>.from(list);
    List<String> alphabets = [];
    for (var item in values) {
      if(!alphabets.contains(item[districtNameKey][0])) {
        alphabets.add(item[districtNameKey][0]);
      }
    }
    return alphabets.length == 1;
  }

  /// Mendapatkan index terakhir dari item yang telah di group kan
  List<int> getLastId(List list) {
    List<Map<String, dynamic>> values = List<Map<String, dynamic>>.from(list);
    values.sort((a, b) {
      return a[districtNameKey].toString().toLowerCase().compareTo(b[districtNameKey].toString().toLowerCase());
    });
    
    List<String> alphabets = [];
    List<int> listId = [];
    for (var item in values) {
      if(!alphabets.contains(item[districtNameKey][0])) {
        alphabets.add(item[districtNameKey][0]);
      }
    }

    for (var item in alphabets) {
      listId.add(values.lastWhere((element) => element[districtNameKey][0] == item)[districtIdKey]);
    }

    return listId;
  }

  void onTap({int districtId, String districtName}) {
    Get.back(result: {'id': districtId, 'name': districtName});
  }
}
