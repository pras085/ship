import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/manajemen_lokasi_api.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/manajemen_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/update_delete_save_location_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/detail_manajemen_lokasi/detail_manajemen_lokasi_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_list_management_lokasi/search_list_management_lokasi_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultListManagementLokasiController extends GetxController {
  var listHasilPencarianInlineSpan = [].obs;
  var searchBar = TextEditingController();
  var focus = false;
  var lastSearch = [].obs;
  var limitLastSearch = 7;

  var filterSearch = "".obs;
  var sort = Map().obs;

  var showInfoTooltip = true.obs;
  var firstShowTooltip = true;

  bool isChange = false;

  var loading = true.obs;
  var listManagementLokasiLength = 0.obs;

  var limit = 4;
  final refreshManagementLokasiController =
      RefreshController(initialRefresh: false);
  var change = Map();

  var listData = <ListManagementLokasiModel>[].obs;
  var phoneheight = MediaQuery.of(Get.context).size.height - 100;
  var showModalBottom = false.obs;
  var transporterContact = Map();
  var transporterStatus = "".obs;

  SortingController _sortingController;
  var transporterSort = [
    DataListSortingModel(
        "LocationManagementLabelLocationName".tr, "Name", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LocationManagementLabelLocation".tr, "Address", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LocationManagementLabelProvince".tr, "Province", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LocationManagementLabelCity".tr, "City", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LocationManagementLabelDistrict".tr, "District", "A-Z", "Z-A", "".obs),
  ];

  var listFilterKota = [].obs;
  var filterKota = [].obs;
  var tempFilterKota = [].obs;
  var getListFilterKota = false.obs;

  var listFilterProvince = [].obs;
  var filterProvince = [].obs;
  var tempFilterProvince = [].obs;
  var getListFilterProvince = false.obs;
  var totalAll = 0.obs;

  var firstTime = true;
  var failedGetListFilter = false.obs;
  var limitWrap = 5;

  @override
  void onInit() async {
    filterSearch.value = Get.arguments[0] as String;
    _setListHasilPencarian();
    searchBar.text = filterSearch.value;
    _sortingController = Get.put(
        SortingController(
            listSort: transporterSort,
            onRefreshData: (map) {
              sort.clear();
              sort.addAll(map);
              refreshData();
            }),
        tag: "SearchResultListManagementLokasi");

    refreshData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void showSort() {
    _sortingController.showSort();
  }

  void refreshData() async {
    // stopTimerGetMitra();
    try {
      loading.value = true;
      await doFilter(0);
      loading.value = false;
    } catch (e) {
      GlobalAlertDialog.showDialogError(
          message: e.toString(),
          context: Get.context,
          onTapPriority1: () {},
          labelButtonPriority1: "LoginLabelButtonCancel".tr);
    }
  }

  void loadData() {
    doFilter(listManagementLokasiLength.value);
  }

  doFilter(int offset) async {
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    var map = {};
    var text = "";
    filterKota.value.forEach((element) {
      text = "$text$element,";
    });
    map["Kota"] = text;
    text = "";
    filterProvince.forEach((element) {
      text = "$text$element,";
    });
    map["Provinsi"] = text;
    var resultFilter =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchListManagementLokasi(filterSearch.value, map, sort.value,
                limit, offset, GlobalVariable.docID);

    List<dynamic> data = resultFilter["Data"];
    totalAll.value = resultFilter["SupportingData"]["RealCountData"];
    if (firstShowTooltip) {
      firstShowTooltip = false;
      if (data.length == 0) {
        showInfoTooltip.value = true;
      } else {
        showInfoTooltip.value = false;
      }
    }

    var newListManagementLokasi = List<ListManagementLokasiModel>();
    data.forEach((element) {
      newListManagementLokasi.add(ListManagementLokasiModel.fromJson(element));
    });
    if (offset == 0) {
      listManagementLokasiLength.value = 0;
      refreshManagementLokasiController.resetNoData();
      refreshManagementLokasiController.refreshCompleted();
      listData.clear();
    } else {
      refreshManagementLokasiController.loadComplete();
    }
    if (newListManagementLokasi.length < limit) {
      refreshManagementLokasiController.loadNoData();
    }
    listManagementLokasiLength.value += newListManagementLokasi.length;
    listData.addAll(newListManagementLokasi);
  }

  Widget listPerItem(int index, ListManagementLokasiModel data) {
    double borderRadius = 10;
    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8.5,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorLightBlue9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 40),
                      child: SvgPicture.asset(
                        "assets/ic_pin_management_lokasi.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 32,
                        height: GlobalVariable.ratioWidth(Get.context) * 32,
                      ),
                    ),
                    SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            data.name,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorBlack1),
                            maxLines: 2,
                            height: 1.2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 2,
                          ),
                          CustomText(
                            data.city,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorGrey3),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _showMenuOptionListManagementLokasi(data);
                          },
                          child: Container(
                              child: Icon(
                            Icons.more_vert,
                            size: GlobalVariable.ratioWidth(Get.context) * 24,
                          )),
                        ))
                  ],
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 14),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 8),
                        alignment: Alignment.center,
                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                        child: SvgPicture.asset(
                          "assets/ic_pin_small_management_lokasi.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 16,
                          height: GlobalVariable.ratioWidth(Get.context) * 16,
                        ),
                      ),
                      Expanded(
                          child: CustomText(
                        data.address,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorDarkGrey3),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  ),
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 15,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 8),
                        alignment: Alignment.center,
                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                        child: SvgPicture.asset(
                          "assets/support_area_icon.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 16,
                          height: GlobalVariable.ratioWidth(Get.context) * 16,
                        ),
                      ),
                      Expanded(
                          child: CustomText(
                        data.district,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorDarkGrey3),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  ),
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 15,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 8),
                        alignment: Alignment.center,
                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                        child: SvgPicture.asset(
                          "assets/ic_province_management_lokasi.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 16,
                          height: GlobalVariable.ratioWidth(Get.context) * 16,
                        ),
                      ),
                      Expanded(
                          child: CustomText(
                        data.province,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorDarkGrey3),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  ),
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 15,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 8),
                        alignment: Alignment.center,
                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                        child: SvgPicture.asset(
                          "assets/ic_postal_code_management_lokasi.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 16,
                          height: GlobalVariable.ratioWidth(Get.context) * 16,
                        ),
                      ),
                      Expanded(
                          child: CustomText(
                        data.postalCode ?? "-",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorDarkGrey3),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              //garis
              width: MediaQuery.of(Get.context).size.width,
              height: 0.5,
              color: Color(ListColor.colorLightGrey10),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 18),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onTap: () async {
                            var result = await GetToPage.toNamed<
                                    DetailManajemenLokasiController>(
                                Routes.DETAIL_MANAJEMEN_LOKASI,
                                arguments: {
                                  EditManajemenLokasiInfoPermintaanMuatController
                                          .manajemenLokasiModelKey:
                                      ManajemenLokasiModel(
                                    id: data.id,
                                    name: data.name,
                                    address: data.address,
                                    latitude: data.latLng.latitude,
                                    longitude: data.latLng.longitude,
                                    province: data.province,
                                    city: data.city,
                                    district: data.district,
                                    postalCode: data.postalCode,
                                    picName: data.picName,
                                    picNoTelp: data.picNoTelp,
                                  ),
                                  EditManajemenLokasiInfoPermintaanMuatController
                                          .typeEditManajemenLokasiInfoPermintaanMuatKey:
                                      TypeEditManajemenLokasiInfoPermintaanMuat
                                          .UPDATE
                                });
                            if (result != null) {
                              if (result) {
                                isChange = true;
                                refreshData();
                              }
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: CustomText(
                                    'LoadRequestInfoButtonLabelDetail'.tr,
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))),
                    ),
                  ],
                ))
          ],
        ));
  }

  void _showMenuOptionListManagementLokasi(
      ListManagementLokasiModel listManagementLokasiModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 4,
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 18),
            width: MediaQuery.of(Get.context).size.width,
            color: Colors.transparent,
            //height: MediaQuery.of(context).size.height - 100,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: GlobalVariable.ratioWidth(Get.context) * 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(ListColor.colorLightGrey16)),
                    ),
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(Get.context) * 12,
                  ),
                  Container(
                      child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: CustomText(
                                "GlobalModalBottomSheetLabelOption".tr,
                                fontWeight: FontWeight.w700,
                                color: Color(ListColor.colorBlue),
                                fontSize: 14),
                          )),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              child: Icon(
                            Icons.close_rounded,
                            size: GlobalVariable.ratioWidth(Get.context) * 24,
                          )),
                        ),
                      ),
                    ],
                  )),
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 20,
                  ),
                  Container(
                      child: _itemBottomSheet(
                    title: "LocationManagementBottomSheetEdit".tr,
                    onTap: () async {
                      var result = await GetToPage.toNamed<
                              EditManajemenLokasiInfoPermintaanMuatController>(
                          Routes.EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
                          arguments: {
                            EditManajemenLokasiInfoPermintaanMuatController
                                .manajemenLokasiModelKey: ManajemenLokasiModel(
                              id: listManagementLokasiModel.id,
                              name: listManagementLokasiModel.name,
                              address: listManagementLokasiModel.address,
                              latitude:
                                  listManagementLokasiModel.latLng.latitude,
                              longitude:
                                  listManagementLokasiModel.latLng.longitude,
                              province: listManagementLokasiModel.province,
                              city: listManagementLokasiModel.city,
                              district: listManagementLokasiModel.district,
                              postalCode: listManagementLokasiModel.postalCode,
                              picName: listManagementLokasiModel.picName,
                              picNoTelp: listManagementLokasiModel.picNoTelp,
                            ),
                            EditManajemenLokasiInfoPermintaanMuatController
                                    .typeEditManajemenLokasiInfoPermintaanMuatKey:
                                TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE
                          });
                      if (result != null) {
                        CustomToast.show(
                            context: Get.context,
                            message: "LocationManagementAlertEditLocation".tr);
                        isChange = true;
                        refreshData();
                      }
                    },
                  )),
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 12,
                  ),
                  Container(
                    //garis
                    width: MediaQuery.of(Get.context).size.width,
                    height: 0.5,
                    color: Color(ListColor.colorLightGrey10),
                  ),
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 12,
                  ),
                  Container(
                      child: _itemBottomSheet(
                          title: "LocationManagementBottomSheetDelete".tr,
                          onTap: () {
                            GlobalAlertDialog.showAlertDialogCustom(
                                context: context,
                                title: "LocationManagementAlertTitleDelete".tr,
                                message:
                                    "LocationManagementAlertMessageDelete".tr,
                                isShowCloseButton: true,
                                positionColorPrimaryButton:
                                    PositionColorPrimaryButton.PRIORITY2,
                                labelButtonPriority1:
                                    GlobalAlertDialog.yesLabelButton,
                                labelButtonPriority2:
                                    GlobalAlertDialog.noLabelButton,
                                onTapPriority1: () async {
                                  UpdateDeleteSaveLocationResponseModel
                                      response =
                                      await ManajemenLokasiAPI.deleteData(
                                          listManagementLokasiModel.id);
                                  if (response != null) {
                                    if (response.message.code == 200) {
                                      CustomToast.show(
                                          context: Get.context,
                                          message:
                                              "LocationManagementAlertDeleteLocation"
                                                  .tr);
                                      isChange = true;
                                      refreshData();
                                    }
                                  }
                                },
                                onTapPriority2: () {});
                          },
                          textColor: Color(ListColor.colorRed))),
                ]),
          );
        });
  }

  Widget _itemBottomSheet(
      {String title, void Function() onTap, Color textColor = Colors.black}) {
    return InkWell(
        onTap: () {
          Get.back();
          onTap();
        },
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(title, color: textColor, fontWeight: FontWeight.w600)
            ],
          ),
        ));
  }

  void goToSearchPage() async {
    var result = await GetToPage.toNamed<SearchListManagementLokasiController>(
        Routes.SEARCH_LIST_MANAGEMENT_LOKASI,
        arguments: [filterSearch.value]);
    if (result != null) {
      filterSearch.value = result;
      _setListHasilPencarian();
      searchBar.text = result;
      refreshManagementLokasiController.requestRefresh();
    }
  }

  TextSpan _setTextSpan(String title, bool isBold) {
    return TextSpan(
        text: title,
        style: TextStyle(
            color: isBold ? Colors.black : Color(ListColor.colorDarkBlue2),
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500));
  }

  void _setListHasilPencarian() {
    String isiDesc2 = ("LocationManagementLabelShowLocation".tr)
        .replaceAll("#number", totalAll.value.toString());
    listHasilPencarianInlineSpan.clear();
    listHasilPencarianInlineSpan.add(_setTextSpan(isiDesc2, false));
    listHasilPencarianInlineSpan.add(_setTextSpan(filterSearch.value, true));
    listHasilPencarianInlineSpan.add(_setTextSpan("\"", false));
  }

  void onWillPop() {
    ListManagementLokasiController listManagementLokasiController;
    try {
      if (isChange) {
        listManagementLokasiController = Get.find();
        listManagementLokasiController.listenRefreshSearch();
      }
    } catch (err) {
      print(err);
    }
    Get.back();
  }
}
