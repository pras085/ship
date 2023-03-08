import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/enum/list_data_design_type_button_corner_right_enum.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_result_list_transporter/search_result_list_transporter_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultListTransporterView
    extends GetView<SearchResultListTransporterController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Container(
      color: Color(ListColor.colorWhite),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
            child: Container(
              height: GlobalVariable.ratioWidth(Get.context) * 56,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(ListColor.colorBlack).withOpacity(0.15),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 15,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 4)),
              ], color: Colors.white),
              child:
                  // Stack(alignment: Alignment.bottomCenter, children: [
                  // Column(mainAxisSize: MainAxisSize.max, children: [
                  Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 12,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomBackButton(
                        context: Get.context,
                        iconColor: Color(ListColor.colorWhite),
                        backgroundColor: Color(ListColor.colorBlue),
                        onTap: () {
                          Get.back();
                        }),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.goToSearchPage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          1,
                                  color: Color(ListColor.colorStroke)),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CustomTextField(
                                      textSize: 14,
                                      context: Get.context,
                                      enabled: false,
                                      controller: controller.searchBar,
                                      textInputAction: TextInputAction.search,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Colors.black),
                                      newInputDecoration: InputDecoration(
                                          hintText:
                                              "LoadRequestInfoLabelSearchHint"
                                                  .tr,
                                          hintStyle: TextStyle(
                                              height: 1.2,
                                              fontWeight: FontWeight.w600,
                                              color: Color(
                                                  ListColor.colorLightGrey2)),
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          isDense: true,
                                          isCollapsed: true,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  36,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  9,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  32,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  0))),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6),
                                child: SvgPicture.asset(
                                  "assets/ic_search.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    GestureDetector(
                        onTap: () {
                          if(!controller.loadingTransporter.value && controller.listTransporterLength.value > 0)
                            controller.showSort();
                        },
                        child: Obx(()=>
                          Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (controller.sortTransporter.isNotEmpty)
                                        ? Colors.black 
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset("assets/sorting_icon.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) * 24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) * 24,
                                  color: controller.listTransporterLength.value == 0 ? Color(ListColor.colorLightGrey2) : (controller.sortTransporter.isNotEmpty) ? Colors.white : Colors.black)),
                        )),
                  ],
                ),
              ),
              // ]),
              // Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 2,
              //     color: Color(ListColor.colorLightBlue5))
              // ]),
            ),
          ),
          body: Obx(
            () => controller.loadingTransporter.value
                ? Center(
                    child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()),
                  )
                : Column(
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
                          padding: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 16,
                              top: GlobalVariable.ratioWidth(Get.context) * 18,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 14),
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    fontFamily: 'AvenirNext',
                                    fontWeight: FontWeight.w500,
                                    color: Color(ListColor.colorDarkBlue2)),
                                children: [
                                  controller.searchBar.text.isEmpty ||
                                          controller.listTransporterLength
                                                  .value ==
                                              0
                                      ? TextSpan(
                                          text:
                                              "LocationManagementLabelShowNoLocation"
                                                  .tr)
                                      : TextSpan(
                                          text:
                                              ("ListTransporterLabelFound"
                                                      .tr)
                                                  .replaceAll(
                                                      "#number",
                                                      controller.totalAll.value
                                                          .toString())),
                                  TextSpan(
                                      text: "\"${controller.searchBar.text}\"",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ]),
                          )),
                      // Container(
                      //   padding: EdgeInsets.only(
                      //       left: GlobalVariable.ratioWidth(Get.context) * 16,
                      //       top: GlobalVariable.ratioWidth(Get.context) * 18,
                      //       bottom:
                      //           GlobalVariable.ratioWidth(Get.context) * 14),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Obx(
                      //         () => Text.rich(
                      //           TextSpan(
                      //               children: controller
                      //                   .listHasilPencarianInlineSpan
                      //                   .map((data) => data as InlineSpan)
                      //                   .toList()),
                      //           textAlign: TextAlign.center,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child:
                            // Obx(
                            //   () => controller.loadingTransporter.value
                            //       ? Center(
                            //           child: Container(
                            //               width: 30,
                            //               height: 30,
                            //               child: CircularProgressIndicator()),
                            //         )
                            //       : (controller.listTransporterLength.value == 0)
                            //           ? Center(
                            //               child: CustomText(
                            //                   "PartnerManagementEmptyDataMitra".tr),
                            //             )
                            //           :
                            Stack(
                          children: [
                            SmartRefresher(
                              enablePullUp: true,
                              controller: controller.refreshController,
                              onLoading: () {
                                controller.loadData();
                              },
                              onRefresh: () {
                                controller.refreshData();
                              },
                              child: ListView.builder(
                                itemCount:
                                    controller.listTransporterLength.value,
                                itemBuilder: (content, index) {
                                  return transporterView(index);
                                },
                              ),
                            ),
                            controller.listTransporterLength.value != 0
                                ? SizedBox.shrink()
                                : controller.searchBar.text.isNotEmpty
                                    ? _noSearchPlaceholder()
                                    : _noDataPlaceholder(
                                        'Belum ada\n data Transporter'.tr)
                          ],
                        ),
                        // ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget transporterView(int index) {
    return controller.listTransporter.getTransporterTileWidget(index,
        typeButton: ListDataDesignTypeButtonCornerRight.THREE_DOT_VERT,
        dari: ListDataMitraFrom.TRANSPORTER, onTapBottonCornerRight: () {
      controller.showTransporterOption(index);
    });
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
                  // width: GlobalVariable.ratioWidth(Get.context) * 84,
                  height: GlobalVariable.ratioWidth(Get.context) * 95,
                )),
                Container(
                  height: 12,
                ),
                Container(
                    child: CustomText(
                  "LocationManagementLabelNoKeywordFound"
                      .tr
                      .replaceAll("\\n", "\n"),
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
