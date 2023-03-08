import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_vertical_dash.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_promo_transporter_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_tooltip.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterItemBody extends GetView<ZoPromoTransporterController> {
  // final String imageLink;
  final int index;

  const ZoPromoTransporterItemBody({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(ListColor.colorWhite),
          padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 14),
          child: Obx(
            () => controller.promoData.isEmpty
                ? SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ImageWidget(
                        source: controller.promoData[index].key.link,
                      ),
                      // SizedBox(height: GlobalVariable.ratioWidth(context) * 100),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 14),
                      GestureDetector(
                        onTap: () => debugPrint('Location Tapped'),
                        onTapDown: (details) =>
                            controller.onLocationTap(index, details),
                        child: Container(
                          color: Colors.transparent,
                          child: _PickupDestinationWidget(
                            from: controller.promoData[index].key.pickupCity,
                            to: controller.promoData[index].key.destinationCity,
                          ),
                        ),
                      ),
                      _PriceListWidget(
                        onExpandChange: (_) {
                          controller.onTooltipClose();
                          controller.onDetailTooltipClose();
                        },
                        // showPeriodeTooltip: controller.shouldShowPeriodeToolip(index),
                        onPeriodeTapDown: (details) =>
                            controller.onPeriodeTap(index, details),
                        list: controller.promoData[index].detail
                            .map(
                              (e) => _PriceListItem(
                                info: controller.promoData[index].key.payment,
                                initialPrice: int.tryParse(
                                    e.normalPrice.replaceAll('.', '')),
                                currentPrice: int.tryParse(
                                    e.promoPrice.replaceAll('.', '')),
                                isPerUnit: true,
                                title: e.title,
                              ),
                            )
                            .toList(),
                        startDate:
                            controller.promoData[index].key.startDateTime,
                        startDateString:
                            controller.promoData[index].key.startDate,
                        startDateRaw:
                            controller.promoData[index].key.startDateRaw,
                        endDate: controller.promoData[index].key.endDateTime,
                        endDateString: controller.promoData[index].key.endDate,
                        endDateRaw: controller.promoData[index].key.endDateRaw,
                      ),
                    ],
                  ),
          ),
        ),
        Obx(
          () => controller.shouldShowLocationTooltip(index)
              ? Positioned(
                  left: GlobalVariable.ratioWidth(context) * 16,
                  top: context.width / 2 -
                      GlobalVariable.ratioFontSize(context) * 60,
                  child: ZoPromoTransporterTooltip(
                    message: ZoPromoTransporterStrings.tooltipLocation.tr,
                    onTap: controller.onTooltipClose,
                  ),
                )
              : SizedBox.shrink(),
        ),
        Obx(
          () => controller.shouldShowPeriodeTooltip(index)
              ? Positioned(
                  left: GlobalVariable.ratioWidth(context) * 16,
                  bottom: GlobalVariable.ratioWidth(context) * 36,
                  child: ZoPromoTransporterTooltip(
                    message: ZoPromoTransporterStrings.tooltipPeriode.tr,
                    onTap: controller.onTooltipClose,
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _PriceListItem {
  final String title;
  final int initialPrice;
  final int currentPrice;
  final String info;
  final bool isPerUnit;

  const _PriceListItem({
    this.title,
    this.initialPrice,
    this.currentPrice,
    this.info,
    this.isPerUnit = true,
  });
}

class _PriceListWidget extends StatefulWidget {
  // final bool showPeriodeTooltip;
  // final void Function() onTooltipClose;
  final void Function(TapDownDetails details) onPeriodeTapDown;
  final bool initiallyExpanded;
  final List<_PriceListItem> list;
  final DateTime startDate;
  final String startDateRaw;
  final String startDateString;
  final DateTime endDate;
  final String endDateRaw;
  final String endDateString;
  final void Function(bool) onExpandChange;

  const _PriceListWidget({
    Key key,
    // this.showPeriodeTooltip,
    // this.onTooltipClose,
    this.onExpandChange,
    this.onPeriodeTapDown,
    this.initiallyExpanded = false,
    this.list = const [],
    this.startDate,
    this.startDateRaw,
    this.startDateString,
    this.endDate,
    this.endDateRaw,
    this.endDateString,
  }) : super(key: key);
  @override
  __PriceListWidgetState createState() => __PriceListWidgetState();
}

class __PriceListWidgetState extends State<_PriceListWidget> {
  bool expanded;
  List<_PriceListItem> sorted;

  @override
  void initState() {
    expanded = widget.initiallyExpanded;
    sorted = widget.list;
    // sorted.sort((a, b) {
    //   if (a.currentPrice == null) return 1;
    //   if (b.currentPrice == null) return -1;
    //   return a.currentPrice.compareTo(b.currentPrice);
    // });
    super.initState();
  }

  List<Widget> _buildRowChildren(
    String asset,
    String text,
    FontWeight fontWeight, {
    void Function(TapDownDetails details) onTapDown,
  }) {
    return [
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
      SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
      Expanded(
        child: GestureDetector(
          onTap: () => debugPrint('$text Tapped'),
          onTapDown: onTapDown,
          child: CustomText(
            (text?.isEmpty ?? true) ? '-' : text,
            fontWeight: fontWeight,
            fontSize: 12,
            height: (14.4 / 12),
            withoutExtraPadding: true,
            color: Color(ListColor.colorBlack),
          ),
        ),
      ),
    ];
  }

  final formatter = DateFormat('dd MMM yyyy');

  String formatCurrency(int number) {
    if (number == null) return null;
    return "Rp ${NumberFormat('#,###').format(number).replaceAll(',', '.')}";
  }

  final separator = Divider(
    color: Color(ListColor.colorGrey3),
    height: 0,
    thickness: 1,
  );

  @override
  Widget build(BuildContext context) {
    var formattedStart =
        widget.startDate == null ? null : formatter.format(widget.startDate);
    var formattedEnd =
        widget.endDate == null ? null : formatter.format(widget.endDate);
    var length = sorted?.length ?? 0;
    var itemCount = expanded ? length : min(1, length);
    var start = formattedStart == null
        ? (widget.startDateString?.isEmpty ?? true)
            ? (widget.startDateRaw?.isEmpty ?? true)
                ? 'N/A'
                : widget.startDateRaw.trim()
            : widget.startDateString.trim()
        : formattedStart;
    var end = formattedEnd == null
        ? (widget.endDateString?.isEmpty ?? true)
            ? (widget.endDateRaw?.isEmpty ?? true)
                ? 'N/A'
                : widget.endDateRaw.trim()
            : widget.endDateString.trim()
        : formattedEnd;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          shrinkWrap: true,
          separatorBuilder: (context, index) => separator,
          itemBuilder: (context, index) {
            var datum = sorted[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(context) * 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    datum.title ?? "N/A",
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: (16.8 / 14),
                    withoutExtraPadding: true,
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                  if (datum.initialPrice != null &&
                      datum.currentPrice != null &&
                      datum.initialPrice != datum.currentPrice &&
                      datum.initialPrice > 0)
                    CustomText(
                      formatCurrency(datum.initialPrice) ?? "N/A",
                      color: Color(ListColor.colorGrey3),
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: (16.8 / 14),
                      withoutExtraPadding: true,
                    ),
                  Row(
                    children: [
                      CustomText(
                        formatCurrency(datum.currentPrice) ?? "N/A",
                        color: Color(ListColor.colorRed),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: (21.6 / 18),
                        withoutExtraPadding: true,
                      ),
                      if (datum?.isPerUnit ?? false) ...[
                        CustomText(
                          " /" + ZoPromoTransporterStrings.unit.tr,
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: (19.2 / 16),
                          withoutExtraPadding: true,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    ..._buildRowChildren(
                      "assets/ic_duit_blue.svg",
                      datum.info ?? '-',
                      FontWeight.w600,
                    ),
                  ]),
                ],
              ),
            );
          },
        ),
        if (expanded) ...[
          separator,
          SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ..._buildRowChildren(
              "assets/ic_timer_pasir.svg",
              "$start - $end",
              FontWeight.w500,
              onTapDown: widget.onPeriodeTapDown,
            ),
            if (length > 1) ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    expanded = !expanded;
                    widget.onExpandChange?.call(expanded);
                  });
                },
                child: CustomText(
                  expanded
                      ? ZoPromoTransporterStrings.showLess.tr
                      : ZoPromoTransporterStrings.showMore.tr,
                  color: Color(ListColor.colorBlue),
                  decoration: TextDecoration.underline,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: (14.4 / 12),
                  withoutExtraPadding: true,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final String source;

  const _ImageWidget({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhite),
        border: Border.all(
          width: 1,
          color: Color(ListColor.colorLightGrey10),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            source ?? "",
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: SvgPicture.asset('assets/ic_picture.svg'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PickupDestinationWidget extends StatelessWidget {
  final String from;
  final String to;

  const _PickupDestinationWidget({
    Key key,
    this.from,
    this.to,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pointSize = GlobalVariable.ratioFontSize(context) * 16;

    Widget buildLocationTitle(String location) {
      return CustomText(
        location ?? "N/A",
        fontWeight: FontWeight.w500,
        fontSize: 14,
        // overflow: TextOverflow.ellipsis,
      );
    }

    Widget buildPoint(String asset) {
      return SizedBox(
        width: pointSize,
        height: pointSize,
        child: Center(
          child: SvgPicture.asset(
            '$asset',
            width: pointSize,
            height: pointSize,
          ),
        ),
      );
    }

    Widget buildLine() {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: GlobalVariable.ratioWidth(context) * 8,
        ),
        child: SizedBox(
          width: pointSize,
          height: 0,
          child: Center(
            child: SizedBox(
              height: double.infinity,
              child: ZoPromoTransporterVerticalDash(
                width: 1.5,
                height: double.infinity,
              ),
              // SvgPicture.asset(
              //   "assets/garis_alur_perjalanan.svg",
              //   fit: BoxFit.fill,
              //   height: 0,
              //   width: 1.5,
              // ),
            ),
          ),
        ),
      );
    }

    // final spacer = SizedBox(height: GlobalVariable.ratioWidth(context) * 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  buildPoint("assets/titik_biru_pickup.svg"),
                  Expanded(child: buildLine()),
                ],
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildLocationTitle(from),
                    SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPoint("assets/titik_biru_kuning_destinasi.svg"),
            SizedBox(width: GlobalVariable.ratioWidth(context) * 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildLocationTitle(to),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
