import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class GroupMitraController extends GetxController {
  var listMitra = List<MitraModel>().obs;
  GroupMitraModel group;
  var groupID = 0;

  @override
  void onInit() async {
    groupID = Get.arguments[0];
    await getListMitra();
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  Future<void> getListMitra() async {
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .fetchListPartnerInGroup(groupID.toString());
    List<dynamic> getListMitra = response["Data"];
    listMitra.clear();
    getListMitra.forEach((element) {
      listMitra.add(MitraModel.fromJson(element));
    });
  }
}
