import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_result_list_management_lokasi/search_result_list_management_lokasi_controller.dart';

import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultListManagementLokasiView
    extends GetView<SearchResultListManagementLokasiController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () {
        controller.onWillPop();
        return Future.value(false);
      },
      child: Container(
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
                      offset: Offset(
                          0, GlobalVariable.ratioWidth(Get.context) * 4)),
                ], color: Colors.white),
                child:
                    // Stack(alignment: Alignment.bottomCenter, children: [
                    //   Column(mainAxisSize: MainAxisSize.max, children: [
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
                          backgroundColor: Color(ListColor.colorBlue),
                          iconColor: Color(ListColor.colorWhite),
                          onTap: () {
                            controller.onWillPop();
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
                                    GlobalVariable.ratioWidth(Get.context) *
                                        8)),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CustomTextField(
                                        context: Get.context,
                                        enabled: false,
                                        controller: controller.searchBar,
                                        textInputAction: TextInputAction.search,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor.colorBlack)),
                                        textSize: 14,
                                        newInputDecoration: InputDecoration(
                                            hintText:
                                                "LoadRequestInfoLabelSearchHint"
                                                    .tr,
                                            hintStyle: TextStyle(
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
                                                    8,
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
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
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
                            controller.showSort();
                          },
                          child: Obx(
                            () => Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.sort.keys.isNotEmpty
                                      ? Color(ListColor.color4)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                    "assets/sorting_icon.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    color: controller.sort.keys.isNotEmpty
                                        ? Colors.white
                                        : Colors.black)),
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
            body: SafeArea(
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Obx(
                            () => Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // controller.filterSearch.value.isEmpty ||
                                //         controller.listManagementLokasiLength
                                //                 .value ==
                                //             0
                                //     ? SizedBox.shrink()
                                //     :
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14),
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      12,
                                              fontFamily: 'AvenirNext',
                                              fontWeight: FontWeight.w500,
                                              color: Color(
                                                  ListColor.colorDarkBlue2)),
                                          children: [
                                            controller.filterSearch.value
                                                        .isEmpty ||
                                                    controller
                                                            .listManagementLokasiLength
                                                            .value ==
                                                        0
                                                ? TextSpan(
                                                    text: ("LocationManagementLabelShowNoLocation"
                                                            .tr)
                                                        .replaceAll("\"", ""))
                                                : TextSpan(
                                                    text:
                                                        ("LocationManagementLabelShowLocation"
                                                                .tr)
                                                            .replaceAll(
                                                                "#number",
                                                                controller
                                                                    .totalAll
                                                                    .value
                                                                    .toString())
                                                            .replaceAll(
                                                                "\"", "")),
                                            TextSpan(
                                                text:
                                                    "\"${controller.filterSearch.value}\"",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            // TextSpan(text: "\"")
                                          ]),
                                    )),
                                Expanded(
                                  child: Obx(() => Stack(
                                        children: [
                                          SmartRefresher(
                                            enablePullUp: true,
                                            controller: controller
                                                .refreshManagementLokasiController,
                                            onLoading: () {
                                              controller.loadData();
                                            },
                                            onRefresh: () {
                                              controller.refreshData();
                                            },
                                            child: ListView.builder(
                                              itemCount: controller
                                                  .listManagementLokasiLength
                                                  .value,
                                              itemBuilder: (content, index) {
                                                return _listPerItem(index,
                                                    controller.listData[index]);
                                              },
                                            ),
                                          ),
                                          controller.listManagementLokasiLength
                                                      .value !=
                                                  0
                                              ? SizedBox.shrink()
                                              : Positioned.fill(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              child: SvgPicture
                                                                  .asset(
                                                            "assets/ic_management_lokasi_no_search.svg",
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                95,
                                                          )),
                                                          Container(
                                                            height: 12,
                                                          ),
                                                          Container(
                                                              child: CustomText(
                                                            "LocationManagementLabelNoKeywordFound"
                                                                .tr
                                                                .replaceAll(
                                                                    "\\n",
                                                                    "\n"),
                                                            textAlign: TextAlign
                                                                .center,
                                                            color: Color(ListColor
                                                                .colorLightGrey14),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            height: 1.2,
                                                          ))
                                                        ],
                                                      ))),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listPerItem(int index, ListManagementLokasiModel data) {
    return controller.listPerItem(index, data);
  }
}
