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
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/filter_manajemen_lokasi/filter_manajemen_lokasi_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListManagementLokasiController extends GetxController {
  var searchBar = TextEditingController();
  var focus = false;
  var lastSearch = [].obs;
  var limitLastSearch = 7;

  var filterSearch = "".obs;
  var sort = Map().obs;

  var showInfoTooltip = true.obs;
  var firstShowTooltip = true;

  var loading = true.obs;
  var listManagementLokasiLength = 0.obs;

  var limit = 4;
  final refreshManagementLokasiController =
      RefreshController(initialRefresh: false);
  var change = Map();

  var listData = <ListManagementLokasiModel>[].obs;

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
  var langTemp = "";

  Function() listenRefreshSearch;

  @override
  void onInit() async {
    _sortingController = Get.put(
        SortingController(
            listSort: transporterSort,
            onRefreshData: (map) {
              sort.clear();
              sort.addAll(map);
              refreshData();
            }),
        tag: "ListManagementLokasi");

    refreshData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void showFilter() async {
    tempFilterKota.value = List.from(filterKota.value);
    tempFilterProvince.value = List.from(filterProvince.value);
    if (firstTime || failedGetListFilter.value) getListFilter();
    firstTime = false;
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(Get.context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 4,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 17),
                    child: Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: GlobalVariable.ratioWidth(Get.context) * 3,
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey16),
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 4))),
                    )),
                Container(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 12,
                        right: GlobalVariable.ratioWidth(Get.context) * 12,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: CustomText("GlobalFilterTitle".tr,
                                fontWeight: FontWeight.w700,
                                color: Color(ListColor.color4),
                                fontSize: 14)),
                        Padding(
                          padding: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  child: SvgPicture.asset(
                                "assets/ic_close1,5.svg",
                                color: Color(ListColor.colorBlack),
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 15,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 15,
                              )),
                            ),
                          ),
                        ),
                        Obx(
                          () => !failedGetListFilter.value &&
                                  !getListFilterKota.value &&
                                  !getListFilterProvince.value
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          child: CustomText(
                                            "GlobalFilterButtonReset".tr,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor.color4),
                                          ),
                                          onTap: () {
                                            resetFilter();
                                          }),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        )
                      ],
                    )),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(Get.context).size.height - 200,
                        minHeight: 0,
                        minWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16),
                      child: Obx(
                        () => (getListFilterKota.value ||
                                getListFilterProvince.value)
                            ? Container(
                                width: MediaQuery.of(Get.context).size.width,
                                height: 200,
                                child: Center(
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator())))
                            : !failedGetListFilter.value
                                ? (listFilterKota.isNotEmpty ||
                                        listFilterProvince.isNotEmpty)
                                    ? ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      "LabelSortProvinceSaveLocation"
                                                          .tr,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  Obx(
                                                    () => Container(
                                                        margin: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    12),
                                                        height: GlobalVariable.ratioWidth(Get.context) *
                                                            22,
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    6),
                                                        constraints: BoxConstraints(
                                                            minWidth:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    22),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 22),
                                                            color: tempFilterProvince.isEmpty ? Colors.transparent : Color(ListColor.color4)),
                                                        child: CustomText(tempFilterProvince.length.toString(), fontWeight: FontWeight.w600, color: tempFilterProvince.isEmpty ? Colors.transparent : Colors.white)),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showAll(1);
                                                        },
                                                        child: CustomText(
                                                            "GlobalFilterButtonShowAll"
                                                                .tr,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                ListColor
                                                                    .colorBlue)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              Obx(() => wrapFilter(
                                                      listFilterProvince.value,
                                                      tempFilterProvince.value,
                                                      (bool onSelect,
                                                          String value) {
                                                    if (onSelect)
                                                      tempFilterProvince
                                                          .add(value);
                                                    else
                                                      tempFilterProvince
                                                          .remove(value);
                                                  }))
                                            ],
                                          ),
                                          Container(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  0.5,
                                              color: Color(
                                                  ListColor.colorLightGrey10),
                                              margin: EdgeInsets.only(
                                                  top:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  bottom:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18)),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      "LabelSortCitySaveLocation"
                                                          .tr,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  Obx(
                                                    () => Container(
                                                        margin: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    12),
                                                        height: GlobalVariable.ratioWidth(Get.context) *
                                                            22,
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    6),
                                                        constraints: BoxConstraints(
                                                            minWidth:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    22),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 22),
                                                            color: tempFilterKota.isEmpty ? Colors.transparent : Color(ListColor.color4)),
                                                        child: CustomText(tempFilterKota.length.toString(), fontWeight: FontWeight.w600, color: tempFilterProvince.isEmpty ? Colors.transparent : Colors.white)),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showAll(0);
                                                        },
                                                        child: CustomText(
                                                            "GlobalFilterButtonShowAll"
                                                                .tr,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                ListColor
                                                                    .colorBlue)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              Obx(() => wrapFilter(
                                                      listFilterKota.value,
                                                      tempFilterKota.value,
                                                      (bool onSelect,
                                                          String value) {
                                                    if (onSelect)
                                                      tempFilterKota.add(value);
                                                    else
                                                      tempFilterKota
                                                          .remove(value);
                                                  }))
                                            ],
                                          ),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  44)
                                        ],
                                      )
                                    : SizedBox.shrink()
                                : Container(
                                    width:
                                        MediaQuery.of(Get.context).size.width,
                                    height: 200,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 10),
                                          CustomText(
                                            'GlobalLabelErrorNoCTypection'.tr,
                                            textAlign: TextAlign.center,
                                            fontSize: 14,
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                              onTap: () {
                                                getListFilter();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: CustomText(
                                                  'GlobalButtonTryAgain'.tr,
                                                  fontSize: 14,
                                                  color:
                                                      Color(ListColor.color4),
                                                ),
                                              ))
                                        ])),
                      ),
                    )),
                Container(
                    width: MediaQuery.of(Get.context).size.width,
                    height: GlobalVariable.ratioWidth(Get.context) * 56,
                    child: Obx(
                      () => !failedGetListFilter.value &&
                              !getListFilterKota.value &&
                              !getListFilterProvince.value
                          ? Container(
                              padding: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 22,
                                  GlobalVariable.ratioWidth(Get.context) * 10,
                                  GlobalVariable.ratioWidth(Get.context) * 22,
                                  GlobalVariable.ratioWidth(Get.context) * 14),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(16),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                      offset: Offset(0, -15),
                                    )
                                  ]),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(ListColor.color4)),
                                        color: Colors.white,
                                      ),
                                      child: Material(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Center(
                                                child: CustomText(
                                                    "GlobalFilterButtonCancel"
                                                        .tr,
                                                    color:
                                                        Color(ListColor.color4),
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(ListColor.color4)),
                                        color: Color(ListColor.color4),
                                      ),
                                      child: Material(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          child: InkWell(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            onTap: () {
                                              onSaveFilter();
                                            },
                                            child: Center(
                                                child: CustomText(
                                                    "GlobalFilterButtonSave".tr,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                    ))
              ],
            ),
          ));
        });
  }

  void showAll(int jenis) async {
    var result = await GetToPage.toNamed<FilterManajemenLokasiController>(
        Routes.FILTER_MANAJEMEN_LOKASI,
        arguments: [
          List.from(
              jenis == 0 ? listFilterKota.value : listFilterProvince.value),
          List.from(
              jenis == 0 ? tempFilterKota.value : tempFilterProvince.value),
          jenis
        ],
        preventDuplicates: false);
    if (result != null) {
      if (jenis == 0)
        tempFilterKota.value = result;
      else
        tempFilterProvince.value = result;
    }
  }

  void resetFilter() {
    tempFilterKota.clear();
    tempFilterProvince.clear();
  }

  void onSaveFilter() {
    filterKota.value = List.from(tempFilterKota.value);
    filterProvince.value = List.from(tempFilterProvince.value);
    tempFilterKota.clear();
    tempFilterProvince.clear();
    refreshData();
    Get.back();
  }

  Widget wrapFilter(List listShow, List listSelected,
      void Function(bool isChoosen, String value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));
    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 10,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 15,
      children: [
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrap(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrap(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget itemWrap(String name, bool isChoosen,
      void Function(bool isChoosen, String value) onTapItem) {
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 2),
            child: CustomText(
              name,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  void getListFilter() {
    langTemp = GlobalVariable.languageType;
    GlobalVariable.languageType = "id_ID";
    getListCity();
    getListProvince();
  }

  void getListCity() async {
    getListFilterKota.value = true;
    var resultCity =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchSearchCity("");
    if (resultCity["Message"]["Code"] == 200) {
      listFilterKota.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterKota.add(element["City"]);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterKota.value = false;
    if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListProvince() async {
    getListFilterProvince.value = true;
    var resultProvince =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchProvince();
    if (resultProvince["Message"]["Code"] == 200) {
      listFilterProvince.clear();
      (resultProvince["Data"] as List).forEach((element) {
        listFilterProvince.add(element["Description"]);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterProvince.value = false;
    if (!getListFilterKota.value) GlobalVariable.languageType = langTemp;
  }

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
    var map = {};
    var text = "";
    filterKota.value.forEach((element) {
      if (filterKota.last == element)
        text += "$element";
      else
        text += "$element,";
    });
    map["Kota"] = text;
    text = "";
    filterProvince.forEach((element) {
      if (filterProvince.last == element)
        text += "$element";
      else
        text += "$element,";
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
      listData.add(null);
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
          borderRadius: BorderRadius.all(Radius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.1),
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
              spreadRadius: 0,
              offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
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
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) *
                              borderRadius),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) *
                              borderRadius))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
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
              height: GlobalVariable.ratioWidth(Get.context) * 0.5,
              color: Color(ListColor.colorLightGrey10),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 7),
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
                      borderRadius: BorderRadius.circular(20),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 18),
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
                                refreshManagementLokasiController
                                    .requestRefresh();
                              }
                            }
                          },
                          child: Container(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 28,
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 82,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18)),
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
                        refreshManagementLokasiController.requestRefresh();
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
                                      if (response.message.code == 200) {
                                        refreshData();
                                      }
                                    }
                                  }
                                },
                                onTapPriority2: () {},
                                positionColorPrimaryButton:
                                    PositionColorPrimaryButton.PRIORITY2);
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

  void addListenerSearch(Function listen) {
    listenRefreshSearch = listen;
  }
}
