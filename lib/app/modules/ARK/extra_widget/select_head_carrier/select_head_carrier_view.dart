import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_head_carrier/select_head_carrier_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_custom2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiver/strings.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SelectHeadCarrierView extends GetView<SelectHeadCarrierController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(ListColor.color4),
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
                        GlobalVariable.ratioWidth(Get.context) * 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            child: GestureDetector(
                                onTap: () {
                                  controller.onClearSearch();
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
                          width: GlobalVariable.ratioWidth(Get.context) * 12,
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              CustomTextField(
                                  context: Get.context,
                                  controller: controller.searchBar,
                                  textInputAction: TextInputAction.search,
                                  onChanged: (String str) async {
                                    controller.filterSearch.value = str;
                                    controller.refreshData(false);
                                  },
                                  onSubmitted: (String str) async {
                                    controller.filterSearch.value = str;
                                    controller.refreshData(false);
                                  },
                                  textSize: 14,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  newInputDecoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText: controller.title,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorGrey3)),
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          32,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          9,
                                      bottom: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              1),
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              7),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              1),
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              7),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(ListColor.color4),
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              1),
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              7),
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            2),
                                child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      "ic_search_blue.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Obx(
                                    () => controller.filterSearch.value.isEmpty
                                        ? SizedBox.shrink()
                                        : Container(
                                            margin: EdgeInsets.only(right: 7),
                                            child: GestureDetector(
                                                onTap: () {
                                                  controller.onClearSearch();
                                                },
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  size:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                )))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: Color(ListColor.colorLightBlue5))
              ]),
            ),
          ),
          // AppBarCustom2(
          //     preferredSize: Size.fromHeight(_appBar.preferredSize.height + 10),
          //     searchInput: controller.searchBar,
          //     listOption: [SizedBox.shrink()],
          //     onSearch: (String str) async {
          //       controller.filterSearch.value = str;
          //       // controller.showSuggestion.value = false;
          //       // controller.showSearch.value = false;
          //       controller.refreshData(false);
          //     },
          //     onChange: (String str) async {
          //       controller.filterSearch.value = str;
          //       // controller.showSuggestion.value = false;
          //       // controller.showSearch.value = false;
          //       controller.startTimerGetMitra();
          //     },
          //     onClear: () async {
          //       controller.filterSearch.value = "";
          //       // controller.showSuggestion.value = false;
          //       // controller.showSearch.value = false;
          //       controller.refreshData(false);
          //     }),
          body: Obx(
            () => controller.loading.value
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
                      ],
                    ))
                : Container(
                    color: Colors.grey[100],
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Obx(() => controller.filteredData.length == 0
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        GlobalVariable.imagePath +
                                            "ic_pencarian_tidak_ditemukan.svg",
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            82,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            93,
                                      ),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              15),
                                      CustomText(
                                          'InfoPraTenderIndexLabelSearchKeyword'
                                                  .tr +
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
                                )
                              : SmartRefresher(
                                  enablePullUp: true,
                                  controller:
                                      controller.refreshTransporterController,
                                  onLoading: () {
                                    controller.loadData();
                                  },
                                  onRefresh: () {
                                    controller.refreshData(true);
                                  },
                                  child: ListView.builder(
                                    itemCount: controller.filteredData.length,
                                    itemBuilder: (content, index) {
                                      return itemView(index);
                                    },
                                  ),
                                )),
                        ),
                        controller.showButtonSave
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x54000000),
                                      spreadRadius: 2,
                                      blurRadius: 30,
                                    ),
                                  ],
                                ),
                                child: FlatButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 20),
                                    onPressed: () {
                                      var data = List.from(controller.listData)
                                          .firstWhere((element) =>
                                              element["ID"] ==
                                              controller.selectedData.value);
                                      controller.filterSearch.value = "";
                                      Get.back(result: data);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    40)),
                                        side: BorderSide(
                                            color: Color(ListColor.color4),
                                            width: 2)),
                                    child: CustomText("Simpan",
                                        textAlign: TextAlign.center,
                                        color: Color(ListColor.color4))),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
          ),
        )));
  }

  Widget itemView(int index) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            controller.selectedData.value =
                controller.filteredData[index]["ID"];

            if (!controller.showButtonSave) {
              var data = List.from(controller.listData).firstWhere(
                  (element) => element["ID"] == controller.selectedData.value);
              controller.filterSearch.value = "";
              controller.onClearSearch();
              Get.back(result: data);
            }
          },
          child: Container(
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 65, // 80,
                    height: GlobalVariable.ratioWidth(Get.context) * 59,
                    margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(Get.context) * 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 12)),
                        border: Border.all(
                            color: Color(ListColor.colorLightGrey2), width: 1)),
                    child: Obx(
                      () => controller.filteredData.length <= index
                          ? Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        19)),
                              ),
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: controller.filteredData[index]
                                      ["ImageHead"] ??
                                  controller.filteredData[index]
                                      ["ImageCarrier"] ??
                                  "",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain)),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                            ),
                    )),
                Expanded(
                    child: Obx(
                  () => CustomText(
                      controller.filteredData[index]["Description"],
                      fontSize: 14,
                      color: Color(ListColor.colorGrey4),
                      fontWeight: FontWeight.w700),
                ))
              ],
            ),
          ),
        ),
        index == controller.filteredData.length - 1
            ? SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
                child: controller.lineDividerWidget(),
              )
      ],
    ));
  }
}
