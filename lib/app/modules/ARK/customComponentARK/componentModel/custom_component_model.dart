import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:flutter/material.dart';

import 'type_in_custom_component.enum.dart';

class CustomComponentModel {
  final List<String> label;
  final TypeInCustomComponent typeInCustomComponent;
  final String fieldsName;
  final String tagFrontend;
  final List<dynamic> customValue;
  final List<dynamic> initValue;
  bool hideTitle;

  CustomComponentModel({
    @required this.label,
    @required this.typeInCustomComponent,
    @required this.fieldsName,
    @required this.tagFrontend,
    this.hideTitle = false,
    this.customValue,
    this.initValue,
  });
}
