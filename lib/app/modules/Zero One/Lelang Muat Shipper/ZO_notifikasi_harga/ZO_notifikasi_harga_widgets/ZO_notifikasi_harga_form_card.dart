import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_edit_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_button.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_form_field.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaFormCard extends StatelessWidget {
  final ZoNotifikasiHargaController controller;
  const ZoNotifikasiHargaFormCard({Key key, @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'ZoNotifikasiHargaFormCard-idEditPage: ${controller.runtimeType}');
    var _controller;
    if (controller is ZoNotifikasiHargaEditController) {
      debugPrint(
          'ZoNotifikasiHargaFormCard-controller: is ZoNotifikasiHargaEditController');
      _controller = controller;
    } else {
      debugPrint(
          'ZoNotifikasiHargaFormCard-controller: is not ZoNotifikasiHargaEditController');
      _controller = controller;
    }
    final fieldSpacer = SizedBox(
      height: GlobalVariable.ratioWidth(context) * 24,
    );
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
                  controller.isEditPage.isTrue
                      ? ZoNotifikasiHargaStrings.editNotificationTitle.tr
                      : ZoNotifikasiHargaStrings.createNotificationTitle.tr,
                  color: Color(ListColor.colorBlack),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: controller.onFormExpansionTapped,
                  child: SvgPicture.asset(
                    controller.showCreateForm.isTrue
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
            if (controller.showCreateForm.isFalse) {
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
                Obx(
                  () => ZoNotifikasiHargaFormField(
                    label: ZoNotifikasiHargaStrings.pickupLabel.tr,
                    value: controller.pickup.value,
                    onTap: controller.onPickupTap,
                  ),
                ),
                fieldSpacer,
                Obx(
                  () => ZoNotifikasiHargaFormField(
                    label: ZoNotifikasiHargaStrings.destinationLabel.tr,
                    value: controller.destination.value,
                    onTap: controller.onDestinationTap,
                  ),
                ),
                fieldSpacer,
                Obx(
                  () => ZoNotifikasiHargaFormField(
                    label: ZoNotifikasiHargaStrings.truckLabel.tr,
                    value: controller.truck.value,
                    onTap: controller.onTruckTap,
                  ),
                ),
                fieldSpacer,
                Obx(
                  () => ZoNotifikasiHargaFormField(
                    label: ZoNotifikasiHargaStrings.carrierLabel.tr,
                    value: controller.carrier.value,
                    onTap: controller.onCarrierTap,
                  ),
                ),
                fieldSpacer,
                Obx(
                  () => ZoNotifikasiHargaFormField(
                    label: ZoNotifikasiHargaStrings.transporterLabel.tr,
                    value: controller.transporter.value,
                    onTap: controller.onTransporterTap,
                  ),
                ),
                fieldSpacer,
                Obx(
                  () => ZoNotifikasiHargaFormField(
                    label: ZoNotifikasiHargaStrings.priceLabel.tr,
                    isDropdown: true,
                    items: [
                      ZoNotifikasiHargaFormFieldItem.fromValue(
                        ZoNotifikasiHargaStrings.dropdownDefaultValue.tr,
                      ),
                      ZoNotifikasiHargaFormFieldItem(
                        value: controller.price.value ==
                                ZoNotifikasiHargaStrings.dropdownDefaultValue.tr
                            ? ZoNotifikasiHargaStrings.dropdownFillPriceValue.tr
                            : controller.price.value,
                        display:
                            ZoNotifikasiHargaStrings.dropdownFillPriceValue.tr,
                        // controller.price.value ==
                        //         ZoNotifikasiHargaStrings
                        //             .dropdownDefaultValue.tr
                        //     ? ZoNotifikasiHargaStrings
                        //         .dropdownFillPriceValue.tr
                        //     : controller.price.value,
                      ),
                    ],
                    value: controller.price.value,
                    onChanged: controller.onPriceChanged,
                  ),
                ),
                fieldSpacer,
                Obx(
                  () => ZoNotifikasiHargaFormField(
                    label: ZoNotifikasiHargaStrings.notificationTypeLabel.tr,
                    isDropdown: true,
                    items: [
                      ZoNotifikasiHargaFormFieldItem.fromValue(
                        ZoNotifikasiHargaStrings.dropdownDefaultValue.tr,
                      ),
                      ZoNotifikasiHargaFormFieldItem.fromValue(
                        ZoNotifikasiHargaStrings.dropdownNotificationEmail.tr,
                      ),
                      ZoNotifikasiHargaFormFieldItem.fromValue(
                        ZoNotifikasiHargaStrings
                            .dropdownNotificationWhatsapp.tr,
                      ),
                      ZoNotifikasiHargaFormFieldItem.fromValue(
                        ZoNotifikasiHargaStrings.dropdownNotificationSystem.tr,
                      ),
                    ],
                    value: controller.notificationType.value,
                    onChanged: controller.onNotificationTypeChanged,
                  ),
                ),
                fieldSpacer,
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Obx(() {
                    final enabled = (controller.pickup?.value?.isNotEmpty ??
                            false) &&
                        (controller.destination?.value?.isNotEmpty ?? false);
                    final isLoading = controller.isSaving.isTrue ||
                        controller.isUpdating.isTrue;

                    return ZoNotifikasiHargaButton(
                      isLoading: isLoading,
                      label: ZoNotifikasiHargaStrings.saveLabel.tr,
                      onPressed: enabled ? controller.onSaveNotification : null,
                      backgroundColor: Color(ListColor.colorBlue),
                      disabledBackgroundColor: Color(ListColor.colorLightGrey2),
                      foregroundColor: Color(ListColor.colorWhite),
                      disabledForegroundColor: Color(ListColor.colorWhite),
                    );
                  }),
                ]),
              ],
            );
          }),
        ],
      ),
    );
  }
}
