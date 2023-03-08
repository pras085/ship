import 'package:muatmuat/app/modules/notification/notif_controller.dart';

class NotifCategory {
  num identifier;
  String categoryName;
  List<dynamic> subCategory;
  num countCategory;

  NotifCategory({this.identifier, this.categoryName, this.subCategory, this.countCategory});
  NotifCategory.fromJson(Map<String, dynamic> json)
      : identifier = json['Identifier'],
        categoryName = json['CategoryName'],
        subCategory = json['SubCategory'],
        countCategory = json['CountKategori'];
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'identifier': identifier,
      'categoryName': categoryName,
      'subCategory' : subCategory,
      'countCategory' : countCategory
    };
    return map;
  }

  NotifCategory.fromMap(Map<String, dynamic> map) {
    identifier = map['identifier'];
    categoryName = map['categoryName'];
    subCategory = map['subCategory'];
    countCategory = map['countCategory'];
  }

   @override
  String toString() {
    return "NotifCategory(id: $identifier, qty: $categoryName, description: $countCategory)";
  }
}

class SubNotifCategory {
  num identifier;
  String subCategoryName;
  num countSubCategory;

  SubNotifCategory({this.identifier, this.subCategoryName, this.countSubCategory});
  SubNotifCategory.fromJson(Map<String, dynamic> json)
      : identifier = json['Identifier'],
        subCategoryName = json['SubCategory'],
        countSubCategory = json['CountSubKategori'];
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'identifier': identifier,
      'subCategoryName': subCategoryName,
      'countSubCategory' : countSubCategory,
    };
    return map;
  }

  SubNotifCategory.fromMap(Map<String, dynamic> map) {
    identifier = map['identifier'];
    subCategoryName = map['subCategoryName'];
    countSubCategory = map['countSubCategory'];
  }

   @override
  String toString() {
    return "SubNotifCategory(id: $identifier, qty: $subCategoryName, description: $countSubCategory)";
  }
}