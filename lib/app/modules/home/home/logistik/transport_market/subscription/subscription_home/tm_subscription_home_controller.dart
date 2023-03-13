import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/alert_dialog/tm_subscription_popup_keuntungan.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/api_tm_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/create_subscription/tm_create_subscription_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_check_segmented_user.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_subscription_data_langganan.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_subscription_sub_user.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_tipe_paket.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_user_status.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/tutorial.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TMSubscriptionHomeController extends GetxController {
  var loading = true.obs;

  // TMCheckSegmentedUserModel dataCek;
  TMSubscriptionDataLanggananModel dataPaketNow;
  TMSubscriptionDataLanggananModel dataPaketPast;
  TMSubscriptionDataLanggananModel dataPaketNext;
  TMTipePaketSubscription tipe;
  List<TMSubscriptionSubUserModel> listDataSubUser = [];
  bool isRiwayatSubUser = false;
  var indexSubUser = 0.obs;
  bool isSegmented = false;
  bool isTrial = false;
  var indexPopup = 0.obs;
  UserStatus userStatus = UserStatus();
  List<TMSubscriptionPopupKeuntunganModel> listKeuntungan = [
    TMSubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_1.svg',
      'SubscriptionPopupTitle1TM'.tr,
      'SubscriptionPopupMessage1TM'.tr,
    ),
    TMSubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_3.svg',
      'SubscriptionPopupTitle3TM'.tr,
      'SubscriptionPopupMessage3TM'.tr,
    ),
    TMSubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_4.svg',
      'SubscriptionPopupTitle4TM'.tr,
      'SubscriptionPopupMessage4TM'.tr,
    ),
    TMSubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_2.svg',
      'SubscriptionPopupTitle2TM'.tr,
      'SubscriptionPopupMessage2TM'.tr,
    ),
    TMSubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_5.svg',
      'SubscriptionPopupTitle5TM'.tr,
      'SubscriptionPopupMessage5TM'.tr,
    ),
    TMSubscriptionPopupKeuntunganModel(
      'assets/ic_subscription_keuntungan_6.svg',
      'SubscriptionPopupTitle6TM'.tr,
      'SubscriptionPopupMessage6TM'.tr,
    ),
  ];

  var dateTimeFormat = DateFormat('dd MMM yyyy');

  ScrollController scrollController = ScrollController();
  GlobalKey keyScroll = GlobalKey();
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
    initTargets();
    getDataCek();

    hasAccessTambahLangganan.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "475", showDialog: false);
    hasAccessTambahSubUser.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "476", showDialog: false);
    hasAccessLihatDaftarSubUser.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "477", showDialog: false);
    hasAccessLihatRiwayatLangganan.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "478", showDialog: false);
    hasAccessLihatRiwayatLanggananSubUser.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "479", showDialog: false);
    hasAccessTambahLanggananBerikutnya.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "480", showDialog: false);
    hasAccessTambahSubUserLanggananBerikutnya.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "481", showDialog: false);
    hasAccessPilihUserLanggananBerikutnya.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "482", showDialog: false);

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
          // if (userStatus.isFirstTMShipper == 1) {
          //   tipe = TMTipePaketSubscription.FIRST;
          //   var result = await SharedPreferencesHelper
          //       .getSubscriptionTMKeuntunganBerlangganan();
          //   if (!result) {
          //     TMSubscriptionPopupKeuntungan.showAlertDialog(
          //         context: Get.context,
          //         onTap: () async {
          //           var result =
          //               await GetToPage.toNamed<TMCreateSubscriptionController>(
          //                   Routes.TM_CREATE_SUBSCRIPTION,
          //                   arguments: [
          //                 !(tipe == TMTipePaketSubscription.FIRST),
          //                 userStatus.isFirstTMShipper == 1,
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
    var response = await ApiTMSubscription(context: Get.context, isShowDialogLoading: false).getDashboardSubscriptionShipper();
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
      if (response['Data']['DataLanggananTrial'].length == 0 &&
          response['Data']['DataLanggananNow'].length == 0 &&
          response['Data']['DataLanggananPast'].length == 0 &&
          response['Data']['DataLanggananNext'].length == 0) {
        tipe = TMTipePaketSubscription.FIRST;
        await showPopupKeuntungan();
      } else if (response['Data']['DataLanggananTrial'].length != 0) {
        dataPaketNow = TMSubscriptionDataLanggananModel.fromJson(response['Data']['DataLanggananTrial']);
        if (dataPaketNow.isAllowOrder || response['Data']['DataLanggananNext'].length != 0) {
          tipe = TMTipePaketSubscription.WILL_EXPIRED;
        } else {
          tipe = TMTipePaketSubscription.ACTIVE;
        }
        await getDataSubUser();
      } else if (response['Data']['DataLanggananNow'].length != 0) {
        dataPaketNow = TMSubscriptionDataLanggananModel.fromJson(
            response['Data']['DataLanggananNow']);
        if (dataPaketNow.isAllowOrder ||
            response['Data']['DataLanggananNext'].length != 0) {
          tipe = TMTipePaketSubscription.WILL_EXPIRED;
        } else {
          tipe = TMTipePaketSubscription.ACTIVE;
        }
        await getDataSubUser();
      } else if (response['Data']['DataLanggananPast'].length != 0) {
        dataPaketPast = TMSubscriptionDataLanggananModel.fromJson(
            response['Data']['DataLanggananPast']);
        tipe = TMTipePaketSubscription.EXPIRED;
        await getRiwayatSubUser();
      }
      if (response['Data']['DataLanggananNext'].length != 0) {
        dataPaketNext = TMSubscriptionDataLanggananModel.fromJson(
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
    var response = await ApiTMSubscription(
            context: Get.context, isShowDialogLoading: false)
        .getTimelineSubscription(body);
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
      List data = response['Data'];
      List<TMSubscriptionSubUserModel> temp = [];
      listDataSubUser = [];
      data.forEach((element) {
        temp.add(TMSubscriptionSubUserModel.fromJson(element));
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
    var response = await ApiTMSubscription(
            context: Get.context, isShowDialogLoading: false)
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
    if (userStatus.isFirstTMShipper == 1) {
      tipe = TMTipePaketSubscription.FIRST;
      var result = await SharedPreferencesHelper
          .getSubscriptionTMKeuntunganBerlangganan();
      if (!result) {
        TMSubscriptionPopupKeuntungan.showAlertDialog(
            context: Get.context,
            onTap: () async {
              if (!hasAccessTambahLangganan.value) { CekSubUserDanHakAkses().showDialogNoAccess(context: Get.context); return; }
              // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "475");
              // if (!hasAccess) {
              //   return;
              // }
              var result =
                  await GetToPage.toNamed<TMCreateSubscriptionController>(
                      Routes.TM_CREATE_SUBSCRIPTION,
                      arguments: [
                    !(tipe == TMTipePaketSubscription.FIRST),
                    userStatus.isFirstTMShipper == 1,
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
    Tutorial().showTutor(
      context: context,
      tcm: tutorialCoachMark,
      targets: targets,
      keyScroll: keyScroll,
      scrollController: scrollController,
    );


    // tutorialCoachMark = TutorialCoachMark(
    //   context,
    //   targets: targets,
    //   colorShadow: Color(ListColor.colorBlue3).withOpacity(0.9),
    //   hideSkip: true,
    //   textSkip: "",
    //   paddingFocus: GlobalVariable.ratioWidth(Get.context) * 7,
    //   opacityShadow: 0.9,
    //   onFinish: () {
    //     print("finish");
    //   },
    //   onClickTarget: (target) {
    //     print('onClickTarget: $target');
    //   },
    //   onSkip: () {
    //     print("skip");
    //   },
    //   onClickOverlay: (target) {
    //     print('onClickOverlay: $target');
    //   },
    // )..show();
  }

  void initTargets() {
    targets.add(
      Tutorial().setTarget(
        context: Get.context, 
        identify: "0", 
        globalKey: keyTutor0, 
        title: "Paket Langganan Saat Ini", 
        subTitle: "Pada section ini Anda dapat melihat status dan periode paket langganan Anda. Saat Ini Anda menikmati akses gratis Big Fleets selama 6 bulan.", 
        contentAlign: ContentAlign.bottom, 
        textAlign: ContentAlign.bottom,
        shape: ShapeLightFocus.RRect,
      )
    );

    targets.add(
      Tutorial().setTarget(
        context: Get.context, 
        identify: "1", 
        globalKey: keyTutor1, 
        title: "Langganan Sub User yang Sedang Aktif", 
        subTitle: "Pada section ini Anda juga dapat melihat jumlah Sub User yang telah Anda aktifkan paket berlangganan setiap bulannya.", 
        contentAlign: ContentAlign.top, 
        textAlign: ContentAlign.top,
        shape: ShapeLightFocus.RRect,
      )
    );

    targets.add(
      Tutorial().setTarget(
        context: Get.context, 
        identify: "2", 
        globalKey: keyTutor2, 
        title: "Tentukan Penugasan Sub User", 
        subTitle: "Anda perlu memilih sub user untuk dapat bergabung mengelola perusahaan Anda di muatmuat pada batas periode berlangganan tertentu.", 
        contentAlign: ContentAlign.bottom, 
        textAlign: ContentAlign.bottom,
        shape: ShapeLightFocus.RRect,
      )
    );

    targets.add(
      Tutorial().setTarget(
        context: Get.context, 
        identify: "3", 
        globalKey: keyTutor3, 
        title: "Pembayaran yang Belum Selesai", 
        subTitle: "Lihat Pembayaran yang belum Anda selesaikan setelah Anda berhasil memesan paket berlangganan.", 
        contentAlign: ContentAlign.bottom, 
        textAlign: ContentAlign.bottom,
        shape: ShapeLightFocus.RRect,
      )
    );

    targets.add(
      Tutorial().setTarget(
        context: Get.context, 
        identify: "4", 
        globalKey: keyTutor4, 
        title: "Riwayat Pembayaran Paket Berlangganan", 
        subTitle: "Anda dapat melihat pembayaran paket berlangganan yang pernah berhasil Anda pesan sebelumnya.", 
        contentAlign: ContentAlign.bottom, 
        textAlign: ContentAlign.bottom,
        shape: ShapeLightFocus.RRect,
        skipAlign: Alignment.topRight
      )
    );
  }
}
