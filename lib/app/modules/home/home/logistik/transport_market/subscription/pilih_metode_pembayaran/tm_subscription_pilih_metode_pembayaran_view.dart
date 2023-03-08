import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pilih_metode_pembayaran/subscription_pilih_metode_pembayaran_expansion_component.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pilih_metode_pembayaran/tm_subscription_pilih_metode_pembayaran_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class TMSubscriptionPilihMetodePembayaranView
    extends GetView<TMSubscriptionPilihMetodePembayaranController> {
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
          title: "SubscriptionChoosePaymentMethod".tr,
          prefixIcon: null,
        ),
        body: SafeArea(
          child: Container(
            color: Color(ListColor.colorWhite),
            child: Obx(
              () => controller.onLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: controller.listMetodePembayaran.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: index == 0
                              ? EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 8,
                                )
                              : EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 8,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 8,
                                ),
                          child:
                              SubscriptionPilihMetodePembayaranExpansionComponent(
                            initiallyOpen: index == 0,
                            header: Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
                                      index == 0
                                          ? "assets/ic_subscription_transfer.svg"
                                          : "assets/ic_subscription_kredit_card.svg",
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          19,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      controller.listMetodePembayaran[index]
                                          .paymentCategory,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            content: Column(
                              children: [
                                // Container(
                                //   decoration: BoxDecoration(boxShadow: [
                                //     BoxShadow(
                                //       blurRadius: 10,
                                //       spreadRadius: 2,
                                //       color: Colors.black.withOpacity(0.5),
                                //     )
                                //   ]),
                                // ),
                                for (int i = 0;
                                    i <
                                        controller.listMetodePembayaran[index]
                                            .content.length;
                                    i++)
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          GlobalVariable.ratioWidth(context) *
                                              16,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        controller.updateSelected(
                                            controller
                                                .listMetodePembayaran[index]
                                                .categoryID,
                                            controller
                                                .listMetodePembayaran[index]
                                                .content[i]
                                                .paymentID);
                                      },
                                      child: Container(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            50,
                                        decoration: i ==
                                                (controller
                                                        .listMetodePembayaran[
                                                            index]
                                                        .content
                                                        .length -
                                                    1)
                                            ? null
                                            : BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(ListColor
                                                        .colorLightGrey10),
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        1,
                                                  ),
                                                ),
                                              ),
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: CachedNetworkImage(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        22,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        22,
                                                imageUrl: controller
                                                    .listMetodePembayaran[index]
                                                    .content[i]
                                                    .thumbnail,
                                              ),
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                            ),
                                            Expanded(
                                              child: CustomText(
                                                controller
                                                    .listMetodePembayaran[index]
                                                    .content[i]
                                                    .paymentName,
                                                overflow: TextOverflow.ellipsis,
                                                color: Color(
                                                    ListColor.colorLightGrey4),
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  28,
                                            ),
                                            Obx(
                                              () => (controller.selectedCategory
                                                              .value ==
                                                          controller
                                                              .listMetodePembayaran[
                                                                  index]
                                                              .categoryID) &&
                                                      (controller
                                                              .selectedContent
                                                              .value ==
                                                          controller
                                                              .listMetodePembayaran[
                                                                  index]
                                                              .content[i]
                                                              .paymentID)
                                                  ? _selectedWidget(context)
                                                  : SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
                  blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.16),
                )
              ]),
          child: Center(
            child: Obx(
              () => TextButton(
                onPressed: () {
                  if (!controller.onLoading.value) controller.onClickOk();
                },
                style: TextButton.styleFrom(
                  minimumSize: Size(
                    GlobalVariable.ratioWidth(Get.context) * 160,
                    GlobalVariable.ratioWidth(Get.context) * 36,
                  ),
                  backgroundColor: Color(
                      controller.selectedCategory.value == '0'
                          ? ListColor.colorLightGrey2
                          : ListColor.colorBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 18,
                    ),
                  ),
                ),
                child: CustomText(
                  'OK',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(ListColor.color2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButtonWidget() {
    return GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Center(
                child: CircleAvatar(
                    backgroundColor: Color(ListColor.colorBlue),
                    radius: 15,
                    child: Center(
                        child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20, // 30 * 0.7,
                      color: Color(ListColor.color2),
                    ))))));
  }

  Widget _selectedWidget(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: GlobalVariable.ratioWidth(context) * 16,
        height: GlobalVariable.ratioWidth(context) * 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(ListColor.color2),
          border: Border.all(
            width: GlobalVariable.ratioWidth(context) * 2,
            color: Color(ListColor.colorBlue),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(ListColor.colorBlue).withOpacity(0.23),
              spreadRadius: GlobalVariable.ratioWidth(context) * 1,
              blurRadius: GlobalVariable.ratioWidth(context) * 5,
              offset: Offset(GlobalVariable.ratioWidth(context) * 0,
                  GlobalVariable.ratioWidth(context) * 6),
            )
          ],
        ),
        child: Center(
          child: Container(
            width: GlobalVariable.ratioWidth(context) * 6.86,
            height: GlobalVariable.ratioWidth(context) * 6.86,
            decoration: BoxDecoration(
              color: Color(ListColor.colorBlue),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
