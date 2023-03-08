import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/select_head_carrier/select_head_carrier_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_custom2.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiver/strings.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SelectHeadCarrierView extends GetView<SelectHeadCarrierController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

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
                                        controller.onClearSearch();
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
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                CustomTextField(
                                    context: Get.context,
                                    autofocus: true,
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
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    newContentPadding: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            36,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6),
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText: controller.title,
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey2)),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey10),
                                            width: GlobalVariable.ratioWidth(
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
                                            width: GlobalVariable.ratioWidth(
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
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                1.0),
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                8),
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: SvgPicture.asset(
                                    "assets/search_magnifition_icon.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    color: Color(ListColor.color4),
                                  ),
                                ),
                                Obx(
                                  () => Align(
                                    alignment: Alignment.centerRight,
                                    child: controller
                                            .filterSearch.value.isNotEmpty
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ]),
            ),
          ),
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
                        CustomText("ListTransporterLabelLoading".tr,
                            fontSize: 12, fontWeight: FontWeight.normal),
                        // Text("Loading"),
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
                                  child: CustomText("Data not found",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal))
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
                                            Radius.circular(40)),
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
        margin: EdgeInsets.only(
            top: index != 0 ? 0 : GlobalVariable.ratioWidth(Get.context) * 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                controller.selectedData.value =
                    controller.filteredData[index]["ID"];
                if (!controller.showButtonSave) {
                  var data = List.from(controller.listData).firstWhere(
                      (element) =>
                          element["ID"] == controller.selectedData.value);
                  controller.filterSearch.value = "";
                  controller.onClearSearch();
                  Get.back(result: data);
                }
              },
              child: Obx(
                () => Container(
                    padding: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 6),
                    margin: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 10,
                        vertical: GlobalVariable.ratioWidth(Get.context) * 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: controller.filteredData.length <= index
                          ? Colors.transparent
                          : controller.filteredData[index]["ID"] ==
                                  controller.selectedData.value
                              ? Color(ListColor.colorLightGrey17WithOpacity)
                              : Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: GlobalVariable.ratioWidth(Get.context) *
                                64, // 80,
                            height: GlobalVariable.ratioWidth(Get.context) * 58,
                            margin: EdgeInsets.only(
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        8)),
                                border: Border.all(
                                    color: Color(ListColor.colorLightGrey2),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            1)),
                            child: Obx(
                              () => controller.filteredData.length <= index
                                  ? Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    8)),
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      fit: BoxFit.cover,
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
                                                        8)),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover)),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                            )),
                        Expanded(
                            child: Obx(
                          () => SubstringHighlight(
                              text: controller.filteredData.length <= index
                                  ? ""
                                  : controller.filteredData[index]
                                      ["Description"],
                              term: controller.filterSearch.value,
                              textStyle: TextStyle(
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14,
                                  color: Color(ListColor.colorGrey4),
                                  fontWeight: FontWeight.w600),
                              textStyleHighlight: TextStyle(
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14,
                                  color: Color(ListColor.color4),
                                  fontWeight: FontWeight.bold)),
                        ))
                      ],
                    )),
              ),
            ),
            // index == controller.filteredData.length - 1
            //     ? SizedBox.shrink()
            //     : Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 16),
            //         child:
            //             Divider(height: 2, color: Color(ListColor.colorLightGrey5)),
            //       )
          ],
        ));
  }
}
