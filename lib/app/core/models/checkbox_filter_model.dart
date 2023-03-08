import 'package:flutter/material.dart';

// class CheckboxFilterModel {
//   final String id;
//   final String value;
//   CheckboxFilterModel({@required this.id, @required this.value});
// }

class CheckboxFilterModel {
  final String id;
  final String value;
  bool canHide;
  int hideIndex;
  CheckboxFilterModel(
      {@required this.id,
      @required this.value,
      this.canHide = false,
      this.hideIndex = 0});
}