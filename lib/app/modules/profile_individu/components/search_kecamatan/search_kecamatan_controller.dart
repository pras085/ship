import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class SearchKecamatanController extends GetxController {
  var districtNameKey = 'District';
  var districtIdKey = 'DistrictID';
  var cityNameKey = 'City';
  var cityIdKey = 'CityID';
  var provinceNameKey = 'Province';
  var provinceIdKey = 'ProvinceID';

  var listKecamatan = [].obs;
  var searchController = TextEditingController();
  var text = "".obs;

  @override
  void onInit() {
    searchController.text = Get.arguments ?? "";
    text.value = Get.arguments ?? "";
    search(search: text.value);
    super.onInit();
  }

  Future search({String search = ""}) async {
    text.value = search;
    print(search);

    if ((search ?? "").isNotEmpty) {
      if (search.contains(",")) {
        var arr = search.split(',');

        var result = await ApiProfile(context: Get.context, isShowDialogLoading: false).getKecamatan(arr[0]);
        listKecamatan.value = result['Data'];

        if (listKecamatan.isNotEmpty) {
          // Kalau format search include kota saja. Misalnya: Sukomanunggal, Kota Surabaya / Sukomanunggal,Kota Surabaya
          if (arr.length == 2) {
            if (arr[1].isNotEmpty) {
              arr[1] = arr[1].trimLeft();
              listKecamatan.value = listKecamatan.where((element) => (element[cityNameKey].toString().toLowerCase()).contains(arr[1].toLowerCase())).toList();
            }
          }

          // Kalau format search include kota dan provinsi. Misalnya: Sukomanunggal, Kota Surabaya, Jawa Timur / Sukomanunggal,Kota Surabaya,Jawa Timur
          if (arr.length == 3) {
            if (arr[1].isNotEmpty) {
              arr[1] = arr[1].trimLeft();
              listKecamatan.value = listKecamatan.where((element) => (element[cityNameKey].toString().toLowerCase()).contains(arr[1].toLowerCase())).toList();
              if (arr[2].isNotEmpty) {
                arr[2] = arr[2].trimLeft();
                listKecamatan.where((element) => (element[provinceNameKey].toString().toLowerCase()).contains(arr[2].toLowerCase())).toList();
              }
            }
          }
        }
      } else {
        var result = await ApiProfile(context: Get.context, isShowDialogLoading: false).getKecamatan(search);
        // Pengecekan text.value agar ketika keyword dikosongkan list hasil sebelumnya tidak akan muncul karena data baru muncul
        if (result['Data'] != null) {
          listKecamatan.value = text.value.isEmpty ? [] : result['Data'];
        } else {
          listKecamatan.value = [];
        }
      }
    } else {
      listKecamatan.value = [];
    }
  }

  void onTap({int districtId, String districtName, int cityId, String cityName, int provinceId, String provinceName}) {
    String fullDistrict = "${districtName.split(" - ")[0]}, $cityName, $provinceName";
    Get.back(result: {'id': districtId, 'name': fullDistrict, 'city_id': cityId, 'province_id': provinceId});
  }
}
