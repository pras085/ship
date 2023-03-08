import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/setting/model_manajemen_notifikasi.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ManajemenNotifikasiEmailController extends GetxController {

  var isInit = true;
  var isLoading = true.obs;

  var _filterheight = MediaQuery.of(Get.context).size.height - 200;

  final toggleAllNotif = true.obs;
  final toggleNotifBf = true.obs;
  final toggleNotifTm = true.obs;
  final toggleNotifBuyer = true.obs;

  final isChoosenGeneral = false.obs;
  final isChoosenBf = false.obs;
  final isChoosenTm = false.obs;
  final isChoosenBuyer = false.obs;

  final isShowGeneral = true.obs;
  final isShowBf = true.obs;
  final isShowTm = true.obs;
  final isShowBuyer = true.obs;

  final isFiltered = false.obs;
  final notFound = false.obs;

  var listModelManajemenVerifikasi = [].obs;
  var listAllMapModelManajemenVerifikasi = [].obs;

  var listModelManajemenVerifikasiGeneral = [].obs;
  var listModelManajemenVerifikasiBf = [].obs;
  var listModelManajemenVerifikasiTm = [].obs;
  var listModelManajemenVerifikasiBuyer = [].obs;

  TextEditingController searchController = TextEditingController();
  var searchValue = "".obs;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => onCompleteBuildWidget());
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onCompleteBuildWidget() async {
    if (isInit) {
      getInit();
      isInit = false;
    }
  }

  void completeDynamicList() {
    // DINAMIS LIST :v
    for(int i = 0; i < listModelManajemenVerifikasi.length; i++) {
      if(i-1 >= 0) {
        if(listModelManajemenVerifikasi[i-1].categoryIdentifier != listModelManajemenVerifikasi[i].categoryIdentifier) {
          log("RUNNN === ID NYA BEDA DENGAN YANG SEBELUMNYA");
          log("RUNNN === ID SEBELUMNYA: " + listModelManajemenVerifikasi[i-1].categoryIdentifier.toString() + " CATEGORY SEBELUMNYA: " + listModelManajemenVerifikasi[i-1].categoryName);
          log("RUN === ID SEKARANG: " + listModelManajemenVerifikasi[i].categoryIdentifier.toString() + " CATEGORY SEKARANG: " + listModelManajemenVerifikasi[i].categoryName);

          listAllMapModelManajemenVerifikasi.add([]);
        }
        listAllMapModelManajemenVerifikasi[listAllMapModelManajemenVerifikasi.length-1].add(listModelManajemenVerifikasi[i]);
      }
      else {
        log("RUN === ID SEKARANG: " + listModelManajemenVerifikasi[i].categoryIdentifier.toString() + " CATEGORY SEKARANG: " + listModelManajemenVerifikasi[i].categoryName);
        listAllMapModelManajemenVerifikasi.add([]);
        listAllMapModelManajemenVerifikasi[listAllMapModelManajemenVerifikasi.length-1].add(listModelManajemenVerifikasi[i]);
      }
    }

    for(int i = 0; i < listAllMapModelManajemenVerifikasi.length; i++) {
      for(int j = 0; j < listAllMapModelManajemenVerifikasi[i].length; j++) {
        log(i.toString() + " " + j.toString() + " " + listAllMapModelManajemenVerifikasi[i][j].categoryIdentifier.toString() + "." + listAllMapModelManajemenVerifikasi[i][j].categoryName + " - " + listAllMapModelManajemenVerifikasi[i][j].subCategoryIdentifier.toString() + ". " + listAllMapModelManajemenVerifikasi[i][j].subCategoryName);
      }
    }
  }

  Future<void> getInit() async {
    isLoading.value = true;
    try {
      await getNotifSetting(query: searchValue.value, showLoading: false);
    } catch (error) {
      print("ERROR :: $error");
    }
    isLoading.value = false;
  }

  Future<void> getNotifSetting({
    @required String query,
    @required bool showLoading
  }) async {
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: showLoading).getNotifSetting({
        "Role": "2",
        "q": query,
      });
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          listModelManajemenVerifikasi.clear();
          listAllMapModelManajemenVerifikasi.clear();

          listModelManajemenVerifikasiGeneral.clear();
          listModelManajemenVerifikasiBf.clear();
          listModelManajemenVerifikasiTm.clear();

          if(response["Data"]["Categories"].length > 0) {
            notFound.value = false;
            log("RUNNN === LENGTH: " + response["Data"]["Categories"].length.toString());
            for(int i = 0; i < response["Data"]["Categories"].length; i++) {
              ModelManajemenNotifikasi temp = ModelManajemenNotifikasi.fromJson(response["Data"]["Categories"][i]);
              log((i+1).toString() + ". CATEGORY NAME: " + temp.categoryName + " - ID: " + temp.categoryIdentifier.toString() + ", SUB CATEGORY NAME: " + temp.subCategoryName + " - ID: " + temp.subCategoryIdentifier.toString() + ", Email Notif: " + temp.emailNotif.toString());

              temp.pushNotifToggle.value = temp.pushNotif == 1 ? true : false;
              temp.emailNotifToggle.value = temp.emailNotif == 1 ? true : false;
              listModelManajemenVerifikasi.add(temp);

              if(temp.categoryIdentifier == 1) {
                // umum
                listModelManajemenVerifikasiGeneral.add(temp);
              }
              else if(temp.categoryIdentifier == 2) {
                // bf shipper
                listModelManajemenVerifikasiBf.add(temp);
              }
              else if(temp.categoryIdentifier == 3) {
                // bf transporter
              }
              else if(temp.categoryIdentifier == 4) {
                // tm shipper
                listModelManajemenVerifikasiTm.add(temp);
              }
              else if(temp.categoryIdentifier == 5) {
                // tm transporter
              }
              else if(temp.categoryIdentifier == 6) {
                // manajemen seller
              }
            }

            // completeDynamicList();
            checkToggleAllNotif();
          }
          else {
            notFound.value = true;
          }
        } else {
          // error
          log("MASOK ERROR");
        }
      } else {
        // error
        log("ERROR");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  Future<void> setNotifSettingAll({
    @required bool toggle,
    @required bool showLoading
  }) async {
    String value = toggle ? "1" : "0";
    toggleAllNotif.value = toggle;

    try{
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: false).setNotifSettingAll({
        "Mode": "2",
        "IsOn": value,
      });
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          log("SUKSES PAKKK");
          // get data ulang
          getNotifSetting(query: searchValue.value, showLoading: showLoading);
        } else {
          // error
          log("MASOK ERROR");
        }
      } else {
        // error
        log("ERROR");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  Future<void> setNotifSetting({
    @required ModelManajemenNotifikasi model, 
    @required bool toggle,
    @required bool showLoading
  }) async {
    if(model.categoryIdentifier == 1) {
      model.emailNotifToggle.value = toggle;
    }
    model.emailNotif = toggle ? 1 : 0;

    log("TOGGLE: " + model.emailNotifToggle.value.toString());
    log("VALUE: " + model.emailNotif.toString());

    try{
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: false).setNotifSetting({
        "Mode": "2",
        "CategoryID": model.categoryIdentifier.toString(),
        "IsOn": model.emailNotif.toString(),
      });
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          log("SUKSES PAKKK");
          // get data ulang
          getNotifSetting(query: searchValue.value, showLoading: showLoading);
        } else {
          // error
          log("MASOK ERROR");
        }
      } else {
        // error
        log("ERROR");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  Future<void> setNotifSettingChild({
    @required ModelManajemenNotifikasi model, 
    @required bool toggle,
    @required bool showLoading
  }) async {
    log("SET => " + model.categoryName + " - " + model.categoryIdentifier.toString() + " - " + model.subCategoryName + " - " + model.subCategoryIdentifier.toString());

    model.emailNotifToggle.value = toggle;
    model.emailNotif = toggle ? 1 : 0;

    log("TOGGLE: " + model.emailNotifToggle.value.toString());
    log("VALUE: " + model.emailNotif.toString());

    try{
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: false).setNotifSettingChild({
        "Mode": "2",
        "SubCategoryID": model.subCategoryIdentifier.toString(),
        "IsOn": model.emailNotif.toString(),
      });
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          // sukses
          log("SUKSES PAKKK");
          // get data ulang
          getNotifSetting(query: searchValue.value, showLoading: showLoading);
          // checkToggleAllNotif();
        } else {
          // error
          log("MASOK ERROR");
        }
      } else {
        // error
        log("ERROR");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }
  }

  checkToggleAllNotif() {
    bool allNotifEnabled = true;
    bool allNotifBfEnabled = true;
    bool allNotifTmEnabled = true;

    for(int i = 0; i < listModelManajemenVerifikasiGeneral.length; i++) {
      if(!listModelManajemenVerifikasiGeneral[i].emailNotifToggle.value) {
        allNotifEnabled = false;
        break;
      }
    }

    for(int i = 0; i < listModelManajemenVerifikasiBf.length; i++) {
      if(!listModelManajemenVerifikasiBf[i].emailNotifToggle.value) {
        allNotifEnabled = false;
        allNotifBfEnabled = false;
        break;
      }
    }

    for(int i = 0; i < listModelManajemenVerifikasiTm.length; i++) {
      if(!listModelManajemenVerifikasiTm[i].emailNotifToggle.value) {
        allNotifEnabled = false;
        allNotifTmEnabled = false;
        break;
      }
    }

    toggleAllNotif.value = allNotifEnabled;
    toggleNotifBf.value = allNotifBfEnabled;
    toggleNotifTm.value = allNotifTmEnabled;
  }

  Future showFilter() async {
    await showModalBottomSheet(
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
          return WillPopScope(
            onWillPop: () {
              // cancelFilter();
              resetFilter();
              applyFilter();
              return Future.value(true);
            },
            child: SingleChildScrollView(
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
                          left: GlobalVariable.ratioWidth(Get.context) * 16,
                          right: GlobalVariable.ratioWidth(Get.context) * 16,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: CustomText("GlobalFilterTitle".tr,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.color4),
                                  fontSize: 14)),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  // cancelFilter();
                                  resetFilter();
                                  applyFilter();
                                  Get.back();
                                },
                                child: Container(
                                    child: SvgPicture.asset(
                                  "assets/ic_close_simple.svg",
                                  color: Color(ListColor.colorBlack),
                                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                                ))),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  child: Container(
                                    // padding: EdgeInsets.symmetric(
                                    //   horizontal: GlobalVariable.ratioWidth(Get.context) * 16
                                    // ),
                                    child: CustomText(
                                      "GlobalFilterButtonReset".tr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.color4),
                                    ),
                                  ),
                                  onTap: () {
                                    resetFilter();
                                  }),
                            ),
                          )
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(context) * 16, 
                      GlobalVariable.ratioWidth(context) * 0, 
                      GlobalVariable.ratioWidth(context) * 16, 
                      GlobalVariable.ratioWidth(context) * 18
                    ),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      "Modul",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(context) * 8, 
                      GlobalVariable.ratioWidth(context) * 0, 
                      GlobalVariable.ratioWidth(context) * 16, 
                      GlobalVariable.ratioWidth(context) * 20
                    ),
                    child: Column(
                      children: [
                        Obx(() =>
                          Row(
                            children: [
                              CheckBoxCustom(
                                size: 16,
                                shadowSize: 8,
                                isWithShadow: true,
                                paddingTop: 0,
                                paddingBottom: 0,
                                onChanged: (onChanged) {
                                  isChoosenGeneral.value = !isChoosenGeneral.value;
                                },
                                value: isChoosenGeneral.value,
                              ),
                              CustomText(
                                "Umum"
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 12,
                        ),
                        Obx(() =>
                          Row(
                            children: [
                              CheckBoxCustom(
                                size: 16,
                                shadowSize: 8,
                                isWithShadow: true,
                                paddingTop: 0,
                                paddingBottom: 0,
                                onChanged: (onChanged) {
                                  isChoosenBf.value = !isChoosenBf.value;
                                },
                                value: isChoosenBf.value,
                              ),
                              CustomText(
                                "Big Fleet"
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 12,
                        ),
                        Obx(() =>
                          Row(
                            children: [
                              CheckBoxCustom(
                                size: 16,
                                shadowSize: 8,
                                isWithShadow: true,
                                paddingTop: 0,
                                paddingBottom: 0,
                                onChanged: (onChanged) {
                                  isChoosenTm.value = !isChoosenTm.value;
                                },
                                value: isChoosenTm.value,
                              ),
                              CustomText(
                                "Transport Market"
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 12,
                        ),
                        Obx(() =>
                          Row(
                            children: [
                              CheckBoxCustom(
                                size: 16,
                                shadowSize: 8,
                                isWithShadow: true,
                                paddingTop: 0,
                                paddingBottom: 0,
                                onChanged: (onChanged) {
                                  isChoosenBuyer.value = !isChoosenBuyer.value;
                                },
                                value: isChoosenBuyer.value,
                              ),
                              CustomText(
                                "Buyer"
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                        vertical: GlobalVariable.ratioHeight(Get.context) * 10
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                          spreadRadius: 0,
                          offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3)
                        )]
                      ),
                      width: MediaQuery.of(Get.context).size.width,
                      height: 60,
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
                                      // cancelFilter();
                                      resetFilter();
                                      applyFilter();
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
                                  8),
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
                                      applyFilter();
                                      Get.back();
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
                      )
                    ),
                  )
                ],
              ),
            )),
          );
        });
  }

  void resetFilter() {
    isChoosenGeneral.value = false;
    isChoosenBf.value = false;
    isChoosenTm.value = false;
    isChoosenBuyer.value = false;
  }

  void cancelFilter() {
    log("CANCEL FILTER");
    // kalau tidak memilih apapun di filter
    if(!isChoosenGeneral.value && !isChoosenBf.value && !isChoosenTm.value && !isChoosenBuyer.value) {
      resetFilter();

      log("TIDAK MEMILIH APAPUN DI FILTER");
      
      if(isShowGeneral.value) {
        log("GENERAL TAMPIL, BERARTI SEBELUMNYA GENERAL TERPILIH");
        isChoosenGeneral.value = isShowGeneral.value;
      }

      if(isShowBf.value) {
        log("BF TAMPIL, BERARTI SEBELUMNYA BF TERPILIH");
        isChoosenBf.value = isShowBf.value;
      }

      if(isShowTm.value) {
        log("TM TAMPIL, BERARTI SEBELUMNYA TM TERPILIH");
        isChoosenTm.value = isShowTm.value;
      }

      if(isShowBuyer.value) {
        log("BUYER TAMPIL, BERARTI SEBELUMNYA BUYER TERPILIH");
        isChoosenBuyer.value = isShowBuyer.value;
      }
    }
    else {
      log("FILTER SALAH SATU TERPILIH");
      isChoosenGeneral.value = isShowGeneral.value;
      isChoosenBf.value = isShowBf.value;
      isChoosenTm.value = isShowTm.value;
      isChoosenBuyer.value = isShowBuyer.value;

      if(isShowGeneral.value && isShowBf.value && isShowTm.value && isShowBuyer.value) {
        log("SEMUA MUNCUL, MATIKAN SEMUA FILTER");
        isChoosenGeneral.value = !isShowGeneral.value;
        isChoosenBf.value = !isShowBf.value;
        isChoosenTm.value = !isShowTm.value;
        isChoosenBuyer.value = !isShowBuyer.value;
      }
      else if(!isShowGeneral.value && !isShowBf.value && !isShowTm.value && !isShowBuyer.value) {
        log("SEMUA TIDAK MUNCUL, NYALAKAN SEMUA FILTER");
        isChoosenGeneral.value = !isShowGeneral.value;
        isChoosenBf.value = !isShowBf.value;
        isChoosenTm.value = !isShowTm.value;
        isChoosenBuyer.value = !isShowBuyer.value;
      }
      else {
        if(isShowGeneral.value) {
          log("GENERAL TAMPIL, BERARTI SEBELUMNYA GENERAL TERPILIH");
          isChoosenGeneral.value = isShowGeneral.value;
        }

        if(isShowBf.value) {
          log("BF TAMPIL, BERARTI SEBELUMNYA BF TERPILIH");
          isChoosenBf.value = isShowBf.value;
        }

        if(isShowTm.value) {
          log("TM TAMPIL, BERARTI SEBELUMNYA TM TERPILIH");
          isChoosenTm.value = isShowTm.value;
        }

        if(isShowBuyer.value) {
          log("BUYER TAMPIL, BERARTI SEBELUMNYA BUYER TERPILIH");
          isChoosenBuyer.value = isShowBuyer.value;
        }
      }
    }

    printCheck();
  }

  void applyFilter() {
    isShowGeneral.value = isChoosenGeneral.value;
    isShowBf.value = isChoosenBf.value;
    isShowTm.value = isChoosenTm.value;
    isShowBuyer.value = isChoosenBuyer.value;

    // kalau tidak memilih apapun di filter
    if(!isChoosenGeneral.value && !isChoosenBf.value && !isChoosenTm.value && !isChoosenBuyer.value) {
      isShowGeneral.value = !isChoosenGeneral.value;
      isShowBf.value = !isChoosenBf.value;
      isShowTm.value = !isChoosenTm.value;
      isShowBuyer.value = !isChoosenBuyer.value;

      // inactive button filter dan show opsi notif di email
      isFiltered.value = false;
    }
    else {
      // active button filter dan hide opsi notif di email
      isFiltered.value = true;
    }

    printCheck();
  }

  void printCheck() {
    log("General: " + isChoosenGeneral.toString());
    log("BF: " + isChoosenBf.toString());
    log("TM: " + isChoosenTm.toString());
    log("Buyer: " + isChoosenBuyer.toString());

    log("Show General: " + isShowGeneral.toString());
    log("Show BF: " + isShowBf.toString());
    log("Show TM: " + isShowTm.toString());
    log("Show Buyer: " + isShowBuyer.toString());
  }

  bool checkIsFiltered() {
    if(isChoosenGeneral.value || isChoosenBf.value || isChoosenTm.value || isChoosenBuyer.value) {
      return true;
    }
    return false;
  }

  bool checkShowItem() {
    if(isShowGeneral.value && isShowBf.value && isShowTm.value && isShowBuyer.value) {
      return true;
    }
    return false;
  }

}
