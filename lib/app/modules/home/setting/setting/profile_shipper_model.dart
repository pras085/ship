import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_as_enum.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_type_account_enum.dart';
import 'package:get/get.dart';

class ProfileShipperModel {
  String shipperID = "";
  String username = "";
  String code = "";
  ShipperBuyerRegisterTypeAccount typeAccount;
  String type = "";
  ShipperBuyerRegisterAs profileAccount;
  String profile = "";
  String profileAndType = "";
  String email = "";
  String phone = "";
  String shopName = "";
  String address = "";
  String provinceCode = "";
  String province = "";
  String categoryCapacityID = "";
  String categoryCapacity = "";
  String cityID = "";
  String city = "";
  String postalCode = "";
  String avatar = "";
  String capacity = "";
  bool isVerif = false;
  String noKTP = "";
  String noNPWP = "";
  String numberWhatssapp = "";
  String businessEntityID = "";
  String businessFieldID = "";
  String businessEntity = "";
  String businessField = "";
  String namePIC1 = "";
  String contactPIC1 = "";
  String namePIC2 = "";
  String contactPIC2 = "";
  String namePIC3 = "";
  String contactPIC3 = "";
  String latitude = "";
  String longitude = "";

  ProfileShipperModel();

  ProfileShipperModel.fromJson(Map<String, dynamic> json) {
    shipperID = json["ShipperID"].toString();
    username = json["Username"];
    code = json["Code"];
    type = json["Type"];
    typeAccount = type == "Individu"
        ? ShipperBuyerRegisterTypeAccount.INDIVIDU
        : ShipperBuyerRegisterTypeAccount.PERUSAHAAN;
    profile = json["Profile"];
    profileAccount = profile == "Pembeli"
        ? ShipperBuyerRegisterAs.BUYER
        : ShipperBuyerRegisterAs.SHIPPER;
    profileAndType = (profileAccount == ShipperBuyerRegisterAs.BUYER
            ? "ProfileShipperProfileAccountBuyer".tr
            : "ProfileShipperProfileAccountShipper".tr) +
        " - " +
        (typeAccount == ShipperBuyerRegisterTypeAccount.INDIVIDU
            ? "ProfileShipperTypeAccountIndividual".tr
            : "ProfileShipperTypeAccountCompany".tr);
    email = json["Email"];
    phone = json["Phone"];
    shopName = json["ShopName"];
    address = json["Address"];
    provinceCode = json["ProvinceCode"].toString();
    province = json["Province"];
    categoryCapacityID = json["CategoryCapacityID"].toString();
    categoryCapacity = json["CategoryCapacity"];
    cityID = json["CityID"].toString();
    city = json["City"];
    postalCode = json["PostalCode"];
    avatar = json["Avatar"];
    capacity = json["Capacity"].toString();
    isVerif = json["IsVerif"] == 1;
    noKTP = json["NoKTP"];
    noNPWP = json["NoNPWP"];
    numberWhatssapp = json["PhoneWA"];
    businessEntityID = json["BusinessEntityID"].toString();
    businessFieldID = json["BusinessFieldID"].toString();
    businessEntity = json["BusinessEntity"];
    businessField = json["BusinessField"];
    namePIC1 = json["NamePic1"] ?? "";
    contactPIC1 = json["ContactPic1"] ?? "";
    namePIC2 = json["NamePic2"];
    contactPIC2 = json["ContactPic2"];
    namePIC3 = json["NamePic3"];
    contactPIC3 = json["ContactPic3"];
    latitude = json["Latitude"] ?? "";
    longitude = json["Longitude"] ?? "";
  }

  ProfileShipperModel.copy(ProfileShipperModel data) {
    shipperID = data.shipperID;
    username = data.username;
    code = data.code;
    type = data.type;
    typeAccount = data.typeAccount;
    profile = data.profile;
    profileAccount = data.profileAccount;
    profileAndType = data.profileAndType;
    email = data.email;
    phone = data.phone;
    shopName = data.shopName;
    address = data.address;
    provinceCode = data.provinceCode;
    province = data.province;
    categoryCapacityID = data.categoryCapacityID;
    categoryCapacity = data.categoryCapacity;
    cityID = data.cityID;
    city = data.city;
    postalCode = data.postalCode;
    avatar = data.avatar;
    capacity = data.capacity;
    isVerif = data.isVerif;
    noKTP = data.noKTP;
    noNPWP = data.noNPWP;
    numberWhatssapp = data.numberWhatssapp;
    businessEntityID = data.businessEntityID;
    businessFieldID = data.businessFieldID;
    businessEntity = data.businessEntity;
    businessField = data.businessField;
    namePIC1 = data.namePIC1;
    contactPIC1 = data.contactPIC1;
    namePIC2 = data.namePIC2;
    contactPIC2 = data.contactPIC2;
    namePIC3 = data.namePIC3;
    contactPIC3 = data.contactPIC3;
    latitude = data.latitude;
    longitude = data.longitude;
  }
}
