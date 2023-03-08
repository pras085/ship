import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/core/models/info_from_address_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class GetInfoFromAddressPlaceID {
  static Future getInfo({String address, String placeID}) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: true,
            isShowDialogError: true)
        .fetchInfoFromAddress(address: address, placeID: placeID);
    if (responseBody != null) {
      InfoFromAddressResponseModel response =
          InfoFromAddressResponseModel.fromJson(responseBody);
      return response;
    }
    return null;
  }
}
