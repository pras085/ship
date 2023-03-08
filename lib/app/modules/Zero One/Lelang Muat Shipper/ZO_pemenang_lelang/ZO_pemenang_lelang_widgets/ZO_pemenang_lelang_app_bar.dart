import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_search_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPemenangLelangAppBar extends GetView<ZoPemenangLelangController>
    with PreferredSizeWidget {
  const ZoPemenangLelangAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ListColor.colorBlue),
      child: AppBar(
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: null,
        title: null,
        flexibleSpace: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              child: Positioned(
                top: MediaQuery.of(Get.context).padding.top,
                right: 0,
                child: Image(
                  image: AssetImage("assets/fallin_star_3_icon.png"),
                  height: GlobalVariable.ratioFontSize(context) * 75,
                  width: GlobalVariable.ratioFontSize(context) * 154,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
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
                      child: ZoPemenangLelangSearchBar(isSearchActive: false),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(context) * 14,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorWhite),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.ratioWidth(context) * 16,
                          vertical: GlobalVariable.ratioWidth(context) * 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                "LelangMuatTabHistoryTabHistoryLabelTitlePesertaLelang"
                                    .tr,
                                color: Color(ListColor.colorLightGrey4),
                                fontSize:
                                    GlobalVariable.ratioFontSize(context) * 14,
                                fontWeight: FontWeight.w700,
                                height: GlobalVariable.ratioFontSize(context) *
                                    (16.8 / 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Obx(
                              () => controller.isLoading.isTrue
                                  ? SizedBox(
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          18,
                                      width: GlobalVariable.ratioFontSize(
                                              context) *
                                          18,
                                      child: const CircularProgressIndicator(),
                                    )
                                  : CustomText(
                                      // "LM-22-00074",
                                      controller.bidInformation.value.bidNo ??
                                          '',
                                      color: Color(ListColor.colorBlue),
                                      fontSize: GlobalVariable.ratioFontSize(
                                              context) *
                                          14,
                                      fontWeight: FontWeight.w700,
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          (16.8 / 14),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 110 +
          MediaQuery.of(Get.context).padding.top);
}
