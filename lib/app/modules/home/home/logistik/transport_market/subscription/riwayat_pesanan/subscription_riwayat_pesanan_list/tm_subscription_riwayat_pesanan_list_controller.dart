import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/api_tm_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_subscription_list_riwayat_pesanan_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search/tm_subscription_riwayat_pesanan_list_search_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TMSubscriptionRiwayatPesananListController extends GetxController {
  final posTab = 0.obs;
  RefreshController refreshControllerAP =
      RefreshController(initialRefresh: false);
  RefreshController refreshControllerCO =
      RefreshController(initialRefresh: false);
  RefreshController refreshControllerEP =
      RefreshController(initialRefresh: false);
  final listAP = <TMSubscriptionListRiwayatPesananModel>[].obs;
  final listCO = <TMSubscriptionListRiwayatPesananModel>[].obs;
  final listEP = <TMSubscriptionListRiwayatPesananModel>[].obs;
  var radioTypeAP = ''.obs;
  var radioTypeCO = ''.obs;
  var radioTypeEP = ''.obs;
  var tempRadioTypeAP = '';
  var tempRadioTypeCO = '';
  var tempRadioTypeEP = '';
  var radioDateAP = ''.obs;
  var radioDateCO = ''.obs;
  var radioDateEP = ''.obs;
  var tempRadioDateAP = '';
  var tempRadioDateCO = '';
  var tempRadioDateEP = '';
  var startDateAP = ''.obs;
  var endDateAP = ''.obs;
  var startDateCO = ''.obs;
  var endDateCO = ''.obs;
  var startDateEP = ''.obs;
  var endDateEP = ''.obs;
  var tempStartDateAP = '';
  var tempEndDateAP = '';
  var tempStartDateCO = '';
  var tempEndDateCO = '';
  var tempStartDateEP = '';
  var tempEndDateEP = '';

  var loadingAP = true.obs;
  var loadingCO = true.obs;
  var loadingEP = true.obs;

  var limitAP = 4;
  var limitCO = 4;
  var limitEP = 4;

  final filterDateAP = {}.obs;
  final filterDateCO = {}.obs;
  final filterDateEP = {}.obs;
  final filterDateTempAP = {}.obs;
  final filterDateTempCO = {}.obs;
  final filterDateTempEP = {}.obs;

  final filterTypeOfPackageAP = {}.obs;
  final filterTypeOfPackageCO = {}.obs;
  final filterTypeOfPackageEP = {}.obs;
  final filterTypeOfPackageTempAP = {}.obs;
  final filterTypeOfPackageTempCO = {}.obs;
  final filterTypeOfPackageTempEP = {}.obs;

  @override
  void onInit() async {
    refreshData(0);
    refreshData(1);
    refreshData(2);
  }

  onChangeTab(int pos) {
    if (posTab.value != pos) {
      posTab.value = pos;
    }
  }

  void refreshData(int posTab) async {
    try {
      if (posTab == 0) {
        loadingAP.value = true;
        await doFilter(0, posTab);
        loadingAP.value = false;
      } else if (posTab == 1) {
        loadingCO.value = true;
        await doFilter(0, posTab);
        loadingCO.value = false;
      } else {
        loadingEP.value = true;
        await doFilter(0, posTab);
        loadingEP.value = false;
      }
    } catch (e) {
      GlobalAlertDialog.showDialogError(
          message: e.toString(),
          context: Get.context,
          onTapPriority1: () {},
          labelButtonPriority1: "LoginLabelButtonCancel".tr);
    }
  }

  void loadData(int posTab) {
    if (posTab == 0) {
      doFilter(listAP.length, posTab);
    } else if (posTab == 1) {
      doFilter(listCO.length, posTab);
    } else {
      doFilter(listEP.length, posTab);
    }
  }

  bool compareDate(String startDate, String endDate) {
    var inputFormatStart = DateFormat('dd/MM/yyyy');
    var inputStart = inputFormatStart.parse(startDate);
    var inputFormatEnd = DateFormat('dd/MM/yyyy');
    var inputEnd = inputFormatEnd.parse(endDate);
    //hasil
    //false = valid startDate lebih kecil atau sama dengan endDate
    //true = not valid startDate lebih besar dari endDate
    return inputStart.isAfter(inputEnd);
  }

  String changeFormat(String date) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    var input = inputFormat.parse(date);
    var outputFormat = DateFormat('yyyy/MM/dd');
    var output = outputFormat.format(input);
    return output;
  }

  doFilter(int offset, int posTab) async {
    ///Type -1 = semua
    ///Type 0 = layanan
    ///Type 1 = sub user
    ///Status 0 = Pembayaran Kadaluarsa
    ///Status 1 = Pembayaran Diterima
    ///Status 2 = Pembayaran Dibatalkan

    if (posTab == 0) {
      var format = DateFormat('yyyy/MM/dd');
      var docDate = '';
      if (tempRadioDateAP == '1') {
        docDate = '';
      } else if (tempRadioDateAP == '2') {
        docDate = format.format((DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day - 30,
            ))) +
            "," +
            format.format(DateTime.now());
      } else if (tempRadioDateAP == '3') {
        docDate = format.format((DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day - 90,
            ))) +
            "," +
            format.format(DateTime.now());
      } else if (tempRadioDateAP == 'pilih') {
        docDate =
            changeFormat(tempStartDateAP) + "," + changeFormat(tempEndDateAP);
      } else {
        docDate = '';
      }
      Map<String, dynamic> filter = {
        "Type": tempRadioTypeAP.isEmpty ? -1 : int.parse(tempRadioTypeAP),
        "DocDate": docDate,
        "Status": 1
      };
      var body = {
        "Limit": limitAP.toString(),
        "Offset": offset.toString(),
        "filter": jsonEncode(filter)
      };

      var resultFilter;
      resultFilter = await ApiTMSubscription(
              context: Get.context, isShowDialogLoading: false)
          .getPacketSubscriptionHistoryByShipper(body);

      if (offset == 0) {
        refreshControllerAP.resetNoData();
        refreshControllerAP.refreshCompleted();
        listAP.clear();
      } else {
        refreshControllerAP.loadComplete();
      }
      List<dynamic> data = resultFilter["Data"];
      data.forEach((element) {
        listAP.add(TMSubscriptionListRiwayatPesananModel.fromJson(element));
      });

      if (data.length < limitAP) {
        refreshControllerAP.loadNoData();
      }
    } else if (posTab == 1) {
      var format = DateFormat('yyyy/MM/dd');
      var docDate = '';
      if (tempRadioDateCO == '1') {
        docDate = '';
      } else if (tempRadioDateCO == '2') {
        docDate = format.format((DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day - 30,
            ))) +
            "," +
            format.format(DateTime.now());
      } else if (tempRadioDateCO == '3') {
        docDate = format.format((DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day - 90,
            ))) +
            "," +
            format.format(DateTime.now());
      } else if (tempRadioDateCO == 'pilih') {
        docDate =
            changeFormat(tempStartDateCO) + "," + changeFormat(tempEndDateCO);
      } else {
        docDate = '';
      }
      Map<String, dynamic> filter = {
        "Type": tempRadioTypeCO.isEmpty ? -1 : int.parse(tempRadioTypeCO),
        "DocDate": docDate,
        "Status": 2
      };
      var body = {
        "Limit": limitCO.toString(),
        "Offset": offset.toString(),
        "filter": jsonEncode(filter)
      };

      var resultFilter;
      resultFilter = await ApiTMSubscription(
              context: Get.context, isShowDialogLoading: false)
          .getPacketSubscriptionHistoryByShipper(body);

      if (offset == 0) {
        refreshControllerCO.resetNoData();
        refreshControllerCO.refreshCompleted();
        listCO.clear();
      } else {
        refreshControllerCO.loadComplete();
      }
      List<dynamic> data = resultFilter["Data"];
      data.forEach((element) {
        listCO.add(TMSubscriptionListRiwayatPesananModel.fromJson(element));
      });

      if (data.length < limitCO) {
        refreshControllerCO.loadNoData();
      }
    } else {
      var format = DateFormat('yyyy/MM/dd');
      var docDate = '';
      if (tempRadioDateEP == '1') {
        docDate = '';
      } else if (tempRadioDateEP == '2') {
        docDate = format.format((DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day - 30,
            ))) +
            "," +
            format.format(DateTime.now());
      } else if (tempRadioDateEP == '3') {
        docDate = format.format((DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day - 90,
            ))) +
            "," +
            format.format(DateTime.now());
      } else if (tempRadioDateEP == 'pilih') {
        docDate =
            changeFormat(tempStartDateEP) + "," + changeFormat(tempEndDateEP);
      } else {
        docDate = '';
      }
      Map<String, dynamic> filter = {
        "Type": tempRadioTypeEP.isEmpty ? -1 : int.parse(tempRadioTypeEP),
        "DocDate": docDate,
        "Status": 0
      };
      var body = {
        "Limit": limitEP.toString(),
        "Offset": offset.toString(),
        "filter": jsonEncode(filter)
      };

      var resultFilter;
      resultFilter = await ApiTMSubscription(
              context: Get.context, isShowDialogLoading: false)
          .getPacketSubscriptionHistoryByShipper(body);

      if (offset == 0) {
        refreshControllerEP.resetNoData();
        refreshControllerEP.refreshCompleted();
        listEP.clear();
      } else {
        refreshControllerEP.loadComplete();
      }
      List<dynamic> data = resultFilter["Data"];
      data.forEach((element) {
        listEP.add(TMSubscriptionListRiwayatPesananModel.fromJson(element));
      });

      if (data.length < limitEP) {
        refreshControllerEP.loadNoData();
      }
    }
  }

  onClickDateFilterAP() {
    showFilters(_listContentFilterDate(radioDateAP, startDateAP, endDateAP),
        onPop: () {
      radioDateAP.value = tempRadioDateAP;
      startDateAP.value = tempStartDateAP;
      endDateAP.value = tempEndDateAP;
    }, onSubmit: () {
      tempRadioDateAP = radioDateAP.value;
      tempStartDateAP = startDateAP.value;
      tempEndDateAP = endDateAP.value;
      if (tempRadioDateAP == 'pilih') {
        if (tempStartDateAP.isNotEmpty && tempEndDateAP.isNotEmpty) {
          if (compareDate(tempStartDateAP, tempEndDateAP)) {
            tempRadioDateAP = '';
            CustomToast.show(
                context: Get.context, message: "Tanggal tidak valid");
          } else {
            refreshData(0);
          }
        } else {
          tempRadioDateAP = '';
          CustomToast.show(
              context: Get.context, message: "Tanggal tidak valid");
        }
      } else {
        refreshData(0);
      }
    }, tipe: 'date');
  }

  onClickDateFilterCO() {
    showFilters(_listContentFilterDate(radioDateCO, startDateCO, endDateCO),
        onPop: () {
      radioDateCO.value = tempRadioDateCO;
      startDateCO.value = tempStartDateCO;
      endDateCO.value = tempEndDateCO;
    }, onSubmit: () {
      tempRadioDateCO = radioDateCO.value;
      tempStartDateCO = startDateCO.value;
      tempEndDateCO = endDateCO.value;
      if (tempRadioDateCO == 'pilih') {
        if (tempStartDateCO.isNotEmpty && tempEndDateCO.isNotEmpty) {
          if (compareDate(tempStartDateCO, tempEndDateCO)) {
            tempRadioDateCO = '';
            CustomToast.show(
                context: Get.context, message: "Tanggal tidak valid");
          } else {
            refreshData(1);
          }
        } else {
          tempRadioDateCO = '';
          CustomToast.show(
              context: Get.context, message: "tanggal tidak valid");
        }
      } else {
        refreshData(1);
      }
    }, tipe: 'date');
  }

  onClickDateFilterEP() {
    showFilters(_listContentFilterDate(radioDateEP, startDateEP, endDateEP),
        onPop: () {
      radioDateEP.value = tempRadioDateEP;
      startDateEP.value = tempStartDateEP;
      endDateEP.value = tempEndDateEP;
    }, onSubmit: () {
      tempRadioDateEP = radioDateEP.value;
      tempStartDateEP = startDateEP.value;
      tempEndDateEP = endDateEP.value;
      if (tempRadioDateEP == 'pilih') {
        if (tempStartDateEP.isNotEmpty && tempEndDateEP.isNotEmpty) {
          if (compareDate(tempStartDateEP, tempEndDateEP)) {
            tempRadioDateEP = '';
            CustomToast.show(
                context: Get.context, message: "Tanggal tidak valid");
          } else {
            refreshData(2);
          }
        } else {
          tempRadioDateEP = '';
          CustomToast.show(
              context: Get.context, message: "tanggal tidak valid");
        }
      } else {
        refreshData(2);
      }
    }, tipe: 'date');
  }

  onClickTypeOfPackageFilterAP() {
    showFilters(
        _listContentFilterTypeOfPackage(
          radioTypeAP,
        ), onPop: () {
      radioTypeAP.value = tempRadioTypeAP;
    }, onSubmit: () {
      tempRadioTypeAP = radioTypeAP.value;
      refreshData(0);
    }, tipe: 'paket');
  }

  onClickTypeOfPackageFilterCO() {
    showFilters(
        _listContentFilterTypeOfPackage(
          radioTypeCO,
        ), onPop: () {
      radioTypeCO.value = tempRadioTypeCO;
    }, onSubmit: () {
      tempRadioTypeCO = radioTypeCO.value;
      refreshData(1);
    }, tipe: 'paket');
  }

  onClickTypeOfPackageFilterEP() {
    showFilters(
        _listContentFilterTypeOfPackage(
          radioTypeEP,
        ), onPop: () {
      radioTypeEP.value = tempRadioTypeEP;
    }, onSubmit: () {
      tempRadioTypeEP = radioTypeEP.value;
      refreshData(2);
    }, tipe: 'paket');
  }

  Widget _listContentFilterTypeOfPackage(RxString radioGrup) {
    return Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
          _perItemFilter('SubscriptionAllPackageTypes'.tr, radioGrup, "-1"),
          _perItemFilter('SubscriptionService'.tr, radioGrup, "0"),
          _perItemFilter('SubscriptionSubUser'.tr, radioGrup, "1",
              isShowSeparator: false),
        ]));
  }

  Widget _listContentFilterDate(
    RxString radioGrup,
    RxString startDate,
    RxString endDate,
  ) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _perItemFilter('SubscriptionDateFilter1'.tr, radioGrup, "1"),
          _perItemFilter('SubscriptionDateFilter2'.tr, radioGrup, "2"),
          _perItemFilter('SubscriptionDateFilter3'.tr, radioGrup, "3"),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _perItemFilter('SubscriptionDateFilter4'.tr, radioGrup, "pilih",
                  isShowSeparator: false),
              radioGrup.value == 'pilih'
                  ? Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                DateTime startDateTime = startDate.value == ''
                                    ? null
                                    : DateFormat("dd/MM/yyyy")
                                        .parse(startDate.value);
                                var result = await datePicker(
                                  initialDate: startDateTime,
                                  // startDate: startDateTime, 
                                  endDate: endDate.value == '' ? null : DateFormat("dd/MM/yyyy")
                                        .parse(endDate.value),
                                );
                                if (result != null) {
                                  final format = DateFormat("dd/MM/yyyy");
                                  startDate.value = format.format(result);  
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color(ListColor.colorLightGrey10),
                                        width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color(ListColor.colorLightGrey3)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          startDate.value.isEmpty
                                              ? "SubscriptionLabelDMY".tr
                                              : startDate.value,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey4),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        "assets/calendar_icon.svg",
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 19),
                            child: CustomText(
                              "s/d",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey4),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                DateTime endDateTime = endDate.value == ''
                                    ? null
                                    : DateFormat("dd/MM/yyyy")
                                        .parse(endDate.value);
                                var result = await datePicker(
                                  initialDate: endDateTime,
                                  startDate: startDate.value == '' ? null : DateFormat("dd/MM/yyyy")
                                        .parse(startDate.value),
                                  // endDate: endDateTime,
                                );
                                if (result != null) {
                                  final format = DateFormat("dd/MM/yyyy");
                                  endDate.value = format.format(result);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color(ListColor.colorLightGrey10),
                                        width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color(ListColor.colorLightGrey3)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        endDate.value.isEmpty
                                            ? "SubscriptionLabelDMY".tr
                                            : endDate.value,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorLightGrey4),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/calendar_icon.svg",
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }

  ///[radioGrup] diisi dengan variabel yg sama untuk ganti radio button jika di pilih
  Widget _perItemFilter(
    String title,

    ///initial value
    RxString radioGrup,

    ///nilai statis value untuk mengaktifkan/nonaktifkan radio button
    String value, {
    bool isShowSeparator = true,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 40),
          // padding: EdgeInsets.symmetric(
          //     vertical: GlobalVariable.ratioWidth(Get.context) * 11.5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: CustomText(
                  title,
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              RadioButtonCustom(
                groupValue: radioGrup.value,
                value: value,
                onChanged: (value) {
                  radioGrup.value = value;
                },
                isWithShadow: true,
                toggleable: true,
                isDense: true,
                width: GlobalVariable.ratioWidth(Get.context) * 20,
                height: GlobalVariable.ratioWidth(Get.context) * 20,
              )
            ],
          ),
        ),
        isShowSeparator ? _separator() : SizedBox.shrink()
      ],
    );
  }

  Widget _separator() {
    return Container(
        height: 0.5,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey5).withOpacity(0.29));
  }

  void onClickSearch() {
    if (listAP.length > 0 ||
        listCO.length > 0 ||
        listEP.length > 0 ||
        tempRadioDateAP.isNotEmpty ||
        tempRadioDateCO.isNotEmpty ||
        tempRadioDateEP.isNotEmpty ||
        tempRadioTypeAP.isNotEmpty ||
        tempRadioTypeCO.isNotEmpty ||
        tempRadioTypeEP.isNotEmpty) {
      GetToPage.toNamed<TMSubscriptionRiwayatPesananListSearchController>(
          Routes.TM_SUBSCRIPTION_RIWAYAT_PESANAN_LIST_SEARCH,
          arguments: [""]);
    }
  }

  Future<DateTime> datePicker({
    DateTime initialDate, 
    DateTime startDate, 
    DateTime endDate,
  }) async {
    // mengatasi masalah error ketika dipilih end date dulu
    // sebelum startdate
    if (endDate != null && initialDate == null) {
      initialDate = endDate;
    }
    var selectedDate = await showDatePicker(
      context: Get.context,
      firstDate: startDate ?? DateTime(DateTime.now().year - 10),
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      lastDate: endDate ?? DateTime.now(),
      initialDate: initialDate ?? DateTime.now(),
    );
    return selectedDate;
  }

  Future showFilters(Widget listContent,
      {@required Function onPop,
      @required Function onSubmit,
      String tipe}) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              onPop();
              return Future.value(true);
            },
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(Get.context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: GlobalVariable.ratioHeight(Get.context) * 5),
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Color(ListColor.colorLightGrey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        )),
                    Container(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            left: GlobalVariable.ratioWidth(Get.context) * 20,
                            right: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom:
                                GlobalVariable.ratioWidth(Get.context) * 12),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: CustomText(
                                    tipe == "date"
                                        ? 'SubscriptionChooseDate'.tr
                                        : 'SubscriptionChoosePackageType'.tr,
                                    fontWeight: FontWeight.w700,
                                    color: Color(ListColor.color4),
                                    fontSize: 14)),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  onPop();
                                  Get.back();
                                },
                                child: Container(
                                  child: SvgPicture.asset(
                                    "assets/ic_close1,5.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            15,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            15,
                                    color: Color(ListColor.colorBlack),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 15),
                        child: listContent),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 32,
                          margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 20, bottom: GlobalVariable.ratioWidth(Get.context) * 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(ListColor.colorBlue),
                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 26),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 26),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 26),
                              onTap: () {
                                Get.back();
                                onSubmit();
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        54.5,
                                    GlobalVariable.ratioWidth(Get.context) * 10,
                                    GlobalVariable.ratioWidth(Get.context) *
                                        54.5,
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                                child: CustomText(
                                  "SubscriptionApply".tr,
                                  color: Color(ListColor.colorWhite),
                                  fontWeight: FontWeight.w600,
                                  withoutExtraPadding: true,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
