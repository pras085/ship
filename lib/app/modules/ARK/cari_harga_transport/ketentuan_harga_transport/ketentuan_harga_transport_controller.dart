import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/contact_partner_info_pra_tender_transporter_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/function/api/get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/checkbox_filter_model.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class KetentuanHargaTransportController extends GetxController
    with SingleGetTickerProviderMixin {
  var posTab = 0.obs;
  var isLoadingData = true.obs;
  var listUser = [].obs;
  var jumlahDataUser = 0.obs;
  var countDataUser = 1.obs;
  var firstTimeUser = true;
  Timer time;

  String tagUser = "0";

  var showFirstTime = true.obs;
  String filePath = "";
  var jenisTab = 'User'.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN User
  bool isFilter = false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK

  var sortByUser = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSortByUser = {}; //UNTUK DAPATKAN DATA MAP SORT User
  var sortTypeUser = ''.obs; //UNTUK URUTAN SORTNYA

  var search = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD

  RefreshController refreshUserController =
      RefreshController(initialRefresh: false);

  SortingController _sortingUserController;

  FilterCustomControllerArk _filterUserCustomController;

  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;
  List<DataListSortingModel> userSort = [];
  List<DataListSortingModel> historySort = [];
  Map<String, dynamic> dataDropdownPeranSubUser = {
    "BFShipper": {
      "text": "",
      "value": 0,
      "id": "2",
    },
    "TMShipper": {
      "text": "",
      "value": 0,
      "id": "2",
    }
  };
  bool isSubscribed = false;
  var hasSubUserRole = false.obs;
  var hasSubUserActive = false.obs;

  var listFilterUser = [].obs;
  String notes = "";
  String additionalNotes = "";
  @override
  void onInit() async {
    notes = Get.arguments[0];
    additionalNotes = Get.arguments[1];
    super.onInit();
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
}
