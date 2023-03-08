import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/modules/search_location_lokasi_truk_siap_muat/search_location_lokasi_truk_siap_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class SearchLocationLokasiTrukSiapMuatView
    extends GetView<SearchLocationLokasiTrukSiapMuatController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
        onWillPop: () async {
          controller.onClearSearch();
          return true;
        },
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(64),
                child: Container(
                  height: 64,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color(ListColor.colorBlack).withOpacity(0.15),
                        blurRadius: GlobalVariable.ratioWidth(context) * 15,
                        spreadRadius: 0,
                        offset: Offset(0, GlobalVariable.ratioWidth(context) * 4)),
                  ], color: Colors.white),
                  padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(context) * 16,
                  ),
                  child: Obx(
                    () => Row(
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
                                        width: 30,
                                        height: 30,
                                        child: Center(
                                            child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          size: 20,
                                          color: Colors.white,
                                        ))))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Obx(
                                () => CustomTextField(
                                    autofocus: true,
                                    onChanged: (value) {
                                      controller.addTextSearch(value);
                                    },
                                    controller: controller
                                        .searchTextEditingController
                                        .value,
                                    textInputAction:
                                        TextInputAction.search,
                                    onSubmitted: (value) {
                                      controller.addTextSearch(value);
                                    },
                                    newContentPadding:
                                        EdgeInsets.symmetric(
                                            horizontal: 42,
                                            vertical: GlobalVariable
                                                    .ratioHeight(
                                                        context) *
                                                6),
                                    textSize: 14,
                                    // borderRadius: 10,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    context: Get.context,
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText:
                                          "Cari Alamat Pickup", // controller.hintText.value,
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Color(
                                              ListColor.colorLightGrey2),
                                          fontWeight: FontWeight.w600),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(ListColor
                                                .colorLightGrey7),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(ListColor
                                                .colorLightGrey7),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(ListColor
                                                .colorLightGrey7),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: SvgPicture.asset(
                                  "assets/search_magnifition_icon.svg",
                                  width: 30,
                                  height: 30,
                                  color: Color(ListColor.colorGrey5),
                                ),
                              ),
                              Obx(
                                () => Align(
                                  alignment: Alignment.centerRight,
                                  child: controller.isSearchMode.value
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.onClearSearch();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 10),
                                              child: Icon(
                                                Icons.close_rounded,
                                                size: GlobalVariable
                                                        .ratioHeight(
                                                            Get.context) *
                                                    24,
                                              )),
                                        )
                                      : SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        !controller.showTopRightMarker.value
                            ? SizedBox.shrink()
                            : Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          controller.numberOfMarker != "1"
                                              ? "assets/pin_blue_icon.svg"
                                              : "assets/pin_yellow_icon.svg",
                                          width: 35,
                                          height: 35,
                                        ),
                                        Container(
                                          child: CustomText(
                                              controller.numberOfMarker,
                                              color: controller
                                                          .numberOfMarker !=
                                                      "1"
                                                  ? Colors.white
                                                  : Color(
                                                      ListColor.color4),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        )
                                      ]),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.onClickSetPositionMarker();
                            },
                            child: _containerPerItem(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/target_location_icon.svg",
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          19,
                                    ),
                                    SizedBox(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                    ),
                                    CustomText(
                                        "LoadRequestInfoLabelChooseLocation".tr,
                                        fontSize: 12,
                                        color: Color(ListColor.color4),
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                                verticalPadding:
                                    GlobalVariable.ratioHeight(Get.context) *
                                        16),
                          ),
                        ),
                        Obx(
                          () => (controller.isSearchMode.value ||
                                  controller.listSearchAddress.length != 0)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      _lineSaparator(),
                                      SizedBox(
                                        height: GlobalVariable.ratioHeight(
                                                Get.context) *
                                            8,
                                      ),
                                      _containerPerItem(
                                        child: CustomText(
                                            controller.isSearchMode.value
                                                ? "LoadRequestInfoLabelSearchResult"
                                                    .tr
                                                : "LoadRequestInfoLabelLastSearch"
                                                    .tr,
                                            fontSize: 10,
                                            color: Color(
                                                ListColor.colorLightGrey14),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: controller
                                                .isSearchingData.value
                                            ? [
                                                Container(
                                                    height: 100,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Center(
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    ))
                                              ]
                                            : controller.listSearchAddress
                                                        .length ==
                                                    0
                                                ? [
                                                    Container(
                                                        height: 100,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Center(
                                                          child: CustomText(
                                                            "LoadRequestInfoLabelNoData"
                                                                .tr,
                                                            fontSize: 14,
                                                          ),
                                                        ))
                                                  ]
                                                : _getListAddress(
                                                    context,
                                                    controller
                                                        .listSearchAddress),
                                      ),
                                    ])
                              : SizedBox.shrink(),
                        ),
                        Obx(
                          () => controller.isGettingSavedLocation.value
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: Center(
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator())))
                              : controller.listSaveLocation.length > 0
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _lineSaparator(),
                                        SizedBox(
                                            height: GlobalVariable.ratioHeight(
                                                    Get.context) *
                                                8),
                                        _containerPerItem(
                                          child: CustomText(
                                              "LoadRequestInfoLabelLocationManagement"
                                                  .tr,
                                              fontSize: 10,
                                              color: Color(
                                                  ListColor.colorLightGrey14),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                            height: GlobalVariable.ratioHeight(
                                                    Get.context) *
                                                6),
                                        Obx(
                                          () => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: _getListSaveLocation(
                                                context,
                                                controller.listSaveLocation),
                                          ),
                                        ),
                                        SizedBox(
                                            height: GlobalVariable.ratioHeight(
                                                    Get.context) *
                                                6),
                                        _containerPerItem(
                                          child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .goToListAllManajemenLokasi();
                                                  },
                                                  child: CustomText(
                                                      "LoadRequestInfoLabelViewLocationManagement"
                                                          .tr,
                                                      fontSize: 10,
                                                      color: Color(
                                                          ListColor.color4),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ]),
                                        ),
                                        SizedBox(
                                            height: GlobalVariable.ratioHeight(
                                                    Get.context) *
                                                2)
                                      ],
                                    )
                                  : SizedBox.shrink(),
                        ),
                        Obx(
                          () => controller
                                      .listHistoryTransactionLocation.length >
                                  0
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _lineSaparator(isUsingMarginVertical: true),
                                    _containerPerItem(
                                      child: CustomText(
                                          "LoadRequestInfoLabelLastTransaction"
                                              .tr,
                                          fontSize: 10,
                                          color:
                                              Color(ListColor.colorLightGrey14),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Obx(
                                      () => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children:
                                            _getListHistoryTransactionLocation(
                                                context,
                                                controller
                                                    .listHistoryTransactionLocation),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox.shrink(),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }

  Widget _containerPerItem(
      {@required Widget child, double verticalPadding = 0}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 26,
          vertical: verticalPadding),
      child: child,
    );
  }

  Widget _lineSaparator({bool isUsingMarginVertical = false}) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 26,
            vertical: isUsingMarginVertical
                ? GlobalVariable.ratioHeight(Get.context) * 8
                : 0),
        height: 1,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey10));
  }

  List<Widget> _getListAddress(BuildContext context, RxList<dynamic> listData) {
    List<Widget> listWidget = [];
    for (int i = 0; i < listData.length; i++) {
      listWidget.add(Material(
        child: InkWell(
          onTap: () {
            controller.onClickAddress(i);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioHeight(Get.context) * 8,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 26),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 3,
                ),
                SvgPicture.asset("assets/pin_white_icon.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 13),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 22,
                ),
                Expanded(
                  child: CustomText(listData[i].addressAutoComplete.description,
                      fontSize: 12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: Color(ListColor.colorDarkGrey3),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                GestureDetector(
                  onTap: () {
                    controller.onClickSaveLocation(
                        address: listData[i].addressAutoComplete.description,
                        placeID: listData[i].addressAutoComplete.placeId);
                  },
                  child: SvgPicture.asset(
                    "assets/unmarked_icon.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 10,
                    height: GlobalVariable.ratioWidth(Get.context) * 14,
                  ),
                ),
              ])),
        ),
      ));
    }
    return listWidget;
  }

  List<Widget> _getListSaveLocation(
      BuildContext context, RxList<dynamic> listData) {
    List<Widget> listWidget = [];
    for (int i = 0; i < listData.length; i++) {
      listWidget.add(Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.onClickListSaveLocation(i);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioHeight(Get.context) * 6,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 30),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: FontTopPadding.getSize(12)),
                      child: SvgPicture.asset(
                        "assets/marked_icon.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                        height: GlobalVariable.ratioWidth(Get.context) * 14,
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(listData[i].name,
                                fontSize: 12,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                color: Color(ListColor.colorDarkGrey4),
                                fontWeight: FontWeight.w700),
                            SizedBox(
                                height:
                                    GlobalVariable.ratioHeight(Get.context) *
                                        4),
                            CustomText(listData[i].address,
                                fontSize: 12,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                color: Color(ListColor.colorGrey3),
                                fontWeight: FontWeight.w500),
                          ]),
                    ),
                    // SizedBox(
                    //   width: GlobalVariable.ratioWidth(Get.context) * 20,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     controller.onClickEditSaveLocation(i);
                    //   },
                    //   child: Container(
                    //     color: Colors.transparent,
                    //     width: 35,
                    //     height: 40,
                    //     child: Center(
                    //       child: SvgPicture.asset(
                    //         "assets/edit_pencil_icon.svg",
                    //         width: 15,
                    //         height: 15,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ])),
        ),
      ));
    }
    return listWidget;
  }

  List<Widget> _getListHistoryTransactionLocation(
      BuildContext context, RxList<dynamic> listData) {
    List<Widget> listWidget = [];
    for (int i = 0; i < listData.length; i++) {
      listWidget.add(Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.onClickListHistoryTransactionLocation(i);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioHeight(Get.context) * 8,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 28),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                SvgPicture.asset(
                  "assets/timer_icon.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 14,
                  height: GlobalVariable.ratioWidth(Get.context) * 17,
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 18,
                ),
                Expanded(
                  child: CustomText(listData[i].address,
                      fontSize: 12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: Color(ListColor.colorDarkGrey3),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                GestureDetector(
                  onTap: () {
                    controller.onClickSaveLocation(
                        address: listData[i].address);
                  },
                  child: SvgPicture.asset(
                    "assets/unmarked_icon.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 10,
                    height: GlobalVariable.ratioWidth(Get.context) * 14,
                  ),
                ),
              ])),
        ),
      ));
    }
    return listWidget;
  }
}
