import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_promo_transporter_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_detail_widgets/ZO_promo_transporter_detail_app_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_detail_widgets/ZO_promo_transporter_detail_condition_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_detail_widgets/ZO_promo_transporter_detail_location_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_detail_widgets/ZO_promo_transporter_detail_price_card.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterDetailView
    extends GetView<ZoPromoTransporterController> {
  final ZoPromoTransporterDataModel data;

  const ZoPromoTransporterDetailView({Key key, @required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.onDetailTooltipClose();
        return true;
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            controller.onDetailTooltipClose();
          },
          child: Scaffold(
            appBar: AppBar(
              shadowColor: Color(ListColor.colorBlack).withOpacity(0.15),
              backgroundColor: Color(ListColor.colorBlue),
              automaticallyImplyLeading: false,
              leading: null,
              title: null,
              toolbarHeight: GlobalVariable.ratioFontSize(context) * 60,
              flexibleSpace: ZoPromoTransporterDetailAppBar(),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(context) * 18,
                vertical: GlobalVariable.ratioWidth(context) * 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ZoPromoTransporterDetailLocationCard(data: data.key),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 24),
                  ZoPromoTransporterDetailPriceCard(data: data.detail),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 24),
                  Obx(
                    () => ZoPromoTransporterDetailConditionCard(
                      data: controller.promoConditionDetail.value,
                      isLoading:
                          controller.isLoadingPromoConditionDetail.isTrue,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _CallTransporterBottomNavBar(
              transporterId: data.key.transporterId ?? data.key.TransporterID,
            ),
          ),
        ),
      ),
    );
  }
}

class _CallTransporterBottomNavBar
    extends GetView<ZoPromoTransporterController> {
  final int transporterId;

  const _CallTransporterBottomNavBar({
    Key key,
    @required this.transporterId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
        vertical: GlobalVariable.ratioWidth(context) * 12,
      ),
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhite),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(ListColor.colorBlack).withOpacity(0.161),
            offset: Offset(0, -3),
            blurRadius: 55,
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: _CallTransporterButton(
          onPressed: () {
            int id = transporterId;
            controller.showContactBottomSheet(id);
          },
          isLoading: false,
          label: ZoPromoTransporterStrings.detailCallTransporter.tr,
          backgroundColor: Color(ListColor.colorBlue),
          disabledBackgroundColor: Color(ListColor.colorLightGrey2),
          foregroundColor: Color(ListColor.colorWhite),
          disabledForegroundColor: Color(ListColor.colorWhite),
        ),
      ),
    );
  }
}

class _CallTransporterButton extends StatelessWidget {
  final bool isLoading;
  final void Function() onPressed;
  final String label;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color disabledForegroundColor;
  final Color disabledBackgroundColor;

  const _CallTransporterButton({
    Key key,
    this.isLoading = false,
    this.onPressed,
    this.label,
    this.foregroundColor,
    this.backgroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool enabled = !isLoading && onPressed != null;
    return Material(
      color: enabled ? backgroundColor : disabledBackgroundColor,
      borderRadius: BorderRadius.circular(66),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(66),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 24,
            vertical: GlobalVariable.ratioWidth(context) * 13,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) ...[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(disabledForegroundColor),
                ),
                SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
              ],
              CustomText(
                label ?? 'OK',
                textAlign: TextAlign.center,
                color: enabled ? foregroundColor : disabledForegroundColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: (16.8 / 14),
                withoutExtraPadding: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
