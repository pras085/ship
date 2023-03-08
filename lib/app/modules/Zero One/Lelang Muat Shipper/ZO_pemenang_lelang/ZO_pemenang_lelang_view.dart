import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_app_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_card_item.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_header.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoPemenangLelangView extends GetView<ZoPemenangLelangController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ZoPemenangLelangAppBar(),
      body: Obx(
        () => controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SmartRefresher(
                controller: controller.mainRefreshController,
                onRefresh: () async {
                  await controller.reset();
                  controller.mainRefreshController.refreshCompleted();
                },
                child: ListView.separated(
                  itemCount: controller.bidWinnerList.length + 2,
                  padding: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(context) * 18,
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 14,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ZoPemenangLelangHeader();
                    } else if (index == 1) {
                      return controller.bidWinnerList.length == 0
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(context) * 16,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                  "LelangMuatTabHistoryTabHistoryLabelTitleTotalPesertaLelang"
                                          .tr +
                                      " : "
                                          "${controller.bidWinnerList.length}",
                                  color: Colors.black,
                                  fontSize:
                                      GlobalVariable.ratioFontSize(context) *
                                          12,
                                  fontWeight: FontWeight.w600,
                                  height:
                                      GlobalVariable.ratioFontSize(context) *
                                          (14.4 / 12),
                                ),
                              ),
                            );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.ratioWidth(context) * 16,
                        ),
                        child: ZoPemenangLelangCardItem(index - 2),
                      );
                    }
                  },
                ),
              ),
      ),
    );
  }
}
