import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/alert_dialog/subscription_popup_keuntungan.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/api_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subscription/create_subscription_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/check_segmented_user.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/subscription_data_langganan.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/subscription_sub_user.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/tipe_paket.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_user_status.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class SubscriptionHomeController extends GetxController {
  var loading = true.obs;

  // CheckSegmentedUserModel dataCek;
  SubscriptionDataLanggananModel dataPaketNow;
  SubscriptionDataLanggananModel dataPaketPast;
  SubscriptionDataLanggananModel dataPaketNext;
  TipePaketSubscription tipe;
  List<SubscriptionSubUserModel> listDataSubUser = [];
  bool isRiwayatSubUser = false;
  var indexSubUser = 0.obs;
  bool isSegmented = false;
  bool isTrial = false;
  // bool isSegmented = true;
  var indexPopup = 0.obs;
  UserStatus userStatus = UserStatus();
  List<SubscriptionPopupKeuntunganModel> listKeuntungan = [
    SubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_1.svg',
      'SubscriptionPopupTitle1'.tr,
      'SubscriptionPopupMessage1'.tr,
    ),
    SubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_3.svg',
      'SubscriptionPopupTitle3'.tr,
      'SubscriptionPopupMessage3'.tr,
    ),
    SubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_4.svg',
      'SubscriptionPopupTitle4'.tr,
      'SubscriptionPopupMessage4'.tr,
    ),
    SubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_2.svg',
      'SubscriptionPopupTitle2'.tr,
      'SubscriptionPopupMessage2'.tr,
    ),
    SubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_5.svg',
      'SubscriptionPopupTitle5'.tr,
      'SubscriptionPopupMessage5'.tr,
    ),
    SubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_6.svg',
      'SubscriptionPopupTitle6'.tr,
      'SubscriptionPopupMessage6'.tr,
    ),
  ];

  var dateTimeFormat = DateFormat('dd MMM yyyy');

  GlobalKey keyTutor0 = GlobalKey();
  GlobalKey keyTutor1 = GlobalKey();
  GlobalKey keyTutor2 = GlobalKey();
  GlobalKey keyTutor3 = GlobalKey();
  GlobalKey keyTutor4 = GlobalKey();
  GlobalKey keyTutor5 = GlobalKey();

  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = List();

  var hasAccessTambahLangganan = true.obs;
  var hasAccessTambahSubUser = true.obs;
  var hasAccessLihatDaftarSubUser = true.obs;
  var hasAccessLihatRiwayatLangganan = true.obs;
  var hasAccessLihatRiwayatLanggananSubUser = true.obs;
  var hasAccessTambahLanggananBerikutnya = true.obs;
  var hasAccessTambahSubUserLanggananBerikutnya = true.obs;
  var hasAccessPilihUserLanggananBerikutnya = true.obs;

  @override
  void onInit() async {
    super.onInit();
    getDataCek();

    hasAccessTambahLangganan.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "16", showDialog: false);
    hasAccessTambahSubUser.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "400", showDialog: false);
    hasAccessLihatDaftarSubUser.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "401", showDialog: false);
    hasAccessLihatRiwayatLangganan.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "402", showDialog: false);
    hasAccessLihatRiwayatLanggananSubUser.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "574", showDialog: false);
    hasAccessTambahLanggananBerikutnya.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "403", showDialog: false);
    hasAccessTambahSubUserLanggananBerikutnya.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "404", showDialog: false);
    hasAccessPilihUserLanggananBerikutnya.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "405", showDialog: false);

    hasAccessTambahLangganan.value = false;
    hasAccessTambahSubUser.value = false;
    hasAccessLihatDaftarSubUser.value = false;
    hasAccessLihatRiwayatLangganan.value = false;
    hasAccessLihatRiwayatLanggananSubUser.value = false;
    hasAccessTambahLanggananBerikutnya.value = false;
    hasAccessTambahSubUserLanggananBerikutnya.value = false;
    hasAccessPilihUserLanggananBerikutnya.value = false;
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void resultPembayaranSubsciption(String namaPaket, String periode,
      {bool kredit = true}) {
    var textPeriode = periode.replaceAll("-", "sampai dengan");
    if (!kredit) {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          isDismissible: false,
          title: "SubscriptionLabelSelamatBerhasil".tr,
          message:
              "${'SubscriptionSubscriptionSuccessAlert1'.tr} $namaPaket. ${'SubscriptionSubscriptionSuccessAlert2'.tr} $textPeriode",
          labelButtonPriority1: "Oke",
          positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
    } else {
      GlobalAlertDialog.showAlertDialogCustom(
          insetPadding: 16,
          borderRadius: 15,
          widthButton1: 254,
          heightButton1: 32,
          fontSizeButton1: 12,
          context: Get.context,
          isDismissible: false,
          title: "",
          customMessage: Container(
            margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(Get.context) * 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: GlobalVariable.ratioWidth(Get.context) * 28),
                  child: SvgPicture.asset("assets/pembayaran_berhasil.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 124,
                      height: GlobalVariable.ratioWidth(Get.context) * 124),
                ),
                CustomText(
                  "SubscriptionPaymentSuccess".tr,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                Container(height: GlobalVariable.ratioWidth(Get.context) * 11),
                CustomText(
                  "${'SubscriptionSubscriptionSuccessAlert1'.tr} $namaPaket. ${'SubscriptionSubscriptionSuccessAlert2'.tr} $textPeriode",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          labelButtonPriority1: "SubscriptionLabelKembaliKeMuatmuat".tr,
          positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
    }
    getDataCek();
  }

  getDataCek() async {
    loading.value = true;
     try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: false).getUserStatus({});
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          userStatus = UserStatus.fromJson(response["Data"]);
          isSegmented = true;
          if(userStatus.userLevel == -2) {
            isTrial = true;
          }
          await getDataLangganan();
            //SEMENTARA DIKOMEN KARENA ALUR TIDAK JELAS KARENA USER 2 TRIAL
            // if (userStatus.isFirstBFShipper == 1) {
            //   tipe = TipePaketSubscription.FIRST;
            //   var result = await SharedPreferencesHelper
            //       .getSubscriptionKeuntunganBerlangganan();
            //   if (!result) {
            //     SubscriptionPopupKeuntungan.showAlertDialog(
            //         context: Get.context,
            //         onTap: () async {
            //           var result =
            //               await GetToPage.toNamed<CreateSubscriptionController>(
            //                   Routes.CREATE_SUBSCRIPTION,
            //                   arguments: [
            //                 !(tipe == TipePaketSubscription.FIRST),
            //                 userStatus.isFirstBFShipper == 1,
            //                 "",
            //                 ""
            //               ]);
            //           if (result != null) {
            //             resultPembayaranSubsciption(result[0], result[1],
            //                 kredit: result[2]);
            //           }
            //         });
            //     //show pop up
            //   }
            // } else {
            //   await getDataLangganan();
            // }
          
          
        } else {
          // error
        }
      } else {
        // error
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
    }

    loading.value = false;
  }

  getDataLangganan() async {
    MessageFromUrlModel message;
    dataPaketNow = null;
    dataPaketPast = null;
    dataPaketNext = null;

    ///"DataLanggananPast":{},
    /// "DataLanggananNow":{
    // String json = '''
    // {"Data":{
    //       "DataLanggananNext":{},
    //       "DataLanggananPast":{},
    //     "DataLanggananNow":{
    //       "ID":123,
    //       "PaketID":123,
    //       "Name":"Paket 3 Bulan Big Fleetpppp123",
    //       "PacketStartDate":"2022-08-09",
    //       "PacketEndDate":"2022-08-09",
    //       "PeriodeAwal":"2022-AGS-09",
    //       "PeriodeAkhir":"2022-AGS-10",
    //       "FullPeriodeAkhir":"30 sep 2022",
    //       "FullNextPeriode":"29 sep 2022",
    //       "NextPeriode":"123456",
    //       "IsAllowOrder":true,
    //       "IsExpired":false
    //       }
    // }}
    //       ''';
    // Map<String, dynamic> response = jsonDecode(json);

    var response =
        await ApiSubscription(context: Get.context, isShowDialogLoading: false).getDashboardSubscriptionShipper();
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
      if (response['Data']['DataLanggananTrial'].length == 0 &&
          response['Data']['DataLanggananNow'].length == 0 &&
          response['Data']['DataLanggananPast'].length == 0 &&
          response['Data']['DataLanggananNext'].length == 0) {
        tipe = TipePaketSubscription.FIRST;
        await showPopupKeuntungan();
      } else if (response['Data']['DataLanggananTrial'].length != 0) {
        dataPaketNow = SubscriptionDataLanggananModel.fromJson(response['Data']['DataLanggananTrial']);
        if (dataPaketNow.isAllowOrder || response['Data']['DataLanggananNext'].length != 0) {
          tipe = TipePaketSubscription.WILL_EXPIRED;
        } else {
          tipe = TipePaketSubscription.ACTIVE;
        }
        await getDataSubUser();
      } else if (response['Data']['DataLanggananNow'].length != 0) {
        dataPaketNow = SubscriptionDataLanggananModel.fromJson(response['Data']['DataLanggananNow']);
        if (dataPaketNow.isAllowOrder || response['Data']['DataLanggananNext'].length != 0) {
          tipe = TipePaketSubscription.WILL_EXPIRED;
        } else {
          tipe = TipePaketSubscription.ACTIVE;
        }
        await getDataSubUser();
      } else if (response['Data']['DataLanggananPast'].length != 0) {
        dataPaketPast = SubscriptionDataLanggananModel.fromJson(response['Data']['DataLanggananPast']);
        tipe = TipePaketSubscription.EXPIRED;
        await getRiwayatSubUser();
      }
      if (response['Data']['DataLanggananNext'].length != 0) {
        dataPaketNext = SubscriptionDataLanggananModel.fromJson(
            response['Data']['DataLanggananNext']);
      }
    } else {
      //show error
    }
  }

  getDataSubUser() async {
    MessageFromUrlModel message;
    var body = {
      "Role": "2",
      "IsDashboard": "true",
      "IsNext": "0",
    };
    // dynamic response = jsonDecode('''{"Data":[]}''');
    // dynamic response = jsonDecode(
    //     '''{"Data":[{"StartDate":"2022-08-09","EndDate":"2022-08-09","FullStartDate":"2022-AGS-09","FullEndDate":"2022-AGS-10","Quota":2,"Used":1,"NotUsed":1,"IsRange":true},{"StartDate":"2022-08-09","EndDate":"2022-08-09","FullStartDate":"2022-AGS-09","FullEndDate":"2022-AGS-10","Quota":2,"Used":1,"NotUsed":1,"IsRange":true}]}''');
    // dynamic response = jsonDecode(
    //     '''{"Data":[{"StartDate":"2022-08-09","EndDate":"2022-08-09","FullStartDate":"2022-AGS-09","FullEndDate":"2022-AGS-10","Quota":2,"Used":1,"NotUsed":1,"IsRange":true}]}''');
    var response =
        await ApiSubscription(context: Get.context, isShowDialogLoading: false)
            .getTimelineSubscription(body);
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
      List data = response['Data'];
      List<SubscriptionSubUserModel> temp = [];
      listDataSubUser = [];
      data.forEach((element) {
        temp.add(SubscriptionSubUserModel.fromJson(element));
      });
      temp.forEach((element) {
        if (element.isRange) {
          if (element.quota > 0) {
            listDataSubUser.add(element);
          }
        }
      });
      await getRiwayatSubUser();
    } else {
      //show error
    }
  }

  getRiwayatSubUser() async {
    MessageFromUrlModel message;
    var query = {
      "Role": "2",
    };
    // dynamic response = jsonDecode('''{"Data":[{"StartDate":"2022-08-09"}]}''');
    // dynamic response = jsonDecode('''{"Data":[]}''');
    var response =
        await ApiSubscription(context: Get.context, isShowDialogLoading: false)
            .getRiwayatSubUsers(query);
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
      List data = response['Data'];
      isRiwayatSubUser = data.length > 0;
    } else {
      //show error
    }
  }

  showPopupKeuntungan() async {
    if (userStatus.isFirstBFShipper == 1) {
      tipe = TipePaketSubscription.FIRST;
      var result = await SharedPreferencesHelper.getSubscriptionKeuntunganBerlangganan();
      if (!result) {
        SubscriptionPopupKeuntungan.showAlertDialog(
            context: Get.context,
            onTap: () async {
              if (!hasAccessTambahLangganan.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
              // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "16");
              // if (!hasAccess) {
              //   return;
              // }
              var result =
                  await GetToPage.toNamed<CreateSubscriptionController>(
                      Routes.CREATE_SUBSCRIPTION,
                      arguments: [
                    !(tipe == TipePaketSubscription.FIRST),
                    userStatus.isFirstBFShipper == 1,
                    "",
                    ""
                  ]);
              if (result != null) {
                resultPembayaranSubsciption(result[0], result[1],
                    kredit: result[2]);
              }
            });
        //show pop up
      }
    }
  }

  void showTutorial(context) {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Color(ListColor.colorBlue3),
      hideSkip: true,
      textSkip: "",
      paddingFocus: GlobalVariable.ratioWidth(Get.context) * 7,
      opacityShadow: 0.9,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onSkip: () {
        print("skip");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
    )..show();
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyTutor0,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    color: Colors.purple,
                    width: GlobalVariable.ratioWidth(Get.context) * 296,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 0,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 14
                      ),
                      child: CustomText(
                        "Paket Langganan Saat Ini",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 21.78/18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomText(
                      "Pada section ini Anda dapat melihat status dan periode paket langganan Anda. Saat Ini Anda menikmati akses gratis Big Fleets selama 6 bulan.",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 18.2/14,
                      color: Colors.white,
                    ),
                ],
              ),
            ))
        ],
        shape: ShapeLightFocus.RRect,
        radius: GlobalVariable.ratioWidth(Get.context) * 10,
      ),
    );
  }
}
