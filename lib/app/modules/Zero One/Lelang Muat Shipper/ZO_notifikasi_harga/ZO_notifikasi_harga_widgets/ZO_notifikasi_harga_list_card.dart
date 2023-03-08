import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_button.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_list_field.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaListCard extends GetView<ZoNotifikasiHargaController> {
  const ZoNotifikasiHargaListCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhite),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 12,
            spreadRadius: 0,
            color: Color(ListColor.colorBlack).withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomText(
                  ZoNotifikasiHargaStrings.listNotificationTitle.tr,
                  color: Color(ListColor.colorBlack),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: controller.onListExpansionTapped,
                  child: SvgPicture.asset(
                    controller.showList.isTrue
                        ? 'assets/ic_dropdown_blue_up.svg'
                        : 'assets/ic_dropdown_blue_down.svg',
                    height: GlobalVariable.ratioFontSize(context) * 18,
                    width: GlobalVariable.ratioFontSize(context) * 18,
                  ),
                ),
              ),
            ],
          ),
          Obx(() {
            if (controller.showList.isFalse) {
              return SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 12,
                ),
                Divider(
                  color: Color(ListColor.colorGrey3),
                  height: 1,
                  thickness: 1,
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 14,
                ),
                if (controller.isListLoading.isTrue)
                  Center(child: CircularProgressIndicator())
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.notifications.length,
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(context) * 12,
                        ),
                        child: Divider(
                          color: Color(ListColor.colorGrey3),
                          height: 1,
                          thickness: 1,
                        ),
                      );
                    },
                    itemBuilder: _itemBuilder,
                  ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 14,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _itemBuilder(context, index) {
    final fieldSpacer = SizedBox(
      height: GlobalVariable.ratioWidth(context) * 24,
    );
    // final notification = controller.notifications[index];

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        flex: 1,
        child: CustomText(
          '${index + 1}. ',
          color: Color(ListColor.colorGrey3),
          textAlign: TextAlign.end,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      Expanded(
        flex: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => ZoNotifikasiHargaListField(
                label: ZoNotifikasiHargaStrings.pickupDestinationLabel.tr,
                value:
                    '${controller.notifications[index].pickup} - ${controller.notifications[index].destination}',
              ),
            ),
            fieldSpacer,
            Obx(
              () => ZoNotifikasiHargaListField(
                label: ZoNotifikasiHargaStrings.truckCarrierLabel.tr,
                value:
                    '${controller.notifications[index].headName} - ${controller.notifications[index].carrierName}',
              ),
            ),
            fieldSpacer,
            Obx(
              () => ZoNotifikasiHargaListField(
                label: ZoNotifikasiHargaStrings.transporterLabel.tr,
                value: controller.notifications[index].transporterName,
              ),
            ),
            fieldSpacer,
            Obx(
              () => ZoNotifikasiHargaListField(
                label: ZoNotifikasiHargaStrings.priceLabel.tr,
                value: (controller.notifications[index]?.minPrice ?? 0) == 0 &&
                        (controller.notifications[index]?.maxPrice ?? 0) == 0
                    ? ZoNotifikasiHargaStrings.dropdownDefaultValue.tr
                    : controller.getPriceString(
                        controller.notifications[index]?.minPrice,
                        controller.notifications[index]?.maxPrice,
                      ),
              ),
            ),
            fieldSpacer,
            Obx(() {
              var notificationType =
                  controller.notifications[index].notificationType;
              var value = '$notificationType';
              if (notificationType?.trim()?.toLowerCase() ==
                  ZoNotifikasiHargaStrings.dropdownDefaultValue.tr
                      .trim()
                      .toLowerCase()) {
                value = ZoNotifikasiHargaStrings
                    .notificationTypeDefaultValueDisplay.tr;
              }

              return ZoNotifikasiHargaListField(
                label: ZoNotifikasiHargaStrings.notificationTypeLabel.tr,
                value: value,
              );
            }),
            fieldSpacer,
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Obx(
                () => ZoNotifikasiHargaButton(
                  onPressed: controller.isDeleting.isTrue ||
                          controller.isUpdating.isTrue
                      ? null
                      : () => controller.onDeleteNotification(
                            index,
                            controller.notifications[index].id,
                          ),
                  isLoading: controller.isDeleting.isTrue &&
                      controller.deletingIndex.value == index,
                  label: ZoNotifikasiHargaStrings.deleteLabel.tr,
                  backgroundColor: Color(ListColor.colorRed),
                  disabledBackgroundColor: Color(ListColor.colorLightGrey2),
                  foregroundColor: Color(ListColor.colorWhite),
                  disabledForegroundColor: Color(ListColor.colorWhite),
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
              Obx(
                () => ZoNotifikasiHargaButton(
                  onPressed: controller.isDeleting.isTrue ||
                          controller.isUpdating.isTrue
                      ? null
                      : () => controller.onEditNotification(
                            index,
                            controller.notifications[index].id,
                          ),
                  isLoading: controller.isUpdating.isTrue &&
                      controller.updatingIndex.value == index,
                  label: ZoNotifikasiHargaStrings.editLabel.tr,
                  backgroundColor: Color(ListColor.colorBlue),
                  disabledBackgroundColor: Color(ListColor.colorLightGrey2),
                  foregroundColor: Color(ListColor.colorWhite),
                  disabledForegroundColor: Color(ListColor.colorWhite),
                ),
              ),
            ]),
          ],
        ),
      ),
    ]);
  }
}
