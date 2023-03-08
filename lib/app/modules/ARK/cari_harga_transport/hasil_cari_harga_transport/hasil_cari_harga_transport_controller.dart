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
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_ark_contact_partner_modal_sheet_bottom_controller.dart';
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
import 'package:muatmuat/app/core/models/radio_button_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_manajemen_user/search_manajemen_user_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_manajemen_user/create_manajemen_user_controller.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/ketentuan_harga_transport/ketentuan_harga_transport_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/manajemen_user_bagi_peran/manajemen_user_bagi_peran_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_manajemen_user/search_manajemen_user_controller.dart';
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

class HasilCariHargaTransportController extends GetxController
    with SingleGetTickerProviderMixin {
  var posTab = 0.obs;
  var isLoadingData = true.obs;
  var listTransporter = [].obs;
  var jumlahDataUser = 0.obs;
  var countDataUser = 1.obs;
  var firstTimeUser = true;
  Timer time;

  String tagUser = "0";

  var showFirstTime = true.obs;
  String filePath = "";
  var jenisTab = 'User'.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN User
  var isFilter = false.obs; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK

  var sortByUser = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSortByUser = {}; //UNTUK DAPATKAN DATA MAP SORT User
  var sortTypeUser = ''.obs; //UNTUK URUTAN SORTNYA

  var search = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD

  RefreshController refreshUserController =
      RefreshController(initialRefresh: false);

  SortingController _sortingUserController;

  FilterCustomControllerArk _filterUserCustomController;
  CustomARKContactPartnerModalSheetBottomController
      _contactModalBottomSheetController;

  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;
  var multiSort = "false".obs;
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
  var jumlahTruk = 0.0.obs;
  var jumlahHarga = 0.0.obs;

  var listFilterUser = [].obs;
  var listBadge = [].obs;

  var selectedPickup = {
    "ID": "",
    "Text": "",
    "District": "",
    "City": "",
    "DistrictID": "",
    "CityID": "",
  }.obs;
  var selectedDestinasi = {
    "ID": "",
    "Text": "",
    "District": "",
    "City": "",
    "DistrictID": "",
    "CityID": "",
  }.obs;
  var selectedJenisTruk = {
    "ID": 0,
    "Text": "",
  }.obs;
  var selectedJenisCarrier = {
    "ID": 0,
    "Text": "",
  }.obs;
  var selectedNamaTransport = {
    "ID": 0,
    "Text": "",
  }.obs;
  var checkboxPromo = false.obs;
  var checkboxGoldTransporter = false.obs;
  var checkboxRegularTransporter = false.obs;
  var checkboxJumlahArmada =
      {"1-50": false, "51-100": false, "101-300": false, "300+": false}.obs;

  var cekHubungiTransporter = false.obs;
  var cekProfilTransporter = false.obs;
  var cekKetentuanHarga = false.obs;

  @override
  void onInit() async {
    cekHubungiTransporter.value =
        await SharedPreferencesHelper.getHakAkses("Hubungi Transporter");

    cekProfilTransporter.value =
        await SharedPreferencesHelper.getHakAkses("Profil Transporter");

    cekKetentuanHarga.value =
        await SharedPreferencesHelper.getHakAkses("Ketentuan");

    print("reset filter");
    selectedPickup.value = Get.arguments[0];
    selectedDestinasi.value = Get.arguments[1];
    selectedJenisTruk.value = Get.arguments[2];
    selectedJenisCarrier.value = Get.arguments[3];
    selectedNamaTransport.value = Get.arguments[4];
    checkboxPromo.value = Get.arguments[5];
    checkboxGoldTransporter.value = Get.arguments[6];
    checkboxRegularTransporter.value = Get.arguments[7];
    checkboxJumlahArmada.value = Get.arguments[8];

    _contactModalBottomSheetController =
        Get.put(CustomARKContactPartnerModalSheetBottomController());

    getBadgeList();
    try {
      Get.delete<FilterCustomControllerArk>(tag: "");
    } catch (e) {
      print(e);
    }

    userSort = [
      DataListSortingModel(
          'CariHargaTransportIndexRekomendasi'.tr,
          'transporter_name',
          'CariHargaTransportIndexYa'.tr,
          'CariHargaTransportIndexTidak'.tr,
          ''.obs),
      DataListSortingModel(
          'CariHargaTransportIndexNamaTransporter'.tr,
          'transporter_name',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'CariHargaTransportIndexKapasitas'.tr,
          'min_capacity',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'CariHargaTransportIndexJenisTruk/Carrier'.tr,
          'head_id',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'CariHargaTransportIndexJumlahTruk'.tr,
          'truck_qty',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'CariHargaTransportIndexHargaTransport'.tr,
          'price_per_unit',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    _sortingUserController = Get.put(
        SortingController(
            listSort: userSort,
            initMap: mapSortByUser,
            onRefreshData: (map) async {
              countDataUser.value = 1;
              print('User');
              listTransporter.clear();
              //SET ULANG
              sortByUser.value = "";
              sortTypeUser.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortByUser.value += element;
                if (index < map.keys.length) {
                  sortByUser.value += ",";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortTypeUser.value += element;
                if (index < map.values.length) {
                  sortTypeUser.value += ",";
                }
              });

              if (index > 1) {
                multiSort.value = "true";
              } else {
                multiSort.value = "false";
              }

              mapSortByUser = map;

              print('NEW MAPS');
              print(map);

              isLoadingData.value = true;

              print(isLoadingData);
              print(firstTimeUser);
              await getListTransporter(1, filter);
            }),
        tag: tagUser);

    // await getDropdownPeranSubUser();
    await getListTransporter(1, filter);

    isLoadingData.value = false;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  Future<Map> getContact(String transporterID) async {
    ContactTransporterByShipperResponseModel response =
        await GetContactTransporterByShipper.getContact(transporterID);
    var contacts = response.contactDataJson;
    contacts.remove("Avatar");
    return contacts;
  }

  void contactPartner(String transporterid) async {
    _contactModalBottomSheetController.showContact(
      transporterID: transporterid,
      contactDataParam: null,
    );
  }

  void hubungi(String idtransporter) {
    contactPartner(idtransporter);
  }

  void showSortingDialog() async {
    print("MAP SORT User");
    print(mapSortByUser);

    if (jenisTab.value == "User") {
      _sortingUserController.showSort();
      print('User');
    }
  }

  void _clearSorting() {
    if (jenisTab.value == "User") {
      _sortingUserController.clearSorting();
      print('User');
    }
  }

  void showFilter() async {
    _filterUserCustomController.updateListFilterModel(
      4,
      WidgetFilterModel(
          label: ['CariHargaTransportIndexJumlahTruk'.tr],
          typeInFilter: TypeInFilter.UNIT,
          customValue: [0.0, jumlahTruk.value],
          keyParam: 'jumlah_truk',
          isSeparateParameter: true,
          listSepKeyParameter: ["min_truck_qty", "max_truck_qty"]),
    );
    _filterUserCustomController.updateListFilterModel(
      5,
      WidgetFilterModel(
          label: ['CariHargaTransportIndexHargaJasaTransport'.tr],
          typeInFilter: TypeInFilter.UNIT,
          customValue: [0.0, jumlahHarga.value],
          keyParam: 'jumlah_truk',
          isSeparateParameter: true,
          listSepKeyParameter: ["harga_min", "harga_max"]),
    );
    _filterUserCustomController.showFilter();
  }

  void reset() async {
    _resetSearchSortingFilter();
  }

  void refreshAll() async {
    listTransporter.clear();
    isLoadingData.value = true;
    countDataUser.value = 1;
    await getListTransporter(1, filter);
  }

  void goToSearchPage() async {
    var sortBy = "";
    var sortType = "";
    var mapSort = {};
    var sortList = [];

    var data = await GetToPage.toNamed<SearchManajemenUserController>(
        Routes.SEARCH_MANAJEMEN_USER,
        arguments: []);

    if (data != null) {
      isLoadingData.value = true;
      listTransporter.clear();
      listTransporter.refresh();
      await getListTransporter(1, filter);
    }
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    search.value = '';

    listTransporter.clear();
    countDataUser.value = 1;
    filter.clear();
    sortByUser.value = '';
    sortTypeUser.value = 'DESC';

    isLoadingData.value = true;
    await getListTransporter(1, filter);
  }

  Future getInitData() async {
    String ID = "";
    ID = await SharedPreferencesHelper.getUserID();
    var initdata = {};
    initdata['loginAs'] = "4";
    initdata['head_id'] =
        selectedJenisTruk['ID'] == 0 ? "" : selectedJenisTruk['ID'].toString();
    initdata['carrier_id'] = selectedJenisCarrier['ID'] == 0
        ? ""
        : selectedJenisCarrier['ID'].toString();
    initdata['head_name'] = selectedJenisTruk['Text'];
    initdata['carrier_name'] = selectedJenisCarrier['Text'];
    if (checkboxJumlahArmada["1-50"]) {
      initdata['jumlah_1'] = checkboxJumlahArmada["1-50"].toString();
    }
    if (checkboxJumlahArmada["51-100"]) {
      initdata['jumlah_51'] = checkboxJumlahArmada["51-100"].toString();
    }
    if (checkboxJumlahArmada["101-300"]) {
      initdata['jumlah_101'] = checkboxJumlahArmada["101-300"].toString();
    }
    if (checkboxJumlahArmada["300+"]) {
      initdata['jumlah_300'] = checkboxJumlahArmada["300+"].toString();
    }
    if (checkboxGoldTransporter.value) {
      initdata['gold'] = checkboxGoldTransporter.value.toString();
    }
    if (checkboxRegularTransporter.value) {
      initdata['reg'] = checkboxRegularTransporter.value.toString();
    }
    if (checkboxPromo.value) {
      initdata['promo'] = checkboxPromo.value.toString();
    }
    initdata['from_city'] = selectedPickup['ID'].toString();
    initdata['from_city_street'] =
        selectedPickup['Text'].toString().replaceAll(" ", "+");
    initdata['from_city_id'] = selectedPickup['CityID'];
    initdata['from_city_name'] =
        selectedPickup['City'].toString().replaceAll(" ", "+");
    initdata['to_city'] = selectedDestinasi['ID'].toString();
    initdata['to_city_street'] =
        selectedDestinasi['Text'].toString().replaceAll(" ", "+");
    initdata['to_city_id'] = selectedDestinasi['CityID'];
    initdata['to_city_name'] =
        selectedDestinasi['City'].toString().replaceAll(" ", "+");
    initdata['nama_transporter'] =
        selectedNamaTransport["Text"].toString().replaceAll(" ", "+");
    return initdata;
  }

  Future getListTransporter(int page, datafilter) async {
    String ID = "";
    ID = await SharedPreferencesHelper.getUserID();
    var initdata = await getInitData();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListHargaTransport(
      ID,
      '10',
      (page - 1).toString(),
      sortByUser.value,
      search.value,
      sortTypeUser.value,
      initdata,
      filter,
      multiSort.value,
      isFilter.toString(),
    );

    if (result == null) {
      print("result mengembalikan nilai null");
      listTransporter.clear();
      jumlahDataUser.value = 0;
      listTransporter.refresh();
      isLoadingData.value = false;
      return;
    }
    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      print(data);

      if (data.length == 0 && page > 1) {
        countDataUser.value -= 1;
      }
      if (page == 1) {
        listTransporter.clear();
      }
      (data as List).forEach((element) {
        element["isExpand"] = false;
        element['hasExpand'] = false;
        element['is_gold'] = false;
        element['hasNotes'] = false;
        if (element['detail'].length > 1) {
          element['hasExpand'] = true;
        }
        if (element['transporter_is_gold'].toString() == "1") {
          element['is_gold'] = true;
        }
        if ((element['notes'] != null && element['notes'] != "") ||
            (element['additional_notes'] != null &&
                element['additional_notes'] != "")) {
          element['hasNotes'] = true;
        }
        listTransporter.add(element);
      });
      jumlahDataUser.value = result['SupportingData']['NoLimitCount'] ?? 0;
      jumlahTruk.value = (result["MaxQty"] ?? 0).toDouble();
      jumlahHarga.value = (result["MaxHarga"] ?? 0).toDouble();
      Map<String, dynamic> _mapFilter = {};

      List<WidgetFilterModel> listWidgetFilter = [
        WidgetFilterModel(
          label: [
            'CariHargaTransportIndexJenisTruk'.tr,
            "CariHargaTransportIndexCariJenisTruk".tr,
          ],
          typeInFilter: TypeInFilter.TRUCK,
          keyParam: 'head_id',
        ),
        WidgetFilterModel(
          label: [
            'CariHargaTransportIndexJenisCarrier'.tr,
            "CariHargaTransportIndexCariJenisCarrier".tr,
          ],
          typeInFilter: TypeInFilter.CARRIER,
          keyParam: 'carrier_id',
        ),
        WidgetFilterModel(
            label: ['CariHargaTransportIndexKapasitas'.tr, "0", "0"],
            typeInFilter: TypeInFilter.CAPACITY,
            keyParam: 'doc_date',
            customValue: [
              {"label": "Ton", "key": "Ton"},
              {"label": "Liter", "key": "Liter"},
            ],
            isSeparateParameter: true,
            listSepKeyParameter: [
              "min_capacity",
              "max_capacity",
              "capacity_unit"
            ]),
        WidgetFilterModel(
            label: ['CariHargaTransportIndexMinimumDimensi'.tr],
            typeInFilter: TypeInFilter.DIMENSION,
            customValue: [
              {
                "separator": "",
                "satuan": [
                  {"label": "m", "key": "m"},
                  {"label": "cm", "key": "cm"},
                ]
              }
            ],
            isSeparateParameter: true,
            listSepKeyParameter: [
              "length",
              "width",
              "height",
              "dimension_unit"
            ],
            keyParam: 'dimension'),
        WidgetFilterModel(
            label: ['CariHargaTransportIndexJumlahTruk'.tr],
            typeInFilter: TypeInFilter.UNIT,
            customValue: [0.0, jumlahTruk.value],
            keyParam: 'jumlah_truk',
            isSeparateParameter: true,
            listSepKeyParameter: ["min_truck_qty", "max_truck_qty"]),
        WidgetFilterModel(
            label: ['CariHargaTransportIndexHargaJasaTransport'.tr],
            typeInFilter: TypeInFilter.UNIT,
            customValue: [0.0, jumlahHarga.value],
            keyParam: 'jumlah_truk',
            isSeparateParameter: true,
            listSepKeyParameter: ["harga_min", "harga_max"]),
        WidgetFilterModel(
          label: [
            'CariHargaTransportIndexKategoriTransporter'.tr,
          ],
          typeInFilter: TypeInFilter.RADIO_BUTTON,
          customValue: [
            RadioButtonFilterModel(
                id: "semua", value: "CariHargaTransportIndexSemuaKategori".tr),
            RadioButtonFilterModel(
                id: "dipilih",
                value: "CariHargaTransportIndexGoldTransporter".tr),
            RadioButtonFilterModel(
                id: "tidak",
                value: "CariHargaTransportIndexRegularTransporter".tr),
          ],
          keyParam: 'category_transporter',
        ),
      ];

      _filterUserCustomController = Get.put(
          FilterCustomControllerArk(
            returnData: (data) async {
              var datasubmenu = [];
              Map<String, dynamic> dataresult = {};
              _mapFilter.clear();
              _mapFilter.addAll(dataresult);

              isLoadingData.value = true;
              // print(dataval);
              isFilter.value = false;
              for (int i = 0; i < data.values.length; i++) {
                if (data.values.elementAt(i).length > 0) {
                  isFilter.value = true;
                }
              }

              var urutan = 0;
              filter.value = data;
              filter.refresh();
              listTransporter.clear();
              await getListTransporter(1, dataresult);
            },
            listWidgetInFilter: listWidgetFilter,
          ),
          tag: "");

      refreshUserController.loadComplete();
    } else {
      print("data-transport error");
    }
    listTransporter.refresh();
    isLoadingData.value = false;
  }

  void onSave() async {
    Get.back();
  }

  Future kirimUlang(subUsersID, index) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {},
              child: Center(child: CircularProgressIndicator()));
        });

    String shipperID = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .resendEmailManajemenUser(subUsersID);

    if (result['Message']['Code'].toString() == '200') {
      Get.back(result: true);
      // CustomToast.show(
      //     context: Get.context,
      //     message:
      //         "ProsesTenderDetailLabelTeksBerhasilMengirimUlangInvitedTransporter"
      //             .tr);
      // isLoadingData.value = true;
      // listTransporter[index]['remaining_diff'] = 60;
      // listTransporter.refresh();
      // await getListTransporter(1, filter);
    } else {
      Get.back(result: true);
    }
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10),
        height: 0,
      ),
    );
  }

  Future getDropdownPeranSubUser() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDropdownSubUser();

    if (result == null) {
      print("result getdropdownperansubuser mengembalikan nilai null");
      return;
    }
    if (result['Message']['Code'].toString() == '200') {
      dataDropdownPeranSubUser = result['Data'] as Map;
      var check = false;
      for (int i = 0; i < dataDropdownPeranSubUser.values.length; i++) {
        if (dataDropdownPeranSubUser.values.elementAt(i)['value'] != 0) {
          check = true;
        }
      }
      isSubscribed = check;
    }
  }

  void expandTruck(int index) {
    listTransporter[index]['isExpand'] = !listTransporter[index]['isExpand'];
    listTransporter.refresh();
  }

  void showModalBagiPeranSubUser() {
    showModalBottomSheet(
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 11),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 3.0,
                      color: Color(ListColor.colorLightGrey16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_simple.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                        onTap: () async {
                          Get.back();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 3),
                        child: CustomText(
                            'ManajemenUserIndexBagiPeranSubUser'
                                .tr, //'Bagi Peran Sub User'.tr,
                            color: Color(ListColor.colorBlue),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 18)
                    ],
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  for (int i = 0;
                      i < dataDropdownPeranSubUser.values.length;
                      i++)
                    Container(
                      child: Column(
                        children: [
                          i != 0 ? lineDividerWidget() : Container(),
                          dataDropdownPeranSubUser.values
                                      .elementAt(i)['value'] !=
                                  0
                              ? listTitleWidget(
                                  dataDropdownPeranSubUser.values
                                      .elementAt(i)['text'],
                                  "BAGIPERAN",
                                  0,
                                  {
                                    "keyword": dataDropdownPeranSubUser.keys
                                        .elementAt(i),
                                    "title": dataDropdownPeranSubUser.values
                                        .elementAt(i)['text'],
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                ],
              ),
            ));
  }

  void opsi(index) {
    showModalBottomSheet(
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 11),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 3.0,
                      color: Color(ListColor.colorLightGrey16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_simple.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                        onTap: () async {
                          Get.back();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 3),
                        child:
                            CustomText('ManajemenUserIndexOpsi'.tr, //'Opsi'.tr,
                                color: Color(ListColor.colorBlue),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 18)
                    ],
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  listTitleWidget(
                      'CariHargaTransportIndexProfilTransporter'.tr, //'Edit',
                      'HUBUNGI',
                      index,
                      listTransporter[index]["transporter_id"].toString()),
                ],
              ),
            ));
  }

  Widget listTitleWidget(String text, String fungsi, int index, dataUser) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(Get.context).size.width -
            GlobalVariable.ratioWidth(Get.context) * 32,
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 12),
        alignment: Alignment.topLeft,
        child: CustomText(text.tr,
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Get.back();
        if (fungsi == 'HUBUNGI') hubungi(dataUser);
      },
    );
  }

  void goToKetentuanHargaTransport(String notes, String additionalNotes) async {
    await GetToPage.toNamed<KetentuanHargaTransportController>(
        Routes.KETENTUAN_HARGA_TRANSPORT,
        arguments: [
          notes,
          additionalNotes,
        ]);
  }

  void bagiPeran(dataKeyword) async {
    var data = await GetToPage.toNamed<ManajemenUserBagiPeranController>(
        Routes.MANAJEMEN_USER_BAGI_PERAN,
        arguments: [
          dataKeyword, //dataUser
        ]);
    if (data != null) {
      reset();
    }
  }

  void edit(dataUser) async {
    var data = await GetToPage.toNamed<CreateManajemenUserController>(
        Routes.CREATE_MANAJEMEN_USER,
        arguments: [
          true, //isEdit
          dataUser, //dataUser
        ]);

    if (data != null) {
      reset();
    }
  }

  void hapusUser(String id, String nama, int index, bool hapus) async {
    if (hapus) {
      GlobalAlertDialog.showAlertDialogCustom(
        title: "ManajemenUserIndexKonfirmasiHapus".tr, // Konfirmasi Hapus
        customMessage: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ManajemenUserIndexApakahAndaYakin".tr +
                    ' ', //Apakah Anda yakin ingin menghapus
                style: TextStyle(
                  fontFamily: "AvenirNext",
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                ),
                children: [
                  TextSpan(
                      text: nama,
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w700,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: []),
                  TextSpan(
                      text: " ?",
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: [])
                ])),
        context: Get.context,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          showDialog(
              context: Get.context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              });
          var result = await ApiHelper(
                  context: Get.context,
                  isShowDialogLoading: false,
                  isShowDialogError: false)
              .hapusManajemenUser(id);

          if (result['Message']['Code'].toString() == '200') {
            Get.back();
            listTransporter.removeAt(index);
            listTransporter.refresh();
            jumlahDataUser.value = jumlahDataUser.value - 1;
            // CustomToast.show(
            //     context: Get.context,
            //     message:
            //         'ManajemenUserIndexBerhasilMenghapusUser'.tr + " " + nama);
          }
        },
      );
    } else {
      showDialog(
          context: Get.context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 32,
                    right: GlobalVariable.ratioWidth(Get.context) * 32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10)),
                child: Container(
                    padding: EdgeInsets.only(
                        bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                    child: Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                            child: Stack(children: [
                          Positioned(
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20,
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            right: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                          ),
                                          child: CustomText(
                                              "ManajemenUserIndexUserTidakDapatDihapus"
                                                  .tr, //User ini tidak dapat digunakan
                                              fontSize: 14,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w500,
                                              height: 1.8,
                                              color: Colors.black)),
                                    ],
                                  ))),
                          Positioned(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            right: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                8,
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                8,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                                child: GestureDetector(
                                                    child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'ic_close_blue.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              color: Color(ListColor.color4),
                                            ))),
                                          ))
                                    ],
                                  ))),
                        ])))));
          });
    }
  }

  void aktifNonManajemenUser(
      String id, String nama, int index, bool value) async {
    if (value) {
      GlobalAlertDialog.showAlertDialogCustom(
        title: "ManajemenUserIndexKonfirmasiAktifkan".tr, // Konfirmasi Aktifkan
        customMessage: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ManajemenUserIndexApakahAndaYakinAktifkan".tr +
                    ' ', //Apakah Anda yakin ingin mengaktifkan
                style: TextStyle(
                  fontFamily: "AvenirNext",
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                ),
                children: [
                  TextSpan(
                      text: nama,
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w700,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: []),
                  TextSpan(
                      text: " ?",
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: [])
                ])),
        context: Get.context,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          showDialog(
              context: Get.context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              });
          var result = await ApiHelper(
                  context: Get.context,
                  isShowDialogLoading: false,
                  isShowDialogError: false)
              .aktifNonManajemenUser(id, "1");

          if (result['Message']['Code'].toString() == '200') {
            Get.back();
            listTransporter[index]['status'] = 1;
            // listTransporter[index]['remaining_diff'] = 60;
            listTransporter.refresh();
            // CustomToast.show(
            //     context: Get.context,
            //     message: 'ManajemenUserIndexBerhasilMengaktifkanUser'.tr +
            //         " " +
            //         nama);
          }
        },
      );
    } else {
      GlobalAlertDialog.showAlertDialogCustom(
        title: "ManajemenUserIndexKonfirmasiNonaktifkan"
            .tr, // Konfirmasi No Aktifkan
        customMessage: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ManajemenUserIndexApakahAndaYakinNonaktifkan".tr +
                    ' ', //Apakah Anda yakin ingin menonaktifkan
                style: TextStyle(
                  fontFamily: "AvenirNext",
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w500,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                ),
                children: [
                  TextSpan(
                      text: nama,
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w700,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: []),
                  TextSpan(
                      text: " ?",
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                      children: [])
                ])),
        context: Get.context,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          showDialog(
              context: Get.context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              });
          var result = await ApiHelper(
                  context: Get.context,
                  isShowDialogLoading: false,
                  isShowDialogError: false)
              .aktifNonManajemenUser(id, "-1");

          if (result['Message']['Code'].toString() == '200') {
            Get.back();
            listTransporter[index]['status'] = -1;
            // listTransporter[index]['remaining_diff'] = 60;
            listTransporter.refresh();
            CustomToast.show(
                context: Get.context,
                message: 'ManajemenUserIndexBerhasilMenonaktifkanUser'.tr +
                    " " +
                    nama);
          } else if (result['Message']['Code'].toString() == '500' &&
              result['Data'].toString() != "") {
            Get.back();
            List<String> namauser = [];
            result['Data'].keys.forEach((key) {
              if (key != "Message") {
                namauser.add(result['Data'][key.toString()]['name_sub_user']);
              }
            });

            UserTidakDapatNonAktif(result['Data']['0']['name'], namauser);
          }
        },
      );
    }
  }

  void UserTidakDapatNonAktif(String namaUser, List<String> userUser) {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 32,
                  right: GlobalVariable.ratioWidth(Get.context) * 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Stack(
                        children: [
                          Positioned(
                              child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        27,
                                    right: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        27,
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            22,
                                    bottom:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: "ManajemenUserindexUser".tr,
                                        style: TextStyle(
                                          height: 1.4,
                                          fontFamily: "AvenirNext",
                                          color: Color(ListColor.colorBlack),
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  14,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: " " + namaUser + " ",
                                              style: TextStyle(
                                                height: 1.4,
                                                fontFamily: "AvenirNext",
                                                color:
                                                    Color(ListColor.colorBlack),
                                                fontWeight: FontWeight.w700,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14,
                                              ),
                                              children: []),
                                          TextSpan(
                                              text:
                                                  "ManajemenUserIndexUserTidakDapatDinonaktifkan"
                                                          .tr +
                                                      " ",
                                              style: TextStyle(
                                                height: 1.4,
                                                fontFamily: "AvenirNext",
                                                color:
                                                    Color(ListColor.colorBlack),
                                                fontWeight: FontWeight.w500,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14,
                                              ),
                                              children: []),
                                          for (var x = 0;
                                              x < userUser.length;
                                              x++)
                                            userUser.length == 1
                                                ? TextSpan(
                                                    text: userUser[x],
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontFamily: "AvenirNext",
                                                      color: Color(
                                                          ListColor.colorBlack),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                    ),
                                                    children: [])
                                                : x == userUser.length - 1
                                                    ? TextSpan(
                                                        text:
                                                            "ManajemenUserIndexDan"
                                                                    .tr +
                                                                " ",
                                                        style: TextStyle(
                                                          height: 1.4,
                                                          fontFamily:
                                                              "AvenirNext",
                                                          color: Color(ListColor
                                                              .colorBlack),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      Get.context) *
                                                              14,
                                                        ),
                                                        children: [
                                                            TextSpan(
                                                                text: (userUser[
                                                                    x]),
                                                                style:
                                                                    TextStyle(
                                                                  height: 1.4,
                                                                  fontFamily:
                                                                      "AvenirNext",
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorBlack),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      GlobalVariable.ratioFontSize(
                                                                              Get.context) *
                                                                          14,
                                                                ),
                                                                children: [])
                                                          ])
                                                    : TextSpan(
                                                        text: (userUser[x] +
                                                            ", "),
                                                        style: TextStyle(
                                                          height: 1.4,
                                                          fontFamily:
                                                              "AvenirNext",
                                                          color: Color(ListColor
                                                              .colorBlack),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      Get.context) *
                                                              14,
                                                        ),
                                                        children: []),
                                          TextSpan(
                                              text: ". " +
                                                  "ManajemenUserIndexSilahkanMengganti"
                                                      .tr +
                                                  ".",
                                              style: TextStyle(
                                                height: 1.4,
                                                fontFamily: "AvenirNext",
                                                color:
                                                    Color(ListColor.colorBlack),
                                                fontWeight: FontWeight.w500,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14,
                                              ),
                                              children: []),
                                        ]))),
                          )),
                          Positioned(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8,
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                            child: GestureDetector(
                                                child: SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              'ic_close_blue.svg',
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          color: Color(ListColor.color4),
                                        ))),
                                      ))))
                        ],
                      )))));
        });
  }

  void popUpGoldTransporter() async {
    var dataPopup = [
      {
        "title": "LelangMuatanTransporterLihatPemenangLabelCopySTNK".tr,
        "checked": true
      },
      {
        "title": "LelangMuatanTransporterLihatPemenangLabelMelengkapi".tr,
        "checked": true
      },
      {
        "title": "LelangMuatanTransporterLihatPemenangLabelKelengkapan".tr,
        "checked": true
      },
      {
        "title": "LelangMuatanTransporterLihatPemenangLabelMenerimaMinimal".tr,
        "checked": true
      },
      {
        "title":
            "LelangMuatanTransporterLihatPemenangLabelMengunggahMinimal".tr,
        "checked": true
      }
    ];

    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 34,
                  right: GlobalVariable.ratioWidth(Get.context) * 34),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(Get.context) * 7,
                        top: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    24),
                            Container(
                                margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      8,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                        GlobalVariable.imagePath +
                                            'ic_gold.png',
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            17,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            22),
                                    SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4),
                                    CustomText("Gold Transporter".tr,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ],
                                )),
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          'ic_close_blue.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          18,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          18,
                                      color: Color(ListColor.color4)),
                                ))),
                          ])),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 26,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 10),
                        CustomText(
                            "          " +
                                "LelangMuatanTransporterLihatPemenangLabelAdalahStatus"
                                    .tr,
                            textAlign: TextAlign.justify,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.2,
                            color: Color(ListColor.colorDarkGrey3)),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 10),
                        for (var x = 0; x < dataPopup.length; x++)
                          Container(
                              margin: EdgeInsets.only(
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4,
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4),
                                    child: dataPopup[x]['checked']
                                        ? SvgPicture.asset(
                                            GlobalVariable.imagePath +
                                                'checklist blue.svg',
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                14,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                14,
                                            color: Color(ListColor.color4))
                                        : SizedBox(
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                14),
                                  ),
                                  Expanded(
                                      child: CustomText(dataPopup[x]['title'],
                                          textAlign: TextAlign.justify,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          height: 1.2,
                                          color:
                                              Color(ListColor.colorDarkGrey3)))
                                ],
                              )),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 2),
                        CustomText(
                            "          " +
                                "LelangMuatanTransporterLihatPemenangLabelStatusGold"
                                    .tr,
                            textAlign: TextAlign.justify,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.2,
                            color: Color(ListColor.colorDarkGrey3)),
                      ],
                    ),
                  )
                ]),
              ));
        });
  }

  List<Widget> getBadgeList() {
    List<Widget> badgeList = [];
    if (selectedJenisTruk['Text'] != "") {
      badgeList.add(badgeWithCloseIcon(selectedJenisTruk['Text'], () {
        selectedJenisTruk.value = {
          "ID": 0,
          "Text": "",
        };
        selectedJenisTruk.refresh();
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (selectedJenisCarrier['Text'] != "") {
      badgeList.add(badgeWithCloseIcon(selectedJenisCarrier['Text'], () {
        selectedJenisCarrier.value = {
          "ID": 0,
          "Text": "",
        };
        selectedJenisCarrier.refresh();
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (selectedNamaTransport['Text'] != "") {
      badgeList.add(badgeWithCloseIcon(selectedNamaTransport['Text'], () {
        selectedNamaTransport.value = {
          "ID": 0,
          "Text": "",
        };
        selectedNamaTransport.refresh();
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (checkboxPromo.value) {
      badgeList.add(badgeWithCloseIcon("CariHargaTransportIndexPromo".tr, () {
        checkboxPromo.value = false;
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (checkboxGoldTransporter.value) {
      badgeList.add(
          badgeWithCloseIcon("CariHargaTransportIndexGoldTransporter".tr, () {
        checkboxGoldTransporter.value = false;
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (checkboxRegularTransporter.value) {
      badgeList.add(badgeWithCloseIcon(
          "CariHargaTransportIndexRegularTransporter".tr, () {
        checkboxRegularTransporter.value = false;
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (checkboxJumlahArmada["1-50"]) {
      badgeList.add(badgeWithCloseIcon("1-50", () {
        checkboxJumlahArmada["1-50"] = false;
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (checkboxJumlahArmada["51-100"]) {
      badgeList.add(badgeWithCloseIcon("51-100", () {
        checkboxJumlahArmada["51-100"] = false;
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (checkboxJumlahArmada["101-300"]) {
      badgeList.add(badgeWithCloseIcon("101-300", () {
        checkboxJumlahArmada["101-300"] = false;
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    if (checkboxJumlahArmada["300+"]) {
      badgeList.add(badgeWithCloseIcon("300+", () {
        checkboxJumlahArmada["300+"] = false;
        getListTransporter(1, filter);
        listBadge.clear();
        getBadgeList();
      }, badgeList.length == 0));
    }
    listBadge.value = badgeList;
    return badgeList;
  }

  Widget badgeWithCloseIcon(var nama, Function closeFunction, bool marginLeft) {
    double borderRadius = 20;
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 23,
      margin: EdgeInsets.only(
        right: GlobalVariable.ratioWidth(Get.context) * 8,
        left: marginLeft ? GlobalVariable.ratioWidth(Get.context) * 16 : 0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
            width: 1,
            color: Color(ListColor.color4),
          ),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            closeFunction();
          },
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                // padding: EdgeInsets.only(left: 10, right: 7, top: 3, bottom: 3),
                padding: EdgeInsets.only(left: 10, right: 7, top: 0, bottom: 0),
                // constraints: BoxConstraints(maxWidth: 150),
                child: CustomText(
                  nama.toString().replaceAll("", "\u{200B}"),
                  color: Color(ListColor.color4),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  right: 10,
                  top: GlobalVariable.ratioWidth(Get.context) * 2,
                ),
                child: SvgPicture.asset(
                    GlobalVariable.imagePath + 'ic_close.svg',
                    width: GlobalVariable.ratioWidth(Get.context) * 11,
                    height: GlobalVariable.ratioWidth(Get.context) * 11,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
