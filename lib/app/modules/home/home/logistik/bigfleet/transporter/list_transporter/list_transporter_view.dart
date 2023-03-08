import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/enum/list_data_design_type_button_corner_right_enum.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/list_transporter/list_transporter_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_list_transporter/search_list_transporter_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';

import 'package:muatmuat/app/widgets/appbar_custom2.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListTransporterView extends GetView<ListTransporterController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarCustom2(
            isEnableSearchTextField: false,
            hintText: "ListTransporterLabelCariTransporter".tr,
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
            searchInput: controller.searchBar,
            listOption: [
              Obx(
                () => GestureDetector(
                    onTap: () {
                      controller.showSort();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: controller.sort.keys.isNotEmpty
                              ? Colors.white
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/sorting_icon.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: controller.sort.keys.isNotEmpty
                                ? Color(ListColor.color4)
                                : Colors.white))),
              )
            ],
            onSelect: () {
              GetToPage.toNamed<SearchListTransporterController>(Routes.SEARCH_LIST_TRANSPORTER,
                  arguments: ["", controller.sort.value]);
            }),
        body: WillPopScope(
          onWillPop: onWillPop,
          child: SafeArea(
            child: Obx(() => controller.loading.value
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    width: Get.context.mediaQuery.size.width,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator()),
                        ),
                        CustomText("ListTransporterLabelLoading".tr),
                      ],
                    ))
                : Container(
                    color: Colors.grey[100],
                    child: Obx(
                      () => Stack(
                        alignment: Alignment.center,
                        children: [
                          Obx(
                            () => Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                    width: context.mediaQuery.size.width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child:
                                          // Obx(() =>
                                          Row(
                                        children: [
                                          Obx(
                                            () => ButtonFilterWidget(
                                              onTap: () {
                                                controller.showFilter();
                                              },
                                              isActive: controller.mapFilterData
                                                  .keys.isNotEmpty,
                                            ),
                                          ),
                                          // for (var area in controller
                                          //     .filterAreaLayanan.values)
                                          //   horizontalScrollItem(
                                          //       Text(area,
                                          //           style: TextStyle(
                                          //               color:
                                          //                   Color(0xFF7C9CBF))),
                                          //       () {}),
                                          // for (var head
                                          //     in controller.filterKota.values)
                                          //   horizontalScrollItem(
                                          //       Text(head,
                                          //           style: TextStyle(
                                          //               color:
                                          //                   Color(0xFF7C9CBF))),
                                          //       () {}),
                                          // Container(width: 8)
                                        ],
                                      ),
                                      // ),
                                    )),
                                controller.filterSearch.value.isEmpty
                                    ? SizedBox.shrink()
                                    : Container(
                                        margin: EdgeInsets.all(15),
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color:
                                                      Color(ListColor.color4)),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "Menampilkan hasil untuk \""),
                                                TextSpan(
                                                    text: controller
                                                        .filterSearch.value,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(text: "\"")
                                              ]),
                                        )),
                                Expanded(
                                    child:
                                        // Obx(() => controller
                                        //             .listTransporterLength.value ==
                                        //         0
                                        //     ? Container(
                                        //         alignment: Alignment.center,
                                        //         child: CustomText("Data not found"))
                                        //     :
                                        Stack(
                                  children: [
                                    SmartRefresher(
                                      enablePullUp: true,
                                      controller: controller
                                          .refreshTransporterController,
                                      onLoading: () {
                                        controller.loadData();
                                      },
                                      onRefresh: () {
                                        controller.refreshData();
                                      },
                                      child: ListView.builder(
                                        itemCount: controller
                                            .listTransporterLength.value,
                                        itemBuilder: (content, index) {
                                          return transporterView(index);
                                        },
                                      ),
                                    ),
                                    controller.listTransporterLength.value != 0
                                        ? SizedBox.shrink()
                                        : controller
                                                .mapFilterData.keys.isNotEmpty
                                            ? _noSearchPlaceholder()
                                            : _noDataPlaceholder(
                                                'Belum ada\n data Transporter'
                                                    .tr)
                                  ],
                                )),
                                // ),
                              ],
                            ),
                          ),
                          !controller.showSuggestion.value
                              ? SizedBox.shrink()
                              : Positioned.fill(
                                  child: Container(
                                      color: Colors.white,
                                      child: SingleChildScrollView(
                                          child: Obx(
                                        () => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                        child: CustomText(
                                                            "Terakhir dicari",
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    controller.lastSearch
                                                                .length ==
                                                            0
                                                        ? SizedBox.shrink()
                                                        : GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .removeAllHistory();
                                                            },
                                                            child: CustomText(
                                                              "Hapus Semua",
                                                              fontSize: 16,
                                                              color: Color(
                                                                  ListColor
                                                                      .colorRed),
                                                            ))
                                                  ],
                                                ),
                                              ),
                                              for (var index = 0;
                                                  index <
                                                      controller
                                                          .lastSearch.length;
                                                  index++)
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.timer,
                                                          color: Colors.grey,
                                                          size: 14),
                                                      Expanded(
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              controller
                                                                  .showSuggestion
                                                                  .value = false;
                                                              controller
                                                                  .refreshData();
                                                            },
                                                            child: CustomText(
                                                                controller
                                                                        .lastSearch[
                                                                    index],
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .removeHistory(
                                                                    index);
                                                          },
                                                          child: Icon(
                                                              Icons.close,
                                                              size: 14,
                                                              color:
                                                                  Colors.black))
                                                    ],
                                                  ),
                                                ),
                                            ]),
                                      )))),
                        ],
                      ),
                    ),
                  )),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (controller.showSuggestion.value) {
      if (controller.focus) {
        FocusScope.of(Get.context).unfocus();
        controller.focus = false;
      } else {
        controller.searchBar.text = controller.filterSearch.value;
        controller.showSuggestion.value = false;
      }
    } else {
      Get.back(result: controller.change);
    }
    return Future.value(false);
  }

  Widget transporterView(int index) {
    return controller.listTransporter.getTransporterTileWidget(index,
        typeButton: ListDataDesignTypeButtonCornerRight.THREE_DOT_VERT,
        dari: ListDataMitraFrom.TRANSPORTER, onTapBottonCornerRight: () {
      controller.showTransporterOption(index);
      log('Zehaha');
    });
  }

  Widget horizontalScrollItem(Widget content, VoidCallback onPress) {
    return Container(
        padding: EdgeInsets.all(5),
        child: MaterialButton(
            color: Colors.white,
            onPressed: onPress,
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: Color(ListColor.colorLightGrey7), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: content));
  }

  Widget _noDataPlaceholder(String text) {
    return Positioned.fill(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: SvgPicture.asset(
                  "assets/ic_management_lokasi_no_data.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 82.3,
                  height: GlobalVariable.ratioWidth(Get.context) * 75,
                )),
                Container(
                  height: 12,
                ),
                Container(
                    child: CustomText(
                  text.replaceAll("\\n", "\n"),
                  textAlign: TextAlign.center,
                  color: Color(ListColor.colorLightGrey14),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.2,
                ))
              ],
            )));
  }

  Widget _noSearchPlaceholder() {
    return Positioned.fill(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: SvgPicture.asset(
                  "assets/ic_management_lokasi_no_search.svg",
                  height: GlobalVariable.ratioWidth(Get.context) * 95,
                )),
                Container(
                  height: 12,
                ),
                Container(
                    child: CustomText(
                  "SubscriptionFilterNoData".tr.replaceAll("\\n", "\n"),
                  textAlign: TextAlign.center,
                  color: Color(ListColor.colorLightGrey14),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.2,
                )),
              ],
            )));
  }
}
