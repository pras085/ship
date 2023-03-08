import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pembayaran_subscription/pembayaran_subscription_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'pembayaran_subscription_expansion_componnet.dart';

class PembayaranSubscriptionView
    extends GetView<PembayaranSubscriptionController> {
  final numberFormat = new NumberFormat("#,##0.00", "en_US");
  final dateFormat = new DateFormat("d MMM yyyy hh:mm");

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => controller.afterBuild());
    return WillPopScope(
      onWillPop: () {
        return controller.onWillPop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarDetail(
          onClickBack: () => controller.onWillPop(),
          title: "SubscriptionPayment".tr,
          prefixIcon: null,
        ),
        body: Container(
          color: Color(ListColor.colorWhite),
          child: Obx(
            () => controller.onLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          child: Obx(
                            () => Stack(
                              children: [
                                SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    panelTotalPembayaran(),
                                    panelMetodePembayaran(),
                                    panelLangkahPembayaran(context),
                                    SizedBox(
                                      height: Get.height * 0.15,
                                    )
                                  ],
                                )),
                                !controller.loadingUpdate.value
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      10,
                                                ),
                                              ),
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: Container(
            height: GlobalVariable.ratioWidth(Get.context) * 55,
            decoration: BoxDecoration(
                color: Color(ListColor.color2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10),
                    topRight: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.3),
                  )
                ]),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      if (!controller.onLoading.value &&
                          !controller.loadingUpdate.value)
                        controller.changeMetode();
                    },
                    style: TextButton.styleFrom(
                        minimumSize: Size(
                            GlobalVariable.ratioWidth(Get.context) * 160,
                            GlobalVariable.ratioWidth(Get.context) * 36),
                        backgroundColor: Color(ListColor.color2),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(ListColor.colorBlue), width: 1),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 18))),
                    child: CustomText(
                      'SubscriptionChangePayment'.tr,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(ListColor.colorBlue),
                    )),
                SizedBox(width: 12),
                TextButton(
                    onPressed: () {
                      if (!controller.onLoading.value &&
                          !controller.loadingUpdate.value)
                        controller.updateStatusPayment();
                    },
                    style: TextButton.styleFrom(
                        minimumSize: Size(
                            GlobalVariable.ratioWidth(Get.context) * 160,
                            GlobalVariable.ratioWidth(Get.context) * 36),
                        backgroundColor: Color(ListColor.colorBlue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 18))),
                    child: CustomText(
                      'OK',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(ListColor.color2),
                    ))
              ],
            ))),
      ),
    );
  }

  panelTotalPembayaran() {
    return Container(
        margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 20,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 14,
        ),
        padding: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 14,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 14,
          GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        decoration: BoxDecoration(
          // color: Color(ListColor.color2),
          border: Border.all(
            color: Color(ListColor.colorLightGrey10),
            width: GlobalVariable.ratioWidth(Get.context) * 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  'SubscriptionTotalPayment'.tr,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 19),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                            Utils.formatUang(controller.jumlahPembayaran),
                            // "Rp${numberFormat.format(controller.jumlahPembayaran)}",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(ListColor.colorBlue)))),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 11),
                GestureDetector(
                  onTap: () {
                    controller.onClickSalinTotalBayar();
                  },
                  child: Container(
                      child: SvgPicture.asset(
                    "assets/ic_copy.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                  )),
                  // Icon(
                  //   Icons.copy,
                  //   color: Color(ListColor.colorBlue),
                  //   size: GlobalVariable.ratioWidth(Get.context) * 20,
                  // ),
                ),
              ],
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'SubscriptionPaymentLimit'.tr,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 19),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                      // "${dateFormat.format(controller.batasPembayaran)} WIB",
                      controller.batasPembayaran,
                      fontSize: 14,
                      color: Color(ListColor.colorBlack),
                      textAlign: TextAlign.right,
                      fontWeight: FontWeight.w600),
                )),
              ],
            ),
          ],
        ));
  }

  panelMetodePembayaran() {
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 106,
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 16,
        0,
        GlobalVariable.ratioWidth(Get.context) * 16,
        GlobalVariable.ratioWidth(Get.context) * 14,
      ),
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 14,
        GlobalVariable.ratioWidth(Get.context) * 0,
        GlobalVariable.ratioWidth(Get.context) * 14,
        GlobalVariable.ratioWidth(Get.context) * 0,
      ),
      decoration: BoxDecoration(
        // color: Color(ListColor.color2),
        border: Border.all(
          color: Color(ListColor.colorLightGrey10),
          width: GlobalVariable.ratioWidth(Get.context) * 1,
        ),
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: GlobalVariable.ratioWidth(Get.context) * 22,
            width: GlobalVariable.ratioWidth(Get.context) * 22,
            imageUrl: controller.metodePembayaran?.thumbnail ?? "",
          ),
          SizedBox(
            width: GlobalVariable.ratioWidth(Get.context) * 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: GlobalVariable.ratioWidth(Get.context) * 27,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        controller.metodePembayaran?.paymentName ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorBlack),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10),
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(Get.context) * 8.6,
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(Get.context) * 35.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "SubscriptionAccountNumber".tr + " :",
                        fontSize: 10,
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorBlack),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          6.07,
                                ),
                                CustomText(
                                  faceVAString(controller.metodePembayaran?.noRek ?? ""),
                                  fontSize: 14,
                                  color: Color(ListColor.colorBlue),
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.onClickSalinNoRek();
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/ic_copy.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  panelLangkahPembayaran(context) {
    return Column(
      children: [
        for (int index = 0;
            index < controller.listLangkahPembayaran.length;
            index++)
          Container(
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * 16,
              0,
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 14,
            ),
            child: Container(
              child: PembayaranSubscriptionExpansionComponent(
                initiallyOpen: true,
                header: CustomText(
                  controller.listLangkahPembayaran[index].code,
                  fontWeight: FontWeight.w600,
                ),
                content: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(context) * 16,
                        0,
                        GlobalVariable.ratioWidth(context) * 16,
                        GlobalVariable.ratioWidth(context) * 6,
                      ),
                      child: Container(
                        height: GlobalVariable.ratioWidth(context) * 1,
                        color: Color(ListColor.colorLightGrey10),
                      ),
                    ),
                    for (int i = 0;
                        i <
                            controller
                                .listLangkahPembayaran[index].content.length;
                        i++)
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(context) * 14,
                          GlobalVariable.ratioWidth(context) * 6,
                          GlobalVariable.ratioWidth(context) * 14,
                          GlobalVariable.ratioWidth(context) * 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      8.5),
                              width: GlobalVariable.ratioWidth(context) * 12,
                              height: GlobalVariable.ratioWidth(context) * 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(ListColor.colorLightGrey2),
                                border: Border.all(
                                  width: GlobalVariable.ratioWidth(context) * 1,
                                  color: Color(ListColor.colorLightGrey2),
                                ),
                              ),
                              child: Center(
                                child: CustomText(
                                  (i + 1).toString(),
                                  fontSize: 8,
                                  color: Color(ListColor.colorLightGrey14),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: GlobalVariable.ratioWidth(context) * 12),
                            Expanded(
                              child: CustomText(
                                controller.listLangkahPembayaran[index]
                                        .content[i].descriptionID ??
                                    "",
                                height: 1.5,
                                fontSize: 14,
                                color: Color(
                                  ListColor.colorLightGrey14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }

  String faceVAString(String val) {
    if (val.length > 3) {
      String res = "";
      final chars = val.characters;
      res += val.substring(0, 3);
      final charSkip = chars.skip(3);
      for (var i = 0; i < charSkip.length; i++) {
        if (i % 4 == 0) {
          res += " ${charSkip.characterAt(i)}";
        } else {
          res += "${charSkip.characterAt(i)}";
        }
      }
      return res;
    } else {
      return val;
    }
  }

}
