import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_truck_satuan/ZO_filter_truck_satuan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/checkbox_custom_widget_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoFilterTruckSatuanView extends GetView<ZoFilterTruckSatuanController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: Container(
            height: 64,
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
                Container(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 20,
                      10,
                      GlobalVariable.ratioWidth(Get.context) * 20,
                      5),
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
                                      width: GlobalVariable.ratioFontSize(
                                              context) *
                                          28,
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          28,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: GlobalVariable.ratioFontSize(
                                                context) *
                                            19,
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
                                    key: ValueKey(
                                        "Cari ${controller.title.value}"),
                                    context: Get.context,
                                    newContentPadding:
                                        EdgeInsets.fromLTRB(42, 10, 10, 10),
                                    onChanged: (value) {
                                      controller.onChange(value);
                                    },
                                    controller: controller
                                        .searchTextEditingController.value,
                                    textInputAction: TextInputAction.search,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    onSubmitted: (value) {
                                      controller.onChange(value);
                                    },
                                    textSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            14,
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey2)),
                                      hintText:
                                          "LelangMuatBuatLelangBuatLelangLabelTitleCari"
                                                  .tr +
                                              " " +
                                              controller.title.value,
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey7),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(ListColor.color4),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: SvgPicture.asset(
                                    "assets/search_magnifition_icon.svg",
                                    width:
                                        GlobalVariable.ratioFontSize(context) *
                                            28,
                                    height:
                                        GlobalVariable.ratioFontSize(context) *
                                            28),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: controller.isShowClearSearch.value
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.onChange("");
                                          controller
                                              .searchTextEditingController.value
                                              .clear();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: GlobalVariable.ratioFontSize(
                                                    Get.context) *
                                                28,
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
        body: Obx(
          () => Stack(
            children: [
              Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: GlobalVariable.ratioWidth(context) * 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller.listTempLocation.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        controller.onSave(
                                            controller.listTempLocation[index]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: GlobalVariable.ratioWidth(
                                                    context) *
                                                12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              height: GlobalVariable.ratioWidth(
                                                      context) *
                                                  59,
                                              width: GlobalVariable.ratioWidth(
                                                      context) *
                                                  65,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color(ListColor
                                                          .colorLightGrey2))),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                child: Image.network(
                                                  controller
                                                      .listTempLocation[index][
                                                          controller
                                                              .nameimg.value]
                                                      .toString(),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      context) *
                                                  24,
                                            ),
                                            Expanded(
                                              child: Stack(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  children: [
                                                    CustomText(
                                                        controller.listTempLocation[
                                                                index]
                                                            ["Description"],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            14),
                                                    CustomText("\n",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            14)
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 4),
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Color(ListColor.colorLightGrey10),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              controller.listTempLocation.length == 0
                  ? Positioned.fill(
                      child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: SvgPicture.asset(
                                "assets/ic_management_lokasi_no_search.svg",
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    82.3,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 75,
                              )),
                              Container(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                              Container(
                                  child: CustomText(
                                "LocationManagementLabelNoKeywordFoundFilter"
                                    .tr
                                    .replaceAll("\\n", "\n"),
                                textAlign: TextAlign.center,
                                color: Color(ListColor.colorLightGrey14),
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalVariable.ratioFontSize(context) * 14,
                                height: 1.2,
                              ))
                            ],
                          )))
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  _tidakAdaDataPencarian() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                top: GlobalVariable.ratioWidth(Get.context) * 20),
            child: Html(
                data: '<span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 500; color: #7C9CBF;">' +
                    'LelangMuatBuatLelangBuatLelangLabelTitleTidakDitemukanHasil'
                        .tr +
                    '</span> <span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000; font-style: italic;">"</span><span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000;">${controller.searchTextEditingController.value.text}</span><span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000; font-style: italic;">"</span>')),
        Expanded(
            child: Center(
          child: Positioned.fill(
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: SvgPicture.asset(
                        "assets/ic_management_lokasi_no_search.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 82.3,
                        height: GlobalVariable.ratioWidth(Get.context) * 75,
                      )),
                      Container(
                        height: 12,
                      ),
                      Container(
                          child: CustomText(
                        "LelangMuatBuatLelangBuatLelangLabelTitleKeywordTidakDitemukan"
                            .tr
                            .replaceAll("\\n", "\n"),
                        textAlign: TextAlign.center,
                        color: Color(ListColor.colorLightGrey14),
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        height: 1.2,
                      ))
                    ],
                  ))),
        ))
      ],
    );
  }
}
