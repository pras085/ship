import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/setting/setting_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../global_variable.dart';

class SettingView extends GetView<SettingController> {
  SettingController _controller = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText('ProfileLabelSettings'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            FlatButton(
                onPressed: () async {
                  controller.listLanguage.clear();
                  controller.getListLanguage(context);
                  showListLanguage();
                  // controller.changeLanguage('id');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: CustomText('SettingLabelLanguage'.tr,
                          textAlign: TextAlign.left),
                    ),
                    CustomText(GlobalVariable.languageName)
                  ],
                )),
            Divider(
              color: Colors.grey[200],
              height: 0,
              thickness: 2,
            ),
            FlatButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              CustomText('SettingLabelConfirmationLogOut'.tr),
                          actions: [
                            FlatButton(
                              child: CustomText('GlobalButtonYES'.tr),
                              onPressed: () {
                                _controller.signOut();
                              },
                            ),
                            FlatButton(
                              child: CustomText('GlobalButtonNO'.tr),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                },
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText('SettingLabelLogout'.tr))),
          ],
        ),
      ),
    );
  }

  showListLanguage() {
    showDialog(
        context: Get.context,
        builder: (context) {
          return AlertDialog(
            actions: [],
            content: Container(
              width: 300,
              height: 300,
              child: Obx(
                () => controller.listLanguage.value.length == 0
                    ? Center(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator()),
                      )
                    : ListView.builder(
                        itemCount: controller.listLanguage.length,
                        itemBuilder: (context, index) {
                          var selectedLanguage =
                              controller.listLanguage.value[index];
                          return FlatButton(
                              color: selectedLanguage.urlSegment ==
                                      GlobalVariable.languageCode
                                  ? Color(ListColor.color4)
                                  : null,
                              onPressed: () async {
                                await controller.changeLanguage(
                                    selectedLanguage.urlSegment,
                                    selectedLanguage.locale,
                                    selectedLanguage.title);
                                Navigator.pop(context);
                              },
                              child: CustomText(selectedLanguage.title,
                                  color: selectedLanguage.urlSegment ==
                                          GlobalVariable.languageCode
                                      ? Colors.white
                                      : Colors.black));
                        }),
              ),
            ),
          );
        });
  }
}
