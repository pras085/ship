import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/enum/list_data_design_type_button_corner_right_enum.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/widgets/appbar_with_tab2.dart';
import 'package:muatmuat/app/widgets/button_below_app_header_theme1_widget.dart';
import 'package:muatmuat/app/widgets/button_below_app_header_widget.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:muatmuat/global_variable.dart';

class ManajemenMitraView extends GetView<ManajemenMitraController> {
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
            length: 3,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBarWithTab2(
                onClickSearch: () {
                  controller.goToSearchPage();
                },
                listTab: [
                  "PartnerManagementLabelMitra".tr,
                  "PartnerManagementLabelRequestApprove".tr,
                  "PartnerManagementLabelGroup".tr
                ],
                positionTab: controller.posTab.value,
                onClickTab: (pos) {
                  controller.onChangeTab(pos);
                },
                hintText: controller.isMitraTab.value ||
                        controller.isRequestApproveTab.value
                    ? "PartnerManagementLabelHintSearchMitra".tr
                    : "PartnerManagementLabelHintSearchGroup".tr,
                listIconWidgetOnRight: [
                  GestureDetector(
                      onTap: () {
                        controller.showSortingDialog();
                      },
                      child: Obx(()=>
                        Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            decoration: BoxDecoration(
                              // color: (controller.isMitraTab.value &&
                              //             controller.isUsingSorting.value) ||
                              //         (controller.isRequestApproveTab.value &&
                              //             ((controller.isRequestApproveTabApproveView
                              //                         .value &&
                              //                     controller
                              //                         .isUsingSortingApproveMitra
                              //                         .value) ||
                              //                 (controller
                              //                         .isRequestApproveTabRequestView
                              //                         .value &&
                              //                     controller
                              //                         .isUsingSortingRequestMitra
                              //                         .value)))
                              //     ? Colors.white
                              //     : Colors.transparent,
                              color: controller.sortBgColor.value,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset("assets/sorting_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                // color: (controller.isMitraTab.value &&
                                //             controller.isUsingSorting.value) ||
                                //         (controller.isRequestApproveTab.value &&
                                //             ((controller.isRequestApproveTabApproveView
                                //                         .value &&
                                //                     controller
                                //                         .isUsingSortingApproveMitra
                                //                         .value) ||
                                //                 (controller
                                //                         .isRequestApproveTabRequestView
                                //                         .value &&
                                //                     controller
                                //                         .isUsingSortingRequestMitra
                                //                         .value)))
                                color: controller.sortColor.value)),
                      ))
                ],
              ),
              body: TabBarView(controller: controller.tabController, children: [
                _listMitra(),
                _listRequestApprove(),
                listGrupMitra()
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(),
                child: FloatingActionButton(
                  backgroundColor: Color(ListColor.colorGreen2),
                  onPressed: () async {
                    if (controller.isGroupMitraTab.value) {
                      var result = await Get.toNamed(Routes.CREATE_GROUP_MITRA);
                      if (result != null && result.toString() == "create") {
                        CustomToast.show(
                            context: context,
                            message: "PartnerManagementGroupHasBeenCreated".tr);
                        controller.refreshGroupController.requestRefresh();
                      }
                    } else {
                      controller.addMitra();
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
        ),
      ),
    );
  }

  Widget _itemDescMitra(String urlIcon, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(urlIcon, width: 25, height: 25),
          SizedBox(width: 16),
          Expanded(
              child: CustomText(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: Color(ListColor.colorGrey4)))
        ],
      ),
    );
  }

  Widget groupTile(int index, int totalIndex, GroupMitraModel group) {
    var borderRadius = GlobalVariable.ratioWidth(Get.context) * 10;
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorBlack).withOpacity(0.1),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Column(children: [
        Container(
          height: GlobalVariable.ratioWidth(Get.context) * 47,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              color: Color(ListColor.colorLightBlue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16),
                width: GlobalVariable.ratioWidth(Get.context) *
                    GlobalVariable.ratioWidth(Get.context) *
                    32,
                height: GlobalVariable.ratioWidth(Get.context) * 32,
                child: CircleAvatar(
                  radius: GlobalVariable.ratioWidth(Get.context) * 32.0,
                  backgroundImage:
                      NetworkImage(group.avatar),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(group.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      CustomText(
                        "${group.totalPartner} " +
                            "PartnerManagementLabelPartner".tr,
                        color: Color(ListColor.colorGrey3),
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        fontSize: 12,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.optionGroupMitra(group);
                },
                child: Container(
                    margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(Get.context) * 12,
                        left: GlobalVariable.ratioWidth(Get.context) * 12),
                    child: SvgPicture.asset(
                      "assets/ic_more_vert.svg",
                      color: Color(ListColor.colorBlack),
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    )),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 14,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 14,
              GlobalVariable.ratioWidth(Get.context) * 14),
          child: CustomText(
            (group.description) ?? "",
            maxLines: 3,
            height: 1.2,
            overflow: TextOverflow.ellipsis,
            color: Color(ListColor.colorGrey4),
          ),
        ),
        Container(
          width: MediaQuery.of(Get.context).size.width,
          height: GlobalVariable.ratioWidth(Get.context) * 0.5,
          color: Color(ListColor.colorStroke),
        ),
        Container(
          height: GlobalVariable.ratioWidth(Get.context) * 42,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16),
                alignment: Alignment.center,
                height: GlobalVariable.ratioWidth(Get.context) * 20,
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                decoration: BoxDecoration(
                    color: group.status
                        ? Color(ListColor.colorLightGreen3)
                        : Color(ListColor.colorLightRed3),
                    borderRadius: BorderRadius.all(Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 6))),
                child: CustomText(
                    group.status
                        ? "PartnerManagementAktifGrup".tr
                        : "PartnerManagementTidakAktifGrup".tr,
                    color: group.status
                        ? Color(ListColor.colorGreen6)
                        : Color(ListColor.colorRed)),
              ),
              Expanded(child: Container()),
              _button(
                  text: "PartnerManagementLabelDetail".tr,
                  marginRight: 16,
                  height: 28,
                  marginTop: 7,
                  marginBottom: 7,
                  paddingLeft: 24,
                  paddingRight: 24,
                  borderRadius: 18,
                  useBorder: false,
                  useShadow: false,
                  backgroundColor: Color(ListColor.colorBlue),
                  onTap: () async {
                    var result = await Get.toNamed(
                        Routes.DETAIL_MANAJEMEN_GROUP_MITRA,
                        arguments: [group.id, group]);
                    if (result != null && result == true) {
                      controller.refreshGroupController.requestRefresh();
                    }
                  }),
            ],
          ),
        ),
      ]),
    );
  }

  popupDialogue(String content, Function() onAgree) {
    showDialog(
        context: Get.context,
        builder: (context) {
          return AlertDialog(
            content: CustomText(content),
            actions: [
              MaterialButton(
                onPressed: () => onAgree(),
                child: CustomText("PartnerManagementLabelSure".tr),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: CustomText("PartnerManagementLabelCancel".tr),
              )
            ],
          );
        });
  }

  Widget _listRequestApprove() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16,
                          vertical: 14),
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            child: ButtonFilterWidget(
                              onTap: () {
                                if(
                                    controller.isRequestApproveTabApproveView.value && (controller.isUsingFilterApproveMitra.value || controller.listApproveRejectMitra.length > 0) ||
                                    controller.isRequestApproveTabRequestView.value && (controller.isUsingFilterRequestMitra.value || controller.listRequestCancelMitra.length > 0)
                                ) {
                                  controller.showFilter();
                                }
                              },
                              isActive: (controller
                                          .isRequestApproveTabApproveView
                                          .value &&
                                      (controller
                                          .isUsingFilterApproveMitra.value) ||
                                  (controller.isRequestApproveTabRequestView
                                          .value &&
                                      (controller
                                          .isUsingFilterRequestMitra.value))),
                            ),
                          ),
                          _button(
                              paddingLeft: 12,
                              paddingRight: 12,
                              marginLeft: 12,
                              marginRight: 12,
                              borderRadius: 17,
                              text: controller.listTabMitra[1] +
                                  (controller.numberApprove.value != "0"
                                      ? " (" +
                                          controller.numberApprove.value +
                                          ")"
                                      : ""),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              borderColor: Color(controller
                                      .isRequestApproveTabApproveView.value
                                  ? ListColor.colorBlue
                                  : ListColor.colorLightGrey7),
                              color: Color(controller
                                      .isRequestApproveTabApproveView.value
                                  ? ListColor.colorBlue
                                  : ListColor.colorDarkBlue2),
                              onTap: () {
                                controller
                                    .clickButtonInsideRequestApproveTab(0);
                              }),

                          _button(
                              paddingLeft: 12,
                              paddingRight: 12,
                              borderRadius: 17,
                              text: controller.listTabMitra[2] +
                                  (controller.numberRequest.value != "0"
                                      ? " (" +
                                          controller.numberRequest.value +
                                          ")"
                                      : ""),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              borderColor: Color(controller
                                      .isRequestApproveTabRequestView.value
                                  ? ListColor.colorBlue
                                  : ListColor.colorLightGrey7),
                              color: Color(controller
                                      .isRequestApproveTabRequestView.value
                                  ? ListColor.colorBlue
                                  : ListColor.colorDarkBlue2),
                              onTap: () {
                                controller
                                    .clickButtonInsideRequestApproveTab(1);
                              }),
                        ],
                      ),
                    ),
                    (controller.isRequestApproveTabApproveView.value)
                        ? Container(
                            // color: Colors.amber[200],
                            margin: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 4,
                                bottom:
                                    GlobalVariable.ratioWidth(Get.context) * 10,
                                left: GlobalVariable.ratioWidth(Get.context) *
                                    16),
                            child: CustomText(
                                (controller.isRequestApproveTabApproveView.value
                                    ? controller.listSubTitleMitra[1]
                                    : controller.listSubTitleMitra[2]),
                                maxLines: 1,
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )
                        : SizedBox.shrink(),
                    Expanded(
                      child: ((controller.isGettingDataMitra.value &&
                                  controller.isRequestApproveTab.value) ||
                              (!controller
                                      .isRequestApproveTabRequestView.value &&
                                  !controller
                                      .isRequestApproveTabApproveView.value)
                          ? Center(
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator()),
                            )
                          : _showListRequestApproveMitra()),
                    )
                  ]),
            )),
      ],
    );
  }

  Widget _listMitra() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ButtonFilterWidget(
                            onTap: () {
                              if(
                                controller.isMitraTab.value && (controller.isUsingFilter.value || controller.listMitra.length > 0)
                              ) {
                                controller.showFilter();
                              }
                            },
                            isActive: (controller.isMitraTab.value &&
                                controller.isUsingFilter.value),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          _button(
                            onTap: () {
                              _showDialogInvite();
                            },
                            borderColor: Color(ListColor.colorLightGrey7),
                            height: 24,
                            useBorder: true,
                            customWidget: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4),
                                    child: SvgPicture.asset(
                                      "assets/ic_undang_rekan_mitra.svg",
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: CustomText(
                                    "PartnerManagementLabelInvitePartner".tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorBlue),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: (controller.isMitraTab.value &&
                                controller.isGettingDataMitra.value)
                            ? Center(
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator()),
                              )
                            : _showListMitra()),
                  ]),
            )),
      ],
    );
  }

  Widget _showListMitra() {
    return Stack(children: [
      (controller.listMitra.length == 0 && !controller.isLoadingDataMitra.value)
          ? Center(
              child: Container(
                  child: CustomText("PartnerManagementEmptyDataMitra".tr)))
          : SizedBox.shrink(),
      _listAllMitra()
    ]);
  }

  Widget _showListRequestApproveMitra() {
    if (controller.isRequestApproveTabApproveView.value)
      return Stack(children: [
        (controller.listApproveRejectMitra.length == 0 &&
                !controller.isLoadingDataApproveMitra.value)
            ? Center(
                child: Container(
                    child: CustomText("PartnerManagementEmptyDataMitra".tr)))
            : SizedBox.shrink(),
        _listRequest()
      ]);
    else
      return Stack(children: [
        (controller.listRequestCancelMitra.length == 0 &&
                !controller.isLoadingDataRequestMitra.value)
            ? Center(
                child: Container(
                    child: CustomText("PartnerManagementEmptyDataMitra".tr)))
            : SizedBox.shrink(),
        _listPending()
      ]);
  }

  Widget _showTitleMitra() {
    if (controller.tabMitraValue.value != controller.listTabMitra[0]) {
      return CustomText(controller.tabMitraValue.value,
          color: Colors.black, fontWeight: FontWeight.w500);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _listAllMitra() {
    return SmartRefresher(
      enablePullUp: true,
      controller: controller.refreshMitraController,
      onLoading: () {
        controller.getAllMitraByShipper();
      },
      onRefresh: () {
        controller.getAllMitraByShipperOnRefresh();
      },
      child: ListView.builder(
        itemCount: controller.listMitra.length,
        itemBuilder: (content, index) {
          return controller.listPerItemMitra(
              context: content,
              index: index,
              listDataDesignFunction: controller.listDataDesignFunctionMitra);
        },
      ),
    );
  }

  Widget _listRequest() {
    return SmartRefresher(
      enablePullUp: true,
      controller: controller.refreshApproveRejectMitraController,
      onLoading: () {
        controller.getAllMitraApproveRejectByShipper();
      },
      onRefresh: () {
        controller.getAllMitraApproveRejectByShipperOnRefresh();
      },
      child: ListView.builder(
        itemCount: controller.listApproveRejectMitra.length,
        itemBuilder: (content, index) {
          return controller.listPerItemApproveRejectMitra(
              context: content,
              index: index,
              listDataDesignFunction:
                  controller.listDataDesignFunctionApproveReject,
              listApproveRejectMitra: controller.listApproveRejectMitra);
        },
      ),
    );
  }

  Widget _listPending() {
    return SmartRefresher(
      enablePullUp: true,
      controller: controller.refreshRequestCancelController,
      onLoading: () {
        controller.getAllMitraRequestCancelByShipper();
      },
      onRefresh: () {
        controller.getAllMitraRequestCancelByShipperOnRefresh();
      },
      child: ListView.builder(
        itemCount: controller.listRequestCancelMitra.length,
        itemBuilder: (content, index) {
          return controller.listPerItemRequestCancelMitra(
              context: content,
              index: index,
              listDataDesignFunction:
                  controller.listDataDesignFunctionRequestCancel,
              listRequestCancel: controller.listRequestCancelMitra);
        },
      ),
    );
  }

  Widget listGrupMitra() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
              vertical: GlobalVariable.ratioWidth(Get.context) * 14),
          child: Row(
            children: [
              ButtonBelowAppHeaderTheme1Widget(
                onTap: () {
                  controller.optionActiveGroupMitra();
                },
                title: controller.namaListGroup.value,
                suffixIcon: Container(
                  child: SvgPicture.asset(
                    "assets/ic_arrow_down_subscription.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 14,
                    height: GlobalVariable.ratioWidth(Get.context) * 14,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Obx(() => Stack(
                children: [
                  SmartRefresher(
                    enablePullUp: true,
                    controller: controller.refreshGroupController,
                    onLoading: () {
                      controller.loadGroupMitra();
                    },
                    onRefresh: () {
                      controller.refreshGroupMitra();
                    },
                    child: ListView.builder(
                      itemCount: controller.listGroupMitra.length,
                      itemBuilder: (content, index) {
                        var groupMitra = controller.listGroupMitra[index];
                        return groupTile(index,
                            controller.listGroupMitra.length, groupMitra);
                      },
                    ),
                  ),
                  controller.listGroupMitra.length == 0 &&
                          controller.isLoadingDataGroupMitra.value
                      ? Center(
                          child: Container(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator()),
                        )
                      : controller.listGroupMitra.length == 0
                          ? Container(
                              alignment: Alignment.center,
                              child: CustomText("There are no groups here yet"))
                          : SizedBox.shrink()
                ],
              )),
        ),
      ]),
    );
  }

  Widget _textInsideButtonBelowAppBar(
      {@required String title, Color textColor}) {
    return CustomText(title,
        color: textColor ?? Color(ListColor.colorDarkBlue2));
  }

  Widget _buttonBelowAppHeader(
      {@required Widget child,
      @required void Function() onTap,
      Color backgroundColor = Colors.white,
      Color borderColor}) {
    return Container(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      width: 1,
                      color: borderColor ?? Color(ListColor.colorLightGrey))),
              child: child,
            )),
      ),
    );
  }

  Widget _buttonFilter({@required bool isActive}) {
    return _buttonBelowAppHeader(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _textInsideButtonBelowAppBar(
            title: "PartnerManagementLabelFilter".tr,
            textColor: isActive ? Colors.white : null,
          ),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset("assets/filter_icon.svg",
              color: isActive ? Colors.white : Color(ListColor.color4)),
        ],
      ),
      onTap: () {
        controller.showFilter();
      },
      backgroundColor: isActive ? Color(ListColor.color4) : null,
      borderColor: isActive ? Color(ListColor.color4) : null,
    );
  }

  void _showDialogInvite() {
    showDialog(
        context: Get.context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
            child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 9
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(alignment: Alignment.topCenter, children: [
                      Container(
                        margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 17),
                        child: CustomText(
                            "PartnerManagementInviteBusinessPartnersTitle".tr,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            fontSize: 16),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: Color(ListColor.color4),
                              size: GlobalVariable.ratioWidth(Get.context) * 24,
                            )),
                      ),
                    ]),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 22,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 13),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                              "PartnerManagementInviteBusinessPartnersDesc".tr,
                              textAlign: TextAlign.center,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.2),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                          ),
                          for(var index = 0; index < ("PartnerManagementInviteBusinessPartnersBenifit".tr).split("\n").length; index++)
                            Container(
                              margin: EdgeInsets.only(top: index == 0 ? 0 : GlobalVariable.ratioWidth(Get.context) * 12),
                              child: CustomText(
                                ("PartnerManagementInviteBusinessPartnersBenifit".tr).split("\n")[index],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2,)
                            ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                          ),
                          Text.rich(
                            TextSpan(
                                children:
                                    controller.listUndangRekanBisnisDesc2),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 22,
                          ),
                          GestureDetector(
                            onTap: (){},
                            child: CustomText(
                              "http://muatmuat.com/referal/${GlobalVariable.userModelGlobal.code}",
                              fontSize: 14,
                              height: 1.2,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                              color: Color(ListColor.color4))
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 22,
                          ),
                          GestureDetector(
                            onTap: (){
                              Share.share(
                                  GlobalVariable.userModelGlobal.code);
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 18)),
                                  color: Color(ListColor.color4)),
                              width: GlobalVariable.ratioWidth(Get.context) * 148,
                              height: GlobalVariable.ratioWidth(Get.context) * 36,
                              child: Center(
                                child: CustomText(
                                    "PartnerManagementInviteBusinessPartnersButtonInvite"
                                        .tr,
                                    fontSize: 14,
                                    height: 1.2,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 17
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget _button({
    double height,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = true,
    bool useBorder = true,
    double borderRadius = 6,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: maxWidth ? MediaQuery.of(Get.context).size.width : null,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: borderColor ?? Color(ListColor.colorBlue),
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
                  borderRadius: BorderRadius.circular(borderRadius)),
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
}
