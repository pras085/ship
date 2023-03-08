import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  GlobalKey keyTutor0 = GlobalKey();
  GlobalKey keyTutor1 = GlobalKey();
  GlobalKey keyTutor2 = GlobalKey();
  GlobalKey keyTutor3 = GlobalKey();
  GlobalKey keyTutor4 = GlobalKey();
  GlobalKey keyTutor5 = GlobalKey();

  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = List();

  @override
  void onInit() async {
    super.onInit();
    getDataCek();
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
