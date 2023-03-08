import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';

import 'example_checkbox_buyer_controller.dart';
import '../../widgets/checkbox_buyer/checkbox_buyer.dart';

class ExampleCheckboxBuyerView extends GetView<ExampleCheckboxBuyerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetail(
        title: "Example Usage Checkbox",
      ),
      body: Column(
        children: [
          Obx(() => CheckboxBuyer(
            title: "Merk", // pass your title here
            listCheckbox: controller.list.value, // pass your list
            selectedListCheckbox: controller.selectedList.value, // selected List
            onCheckboxTap: (value) {
              // check if the value is already checked or not.
              if (!controller.selectedList.contains(value)) {
                final list = controller.selectedList;
                list.add(value);
                controller.selectedList.value = [...list];
              } else {
                final list = controller.selectedList;
                list.remove(value);
                controller.selectedList.value = [...list];
              }
            },
            onUpdate: (values) {
              // update the list, right after back from checkbox page.
              controller.selectedList.value = [...values];
            },
          )),
        ],
      ),
    );
  }
}