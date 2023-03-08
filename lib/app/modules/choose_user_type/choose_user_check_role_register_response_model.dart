import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class ChooseUserCheckRoleRegisterResponseModel {
  MessageFromUrlModel message;
  String shipperID = "";
  String transporterID = "";
  String sellerID = "";
  String jobSeekerID = "";

  ChooseUserCheckRoleRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    Map<String, dynamic> data = json['Data'];
    if (data != null) {
      shipperID = data['ShipperID'].toString();
      transporterID = data['TransporterID'].toString();
      sellerID = data['SellerID'].toString();
      jobSeekerID = data['JobseekerID'].toString();
    }
  }

  bool get isRegisteredAsShipper => shipperID != "0";

  bool get isRegisteredAsTransporter => transporterID != "0";

  bool get isRegisteredAsSeller => sellerID != "0";

  bool get isRegisteredAsJobSeeker => jobSeekerID != "0";
}
