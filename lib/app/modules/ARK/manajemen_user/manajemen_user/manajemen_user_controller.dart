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
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/checkbox_filter_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_role/manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_manajemen_user/create_manajemen_user_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/manajemen_user_bagi_peran/manajemen_user_bagi_peran_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_manajemen_user/search_manajemen_user_controller.dart';
// import 'package:muatmuat/app/modules/manajemen_user_bagi_peran/manajemen_user_bagi_peran_controller.dart';
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

class ManajemenUserController extends GetxController
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

  var cekTambah = false;
  var cekHapus = false;
  var cekAktifNon = false;
  var cekAssign = false;
  @override
  void onInit() async {
    print("reset filter");
    try {
      Get.delete<FilterCustomControllerArk>(tag: "");
    } catch (e) {
      print(e);
    }

    cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Sub User");
    cekHapus = await SharedPreferencesHelper.getHakAkses("Hapus Sub User");
    cekAktifNon =
        await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Sub User");
    cekAssign = await SharedPreferencesHelper.getHakAkses("Assign Sub User");

    userSort = [
      DataListSortingModel(
          'ManajemenUserIndexNama'.tr,
          'name',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'ManajemenUserIndexEmail'.tr,
          'email',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      // DataListSortingModel(
      //     'ManajemenUserIndexStatusUser'.tr,
      //     'status',
      //     'LoadRequestInfoSortingLabelAscending'.tr,
      //     'LoadRequestInfoSortingLabelDescending'.tr,
      //     ''.obs),
    ];

    _sortingUserController = Get.put(
        SortingController(
            listSort: userSort,
            initMap: mapSortByUser,
            onRefreshData: (map) async {
              countDataUser.value = 1;
              print('User');
              listUser.clear();
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

              mapSortByUser = map;

              print('NEW MAPS');
              print(map);

              isLoadingData.value = true;

              print(isLoadingData);
              print(firstTimeUser);
              await getListUser(1, filter);
            }),
        tag: tagUser);

    await getDropdownPeranSubUser();
    await getListUser(1, filter);

    isLoadingData.value = false;

    print(cekTambah);

    setMailTime();
    print(firstTimeUser);
    print(isLoadingData);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

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
    _filterUserCustomController.showFilter();
  }

  void reset() async {
    _resetSearchSortingFilter();
  }

  void refreshAll() async {
    listUser.clear();
    isLoadingData.value = true;
    countDataUser.value = 1;
    await getListUser(1, filter);
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
      listUser.clear();
      listUser.refresh();
      await getListUser(1, filter);
    }
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    search.value = '';

    listUser.clear();
    countDataUser.value = 1;
    filter.clear();
    sortByUser.value = '';
    sortTypeUser.value = 'DESC';
    _sortingUserController.clearSorting();

    isLoadingData.value = true;
    await getListUser(1, filter);
  }

  Future getListUser(int page, datafilter) async {
    String ID = "";
    ID = await SharedPreferencesHelper.getUserID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListManajemenUser(
      ID,
      '10',
      (page - 1).toString(),
      sortByUser.value,
      search.value,
      sortTypeUser.value,
      filter['statusFilter'] ?? [],
    );

    print(filter);
    if (result == null) {
      print("result mengembalikan nilai null");
      listUser.clear();
      jumlahDataUser.value = 0;
      listUser.refresh();
      isLoadingData.value = false;
      return;
    }
    if (result['Message']['Code'].toString() == '200') {
      listFilterUser.value = [];
      listFilterUser.refresh();
      firstTimeUser = false;
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countDataUser.value -= 1;
      }
      if (page == 1) {
        listUser.clear();
      }
      (data as List).forEach((element) {
        listUser.add({
          'id': element['ID'].toString(),
          'name': element['name'],
          "email": element['email'],
          "phone": element['phone'],
          // "counter_verif": element['counter_verif'] ?? 180,
          "remaining_diff": element['remaining_diff'] ?? 0,
          "status": element['status'],
          "StatusAssign": element['StatusAssign'],
        });
      });
      jumlahDataUser.value = result['SupportingData']['RealCountData'] ?? 0;
      hasSubUserActive.value =
          result['SupportingData']['CountSubUser'] > 0 ? true : false;
      // hasSubUserRole.value =
      //     result['SupportingData']['CountUserRole'] > 0 ? true : false;

      Map<String, dynamic> _mapFilter = {};

      List<WidgetFilterModel> listWidgetFilter = [
        WidgetFilterModel(
          label: [
            'ManajemenUserIndexStatusUser'.tr,
            "ManajemenUserIndexCariSubUser".tr,
            "ManajemenUserIndexCariSubUser".tr,
          ],
          customValue: [
            CheckboxFilterModel(
              id: "Ditugaskan",
              value: "ManajemenUserIndexFilterDitugaskan".tr,
            ),
            CheckboxFilterModel(
              id: "BelumDitugaskan",
              value: "ManajemenUserIndexFilterBelumDitugaskan".tr,
            ),
            CheckboxFilterModel(
              id: "TidakAktif",
              value: "ManajemenUserIndexFilterTidakAktif".tr,
            ),
            CheckboxFilterModel(
              id: "Email",
              value: "ManajemenUserIndexFilterMenungguVerifikasiEmail".tr,
            ),
            CheckboxFilterModel(
              id: "Whatsapp",
              value: "ManajemenUserIndexFilterMenungguVerifikasiNoWhatsapp".tr,
            ),
            CheckboxFilterModel(
              id: "Tolak",
              value: "ManajemenUserIndexFilterVerifikasiDitolakSubUser".tr,
            ),
          ],
          typeInFilter: TypeInFilter.CHECKBOX,
          keyParam: 'status',
        ),
      ];

      _filterUserCustomController = Get.put(
          FilterCustomControllerArk(
            returnData: (data) async {
              var dataParameterFilter = {
                "Ditugaskan": {"Status": 1, "StatusAssign": 1, "filtered": 1},
                "BelumDitugaskan": {
                  "Status": 1,
                  "StatusAssign": 0,
                  "filtered": 2
                },
                "TidakAktif": {"Status": -1, "StatusAssign": 0, "filtered": 3},
                "Email": {"Status": 2, "StatusAssign": 0, "filtered": 4},
                "Whatsapp": {"Status": 3, "StatusAssign": 0, "filtered": 5},
                "Tolak": {"Status": 4, "StatusAssign": 0, "filtered": 6},
              };

              var datasubmenu = [];
              Map<String, dynamic> dataresult = {};
              _mapFilter.clear();
              _mapFilter.addAll(dataresult);

              isLoadingData.value = true;
              // print(dataval);
              isFilter = false;
              for (int i = 0; i < data.values.length; i++) {
                if (data.values.elementAt(i).length > 0) {
                  isFilter = true;
                }
              }
              if (isFilter) {
                var arr = [];
                for (int i = 0; i < data['status'].length; i++) {
                  arr.add(dataParameterFilter[data['status'][i]]);
                }

                dataresult['statusFilter'] = arr;
              }

              var urutan = 0;
              filter.value = dataresult;
              filter.refresh();
              listUser.clear();
              await getListUser(1, dataresult);
            },
            listWidgetInFilter: listWidgetFilter,
          ),
          tag: "");

      refreshUserController.loadComplete();
    }
    listUser.refresh();
    isLoadingData.value = false;
  }

  void setMailTime() async {
    time = Timer.periodic(const Duration(seconds: 1), (val) {
      for (var x = 0; x < listUser.length; x++) {
        if (listUser[x]['remaining_diff'] > 0) {
          listUser[x]['remaining_diff']--;
          listUser.refresh();
        } else {
          listUser[x]['remaining_diff'] = 0;
          listUser.refresh();
        }
      }
    });
  }

  void onSave() async {
    if (time.isActive) {
      time.cancel();
    }
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
      listUser[index]['remaining_diff'] = 60;
      listUser.refresh();
      // await getListUser(1, filter);
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
      hasSubUserRole.value = result['Data']['CountUserRole'] > 0 ? true : false;
      // print(result['Data']['CountUserRole'] ?? "g nemu countuser");
      dataDropdownPeranSubUser = result['Data'] as Map;

      print(dataDropdownPeranSubUser);
      var check = false;
      for (int i = 0; i < dataDropdownPeranSubUser.values.length - 1; i++) {
        if (dataDropdownPeranSubUser.values.elementAt(i)['value'] != 0) {
          check = true;
        }
      }
      isSubscribed = check;
    }
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
                        child: SvgPicture.asset('assets/ic_close_simple.svg',
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
                      i < dataDropdownPeranSubUser.values.length - 1;
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
                                  true,
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

  void opsi(dataUser, index) {
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
                        child: SvgPicture.asset('assets/ic_close_simple.svg',
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
                      'ManajemenUserIndexEdit'.tr, //'Edit',
                      'EDIT',
                      index,
                      cekTambah,
                      dataUser),
                  lineDividerWidget(),
                  listTitleWidget(
                      'ManajemenUserIndexHapus'.tr, //'Hapus',
                      'HAPUS',
                      index,
                      cekHapus,
                      dataUser),
                ],
              ),
            ));
  }

  Widget listTitleWidget(
      String text, String fungsi, int index, bool akses, dataUser) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(Get.context).size.width -
            GlobalVariable.ratioWidth(Get.context) * 32,
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 12),
        alignment: Alignment.topLeft,
        child: CustomText(text.tr,
            color: akses ? Colors.black : Color(ListColor.colorAksesDisable),
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Get.back();
        if (fungsi == 'EDIT') edit(dataUser);
        if (fungsi == 'BAGIPERAN') bagiPeran(dataUser);
        if (fungsi == 'HAPUS')
          hapusUser(dataUser['id'], dataUser['name'], index, true);
      },
    );
  }

  void bagiPeran(dataKeyword) async {
    if (!hasSubUserRole.value) {
      popUpCreateRole();
    } else {
      var data = await GetToPage.toNamed<ManajemenUserBagiPeranController>(
          Routes.MANAJEMEN_USER_BAGI_PERAN,
          arguments: [
            dataKeyword, //dataUser
          ]);
      if (data != null) {
        reset();
      }
    }
  }

  void popUpCreateRole() async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    32),
                            Expanded(
                                // margin: EdgeInsets.only(
                                //   top: GlobalVariable.ratioWidth(Get.context) *
                                //       24,
                                // ),
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          "ManajemenUserIndexAndaBelumMemilikiRoleHakAkses"
                                              .tr,
                                          fontSize: 14,
                                          height: 1.4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          Get.back();
                                          GetToPage.toNamed<
                                                  ManajemenRoleController>(
                                              Routes.MANAJEMEN_ROLE);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Color(ListColor.colorBlue),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      9),
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CustomText(
                                                    "ManajemenUserIndexBukaManajemenRole"
                                                        .tr,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      8,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      child: GestureDetector(
                                          child: SvgPicture.asset(
                                    'assets/ic_close_blue.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    color: Color(ListColor.color4),
                                  ))),
                                ))
                          ])))));
        });
  }

  void edit(dataUser) async {
    cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Sub User",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekTambah)) {
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
  }

  void hapusUser(String id, String nama, int index, bool hapus) async {
    cekHapus = await SharedPreferencesHelper.getHakAkses("Hapus Sub User",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekHapus)) {
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
              listUser.removeAt(index);
              listUser.refresh();
              jumlahDataUser.value = jumlahDataUser.value - 1;
              CustomToast.show(
                  context: Get.context,
                  message: 'ManajemenUserIndexBerhasilMenghapusUser'.tr + nama);
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
                                                'assets/ic_close_blue.svg',
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24,
                                                height:
                                                    GlobalVariable.ratioWidth(
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
            listUser[index]['status'] = 1;
            // listUser[index]['remaining_diff'] = 60;
            listUser.refresh();
            CustomToast.show(
                context: Get.context,
                message:
                    'ManajemenUserIndexBerhasilMengaktifkanUser'.tr + nama);
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
            listUser[index]['status'] = -1;
            // listUser[index]['remaining_diff'] = 60;
            listUser.refresh();
            CustomToast.show(
                context: Get.context,
                message:
                    'ManajemenUserIndexBerhasilMenonaktifkanUser'.tr + nama);
          } else if (result['Message']['Code'].toString() == '500' &&
              result['Data'].toString() != "") {
            Get.back();
            List<String> namaMenu = [];
            result['Data'].keys.forEach((key) {
              if (key != "Message") {
                if (namaMenu.contains(
                        result['Data'][key.toString()]['title_menu_id']) ==
                    false) {
                  namaMenu.add(result['Data'][key.toString()]['title_menu_id']);
                }
              }
            });

            UserTidakDapatNonAktif(result['Data']['0']['name'], namaMenu);
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
                                                      .tr,
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
                                          'assets/ic_close_blue.svg',
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
}
