import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/history_search_model.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_manajemen_user/create_manajemen_user_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchManajemenUserController extends GetxController {
  var jenisTab = "".obs;
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listUser = [].obs;
  var searchOn = false.obs;
  final isShowClearSearch = false.obs;
  Timer time;

  var kondisiAwal = true;

  var countData = 1.obs;
  var countSearch = 1.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN

  var sortBy = ''.obs; //UNTUK SORT BERDASARKAN APA
  var sortType = ''.obs; //UNTUK URUTAN SORTNYA
  Map<String, dynamic> mapSort = {}; //UNTUK URUTAN SORTNYA
  var pencarian = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD

  String sortTag = 'sort';

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  SortingController _sortingController;

  List<DataListSortingModel> sort = [];
  var jumlahDataUser = 0.obs;
  var lastShow = true.obs;

  var listHistorySearch = [].obs;
  var isLoadingLast = false.obs;
  String searchType = "1";

  var cekTambah = false;
  var cekHapus = false;
  var cekAktifNon = false;

  @override
  void onInit() async {
    super.onInit();

    cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Sub User");
    cekHapus = await SharedPreferencesHelper.getHakAkses("Hapus Sub User");
    cekAktifNon =
        await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Sub User");

    sort = [
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
      DataListSortingModel(
          'ManajemenUserIndexStatusUser'.tr,
          'status',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    _sortingController = Get.put(
        SortingController(
            listSort: sort,
            initMap: mapSort,
            onRefreshData: (map) async {
              listUser.clear();
              countData.value = 1;
              //SET ULANG
              sortBy.value = "";
              sortType.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortBy.value += element;
                if (index < map.keys.length) {
                  sortBy.value += ",";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortType.value += element;
                if (index < map.values.length) {
                  sortType.value += ",";
                }
              });

              mapSort = map;
              print('NEW MAPS');
              print(map);
              isLoadingData.value = true;
              await getListUser(1, jenisTab.value);
            }),
        tag: sortTag);

    isLoadingLast.value = true;
    isLoadingData.value = false;

    getHistorySearch();

    setMailTime();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onSearch() async {
    kondisiAwal = true;
    lastShow.value = false;
    FocusManager.instance.primaryFocus.unfocus();
    countData.value = 1;
    isLoadingData.value = true;
    listUser.clear();
    if (searchController.value.text != "") {
      searchOn.value = true;
    } else {
      searchOn.value = false;
    }
    await saveHistorySearch();
    await getListUser(1, jenisTab.value);
  }

  void onChangeText(String textSearch) {
    isShowClearSearch.value = textSearch != "";
  }

  void onClearSearch() async {
    searchController.value.text = '';
    onChangeText(searchController.value.text);
  }

  void showSortingDialog() {
    FocusManager.instance.primaryFocus.unfocus();
    _sortingController.showSort();
  }

  void _clearSorting() {
    FocusManager.instance.primaryFocus.unfocus();
    _sortingController.clearSorting();
  }

  void reset() async {
    FocusManager.instance.primaryFocus.unfocus();
    _resetSearchSortingFilter();
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    pencarian.value = '';
    listUser.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    await getListUser(1, jenisTab.value);
  }

  Future getHistorySearch() async {
    var isShipper = "1";
    var ID = await SharedPreferencesHelper.getUserShipperID();

    listHistorySearch.clear();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchLatestSearchSubUser(searchType);
    print("ini result");
    print(result);
    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (var x = 0; x < data.length; x++) {
        var json = {
          'idsearch': data[x]['ID'].toString(),
          'search': data[x]['history'].toString(),
        };
        listHistorySearch.add(json);
      }
      listHistorySearch.refresh();
    }

    print('GET HISTORY SEARCH');

    print(listHistorySearch);
    isLoadingLast.value = false;
  }

  void chooseHistorySearch(index) async {
    searchController.value.text = listHistorySearch[index]['search'].toString();
    onSearch();
  }

  Future saveHistorySearch() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .saveLatestSearchSubUser(searchController.value.text, searchType);
    await getHistorySearch();
    print('HAPUS HISTORY SEARCH');
  }

  void hapusHistorySearch(index) async {
    var idsearch = listHistorySearch[index]['idsearch'];

    listHistorySearch.removeAt(index);

    listHistorySearch.refresh();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .deleteLatestSearchSubUser(idsearch);

    print('HAPUS HISTORY SEARCH');
  }

  void clearHistorySearch() async {
    listHistorySearch.clear();
    listHistorySearch.refresh();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .deleteAllLatestSearchSubUser(searchType);

    print('CLEAR HISTORY SEARCH');
  }

  Future getListUser(int page, String pageName) async {
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
      sortBy.value,
      searchController.value.text,
      sortType.value,
      [],
    );

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countData.value -= 1;
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

      countSearch.value = result['SupportingData']['RealCountData'];
    }
    refreshController.loadComplete();

    isLoadingData.value = false;
    kondisiAwal = false;
  }

  void refreshAll() async {
    FocusManager.instance.primaryFocus.unfocus();
    pencarian.value = '';
    listUser.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    getListUser(1, jenisTab.value);
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

  void aktifNonManajemenUser(
      String id, String nama, int index, bool value) async {
    if (value) {
      GlobalAlertDialog.showAlertDialogCustom(
        title: "ManajemenUserIndexKonfirmasiAktifkan".tr, // Konfirmasi Aktifkan
        customMessage: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ManajemenUserIndexApakahAndaYakinMengaktifkanUser".tr +
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
            listUser[index]['status'] = -1;
            // listUser[index]['remaining_diff'] = 60;
            listUser.refresh();
            // CustomToast.show(
            //     context: Get.context,
            //     message: 'ManajemenUserIndexBerhasilMenonaktifkanUser'.tr +
            //         " " +
            //         nama);
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
                                        text: "User",
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
        if (fungsi == 'HAPUS')
          hapusUser(dataUser['id'], dataUser['name'], index, true);
      },
    );
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
    // Get.back();
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
}
