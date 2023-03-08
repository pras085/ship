import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/info_permintaan_muat_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/info_permintaan_muat_status_enum.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_user_info_permintaan_muat/list_user_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_info_permintaan_muat.dart';
import 'package:muatmuat/app/widgets/appbar_with_tab2.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'list_info_permintaan_muat_controller.dart';
import 'dart:math' as math;

class ListInfoPermintaanMuatView
    extends GetView<ListInfoPermintaanMuatController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
        color: Color(ListColor.color4),
        child: SafeArea(
          child: Obx(
            () => DefaultTabController(
              length: controller.tabLength,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                // appBar: AppBarWithTab2(
                appBar: AppBarInfoPermintaanMuat(
                  onClickSearch: (){
                    controller.goToSearchPage();
                  },
                  listTab: [
                    "LoadRequestInfoTabLabelActive".tr,
                    "LoadRequestInfoTabLabelHistory".tr
                  ],
                  positionTab: controller.posTab.value,
                  onClickTab: (pos) {
                    controller.onChangeTab(pos);
                  },
                  hintText: "LoadRequestInfoLabelSearchHint".tr,
                  listIconWidgetOnRight: [
                    GestureDetector(
                        onTap: () {
                          // Share.share("test");
                          if (controller.posTab.value == 0) {
                            if(!controller.exportAktifRole) return;
                            print('::: Export Muat Aktif ');
                          } else {
                            if(!controller.exportHistoryRole) return;
                            print('::: Export Muat History ');
                          }
                        },
                        child: Container(
                          width: GlobalVariable.ratioWidth(Get.context) * 24,
                          height: GlobalVariable.ratioWidth(Get.context) * 24,
                          child: SvgPicture.asset("assets/share_icon.svg",
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              color: Colors.white),
                        )),
                    GestureDetector(
                        onTap: () {
                          print("sorting");
                          controller.showSortingDialog();
                        },
                        child: Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            decoration: BoxDecoration(
                              color: ((controller.isTabActive &&
                                          controller
                                              .isUsingSortingActive.value) ||
                                      (controller.isTabHistory &&
                                          controller
                                              .isUsingSortingHistory.value))
                                  ? Colors.white
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/sorting_icon.svg",
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              color: ((controller.isTabActive &&
                                          controller
                                              .isUsingSortingActive.value) ||
                                      (controller.isTabHistory &&
                                          controller
                                              .isUsingSortingHistory.value))
                                  ? Color(ListColor.color4)
                                  : Colors.white,
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                            ))),
                    // Container(
                    //     padding: EdgeInsets.all(5),
                    //     child: SvgPicture.asset(
                    //       "assets/export_file_icon.svg",
                    //     ))),
                  ],
                ),
                body:
                    TabBarView(controller: controller.tabController, children: [
                  _activeLoadRequest(),
                  _historyLoadRequest(),
                ]), //[listMitra(), listRequest(), listPending()]
                bottomNavigationBar: BottomAppBarMuat(
                  centerItemText: '',
                  color: Colors.grey,
                  backgroundColor: Colors.white,
                  selectedColor: Color(ListColor.colorSelectedBottomMenu),
                  notchedShape: CircularNotchedRectangle(),
                  onTabSelected: (index) async {
                    switch (index) {
                      case 0:
                        {
                          // Get.toNamed(Routes.INBOX);
                          await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                          Chat.toInbox();
                          break;
                        }
                      case 1:
                        {
                          // Get.toNamed(Routes.PROFILE_SHIPPER);
                          Get.toNamed(Routes.PROFIL);
                          break;
                        }
                    }
                  },
                  items: [
                    BottomAppBarItemModel(
                        iconName: 'message_menu_icon.svg', text: ''),
                    BottomAppBarItemModel(
                        iconName: 'user_menu_icon.svg', text: ''),
                  ],
                  iconSize: 40,
                ),
                // body: _list[_page],
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(
                  width: 80,
                  height: 80,
                  // decoration: BoxDecoration(),
                  child: FloatingActionButton(
                    backgroundColor: controller.buatRole ? Color(ListColor.color4) : Color(ListColor.colorGrey),
                    onPressed: () async{
                      print("::::"+controller.buatRole.toString());
                      if (!controller.buatRole) {
                        return;
                      } else {
                      controller.goToCreatePermintaanMuat();
                      }
                      // GetToPage.toNamed<ListUserInfoPermintaanMuatController>(
                      //     Routes.LIST_USER_INFO_PERMINTAAN_MUAT,
                      //     arguments: [
                      //       {"semua": {}, "group": [], "transporter": []}
                      //     ]);
                    },
                    child: Icon(
                      Icons.add_rounded,
                      color: controller.buatRole ? Color(ListColor.colorWhite)  : Color(ListColor.colorGrey),
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
          ),
        ));
  }

  Widget _activeLoadRequest() {
    return Obx(
      () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                height: GlobalVariable.ratioWidth(Get.context) * 24,
                // width: GlobalVariable.ratioWidth(Get.context) * 80,
                margin: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 14,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 7),
                child: ButtonFilterWidget(
                  onTap: () {
                    controller.showFilterActive();
                  },
                  isActive: ((controller.isTabActive &&
                          controller.isUsingFilterActive.value) ||
                      (controller.isTabHistory &&
                          controller.isUsingFilterHistory.value)),
                )),
            Expanded(
                child: controller.isGettingDataPermintaanMuat.value &&
                        controller.isLoadingDataActive
                    ? Center(
                        child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()),
                      )
                    : Stack(children: [
                        SmartRefresher(
                          enablePullUp: true,
                          controller: controller.activeRefreshController,
                          onLoading: () {
                            controller
                                .getAllInfoPermintaanMuatActiveOnLoading();
                          },
                          onRefresh: () {
                            controller
                                .getAllInfoPermintaanMuatActiveOnRefresh();
                          },
                          child: ListView.builder(
                            itemCount:
                                controller.listInfoPermintaanMuatActive.length,
                            itemBuilder: (content, index) {
                              return _listPerItem(
                                  index,
                                  controller
                                      .listInfoPermintaanMuatActive[index]);
                              //mitraTile2(controller.listMitra[index]);
                            },
                          ),
                        ),
                        (controller.listInfoPermintaanMuatActive.length == 0 &&
                                !controller.isLoadingDataActive)
                            ? Center(
                                child: CustomText(
                                    "LoadRequestInfoLabelEmptyData".tr),
                              )
                            : SizedBox.shrink()
                      ]))
          ]),
    );
  }

  Widget _historyLoadRequest() {
    return Obx(
      () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                height: GlobalVariable.ratioWidth(Get.context) * 24,
                margin: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 14,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 6),
                child: ButtonFilterWidget(onTap: () {
                  controller.showFilterHistory();
                })),
            Expanded(
                child: (!controller.isAlreadyLoadHistoryFirstTime.value ||
                        (controller.isGettingDataPermintaanMuat.value &&
                            controller.isLoadingDataHistory))
                    ? Center(
                        child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()),
                      )
                    : Stack(children: [
                        SmartRefresher(
                          enablePullUp: true,
                          controller: controller.historyRefreshController,
                          onLoading: () {
                            controller
                                .getAllInfoPermintaanMuatHistoryOnLoading();
                          },
                          onRefresh: () {
                            controller
                                .getAllInfoPermintaanMuatHistoryOnRefresh();
                          },
                          child: ListView.builder(
                            itemCount:
                                controller.listInfoPermintaanMuatHistory.length,
                            itemBuilder: (content, index) {
                              return _listPerItem(
                                  index,
                                  controller
                                      .listInfoPermintaanMuatHistory[index]);
                              //mitraTile2(controller.listMitra[index]);
                            },
                          ),
                        ),
                        (controller.listInfoPermintaanMuatHistory.length == 0 &&
                                !controller.isLoadingDataHistory)
                            ? Center(
                                child: CustomText(
                                    "LoadRequestInfoLabelEmptyData".tr),
                              )
                            : SizedBox.shrink()
                      ]))
          ]),
    );
  }

  Widget _listPerItem(int index, InfoPermintaanMuatModel data) {
    return controller.listPerItem(index, data);
  }

  TextStyle _textStyleContentPerItem() => TextStyle(
      fontSize: 14,
      color: Color(ListColor.colorGrey4),
      fontWeight: FontWeight.w500);
}
