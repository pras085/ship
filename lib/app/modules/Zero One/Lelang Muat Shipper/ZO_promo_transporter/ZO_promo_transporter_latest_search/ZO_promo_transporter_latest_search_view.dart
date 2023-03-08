import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_latest_search/ZO_promo_transporter_latest_search_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_latest_search/ZO_promo_transporter_latest_search_item.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_app_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterLatestSearchView
    extends GetView<ZoPromoTransporterLatestSearchController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Color(ListColor.colorBlack).withOpacity(0.15),
          backgroundColor: Color(ListColor.colorWhite),
          automaticallyImplyLeading: false,
          leading: null,
          title: null,
          toolbarHeight: GlobalVariable.ratioWidth(context) * 60,
          flexibleSpace: Obx(
            () => ZoPromoTransporterAppBar(
              isReadOnly: false,
              text: controller.initialSearch.value,
              onChanged: controller.onSearchChanged,
              onSubmit: controller.onSearchSubmit,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(context) * 16,
                horizontal: GlobalVariable.ratioWidth(context) * 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    ZoPromoTransporterStrings.searchHistoryLatestLabel.tr,
                    fontSize: GlobalVariable.ratioFontSize(context) * 14,
                    height: GlobalVariable.ratioFontSize(context) * 16.8 / 14,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: controller.onDeleteAllTapped,
                    child: CustomText(
                      ZoPromoTransporterStrings.searchHistoryDeleteAll.tr,
                      color: Color(ListColor.colorRed2),
                      fontSize: GlobalVariable.ratioFontSize(context) * 10,
                      height: GlobalVariable.ratioFontSize(context) * 12 / 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(context) * 16,
                  ),
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    return ZoPromoTransporterLatestSearchItem(
                      data: controller.data[index],
                      onTap: () => controller.onTapped(index),
                      onCloseTap: () => controller.onDeleteTapped(index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
