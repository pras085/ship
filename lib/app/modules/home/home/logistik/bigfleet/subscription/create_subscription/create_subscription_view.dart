import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subscription/create_subscription_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:muatmuat/app/core/function/onchange_textfield_number.dart';

class CreateSubscriptionView extends GetView<CreateSubscriptionController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.firstTooltip) {
        controller.firstTooltip = false;
        if (controller.nextLangganan) controller.showInfoKadaluarsa();
      }
    });

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Container(
        color: Color(ListColor.color4),
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(GlobalVariable.ratioWidth(context) * 56),
              child: Container(
                height: GlobalVariable.ratioWidth(context) * 56,
                width: MediaQuery.of(context).size.width,
                color: Color(ListColor.color4),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(context) * 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomBackButton(
                      context: Get.context,
                      onTap: () {
                        controller.onBack();
                      },
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    Expanded(
                      child: CustomText(
                        "SubscriptionCreateLabelBigfleet".tr,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 52,
                      color: Color(ListColor.color4),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(context) * 16),
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 0.5,
                              child: Container(color: Colors.white)),
                          Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(context) * 16,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Obx(() => CustomText(
                                          controller.title.value,
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                    )),
                                    Obx(
                                      () => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          for (int i = 0; i < 3; i++)
                                            _buildPageIndicator(
                                                i ==
                                                    controller.slideIndex.value,
                                                i)
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Obx(
                      () => Container(
                        color: Color(ListColor.colorWhite),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: PageView(
                                    physics: NeverScrollableScrollPhysics(),
                                    onPageChanged: (index) {
                                      controller.slideIndex.value = index;
                                      controller.updateTitle();
                                    },
                                    controller: controller.pageController,
                                    children: [
                                      firstPage(),
                                      secondPage(),
                                      thirdPage()
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      vertical: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          topRight: Radius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withAlpha(70),
                                            offset: Offset(0, -2),
                                            blurRadius: 2,
                                            spreadRadius: 3)
                                      ]),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Obx(() => Opacity(
                                              opacity:
                                                  controller.slideIndex.value ==
                                                          0
                                                      ? 0
                                                      : 1,
                                              child: Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        32,
                                                child: MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              GlobalVariable.ratioWidth(Get
                                                                      .context) *
                                                                  26)),
                                                      side: BorderSide(
                                                          width: GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              1.5,
                                                          color: Color(
                                                              ListColor.color4))),
                                                  onPressed: () {
                                                    if (controller
                                                            .slideIndex.value !=
                                                        0) {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          .unfocus();
                                                      controller
                                                          .slideIndex.value--;
                                                      controller.pageController
                                                          .animateToPage(
                                                              controller
                                                                  .slideIndex
                                                                  .value,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve: Curves
                                                                  .linear);
                                                    }
                                                  },
                                                  child: CustomText(
                                                      "SubscriptionCreateLabelSebelumnya"
                                                          .tr,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(
                                                          ListColor.color4)),
                                                ),
                                              ),
                                            )),
                                      ),
                                      Container(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8),
                                      Expanded(
                                        child: Container(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              32,
                                          child: Obx(() => MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                26))),
                                                color: Color((controller
                                                                .slideIndex
                                                                .value ==
                                                            2 &&
                                                        controller
                                                            .metodePembayaran
                                                            .isEmpty)
                                                    ? ListColor.colorLightGrey2
                                                    : controller.slideIndex.value ==
                                                      0 && controller.selectedPaketSubscription.isEmpty
                                                      ? ListColor.colorLightGrey2
                                                      : ListColor.color4),
                                                onPressed: () {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      .unfocus();
                                                  var valid = false;
                                                  switch (controller
                                                      .slideIndex.value) {
                                                    case 0:
                                                      {
                                                        valid = controller
                                                            .selectedPaketSubscription
                                                            .isNotEmpty;
                                                        if (valid &&
                                                            controller
                                                                .needRefresh) {
                                                          controller
                                                                  .needRefresh =
                                                              false;
                                                          controller
                                                              .getTotalPaketSubuser();
                                                        }
                                                        break;
                                                      }
                                                    case 1:
                                                      {
                                                        valid = !controller
                                                            .onDeleting;
                                                        if (valid) {
                                                          controller
                                                              .countAllSubuser();
                                                          controller
                                                              .updateTotalPembayaran();
                                                        }
                                                        break;
                                                      }
                                                    case 2:
                                                      {
                                                        valid = true;
                                                        // valid = controller.formThree.currentState
                                                        //     .validate();
                                                        break;
                                                      }
                                                  }
                                                  if (valid) {
                                                    FocusScope.of(Get.context)
                                                        .unfocus();
                                                    if (controller
                                                            .slideIndex.value !=
                                                        2) {
                                                      controller
                                                          .slideIndex.value++;
                                                      controller.pageController
                                                          .animateToPage(
                                                              controller
                                                                  .slideIndex
                                                                  .value,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve: Curves
                                                                  .linear);
                                                    } else {
                                                      controller.checkFirst();
                                                    }
                                                  }
                                                },
                                                child: CustomText(
                                                  controller.slideIndex.value ==
                                                          2
                                                      ? "SubscriptionCreateLabelBuatPesanan"
                                                          .tr
                                                      : "SubscriptionCreateLabelSelanjutnya"
                                                          .tr,
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            !controller.loadingCreate.value
                                ? SizedBox.shrink()
                                : Positioned.fill(
                                    child: Container(
                                        color: Colors.black.withAlpha(100),
                                        child: Center(
                                          child: Container(
                                              padding: EdgeInsets.all(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          10)),
                                              child:
                                                  CircularProgressIndicator()),
                                        )))
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: GlobalVariable.ratioWidth(Get.context) * 19,
              height: GlobalVariable.ratioWidth(Get.context) * 19,
              decoration: BoxDecoration(
                color: isCurrentPage
                    ? Color(ListColor.colorYellow)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 12),
                border: Border.all(
                    color: Color(ListColor.colorYellow),
                    width: GlobalVariable.ratioWidth(Get.context) * 2),
              ),
            ),
            Center(
              child: CustomText(
                (index + 1).toString(),
                color:
                    isCurrentPage ? Color(ListColor.colorBlue) : Colors.white,
                fontSize: 12,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        index == 2
            ? SizedBox.shrink()
            : Container(
                height: GlobalVariable.ratioWidth(Get.context) * 2,
                width: GlobalVariable.ratioWidth(Get.context) * 12,
                color: Color(ListColor.colorYellow))
      ],
    );
  }

  Widget firstPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(
              top: GlobalVariable.ratioWidth(Get.context) * 20 -
                  FontTopPadding.getSize(14),
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              right: GlobalVariable.ratioWidth(Get.context) * 16,
              bottom: GlobalVariable.ratioWidth(Get.context) * 14,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText("SubscriptionCreateLabelPilihPaketLangganan".tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                controller.nextLangganan
                    ? Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.showInfoKadaluarsa();
                              // controller.showInfoTooltip
                              //     .value = true;
                            },
                            child: Container(
                                child: SvgPicture.asset(
                              "assets/ic_tooltip_list_management_lokasi.svg",
                              color: Color(ListColor.colorBlue),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                            )),
                          ),
                        ),
                      )
                    : Container()
              ],
            )),
        Expanded(
          child: Obx(
            () => controller.loadSubscription.value
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.listPaketSubscription.length,
                    itemBuilder: (context, index) {
                      var lebar = GlobalVariable.ratioWidth(Get.context) * 16;

                      return Container(
                        margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 16,
                          right: GlobalVariable.ratioWidth(Get.context) * 16,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            controller.needRefresh = true;
                            if (controller.selectedPaketSubscription.value !=
                                controller.listPaketSubscription[index]
                                        [controller.subscriptionID]
                                    .toString()) {
                              controller.selectedPaketSubscription.value =
                                  controller.listPaketSubscription[index]
                                          [controller.subscriptionID]
                                      .toString();
                              controller.showClosePopup = true;
                            } else {
                              controller.selectedPaketSubscription.value = "";
                              controller.showClosePopup = false;
                            }
                            controller.resetSubuser();
                          },
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                offset: Offset(
                                                    0,
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        3),
                                                blurRadius:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12,
                                                spreadRadius: 0)
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  10)))),
                              Obx(
                                () => Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                    GlobalVariable.ratioWidth(Get.context) * 0,
                                    GlobalVariable.ratioWidth(Get.context) * 10,
                                    GlobalVariable.ratioWidth(Get.context) * 0,
                                  ),
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          58,
                                  decoration: BoxDecoration(
                                      color:
                                          controller.listPaketSubscription[index][controller.subscriptionID]
                                                      .toString() ==
                                                  controller
                                                      .selectedPaketSubscription
                                                      .value
                                              ? Color(ListColor.color4)
                                                  .withOpacity(0.1)
                                              : Colors.transparent,
                                      border: Border.all(
                                          color: controller
                                                      .listPaketSubscription[index]
                                                          [controller.subscriptionID]
                                                      .toString() ==
                                                  controller.selectedPaketSubscription.value
                                              ? Color(ListColor.color4)
                                              : Colors.transparent,
                                          width: GlobalVariable.ratioWidth(Get.context) * 1),
                                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AbsorbPointer(
                                        child: RadioButtonCustom(
                                          colorSelected:
                                              Color(ListColor.colorBlue),
                                          isDense: true,
                                          isWithShadow: true,
                                          width: lebar,
                                          height: lebar,
                                          groupValue: controller
                                              .selectedPaketSubscription.value,
                                          value: controller
                                              .listPaketSubscription[index]
                                                  [controller.subscriptionID]
                                              .toString(),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    8),
                                        child: CustomText(
                                            controller.listPaketSubscription[
                                                    index]
                                                [controller.subscriptionName],
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      )),
                                      Container(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            58,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            CustomText(
                                              Utils.formatUang(controller
                                                  .listPaketSubscription[index][
                                                      controller
                                                          .subscriptionPrice]
                                                  .toDouble()),
                                              color: Color(ListColor.color4),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                            controller.listPaketSubscription[
                                                            index][
                                                        controller
                                                            .subscriptionFree] ==
                                                    0
                                                ? SizedBox.shrink()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        top: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            2),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  2),
                                                          child: SvgPicture.asset(
                                                              "assets/ic_gratis_subuser.svg",
                                                              height: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  10,
                                                              color: Color(ListColor
                                                                  .colorOrange)),
                                                        ),
                                                        Container(
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                8),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  2),
                                                          child: CustomText(
                                                              ("SubscriptionCreateLabelGratisSubuser".tr).replaceAll(
                                                                  "#",
                                                                  controller
                                                                      .listPaketSubscription[
                                                                          index]
                                                                          [
                                                                          controller
                                                                              .subscriptionFree]
                                                                      .toString()),
                                                              // "Gratis ${Utils.formatUang(controller.listPaketSubscription[index][controller.subscriptionFree].toDouble())} Sub User",
                                                              color: Color(ListColor
                                                                  .colorOrange),
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ),
        )
      ],
    );
  }

  Widget secondPage() {
    return Obx(
      () => Container(
        child: controller.loadTotalSubuser.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 20 -
                              FontTopPadding.getSize(14),
                          left: GlobalVariable.ratioWidth(Get.context) * 16,
                          right: GlobalVariable.ratioWidth(Get.context) * 16,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: CustomText(
                                ("SubscriptionCreateLabelPaketUser".tr + " "),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Container(
                            child: CustomText(
                                "SubscriptionCreateLabelOpsional".tr,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Obx(
                      () => ListView(
                        children: [
                          for (var index = 0;
                              index < controller.jumlahPaketSubuser.value;
                              index++)
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                    0,
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                    GlobalVariable.ratioWidth(Get.context) *
                                        24),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(30),
                                        offset: Offset(0, 3),
                                        blurRadius: 12,
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withAlpha(30),
                                        offset: Offset(0, 3),
                                        blurRadius: 12,
                                        spreadRadius: 0,
                                      )
                                    ]),
                                child: Column(children: [
                                  Container(
                                      constraints: BoxConstraints(
                                          minHeight: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              40),
                                      margin: EdgeInsets.only(
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14,
                                          bottom: (controller.listPaketSubuser[index]
                                                          [controller.subuserDescription]
                                                      as String)
                                                  .isNotEmpty
                                              ? GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12
                                              : 14),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  40,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                              child: CustomText(
                                                  "SubscriptionCreateLabelPaketSubuser"
                                                      .tr,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(ListColor
                                                      .colorLightGrey4))),
                                          Expanded(
                                              child: Obx(
                                            () => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .choosePaketSubuser(
                                                              index);
                                                    },
                                                    child: Container(
                                                        height: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            40,
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        12),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        8),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFA8A8A8),
                                                                width: 1)),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: Obx(
                                                              () => CustomText(
                                                                controller.listPaketSubuser[index]
                                                                            [
                                                                            controller
                                                                                .subuserID] ==
                                                                        0
                                                                    ? "SubscriptionCreateLabelPilihPaketSubuser"
                                                                        .tr
                                                                    : controller
                                                                            .listPaketSubuser[index]
                                                                        [
                                                                        controller
                                                                            .subuserName],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey4),
                                                                maxLines: 1,
                                                              ),
                                                            )),
                                                            Container(
                                                                // margin: EdgeInsets.only(
                                                                //     left: GlobalVariable.ratioWidth(Get
                                                                //             .context) *
                                                                //         12),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                              "assets/ic_arrow_down_subscription.svg",
                                                              color: Color(
                                                                  ListColor
                                                                      .colorGrey3),
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                            )),
                                                          ],
                                                        )),
                                                  ),
                                                  (controller.listPaketSubuser[
                                                                      index][
                                                                  controller
                                                                      .subuserDescription]
                                                              as String)
                                                          .isEmpty
                                                      ? SizedBox.shrink()
                                                      : Container(
                                                          margin: EdgeInsets.only(
                                                              top: (GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      8) -
                                                                  FontTopPadding
                                                                      .getSize(
                                                                          12)),
                                                          child: CustomText(
                                                            controller.listPaketSubuser[
                                                                    index][
                                                                controller
                                                                    .subuserDescription],
                                                            color: Color(ListColor
                                                                .colorLightGrey4),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        )
                                                ]),
                                          ))
                                        ],
                                      )),
                                  Container(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          0.5,
                                      color: Color(ListColor.colorLightGrey2)),
                                  Container(
                                      constraints: BoxConstraints(
                                          minHeight: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              40),
                                      margin: EdgeInsets.symmetric(
                                          vertical: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: CustomText(
                                                  "SubscriptionCreateLabelHargaPerPaket"
                                                      .tr,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(ListColor
                                                      .colorLightGrey4))),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                              child: Obx(() => CustomText(
                                                    Utils.formatUang(controller
                                                        .listPaketSubuser[index]
                                                            [controller
                                                                .subuserHarga]
                                                        .toDouble()),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  )))
                                        ],
                                      )),
                                  Container(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          0.5,
                                      color: Color(ListColor.colorLightGrey2)),
                                  Obx(
                                    () => Container(
                                        constraints: BoxConstraints(
                                            minHeight:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    40),
                                        margin: EdgeInsets.only(
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14,
                                          bottom: controller.listPaketSubuser[
                                                          index]
                                                      [controller.subuserID] !=
                                                  0
                                              ? GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12
                                              : GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: EdgeInsets.only(
                                                      bottom: controller.listPaketSubuser[index][controller.subuserID] !=
                                                              0
                                                          ? GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              3
                                                          : 0,
                                                      right:
                                                          GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              12),
                                                  child: CustomText(
                                                      "SubscriptionCreateLabelJumlah".tr,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(ListColor.colorLightGrey4))),
                                            ),
                                            Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Obx(
                                                  () => Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                            width: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                90,
                                                            child:
                                                                jumlahPaketTextFielde(
                                                                    index)),
                                                        controller.listPaketSubuser[
                                                                        index][
                                                                    controller
                                                                        .subuserID] ==
                                                                0
                                                            ? SizedBox.shrink()
                                                            : Container(
                                                                margin: EdgeInsets.only(
                                                                    top: (GlobalVariable.ratioWidth(Get.context) *
                                                                            6) -
                                                                        FontTopPadding.getSize(
                                                                            12)),
                                                                child:
                                                                    CustomText(
                                                                  "${(controller.listPaketSubuser[index][controller.subuserTotal] * controller.listPaketSubuser[index][controller.subuserQtySubuser]).toString()} " +
                                                                      controller
                                                                              .listPaketSubuser[index]
                                                                          [
                                                                          controller
                                                                              .subuserInfo],
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorLightGrey4),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                ),
                                                              )
                                                      ]),
                                                ))
                                          ],
                                        )),
                                  ),
                                  Container(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          0.5,
                                      color: Color(ListColor.colorLightGrey2)),
                                  Container(
                                      constraints: BoxConstraints(
                                          minHeight: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              40),
                                      margin: EdgeInsets.symmetric(
                                          vertical: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: CustomText(
                                                  "SubscriptionCreateLabelSubTotal"
                                                      .tr,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(ListColor
                                                      .colorLightGrey4))),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                              child: Obx(() => CustomText(
                                                    Utils.formatUang((controller
                                                                    .listPaketSubuser[
                                                                index][
                                                            controller
                                                                .subuserHarga]) *
                                                        (controller.listPaketSubuser[
                                                                    index][
                                                                controller
                                                                    .subuserTotal])
                                                            .toDouble()),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  )))
                                        ],
                                      )),
                                  controller.jumlahPaketSubuser.value == 1
                                      ? SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: () {
                                            controller.deleteSubuser(index);
                                          },
                                          child: Container(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  34,
                                              width: double.infinity,
                                              margin: EdgeInsets.only(
                                                  bottom: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      14),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          32),
                                                  border: Border.all(
                                                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                                                      color: Color(ListColor.colorRed))),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: SvgPicture.asset(
                                                      "assets/ic_close2,5.svg",
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          10,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          10,
                                                      color: Color(
                                                          ListColor.colorRed),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          12),
                                                  CustomText(
                                                    "SubscriptionCreateLabelHapusPaket"
                                                        .tr,
                                                    color: Color(
                                                        ListColor.colorRed),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ],
                                              )),
                                        )
                                ])),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  if (controller.listPaketSubuser[controller
                                                  .jumlahPaketSubuser.value -
                                              1][controller.subuserID] !=
                                          0 &&
                                      controller.jumlahPaketSubuser.value !=
                                          controller.totalSemuaPaketSubuser
                                              .value) controller.addSubuser();
                                },
                                child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: GlobalVariable.ratioWidth(Get.context) *
                                            14),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(controller.listPaketSubuser[controller.jumlahPaketSubuser.value - 1][
                                                        controller.subuserID] !=
                                                    0 &&
                                                controller.jumlahPaketSubuser.value !=
                                                    controller
                                                        .totalSemuaPaketSubuser
                                                        .value
                                            ? ListColor.color4
                                            : ListColor.colorLightGrey2),
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(Get.context) * 42)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/plus_white.svg",
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16),
                                        // Icon(Icons.add,
                                        //     color: Colors.white,
                                        //     size: GlobalVariable.ratioWidth(
                                        //             Get.context) *
                                        //         16),
                                        Container(
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12),
                                        CustomText(
                                          "SubscriptionCreateLabelTambahPaket"
                                              .tr,
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        )
                                      ],
                                    ))),
                          ),
                          controller.jumlahPaketSubuser.value == 1 &&
                                  controller.listPaketSubuser[0]
                                          [controller.subuserID] ==
                                      0
                              ? SizedBox.shrink()
                              : Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    vertical: (GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24 -
                                        FontTopPadding.getSize(14)),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        "SubscriptionCreateLabelTotalHargaSubUser"
                                            .tr,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14),
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    16,
                                            vertical: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                14,
                                          ),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withAlpha(30),
                                                    offset: Offset(0, 3),
                                                    blurRadius: 12,
                                                    spreadRadius: 0)
                                              ]),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                  child: CustomText(
                                                      "SubscriptionCreateLabelPaketSubuser"
                                                          .tr,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(ListColor
                                                          .colorGrey3))),
                                              Obx(
                                                () => CustomText(
                                                    Utils.formatUang(controller
                                                        .totalHargaSubuser.value
                                                        .toDouble()),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ))
                                    ],
                                  ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget thirdPage() {
    return Container(
        child: Obx(
      () => ListView(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 20,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  0),
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(70),
                        offset: Offset(0, 4),
                        blurRadius: 2,
                        spreadRadius: 3)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(Get.context) * 14),
                      child: CustomText(
                          "SubscriptionCreateLabelPaketLangganan".tr,
                          fontWeight: FontWeight.w600)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 12),
                        child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => CustomText(
                                      (controller.listPaketSubscription.where(
                                              (element) =>
                                                  element[controller
                                                          .subscriptionID]
                                                      .toString() ==
                                                  controller
                                                      .selectedPaketSubscription
                                                      .value)).toList()[0]
                                          [controller.subscriptionName],
                                      color: Color(ListColor.colorLightGrey4),
                                      fontWeight: FontWeight.w600),
                                ),
                                (controller.listPaketSubscription.where((element) =>
                                                    element[controller
                                                            .subscriptionID]
                                                        .toString() ==
                                                    controller
                                                        .selectedPaketSubscription
                                                        .value)).toList()[0]
                                                [controller.subscriptionFree] !=
                                            0 ||
                                        (controller.listVoucher.length > 0 &&
                                            controller.listVoucher
                                                .any((element) {
                                              return (element[controller
                                                              .voucherPaketID]
                                                          .toString() ==
                                                      controller
                                                          .selectedPaketSubscription
                                                          .value
                                                          .toString() &&
                                                  element[controller
                                                          .voucherFreeUser] !=
                                                      0);
                                            }))
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                4),
                                        child: Obx(() => CustomText(
                                            ("SubscriptionCreateLabelGratisSubuser".tr)
                                                .replaceAll(
                                                    "#",
                                                    ((controller.listPaketSubscription
                                                                    .where((element) =>
                                                                        element[controller.subscriptionID]
                                                                            .toString() ==
                                                                        controller
                                                                            .selectedPaketSubscription
                                                                            .value)
                                                                    .toList()[0]
                                                                [controller
                                                                    .subscriptionFree]) +

                                                            //cek
                                                            ((controller.listVoucher
                                                                            .length >
                                                                        0 &&
                                                                    controller
                                                                        .listVoucher
                                                                        .any(
                                                                            (element) {
                                                                      return (element[controller.voucherPaketID].toString() ==
                                                                              controller.selectedPaketSubscription.value
                                                                                  .toString() &&
                                                                          element[controller.voucherFreeUser] !=
                                                                              0);
                                                                    }))
                                                                ? controller
                                                                        .listVoucher[0]
                                                                    [controller.voucherFreeUser]
                                                                : 0))
                                                        .toString()),
                                            // "Gratis ${controller.listPaketSubscription.where((element) => element[controller.subscriptionID].toString() == controller.selectedPaketSubscription.value).toList()[0][controller.subscriptionFree]} Sub User",
                                            color: Color(ListColor.colorOrange),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            )),
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.topRight,
                        child: Obx(() => CustomText(
                            Utils.formatUang((controller.listPaketSubscription
                                    .where((element) =>
                                        element[controller.subscriptionID]
                                            .toString() ==
                                        controller
                                            .selectedPaketSubscription.value))
                                .toList()[0][controller.subscriptionPrice]
                                .toDouble()),
                            textAlign: TextAlign.end,
                            fontWeight: FontWeight.w600)),
                      )),
                    ],
                  )
                ],
              )),
          (controller.listPaketSubuser.length == 1 &&
                  controller.listPaketSubuser[0][controller.subscriptionID]
                          .toString() ==
                      "0")
              ? SizedBox.shrink()
              : Container(
                  margin: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 24,
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      0),
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 14),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(70),
                            offset: Offset(0, 4),
                            blurRadius: 2,
                            spreadRadius: 3)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 14),
                          child: CustomText(
                              "SubscriptionCreateLabelPaketSubuser".tr,
                              fontWeight: FontWeight.w600)),
                      Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var index = 0;
                                index <
                                    List.from(controller.listPaketSubuser)
                                        .where((element) =>
                                            element[controller.subuserTotal] >
                                            0)
                                        .length;
                                index++)
                              Container(
                                margin: EdgeInsets.only(
                                    top: index == 0
                                        ? 0
                                        : GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      "${controller.listPaketSubuser[index][controller.subuserTotal].toString()}x ",
                                      color: Color(ListColor
                                          .colorLightGrey4),
                                      fontWeight:
                                          FontWeight.w600),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Obx(() => CustomText(
                                                          controller.listPaketSubuser[index][controller.subuserName],
                                                          color: Color(ListColor
                                                              .colorLightGrey4),
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: GlobalVariable
                                                                  .ratioWidth(
                                                                      Get.context) *
                                                              4),
                                                      child: Obx(() => CustomText(
                                                          "${(controller.listPaketSubuser[index][controller.subuserTotal] * controller.listPaketSubuser[index][controller.subuserQtySubuser]).toString()} " +
                                                              controller.listPaketSubuser[
                                                                      index][
                                                                  controller
                                                                      .subuserInfo],
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                    ),
                                                    controller.listVoucher.isEmpty ||
                                                            controller.listVoucher.any((element) =>
                                                                (element[controller.voucherPaketID]
                                                                            .toString() ==
                                                                        controller.listPaketSubuser[index][controller.subuserID]
                                                                            .toString() &&
                                                                    element[controller.voucherFreeUser] ==
                                                                        0))
                                                        ? SizedBox.shrink()
                                                        : controller.listVoucher.length > 0 &&
                                                                controller.listVoucher
                                                                    .any((element) =>
                                                                        (element[controller.voucherPaketID].toString() == controller.listPaketSubuser[index][controller.subuserID].toString() &&
                                                                            element[controller.voucherFreeUser] != 0))
                                                            ? Container(
                                                                margin: EdgeInsets.only(
                                                                    top: GlobalVariable
                                                                            .ratioWidth(
                                                                                Get.context) *
                                                                        4),
                                                                child: Obx(() =>
                                                                    CustomText(
                                                                        ("SubscriptionCreateLabelGratisSubuser"
                                                                                .tr)
                                                                            .replaceAll(
                                                                                "#",
                                                                                // Utils.formatUang(
                                                                                controller.listVoucher[0][controller.voucherFreeUser]
                                                                                    .toString()

                                                                                // )
                                                                                ),
                                                                        // "Gratis ${Utils.formatUang(controller.listVoucher[0][controller.voucherFreeUser].toDouble())} Sub User",
                                                                        color: Color(
                                                                            ListColor
                                                                                .colorOrange),
                                                                        fontSize: 12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                              )
                                                            : Container(),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                alignment: Alignment.topRight,
                                                child: Obx(() => controller.listVoucher.length > 0 &&
                                                        controller.listVoucher.any((element) =>
                                                            (element[controller.voucherPaketID]
                                                                        .toString() ==
                                                                    controller.listPaketSubuser[index][controller.subuserID]
                                                                        .toString() &&
                                                                element[controller.voucherAmount] !=
                                                                    0))
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    2),
                                                            child: CustomText(
                                                                Utils.formatUang(controller
                                                                    .listPaketSubuser[
                                                                        index][
                                                                        controller
                                                                            .subuserSubTotal]
                                                                    .toDouble()),
                                                                color: Color(ListColor
                                                                    .colorRed),
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight.w600),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    2),
                                                            child: CustomText(
                                                                Utils.formatUang(
                                                                    controller
                                                                        .listVoucher[
                                                                            0][
                                                                            controller
                                                                                .voucherDiskon]
                                                                        .toDouble()),
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight.w600),
                                                          ),
                                                        ],
                                                      )
                                                    : CustomText(
                                                        Utils.formatUang(controller.listPaketSubuser[index][controller.subuserSubTotal].toDouble()),
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600)),
                                              )),
                                            ],
                                          ),
                                          index ==
                                                  (List.from(controller
                                                              .listPaketSubuser)
                                                          .where((element) =>
                                                              element[controller
                                                                  .subuserTotal] >
                                                              0)
                                                          .length -
                                                      1)
                                              ? SizedBox.shrink()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14),
                                                  width: double.infinity,
                                                  color: Color(
                                                      ListColor.colorLightGrey2),
                                                  height: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      1)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  )),
          Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 24,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  0),
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(70),
                        offset: Offset(0, 4),
                        blurRadius: 2,
                        spreadRadius: 3)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(Get.context) * 11),
                      child: CustomText("SubscriptionCreateLabelKodeVoucher".tr,
                          fontWeight: FontWeight.w600)),
                  Container(
                      child: Stack(children: [
                    Positioned.fill(
                      child: SvgPicture.asset("assets/ic_voucher_bg.svg"),
                    ),
                    GestureDetector(
                        onTap: () {
                          controller.chooseVoucher();
                        },
                        child: Container(
                          color: Colors.transparent,
                          constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 40),
                          child: Obx(
                            () => Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                ),
                                SvgPicture.asset(
                                  "assets/ic_voucher.svg",
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                ),
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                GlobalVariable.ratioWidth(Get.context) *
                                                    12),
                                        margin: EdgeInsets.only(
                                            left: GlobalVariable.ratioWidth(Get.context) *
                                                10),
                                        child: Obx(() => CustomText(
                                            controller.listVoucher.isEmpty
                                                ? "SubscriptionCreateLabelPakaiKodePromo"
                                                    .tr
                                                : controller.listVoucher[0]
                                                    [controller.voucherCode],
                                            color: Color(ListColor.color4),
                                            fontSize: 12,
                                            fontWeight:
                                                controller.listVoucher.isEmpty
                                                    ? FontWeight.w600
                                                    : FontWeight.w700)))),
                                controller.listVoucher.length == 0
                                    ? Container(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            20,
                                      )
                                    : _button(
                                        marginRight: 22,
                                        width: 13,
                                        height: 13,
                                        useShadow: true,
                                        borderRadius: 50,
                                        customWidget: Container(
                                          child: SvgPicture.asset(
                                            "assets/ic_close_voucher_subscription.svg",
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                5,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                5,
                                          ),
                                        ),
                                        onTap: () {
                                          controller.listVoucher.clear();
                                          controller.listVoucher.refresh();
                                          controller.countAllSubuser();
                                          controller.updateTotalPembayaran();
                                        })

                                // GestureDetector(
                                //     onTap: () {
                                //       controller.listVoucher.clear();
                                //       controller.listVoucher.refresh();
                                //       controller.countAllSubuser();
                                //       controller.updateTotalPembayaran();
                                //     },
                                //     child: Container(
                                //         padding: EdgeInsets.symmetric(
                                //           horizontal:
                                //               GlobalVariable.ratioWidth(
                                //                       Get.context) *
                                //                   20,
                                //           vertical:
                                //               GlobalVariable.ratioWidth(
                                //                       Get.context) *
                                //                   12,
                                //         ),
                                //         child: Container(
                                //             decoration: BoxDecoration(
                                //                 boxShadow: [
                                //                   BoxShadow(
                                //                       color: Colors.grey
                                //                           .withAlpha(100),
                                //                       blurRadius: 0.5,
                                //                       spreadRadius: 1)
                                //                 ],
                                //                 color: Colors.white,
                                //                 shape: BoxShape.circle),
                                //             width:
                                //                 GlobalVariable.ratioWidth(
                                //                         Get.context) *
                                //                     13,
                                //             height:
                                //                 GlobalVariable.ratioWidth(
                                //                         Get.context) *
                                //                     13,
                                //             child: Icon(Icons.close,
                                //                 size: GlobalVariable
                                //                         .ratioWidth(
                                //                             Get.context) *
                                //                     9,
                                //                 color: Colors.black))
                                //         // SvgPicture.asset(
                                //         //     "assets/ic_close_round.svg")
                                //         ))
                              ],
                            ),
                          ),
                        ))
                  ]))
                ],
              )),
          Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 24,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  0),
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(70),
                        offset: Offset(0, 4),
                        blurRadius: 2,
                        spreadRadius: 3)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 36),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Obx(
                            () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(
                                      style: TextStyle(height: 1.2),
                                      children: [
                                        TextSpan(
                                            text:
                                                ("SubscriptionCreateLabelSubTotal"
                                                        .tr +
                                                    " "),
                                            style: TextStyle(
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(ListColor
                                                    .colorLightGrey4))),
                                        TextSpan(
                                            text:
                                                "SubscriptionCreateLabelSebelumDiskon"
                                                    .tr,
                                            style: TextStyle(
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(ListColor
                                                    .colorLightGrey4))),
                                      ])),
                                  controller.totalSubuser.value > 0 ||
                                          controller.totalFreeSubuser.value > 0
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  4),
                                          child: Text.rich(TextSpan(
                                              style: TextStyle(height: 1.2),
                                              children: [
                                                TextSpan(
                                                    text: controller
                                                                .totalSubuser
                                                                .value ==
                                                            0
                                                        ? ""
                                                        : ("${controller.totalSubuser.value.toString()} " +
                                                            "SubscriptionCreateLabelSubUser"
                                                                .tr),
                                                    style: TextStyle(
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(Get
                                                                    .context) *
                                                            12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black)),
                                                TextSpan(
                                                    text: controller.totalSubuser
                                                                    .value !=
                                                                0 &&
                                                            controller
                                                                    .totalFreeSubuser
                                                                    .value !=
                                                                0
                                                        ? " + "
                                                        : "",
                                                    style: TextStyle(
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(Get
                                                                    .context) *
                                                            12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(ListColor
                                                            .colorOrange))),
                                                TextSpan(
                                                    text: controller
                                                                .totalFreeSubuser
                                                                .value ==
                                                            0
                                                        ? ""
                                                        : ("SubscriptionCreateLabelGratisSubuser".tr)
                                                            .replaceAll(
                                                                "#",
                                                                controller
                                                                    .totalFreeSubuser
                                                                    .value
                                                                    .toString()),
                                                    style: TextStyle(
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(Get
                                                                    .context) *
                                                            12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(ListColor
                                                            .colorOrange))),
                                              ])),
                                        )
                                      : SizedBox.shrink()
                                ]),
                          )),
                          Container(
                              child: Obx(
                            () => CustomText(
                                Utils.formatUang(
                                    controller.subtotal.value.toDouble()),
                                fontWeight: FontWeight.w700),
                          ))
                        ],
                      )),
                  Container(
                      width: double.infinity,
                      color: Color(ListColor.colorLightGrey2),
                      height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 36),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: CustomText(
                                  "SubscriptionCreateLabelDiskonVoucher".tr,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4))),
                          Container(
                              child: Obx(
                            () => CustomText(
                                Utils.formatUang(controller.listVoucher.isEmpty
                                    ? 0.0
                                    : controller.listVoucher[0]
                                            [controller.voucherAmount]
                                        .toDouble()),
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorRed)),
                          ))
                        ],
                      )),
                  Container(
                      width: double.infinity,
                      color: Color(ListColor.colorLightGrey2),
                      height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 36),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: CustomText(
                                  "SubscriptionCreateLabelBiayaLayanan".tr,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4))),
                          Container(
                              child: Obx(
                            () => CustomText(
                                Utils.formatUang(
                                    controller.biayaLayanan.value.toDouble()),
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ))
                        ],
                      )),
                  Container(
                      width: double.infinity,
                      color: Color(ListColor.colorLightGrey2),
                      height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 36),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: CustomText(
                                  "SubscriptionCreateLabelTotalPajak".tr,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4))),
                          Container(
                              child: Obx(
                            () => CustomText(
                                Utils.formatUang(controller.totalPajak.value),
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ))
                        ],
                      )),
                  Container(
                      width: double.infinity,
                      color: Color(ListColor.colorLightGrey2),
                      height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8),
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 36),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: CustomText(
                                  "SubscriptionCreateLabelTotalPesanan".tr,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4))),
                          Container(
                              child: Obx(
                            () => CustomText(
                                Utils.formatUang(controller.totalPesanan.value),
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ))
                        ],
                      )),
                ],
              )),
          Container(
              margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 24,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 24),
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(70),
                        offset: Offset(0, 4),
                        blurRadius: 2,
                        spreadRadius: 3)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(Get.context) * 14),
                      child: Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomText(
                                  "SubscriptionCreateLabelMetodePembayaran".tr,
                                  fontWeight: FontWeight.w600),
                            ),
                            controller.metodePembayaran.isEmpty
                                ? SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () {
                                      controller.chooseMetodePembayaran();
                                    },
                                    child: CustomText(
                                        "SubscriptionCreateLabelGanti".tr,
                                        fontSize: 12,
                                        color: Color(ListColor.color4),
                                        fontWeight: FontWeight.w600),
                                  ),
                          ],
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      if (controller.metodePembayaran.isEmpty)
                        controller.chooseMetodePembayaran();
                    },
                    child: Obx(
                      () => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                              vertical: GlobalVariable.ratioWidth(Get.context) *
                                  (controller.metodePembayaran.isNotEmpty
                                      ? 12
                                      : 8)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 3),
                            color:
                                Color(ListColor.colorLightGrey10).withAlpha(77),
                          ),
                          child: Obx(
                            () => Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                controller.metodePembayaran.isNotEmpty
                                    ? CachedNetworkImage(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        fit: BoxFit.fitHeight,
                                        imageUrl: controller.metodePembayaran[0]
                                            [controller.paymentThumbnail])
                                    : SvgPicture.asset(
                                        "assets/ic_metode_pembayaran.svg",
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            25,
                                      ),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        child: Obx(() => CustomText(
                                            controller.metodePembayaran.isEmpty
                                                ? "SubscriptionCreateLabelPilihMetodePembayaran"
                                                    .tr
                                                : controller.metodePembayaran[0]
                                                    [controller.paymentName],
                                            color: Color(ListColor.color4),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600))))
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              )),
        ],
      ),
    ));
  }

  Widget jumlahPaketTextFielde(int index) {
    var textController =
        controller.listPaketSubuser[index][controller.subUserController];
    var textOnChange =
        controller.listPaketSubuser[index][controller.subUserController].text;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: GlobalVariable.ratioWidth(Get.context) * 85,
          height: GlobalVariable.ratioWidth(Get.context) * 24,
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
          margin: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      width: GlobalVariable.ratioWidth(Get.context) * 1.0,
                      color: Color(ListColor.colorLightGrey10)),
                  bottom: BorderSide(
                      width: GlobalVariable.ratioWidth(Get.context) * 1.0,
                      color: Color(ListColor.colorLightGrey10)))),
          child: Focus(
            onFocusChange: (val) {
              if (!val) {
                controller.onChangeTotalSubuser(index,
                    textOnChange.isEmpty ? "0" : textOnChange, textController);
                controller.countTotalHargaSubuser();
                controller.countAllSubuser();
                controller.updateTotalPembayaran();
              }
            },
            child: CustomTextField(
              enabled:
                  controller.listPaketSubuser[index][controller.subuserID] != 0,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textSize: 14,
              context: Get.context,
              controller: textController,
              newContentPadding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 5,
                  GlobalVariable.ratioWidth(Get.context) * 1,
                  GlobalVariable.ratioWidth(Get.context) * 2,
                  GlobalVariable.ratioWidth(Get.context) * 2),
              inputFormatters: [LengthLimitingTextInputFormatter(4)],
              newInputDecoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              onChanged: (value) {
                if (controller.listPaketSubuser[index][controller.subuserID] !=
                        0 &&
                    double.tryParse(value) != null) {
                  textOnChange = value;
                  OnChangeTextFieldNumber.checkNumber(
                      () => textController, value, true);
                } else {
                  textController.text = "0";
                }
              },
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                if (controller.listPaketSubuser[index][controller.subuserID] !=
                    0) {
                  controller.onChangeTotalSubuser(
                      index,
                      (int.parse(textController.text) - 1).toString(),
                      textController);
                }
              },
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border:
                        Border.all(width: 1, color: Color(ListColor.color4))),
                child: Icon(Icons.remove,
                    size: GlobalVariable.ratioWidth(Get.context) * 14,
                    color: Color(ListColor.color4)),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (controller.listPaketSubuser[index][controller.subuserID] !=
                    0) {
                  if (int.parse(textController.text) < 9999)
                    controller.onChangeTotalSubuser(
                        index,
                        (int.parse(textController.text) + 1).toString(),
                        textController);
                  else
                    controller.onChangeTotalSubuser(
                        index, "9999", textController);
                }
              },
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border:
                        Border.all(width: 1, color: Color(ListColor.color4))),
                child: Icon(Icons.add,
                    size: GlobalVariable.ratioWidth(Get.context) * 14,
                    color: Color(ListColor.color4)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _button({
    double height,
    double width,
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
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
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
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorBlack).withOpacity(0.2),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 1),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
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
