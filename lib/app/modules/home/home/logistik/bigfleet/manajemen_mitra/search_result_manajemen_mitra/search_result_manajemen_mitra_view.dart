import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_type_enum.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'search_result_manajemen_mitra_controller.dart';

class SearchResultManajemenMitraView
    extends GetView<SearchResultManajemenMitraController> {
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
                              Obx(
                                () => Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CustomTextField(
                                        context: Get.context,
                                        enabled: false,
                                        controller: controller
                                            .searchTextEditingController.value,
                                        textInputAction: TextInputAction.search,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(
                                                ListColor.colorDarkGrey3)),
                                        newInputDecoration: InputDecoration(
                                            hintText:
                                                "GlobalLabelSearchCityHint".tr,
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
                                                GlobalVariable.ratioWidth(Get.context) *
                                                    36,
                                                GlobalVariable.ratioWidth(Get.context) *
                                                    9,
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    32,
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    0))),
                                  ],
                                ),
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
                          controller.showSorting();
                        },
                        child: Obx(()=>
                          Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.sortBgColor.value,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset("assets/sorting_icon.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) * 24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) * 24,
                                  color: controller.sortColor.value)),
                        )),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
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
                child: Obx(() => controller.isShowLoadingCircular.value
                    ? Center(
                        child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()),
                      )
                    : Stack(children: [
                        SmartRefresher(
                          enablePullUp: true,
                          controller: controller.refreshSearchController,
                          onLoading: () {
                            controller.getAllSearchMitra();
                          },
                          onRefresh: () {
                            controller.getAllSearchMitraOnRefresh(
                                isUsingLoadingManual: false);
                          },
                          child: ListView.builder(
                            itemCount: controller.listSearchMitra.length,
                            itemBuilder: (content, index) {
                              return controller.listWidget(content, index);
                              //mitraTile2(controller.listMitra[index]);
                            },
                          ),
                        ),
                        (controller.listSearchMitra.length == 0 &&
                                !controller.isGettingData.value)
                            ? Center(
                                child: CustomText(
                                    "PartnerManagementEmptyDataMitra".tr),
                              )
                            : SizedBox.shrink()
                      ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
