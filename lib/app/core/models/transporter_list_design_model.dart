import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';

class TransporterListDesignModel {
  String userID;
  String transporterID;
  String transporterName;
  String avatar;
  String address;
  String city;
  String initials;
  String serviceArea;
  String yearFounded = "";
  String numberTruck = "";
  String joinDate;
  Color backgroundColor;
  bool isGoldTransporter = true;
  bool isAlreadyBecomePartner = false;

  TransporterListDesignModel(
      {this.userID = "",
      this.transporterID = "",
      this.transporterName = "",
      this.avatar = "",
      this.address = "",
      this.city = "",
      this.initials = "",
      this.serviceArea = "",
      this.yearFounded = "",
      this.numberTruck = "",
      this.isGoldTransporter = true,
      this.isAlreadyBecomePartner = false,
      this.joinDate = ""}) {
    this.initials =
        this.initials == "" ? _getInitials(transporterName) : this.initials;
  }

  String _getInitials(String value) {
    List<String> listWords = value.trim().split(" ");
    listWords.removeWhere((element) => element.isEmpty);
    String initials = "";
    final int maxInitials = 3;
    int countInitials =
        listWords.length > maxInitials ? maxInitials : listWords.length;
    for (int i = 0; i < countInitials; i++) {
      initials += '${listWords[i][0]}';
    }
    return initials.toUpperCase();
  }
}
