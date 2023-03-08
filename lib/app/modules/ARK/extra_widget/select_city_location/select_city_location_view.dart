import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:validators/validators.dart';
import 'select_city_location_controller.dart';

class SelectCityLocationView extends GetView<SelectCityLocationController> {
  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(Get.context).size.height * 50 / 100;
    double left = MediaQuery.of(Get.context).size.width * 50 / 100;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          child: Container(
            height: GlobalVariable.ratioWidth(Get.context) * 56,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 8),
              ),
            ], color: Colors.white),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 12,
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 11.5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      "ic_back_blue_button.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24))),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Obx(() => CustomTextField(
                                context: Get.context,
                                // autofocus: !controller.isLoadingData.value,
                                controller: controller
                                    .searchTextEditingController.value,
                                textInputAction: TextInputAction.search,
                                onChanged: (value) {
                                  controller.search(value);
                                },
                                textSize: 14,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                newInputDecoration: InputDecoration(
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText: controller.hintText.value,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    color: Color(ListColor.colorLightGrey2),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            32,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6,
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9,
                                    bottom:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.colorLightGrey7),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            1),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.colorLightGrey7),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            1),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.color4),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            1),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                  ),
                                ))),
                            Container(
                              margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      6,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          2),
                              child: SvgPicture.asset(
                                GlobalVariable.imagePath + "ic_search_blue.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Obx(() => controller
                                      .isShowClearSearch.value
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.onClearSearch();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  4),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "ic_close_blue.svg",
                                              color:
                                                  Color(ListColor.colorGrey3),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              height:
                                                  GlobalVariable.ratioWidth(Get.context) * 24)))
                                  : SizedBox.shrink()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Color(ListColor.colorBackgroundTender)),
            ),
            Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : controller.listKotaKabupaten.length == 0
                    ? Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                GlobalVariable.imagePath +
                                    "ic_pencarian_tidak_ditemukan.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 82,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 93,
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15),
                              CustomText(
                                  'InfoPraTenderIndexLabelSearchKeyword'.tr +
                                      '\n' +
                                      'InfoPraTenderIndexLabelSearchTidakDitemukan'
                                          .tr, //Keyword Tidak Ditemukan,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.center,
                                  height: 1.2,
                                  color: Color(ListColor.colorGrey3))
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 16,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 6),
                        itemCount: controller.listKotaKabupaten.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(
                                              ListColor.colorLightGrey10)))),
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  Get.back(result: [
                                    int.parse(controller
                                        .listKotaKabupaten[index]['idKota']),
                                    controller.listKotaKabupaten[index]
                                        ['namaKota'],
                                  ]);
                                },
                                title: CustomText(
                                    controller.listKotaKabupaten[index]
                                        ['namaKota'],
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ));
                        })),
          ],
        ),
      ),
    );
  }
}
