import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_latest_search/ZO_promo_transporter_latest_search_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_latest_search/ZO_promo_transporter_latest_search_item.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_app_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_item_widgets/ZO_promo_transporter_item.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoPromoTransporterSearchView
    extends GetView<ZoPromoTransporterController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.showLatest.isTrue) {
          controller.showLatest.value = false;
          // controller.searchQueryObs.value = controller.tempSearchQueryObs.value;
          // controller.tempSearchQueryObs.value = controller.searchQueryObs.value;
          FocusManager.instance.primaryFocus.unfocus();
          return false;
        } else {
          controller.searchQueryObs.value = '';
          controller.tempSearchQueryObs.value = controller.searchQueryObs.value;
          controller.sortMapObs.clear();
          controller.loadPromo();
          return true;
        }
      },
      child: SafeArea(
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
                isReadOnly: false,
                text: controller.tempSearchQueryObs.value,
                onTap: controller.onLatestSearchTap,
                onBackTap: () async {
                  controller.searchQueryObs.value = '';
                  controller.sortMapObs.clear();
                  controller.loadPromo();
                  Get.back();
                },
                onSubmit: controller.onSearchSubmit,
                onChanged: controller.onSearchChanged,
                // () {
                //   Get.toNamed(Routes.ZO_PROMO_TRANSPORTER_LATEST_SEARCH).then(
                //     (value) {
                //       if (value != null) {
                //         controller.searchQueryObs.value = value.trim();
                //         controller.loadPromo();
                //       }
                //     },
                //   );
                //   // Navigator.pushReplacementNamed(
                //   //   context,
                //   //   Routes.ZO_PROMO_TRANSPORTER_LATEST_SEARCH,
                //   //   arguments: controller.searchQueryObs.value,
                //   // );
                // },
                // onChanged: controller.onSearchChanged,
                isSortActive: controller.sortMapObs.isNotEmpty,
                onSortTap: controller.isFetching.isTrue ||
                        controller.searchQueryObs.trim().isEmpty ||
                        controller.promoData.isEmpty ||
                        controller.showLatest.isTrue
                    ? null
                    : controller.onSortTap,
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
              Obx(
                () => controller.searchQueryObs.trim().isNotEmpty &&
                        controller.showLatest.isFalse
                    ? _buildResultTextWidget(context)
                    : Padding(
                        padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 4,
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              ZoPromoTransporterStrings
                                  .searchHistoryLatestLabel.tr,
                              fontSize: 14,
                              height: 16.8 / 14,
                              withoutExtraPadding: true,
                              fontWeight: FontWeight.w600,
                            ),
                            GestureDetector(
                              onTap: Get.find<ZoPromoTransporterController>()
                                  .onDeleteAllTapped,
                              child: CustomText(
                                ZoPromoTransporterStrings
                                    .searchHistoryDeleteAll.tr,
                                color: Color(ListColor.colorRed2),
                                fontSize: 10,
                                height: 12 / 10,
                                withoutExtraPadding: true,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              Obx(
                () => SizedBox(
                  height: GlobalVariable.ratioWidth(context) *
                      (controller.searchQueryObs.trim().isEmpty ||
                              controller.showLatest.isTrue
                          ? 0
                          : 16),
                ),
              ),
              Obx(
                () => controller.searchQueryObs.trim().isEmpty ||
                        controller.showLatest.isTrue
                    ? Expanded(
                        child: GetX<ZoPromoTransporterController>(
                            builder: (latestController) {
                          return ListView.builder(
                            itemCount: latestController.data.length,
                            itemBuilder: (context, index) {
                              return ZoPromoTransporterLatestSearchItem(
                                data: latestController.data[index],
                                onTap: () => latestController.onTapped(
                                  index,
                                  // isLatestSearchPage: false,
                                ),
                                onCloseTap: () =>
                                    latestController.onDeleteTapped(index),
                              );
                            },
                          );
                        }),
                      )
                    : Expanded(
                        child: LayoutBuilder(
                          builder: (context, contraints) => Obx(() {
                            // var isLoading = controller.isSearchLoading.isTrue;
                            var isLoading = controller.isLoading.isTrue;
                            var data = controller.promoData;

                            if (controller.searchQueryObs.isEmpty) {
                              data = RxList([]);
                            }

                            return SmartRefresher(
                              controller: controller.searchRefreshController,
                              enablePullUp: controller.hasMore.isTrue,
                              enablePullDown: true,
                              onRefresh: controller.onSearchRefreshPullDown,
                              onLoading: controller.onSearchRefreshPullUp,
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: isLoading || (data?.isEmpty ?? true)
                                    ? 1
                                    : data.length,
                                padding: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(context) * 16,
                                  GlobalVariable.ratioWidth(context) * 0,
                                  GlobalVariable.ratioWidth(context) * 16,
                                  GlobalVariable.ratioWidth(context) * 16,
                                ),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(context) * 16,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  if (isLoading) {
                                    return SizedBox(
                                      height: contraints.maxHeight,
                                      child: Center(
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    );
                                  } else if (data?.isEmpty ?? true) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            GlobalVariable.ratioWidth(context) *
                                                56,
                                      ),
                                      child: SizedBox(
                                        height: contraints.maxHeight -
                                            (GlobalVariable.ratioWidth(
                                                    context) *
                                                16 *
                                                2),
                                        child: Center(
                                          child: _buildResultNotFoundWidget(
                                              context),
                                        ),
                                      ),
                                    );
                                  }
                                  return ZoPromoTransporterItem(index: index);
                                },
                              ),
                            );
                          }),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultNotFoundWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: SvgPicture.asset(
          "assets/ic_management_lokasi_no_search.svg",
          width: GlobalVariable.ratioWidth(Get.context) * 82.3,
          height: GlobalVariable.ratioWidth(Get.context) * 75,
        )),
        Container(
          height: 12,
        ),
        Container(
            child: CustomText(
          ZoPromoTransporterStrings.searchNoResultCaption.tr
              .replaceAll("\\n", "\n"),
          textAlign: TextAlign.center,
          color: Color(ListColor.colorLightGrey14),
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 16.8 / 14,
        ))
      ],
    );
  }

  Widget _buildResultTextWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
      ),
      child: Obx(
        () => RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(context) * 12,
              height: GlobalVariable.ratioFontSize(context) * 14.4 / 12,
              fontFamily: 'AvenirNext',
            ),
            children: [
              TextSpan(
                style: TextStyle(
                  color: Color(ListColor.colorDarkBlue2),
                  fontWeight: FontWeight.w500,
                ),
                text: controller.isLoading.isTrue
                    ? ZoPromoTransporterStrings.searchLoadingLabel.tr
                    : controller.searchQueryObs.isEmpty ||
                            controller.promoData.length == 0
                        ? ZoPromoTransporterStrings.searchNoResultLabel.tr
                        : ZoPromoTransporterStrings.searchShowingLabel.tr +
                            " ${controller.promoData.length} " +
                            ZoPromoTransporterStrings.searchResultForLabel.tr,
              ),
              TextSpan(
                style: TextStyle(
                  color: Color(ListColor.colorBlack),
                  fontWeight: FontWeight.w600,
                ),
                text: ' "${controller.searchQueryObs.value}"',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
