import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class GetContactTransporterByShipper {
  static Future getContact(String transporterID) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getTransporterContact(transporterID);
    if (responseBody != null) {
      ContactTransporterByShipperResponseModel response =
          ContactTransporterByShipperResponseModel.fromJson(responseBody);
      return response;
    }
    return null;
  }
}
