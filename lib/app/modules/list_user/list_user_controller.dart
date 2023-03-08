import 'package:get/get.dart';

class ListUserController extends GetxController {
  var selectedJenisMitra = {}.obs;
  var selectedGroup = [].obs;
  var selectedTransporter = [].obs;
  var selectedInvited = {}.obs;
  var delete = false.obs;

  var isExpandJenisMitra = true.obs;
  var isExpandGroup = true.obs;
  var isExpandTransporter = true.obs;
  var isExpandInvited = true.obs;

  @override
  void onInit() {
    delete.value = Get.arguments[0];
    var map = Get.arguments[1];
    selectedJenisMitra.value = map["semua"];
    selectedGroup.value = map["group"];
    selectedTransporter.value = map["transporter"];
    selectedInvited.value = map["invited"];
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
}
