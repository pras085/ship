import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'search_result_info_permintaan_muat_controller.dart';

class SearchResultInfoPermintaanMuatView
    extends GetView<SearchResultInfoPermintaanMuatController> {
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
            preferredSize: Size.fromHeight(64),
            child: Container(
              height: GlobalVariable.ratioWidth(Get.context) * 56,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
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
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.goToSearchPage();
                              },
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Obx(
                                    () => CustomTextField(
                                        context: Get.context,
                                        enabled: false,
                                        controller: controller
                                            .searchTextEditingController.value,
                                        textInputAction: TextInputAction.search,
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
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(
                                                    ListColor.colorLightGrey7),
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(ListColor.color4),
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 8,
                          ),
                          GestureDetector(
                              onTap: () {
                                controller.showSorting();
                              },
                              child: Obx(
                                () => Container(
                                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                                    decoration: BoxDecoration(
                                      color: controller.isUsingSorting.value
                                          ? Colors.black
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/sorting_icon.svg",
                                        color: controller.isUsingSorting.value
                                            ? Colors.white
                                            : Colors.black,
                                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                                  height: GlobalVariable.ratioWidth(Get.context) * 24,)),
                              )),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 16,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   child: Obx(
              //     () => ButtonFilterWidget(
              //       isActive: controller.isUsingFilter.value,
              //       onTap: () {
              //         controller.showFilter();
              //       },
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 20,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 7),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text.rich(
                        TextSpan(
                            children: controller.listHasilPencarianInlineSpan
                                .map((data) => data as InlineSpan)
                                .toList()),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => controller.isGettingData.value &&
                          controller.isLoadingManual.value
                      ? Center(
                          child: Container(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator()),
                        )
                      : Stack(children: [
                          SmartRefresher(
                            enablePullUp: true,
                            controller: controller.searchRefreshController,
                            onLoading: () {
                              controller.onLoadingSearchInfoPermintaanMuat();
                            },
                            onRefresh: () {
                              controller.onRefreshSearchInfoPermintaanMuat();
                            },
                            child: ListView.builder(
                              itemCount: controller
                                  .listInfoPermintaanMuatSearch.length,
                              itemBuilder: (content, index) {
                                return controller.perItem(
                                    index,
                                    controller
                                        .listInfoPermintaanMuatSearch[index]);
                                //mitraTile2(controller.listMitra[index]);
                              },
                            ),
                          ),
                          (controller.listInfoPermintaanMuatSearch.length ==
                                      0 &&
                                  !controller.isGettingData.value)
                              ? Center(
                                  child: CustomText(
                                      "LoadRequestInfoLabelEmptyData".tr),
                                )
                              : SizedBox.shrink()
                        ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
