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
import 'package:muatmuat/app/widgets/radio_button_custom_with_text_widget.dart';
import 'package:muatmuat/global_variable.dart';

class RingkasanManajemenNotifikasiController extends GetxController {

  var isInit = true;
  var isLoading = true.obs;

  var _filterheight = MediaQuery.of(Get.context).size.height - 200;

  final isChoosenBf = false.obs;
  final isChoosenTm = false.obs;
  final isChoosenBuyer = false.obs;
  final isChoosenEmail = false.obs;
  final isChoosenAplikasi = false.obs;

  final selectedEmail = "-1".obs;
  final selectedEmailValue = "-1".obs;
  final selectedAplikasi = "-1".obs;
  final selectedAplikasiValue = "-1".obs;

  final isShowBf = true.obs;
  final isShowTm = true.obs;
  final isShowBuyer = true.obs;
  final isShowEmail = false.obs;
  final isShowAplikasi = false.obs;

  final isFiltered = false.obs;
  final notFound = false.obs;

  var listModelManajemenVerifikasi = [].obs;
  var listAllMapModelManajemenVerifikasi = [].obs;

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

          listModelManajemenVerifikasiBf.clear();
          listModelManajemenVerifikasiTm.clear();

          if(response["Data"]["Categories"].length > 0) {
            notFound.value = false;
            log("RUNNN === LENGTH: " + response["Data"]["Categories"].length.toString());
            for(int i = 0; i < response["Data"]["Categories"].length; i++) {
              ModelManajemenNotifikasi temp = ModelManajemenNotifikasi.fromJson(response["Data"]["Categories"][i]);
              // log((i+1).toString() + ". CATEGORY NAME: " + temp.categoryName + " - ID: " + temp.categoryIdentifier.toString() + ", SUB CATEGORY NAME: " + temp.subCategoryName + " - ID: " + temp.subCategoryIdentifier.toString() + ", Email Notif: " + temp.emailNotif.toString() + ", Push Notif: " + temp.pushNotif.toString());

              if(temp.pushNotif == 1 || temp.emailNotif == 1) {
                log((i+1).toString() + ". CATEGORY NAME: " + temp.categoryName + " - ID: " + temp.categoryIdentifier.toString() + ", SUB CATEGORY NAME: " + temp.subCategoryName + " - ID: " + temp.subCategoryIdentifier.toString() + ", Email Notif: " + temp.emailNotif.toString() + ", Push Notif: " + temp.pushNotif.toString());
                temp.pushNotifToggle.value = temp.pushNotif == 1 ? true : false;
                temp.emailNotifToggle.value = temp.emailNotif == 1 ? true : false;
                listModelManajemenVerifikasi.add(temp);
              }

              if(temp.categoryIdentifier == 1) {
                // umum
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

            printListContent();
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
                      GlobalVariable.ratioWidth(context) * 0
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
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(context) * 16,
                      vertical: GlobalVariable.ratioWidth(context) * 20,
                    ),
                    color: Color(ListColor.colorStroke),
                    height: GlobalVariable.ratioWidth(context) * 0.5,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(context) * 16, 
                      GlobalVariable.ratioWidth(context) * 0, 
                      GlobalVariable.ratioWidth(context) * 16, 
                      GlobalVariable.ratioWidth(context) * 18
                    ),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      "Jenis Notifikasi",
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
                                  isChoosenEmail.value = !isChoosenEmail.value;
                                },
                                value: isChoosenEmail.value,
                              ),
                              CustomText(
                                "Email"
                              ),
                            ],
                          ),
                        ),
                        Obx(() => isChoosenEmail.value
                          ? Container(
                            margin: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(context) * 33,
                              top: GlobalVariable.ratioWidth(context) * 8.9
                            ),
                            child: Column(
                              children: [
                                RadioButtonCustomWithText(
                                  isWithShadow: true,
                                  isDense: true,
                                  radioSize: GlobalVariable.ratioWidth(context) * 16,
                                  groupValue: selectedEmail.value,
                                  value: "1", 
                                  customTextWidget: Container(
                                    margin:EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(Get.context) * 8
                                    ),
                                    child: CustomText(
                                      "Aktif",
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorGrey3)),
                                  ), 
                                  onChanged: (value) {
                                    selectedEmail.value = value;
                                  },
                                ),
                                SizedBox(
                                  height: GlobalVariable.ratioWidth(context) * 9.5,
                                ),
                                RadioButtonCustomWithText(
                                  isWithShadow: true,
                                  isDense: true,
                                  radioSize: GlobalVariable.ratioWidth(context) * 16,
                                  groupValue: selectedEmail.value,
                                  value: "0", 
                                  customTextWidget: Container(
                                    margin:EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(Get.context) * 8
                                    ),
                                    child: CustomText(
                                      "Tidak Aktif",
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorGrey3)),
                                  ), 
                                  onChanged: (value) {
                                    selectedEmail.value = value;
                                  },
                                ),
                              ],
                            ),
                          )
                          : SizedBox.shrink()
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
                                  isChoosenAplikasi.value = !isChoosenAplikasi.value;
                                },
                                value: isChoosenAplikasi.value,
                              ),
                              CustomText(
                                "Aplikasi"
                              ),
                            ],
                          ),
                        ),
                        Obx(() => isChoosenAplikasi.value
                          ? Container(
                            margin: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(context) * 33,
                              top: GlobalVariable.ratioWidth(context) * 8.9
                            ),
                            child: Column(
                              children: [
                                RadioButtonCustomWithText(
                                  isWithShadow: true,
                                  isDense: true,
                                  radioSize: GlobalVariable.ratioWidth(context) * 16,
                                  groupValue: selectedAplikasi.value,
                                  value: "1", 
                                  customTextWidget: Container(
                                    margin:EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(Get.context) * 8
                                    ),
                                    child: CustomText(
                                      "Aktif",
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorGrey3)),
                                  ), 
                                  onChanged: (value) {
                                    selectedAplikasi.value = value;
                                  },
                                ),
                                SizedBox(
                                  height: GlobalVariable.ratioWidth(context) * 9.5,
                                ),
                                RadioButtonCustomWithText(
                                  isWithShadow: true,
                                  isDense: true,
                                  radioSize: GlobalVariable.ratioWidth(context) * 16,
                                  groupValue: selectedAplikasi.value,
                                  value: "0", 
                                  customTextWidget: Container(
                                    margin:EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(Get.context) * 8
                                    ),
                                    child: CustomText(
                                      "Tidak Aktif",
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorGrey3)),
                                  ), 
                                  onChanged: (value) {
                                    selectedAplikasi.value = value;
                                  },
                                ),
                              ],
                            ),
                          )
                          : SizedBox.shrink()
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
    isChoosenBf.value = false;
    isChoosenTm.value = false;
    isChoosenBuyer.value = false;
    isChoosenAplikasi.value = false;
    isChoosenEmail.value = false;

    selectedEmail.value = "-1";
    // selectedEmailValue.value = "-1";
    selectedAplikasi.value = "-1";
    // selectedAplikasiValue.value = "-1";
  }

  void cancelFilter() {
    log("CANCEL FILTER");
    // kalau tidak memilih apapun di filter
    if(!isChoosenBf.value && !isChoosenTm.value && !isChoosenBuyer.value && !isChoosenEmail.value && !isChoosenAplikasi.value) {
      resetFilter();

      log("TIDAK MEMILIH APAPUN DI FILTER");
    }
    else {
      log("FILTER SALAH SATU TERPILIH");
      isChoosenBf.value = isShowBf.value;
      isChoosenTm.value = isShowTm.value;
      isChoosenBuyer.value = isShowBuyer.value;
    }

    if(isShowBf.value && isShowTm.value && isShowBuyer.value) {
      log("SEMUA MUNCUL, MATIKAN SEMUA FILTER");
      isChoosenBf.value = false;
      isChoosenTm.value = false;
      isChoosenBuyer.value = false;
    }
    else if(!isShowBf.value && !isShowTm.value && !isShowBuyer.value) {
      log("SEMUA TIDAK MUNCUL, NYALAKAN SEMUA FILTER");
      isChoosenBf.value = true;
      isChoosenTm.value = true;
      isChoosenBuyer.value = true;
    }
    else {
      if(isShowBf.value) {
        log("BF TAMPIL, BERARTI SEBELUMNYA BF TERPILIH");
        isChoosenBf.value = true;
      }

      if(isShowTm.value) {
        log("TM TAMPIL, BERARTI SEBELUMNYA TM TERPILIH");
        isChoosenTm.value = true;
      }

      if(isShowBuyer.value) {
        log("BUYER TAMPIL, BERARTI SEBELUMNYA BUYER TERPILIH");
        isChoosenBuyer.value = true;
      }
    }

    if(selectedEmailValue.value != "-1") {
      if(selectedEmailValue.value != "1") log("RADIO BUTTON EMAIL KONDISI AKTI");
      else log("RADIO BUTTON EMAIL KONDISI TIDAK AKTIF");
      isChoosenEmail.value = true;
      selectedEmail.value = selectedEmailValue.value;
    }
    else {
      isChoosenEmail.value = false;
      selectedEmail.value = "-1";
    }

    if(selectedAplikasiValue.value != "-1") {
      if(selectedAplikasiValue.value != "1") log("RADIO BUTTON APLIKASI KONDISI AKTIF");
      else log("RADIO BUTTON APLIKASI KONDISI TIDAK AKTIF");      
      isChoosenAplikasi.value = true;
      selectedAplikasi.value = selectedAplikasiValue.value;
    }
    else {
      isChoosenAplikasi.value = false;
      selectedAplikasi.value = "-1";
    }

    printCheck();
  }

  void applyFilter() {
    isShowBf.value = isChoosenBf.value;
    isShowTm.value = isChoosenTm.value;
    isShowBuyer.value = isChoosenBuyer.value;
    isShowEmail.value = isChoosenEmail.value;
    isShowAplikasi.value = isChoosenAplikasi.value;

    // kalau tidak memilih apapun di filter
    if(!isChoosenBf.value && !isChoosenTm.value && !isChoosenBuyer.value && !isChoosenEmail.value && !isChoosenAplikasi.value) {
      isShowBf.value = !isChoosenBf.value;
      isShowTm.value = !isChoosenTm.value;
      isShowBuyer.value = !isChoosenBuyer.value;
      isShowEmail.value = !isChoosenEmail.value;
      isShowAplikasi.value = !isChoosenAplikasi.value;

      // inactive button filter dan show opsi notif di email
      isFiltered.value = false;
    }
    else {
      // active button filter dan hide opsi notif di email
      isFiltered.value = true;
    }

    if(!isChoosenEmail.value) {
      selectedEmail.value = "-1";
      selectedEmailValue.value = "-1";
    }
    else {
      selectedEmailValue.value = selectedEmail.value;
    }

    if(!isChoosenAplikasi.value) {
      selectedAplikasi.value = "-1";
      selectedAplikasiValue.value = "-1";
    }
    else {
      selectedAplikasiValue.value = selectedAplikasi.value;
    }

    printCheck();
  }

  void printCheck() {
    log(" === START === ");
    log("BF: " + isChoosenBf.toString());
    log("TM: " + isChoosenTm.toString());
    log("Buyer: " + isChoosenBuyer.toString());
    log("Email: " + isChoosenEmail.toString());
    log("Aplikasi: " + isChoosenAplikasi.toString());

    log("Show BF: " + isShowBf.toString());
    log("Show TM: " + isShowTm.toString());
    log("Show Buyer: " + isShowBuyer.toString());
    log("Show Email: " + isShowEmail.toString());
    log("Show Aplikasi: " + isShowAplikasi.toString());

    log("Selected Email: " + selectedEmail.value);
    log("Selected Aplikasi: " + selectedAplikasi.value);
    log(" === END === ");
  }

  void printListContent() {
    log(" === PRINT LIST CONTENT === ");
    log(" === START === ");
    log("List length: " + listModelManajemenVerifikasi.length.toString());
    for(int i = 0; i < listModelManajemenVerifikasi.length; i++) {
      log((i+1).toString() + ". CATEGORY NAME: " + listModelManajemenVerifikasi[i].categoryName + " - ID: " + listModelManajemenVerifikasi[i].categoryIdentifier.toString() + ", SUB CATEGORY NAME: " + listModelManajemenVerifikasi[i].subCategoryName + " - ID: " + listModelManajemenVerifikasi[i].subCategoryIdentifier.toString() + ", Email Notif: " + listModelManajemenVerifikasi[i].emailNotif.toString() + ", Push Notif: " + listModelManajemenVerifikasi[i].pushNotif.toString());
    }
    log(" === END === ");

    log(" ### ### BREAK ### ### ");

    log(" === PRINT LIST CONTENT BF === ");
    log(" === START === ");
    log("List length bf: " + listModelManajemenVerifikasiBf.length.toString());
    for(int i = 0; i < listModelManajemenVerifikasiBf.length; i++) {
      log((i+1).toString() + ". CATEGORY NAME: " + listModelManajemenVerifikasiBf[i].categoryName + " - ID: " + listModelManajemenVerifikasiBf[i].categoryIdentifier.toString() + ", SUB CATEGORY NAME: " + listModelManajemenVerifikasiBf[i].subCategoryName + " - ID: " + listModelManajemenVerifikasiBf[i].subCategoryIdentifier.toString() + ", Email Notif: " + listModelManajemenVerifikasiBf[i].emailNotif.toString() + ", Push Notif: " + listModelManajemenVerifikasiBf[i].pushNotif.toString());
    }
    log(" === END === ");

    log(" ### ### BREAK ### ### ");

    log(" === PRINT LIST CONTENT TM === ");
    log(" === START === ");
    log("List length tm: " + listModelManajemenVerifikasiTm.length.toString());
    for(int i = 0; i < listModelManajemenVerifikasiTm.length; i++) {
      log((i+1).toString() + ". CATEGORY NAME: " + listModelManajemenVerifikasiTm[i].categoryName + " - ID: " + listModelManajemenVerifikasiTm[i].categoryIdentifier.toString() + ", SUB CATEGORY NAME: " + listModelManajemenVerifikasiTm[i].subCategoryName + " - ID: " + listModelManajemenVerifikasiTm[i].subCategoryIdentifier.toString() + ", Email Notif: " + listModelManajemenVerifikasiTm[i].emailNotif.toString() + ", Push Notif: " + listModelManajemenVerifikasiTm[i].pushNotif.toString());
    }
    log(" === END === ");
  }

  bool checkIsFiltered() {
    if(isChoosenBf.value || isChoosenTm.value || isChoosenBuyer.value || isChoosenEmail.value || isChoosenAplikasi.value) {
      return true;
    }
    return false;
  }

  // bool checkShowItem() {
  //   if(isShowGeneral.value && isShowBf.value && isShowTm.value && isShowBuyer.value) {
  //     return true;
  //   }
  //   return false;
  // }

}
