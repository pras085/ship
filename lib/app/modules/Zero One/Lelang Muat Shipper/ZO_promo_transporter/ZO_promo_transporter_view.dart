import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_app_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_item_widgets/ZO_promo_transporter_item.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_list_menu.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_no_promo.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_pop_up.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_banner_widget.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoPromoTransporterView extends GetView<ZoPromoTransporterController> {
  @override
  Widget build(BuildContext context) {
    // var items = const [
    //   ZoPromoTransporterPopUp(),
    //   ZoPromoTransporterItem(),
    //   ZoPromoTransporterNoPromo(),
    // ];

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          controller.onTooltipClose();
        },
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Color(ListColor.colorBlack).withOpacity(0.15),
            backgroundColor: Color(ListColor.colorWhite),
            automaticallyImplyLeading: false,
            leading: null,
            title: null,
            toolbarHeight: GlobalVariable.ratioFontSize(context) * 60,
            flexibleSpace: Obx(
              () => ZoPromoTransporterAppBar(
                isReadOnly: true,
                onTap: controller.isLoading.isTrue ||
                        controller.isFetching.isTrue ||
                        controller.promoData.isEmpty
                    ? null
                    : controller.onSearchTap,
                isSortActive: controller.sortMapObs.isNotEmpty,
                onSortTap: controller.isLoading.isTrue ||
                        controller.isFetching.isTrue ||
                        controller.promoData.isEmpty
                    ? null
                    : controller.onSortTap,
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(
                () => ZoBannerWidget(
                  items: controller.bannerItems.isNotEmpty
                      ? controller.bannerItems
                          .map(
                            (item) => Builder(
                              builder: (context) => Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    GlobalVariable.ratioWidth(context) * 159,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('$item'),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()
                      : [1].map((e) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: GlobalVariable.ratioWidth(context) * 159,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/background_header_lelang_muatan.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            GlobalVariable.ratioWidth(context) *
                                                20,
                                        right:
                                            GlobalVariable.ratioWidth(context) *
                                                23,
                                      ),
                                      child: Image(
                                        image: AssetImage(
                                          "assets/ic_mobile_header_lelang_muatan.png",
                                        ),
                                        width:
                                            GlobalVariable.ratioWidth(context) *
                                                92,
                                        height:
                                            GlobalVariable.ratioWidth(context) *
                                                91,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right:
                                            GlobalVariable.ratioWidth(context) *
                                                20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            ZoPromoTransporterStrings
                                                .headerTitle.tr,
                                            color: Colors.white,
                                            fontSize: 24,
                                            height: 28.8 / 24,
                                            withoutExtraPadding: true,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      context) *
                                                  9,
                                            ),
                                            child: CustomText(
                                              ZoPromoTransporterStrings
                                                  .headerDescription.tr,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: (16.8 / 14),
                                              withoutExtraPadding: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        }).toList(),
                ),
              ),
              const ZoPromoTransporterListMenu(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, contraints) => Obx(() {
                    var isLoading = controller.isLoading.isTrue;
                    var data = controller.promoData;
                    debugPrint('showPopUp: ${controller.showPopUp.isTrue}');
                    // var showPopUp = controller.showPopUp.isTrue;

                    return SmartRefresher(
                      controller: controller.refreshController,
                      enablePullUp: controller.hasMore.isTrue,
                      enablePullDown: true,
                      onRefresh: controller.onRefreshPullDown,
                      onLoading: controller.onRefreshPullUp,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: isLoading || (data?.isEmpty ?? true)
                            ? 1
                            : data.length +
                                (controller.showPopUp.isTrue ? 1 : 0),
                        padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 2,
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 16,
                        ),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: GlobalVariable.ratioWidth(context) * 16,
                          );
                        },
                        itemBuilder: (context, index) {
                          if (isLoading) {
                            return SizedBox(
                              height: contraints.maxHeight,
                              child: Center(
                                  child: const CircularProgressIndicator()),
                            );
                          } else if (data?.isEmpty ?? true) {
                            if (controller.showPopUp.isTrue) {
                              return const ZoPromoTransporterPopUp();
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(context) * 50,
                              ),
                              child: SizedBox(
                                height: contraints.maxHeight -
                                    (GlobalVariable.ratioWidth(context) *
                                        16 *
                                        2),
                                child: ZoPromoTransporterNoPromo(
                                  isFilter: controller.isFilter.isTrue,
                                  onResetFilterTap: controller.showFilter,
                                ),
                              ),
                            );
                          }
                          if (controller.showPopUp.isTrue) {
                            if (index == 0) {
                              return const ZoPromoTransporterPopUp();
                            } else {
                              return ZoPromoTransporterItem(index: index - 1);
                            }
                          } else {
                            return ZoPromoTransporterItem(index: index);
                          }
                        },
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
