import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/api_tm_subscription.dart';

class TMChooseSubuserController extends GetxController {
  var listPaket = [].obs;
  var listPaketTemp = [];
  var searchBar = TextEditingController();
  var search = "".obs;
  var isShowClearSearch = false.obs;
  var loading = true.obs;

  var subuserTax = "Tax";
  var subuserLayanan = "AdditionalFee";
  var subuserID = "PaketID";
  var subuserName = "PaketName";
  var subuserDurasi = "Durasi";
  var subuserHarga = "Harga";
  var subuserQtySubuser = "QtySubUsers";
  var subuserShowDetail = "ShowDetail";
  var subuserDescription = "Description";
  var subuserInfo = "StrInfo";

  var paketLanggananIDName = "paketLanggananID";
  var usedPaketSubuserName = "usedPaketSubuser";
  var nextLanggananName = "nextLangganan";
  var fromBigfleetName = "fromBigfleet";

  int paketLanggananID;
  String usedPaketSubuser;
  bool nextLangganan;
  bool fromBigfleet;

  @override
  void onInit() async {
    isShowClearSearch.value = search.isNotEmpty;
    var argument = Get.arguments as Map;
    paketLanggananID = argument[paketLanggananIDName] != null
        ? argument[paketLanggananIDName]
        : 0;
    usedPaketSubuser = argument[usedPaketSubuserName] != null
        ? argument[usedPaketSubuserName]
        : "";
    nextLangganan = argument[nextLanggananName] != null
        ? argument[nextLanggananName]
        : false;
    fromBigfleet =
        argument[fromBigfleetName] != null ? argument[fromBigfleetName] : true;
    await getListSubuser();
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  Future<void> getListSubuser() async {
    loading.value = true;
    listPaket.clear();
    var result = await ApiTMSubscription(
            context: Get.context,
            isShowDialogError: false,
            isShowDialogLoading: false)
        .fetchPaketLanggananSubuser(paketLanggananID, usedPaketSubuser,
            nextLangganan: nextLangganan, fromBigfleet: fromBigfleet);
    if (result != null) {
      var list = List.from(result["Data"]);
      // list.sort((a, b) => a[subuserName].compareTo(b[subuserName]));
      (list).forEach((element) {
        var body = {
          subuserID: element[subuserID],
          subuserName: element[subuserName],
          subuserDurasi:
              int.parse((element[subuserDescription] as String).split(" ")[4]),
          subuserHarga: element[subuserHarga],
          subuserQtySubuser: element[subuserQtySubuser],
          subuserDescription: element[subuserShowDetail] == 0
              ? ""
              : element[subuserDescription],
          subuserInfo: element[subuserInfo],
          subuserTax: element[subuserTax],
          subuserLayanan: element[subuserLayanan]
        };
        listPaket.add(body);
        listPaketTemp.add(body);
      });
    }
    loading.value = false;
  }

  void searchOnSubmit(String value, {bool submit: true}) {
    search.value = value;
    isShowClearSearch.value = search.isNotEmpty;
    if (submit) FocusManager.instance.primaryFocus.unfocus();
    if (search.isNotEmpty) {
      listPaket.value = [];
      listPaket.value = listPaketTemp
          .where((el) =>
              "${el[subuserName]}"
                  .toLowerCase()
                  .contains(search.value.toLowerCase()) ||
              "${el[subuserDescription]}"
                  .toLowerCase()
                  .contains(search.value.toLowerCase()))
          .toList();
    } else {
      listPaket.value = [];
      listPaket.value = listPaketTemp;
    }
  }

  void onClearSearch() {
    searchBar.text = "";
    searchOnSubmit("");
  }

  void onClickPaketSubuser(int index) {
    Get.back(result: Map.from(listPaket[index]));
  }
}
