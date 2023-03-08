import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/models/carrier_truck_model.dart';
import 'package:muatmuat/app/core/models/head_truck_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_notifikasi_harga_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_edit_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_edit_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_view_search.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_widgets/ZO_notifikasi_harga_form_field.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaController extends GetxController {
  final isEditPage = false.obs;
  var id = Rx<int>(null);
  // final _response = Rx<ZoNotifikasiHargaResponseModel>(null);
  final notifications = <ZoNotifikasiHargaModel>[].obs;
  var isSearchLoading = false.obs;
  var isListLoading = false.obs;
  var isSaving = false.obs;
  var isUpdating = false.obs;
  var isDeleting = false.obs;
  var updatingIndex = 0.obs;
  var deletingIndex = 0.obs;
  var loginASval = "".obs;
  final _originalItems = <ZoNotifikasiHargaSearchPageModel>[].obs;
  final items = <ZoNotifikasiHargaSearchPageModel>[].obs;
  var pickup = Rx<String>(null);
  var destination = Rx<String>(null);
  var truck = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr.obs;
  var carrier = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr.obs;
  var transporter = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr.obs;
  var price = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr.obs;
  var notificationType = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr.obs;
  var searchQueryObs = ''.obs;
  var hintText = ''.obs;
  var showCreateForm = false.obs;
  var showList = true.obs;
  final startPriceController = TextEditingController();
  final endPriceController = TextEditingController();
  final errorText = Rx<String>(null);
  Timer debounce;
  var isSearchLocation = false.obs;

  Future<void> onViewRefresh() async {
    doInbetweenListLoading(() async => await _fetchNotifications());
  }

  Future<void> onViewSearchRefresh(
    Future<void> Function() callback,
  ) {
    doInbetweenSearchLoading(() async => await callback());
  }

  Future<bool> onSearchWillPop() async {
    searchQueryObs.value = '';
    searchQueryObs.refresh();
    items.clear();
    items.addAll(_originalItems);
    items.refresh();
    return true;
  }

  void onSearchSubmit(String query) {
    searchQueryObs.value = query;
  }

  void onSearchChanged(String query) async {
    searchQueryObs.value = query;

    if (isSearchLocation.isTrue) {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 300), () async {
        isSearchLoading.value = true;

        if (isSearchLocation.isTrue) {
          await _fetchLocations();
        }
        items.clear();

        if (searchQueryObs.isEmpty) {
          items.addAll(_originalItems);
        } else {
          var containsQuery = (ZoNotifikasiHargaSearchPageModel model) => model
              ?.value
              ?.trim()
              ?.toLowerCase()
              ?.contains(searchQueryObs.value.trim().toLowerCase());
          items.addAll(_originalItems.where(containsQuery) ?? []);
        }
        isSearchLoading.value = false;
      });
    } else {
      isSearchLoading.value = true;

      if (isSearchLocation.isTrue) {
        await _fetchLocations();
      }
      items.clear();

      if (searchQueryObs.isEmpty) {
        items.addAll(_originalItems);
      } else {
        var containsQuery = (ZoNotifikasiHargaSearchPageModel model) =>
            model?.value?.toLowerCase()?.contains(query.toLowerCase());
        items.addAll(_originalItems.where(containsQuery) ?? []);
      }
      isSearchLoading.value = false;
    }
  }

  initFields() {
    pickup.value = null;
    destination.value = null;
    truck.value = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr;
    carrier.value = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr;
    transporter.value = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr;
    price.value = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr;
    notificationType.value = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr;
  }

  String getPriceString(int minPrice, int maxPrice) {
    return '${formatCurrency(minPrice ?? 0)} - ${formatCurrency(maxPrice ?? 0)}';
  }

  String formatCurrency(int number) {
    if (number == null) return null;
    return "${NumberFormat('#,###').format(number).replaceAll(',', '.')}";
  }

  void initFieldsForEdit(ZoNotifikasiHargaModel data) {
    debugPrint('initFieldsForEdit: ${data?.toParams()}');
    showCreateForm.value = true;
    isEditPage.value = true;
    id.value = data.id;
    isEditPage.refresh();
    if (data != null) {
      final isAllPrice = data.minPrice == 0 && data.maxPrice == 0;
      final priceString = getPriceString(data.minPrice, data.maxPrice);

      String getValueOrDefault(String value) {
        final defaultValue = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr;

        if (value == null) return defaultValue;

        return value.toLowerCase().contains(defaultValue.toLowerCase())
            ? defaultValue
            : value;
      }

      startPriceController.text = formatThousand(data.minPrice) ?? '';
      endPriceController.text = formatThousand(data.maxPrice) ?? '';
      startPriceUnapplied = startPriceController.text;
      endPriceUnapplied = endPriceController.text;

      startPrice.value = formatThousand(data.minPrice) ?? '';
      endPrice.value = formatThousand(data.maxPrice) ?? '';

      pickup.value = data.pickup;
      destination.value = data.destination;
      truck.value = getValueOrDefault(data.headName);
      carrier.value = getValueOrDefault(data.carrierName);
      transporter.value = getValueOrDefault(data.transporterName);
      price.value = isAllPrice
          ? ZoNotifikasiHargaStrings.dropdownDefaultValue.tr
          : priceString;
      notificationType.value = getValueOrDefault(data.notificationType);
    }
  }

  void doInbetweenSearchLoading(Future<void> Function() callback) async {
    isSearchLoading.value = true;
    await callback?.call();
    isSearchLoading.value = false;
  }

  void doInbetweenSaving(Future<void> Function() callback) async {
    isSaving.value = true;
    await callback?.call();
    isSaving.value = false;
  }

  void doInbetweenUpdating(Future<void> Function() callback) async {
    isUpdating.value = true;
    await callback?.call();
    isUpdating.value = false;
  }

  void doInbetweenDeleting(Future<void> Function() callback) async {
    isDeleting.value = true;
    await callback?.call();
    isDeleting.value = false;
  }

  void doInbetweenListLoading(Future<void> Function() callback) async {
    isListLoading.value = true;
    await callback?.call();
    isListLoading.value = false;
  }

  void showMessage(String message) {
    CustomToast.show(
      context: Get.context,
      sizeRounded: GlobalVariable.ratioWidth(Get.context) * 6,
      message: message ?? '',
    );
  }

  Future<void> _fetchNotifications() async {
    try {
      await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      )
          .fetchPromoNotificationList(
        loginAS: loginASval.value,
        roleProfile: GlobalVariable.role,
      )
          .then((response) {
        if (response?.data != null) {
          notifications.clear();
          notifications.addAll(response?.data ?? []);
          notifications.refresh();
          if (notifications.isEmpty) {
            showCreateForm.value = true;
            showList.value = false;
          }
        } else {
          showMessage(
            ZoNotifikasiHargaStrings.failedGetList +
                '\n' +
                (response?.message?.text ?? "GlobalLabelErrorNullResponse").tr,
          );
        }
      }).onError((error, stackTrace) {
        debugPrint('$error, $stackTrace');
        showMessage(error.toString().tr);
      });
    } catch (e) {
      debugPrint(e.toString());
      showMessage(
        "GlobalLabelErrorNullResponse".tr,
      );
    }
  }

  @override
  void onClose() {
    startPriceController?.dispose();
    endPriceController?.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    if (isEditPage.isFalse) {
      doInbetweenListLoading(() async {
        var getUserShipperResponse = await ApiHelper(
          context: Get.context,
          isShowDialogLoading: false,
          isShowDialogError: false,
        ).getUserShiper(GlobalVariable.role);

        if (getUserShipperResponse["Message"]["Code"] == 200) {
          loginASval.value = getUserShipperResponse["LoginAs"].toString();
          await _fetchNotifications();
        }
      });
    }
    super.onInit();
  }

  void onFormExpansionTapped() {
    showCreateForm.value = !showCreateForm.value;
  }

  void onListExpansionTapped() {
    showList.value = !showList.value;
  }

  Future<void> _deleteNotification([int id]) async {
    try {
      await ApiHelper(
        context: Get.context,
        isShowDialogLoading: true,
        isShowDialogError: false,
      )
          .deleteNotification(
        id: id,
        loginAS: loginASval.value,
        roleProfile: GlobalVariable.role,
      )
          .then((response) {
        if (response?.message?.code != null && response.message.code == 200) {
          showMessage(
            ZoNotifikasiHargaStrings.successDelete.tr,
          );
        } else {
          showMessage(
            ZoNotifikasiHargaStrings.failedDelete.tr +
                '\n' +
                (response?.message?.text ?? "GlobalLabelErrorNullResponse").tr,
          );
        }
      }).onError((error, stackTrace) {
        debugPrint('$error, $stackTrace');
        showMessage(
          error.toString().tr,
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      showMessage(
        "GlobalLabelErrorNullResponse".tr,
      );
    }
  }

  Future<void> _createUpdateNotification([int id]) async {
    try {
      await ApiHelper(
        context: Get.context,
        isShowDialogLoading: true,
        isShowDialogError: false,
      )
          .createUpdateNotification(
        id: id,
        loginAS: loginASval.value,
        roleProfile: GlobalVariable.role,
        pickup: pickup.value,
        destination: destination.value,
        truck: truck.value,
        carrier: carrier.value,
        transporterName: transporter.value,
        priceRange: price.value,
        type: notificationType.value,
      )
          .then((response) {
        if (response?.message?.code != null && response.message.code == 200) {
          initFields();
          showMessage(
            id == null
                ? ZoNotifikasiHargaStrings.successSave.tr
                : ZoNotifikasiHargaStrings.successEdit.tr,
          );
          startPrice.value = '';
          endPrice.value = '';
          startPriceController.text = '';
          endPriceController.text = '';
          startPriceUnapplied = '';
          endPriceUnapplied = '';
          price.value = ZoNotifikasiHargaStrings.dropdownDefaultValue.tr;
        } else {
          showMessage(
            (id == null
                    ? ZoNotifikasiHargaStrings.failedSave.tr
                    : ZoNotifikasiHargaStrings.failedEdit.tr) +
                '\n' +
                (response?.message?.text ?? "GlobalLabelErrorNullResponse").tr,
          );
        }
      }).onError((error, stackTrace) {
        debugPrint('$error, $stackTrace');
        showMessage(
          error.toString().tr,
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      showMessage(
        "GlobalLabelErrorNullResponse".tr,
      );
    }
  }

  void onSaveNotification() {
    if (id.value == null) {
      doInbetweenSaving(() async {
        await _createUpdateNotification();
        showCreateForm.value = false;
        showList.value = true;
        doInbetweenListLoading(() async => await _fetchNotifications());
      });
    } else {
      doInbetweenUpdating(() async {
        await _createUpdateNotification(id.value);
        Get.back(result: true);
      });
    }
  }

  Future<bool> onWillPop() async {
    bool shouldPop = false;

    if (isEditPage.isTrue) {
      GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: ZoNotifikasiHargaStrings.confirmCancelTitle.tr,
        message: ZoNotifikasiHargaStrings.confirmCancelMessage.tr,
        isShowCloseButton: true,
        disableGetBack: true,
        labelButtonPriority1: ZoNotifikasiHargaStrings.labelNo.tr,
        labelButtonPriority2: ZoNotifikasiHargaStrings.labelYes.tr,
        onTapPriority1: () {
          shouldPop = false;
          Get.back();
        },
        onTapPriority2: () {
          shouldPop = true;
          Get.back();
          Get.back();
        },
      );
    } else {
      return true;
    }
  }

  void onEditNotification(int index, int id) {
    var shouldRefresh = false;
    GlobalAlertDialog.showAlertDialogCustom(
      context: Get.context,
      title: ZoNotifikasiHargaStrings.confirmEditTitle.tr,
      message: ZoNotifikasiHargaStrings.confirmEditMessage.tr,
      isShowCloseButton: true,
      disableGetBack: true,
      labelButtonPriority1: ZoNotifikasiHargaStrings.labelNo.tr,
      labelButtonPriority2: ZoNotifikasiHargaStrings.labelYes.tr,
      onTapPriority1: () {
        Get.back();
      },
      onTapPriority2: () async {
        updatingIndex.value = index;
        Get.back();
        shouldRefresh = await Get.to<bool>(
          () => ZoNotifikasiHargaEditView(),
          binding: ZoNotifikasiHargaEditBinding(),
          arguments: notifications[index].toParams(),
        );
        if (shouldRefresh ?? false) {
          showCreateForm.value = false;
          showList.value = true;
          doInbetweenListLoading(() async => await _fetchNotifications());
        }
      },
    );
  }

  void onDeleteNotification(int index, int id) {
    GlobalAlertDialog.showAlertDialogCustom(
      context: Get.context,
      title: ZoNotifikasiHargaStrings.confirmDeleteTitle.tr,
      message: ZoNotifikasiHargaStrings.confirmDeleteMessage.tr,
      isShowCloseButton: true,
      disableGetBack: true,
      labelButtonPriority1: ZoNotifikasiHargaStrings.labelNo.tr,
      labelButtonPriority2: ZoNotifikasiHargaStrings.labelYes.tr,
      onTapPriority1: () {
        Get.back();
      },
      onTapPriority2: () {
        deletingIndex.value = index;
        Get.back();
        doInbetweenDeleting(() async {
          await _deleteNotification(id);
          showCreateForm.value = false;
          showList.value = true;
          doInbetweenListLoading(() async => await _fetchNotifications());
        });
      },
    );
  }

  void _moveToSearchPageAndDo({
    Future<void> Function() callback,
    void Function(String result) onResult,
  }) async {
    items.clear();
    doInbetweenSearchLoading(callback);

    var result = await Navigator.of(Get.context).push(
      MaterialPageRoute(
        builder: (_) {
          return ZoNotifikasiHargaViewSearch(
            controller: this,
            refreshCallback: callback,
          );
        },
      ),
    );
    searchQueryObs.value = '';

    onResult?.call(result);
  }

  void onPickupTap() async {
    isSearchLocation.value = true;
    hintText.value = ZoNotifikasiHargaStrings.pickupHint.tr;
    _moveToSearchPageAndDo(
      callback: _fetchLocations,
      onResult: (String result) {
        pickup.value = result ?? pickup.value;
      },
    );
  }

  void onDestinationTap() async {
    isSearchLocation.value = true;
    hintText.value = ZoNotifikasiHargaStrings.destinationHint.tr;
    _moveToSearchPageAndDo(
      callback: _fetchLocations,
      onResult: (String result) {
        destination.value = result ?? destination.value;
      },
    );
  }

  void onTruckTap() async {
    isSearchLocation.value = false;
    hintText.value = ZoNotifikasiHargaStrings.truckHint.tr;
    _moveToSearchPageAndDo(
      callback: _fetchHeadTruck,
      onResult: (String result) {
        truck.value = result ?? truck.value;
      },
    );
  }

  void onCarrierTap() async {
    isSearchLocation.value = false;
    hintText.value = ZoNotifikasiHargaStrings.carrierHint.tr;
    _moveToSearchPageAndDo(
      callback: _fetchCarrierTruck,
      onResult: (String result) {
        carrier.value = result ?? carrier.value;
      },
    );
  }

  var startPrice = ''.obs;
  var endPrice = ''.obs;

  void onTransporterTap() async {
    isSearchLocation.value = false;
    hintText.value = ZoNotifikasiHargaStrings.transporterHint.tr;
    _moveToSearchPageAndDo(
      callback: _fetchTransporter,
      onResult: (String result) {
        transporter.value = result ?? transporter.value;
      },
    );
  }

  var isSavedOnce = false.obs;
  var startPriceUnapplied = '';
  var endPriceUnapplied = '';

  void onStartPriceChanged(String value) {
    final offset = startPriceController.value.selection.baseOffset;
    if (startPriceController.text.isEmpty) {
      startPrice.value = '';
      errorText.value = null;
    } else {
      int start =
          int.tryParse(startPriceController.text.replaceAll('.', '')) ?? -1;
      int end = int.tryParse(endPriceController.text.replaceAll('.', '')) ?? -1;

      debugPrint('tff-startEC: $start');
      if (start <= 1000000000) {
        startPrice.value = formatThousand(start);
        if (start != -1 && end != -1 && start > end) {
          errorText.value =
              'Harga minimum tidak boleh lebih dari harga maksimum'.tr;
        } else {
          errorText.value = null;
        }
      }
    }
    startPriceController.text = startPrice.value;
    startPriceController.selection = TextSelection.collapsed(
      offset: math.max(0, math.min(offset, startPrice?.value?.length ?? 0)),
    );
    debugPrint('tff-abc:${startPriceController.text}');
  }

  String formatThousand(int number) {
    if (number == null) return null;
    return "${NumberFormat('#,###').format(number).replaceAll(',', '.')}";
  }

  void onEndPriceChanged(String value) {
    final offset = endPriceController.value.selection.baseOffset;
    if (endPriceController.text.isEmpty) {
      endPrice.value = '';
      errorText.value = null;
    } else {
      int start =
          int.tryParse(startPriceController.text.replaceAll('.', '')) ?? -1;
      int end = int.tryParse(endPriceController.text.replaceAll('.', '')) ?? -1;
      debugPrint('tff-endEC: $end');
      if (end <= 1000000000) {
        endPrice.value = formatThousand(end);
        if (start != -1 && end != -1 && start > end) {
          errorText.value =
              'Harga minimum tidak boleh lebih dari harga maksimum'.tr;
        } else {
          errorText.value = null;
        }
      }
    }
    endPriceController.text = endPrice.value;
    endPriceController.selection = TextSelection.collapsed(
      offset: math.max(0, math.min(offset, endPrice?.value?.length ?? 0)),
    );
    debugPrint('tff-abc:${endPriceController.text}');
  }

  void onPriceChanged(String value) async {
    if (value == ZoNotifikasiHargaStrings.dropdownDefaultValue.tr) {
      price.value = value;
    } else {
      final textStyle = TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 16.8 / 14,
      );
      Widget buildTextWidget(String text) {
        return CustomText(
          text,
          color: textStyle.color,
          fontSize: textStyle.fontSize,
          fontWeight: textStyle.fontWeight,
          height: textStyle.height,
        );
      }

      Widget buildTextFieldWidget(
        TextEditingController controller, {
        String hint,
        String errorText,
        void Function(String) onChanged,
      }) {
        debugPrint('tff-${controller.text}');
        return CustomTextFormField(
          context: Get.context,
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            // LengthLimitingTextInputFormatter(10),
            ThousanSeparatorFormater(),
          ],
          newInputDecoration: InputDecoration(
            hintText: hint,
            hintStyle: textStyle.copyWith(
              color: Color(ListColor.colorLightGrey2),
            ),
            border: ZoNotifikasiHargaFormField.getBorder(
                Color(ListColor.colorLightGrey19)),
            focusedBorder: ZoNotifikasiHargaFormField.getBorder(
                Color(ListColor.colorBlue)),
            enabledBorder: ZoNotifikasiHargaFormField.getBorder(
                Color(ListColor.colorLightGrey19)),
            disabledBorder: ZoNotifikasiHargaFormField.getBorder(
                Color(ListColor.colorLightGrey19)),
            contentPadding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            ),
            errorText: errorText,
          ),
          style: textStyle,
        );
      }

      var priceRangeFilled = false;

      Widget buildButton([void Function() onTap]) {
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Color(
                onTap == null ? ListColor.colorLightGrey2 : ListColor.color4),
            side: BorderSide(
                width: 2,
                color: Color(onTap == null
                    ? ListColor.colorLightGrey2
                    : ListColor.color4)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          onPressed: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Stack(alignment: Alignment.center, children: [
              CustomText(
                ZoNotifikasiHargaStrings.saveLabel.tr,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ]),
          ),
        );
      }

      isSavedOnce.value = false;

      final saved = await showDialog<bool>(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            // key: _keyDialog,
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(context) * 24,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: CustomText(
                      ZoNotifikasiHargaStrings.priceDialogTitle.tr,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(context) * 3,
                        top: GlobalVariable.ratioWidth(context) * 3,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.back(result: false);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.close_rounded,
                            color: Color(ListColor.color4),
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 20,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(context) * 15,
                    right: GlobalVariable.ratioWidth(context) * 15,
                    bottom: GlobalVariable.ratioWidth(context) * 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: buildTextFieldWidget(
                              startPriceController,
                              hint: ZoNotifikasiHargaStrings.hintMin.tr,
                              onChanged: onStartPriceChanged,
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 4,
                          ),
                          buildTextWidget(
                            ZoNotifikasiHargaStrings.priceDialogSeparator.tr,
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 4,
                          ),
                          Expanded(
                            child: buildTextFieldWidget(
                              endPriceController,
                              hint: ZoNotifikasiHargaStrings.hintMax.tr,
                              onChanged: onEndPriceChanged,
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => isSavedOnce.isFalse || errorText.value == null
                            ? SizedBox.shrink()
                            : CustomText(
                                errorText.value,
                                color: Color(ListColor.colorRed),
                                fontSize: 12,
                              ),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(context) * 25,
                          right: GlobalVariable.ratioWidth(context) * 25,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => buildButton(
                                startPrice.value.trim().isEmpty ||
                                        endPrice.value.trim().isEmpty ||
                                        (isSavedOnce.isTrue &&
                                            errorText.value != null)
                                    ? null
                                    : () {
                                        isSavedOnce.value = true;
                                        if (errorText.value == null) {
                                          Get.back(result: true);
                                        }
                                      },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      );
      if (saved ?? false) {
        price.value =
            '${startPriceController.text} - ${endPriceController.text}';
        startPriceUnapplied = startPriceController.text;
        endPriceUnapplied = endPriceController.text;
      } else {
        startPriceController.text = startPriceUnapplied;
        endPriceController.text = endPriceUnapplied;
        startPrice.value = startPriceUnapplied;
        endPrice.value = endPriceUnapplied;
        onStartPriceChanged(startPriceUnapplied);
        onEndPriceChanged(endPriceUnapplied);
      }
    }
  }

  void onNotificationTypeChanged(String value) {
    notificationType.value = value;
  }

  void onPickupChanged(String value) {
    pickup.value = value;
  }

  void onDestionationChanged(String value) {
    destination.value = value;
  }

  void onTruckChanged(String value) {
    truck.value = value;
  }

  void onCarrierChanged(String value) {
    carrier.value = value;
  }

  void onTransporterChanged(String value) {
    transporter.value = value;
  }

  Future<void> _fetchLocations() async {
    try {
      await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      ).fetchRegionByCity(searchQueryObs.value).then((regionByCityList) {
        if (regionByCityList != null) {
          final searchModelList = regionByCityList
              .map(
                (e) => ZoNotifikasiHargaSearchPageModel.fromRegionByCity(e),
              )
              .toList();
          searchModelList.sort((a, b) {
            var first = a.valueForSort;
            var second = b.valueForSort;

            if (first == null || second == null) {
              first = a.value;
              second = b.value;
            }
            return first == null
                ? 1
                : second == null
                    ? -1
                    : first.compareTo(second);
          });
          items.clear();
          _originalItems.clear();
          items.addAll(searchModelList);
          _originalItems.addAll(searchModelList);
          items.refresh();
          _originalItems.refresh();
        }
      }).onError((error, stackTrace) {
        debugPrint('$error, $stackTrace');
        showMessage(
          error.toString().tr,
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      showMessage(
        "GlobalLabelErrorNullResponse".tr,
      );
    }
  }

  Future<void> _fetchHeadTruck() async {
    try {
      await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      ).fetchHeadTruckForPriceNotification().then((headTruckList) {
        if (headTruckList != null) {
          final searchModelList = (headTruckList
                ..insert(
                  0,
                  HeadTruckModel(
                    description:
                        ZoNotifikasiHargaStrings.dropdownDefaultValue.tr,
                  ),
                ))
              .map(
                (e) => ZoNotifikasiHargaSearchPageModel.fromHeadTruck(e),
              )
              .toList();
          items.clear();
          _originalItems.clear();
          items.addAll(searchModelList);
          _originalItems.addAll(searchModelList);
          items.refresh();
          _originalItems.refresh();
        }
      }).onError((error, stackTrace) {
        debugPrint('$error, $stackTrace');
        showMessage(
          error.toString().tr,
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      showMessage(
        "GlobalLabelErrorNullResponse".tr,
      );
    }
  }

  Future<void> _fetchCarrierTruck() async {
    try {
      await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      ).fetchCarrierTruckForPriceNotification().then((carrierTruckList) {
        if (carrierTruckList != null) {
          final searchModelList = (carrierTruckList
                ..insert(
                  0,
                  CarrierTruckModel(
                    description:
                        ZoNotifikasiHargaStrings.dropdownDefaultValue.tr,
                  ),
                ))
              .map(
                (e) => ZoNotifikasiHargaSearchPageModel.fromCarrierTruck(e),
              )
              .toList();
          items.clear();
          _originalItems.clear();
          items.addAll(searchModelList);
          _originalItems.addAll(searchModelList);
          items.refresh();
          _originalItems.refresh();
        }
      }).onError((error, stackTrace) {
        debugPrint('$error, $stackTrace');
        showMessage(
          error.toString().tr,
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      showMessage(
        "GlobalLabelErrorNullResponse".tr,
      );
    }
  }

  Future<void> _fetchTransporter() async {
    try {
      await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      )
          .fetchTransporterListFree(
        query: searchQueryObs.value,
        limit: null,
        offset: 0,
      )
          .then((transporterListFree) {
        if (transporterListFree != null) {
          final searchModelList = (transporterListFree
                ..insert(
                    0,
                    ZoTransporterFreeModel(
                      name: ZoNotifikasiHargaStrings.dropdownDefaultValue.tr,
                    )))
              .map(
                (e) => ZoNotifikasiHargaSearchPageModel.fromTransporterFree(e),
              )
              .toList();
          items.clear();
          _originalItems.clear();
          items.addAll(searchModelList);
          _originalItems.addAll(searchModelList);
          items.refresh();
          _originalItems.refresh();
        }
      }).onError((error, stackTrace) {
        debugPrint('$error, $stackTrace');
        showMessage(
          error.toString().tr,
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      showMessage(
        "GlobalLabelErrorNullResponse".tr,
      );
    }
  }
}
