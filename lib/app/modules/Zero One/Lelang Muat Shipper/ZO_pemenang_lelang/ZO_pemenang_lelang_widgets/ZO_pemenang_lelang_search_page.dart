import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_card_item.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_search_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoPemenangLelangSearchView extends GetView<ZoPemenangLelangController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.reset();
        controller.searchRefreshController.refreshCompleted();
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Color(ListColor.colorBlack).withOpacity(0.15),
            backgroundColor: Color(ListColor.colorWhite),
            automaticallyImplyLeading: false,
            leading: null,
            title: null,
            toolbarHeight: GlobalVariable.ratioWidth(context) * 60,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(context) * 19,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(context) * 12,
                    ),
                    child: ZoPemenangLelangSearchBar(isSearchActive: true),
                  ),
                ],
              ),
            ),
          ),
          body: Obx(
            () => controller.isSearching.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SmartRefresher(
                    controller: controller.searchRefreshController,
                    onRefresh: () async {
                      await controller.reset(maintainQuery: true);
                      controller.searchRefreshController.refreshCompleted();
                    },
                    child: controller.searchQueryObs.isEmpty
                        ? const SizedBox.shrink()
                        : controller.bidWinnerList.length == 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                      height:
                                          GlobalVariable.ratioWidth(context) *
                                              20),
                                  _buildResultTextWidget(context),
                                  Expanded(
                                    child: Center(
                                      child:
                                          _buildResultNotFoundWidget(context),
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                itemCount: controller.bidWinnerList.length + 1,
                                padding: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(context) * 20,
                                  bottom:
                                      GlobalVariable.ratioWidth(context) * 18,
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(context) * 14,
                                ),
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return _buildResultTextWidget(context);
                                  } else {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            GlobalVariable.ratioWidth(context) *
                                                16,
                                      ),
                                      child:
                                          ZoPemenangLelangCardItem(index - 1),
                                    );
                                  }
                                },
                              ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultTextWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(context) * 16,
        right: GlobalVariable.ratioWidth(context) * 16,
      ),
      child: Obx(
        () => RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(context) * 12,
              height: GlobalVariable.ratioFontSize(context) * 14.4 / 12,
            ),
            children: [
              TextSpan(
                style: TextStyle(
                  color: Color(ListColor.colorDarkBlue2),
                  fontWeight: FontWeight.w500,
                ),
                text: controller.searchQueryObs.isEmpty ||
                        controller.bidWinnerList.length == 0
                    ? "LelangMuatPesertaLelangPesertaLelangLabelTitleNoHasilCari"
                            .tr +
                        " "
                    : "LelangMuatPesertaLelangPesertaLelangLabelTitleMenampilkan"
                            .tr +
                        " ${controller.bidWinnerList.length} " +
                        "LelangMuatPesertaLelangPesertaLelangLabelTitleHasilUntuk"
                            .tr,
              ),
              TextSpan(
                style: TextStyle(
                  color: Color(ListColor.colorBlack),
                  fontWeight: FontWeight.w600,
                ),
                text: '"${controller.searchQueryObs.value}"',
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
          "LocationManagementLabelNoKeywordFoundFilter"
              .tr
              .replaceAll("\\n", "\n"),
          textAlign: TextAlign.center,
          color: Color(ListColor.colorLightGrey14),
          fontWeight: FontWeight.w600,
          fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
          height: 1.2,
        ))
      ],
    );
  }
}
