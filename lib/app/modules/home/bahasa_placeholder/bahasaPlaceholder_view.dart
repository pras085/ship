import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/bahasa_placeholder/bahasaPlaceholder_controller.dart';

class BahasaPlaceholderView extends GetView<BahasaPlaceholderController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
