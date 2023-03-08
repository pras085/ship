import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';

class ContactShipperModel {
  MessageFromUrlModel message;
  ContactTransporterByShipperModel contactTransporterByShipperModel;
  var contactDataJson;

  ContactShipperModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    contactDataJson = json['Data'];
    if (contactDataJson != null) {
      try {
        contactTransporterByShipperModel = ContactTransporterByShipperModel(
          namePic1: contactDataJson["NamePic1"],
          contactPic1: contactDataJson["ContactPic1"],
          namePic2: contactDataJson["NamePic2"],
          contactPic2: contactDataJson["ContactPic2"],
          namePic3: contactDataJson["NamePic3"],
          contactPic3: contactDataJson["ContactPic3"],
          phone: contactDataJson["EmergencyHp"],
          phoneWA: contactDataJson["EmergencyHp"],
          email: contactDataJson["Email"] ?? "",
          isWa1: false,
          isWa2: false,
          isWa3: false,
        );
      } catch (err) {}
    }
  }
}
