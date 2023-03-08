import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/location_management_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/global_variable.dart';

class AllLocationManagement {
  bool isShowLoading;
  String errorMessage = "";
  List<LocationManagementModel> listData = [];

  AllLocationManagement({this.isShowLoading = true});

  Future<bool> getAllLocationManagement() async {
    listData.clear();
    MessageFromUrlModel _message;
    try {
      var response = await ApiHelper(
              context: Get.context, isShowDialogLoading: isShowLoading)
          .fetchListManagementLokasi("", {}, {}, 10, 0, GlobalVariable.docID);
      if (response != null) {
        Map<String, dynamic> json = response;
        _message = json['Message'] != null
            ? MessageFromUrlModel.fromJson(json['Message'])
            : null;
        if (_message != null) {
          if (_message.code != 200) {
            errorMessage = _message.text;
            return false;
          }
        }
        var data = json['Data'];
        if (data != null) {
          listData.addAll(data
              .map<LocationManagementModel>(
                  (value) => LocationManagementModel.fromJson(value))
              .toList());
        }
        return true;
      }
    } catch (err) {}
    return false;
  }
}
