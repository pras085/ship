import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_tipe_paket.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_home/tm_subscription_home_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class TMSubscriptionPopupKeuntungan {
  static void showAlertDialog({
    BuildContext context,
    Function onTap,
    bool isDismissible = false,
  }) async {
    TMSubscriptionHomeController controller;
    try {
      controller = Get.find();
    } catch (err) {}
    if (controller == null) {
      return;
    }
    var initChekbox =
        await SharedPreferencesHelper.getSubscriptionTMKeuntunganBerlangganan();
    controller.indexPopup.value = 0;
    final _keyDialog = new GlobalKey<State>();
    PageController pageController = PageController();
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext context) {
          return Dialog(
            key: _keyDialog,
            backgroundColor: Colors.transparent,
            insetPadding:
                EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                GlobalVariable.ratioWidth(Get.context) * 10,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 400,
                      child: Stack(children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(context) * 16),
                          child: PageView(
                            onPageChanged: (index) {
                              controller.indexPopup.value = index;
                            },
                            controller: pageController,
                            children: [
                              for (int i = 0;
                                  i < controller.listKeuntungan.length;
                                  i++)
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              25,
                                        ),
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            176,
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            176,
                                        child: SvgPicture.asset(
                                          controller.listKeuntungan[i].icon,
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              176,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              176,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                31,
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12),
                                        child: CustomText(
                                          controller.listKeuntungan[i].title,
                                          fontSize: 20,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        child: CustomText(
                                          controller.listKeuntungan[i].body,
                                          fontSize: 14,
                                          height: 1.2,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      12),
                              child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      child: SvgPicture.asset(
                                    "assets/ic_close1,5.svg",
                                    color: Color(ListColor.colorBlue),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            15,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            15,
                                  ))),
                            )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: GlobalVariable.ratioWidth(Get.context) *
                                    40),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < controller.listKeuntungan.length;
                                    i++)
                                  _buildPageIndicator(i),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Obx(
                      () => Container(
                        alignment: Alignment.topLeft,
                        height: GlobalVariable.ratioWidth(context) * 94,
                        child: controller.indexPopup.value !=
                                    controller.listKeuntungan.length - 1 ||
                                (controller.tipe ==
                                        TMTipePaketSubscription.ACTIVE ||
                                    (controller.tipe ==
                                            TMTipePaketSubscription
                                                .WILL_EXPIRED &&
                                        controller.dataPaketNext != null))
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              28),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.indexPopup.value !=
                                              controller.listKeuntungan.length -
                                                  1) {
                                            pageController.animateToPage(
                                                controller
                                                        .listKeuntungan.length -
                                                    1,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.linear);
                                          } else {
                                            Get.back();
                                          }
                                        },
                                        child: CustomText(
                                          'SubscriptionSkip'.tr,
                                          color: Color(ListColor.colorBlue),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //button kiri
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            31,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            31,
                                    margin: EdgeInsets.only(),
                                    decoration: BoxDecoration(
                                      color: Color(ListColor.colorWhite),
                                      border: Border.all(
                                          color: Color(
                                              0 == controller.indexPopup.value
                                                  ? ListColor.colorLightGrey2
                                                  : ListColor.colorBlue)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      context) *
                                                  12),
                                        ),
                                        onTap: 0 == controller.indexPopup.value
                                            ? null
                                            : () {
                                                if (0 !=
                                                    controller
                                                        .indexPopup.value) {
                                                  pageController.animateToPage(
                                                      controller.indexPopup
                                                              .value -
                                                          1,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.linear);
                                                }
                                              },
                                        child: Container(
                                          child: Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: SvgPicture.asset(
                                              "assets/ic_arrow_right_subscription.svg",
                                              color: Color(0 ==
                                                      controller
                                                          .indexPopup.value
                                                  ? ListColor.colorLightGrey2
                                                  : ListColor.colorBlue),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  31,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  31,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //button kanan
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            31,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            31,
                                    margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            28),
                                    decoration: BoxDecoration(
                                      color: Color(controller
                                                  .indexPopup.value !=
                                              controller.listKeuntungan.length -
                                                  1
                                          ? ListColor.colorBlue
                                          : ListColor.colorLightGrey2),
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(context) *
                                              12),
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(context) *
                                              12),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      context) *
                                                  12),
                                        ),
                                        onTap: () {
                                          if (controller.listKeuntungan.length -
                                                  1 !=
                                              controller.indexPopup.value) {
                                            pageController.animateToPage(
                                                controller.indexPopup.value + 1,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.linear);
                                          }
                                        },
                                        child: Container(
                                          child: SvgPicture.asset(
                                            "assets/ic_arrow_right_subscription.svg",
                                            color: Color(ListColor.colorWhite),
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                31,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                31,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  controller.tipe ==
                                              TMTipePaketSubscription.FIRST ||
                                          (controller.tipe ==
                                                  TMTipePaketSubscription
                                                      .WILL_EXPIRED &&
                                              controller.dataPaketNext ==
                                                  null) ||
                                          controller.tipe ==
                                              TMTipePaketSubscription.EXPIRED
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            _button(
                                                backgroundColor:
                                                    Color(ListColor.colorBlue),
                                                marginBottom: 15,
                                                text: 'SubscriptionSubscribeNow'
                                                    .tr,
                                                onTap: () {
                                                  Get.back();
                                                  //pindah halaman
                                                  onTap();
                                                }),
                                          ],
                                        )
                                      : Container(),
                                  controller.tipe ==
                                          TMTipePaketSubscription.FIRST
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            CheckBoxCustom(
                                              border: 1,
                                              size: 16,
                                              shadowSize: 19,
                                              isWithShadow: true,
                                              onChanged: (onChanged) async {
                                                await SharedPreferencesHelper
                                                    .setSubscriptionTMKeuntunganBerlangganan(
                                                        onChanged);
                                                initChekbox = onChanged;
                                              },
                                              value: initChekbox,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          2,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          5),
                                              child: CustomText(
                                                'SubscriptionDontShowAgain'.tr,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  static Widget _buildPageIndicator(int i) {
    TMSubscriptionHomeController controller;
    try {
      controller = Get.find();
    } catch (err) {}
    if (controller == null) {
      return Container();
    }
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 2.5),
        height: GlobalVariable.ratioWidth(Get.context) * 6.0,
        width: GlobalVariable.ratioWidth(Get.context) * 6,
        decoration: BoxDecoration(
          color: controller.indexPopup.value == i
              ? Color(ListColor.colorBlue)
              : Color(ListColor.colorLightGrey2),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 12),
        ),
      ),
    );
  }

  static Widget _button({
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 24,
    double paddingTop = 0,
    double paddingRight = 24,
    double paddingBottom = 0,
    bool useShadow = true,
    bool useBorder = false,
    double borderRadius = 20,
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
      height: GlobalVariable.ratioWidth(Get.context) * 30,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
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

class TMSubscriptionPopupKeuntunganModel {
  String icon;
  String title;
  String body;

  TMSubscriptionPopupKeuntunganModel(this.icon, this.title, this.body);
}
