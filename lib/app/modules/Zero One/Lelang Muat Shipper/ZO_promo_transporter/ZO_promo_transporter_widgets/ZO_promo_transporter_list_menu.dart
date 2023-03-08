import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterListMenu extends GetView<ZoPromoTransporterController> {
  const ZoPromoTransporterListMenu({Key key}) : super(key: key);
  Widget _buildFilterWidget(VoidCallback onTap, {bool isActive = false}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorLightGrey).withOpacity(0.3),
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
        color: Color(
          onTap != null && isActive
              ? ListColor.colorLightBlue1
              : ListColor.colorWhite,
        ),
        borderRadius: BorderRadius.circular(
          GlobalVariable.ratioFontSize(Get.context) * 12,
        ),
        border: Border.all(
            color: Color(
          onTap == null
              ? ListColor.colorLightGrey2
              : isActive
                  ? ListColor.colorBlue
                  : ListColor.colorLightGrey7,
        )),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(
          GlobalVariable.ratioFontSize(Get.context) * 12,
        ),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioFontSize(Get.context) * 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioFontSize(Get.context) * 3,
                  ),
                  child: CustomText(
                    ZoPromoTransporterStrings.filterLabel.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(
                      onTap == null
                          ? ListColor.colorLightGrey2
                          : isActive
                              ? ListColor.colorBlue
                              : ListColor.colorDarkBlue2,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 5),
                    SvgPicture.asset(
                      "assets/filter_icon.svg",
                      height: GlobalVariable.ratioFontSize(Get.context) * 14,
                      color: Color(
                        onTap == null
                            ? ListColor.colorLightGrey2
                            : ListColor.colorBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoWidget() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Obx(
          () => InkWell(
            onTap: controller.showPopUp.isTrue || controller.isLoading.isTrue
                ? null
                : controller.onInfoTap,
            child: Container(
              child: SvgPicture.asset(
                controller.showPopUp.isTrue || controller.isLoading.isTrue
                    ? "assets/info_disable.svg"
                    : "assets/info_active.svg",
                width: GlobalVariable.ratioFontSize(Get.context) * 24,
                height: GlobalVariable.ratioFontSize(Get.context) * 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationSettingWidget() {
    return Material(
      color: Color(ListColor.colorBlue),
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: InkWell(
        onTap: () {
          controller.onTooltipClose();
          controller.onDetailTooltipClose();
          GetToPage.toNamed<ZoNotifikasiHargaController>(
            Routes.ZO_NOTIFIKASI_HARGA,
            preventDuplicates: false,
            arguments: [""],
          );
        },
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioFontSize(Get.context) * 12,
            vertical: GlobalVariable.ratioFontSize(Get.context) * 3,
          ),
          decoration: BoxDecoration(
            // color: Color(ListColor.colorBlue),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
          ),
          child: Row(
            children: [
              CustomText(
                ZoPromoTransporterStrings.notificationSettings.tr,
                color: Color(ListColor.colorWhite),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: GlobalVariable.ratioFontSize(Get.context) * 8),
              SvgPicture.asset(
                'assets/ic_bell_with_sound.svg',
                width: GlobalVariable.ratioFontSize(Get.context) * 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 14,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => _buildFilterWidget(
                  controller.isFetching.isTrue ||
                          (controller.promoData.isEmpty &&
                              controller.isFilter.isFalse)
                      ? null
                      : () {
                          controller.onTooltipClose();
                          controller.onDetailTooltipClose();
                          controller.showFilter();
                        },
                  isActive: controller.isFilter.isTrue,
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
              _buildInfoWidget(),
            ],
          ),
          _buildNotificationSettingWidget(),
        ],
      ),
    );
  }
}
