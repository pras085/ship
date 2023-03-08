import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/contact_shipper_model_ark.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';

class CustomArkGetContactTransporterByShipper {
  static Future getContact(String shipperID) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getTransporterContactCustomARK(shipperID);
    if (responseBody != null) {
      ContactShipperModel response = ContactShipperModel.fromJson(responseBody);
      return response;
    }
    return null;
  }

  static Future getWA(String shipperID) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getTransporterWACustomARK(shipperID);
    if (responseBody != null) {
      ContactShipperModel response = ContactShipperModel.fromJson(responseBody);
      return response;
    }
    return null;
  }
}
