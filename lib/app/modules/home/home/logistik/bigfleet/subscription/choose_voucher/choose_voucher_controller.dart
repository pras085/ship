import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/api_subscription.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class ChooseVoucherController extends GetxController {
  var listPaket = [].obs;
  var listVoucher = [].obs;
  var selectedVoucherID = 0.obs;
  var listVoucherTemp = [];
  var searchBar = TextEditingController();
  var search = "".obs;
  var isShowClearSearch = false.obs;
  var loading = true.obs;
  var cekLoading = false.obs;
  var isFirst = 0;

  //Get Voucher
  var getVoucherID = "VoucherID";
  var getVoucherKode = "Kode";
  var getVoucherNote = "Note";
  var getVoucherType = "Type";
  var getVoucherAmount = "Amount";
  var getVoucherFreeUser = "FreeUser";
  var getVoucherStartDate = "StartDate";
  var getVoucherEndDate = "EndDate";

  //Check Voucher
  var cekVoucherPaketID = "PaketID";
  var cekVoucherID = "VoucherID";
  var cekVoucherCode = "VoucherCode";
  var cekVoucherAmount = "Amount";
  var cekVoucherFreeUser = "FreeUser";
  var cekVoucherHargaPaket = "HargaPaket";
  var cekVoucherDiskon = "Diskon";

  var cekPaketID = "ID";
  var cekPaketQty = "Qty";

  @override
  void onInit() async {
    // isShowClearSearch.value = search.isNotEmpty;
    listPaket.value = Get.arguments as List;
    await getListVoucher();
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  Future<void> getListVoucher() async {
    loading.value = true;
    listVoucher.clear();
    var stringPaket = "";
    listPaket.forEach((element) {
      stringPaket +=
          ((stringPaket.isEmpty ? "" : ",") + element[cekPaketID].toString());
    });
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var resultCheckSegmented = await ApiSubscription(
            context: Get.context,
            isShowDialogError: false,
            isShowDialogLoading: false)
        .getCheckSegmented(role: "2", roleUserId: shipperID);
    if (resultCheckSegmented != null) {
      isFirst = resultCheckSegmented["Data"]["IsFirst"];
      var result = await ApiSubscription(
              context: Get.context,
              isShowDialogError: false,
              isShowDialogLoading: false)
          .fetchListSubscriptionVoucher(isFirst, stringPaket);
      if (result != null) {
        (result["Data"] as List).forEach((element) {
          var voucher = {
            getVoucherID: element[getVoucherID],
            getVoucherKode: element[getVoucherKode],
            getVoucherNote: element[getVoucherNote],
            getVoucherType: element[getVoucherType],
            getVoucherAmount: element[getVoucherAmount],
            getVoucherFreeUser: element[getVoucherFreeUser],
            getVoucherStartDate: element[getVoucherStartDate],
            getVoucherEndDate: element[getVoucherEndDate],
          };
          listVoucher.add(voucher);
          listVoucherTemp.add(voucher);

          // default selected voucher
          if (listPaket[0]['voucherId'] != null) {
            final res = listVoucher.value.where((e) => '${e[getVoucherID]}' == '${listPaket[0]['voucherId']}').toList();
            if (res.isNotEmpty) {
              selectedVoucherID.value = res.first[getVoucherID];
            }
          }
        });
      }
    }
    loading.value = false;
  }

  void searchOnSubmit(String value, {bool submit: true}) {
    search.value = value;
    isShowClearSearch.value = search.isNotEmpty;
    if (submit) FocusManager.instance.primaryFocus.unfocus();
    if (search.isNotEmpty) {
      listVoucher.value = [];
      listVoucher.value = listVoucherTemp
          .where((el) =>
              "${el[getVoucherKode]}"
                  .toLowerCase()
                  .contains(search.value.toLowerCase()) ||
              "${el[getVoucherNote]}"
                  .toLowerCase()
                  .contains(search.value.toLowerCase()))
          .toList();
    } else {
      listVoucher.value = [];
      listVoucher.value = listVoucherTemp;
    }
  }

  void onClearSearch() {
    searchBar.text = "";
    searchOnSubmit("", submit: false);
  }

  void onClickPaketSubuser(int index) {
    selectedVoucherID.value =
        selectedVoucherID.value == listVoucher[index][getVoucherID]
            ? 0
            : listVoucher[index][getVoucherID];
  }

  void onSubmit() async {
    FocusManager.instance.primaryFocus.unfocus();
    if (selectedVoucherID.value == 0) {
      Get.back();
    } else {
      cekLoading.value = true;
      var result = await ApiSubscription(
              context: Get.context,
              isShowDialogError: false,
              isShowDialogLoading: false)
          .checkSubscriptionVoucher(
              List.from(listPaket.value), selectedVoucherID.value.toString());
      if (result != null) {
        Get.back(
            result: List.from(result["Data"])
                .where((element) => element["AppliedVoucher"] == true)
                .toList());
      }
      cekLoading.value = false;
    }
  }
}
