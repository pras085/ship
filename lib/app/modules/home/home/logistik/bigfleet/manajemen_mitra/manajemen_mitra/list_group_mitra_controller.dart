import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';

class ListGroupMitraController extends GetxController {
  var filterName = "".obs;
  var sort = Map().obs;
  var listGroupMitra = List<GroupMitraModel>().obs;
  var activeGroup = true.obs;

  @override
  void onInit() async {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  // Future<void> getListGroupMitra() async {
  //   var shipperID = await SharedPreferencesHelper.getUserShipperID();
  //   var response =
  //       await ApiHelper(context: Get.context, isShowDialogLoading: true)
  //           .fetchFilteredGroupMitra(shipperID.toString(), "", sort.value,
  //               {"Status": activeGroup.value ? "1" : "0"});
  //   List<dynamic> getListGroup = response["Data"];
  //   listGroupMitra.clear();
  //   getListGroup.forEach((element) {
  //     listGroupMitra.add(GroupMitraModel.fromJson(element));
  //   });
  // }
}
