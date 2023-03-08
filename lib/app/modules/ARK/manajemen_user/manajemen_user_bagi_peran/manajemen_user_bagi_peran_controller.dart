import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_bagi_peran_sub_user/search_bagi_peran_sub_user_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ManajemenUserBagiPeranController extends GetxController {
  var loading = true.obs;
  String keyword = "";
  String id = "";
  String title = "";
  var isChanged = false.obs;
  List<String> keywordBF = ["BFShipper", "BFTransporter"];
  List<String> keywordTM = ["TMShipper", "TMTransporter"];
  bool isBF = false;
  bool isTM = false;
  var listPeriode = [].obs;
  var selectedPeriode = {}.obs;
  var selectedIndexPeriode = 0.obs;
  var listUser = [].obs;
  var listRole = [].obs;
  var usedUser = 0.obs;
  var isNext = 0.obs;
  var hasNextSubsciption = false.obs;
  var dataSubscriptionNow = {}.obs;
  var dataSubscriptionNext = {}.obs;
  int paketID = 0;

  var listUserSelected = [].obs;
  var listUserSelectedSebelumnya = [].obs;

  @override
  void onInit() async {
    var dataKeyword = Get.arguments[0] ?? {};
    keyword = dataKeyword['keyword'] ?? "";
    title = dataKeyword['title'] ?? "";
    for (int i = 0; i < keywordBF.length; i++) {
      if (keyword == keywordBF[i]) {
        isBF = true;
      }
    }
    for (int i = 0; i < keywordTM.length; i++) {
      if (keyword == keywordTM[i]) {
        isTM = true;
      }
    }

    await getDataUserSubscription();
    await getPeriodeSubUser();
    await getAllRoleSubUser();
    await getListUser(mode: 'RESET');
    loading.value = false;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void nextSubscription() async {
    loading.value = true;
    selectedIndexPeriode.value = 0;
    isNext.value = 1;
    hasNextSubsciption.value = false;
    await getPeriodeSubUser();
    await getAllRoleSubUser();
    await getListUser();
    loading.value = false;
  }

  Future getDataUserSubscription() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDataUserSubscription();

    // print(result);
    if (result != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      if (data['DataLanggananNow'].length != 0) {
        dataSubscriptionNow.value = data['DataLanggananNow'];
        dataSubscriptionNow.refresh();
      }
      if (data['DataLanggananNext'].length != 0) {
        dataSubscriptionNext.value = data['DataLanggananNext'];
        dataSubscriptionNext.refresh();
        hasNextSubsciption.value = true;
      } else {
        hasNextSubsciption.value = false;
      }
    } else {
      print("get data subscription error");
    }
  }

  Future getListUser({String mode = 'NORMAL'}) async {
    String url = "";
    if (isBF) {
      url = "list_assign_sub_user_BF";
    }
    if (isTM) {
      url = "list_assign_sub_user_TM";
    }
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListAssignSubUser(url, selectedPeriode['StartDate'],
            selectedPeriode['EndDate'], "", isNext.value.toString());

    print(result);
    if (result != null && result['Message']['Code'].toString() == '200') {
      listUser.clear();
      paketID = result['Data'][0]['PaketID'];

      var data = result['Data'][0]['SubUsers_Assign'];
      if (data != null) {
        for (int i = 0; i < data.length; i++) {
          listUser.add({
            "id": data[i]['ID'],
            "idassign": (data[i]['IDAssign'] ?? 0),
            "name": data[i]['name'],
            "email": data[i]['email'],
            "phone": data[i]['phone'],
            "roleid": data[i]['Role'] ?? 0,
            "role": (data[i]['Role'] ?? 0) == 0
                ? ""
                : getRoleName(data[i]['Role'] ?? 0),
            "aktif": data[i]['IDAssign'] == null ? false : true,
            "ddError": false,
          });

          if (mode == 'RESET') {
            listUserSelected.add({
              "id": data[i]['ID'],
              "idassign": (data[i]['IDAssign'] ?? 0),
              "name": data[i]['name'],
              "email": data[i]['email'],
              "phone": data[i]['phone'],
              "roleid": data[i]['Role'] ?? 0,
              "role": (data[i]['Role'] ?? 0) == 0
                  ? ""
                  : getRoleName(data[i]['Role'] ?? 0),
              "aktif": data[i]['IDAssign'] == null ? false : true,
              "ddError": false,
            });
          }
        }
      }

      usedUser.value = listUserSelected.length;

      print('SELECTED : ' + listUserSelected.toString());

      data = result['Data'][0]['SubUsers_nonAssign'];
      if (data != null) {
        for (int i = 0; i < data.length; i++) {
          var cek = false;
          for (var j = 0; j < listUserSelected.length; j++) {
            if (data[i]['ID'].toString() ==
                listUserSelected[j]['id'].toString()) {
              cek = true;
              listUser.add({
                "id": listUserSelected[j]['id'],
                "idassign": (listUserSelected[j]['IDAssign'] ?? 0),
                "name": listUserSelected[j]['name'],
                "email": listUserSelected[j]['email'],
                "phone": listUserSelected[j]['phone'],
                "roleid": listUserSelected[j]['roleid'] ?? 0,
                "role": (listUserSelected[j]['roleid'] == 0
                    ? ""
                    : getRoleName(listUserSelected[j]['roleid'])),
                "aktif": listUserSelected[j]['aktif'],
                "ddError": listUserSelected[j]['ddError'],
              });
            }
          }
          if (!cek) {
            listUser.add({
              "id": data[i]['ID'],
              "idassign": (data[i]['IDAssign'] ?? 0),
              "name": data[i]['name'],
              "email": data[i]['email'],
              "phone": data[i]['phone'],
              "roleid": data[i]['Role'] ?? 0,
              "role": (data[i]['Role'] ?? 0) == 0
                  ? ""
                  : getRoleName(data[i]['Role'] ?? 0),
              "aktif": data[i]['IDAssign'] == null ? false : true, // CEK
              "ddError": false,
            });
          }
        }
      }
      listUser.refresh();
      listUserSelectedSebelumnya.value =
          json.decode(json.encode(listUserSelected.value));
    } else {
      print("list_assign_sub_user_BF/TM error");
    }
  }

  Future getPeriodeSubUser() async {
    String url = "";
    if (isBF) {
      url = "timeline_sub_user_BF";
    }
    if (isTM) {
      url = "timeline_sub_user_TM";
    }
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getPeriodeSubUser(url, isNext.toString(), isTM);

    // print(result);
    if (result != null && result['Message']['Code'].toString() == '200') {
      print("ini list periode");
      print(result['Data']);
      print(selectedIndexPeriode.value);
      listPeriode.clear();
      listPeriode.value.addAll(result['Data']);
      listPeriode.refresh();
      selectedPeriode.value = listPeriode[selectedIndexPeriode.value];
      selectedPeriode.refresh();
      usedUser.value = selectedPeriode['Used'];
      print('TES PERIODE : ' + selectedPeriode.value.toString());
    } else {
      print("dropdown periode sub user error");
    }
  }

  Future getAllRoleSubUser() async {
    listRole.clear();
    String url = "";
    if (isBF) {
      url = "1";
    }
    if (isTM) {
      url = "2";
    }
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getAllRoleSubUser(url);

    // print(result);
    if (result != null && result['Message']['Code'].toString() == '200') {
      listRole.value.addAll(result['Data']);
      listRole.refresh();
    } else {
      print("dropdown periode sub user error");
    }
  }

  String getRoleName(int id) {
    String nama = "";
    for (int i = 0; i < listRole.length; i++) {
      if (id.toString() == listRole[i]['ID'].toString()) {
        nama = listRole[i]['name'];
      }
    }
    return nama;
  }

  void goToSearchPage() async {
    var data = await GetToPage.toNamed<SearchBagiPeranSubUserController>(
        Routes.SEARCH_BAGI_PERAN_SUB_USER,
        arguments: [
          selectedPeriode["Quota"],
          usedUser.value,
          isBF,
          isTM,
          selectedPeriode["StartDate"],
          selectedPeriode["EndDate"],
          isNext.value,
          listUserSelected.value,
          listUser.value,
        ]);

    if (data != null) {
      loading.value = true;

      listUserSelected.value = json.decode(json.encode(data[0]));
      print(data[1]);
      listUser.clear();
      listUser.value = json.decode(json.encode(data[1]));

      print('RESPONSE KEMBALI');
      print(listUser);
      listUser.refresh();
      usedUser.value = listUserSelected.length;
      loading.value = false;
      if (listUserSelectedSebelumnya.value.toString() !=
          listUserSelected.value.toString()) {
        isChanged.value = true;
      }
    }
  }

  void ubahPeriode() {
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
                            'ManajemenUserBagiPeranPilihPeriode'
                                .tr, //'Opsi'.tr,
                            color: Color(ListColor.colorBlue),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 18)
                    ],
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  for (int i = 0; i < listPeriode.length; i++)
                    Container(
                      child: Column(
                        children: [
                          i != 0 ? lineDividerWidget() : Container(),
                          listTitleWidget(
                              listPeriode[i]['FullStartDate'] +
                                  " - " +
                                  listPeriode[i]['FullEndDate'], //'Hapus',
                              'SELECT',
                              i),
                        ],
                      ),
                    ),
                ],
              ),
            ));
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

  Widget listTitleWidget(String text, String fungsi, int index) {
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
        if (fungsi == 'SELECT') choosePeriode(index);
      },
    );
  }

  void choosePeriode(int index) async {
    selectedIndexPeriode.value = index;
    selectedPeriode.value = listPeriode[index];
    selectedPeriode.refresh();
    listUserSelected.clear();
    listUserSelected.refresh();
    usedUser.value = selectedPeriode['Used'];
    loading.value = true;
    await getListUser(mode: 'RESET');
    loading.value = false;
  }

  void onSubmit() async {
    bool valid = true;
    //RESET
    for (var i = 0; i < listUser.length; i++) {
      listUser[i]['ddError'] = false;
    }

    for (var i = 0; i < listUser.length; i++) {
      if (listUser[i]['roleid'] == 0 && listUser[i]['aktif']) {
        listUser[i]['ddError'] = true;
        valid = false;
      }
    }

    String idAssign = "";
    String idSubUser = "";
    String idRole = "";
    String namaSubUser = "";
    for (var x = 0; x < listUserSelected.length; x++) {
      if (listUserSelected[x]['idassign'].toString() != '0') {
        idAssign += listUserSelected[x]['idassign'].toString() + ",";
      }
      idSubUser += listUserSelected[x]['id'].toString() + ",";
      idRole += listUserSelected[x]['roleid'].toString() + ",";
      namaSubUser += listUserSelected[x]['name'].toString() + ", ";
    }

    for (var y = 0; y < listUserSelectedSebelumnya.length; y++) {
      var ada = false;
      for (var x = 0; x < listUserSelected.length; x++) {
        if (listUserSelectedSebelumnya[y]['idassign'].toString() != '0' &&
            listUserSelectedSebelumnya[y]['id'].toString() ==
                listUserSelected[x]['id'].toString()) {
          ada = true;
        }
      }

      if (!ada) {
        idAssign += listUserSelectedSebelumnya[y]['idassign'].toString() + ",";
      }
    }

    if (idAssign != "") {
      idAssign = idAssign.substring(0, idAssign.length - 1);
    }

    if (idSubUser != "") {
      idSubUser = idSubUser.substring(0, idSubUser.length - 1);
    }

    if (idRole != "") {
      idRole = idRole.substring(0, idRole.length - 1);
    }

    if (namaSubUser != "") {
      namaSubUser = namaSubUser.substring(0, namaSubUser.length - 2);
    }

    print(listUser);
    print(valid);
    listUser.refresh();
    if (valid) {
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
          .doAssignUser(
        selectedPeriode["StartDate"],
        selectedPeriode["EndDate"].toString().replaceAll(" 00:00:00", ""),
        listUserSelected.length.toString(),
        paketID.toString(),
        idAssign,
        idSubUser,
        idRole,
      );

      // print(result);
      if (result != null && result['Message']['Code'].toString() == '200') {
        Get.back();
        isChanged.value = false;
        listUserSelected.clear();
        CustomToast.show(
            context: Get.context,
            message: "ManajemenUserBagiPeranUser" // User
                    .tr +
                " " +
                namaSubUser +
                " " +
                "ManajemenUserBagiPeranBerhasilDipilihMenjadiSubUser".tr +
                " " +
                selectedPeriode['FullStartDate'] +
                " - " +
                selectedPeriode['FullEndDate']);

        loading.value = true;
        await getDataUserSubscription();
        await getPeriodeSubUser();
        await getAllRoleSubUser();
        await getListUser(mode: 'RESET');
        loading.value = false;
      } else {
        print("dropdown periode sub user error");
      }
    }
  }

  void onSetData() {
    listUserSelected.clear();
    for (var x = 0; x < listUser.length; x++) {
      if (listUser[x]['aktif']) {
        listUserSelected.add(listUser[x]);
      }
    }
    print('TERPILIH');
    print(listUserSelected);
  }
}
