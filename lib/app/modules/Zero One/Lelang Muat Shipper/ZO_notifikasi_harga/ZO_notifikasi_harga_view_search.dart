import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_notifikasi_harga_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_model.dart';
import 'package:muatmuat/app/core/models/head_truck_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_search_app_bar.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaViewSearch extends StatelessWidget {
  final ZoNotifikasiHargaController controller;
  final Future<void> Function() refreshCallback;
  const ZoNotifikasiHargaViewSearch({
    Key key,
    @required this.controller,
    @required this.refreshCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onSearchWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Color(ListColor.colorBlack).withOpacity(0.15),
            backgroundColor: Color(ListColor.colorWhite),
            automaticallyImplyLeading: false,
            leading: null,
            title: null,
            toolbarHeight: GlobalVariable.ratioWidth(context) * 56,
            flexibleSpace: Obx(
              () => ZoNotifikasiHargaSearchAppBar(
                onSubmitted: controller.onSearchSubmit,
                onChanged: controller.onSearchChanged,
                hintText: controller.hintText.value,
                initialSearch: controller.searchQueryObs.value,
              ),
            ),
          ),
          body: Obx(() {
            if (controller.isSearchLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final list = controller.items;
            if (list.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: SvgPicture.asset(
                      "assets/ic_management_lokasi_no_search.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 82.3,
                      height: GlobalVariable.ratioWidth(Get.context) * 75,
                    )),
                    Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    Container(
                        child: CustomText(
                      ZoPromoTransporterStrings.searchNoResultCaption.tr
                          .replaceAll("\\n", "\n"),
                      textAlign: TextAlign.center,
                      color: Color(ListColor.colorLightGrey14),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.2,
                    ))
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async =>
                  await controller.onViewSearchRefresh(refreshCallback),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(context) * 16,
                  vertical: GlobalVariable.ratioWidth(context) * 20,
                ),
                itemCount: list.length,
                separatorBuilder: (context, index) => list[index].showDivider
                    ? Divider(
                        height: GlobalVariable.ratioWidth(context) * 24,
                      )
                    : SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                itemBuilder: (context, index) {
                  return Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, list[index].value);
                      },
                      child: list[index].widget,
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ZoNotifikasiHargaSearchPageModel {
  final String value;
  final String valueForSort;
  final Widget widget;
  final bool showDivider;

  const ZoNotifikasiHargaSearchPageModel({
    String value,
    String valueForSort,
    this.widget,
    this.showDivider = true,
  })  : this.value = value,
        this.valueForSort = valueForSort == null ? value : valueForSort;

  factory ZoNotifikasiHargaSearchPageModel.fromTransporterFree(
      ZoTransporterFreeModel transporterFree) {
    if (transporterFree == null) return null;

    var placeholderImage =
        Image.asset('assets/ic_avatar.png', fit: BoxFit.contain);

    return ZoNotifikasiHargaSearchPageModel(
      showDivider: false,
      value: '${transporterFree?.name}',
      widget: Row(
        children: [
          ClipOval(
            child: Container(
              width: GlobalVariable.ratioWidth(Get.context) * 32,
              height: GlobalVariable.ratioWidth(Get.context) * 32,
              child: transporterFree?.avatar == null
                  ? placeholderImage
                  : Image.network(
                      transporterFree?.avatar ?? '',
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: SizedBox(
                            height: GlobalVariable.ratioWidth(context) * 16,
                            width: GlobalVariable.ratioWidth(context) * 16,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) {
                        return placeholderImage;
                        // return Container(
                        //   alignment: Alignment.center,
                        //   color: Colors.grey,
                        //   child: SvgPicture.asset(
                        //     'assets/ic_picture.svg',
                        //     width: GlobalVariable.ratioWidth(Get.context) * 16,
                        //   ),
                        // );
                      },
                    ),
            ),
          ),
          SizedBox(
            width: GlobalVariable.ratioWidth(Get.context) * 12,
          ),
          Expanded(
            child: CustomText(
              '${transporterFree?.name}',
              color: Color(ListColor.colorGrey4),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  factory ZoNotifikasiHargaSearchPageModel.fromRegionByCity(
    ZoRegionByCityModel regionByCity,
  ) {
    if (regionByCity == null) return null;
    var list =
        regionByCity.description?.split(',')?.map((e) => e.trim())?.toList() ??
            [];
    var province = regionByCity.province ?? (list.isNotEmpty ? list.last : '');
    var cityName = (regionByCity.city ??
        regionByCity.modifiedCity ??
        (list.isNotEmpty ? list.first : ''));
    var city = (regionByCity.modifiedCity ??
            regionByCity.city ??
            (list.isNotEmpty ? list.first : ''))
        .replaceAll(RegExp('Kabupaten', caseSensitive: false), 'Kab.');

    if (cityName.indexOf(RegExp('Kabupaten', caseSensitive: false)) == 0) {
      cityName = cityName
              .replaceFirst(RegExp('Kabupaten', caseSensitive: false), '')
              .trim() +
          ' Kabupaten';
    }
    if (cityName.indexOf(RegExp('Kota', caseSensitive: false)) == 0) {
      cityName = cityName
          .replaceFirst(RegExp('Kota', caseSensitive: false), '')
          .trim();
    }

    var value = '${(cityName?.isEmpty ?? true) ? '' : '$cityName'}';

    var display = '${(city?.isEmpty ?? true) ? '' : '$city'}'
        '${(province?.isEmpty ?? true) ? '' : ', $province'}';

    return ZoNotifikasiHargaSearchPageModel(
      value: '$display',
      valueForSort: '$value',
      widget: _getTextRow('$display'),
    );
  }

  factory ZoNotifikasiHargaSearchPageModel.fromHeadTruck(
    HeadTruckModel headTruck,
  ) {
    if (headTruck == null) return null;
    final value = '${headTruck.description}';
    final display = value == ZoNotifikasiHargaStrings.dropdownDefaultValue.tr
        ? ZoNotifikasiHargaStrings.dropdownTruckDefaultValueDisplay.tr
        : value;
    return ZoNotifikasiHargaSearchPageModel(
      value: value,
      widget: _getTextRow(display),
    );
  }

  factory ZoNotifikasiHargaSearchPageModel.fromCarrierTruck(
    CarrierTruckModel carrierTruck,
  ) {
    if (carrierTruck == null) return null;
    final value = '${carrierTruck.description}';
    final display = value == ZoNotifikasiHargaStrings.dropdownDefaultValue.tr
        ? ZoNotifikasiHargaStrings.dropdownCarrierDefaultValueDisplay.tr
        : value;
    return ZoNotifikasiHargaSearchPageModel(
      value: value,
      widget: _getTextRow(display),
    );
  }

  static Widget _getTextRow(String label) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            '$label',
            color: Color(ListColor.colorBlack),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  String toString() {
    return value;
  }
}
