import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_result_list_transporter/search_result_list_transporter_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class DetailManajemenGroupTambahAnggotaController extends GetxController {
  var searchBar = TextEditingController();
  var search = "";
  var isShowClearSearch = false.obs;

  var listMitra = <MitraModel>[].obs;
  var tempListMitra = <MitraModel>[].obs;

  var selectedMitra = <MitraModel>[].obs;
  var tempSelectedMitra = <MitraModel>[].obs;

  var change = false;
  final _keyDialog = new GlobalKey<State>();

  var groupID = '';

  @override
  void onInit() async {
    listMitra.addAll(await Get.arguments[0]);
    groupID = await Get.arguments[1];
    // selectedMitra.addAll(await Get.arguments[1]);

    selectedMitra.clear();
    tempSelectedMitra.clear();
    tempListMitra.clear();
    tempListMitra.addAll(listMitra.value);
    tempSelectedMitra.addAll(selectedMitra.value);
    // searchBar.text = search;
    // isShowClearSearch.value = search.isNotEmpty;
    // searchOnChange(search);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void searchOnChange(String value) {
    search = value;
    isShowClearSearch.value = search.isNotEmpty;
    tempListMitra.clear();
    tempListMitra
        .addAll(List<MitraModel>.from(listMitra.value).where((element) {
      return element.name
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase());
    }));
  }

  void onClearSearch() {
    searchBar.text = "";
    searchOnChange("");
  }

  void hapusMitra(MitraModel mitra) {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "PartnerManagementLabelTitleRemovePartner".tr,
      message: "PartnerManagementRemoveQuestion".tr,
      context: Get.context,
      labelButtonPriority1: "PartnerManagementLabelCancel".tr,
      onTapPriority2: () async {
        var shipperID = await SharedPreferencesHelper.getUserShipperID();
        // loading.value = true;
        var response =
            await ApiHelper(context: Get.context, isShowDialogLoading: true)
                .removeMitraFromGroup(mitra.docID);
        var message = MessageFromUrlModel.fromJson(response['Message']);
        if (message.code == 200) {
          // await getListMitraOnGroup();
          // updateFilter();
          change = true;
          // loading.value = false;
          CustomToast.show(
              context: Get.context,
              message: "PartnerManagementHasBeenRemoved".tr);
        } else {
          // loading.value = false;
          CustomToast.show(
              context: Get.context, message: response["Data"]["Message"]);
        }
      },
      labelButtonPriority2: "PartnerManagementLabelRemove".tr,
    );
  }

  Future<void> getListAllMitra() async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .fetchNonFilteredMitra(shipperID.toString());
    // var response =
    //     await ApiHelper(context: Get.context, isShowDialogLoading: false)
    //         .fetchNonFilteredMitra("42");
    List<dynamic> getListMitra = response["Data"];
    var filteredMitra = [];
    getListMitra.forEach((element) {
      filteredMitra.add(MitraModel.fromJson(element));
    });
    filteredMitra.removeWhere((element) =>
        listMitra.value.any((alreadyMitra) => alreadyMitra.id == element.id));
    filteredMitra.forEach((element) {
      print(element.name);
    });
    listMitra.value = filteredMitra;
    searchOnChange(search);
    // listAllMitra.value.forEach((element) {
    //   print("all mitra ${element.name}");
    // });
    // tempListAllMitra.value = List.from(listAllMitra.value);
    // listAllMitra.value.forEach((element) {
    //   print("temp all mitra ${element.name}");
    // });
  }

  void addMitraIntoGroup() async {
    var error = "";
    _showDialogLoading();
    // loading.value = true;
    for (var mitra in tempSelectedMitra.value) {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .addMitraIntoGroup(groupID, mitra.docID);
      var message = MessageFromUrlModel.fromJson(response['Message']);
      if (message.code != 200) {
        if (error.isNotEmpty) {
          error += "\n";
        }
        error += "Error input ${mitra.name}: ${response["Data"]["Message"]}";
      }
    }
    if (error.isEmpty) {
      change = true;
      Get.back();
      Get.back(result: change);
      //   await getListMitraOnGroup();
      //   updateFilter();
      //   change = true;
      //   loading.value = false;
      //   CustomToast.show(context: Get.context, message: "Mitra has been added");
    } else {
      Get.back();
      // loading.value = false;
      GlobalAlertDialog.showDialogError(message: error, context: Get.context);
    }
  }

  Future _showDialogLoading() async {
    // _isShowingDialogLoading = true;
    return showDialog(
        context: Get.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: _keyDialog,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText('GlobalLabelDialogLoading'.tr,
                            color: Colors.blueAccent)
                      ]),
                    )
                  ]));
        });
  }

  void onWillPop() {
    Get.back(result: change);
  }
}
