import 'package:flutter/material.dart';

class SatuanFilterModel {
  final String id;
  final String value;
  double min;
  double max;
  SatuanFilterModel(
      {@required this.id, @required this.value, this.min, this.max});
}
