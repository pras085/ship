import 'package:flutter/material.dart';

class CheckboxWithSubFilterModel {
  final String id;
  final String value;
  bool canHide;
  int hideIndex;
  List<dynamic> subdata;
  CheckboxWithSubFilterModel({
    @required this.id,
    @required this.value,
    this.canHide = false,
    this.hideIndex = 0,
    this.subdata,
  });
}
