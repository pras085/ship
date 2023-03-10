import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/buyer/filter_iklan/filter_iklan_view.dart';
import 'package:muatmuat/app/modules/login/login_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/dialog/dialog_buyer.dart';
import 'package:muatmuat/app/template/search/search_page_buyer.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_view.dart';
import 'package:muatmuat/app/template/widgets/appbar/appbar_list_buyer.dart';
import 'package:muatmuat/app/template/widgets/badge_places/badge_places_buyer.dart';
import 'package:muatmuat/app/template/widgets/banner/banner_ads.dart';
import 'package:muatmuat/app/template/widgets/navbar/navbar.dart';
import 'package:muatmuat/app/template/widgets/static_card/ads_places_card_buyer.dart';
import 'package:muatmuat/app/template/widgets/static_card/static_card_buyer.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../global_variable.dart';
import '../rules_buyer.dart';
import 'list_iklan_places_promo_controller.dart';

class ListIklanPlacesPromoView extends StatefulWidget {
  @override
  _ListIklanPlacesPromoViewState createState() => _ListIklanPlacesPromoViewState();
}

class _ListIklanPlacesPromoViewState extends State<ListIklanPlacesPromoView> {

  final controller = Get.put(ListIklanPlacesPromoController());
  Map menu;

  @override
  void initState() {
    super.initState();
    menu = Get.arguments;
    controller.argument.value = menu;
    controller.fetchDataIklan();
    controller.scrollController.addListener(() {
      print("SCROLL POSITION: ${controller.scrollController.position.pixels}");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adsType = RulesBuyer.getAdsTypeBySubKategoriId("${controller.argument.value['ID']}");
    
    return Material(
      color: Color(ListColor.colorBlueTemplate),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(
              double.infinity, 
              GlobalVariable.ratioWidth(context) * 60,
            ),
            child: Obx(() {
              String jumlahFilter = "0";
              if (controller.filter.value != null) {
                final jumlah = controller.filter.value.entries.where((el) {
                  if (el.value['value'] != null) {
                    if (el.value['value'] is List && (el.value['value'] as List).isNotEmpty) {
                      return true;
                    } else {
                      if (
                        el.value['value'] is String 
                        && (
                          (el.value['value'] as String).isNotEmpty
                          || "${el.value['value']}" != "0"
                        )
                      ) return true;
                      return false;
                    }
                  }
                  return false;
                }).length;
                jumlahFilter = "$jumlah";
              }
              return AppBarListBuyer(
                title: "${menu['subKategori']}",
                subTitle: "${menu['kategori']}",
                isActiveFavorite: controller.isFavorite.value,
                onClickBack: () {
                  Get.back();
                },
                onClickFavorite: () async {
                  if (GlobalVariable.tokenApp.isEmpty) {
                    GlobalAlertDialog.showAlertDialogCustom(
                      context: Get.context,
                      insetPadding: 17,
                      customMessage: Container(
                        margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 15,
                          right: GlobalVariable.ratioWidth(Get.context) * 15,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
                        ),
                        child: CustomText(
                          "Silahkan Masuk atau Daftar terlebih dahulu jika belum punya akun muatmuat",
                          textAlign: TextAlign.center,
                          fontSize: 14,
                          height: 21 / 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      borderRadius: 12,
                      primaryColor: Color(ListColor.colorBlueTemplate),
                      labelButtonPriority1: "Daftar",
                      labelButtonPriority2: "Masuk",
                      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
                      onTapPriority1: () {
                        GetToPage.toNamed<RegisterUserController>(Routes.REGISTER_USER);
                      },
                      onTapPriority2: () {
                        GetToPage.toNamed<LoginController>(Routes.LOGIN);
                      }
                    );
                  } else {
                    controller.filter.value = null;
                    controller.selectedSorting.value = null;
                    controller.isFavorite.value = !controller.isFavorite.value;
                    controller.fetchDataIklan();
                  }
                },
                jumlahFilter: jumlahFilter,
                isActiveSort: controller.selectedSorting.value != null,
                isActiveFilter: controller.filter.value != null,
                onClickFilter: controller.isFavorite.value ? null : () async {
                  final res = await Get.to(FilterIklanView(),
                    arguments: {
                      'filter': controller.filter.value,
                      'data': controller.dataModelResponse.value.data["SupportingData"]['max'],
                      ...menu,
                    },
                  );
                  if (res != null) {
                    if (res is Map && res.isNotEmpty) {
                      controller.filter.value = res;
                      if (res['PlatformRekomendasi'] != null) {
                        controller.isBF.value = res['PlatformRekomendasi']['value'].contains("0");
                        controller.isTM.value = res['PlatformRekomendasi']['value'].contains("1");
                      }
                    } else {
                      controller.filter.value = null;
                    }
                    controller.fetchDataIklan();
                  }
                  // update statusbar color
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
                },
                onClickSort: controller.isFavorite.value ? null : () {
                  showSortingDialog();
                },
              );
            }),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 12,
              ),
              // Pencarian
              Center(
                child: InkWell(
                  onTap: controller.isFavorite.value ? null : () async {
                    final res = await Get.to(() => SearchPageBuyer(),
                      arguments: controller.searchResult.value,
                    );
                    if (res != null && res is List && res.length > 1) {
                      controller.searchResult.value = res[0];
                      controller.locationController.location.value = res[1];
                      controller.fetchDataIklan();
                    }
                  },
                  child: Container(
                    height: GlobalVariable.ratioWidth(context) * 32,
                    width: GlobalVariable.ratioWidth(context) * 328,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 8),
                      border: Border.all(
                        width: GlobalVariable.ratioWidth(context) * 1, 
                        color: Color(ListColor.colorGreyTemplate2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 6),
                          child: Image.asset(
                            GlobalVariable.urlImageTemplateBuyer + 'loop_kat.png',
                            height: GlobalVariable.ratioWidth(context) * 20,
                            width: GlobalVariable.ratioWidth(context) * 20,
                            color: Color(0xFF002D84),
                          ),
                        ),
                        Expanded(
                          child: Obx(() => CustomText(
                            controller.searchResult.value.isNotEmpty 
                            ? controller.searchResult.value
                            : "Masukkan Pencarian", 
                            fontWeight: FontWeight.w600, 
                            fontSize: 14,
                            color: Color(
                              controller.searchResult.value.isNotEmpty
                              ? 0xFF000000
                              : 0xFFCECECE
                            ),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ),
                        Obx(() => controller.searchResult.value.isNotEmpty ? GestureDetector(
                          onTap: () {
                            controller.searchResult.value = "";
                            controller.fetchDataIklan();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(
                              GlobalVariable.ratioWidth(context) * 6,
                            ),
                            child: SvgPicture.asset(
                              'assets/ic_close_frame.svg',
                              height: GlobalVariable.ratioWidth(context) * 20,
                              width: GlobalVariable.ratioWidth(context) * 20,
                              color: Colors.black,
                            ),
                          ),
                        ) : SizedBox.shrink()),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 5,
              ),
              // location
              InkWell(
                onTap: () async {
                  final res = await Get.to(SelectLocationBuyerView());
                  if (res != null && res is SelectLocationBuyerModel) {
                    controller.locationController.location.value = res;
                    controller.fetchDataIklan();
                  } else if (res != null && res is int) {
                    controller.locationController.location.value = null;
                    controller.fetchDataIklan();
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(context) * 16),
                  height: GlobalVariable.ratioWidth(context) * 28,
                  width: GlobalVariable.ratioWidth(context) * 184,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(context) * 4),
                        child: Image.asset(
                          'assets/loc_kat.png',
                          height: GlobalVariable.ratioWidth(context) * 24,
                          width: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                            // top: GlobalVariable.ratioWidth(context) * 2,
                            left: GlobalVariable.ratioWidth(context) * 8,
                          ),
                          child: Obx(() => CustomText(controller.locationController.location.value != null ? controller.locationController.location.value.description : "Indonesia", 
                            fontWeight: FontWeight.w600, 
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(ListColor.colorBlueTemplate),
                          )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(context) * 6),
                        child: Image.asset(
                          'assets/chev_kat.png',
                          height: GlobalVariable.ratioWidth(context) * 16,
                          width: GlobalVariable.ratioWidth(context) * 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 12,
              ),
              // CONTENT
              Expanded(
                child: Obx(() {
                  return SmartRefresher(
                    enablePullUp: controller.locationController.location.value == null,
                    controller: controller.refreshController,
                    onLoading: controller.locationController.location.value == null ? 
                      controller.dataModelResponse.value.state == ResponseStates.COMPLETE && controller.dataList.value.isNotEmpty  ? 
                        () {
                          controller.fetchDataIklan(
                            refresh: false,
                          );
                        } : null
                      : null,
                    scrollController: controller.scrollController,
                    onRefresh: controller.dataModelResponse.value.state == ResponseStates.COMPLETE ? () {
                      print('REFRESH');
                      controller.fetchDataIklan();
                    } : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // BANNER ADS
                        Container(
                          key: controller.bannerKey,
                          child: BannerAds(
                            layananID: "${controller.argument.value['layanan']}",
                            formMasterID: "${controller.argument.value['KategoriID']}",
                            penempatanID: "1",
                            marginBottom: 0,
                          ),
                        ),

                        Obx(() {
                          if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
                            final dataList = controller.dataList.value;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                
                                // START CUSTOM WIDGET HEREEE
                                Obx(() => controller.locationController.location.value != null ?
                                  Container(
                                    key: controller.badgeKey,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(context) * 8, // -2px customText
                                    ),
                                    child: BadgePlacesBuyer(
                                      location: controller.locationController.location.value,
                                    ),
                                  )
                                  : SizedBox.shrink()
                                ),
                                // END CUSTOM WIDGET HEREEE

                                if (
                                  controller.searchResult.isNotEmpty 
                                  && dataList.isNotEmpty
                                )
                                  Container(
                                    width: GlobalVariable.ratioWidth(context) * 328,
                                    margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(context) * 8, // -2px customText
                                    ),
                                    child: CustomText("Menampilkan Hasil Dari Pencarian \"${controller.searchResult}\"",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                // LIST PRODUCT
                                if (dataList.isEmpty)
                                  Container(
                                    width: GlobalVariable.ratioWidth(context) * 328,
                                    // height: GlobalVariable.ratioWidth(context) * 153,
                                    constraints: BoxConstraints(
                                      minHeight: GlobalVariable.ratioWidth(context) * 153,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(context) * 16,
                                      vertical: GlobalVariable.ratioWidth(context) * 0,
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset("assets/empty_result_buyer.svg",
                                          width: GlobalVariable.ratioWidth(context) * 120,
                                          height: GlobalVariable.ratioWidth(context) * 120,
                                        ),
                                        SizedBox(
                                          height: GlobalVariable.ratioWidth(context) * 16,
                                        ),
                                        CustomText(
                                          // if favorit on dan filter off
                                          controller.isFavorite.value && controller.filter.value == null ? 
                                          "Anda Belum Memiliki Iklan Yang Difavoritkan"  
                                          // filter on and favorit off
                                          : controller.filter.value != null && controller.filter.value.isNotEmpty && !controller.isFavorite.value ?
                                          "Hasil Filter Anda Tidak Ditemukan"
                                          : "Hasil Pencarian Anda Tidak Ditemukan",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.center,
                                          height: 16.8/14,
                                          withoutExtraPadding: true,
                                        ),
                                        // only show if it comes from search
                                        if (
                                          dataList.isEmpty 
                                          && !controller.isFavorite.value 
                                          && controller.searchResult.value.isNotEmpty
                                        )
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(context) * 4,
                                            ),
                                            child: CustomText("Coba gunakan kata kunci lain untuk menemukan produk yang Anda inginkan",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.center,
                                              height: 14.4/12,
                                              withoutExtraPadding: true,
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                else ...[
                                  Padding(
                                    key: controller.listKey,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(context) * 16,
                                      vertical: GlobalVariable.ratioWidth(context) * 10,
                                    ),
                                    child: StaggeredGrid.count(
                                      crossAxisCount: adsType == ADS_TYPE.product ? 2 : 1,
                                      mainAxisSpacing: GlobalVariable.ratioWidth(context) * 10,
                                      crossAxisSpacing: GlobalVariable.ratioWidth(context) * 16,
                                      children: [
                                        for (int i=0;i<dataList.length;i++)
                                          RulesBuyer.getCardDataKey(
                                            kategoriId: "${controller.argument.value['KategoriID']}",
                                            subKategoriId: "${controller.argument.value['ID']}",
                                            data: dataList[i],
                                            layanan: "${menu['kategori']}",
                                            onFavorited: () {
                                              controller.addToWishlist(i);
                                            }
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (controller.isLoading.value) Center(child: CircularProgressIndicator()),
                                  if (controller.locationController.location.value != null) Container(
                                    key: controller.buttonKey,
                                    padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(context) * 16,
                                      right: GlobalVariable.ratioWidth(context) * 16,
                                      top: controller.isLoading.value ? GlobalVariable.ratioWidth(context) * 10 : 0,
                                      bottom: GlobalVariable.ratioWidth(context) * 10
                                    ),
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: !controller.isLoading.value
                                      ? () async {
                                        controller.isLoading.value = true;
                                        await controller.fetchDataIklan(refresh: false);
                                        controller.isLoading.value = false;
                                        controller.scrollController.animateTo(controller.getCurrentPosition(), duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                                      } : null,
                                      child: CustomText(
                                        'Tampilkan Selengkapnya',
                                        color: Color(ListColor.colorBlue),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                                
                                Obx(() => controller.locationController.location.value != null ?
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(context) * 16,
                                      vertical: GlobalVariable.ratioWidth(context) * 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        StaticCardBuyer(
                                          isBigFleet: controller.isBF.value, // default for places
                                          isTransportMarket: controller.isTM.value, // default for places
                                        ),
                                        SizedBox(
                                          height: GlobalVariable.ratioWidth(context) * 10,
                                        ),
                                        AdsPlacesCardBuyer(
                                          title: "Temukan # Iklan Transportation Store di ${controller.locationController.location.value.city}", 
                                          location: controller.locationController.location.value,
                                          layananID: "4", // transportation Store 
                                          layananName: "Transportation Store",
                                          adsType: ADS_TYPE.product,
                                        ),
                                        AdsPlacesCardBuyer(
                                          title: "Temukan # Iklan Gudang dijual di ${controller.locationController.location.value.city}", 
                                          location: controller.locationController.location.value,
                                          layananID: "6", // Property & Warehouse 
                                          layananName: "Property & Warehouse",
                                          adsType: ADS_TYPE.product,
                                        ),
                                        AdsPlacesCardBuyer(
                                          title: "Temukan # Iklan lowongan kerja di ${controller.locationController.location.value.city}", 
                                          location: controller.locationController.location.value,
                                          layananID: "9", // Human Capital
                                          layananName: "Human Capital",
                                          adsType: ADS_TYPE.compro,
                                        ),
                                      ],
                                    ),
                                  ) : SizedBox.shrink(),
                                ),

                              ],
                            );
                          } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: GlobalVariable.ratioWidth(context) * 150,
                              ),
                              child: ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
                                onRefresh: () => controller.fetchDataIklan(),
                              ),
                            );
                          }
                          return _loadingWidget(adsType == ADS_TYPE.product);
                        }),

                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
          bottomNavigationBar: Navbar(
            onTap1: () {},
            onTap2: () {},
            onTap3: () {},
            onTap4: () {},
            selectedIndex: 0,
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget(bool isProduct) {
    final int length = isProduct ? 10 : 4;
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(context) * 16,
              vertical: GlobalVariable.ratioWidth(context) * 10,
            ),
            child: StaggeredGrid.count(
              crossAxisCount: isProduct ? 2 : 1,
              mainAxisSpacing: GlobalVariable.ratioWidth(context) * 10,
              crossAxisSpacing: GlobalVariable.ratioWidth(context) * 16,
              children: [
                for (int i=0;i<length;i++)
                  Material(
                    borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(context) * 8,
                    ),
                    color: Colors.white54,
                    child: Padding(
                      padding: EdgeInsets.all(
                        GlobalVariable.ratioWidth(context) * 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: GlobalVariable.ratioWidth(context) * 52,
                                height: GlobalVariable.ratioWidth(context) * 12,
                                color: Colors.white,
                              ),
                              SvgPicture.asset(
                                GlobalVariable.urlImageTemplateBuyer + 'ic_favorite_template.svg',
                                height: GlobalVariable.ratioWidth(Get.context) * 20,
                                width: GlobalVariable.ratioWidth(Get.context) * 20
                              ),
                            ],
                          ),
                          if (isProduct)
                            Container(
                              width: GlobalVariable.ratioWidth(context) * 140,
                              height: GlobalVariable.ratioWidth(context) * 82,
                              color: Colors.white,
                            )
                          else
                            Row(
                              children: [
                                Container(
                                  width: GlobalVariable.ratioWidth(context) * 89,
                                  height: GlobalVariable.ratioWidth(context) * 50,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: GlobalVariable.ratioWidth(context) * 120,
                                        height: GlobalVariable.ratioWidth(context) * 14,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(context) * 8,
                          ),
                          Container(
                            width: double.infinity,
                            height: GlobalVariable.ratioWidth(context) * 28,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(context) * 8,
                          ),
                          Container(
                            width: double.infinity,
                            height: GlobalVariable.ratioWidth(context) * 28,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSortingDialog() {
    final listSorting = RulesBuyer.getSortingDataBySubKategoriId("${controller.argument.value['ID']}");
    // call the class
    DialogBuyer.sorting(
      context: context,
      onReset: () {
        controller.selectedSorting.value = null;
        controller.fetchDataIklan();
        Get.back(); // close the dialog immediately after click/update the value.
      }, // when reset button was tapped
      itemCount: listSorting.length, // the length of list sorting from api
      itemBuilder: (c, i) {
        // builder, to build the item.
        return SortingTileDialogBuyer(
          context: context,
          label: listSorting[i]['name'],
          childCount: (listSorting[i]['child'] as List).length,
          childBuilder: (_, idx) {
            // Start to render the view for radio button and its label.
            final o = (listSorting[i]['child'] as List)[idx];
            return SortingTileContentDialogBuyer(
              context: context,
              groupValue: controller.selectedSorting.value, // newest value, change this with your variable
              // combination
              value: "${listSorting[i]['id']},${o['id']}", // default value for each radio button.
              text: o['name'], // label for the item.
              onTap: () {
                // example onSelect
                controller.selectedSorting.value = "${listSorting[i]['id']},${o['id']}";
                controller.fetchDataIklan();
                Get.back(); // close the dialog immediately after click/update the value.
              },
            );
          },
        );
      },
    );
  }

}