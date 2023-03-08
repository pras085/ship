import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_list_management_lokasi/search_list_management_lokasi_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';

import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListManagementLokasiView extends GetView<ListManagementLokasiController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
      color: Color(ListColor.colorBlue),
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          appBar: _AppBarCustom(
              showClear: false,
              isEnableSearchTextField: false,
              hintText: "LocationManagementLabelHintAppBar".tr,
              preferredSize:
                  Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
              searchInput: controller.searchBar,
              listOption: [
                Container(width: GlobalVariable.ratioWidth(Get.context) * 12),
                Obx(
                  () => GestureDetector(
                      onTap: () {
                        if (!(controller.listData.length <= 1 &&
                            controller.filterKota.isEmpty &&
                            controller.filterProvince.isEmpty))
                          controller.showSort();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: controller.sort.keys.isNotEmpty
                                ? Colors.white
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/sorting_icon.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              color: (controller.listData.length <= 1 &&
                                      controller.filterKota.isEmpty &&
                                      controller.filterProvince.isEmpty)
                                  ? Color(ListColor.colorLightGrey2)
                                  : controller.sort.keys.isNotEmpty
                                      ? Color(ListColor.color4)
                                      : Colors.white))),
                )
              ],
              onSelect: () {
                if (!(controller.listData.length <= 1 &&
                    controller.filterKota.isEmpty &&
                    controller.filterProvince.isEmpty)) {
                  GetToPage.toNamed<SearchListManagementLokasiController>(
                      Routes.SEARCH_LIST_MANAGEMENT_LOKASI,
                      arguments: [""]);

                  controller.addListenerSearch(() {
                    controller.refreshData();
                  });
                }
              }),
          body: WillPopScope(
            onWillPop: onWillPop,
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
                              Container(
                                  width: context.mediaQuery.size.width,
                                  margin: EdgeInsets.fromLTRB(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Obx(() => _filter()),
                                        Container(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                        ),
                                        Obx(
                                          () => Container(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.showInfoTooltip
                                                      .value = true;
                                                },
                                                child: Container(
                                                    child: SvgPicture.asset(
                                                  "assets/ic_tooltip_list_management_lokasi.svg",
                                                  color: Color(controller
                                                          .showInfoTooltip.value
                                                      ? ListColor
                                                          .colorLightGrey2
                                                      : ListColor.colorBlue),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                )),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              // controller.showInfoTooltip.value
                              //     ? _infoTooltip()
                              //     : SizedBox.shrink(),
                              controller.filterSearch.value.isEmpty
                                  ? SizedBox.shrink()
                                  : Container(
                                      margin: EdgeInsets.all(15),
                                      child: RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                fontFamily: 'AvenirNext',
                                                color: Color(
                                                    ListColor.colorDarkBlue2)),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      ("LocationManagementLabelShowLocation"
                                                              .tr)
                                                          .replaceAll(
                                                              "#number",
                                                              controller
                                                                  .totalAll
                                                                  .value
                                                                  .toString())),
                                              TextSpan(
                                                  text: controller
                                                      .filterSearch.value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(text: "\"")
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
                                                    .value +
                                                1,
                                            itemBuilder: (content, index) {
                                              return _listPerItem(index,
                                                  controller.listData[index]);
                                            },
                                          ),
                                        ),
                                        controller.listData.length > 1
                                            // &&
                                            //         controller.filterKota.isEmpty &&
                                            //         controller
                                            //             .filterProvince.isEmpty
                                            ? SizedBox.shrink()
                                            : (controller.listData.length <=
                                                        1 &&
                                                    (controller.filterKota
                                                            .isNotEmpty ||
                                                        controller
                                                            .filterProvince
                                                            .isNotEmpty))
                                                ? _noSearchPlaceholder(
                                                    onTap: () {
                                                    if (!(controller.listData
                                                                .length <=
                                                            1 &&
                                                        controller.filterKota
                                                            .isEmpty &&
                                                        controller
                                                            .filterProvince
                                                            .isEmpty)) {
                                                      controller.showFilter();
                                                    }
                                                  })
                                                : _noDataPlaceholder(
                                                    "LocationManagementLabelNoLocationSaved"
                                                        .tr)
                                        // Positioned.fill(
                                        //     child: Container(
                                        //         alignment: Alignment.center,
                                        //         child: Column(
                                        //           mainAxisSize:
                                        //               MainAxisSize.min,
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment
                                        //                   .center,
                                        //           children: [
                                        //             Container(
                                        //                 child: SvgPicture
                                        //                     .asset(
                                        //               "assets/ic_management_lokasi_no_data.svg",
                                        //               width: GlobalVariable
                                        //                       .ratioWidth(Get
                                        //                           .context) *
                                        //                   82.3,
                                        //               height: GlobalVariable
                                        //                       .ratioWidth(Get
                                        //                           .context) *
                                        //                   75,
                                        //             )),
                                        //             Container(
                                        //               height: 12,
                                        //             ),
                                        //             Container(
                                        //                 child: CustomText(
                                        //               "LocationManagementLabelNoLocationSaved"
                                        //                   .tr
                                        //                   .replaceAll(
                                        //                       "\\n", "\n"),
                                        //               textAlign:
                                        //                   TextAlign.center,
                                        //               color: Color(ListColor
                                        //                   .colorLightGrey14),
                                        //               fontWeight:
                                        //                   FontWeight.w600,
                                        //               fontSize: 14,
                                        //               height: 1.2,
                                        //             ))
                                        //           ],
                                        //         ))),
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
          bottomNavigationBar: BottomAppBarMuat(
            centerItemText: '',
            color: Colors.grey,
            backgroundColor: Colors.white,
            selectedColor: Color(ListColor.colorSelectedBottomMenu),
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: (index) async {
              if (index == 0){
                // Get.toNamed(Routes.INBOX);
                await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                Chat.toInbox();
              } else
                Get.back();
              // switch (index) {
              //   case 0:
              //     {
              //       Get.toNamed(Routes.INBOX);
              //       break;
              //     }
              //   case 1:
              //     {
              //       // Get.toNamed(Routes.PROFILE_SHIPPER);
              //       break;
              //     }
              // }
            },
            items: [
              BottomAppBarItemModel(
                  iconName: 'message_menu_icon.svg', text: ''),
              BottomAppBarItemModel(iconName: 'user_menu_icon.svg', text: ''),
            ],
            iconSize: 40,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(),
            child: FloatingActionButton(
              backgroundColor: Color(ListColor.colorBlue),
              onPressed: () async {
                var result = await GetToPage.toNamed<
                        EditManajemenLokasiInfoPermintaanMuatController>(
                    Routes.EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
                    arguments: {
                      "TypeEditManajemenLokasiInfoPermintaanMuat":
                          TypeEditManajemenLokasiInfoPermintaanMuat.ADD,
                      EditManajemenLokasiInfoPermintaanMuatController
                          .manajemenLokasiModelKey: null,
                      "Address": "",
                      "PlaceID": ""
                    });
                if (result != null) {
                  CustomToast.show(
                      context: Get.context,
                      message: "LocationManagementAlertSaveLocation".tr);
                  controller.refreshManagementLokasiController.requestRefresh();
                }
              },
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 60,
              ),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  side: BorderSide(color: Colors.white, width: 4.0)),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    return Future.value(!controller.loading.value);
  }

  Widget _listPerItem(int index, ListManagementLokasiModel data) {
    if (index == 0) {
      return Obx(() =>
          controller.showInfoTooltip.value ? _infoTooltip() : Container());
    } else {
      return controller.listPerItem(index, data);
    }
  }

  Widget _infoTooltip() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorLightGrey).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(ListColor.colorYellow4)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(Get.context) * 7,
                  top: GlobalVariable.ratioWidth(Get.context) * 11,
                  bottom: GlobalVariable.ratioWidth(Get.context) * 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        controller.showInfoTooltip.value = false;
                      },
                      child: Container(
                          child: SvgPicture.asset(
                        "assets/ic_close_zo.svg",
                        height: GlobalVariable.ratioWidth(Get.context) * 9,
                        color: Color(ListColor.colorBlack),
                      )
                          //     child: Icon(
                          //   Icons.close_rounded,
                          //   size: GlobalVariable.ratioWidth(Get.context) * 16,
                          // )
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 18,
                  0,
                  GlobalVariable.ratioWidth(Get.context) * 18,
                  GlobalVariable.ratioWidth(Get.context) * 14),
              child: Row(
                children: [
                  Expanded(
                      child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: TextStyle(
                            fontSize:
                                GlobalVariable.ratioWidth(Get.context) * 14,
                            color: Color(ListColor.colorBlack1),
                            height: 1.857,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: "LocationManagementLabelToolTip1".tr + " ",
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          TextSpan(text: "LocationManagementLabelToolTip2".tr),
                        ]),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget horizontalScrollItem(Widget content, VoidCallback onPress) {
    return Container(
        padding: EdgeInsets.all(5),
        child: MaterialButton(
            color: Colors.white,
            onPressed: onPress,
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: Color(ListColor.colorLightGrey7), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: content));
  }

  Widget _filter() {
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 24,
      width: GlobalVariable.ratioWidth(Get.context) * 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.0001),
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
          ],
          color: Color((controller.filterKota.isEmpty &&
                  controller.filterProvince.isEmpty)
              ? ListColor.colorWhite
              : ListColor.colorLightBlue1),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 12),
          border: Border.all(
            width: GlobalVariable.ratioWidth(Get.context) * 1,
            color: Color(controller.listData.length <= 1 &&
                    (controller.filterKota.isEmpty &&
                        controller.filterProvince.isEmpty)
                ? ListColor.colorLightGrey2
                : controller.listData.isNotEmpty &&
                        (controller.filterKota.isEmpty &&
                            controller.filterProvince.isEmpty)
                    ? ListColor.colorLightGrey7
                    : ListColor.color4),
          )),
      child: Material(
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 12),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 12),
            ),
            onTap: () {
              if (!(controller.listData.length <= 1 &&
                  controller.filterKota.isEmpty &&
                  controller.filterProvince.isEmpty)) {
                controller.showFilter();
              }
            },
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: CustomText("GlobalFilterLabelButtonFilter".tr,
                        fontWeight: FontWeight.w500,
                        color: controller.listData.length <= 1 &&
                                (controller.filterKota.isEmpty &&
                                    controller.filterProvince.isEmpty)
                            ? Color(ListColor.colorLightGrey2)
                            : (controller.filterKota.isNotEmpty ||
                                    controller.filterProvince.isNotEmpty)
                                ? Color(ListColor.colorBlue)
                                : Color(ListColor.colorDarkBlue2)),
                  ),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    SvgPicture.asset(
                      "assets/filter_icon.svg",
                      height: GlobalVariable.ratioWidth(Get.context) * 12.5,
                      color: controller.listData.length <= 1 &&
                              (controller.filterKota.isEmpty &&
                                  controller.filterProvince.isEmpty)
                          ? Color(ListColor.colorLightGrey2)
                          : Color(ListColor.color4),
                    )
                  ])
                ],
              ),
            )),
      ),
    );
  }

  Widget _button({
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double minHeight = 28,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: maxWidth ? double.infinity : null,
      constraints: BoxConstraints(
          minHeight: GlobalVariable.ratioWidth(Get.context) * minHeight),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 4),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
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

  Widget _noSearchPlaceholder({@required Function onTap}) {
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
                  height: GlobalVariable.ratioWidth(Get.context) * 95,
                )),
                Container(
                  height: 12,
                ),
                Container(
                    child: CustomText(
                  "Data tidak ditemukan\nMohon coba hapus beberapa filter"
                      .tr
                      .replaceAll("\\n", "\n"),
                  textAlign: TextAlign.center,
                  color: Color(ListColor.colorLightGrey14),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.2,
                )),
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 18),
                    child: CustomText(
                      "Atau".tr.replaceAll("\\n", "\n"),
                      textAlign: TextAlign.center,
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _button(
                        text: "Atur Ulang Filter",
                        paddingLeft: 24,
                        paddingRight: 24,
                        backgroundColor: Color(ListColor.colorBlue),
                        onTap: () {
                          onTap();
                        }),
                  ],
                )
              ],
            )));
  }
}

class _AppBarCustom extends PreferredSize {
  final TextEditingController searchInput;
  final String hintText;
  final List<Widget> listOption;
  final Function(String) onSearch;
  final Function(String) onChange;
  final Function() onSelect;
  final Function() onClear;
  final bool isEnableSearchTextField;
  final bool showClear;

  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: preferredSize.height,
      child: Container(
          height: preferredSize.height,
          color: Color(ListColor.color4),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 5,
              right: 0,
              child: Image(
                image: AssetImage("assets/fallin_star_3_icon.png"),
                height: preferredSize.height,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBackButton(
                      context: Get.context,
                      onTap: () {
                        Get.back();
                      }),

                  // Container(
                  //   child: ClipOval(
                  //     child: Material(
                  //         shape: CircleBorder(),
                  //         color: Colors.white,
                  //         child: InkWell(
                  //             onTap: () {
                  //               Get.back();
                  //             },
                  //             child: Container(
                  //                 width: 30,
                  //                 height: 30,
                  //                 child: Center(
                  //                     child: Icon(
                  //                   Icons.arrow_back_ios_rounded,
                  //                   size: 30 * 0.7,
                  //                   color: Color(ListColor.color4),
                  //                 ))))),
                  //   ),
                  // ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 8,
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                          child: onSelect != null && !isEnableSearchTextField
                              ? GestureDetector(
                                  onTap: onSelect, child: _searchTextField)
                              : _searchTextField)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: listOption,
                  )
                ],
              ),
            )
          ])),
    ));
  }

  Widget get _searchTextField => Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                context: Get.context,
                enabled: isEnableSearchTextField,
                controller: searchInput,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.go,
                style: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "AvenirNext",
                    color: Colors.black),
                newInputDecoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorLightGrey2)),
                    filled: true,
                    isDense: true,
                    isCollapsed: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(Get.context) * 36,
                        GlobalVariable.ratioWidth(Get.context) * 9,
                        GlobalVariable.ratioWidth(Get.context) * 32,
                        GlobalVariable.ratioWidth(Get.context) * 0)),
                onSubmitted: (String str) async {
                  await onSearch(str);
                },
                onChanged: (String str) async {
                  await onChange(str);
                },
                onTap: () async {
                  if (!onSelect.isNull) await onSelect();
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 6),
            child: SvgPicture.asset(
              "assets/ic_search.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 20,
              height: GlobalVariable.ratioWidth(Get.context) * 20,
            ),
          ),
          showClear
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () async {
                      searchInput.clear();
                      await onClear();
                    },
                  ))
              : SizedBox.shrink()
        ],
      );

  _AppBarCustom({
    this.hintText = "Search",
    this.preferredSize,
    this.searchInput,
    this.listOption,
    this.onSearch,
    this.onChange,
    this.onClear,
    this.onSelect,
    this.isEnableSearchTextField = true,
    this.showClear = false,
  });
}
