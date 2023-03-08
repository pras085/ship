import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'search_location_ubah_data_controller.dart';

class SearchLocationUbahDataView extends GetView<SearchLocationUbahDataController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
        onWillPop: () {
          controller.onClearSearch();
          Get.back(result: 'back');
        },
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(context) * 64),
                child: Container(
                  height: GlobalVariable.ratioWidth(context) * 64,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(color: Color(ListColor.colorLightGrey).withOpacity(0.5), blurRadius: 10, spreadRadius: 2, offset: Offset(0, 8)),
                  ], color: Colors.white),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Column(mainAxisSize: MainAxisSize.max, children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * 16, 10.0, GlobalVariable.ratioWidth(Get.context) * 16, 5),
                        child: Obx(
                          () => Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                child: ClipOval(
                                  child: Material(
                                    shape: CircleBorder(),
                                    // color: Color(ListColor.color4),
                                    child: InkWell(
                                      onTap: () {
                                        controller.onClearSearch();
                                        // Get.back();
                                        Get.back(result: 'back');
                                      },
                                      child: Container(
                                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                                        child: Center(
                                          child: Image.asset(
                                            "assets/template_buyer/backnew.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      height: GlobalVariable.ratioWidth(context) * 40,
                                      width: GlobalVariable.ratioWidth(context) * 292,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(0xFFCECECE),
                                          ),
                                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6)),
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        autofocus: true,
                                        onChanged: (value) {
                                          controller.searchvalue.value = value;
                                          controller.addTextSearch(value);
                                        },
                                        controller: controller.searchTextEditingController.value,
                                        textInputAction: TextInputAction.search,
                                        onSubmitted: (value) {
                                          controller.addTextSearch(value);
                                        },
                                        newContentPadding: EdgeInsets.symmetric(
                                            horizontal: controller.devicetype.value == 'tablet' ? 52 : 42, //42,
                                            vertical: GlobalVariable.ratioWidth(context) * 6),
                                        textSize: 14,
                                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                                        context: Get.context,
                                        newInputDecoration: InputDecoration(
                                          isDense: true,
                                          isCollapsed: true,
                                          hintText: "Cari Alamat", //alamat palsu // controller.hintText.value,
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          hintStyle: TextStyle(color: Color(ListColor.colorLightGrey2), fontWeight: FontWeight.w600),
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 7),
                                      child: Image.asset(
                                        "assets/cari.png",
                                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                                        color: controller.searchvalue.value == "" ? Color(0XFFCECECE) : Colors.black,
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
                                                    margin: EdgeInsets.only(right: 10),
                                                    child: Icon(
                                                      Icons.close_rounded,
                                                      size: GlobalVariable.ratioWidth(Get.context) * 24,
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: GlobalVariable.ratioWidth(Get.context) * 11,
                                        ),
                                        // Stack(
                                        //     alignment: Alignment.topCenter,
                                        //     children: [
                                        //       SvgPicture.asset(
                                        //         controller.totalMarker.value ==
                                        //                 1
                                        //             ? "assets/pin_truck_icon.svg"
                                        //             : controller.numberOfMarker ==
                                        //                     "1"
                                        //                 ? "assets/pin_yellow_icon.svg"
                                        //                 : "assets/pin_blue_icon.svg",
                                        //         width:
                                        //             GlobalVariable.ratioWidth(
                                        //                     Get.context) *
                                        //                 16,
                                        //         height:
                                        //             GlobalVariable.ratioWidth(
                                        //                     Get.context) *
                                        //                 22,
                                        //       ),
                                        //       Container(
                                        //         margin: EdgeInsets.only(
                                        //             top: GlobalVariable
                                        //                     .ratioWidth(
                                        //                         Get.context) *
                                        //                 6),
                                        //         child: CustomText(
                                        //             controller.totalMarker
                                        //                         .value ==
                                        //                     1
                                        //                 ? ""
                                        //                 : controller
                                        //                     .numberOfMarker,
                                        //             color: controller
                                        //                         .numberOfMarker !=
                                        //                     "1"
                                        //                 ? Colors.white
                                        //                 : Color(
                                        //                     ListColor.color4),
                                        //             fontWeight: FontWeight.w700,
                                        //             fontSize: 8),
                                        //       )
                                        //     ]),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Container(width: MediaQuery.of(context).size.width, height: 2, color: Color(ListColor.colorLightBlue5))
                  ]),
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
                                      width: GlobalVariable.ratioWidth(Get.context) * 19,
                                    ),
                                    // Image.asset("assets/target.png", width: GlobalVariable.ratioWidth(
                                    // Get.context) * 19,),
                                    SizedBox(
                                      width: GlobalVariable.ratioWidth(Get.context) * 20,
                                    ),
                                    CustomText("LoadRequestInfoLabelChooseLocation".tr,
                                        fontSize: 14, color: Color(ListColor.color4), fontWeight: FontWeight.w600),
                                  ],
                                ),
                                verticalPadding: GlobalVariable.ratioWidth(Get.context) * 16),
                          ),
                        ),
                        Obx(
                          () => controller.isSearchMode.value || controller.listSearchAddress.length > 0
                              ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  _lineSaparator(),
                                  SizedBox(
                                    height: GlobalVariable.ratioWidth(Get.context) * 18,
                                  ),
                                  _containerPerItem(
                                    child: CustomText(
                                        controller.isSearchMode.value ? "LoadRequestInfoLabelSearchResult".tr : "LoadRequestInfoLabelLastSearch".tr,
                                        fontSize: 16,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(height: GlobalVariable.ratioWidth(Get.context) * 6),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: controller.isSearchingData.value
                                        ? [
                                            Container(
                                                height: 100,
                                                width: MediaQuery.of(context).size.width,
                                                child: Center(
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                ))
                                          ]
                                        : controller.listSearchAddress.length == 0
                                            ? [
                                                Container(
                                                    height: 100,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Center(
                                                      child: CustomText(
                                                        "LoadRequestInfoLabelNoData".tr,
                                                        fontSize: 14,
                                                      ),
                                                    ))
                                              ]
                                            : _getListAddress(context, controller.listSearchAddress),
                                  ),
                                  Container(height: GlobalVariable.ratioWidth(Get.context) * 12),
                                ])
                              : SizedBox.shrink(),
                        ),
                        Obx(
                          () => controller.isGettingSavedLocation.value
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: Center(child: Container(width: 30, height: 30, child: CircularProgressIndicator())))
                              : controller.listSaveLocation.length > 0
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _lineSaparator(),
                                        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            _containerPerItem(
                                              child: CustomText("LoadRequestInfoLabelLocationManagement".tr,
                                                  fontSize: 16, color: Color(0XFF000000), fontWeight: FontWeight.w600),
                                            ),
                                            _containerPerItem(
                                              child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.goToListAllManajemenLokasi();
                                                  },
                                                  child: CustomText(
                                                      // "LoadRequestInfoLabelViewLocationManagement"
                                                      //     .tr,
                                                      "Lihat Selengkapnya",
                                                      fontSize: 12,
                                                      color: Color(ListColor.color4),
                                                      fontWeight: FontWeight.w500),
                                                )
                                              ]),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 6),
                                        Obx(
                                          () => Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: _getListSaveLocation(context, controller.listSaveLocation),
                                          ),
                                        ),
                                        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 6),
                                        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18)
                                      ],
                                    )
                                  : SizedBox.shrink(),
                        ),
                        Obx(
                          () => controller.listHistoryTransactionLocation.length > 0
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _lineSaparator(),
                                    SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
                                    _containerPerItem(
                                      child: CustomText("LoadRequestInfoLabelLastTransaction".tr,
                                          fontSize: 14, color: Color(ListColor.colorGrey3), fontWeight: FontWeight.w700),
                                    ),
                                    Container(height: GlobalVariable.ratioWidth(Get.context) * 4),
                                    Obx(
                                      () => Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: _getListHistoryTransactionLocation(context, controller.listHistoryTransactionLocation),
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

  Widget _containerPerItem({@required Widget child, double verticalPadding = 0}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16, vertical: verticalPadding),
      child: child,
    );
  }

  Widget _lineSaparator() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16, vertical: 0),
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
            // print(listData[i].addressAutoComplete.placeId);
          },
          child: Container(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 8, horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 6,
                ),
                // SvgPicture.asset("assets/pin_white_icon.svg",
                //     width: GlobalVariable.ratioWidth(Get.context) * 13),
                Padding(
                  padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 5),
                  child: Image.asset("assets/template_buyer/lokasi.png",
                      width: GlobalVariable.ratioWidth(Get.context) * 18, height: GlobalVariable.ratioWidth(Get.context) * 18, fit: BoxFit.cover),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 11,
                ),
                Expanded(
                  child: CustomText(listData[i].addressAutoComplete.description,
                      fontSize: 14,
                      maxLines: 3,
                      height: 1.33,
                      overflow: TextOverflow.ellipsis,
                      color: Color(ListColor.colorDarkGrey3),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 14,
                ),
                Padding(
                  padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 6),
                  child: GestureDetector(
                    onTap: () {
                      controller.onClickSaveLocation(address: listData[i].addressAutoComplete.description, placeID: listData[i].addressAutoComplete.placeId);
                    },
                    child: SvgPicture.asset(
                      "assets/unmarked_icon.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 12,
                      height: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                  ),
                ),
              ])),
        ),
      ));
    }
    return listWidget;
  }

  List<Widget> _getListSaveLocation(BuildContext context, RxList<dynamic> listData) {
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
              padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 6, horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                Container(
                  margin: EdgeInsets.only(top: FontTopPadding.getSize(14), left: GlobalVariable.ratioWidth(Get.context) * 6),
                  child: SvgPicture.asset(
                    "assets/marked_icon.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 9,
                    height: GlobalVariable.ratioWidth(Get.context) * 12,
                  ),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 14,
                ),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    CustomText(listData[i].name,
                        fontSize: 14, maxLines: 1, overflow: TextOverflow.ellipsis, color: Color(ListColor.colorDarkGrey4), fontWeight: FontWeight.w600),
                    SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 4),
                    CustomText(listData[i].address,
                        fontSize: 14,
                        maxLines: 3,
                        height: 1.33,
                        overflow: TextOverflow.ellipsis,
                        color: Color(ListColor.colorDarkGrey3),
                        fontWeight: FontWeight.w500),
                  ]),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                GestureDetector(
                  onTap: () {
                    controller.onClickEditSaveLocation(i);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 35,
                    height: 40,
                    child: Center(
                      child: SvgPicture.asset("assets/edit_icon_2.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 18, height: GlobalVariable.ratioWidth(Get.context) * 18, color: Colors.black),
                    ),
                  ),
                ),
              ])),
        ),
      ));
    }
    return listWidget;
  }

  List<Widget> _getListHistoryTransactionLocation(BuildContext context, RxList<dynamic> listData) {
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
              padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 8, horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 4,
                ),
                SvgPicture.asset(
                  "assets/timer_icon.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 16,
                  height: GlobalVariable.ratioWidth(Get.context) * 19,
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 11,
                ),
                Expanded(
                  child: CustomText(listData[i].address,
                      fontSize: 14, maxLines: 1, overflow: TextOverflow.ellipsis, color: Color(ListColor.colorLightGrey4), fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 14,
                ),
                GestureDetector(
                  onTap: () {
                    controller.onClickSaveLocation(address: listData[i].address);
                  },
                  child: SvgPicture.asset("assets/unmarked_icon.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 12,
                      height: GlobalVariable.ratioWidth(Get.context) * 16,
                      color: Color(ListColor.colorLightGrey4)),
                ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 6,
                ),
              ])),
        ),
      ));
    }
    return listWidget;
  }
}
