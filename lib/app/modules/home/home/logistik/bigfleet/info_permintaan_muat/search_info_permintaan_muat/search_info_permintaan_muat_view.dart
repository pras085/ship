import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'search_info_permintaan_muat_controller.dart';

class SearchInfoPermintaanMuatView
    extends GetView<SearchInfoPermintaanMuatController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
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
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: ClipOval(
                              child: Material(
                                  shape: CircleBorder(),
                                  color: Color(ListColor.color4),
                                  child: InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          child: Center(
                                              child: Icon(
                                            Icons.arrow_back_ios_rounded,
                                            size: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            color: Colors.white,
                                          ))))),
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12,
                          ),
                          Obx(
                            () => Expanded(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Obx(
                                    () => CustomTextField(
                                        context: Get.context,
                                        autofocus: true,
                                        onChanged: (value) {
                                          controller
                                              .addTextSearchInfoPermintaanMuat(
                                                  value);
                                        },
                                        controller: controller
                                            .searchTextEditingController.value,
                                        textInputAction: TextInputAction.search,
                                        onSubmitted: (value) {
                                          controller.onSubmitSearch();
                                        },
                                        textSize: 14,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        newContentPadding: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                36,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                8,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6),
                                        newInputDecoration: InputDecoration(
                                          isDense: true,
                                          isCollapsed: true,
                                          hintText:
                                              "LoadRequestInfoLabelSearchHint"
                                                  .tr,
                                          fillColor: Colors.white,
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(
                                                  ListColor.colorLightGrey2)),
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(
                                                    ListColor.colorLightGrey10),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        1.0),
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    8),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(
                                                    ListColor.colorLightGrey10),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        1.0),
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(
                                                    ListColor.colorLightGrey10),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        1.0),
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    8),
                                          ),
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8),
                                    child: SvgPicture.asset(
                                      "assets/search_magnifition_icon.svg",
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                      color: Color(ListColor.color4),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: controller.isShowClearSearch.value
                                        ? GestureDetector(
                                            onTap: () {
                                              controller.onClearSearch();
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.close_rounded,
                                                color: Color(
                                                    ListColor.colorDarkGrey3),
                                                size: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    14,
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 8,
                          ),
                          SvgPicture.asset(
                            "assets/sorting_icon.svg",
                            color: Color(ListColor.colorLightGrey2),
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
                // Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: 2,
                //     color: Color(ListColor.colorLightBlue5))
              ]),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 20,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText("LoadRequestInfoLabelLastSearch".tr,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black),
                    GestureDetector(
                      onTap: () {
                        controller.onClearAllHistorySearch();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomText("LoadRequestInfoLabelDeleteAll".tr,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(ListColor.colorRed2)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      itemCount: controller.listHistorySearch.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.onClickHistorySearch(index);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("assets/timer_icon.svg",
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          color: Color(
                                              ListColor.colorLightGrey11)),
                                      SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                            controller
                                                .listHistorySearch[index].name,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller
                                              .onClearOneItemHistorySearch(
                                                  index);
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                        ),
                                      )
                                    ])),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
