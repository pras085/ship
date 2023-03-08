import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_list_transporter/search_list_transporter_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class SearchListTransporterView
    extends GetView<SearchListTransporterController> {
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
                  //  Stack(alignment: Alignment.bottomCenter, children: [
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
                        iconColor: Color(ListColor.colorWhite),
                        backgroundColor: Color(ListColor.colorBlue),
                        onTap: () {
                          Get.back();
                        }),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    Obx(
                      () => Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          1,
                                  color: Color(ListColor.colorLightGrey10)),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CustomTextField(
                                      context: Get.context,
                                      autofocus: true,
                                      onChanged: (value) {
                                        controller.searchOnChange(value);
                                      },
                                      controller: controller.searchBar,
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) {
                                        controller.onSubmitSearch();
                                      },
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          height: 1.2,
                                          color: Colors.black),
                                      textSize: 14,
                                      newInputDecoration: InputDecoration(
                                          hintText:
                                              "ListTransporterLabelCariTransporter"
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: controller.isShowClearSearch.value
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.onClearSearch();
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        4),
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24,
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24,
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              "assets/ic_close1,5.svg",
                                              color:
                                                  Color(ListColor.colorGrey3),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  15,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  15,
                                            )))
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //   ]),
              //   Container(
              //       width: MediaQuery.of(context).size.width,
              //       height: 2,
              //       color: Color(ListColor.colorLightBlue5))
              // ]),
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
                  GlobalVariable.ratioWidth(Get.context) * 8
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText("LoadRequestInfoLabelLastSearch".tr,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.2,
                        color: Colors.black),
                    GestureDetector(
                      onTap: () {
                        controller.removeAllHistory();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CustomText("LoadRequestInfoLabelDeleteAll".tr,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            height: 1.2,
                            color: Color(ListColor.colorRed2)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      itemCount: controller.lastSearch.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.onClickHistorySearch(index);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16, vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/timer_icon.svg",
                                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                                        height: GlobalVariable.ratioWidth(Get.context) * 16,
                                      ),
                                      SizedBox(
                                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                            controller.lastSearch[index],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.removeHistory(index);
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: GlobalVariable.ratioWidth(Get.context) * 16,
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
