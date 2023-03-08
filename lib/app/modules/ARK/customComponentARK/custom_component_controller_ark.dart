import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'componentModel/custom_component_model.dart';

class CustomWidgetControllerArk extends GetxController {
  void Function(Map<String, dynamic>) returnData;
  final List<CustomComponentModel> listCustomWidget;
  CustomWidgetControllerArk({
    @required this.returnData,
    @required this.listCustomWidget,
  });
  @override
  void onInit() {}
}
