import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPemenangLelangHeader extends GetView<ZoPemenangLelangController> {
  ZoPemenangLelangHeader();

  Widget _buildRow(BuildContext context, String asset, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: GlobalVariable.ratioFontSize(context) * 16,
          width: GlobalVariable.ratioFontSize(context) * 16,
          child: Center(
            child: asset.toLowerCase().contains('svg')
                ? SvgPicture.asset(
                    asset,
                    color: Color(ListColor.colorBlue),
                    width: GlobalVariable.ratioFontSize(context) * 16,
                  )
                : Image.asset(
                    asset,
                    color: Color(ListColor.colorBlue),
                    width: GlobalVariable.ratioFontSize(context) * 16,
                  ),
          ),
        ),
        SizedBox(width: GlobalVariable.ratioWidth(context) * 10),
        Expanded(
          child: CustomText(
            text ?? '',
            fontWeight: FontWeight.w600,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ListColor.colorBlue),
      padding: EdgeInsets.only(
        left: GlobalVariable.ratioWidth(context) * 19,
        right: GlobalVariable.ratioWidth(context) * 19,
        bottom: GlobalVariable.ratioWidth(context) * 14,
      ),
      child: Container(
        padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
        decoration: BoxDecoration(
          color: Color(ListColor.colorWhite),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _DestinationWidget(),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
            Obx(
              () => _buildRow(
                context,
                "assets/ic_calendar.svg",
                // "24 Okt 2022 11.00 WIB",
                controller.bidInformation.value.created,
              ),
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
            Obx(
              () => _buildRow(
                context,
                "assets/ic_timer_pasir.svg",
                // "24 Okt 2022 - 27 Okt 2022",
                "${controller.bidInformation.value.startDate} - "
                    "${controller.bidInformation.value.endDate}",
              ),
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
            Obx(
              () => _buildRow(
                context,
                "assets/truck_plus.svg",
                // "23 Medium semi trailer 4x2 - Flatbed",
                "${controller.bidInformation.value.truckQty} "
                    "${controller.bidInformation.value.headName} - "
                    "${controller.bidInformation.value.carrierName}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationWidget extends GetView<ZoPemenangLelangController> {
  const _DestinationWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: GlobalVariable.ratioFontSize(context) * 16,
              height: GlobalVariable.ratioFontSize(context) * 16,
              child: Center(
                child: SvgPicture.asset(
                  "assets/titik_biru_pickup.svg",
                  width: GlobalVariable.ratioFontSize(context) * 16,
                  height: GlobalVariable.ratioFontSize(context) * 16,
                ),
              ),
            ),
            SizedBox(width: GlobalVariable.ratioWidth(context) * 10),
            Container(
              child: Obx(
                () => CustomText(
                  controller.bidInformation.value.cityPickup ?? '',
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: GlobalVariable.ratioFontSize(context) * 16,
          height: GlobalVariable.ratioFontSize(context) * 31,
          child: Center(
            child: SvgPicture.asset(
              "assets/garis_alur_perjalanan.svg",
              height: GlobalVariable.ratioFontSize(context) * 31,
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: GlobalVariable.ratioFontSize(context) * 16,
              height: GlobalVariable.ratioFontSize(context) * 16,
              child: Center(
                child: SvgPicture.asset(
                  "assets/titik_biru_kuning_destinasi.svg",
                  width: GlobalVariable.ratioFontSize(context) * 16,
                  height: GlobalVariable.ratioFontSize(context) * 16,
                ),
              ),
            ),
            SizedBox(width: GlobalVariable.ratioWidth(context) * 10),
            Container(
              child: Obx(
                () => CustomText(
                  controller.bidInformation.value.cityDestination ?? '',
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
