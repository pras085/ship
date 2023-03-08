import 'package:get/get.dart';

class ModelManajemenNotifikasi extends GetxController {
  String categoryName;
  int categoryIdentifier;
  int categoryOrderNumber;
  int role;
  int subCategoryIdentifier;
  int subCategoryOrderNumber;
  String subCategoryName;
  int userId;
  int pushNotif;
  int emailNotif;
  var pushNotifToggle = false.obs;
  var emailNotifToggle = false.obs;

  ModelManajemenNotifikasi();

  ModelManajemenNotifikasi.fromJson(Map<String, dynamic> json) {
    categoryName = json["CategoryName"];
    categoryIdentifier = json["CategoryIdentifier"];
    categoryOrderNumber = json["CategoryOrderNumber"];
    role = json["Role"];
    subCategoryIdentifier = json["SubCategoryIdentifier"];
    subCategoryOrderNumber = json["SubCategoryOrderNumber"];
    subCategoryName = json["SubCategoryName"];
    userId = json["UserID"];
    pushNotif = json["PushNotif"];
    emailNotif = json["EmailNotif"];
  }
}