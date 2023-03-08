import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:flutter/material.dart';

// class WidgetFilterModel {
//   final List<String> label;
//   final TypeInFilter typeInFilter;
//   final String keyParam;
//   final List<dynamic> customValue;
//   final List<dynamic> initValue;

//   WidgetFilterModel(
//       {@required this.label,
//       @required this.typeInFilter,
//       @required this.keyParam,
//       this.customValue,
//       this.initValue});
// }

class WidgetFilterModel {
  final List<String> label;
  final TypeInFilter typeInFilter;
  final String keyParam;
  final List<dynamic> customValue;
  final List<dynamic> initValue;
  bool canBeHide;
  double paddingLeft;
  bool hideTitle;
  int numberHideFilter;
  bool hideLine;
  bool isSeparateParameter;
  bool isIdAsParameter;
  List<String> listSepKeyParameter;
  double heightPaddingBottom;
  double heightPaddingBottomWhenHidden;

  WidgetFilterModel({
    @required this.label,
    @required this.typeInFilter,
    @required this.keyParam,
    this.canBeHide = false,
    this.paddingLeft = 0.0,
    this.numberHideFilter = 0,
    this.hideTitle = false,
    this.hideLine = false,
    this.customValue,
    this.initValue,
    this.isIdAsParameter = false,
    this.isSeparateParameter = false,
    this.listSepKeyParameter,
    this.heightPaddingBottom = 20,
    this.heightPaddingBottomWhenHidden = 0,
  });
}
