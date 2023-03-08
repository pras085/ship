import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_subuser/choose_subuser_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ChooseSubuserView extends GetView<ChooseSubuserController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
        child: Material(
          color: Colors.white,
          child: SafeArea(
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
              child: Container(
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
                                      context: Get.context,
                                      enabled:
                                          !(controller.listPaket.length == 0 &&
                                              controller.search.value.isEmpty),
                                      autofocus: true,
                                      onChanged: (value) {
                                        controller.searchOnSubmit(value,
                                            submit: false);
                                      },
                                      controller: controller.searchBar,
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) {
                                        controller.searchOnSubmit(value);
                                      },
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      textSize: 14,
                                      newInputDecoration: InputDecoration(
                                          hintText:
                                              'SubscriptionCreateLabelCariJenisPaket'
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
                                              GlobalVariable.ratioWidth(Get.context) *
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
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => controller.loading.value
            ? Container(
                color: Color(ListColor.colorLightGrey6),
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
                color: Color(ListColor.colorLightGrey6),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          controller.search.value.isEmpty
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.fromLTRB(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      GlobalVariable.ratioWidth(Get.context) * 4
                                      // ((GlobalVariable.ratioWidth(
                                      //             Get.context) *
                                      //         4) -
                                      //     FontTopPadding.getSize(14))
                                      ),
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontSize: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            fontFamily: 'AvenirNext',
                                            fontWeight: FontWeight.w500,
                                            color: Color(
                                                ListColor.colorDarkBlue2)),
                                        children: [
                                          controller.listPaket.length == 0
                                              ? TextSpan(
                                                  text:
                                                      ("LocationManagementLabelShowNoLocation"
                                                              .tr)
                                                          .replaceAll("\"", ""))
                                              : TextSpan(
                                                  text:
                                                      ("LocationManagementLabelShowLocation"
                                                              .tr)
                                                          .replaceAll(
                                                              "#number",
                                                              controller
                                                                  .listPaket
                                                                  .length
                                                                  .toString())
                                                          .replaceAll(
                                                              "\"", "")),
                                          TextSpan(
                                              text:
                                                  "\"${controller.search.value}\"",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                        ]),
                                  )),
                          Expanded(
                            child: Obx(() => Stack(
                                  children: [
                                    ListView.separated(
                                      itemCount: controller.listPaket.length,
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20,
                                        horizontal:
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16),
                                      separatorBuilder: (_, __) {
                                        return SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                        );
                                      },
                                      itemBuilder: (content, index) {
                                        return Material(
                                          color: Colors.transparent,
                                            child: InkWell(
                                            onTap: () {
                                              // print("indesss " +
                                              //     index.toString());
                                              controller
                                                  .onClickPaketSubuser(index);
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  border: index ==
                                                            controller.listPaket
                                                                    .length -
                                                                1 ? null : Border(
                                                                  bottom: BorderSide(
                                                                    color: Color(ListColor.colorLightGrey10),
                                                                  width: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      0.5,
                                                                  ),
                                                                ),
                                                ),
                                                constraints: BoxConstraints(
                                                  minHeight: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            49,
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                        controller.listPaket[
                                                                index][
                                                            controller
                                                                .subuserName],
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight
                                                                .w600,
                                                        color:
                                                            Colors.black),
                                                    (controller.listPaket[
                                                                    index]
                                                                [
                                                                controller
                                                                    .subuserDescription] as String)
                                                            .isEmpty
                                                        ? SizedBox.shrink()
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  height:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          4),
                                                              CustomText(
                                                                  controller.listPaket[index]
                                                                      [
                                                                      controller
                                                                          .subuserDescription],
                                                                  fontSize:
                                                                      12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      ListColor.colorLightGrey4)),
                                                            ],
                                                          ),
                                                  ],
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                    controller.listPaket.length != 0
                                        ? SizedBox.shrink()
                                        : Positioned.fill(
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        child: SvgPicture.asset(
                                                            controller
                                                                    .search
                                                                    .value
                                                                    .isEmpty
                                                                ? "assets/ic_management_lokasi_no_data.svg"
                                                                : "assets/ic_management_lokasi_no_search.svg",
                                                            height: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                (controller
                                                                        .search
                                                                        .value
                                                                        .isEmpty
                                                                    ? 75
                                                                    : 95))),
                                                    Container(
                                                      height: 12,
                                                    ),
                                                    Container(
                                                        child: CustomText(
                                                      controller.search.value
                                                              .isEmpty
                                                          ? "SubscriptionSubUserNoData"
                                                              .tr
                                                          : "LocationManagementLabelNoKeywordFound"
                                                              .tr
                                                              .replaceAll(
                                                                  "\\n", "\n"),
                                                      textAlign:
                                                          TextAlign.center,
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
    );
  }
}
