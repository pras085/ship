import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/core/controllers/filter_controller_custom.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/function/api/get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/transporter_list_design_model.dart';
import 'package:muatmuat/app/core/models/transporter_model.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListTransporterController extends GetxController {
  var searchBar = TextEditingController();
  var focus = false;
  var showSuggestion = false.obs;
  var lastSearch = [].obs;
  var limitLastSearch = 7;

  var filterSearch = "".obs;
  var sort = Map().obs;

  var loading = true.obs;
  var listTransporterLength = 0.obs;

  var limit = 4;
  final refreshTransporterController = RefreshController(initialRefresh: false);
  FilterCustomController _controllerFilter;
  var change = Map();

  ListDataDesignFunction listTransporter;
  var phoneheight = MediaQuery.of(Get.context).size.height - 100;
  var showModalBottom = false.obs;
  var transporterContact = Map();
  var transporterStatus = "".obs;

  var mapFilterData = Map<String, dynamic>().obs;
  SortingController _sortingController;
  var transporterSort = [
    DataListSortingModel("Nama", "Name", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Lokasi", "Kota", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "Tahun Didirikan", "FoundedYear", "Paling Lama", "Paling Baru", "".obs),
    DataListSortingModel(
        "Jumlah Truk", "QtyTruck", "Paling Sedikit", "Paling Banyak", "".obs),
    DataListSortingModel(
        "Bergabung Sejak", "JoinDate", "Paling Lama", "Paling Baru", "".obs),
    // DataListSortingModel("Lainnya", "Lainnya", "A-Z", "Z-A", "".obs),
  ];

  List<WidgetFilterModel> _listWidgetFilter = [
    WidgetFilterModel(
        label: ["GlobalFIlterNumberOfTruck".tr],
        typeInFilter: TypeInFilter.UNIT,
        keyParam: "Qty"),
    WidgetFilterModel(
        label: ["GlobalFilterYearFounded".tr],
        typeInFilter: TypeInFilter.YEAR,
        keyParam: "Tahun"),
    WidgetFilterModel(
        label: ["Bergabung Sejak".tr],
        typeInFilter: TypeInFilter.DATE,
        keyParam: "Join"),
    WidgetFilterModel(
        label: [
          "GlobalFilterTransporterLocation".tr,
          "GlobalLabelSearchCityHint".tr,
          "GlobalFilterTransporterLocation".tr
        ],
        typeInFilter: TypeInFilter.CITY,
        keyParam: "TransporterKota"),
    WidgetFilterModel(
        label: [
          "GlobalFilterServiceArea".tr,
          "GlobalFilterSearchServiceArea".tr,
          "GlobalFilterServiceArea".tr
        ],
        typeInFilter: TypeInFilter.CITY,
        keyParam: "AreaLayanan"),
    WidgetFilterModel(label: [
      "GlobalFilterTypeOfTransporter".tr,
      "GlobalFilterGoldenTransporter".tr
    ], typeInFilter: TypeInFilter.SWITCH, keyParam: "Gold")
  ];

  ContactPartnerModalSheetBottomController _contactModalBottomSheetController;

  @override
  void onInit() async {
    _contactModalBottomSheetController =
        Get.put(ContactPartnerModalSheetBottomController());
    await getHistory();
    listTransporter =
        ListDataDesignFunction(false, resultValueFunction: (result, index) {
      if (result != null) {
        change.addAll(result);
      }
    });
    _sortingController = Get.put(
        SortingController(
            listSort: transporterSort,
            onRefreshData: (map) {
              sort.clear();
              sort.addAll(map);
              refreshData();
            }),
        tag: "ListTransporter");

    _controllerFilter = Get.put(FilterCustomController(
        returnData: (map) {
          mapFilterData.clear();
          mapFilterData.addAll(map);
          // filterAreaLayanan.value = Map();
          // filterKota.value = Map();
          refreshData();
        },
        listWidgetInFilter: _listWidgetFilter));
    refreshData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void showFilter() {
    _controllerFilter.showFilter();
  }

  void showSort() {
    _sortingController.showSort();
  }

  void refreshData() async {
    // stopTimerGetMitra();
    loading.value = true;
    await doFilter(0);
    loading.value = false;
  }

  void loadData() {
    doFilter(listTransporterLength.value);
  }

  Future<void> doFilter(int offset) async {
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    var filterMap = Map.from(mapFilterData);
    if (filterMap.isNotEmpty && filterMap['Join'].isNotEmpty) filterMap['Join'] = "${filterMap['Join'].split(',')[0].split("-").reversed.toList().join("-")},${filterMap['Join'].split(',')[1].split("-").reversed.toList().join("-")}";
    var resultFilter =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchFilteredTransporter(
                filterSearch.value,
                filterMap.isEmpty ? null : filterMap,
                sort.value,
                limit,
                offset,
                shipperID);
    List<dynamic> data = resultFilter["Data"];
    var newListTransporter = List<Transporter>();
    data.forEach((element) {
      newListTransporter.add(Transporter.fromJson(element));
    });
    if (offset == 0) {
      listTransporterLength.value = 0;
      refreshTransporterController.resetNoData();
      refreshTransporterController.refreshCompleted();
      listTransporter.clearList();
    } else {
      refreshTransporterController.loadComplete();
    }
    if (newListTransporter.length < limit) {
      refreshTransporterController.loadNoData();
    }
    listTransporterLength.value += newListTransporter.length;
    listTransporter.addDataList(newListTransporter
        .map((e) => TransporterListDesignModel(
            transporterID: e.transporterID,
            transporterName: e.nama ?? "",
            isGoldTransporter: e.isGold ?? false,
            avatar: e.avatar ?? "",
            city: e.kota ?? "",
            address: e.alamat ?? "",
            serviceArea: e.areaLayanan.join(",") ?? "",
            yearFounded: e.tahunBerdiri ?? "",
            numberTruck: e.jumlahTruk ?? "",
            joinDate: e.joinDate ?? "",
            isAlreadyBecomePartner: e.isMitra ?? false))
        .toList());
  }

  void updateHistory() {
    if ((lastSearch.length + 1) > limitLastSearch) lastSearch.removeAt(0);
    lastSearch.add(searchBar.text);
    SharedPreferencesHelper.setHistoryTransporter(
        jsonEncode(List.from(lastSearch)));
  }

  void removeAllHistory() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "Peringatan",
        message: "Apakah anda yakin untuk menghapus semua pencarian terakhir?",
        labelButtonPriority1: "Cancel",
        labelButtonPriority2: "Yakin",
        onTapPriority2: () {
          lastSearch.clear();
          SharedPreferencesHelper.setHistoryTransporter("");
        });
  }

  void removeHistory(int index) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "Peringatan",
        message: "Apakah anda yakin untuk menghapus '${lastSearch[index]}'?",
        labelButtonPriority1: "Cancel",
        labelButtonPriority2: "Yakin",
        onTapPriority2: () {
          lastSearch.removeAt(index);
          SharedPreferencesHelper.setHistoryTransporter(
              jsonEncode(List.from(lastSearch)));
        });
  }

  Future<void> getHistory() async {
    try {
      var resultJson =
          jsonDecode(await SharedPreferencesHelper.getHistoryTransporter())
              as List;
      lastSearch.addAll(resultJson);
    } catch (err) {}
  }

  void showTransporterOption(int index) async {
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    var transporter = listTransporter.listData[index];
    getTransporterData(index);
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Container(
              width: MediaQuery.of(Get.context).size.width,
              color: Colors.transparent,
              child: Obx(
                () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 4,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 17),
                          child: Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 38,
                            height: GlobalVariable.ratioWidth(Get.context) * 3,
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorLightGrey16),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        4))),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 12,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: CustomText(
                                        "PartnerManagementLabelOption".tr,
                                        fontWeight: FontWeight.w700,
                                        color: Color(ListColor.color4),
                                        fontSize: 14),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
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
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          15,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          15,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      showModalBottom.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() => getStatusWidget(
                                    transporterStatus.value,
                                    transporter,
                                    shipperID)),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16),
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.5,
                                  color: Color(ListColor.colorStroke),
                                ),
                                itemOption(
                                    title: "Hubungi Transporter",
                                    onTap: () async {
                                      contactPartner(transporter.transporterID, transporter.userID);
                                    }),
                              ],
                            )
                          : Container(
                              padding: EdgeInsets.all(
                                  GlobalVariable.ratioWidth(Get.context) * 20),
                              alignment: Alignment.center,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 180,
                              child: CircularProgressIndicator()),
                    ]),
              ));
        });
  }

  void getTransporterData(int index) async {
    showModalBottom.value = false;
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    var transporter = listTransporter.listData[index];
    transporterStatus.value =
        await getStatusMitra(shipperID, transporter.transporterID);
    transporterContact = await getContact(transporter.transporterID);
    showModalBottom.value = true;
  }

  Future<String> getStatusMitra(String shipperID, String transporterID) async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchCheckStatusTransporterAsMitra(
                shipperID.toString(), transporterID);
    Map<dynamic, dynamic> responseStatus = response["Data"][0];
    return responseStatus["Status"].toString();
  }

  Widget getStatusWidget(
      String status, TransporterListDesignModel transporter, String shipperID) {
    switch (status) {
      case "0":
        return itemOption(
            title: "DetailTransporterLabelAddPartner".tr,
            onTap: () {
              addMitra(transporter.transporterName, transporter.transporterID, shipperID);
            });
        break;
      case "1":
        return itemOption(
            title: "DetailTransporterLabelBalasPermintaan".tr,
            onTap: () {
              approveRejectDialog(transporter, shipperID);
            });
        break;
      case "2":
        return itemOption(
            title: "DetailTransporterLabelBatalPermintaan".tr,
            onTap: () {
              cancelRequest(transporter, shipperID);
            });
        break;
      case "3":
        return itemOption(
            textColor: Color(ListColor.colorRed),
            title: "DetailTransporterLabelRemovePartner".tr,
            onTap: () {
              removeMitra(transporter, shipperID);
            });
        break;
    }
    return SizedBox.shrink();
  }

  Widget itemOption(
      {String title,
      String urlIcon = "",
      void Function() onTap,
      Color textColor = Colors.black}) {
    return InkWell(
        onTap: () {
          Get.back();
          onTap();
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: GlobalVariable.ratioWidth(Get.context) * 41,
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(title,
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
              urlIcon != ""
                  ? SvgPicture.asset(
                      urlIcon,
                      width: 30,
                      height: 30,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ));
  }

  void contactPartner(String transporterID, String userID) async {
    _contactModalBottomSheetController.showContact(
        userID,
        transporterID: transporterID);
  }

  Future<Map> getContact(String transporterID) async {
    ContactTransporterByShipperResponseModel response =
        await GetContactTransporterByShipper.getContact(transporterID);
    var contacts = response.contactDataJson;
    contacts.remove("Avatar");
    return contacts;
  }

  void addMitra(String transporterName, String transporterID, String shipperID) async {
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .requestAsPartner(shipperID, transporterID);
    var message = MessageFromUrlModel.fromJson(response['Message']);
    if (message.code == 200) {
      CustomToast.show(
          context: Get.context,
          // message: "DetailTransporterLabelHasBeenSent".tr);
          customMessage: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
            style: TextStyle(
              color: Colors.white,
              fontSize: GlobalVariable.ratioWidth(Get.context) * 12,
              height: 1.2
            ),
            children: [
              TextSpan(text: "ListTransporterLabelAddPartner".tr, style: TextStyle(fontWeight: FontWeight.w500)),
              TextSpan(text: "\n$transporterName", style: TextStyle(fontWeight: FontWeight.w700))
            ]
          )));
    } else {
      GlobalAlertDialog.showDialogError(
          message: response["Data"]["Message"],
          context: Get.context,
          isDismissible: false);
    }
  }

  void removeMitra(TransporterListDesignModel transporter, String shipperID) {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Peringatan",
      message: "DetailTransporterLabelRemoveQuestion".tr,
      customMessage: Container(
        margin: EdgeInsets.only(
            bottom: GlobalVariable.ratioWidth(Get.context) * 20),
        child: GlobalAlertDialog.getTextRichtWidget(
            "DetailTransporterLabelRemoveQuestion".tr,
            ":NAMA_TRANSPORTER",
            transporter.transporterName),
      ),
      context: Get.context,
      labelButtonPriority1: "Ya",
      labelButtonPriority2: "Tidak",
      onTapPriority1: () async {
        var shipperID = await SharedPreferencesHelper.getUserShipperID();
        var response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .removePartner("",
                    transporterID: transporter.transporterID,
                    shipperID: shipperID);
        var message = MessageFromUrlModel.fromJson(response['Message']);
        if (message.code == 200) {
          refreshTransporterController.requestRefresh();
          CustomToast.show(
              context: Get.context,
              message: "DetailTransporterLabelRemoveSuccess".tr);
        } else {
          GlobalAlertDialog.showAlertDialogCustom(
              title: "Error".tr,
              customMessage: Container(
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                child: GlobalAlertDialog.convertHTMLToText(message.code == 500
                    ? response['Data']['Message']
                    : message.text),
              ),
              context: Get.context,
              labelButtonPriority1: "OK",
              onTapPriority1: () {});
        }
      },
    );
  }

  void cancelRequest(
      TransporterListDesignModel transporter, String shipperID) async {
    GlobalAlertDialog.showAlertDialogCustom(
        title: "GlobalDialogCancelReqPartnerTitle".tr,
        customMessage: Container(
          margin: EdgeInsets.only(
              bottom: GlobalVariable.ratioWidth(Get.context) * 20),
          child: GlobalAlertDialog.getTextRichtWidget(
              "GlobalDialogCancelReqPartnerDesc".tr,
              ":NAMA_TRANSPORTER",
              transporter.transporterName),
        ),
        context: Get.context,
        onTapPriority1: () {},
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority2: () async {
          var shipperID = await SharedPreferencesHelper.getUserShipperID();
          var response =
              await ApiHelper(context: Get.context, isShowDialogLoading: true)
                  .fetchSetDataRequestCancelMitraByShipper("",
                      transporterID: transporter.transporterID,
                      shipperID: shipperID);
          var message = MessageFromUrlModel.fromJson(response['Message']);
          if (message.code == 200) {
            CustomToast.show(
                context: Get.context,
                message: "DetailTransporterLabelHasBeenCancelled".tr);
          } else {
            GlobalAlertDialog.showDialogError(
                message: response["Data"]["Message"],
                context: Get.context,
                isDismissible: false);
          }
        });
  }

  void approveRejectDialog(
      TransporterListDesignModel transporter, String shipperID) async {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Peringatan",
      message: "DetailTransporterLabelApproveRejectQuestion".tr,
      context: Get.context,
      labelButtonPriority1: "DetailTransporterLabelApprove".tr,
      labelButtonPriority2: "DetailTransporterLabelReject".tr,
      onTapPriority1: () {
        approveRejectMitra("1", transporter, shipperID);
      },
      onTapPriority2: () {
        approveRejectMitra("-1", transporter, shipperID);
      },
    );
  }

  void approveRejectMitra(String status, TransporterListDesignModel transporter,
      String shipperID) async {
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .fetchSetDataApproveRejectMitraByShipper("", status,
                transporterID: transporter.transporterID, shipperID: shipperID);
    var message = MessageFromUrlModel.fromJson(response['Message']);
    if (message.code == 200) {
      if (status == "1") refreshTransporterController.requestRefresh();
      CustomToast.show(
          context: Get.context,
          message: status == "1"
              ? "DetailTransporterLabelHasBeenApproved".tr
              : "DetailTransporterLabelHasBeenRejected".tr);
    } else {
      GlobalAlertDialog.showDialogError(
          message: response["Data"]["Message"],
          context: Get.context,
          isDismissible: false);
    }
  }
}
