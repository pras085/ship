import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/detail_info_pra_tender/detail_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/edit_info_pra_tender/edit_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_invited_transporter_tender/list_invited_transporter_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_rute_tender/select_rute_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/text_form_field_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:latlong/latlong.dart';

class DetailInfoPraTenderView extends GetView<DetailInfoPraTenderController> {
  AppBar _appBar = AppBar(
    title: Text('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: onWillPop,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: Color(ListColor.colorBlue),
                statusBarIconBrightness: Brightness.light),
            child: SafeArea(
                child: Scaffold(
                    extendBody: true,
                    appBar: AppBar(
                       toolbarHeight: GlobalVariable.ratioWidth(Get.context) * 110,
                      backgroundColor: GlobalVariable.appsMainColor,
                      leadingWidth:
                          GlobalVariable.ratioWidth(Get.context) * (24 + 16),
                      leading: Container(
                          padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                          ),
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      "ic_back_button.svg",
                                  color: GlobalVariable
                                      .tabDetailAcessoriesMainColor))),
                      titleSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
                      title: Obx(() => controller.slideIndex.value > 0
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(Get
                                              .context) *
                                          8,
                                      bottom: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          "InfoPraTenderDetailLabelNomorPraTender"
                                              .tr, // Nomor Pra Tender
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: GlobalVariable
                                              .tabDetailAcessoriesMainColor),
                                      CustomText(controller.kodePraTender.value,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: GlobalVariable
                                              .tabDetailAcessoriesMainColor)
                                    ],
                                  )))
                          : CustomText(
                              controller
                                          .jenisTab ==
                                      "History"
                                  ? "InfoPraTenderDetailLabelDetailHistoryInfoPraTender"
                                      .tr
                                  : "InfoPraTenderDetailLabelDetailInfoPraTender"
                                      .tr, // Detail Info Pra Tender
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color:
                                  GlobalVariable.tabDetailAcessoriesMainColor)),
                      actions: [
                        Obx(() => !controller.isLoading.value
                            ? GestureDetector(
                                onTap: () async {
                                  controller.cekShare =
                                      await SharedPreferencesHelper.getHakAkses(
                                          "Export Detail Info Pra Tender",denganLoading:true);
                                  if (SharedPreferencesHelper.cekAkses(
                                      controller.cekShare)) {
                                    //Untuk Share Data Info Pra Tender
                                    controller.shareDetailInfoPraTender();
                                  }
                                },
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "share_active.svg",
                                    color: controller.cekShare
                                        ? GlobalVariable.tabButtonMainColor
                                        : Color(ListColor.colorAksesDisable),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20))
                            : SizedBox()),
                        Obx(() => !controller.isLoading.value
                            ? controller.jenisTab == "History"
                                ? SizedBox()
                                : Row(
                                    children: [
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14),
                                      GestureDetector(
                                          onTap: () async {
                                            controller.cekEdit =
                                                await SharedPreferencesHelper
                                                    .getHakAkses(
                                                        "Edit Info Pra Tender",denganLoading:true);
                                            if (SharedPreferencesHelper
                                                .cekAkses(controller.cekEdit)) {
                                              var data = await GetToPage.toNamed<
                                                      EditInfoPraTenderController>(
                                                  Routes.EDIT_INFO_PRA_TENDER,
                                                  arguments: [
                                                    controller.idPraTender,
                                                    controller.slideIndex.value
                                                  ]);

                                              if (data != null) {
                                                print('asd');
                                                controller.pageController
                                                    .jumpToPage(0);

                                                controller.getDetail("");
                                              }
                                            }
                                          },
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "ic_edit_white.svg",
                                              color: controller.cekEdit
                                                  ? Colors.white
                                                  : Color(ListColor
                                                      .colorAksesDisable),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20)),
                                    ],
                                  )
                            : SizedBox()),
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 16),
                      ],
                      elevation: 10.0,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(
                            GlobalVariable.ratioWidth(Get.context) * 55),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 16,
                          ),
                          height: GlobalVariable.ratioWidth(Get.context) * 55,
                          //color: Color(ListColor.color4),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.5,
                                  child: Container(
                                      color: Color(ListColor.colorLightBlue5))),
                              Expanded(
                                child: Container(
                                    child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Obx(() => CustomText(
                                          controller.title.value.tr,
                                          color: GlobalVariable
                                              .tabDetailAcessoriesMainColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                    )),
                                    Obx(() => !controller.isLoading.value
                                        ? Obx(
                                            () => Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        (controller.satuanTender
                                                                    .value ==
                                                                2
                                                            ? 5
                                                            : 4);
                                                    i++)
                                                  _buildPageIndicator(
                                                      i ==
                                                          controller
                                                              .slideIndex.value,
                                                      i)
                                              ],
                                            ),
                                          )
                                        : SizedBox())
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                              topRight: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, -5),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 11,
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 22),
                        child: Row(children: [
                          Expanded(
                            flex: 1,
                            child: Obx(() => Opacity(
                                  opacity: controller.slideIndex == 0 ? 0 : 1,
                                  child: MaterialButton(
                                      padding: EdgeInsets.symmetric(
                                vertical:GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20)),
                                        side: BorderSide(
                                          width: GlobalVariable.ratioWidth(Get.context) * 1,
                                            color: Color(ListColor.color4))),
                                    onPressed: !controller.isLoading.value
                                        ? () {
                                            if (controller.slideIndex.value !=
                                                0) {
                                              controller.slideIndex.value--;
                                              controller.pageController
                                                  .animateToPage(
                                                      controller
                                                          .slideIndex.value,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.linear);
                                            }
                                          }
                                        : null,
                                    child: CustomText(
                                      "InfoPraTenderDetailLabelSebelumnya"
                                          .tr, // Sebelumnya
                                      color: Color(ListColor.color4),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          Expanded(
                              flex: 1,
                              child: Obx(() => MaterialButton(
                                    elevation: 0,
                                      padding: EdgeInsets.symmetric(
                                vertical:GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20))),
                                    color: Color(ListColor.color4),
                                    onPressed: !controller.isLoading.value
                                        ? () {
                                            FocusScope.of(Get.context)
                                                .unfocus();
                                            int saveIndex = 0;
                                            if (controller.satuanTender.value ==
                                                2) {
                                              saveIndex = 4;
                                            } else {
                                              saveIndex = 3;
                                            }
                                            if (controller.slideIndex.value !=
                                                saveIndex) {
                                              controller.slideIndex.value++;
                                              controller.pageController
                                                  .animateToPage(
                                                      controller
                                                          .slideIndex.value,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.linear);
                                            } else {
                                              controller.onSave();
                                            }
                                          }
                                        : null,
                                    child: controller.satuanTender.value == 2
                                        ? Obx(() => CustomText(
                                              controller.slideIndex.value == 4
                                                  ? "InfoPraTenderDetailLabelKembaliKeList"
                                                      .tr // Kembali ke List
                                                  : "InfoPraTenderDetailLabelSelanjutnya"
                                                      .tr, // Selanjutnya
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ))
                                        : Obx(() => CustomText(
                                              controller.slideIndex.value == 3
                                                  ? "InfoPraTenderDetailLabelKembaliKeList"
                                                      .tr // Kembali ke List
                                                  : "InfoPraTenderDetailLabelSelanjutnya"
                                                      .tr, // Selanjutnya
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            )),
                                  ))),
                        ])),
                    body: Container(
                        child: Obx(() => !controller.isLoading.value
                            ? Stack(
                                children: [
                                  Container(
                                    color:
                                        Color(ListColor.colorBackgroundTender),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            child: Obx(
                                          () => PageView(
                                            //physics: NeverScrollableScrollPhysics(),
                                            onPageChanged: (index) {
                                              controller.slideIndex.value =
                                                  index;
                                              controller.updateTitle();
                                            },
                                            controller:
                                                controller.pageController,
                                            children:
                                                controller.satuanTender.value ==
                                                        2
                                                    ? [
                                                        firstPage(context),
                                                        secondPage(context),
                                                        thirdPage(context),
                                                        fourthPage(context),
                                                        fifthPage(context),
                                                      ]
                                                    : [
                                                        firstPage(context),
                                                        secondPage(context),
                                                        fourthPage(context),
                                                        fifthPage(context),
                                                      ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )))))));
  }

  Widget _buildPageIndicator(bool isCurrentPage, int index) {
    int saveIndex = 0;
    if (controller.satuanTender.value == 2) {
      saveIndex = 4;
    } else {
      saveIndex = 3;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: GlobalVariable.ratioWidth(Get.context) * 10,
            backgroundColor: GlobalVariable.tabDetailBorderPageIndicatorColor,
            child: CircleAvatar(
                radius: GlobalVariable.ratioWidth(Get.context) * 8,
                backgroundColor: isCurrentPage
                    ? GlobalVariable
                        .tabDetailBackgroundPageIndicatorCurrentColor
                    : GlobalVariable.appsMainColor,
                child: CustomText(
                  (index + 1).toString(),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: isCurrentPage
                      ? GlobalVariable.appsMainColor
                      : GlobalVariable.tabDetailAcessoriesMainColor,
                ))),
        index == saveIndex
            ? SizedBox.shrink()
            : Container(
                height: GlobalVariable.ratioWidth(Get.context) * 2,
                width: GlobalVariable.ratioWidth(Get.context) * 8,
                color: GlobalVariable.tabDetailBorderPageIndicatorColor)
      ],
    );
  }

  Widget firstPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formOne,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 20,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  "InfoPraTenderDetailLabelNomorPraTender"
                      .tr, // Nomor Pra Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                controller.kodePraTender.value,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderDetailLabelTanggalDibuat".tr, // Tanggal Dibuat
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                controller.tanggalDibuat.value,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderDetailLabelDiumumkanKepada"
                      .tr, // Diumumkan Kepada
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              controller.dataSelectedTampil.value.length > 0
                  ? SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 2)
                  : SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 8),
              controller.dataSelectedTampil.value.length > 0
                  ? Obx(() => Column(
                        children: [
                          Wrap(
                            children: [
                              for (var index = 0;
                                  index <
                                      (controller.dataSelectedTampil.value
                                                  .length >
                                              6
                                          ? 6
                                          : controller
                                              .dataSelectedTampil.value.length);
                                  index++)
                                controller.selectedTransporterWidget(
                                    controller.dataSelectedTampil[index], index)
                            ],
                          ),
                        ],
                      ))
                  : SizedBox(),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              controller.jenisTab == "History" ||
                      controller.dataEmailTransporter.length == 0
                  ? SizedBox()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          CustomText(
                              "InfoPraTenderDetailLabelInvitedTransporter"
                                  .tr, // Invited Transporter
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(ListColor.colorGrey3)),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 9),
                          controller.jenisTab == "Aktif"
                              ? Column(
                                  children: [
                                    Material(
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      color: controller.cekKirim
                                          ? Color(ListColor.colorBlue)
                                          : Color(ListColor.colorAksesDisable),
                                      child: InkWell(
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    18),
                                          ),
                                          onTap: () async {
                                            controller.cekKirim =
                                                await SharedPreferencesHelper
                                                    .getHakAkses(
                                                        "Undag Invited Transporter Pra Tender",denganLoading:true);
                                            if (SharedPreferencesHelper
                                                .cekAkses(
                                                    controller.cekKirim)) {
                                              var data = await GetToPage.toNamed<
                                                      ListInvitedTransporterTenderController>(
                                                  Routes
                                                      .LIST_INVITED_TRANSPORTER_TENDER,
                                                  arguments: [
                                                    controller.idPraTender,
                                                    controller.dataEmail.value,
                                                    'PT'
                                                  ]);
                                              if (data != null) {
                                                controller.time.cancel();
                                                controller.getDetail("");
                                              }
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      GlobalVariable.ratioWidth(Get.context) *
                                                          11,
                                                  vertical: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      6),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20)),
                                              child: CustomText(
                                                  'InfoPraTenderDetailLabelKirimLink'
                                                      .tr, // Kirim Link
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600))),
                                    ),
                                    controller.dataEmailTransporter.length > 0
                                        ? SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20)
                                        : SizedBox(),
                                  ],
                                )
                              : SizedBox(),
                          for (var x = 0;
                              x < controller.dataEmailTransporter.length;
                              x++)
                            for (var y = 0;
                                y <
                                    controller
                                        .dataEmailTransporter[x]['data'].length;
                                y++)
                              Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              90,
                                          child: CustomText(
                                              y == 0
                                                  ? controller
                                                          .dataEmailTransporter[
                                                      x]['tanggal']
                                                  : "",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black)),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              controller.dataEmailTransporter[x]
                                                  ['data'][y]['name'],
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  4),
                                          controller.jenisTab == "Aktif"
                                              ? GestureDetector(
                                                  onTap:
                                                      controller.dataEmailTransporter[
                                                                      x]['data']
                                                                  [
                                                                  y]['waktu'] !=
                                                              0
                                                          ? null
                                                          : () async {
                                                              controller
                                                                      .cekKirim =
                                                                  await SharedPreferencesHelper
                                                                      .getHakAkses(
                                                                          "Undag Invited Transporter Pra Tender",denganLoading:true);
                                                              if (SharedPreferencesHelper
                                                                  .cekAkses(
                                                                      controller
                                                                          .cekKirim)) {
                                                                controller.kirimUlang(
                                                                    controller.dataEmailTransporter[x]
                                                                            [
                                                                            'data']
                                                                        [
                                                                        y]['id'],
                                                                    x);
                                                              }
                                                            },
                                                  child: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "AvenirNext",
                                                            color: Color(
                                                                ListColor
                                                                    .color4)),
                                                        children: [
                                                          TextSpan(
                                                              text: "InfoPraTenderDetailLabelKirimUlang"
                                                                  .tr, // Kirim Ulang
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "AvenirNext",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      GlobalVariable.ratioFontSize(Get.context) *
                                                                          14,
                                                                  color: controller
                                                                          .cekKirim
                                                                      ? controller.dataEmailTransporter[x]['data'][y]['waktu'] !=
                                                                              0
                                                                          ? Color(ListColor
                                                                              .colorLightGrey2)
                                                                          : Color(ListColor
                                                                              .colorBlue)
                                                                      : Color(ListColor
                                                                          .colorAksesDisable))),
                                                          WidgetSpan(
                                                              child: SizedBox(
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14)),
                                                          TextSpan(
                                                              text: controller.dataEmailTransporter[x]['data']
                                                                              [y][
                                                                          'waktu'] !=
                                                                      0
                                                                  ? (Duration(
                                                                          seconds: controller.dataEmailTransporter[x]['data'][y][
                                                                              'waktu'])
                                                                      .toString()
                                                                      .substring(
                                                                          2,
                                                                          Duration(seconds: controller.dataEmailTransporter[x]['data'][y]['waktu']).toString().length -
                                                                              7))
                                                                  : "",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "AvenirNext",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey4),
                                                                fontSize: GlobalVariable
                                                                        .ratioFontSize(
                                                                            Get.context) *
                                                                    14,
                                                              )),
                                                        ]),
                                                  ),
                                                )
                                              : SizedBox(),
                                          y !=
                                                  controller
                                                          .dataEmailTransporter[
                                                              x]['data']
                                                          .length -
                                                      1
                                              ? SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      8)
                                              : SizedBox()
                                        ],
                                      ))
                                    ],
                                  )),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24),
                        ]),
              CustomText("InfoPraTenderDetailLabelJudul".tr, //Judul
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(controller.judulPraTender.value,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderDetailLabelTahapTender".tr, // Tahap Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 14),
              //DETAIL TAHAP TENDER
              for (var index = 0;
                  index < controller.dataTahapTender.length;
                  index++)
                controller.listTahapTenderWidget(index),
              //DETAIL TAHAP TENDER
              CustomText(
                  "InfoPraTenderDetailLabelSatuanTender".tr, // Satuan Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),

              CustomText(controller.namaSatuanTender.value,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 56),
            ],
          ),
        ),
      ),
    ));
  }

  Widget secondPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formTwo,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 20,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("InfoPraTenderDetailLabelNamaMuatan".tr, // Nama Muatan
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.namaMuatan.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            CustomText("InfoPraTenderDetailLabelJenisMuatan".tr, // Jenis Muatan
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.jenisMuatan.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection:
                    //KHUSUS SATUAN TENDER VOLUME, DIATAS BERAT
                    controller.satuanTender.value == 3
                        ? VerticalDirection.up
                        : VerticalDirection.down,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("InfoPraTenderDetailLabelBerat".tr, // Berat
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        CustomText(controller.berat.value,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("InfoPraTenderDetailLabelVolume".tr, //Volume
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        CustomText(controller.volume.value,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ])
                ]),
            CustomText(
                "InfoPraTenderDetailLabelDimensiMuatanKoli"
                    .tr, // Dimensi Muatan / Koli
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.dimensiMuatanKoli.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            CustomText("InfoPraTenderDetailLabelJumlahKoli".tr, // Jumlah Koli
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.jumlahKoli.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 56),
          ],
        ),
      ),
    ));
  }

  Widget thirdPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: controller.formThree,
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //KEBUTUHAN
                  for (var index = 0;
                      index < controller.dataTrukTender.length;
                      index++)
                    controller.kebutuhanTrukWidget(index),
                  //KEBUTUHAN
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 56),
                ],
              ),
            ),
          )),
    );
  }

  Widget fourthPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formFour,
        child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //JUMLAH RUTE
              for (var index = 0;
                  index < controller.dataRuteTender.length;
                  index++)
                controller.satuanTender.value == 2
                    ? controller.unitTrukRuteDitenderkanWidget(index)
                    : controller.satuanTender.value == 1
                        ? controller.beratRuteDitenderkanWidget(index)
                        : controller.volumeRuteDitenderkanWidget(index),
              //JUMLAH RUTE
              controller.satuanTender.value == 2
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24)
                  : SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 14),

              Container(
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(ListColor.colorBorderTextbox)),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      controller.satuanTender.value == 1
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      4,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15),
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath + 'ic_berat.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17),
                            )
                          : controller.satuanTender.value == 3
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          15),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          'volume_icon.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          17,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          17),
                                )
                              : controller.satuanTender.value == 2
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              9),
                                      child: SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              'ic_truck_grey.svg',
                                          color: Color(ListColor.colorBlue),
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18),
                                    )
                                  : SizedBox(),
                      Expanded(
                          child: CustomText(
                              'ProsesTenderDetailLabelTotal'.tr +
                                  ' ' +
                                  (controller.satuanTender.value == 2
                                      ? ''
                                      : controller.arrSatuanTender[controller
                                          .satuanTender.value]), //Total
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.colorGrey3))),
                      Container(
                          alignment: controller.satuanTender.value == 2
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          constraints: BoxConstraints(
                              minWidth: GlobalVariable.ratioWidth(Get.context) *
                                  52), // 72
                          child: Obx(
                            () => CustomText(
                                GlobalVariable.formatCurrencyDecimal(controller
                                        .jumlahYangDigunakan
                                        .toString()) +
                                    (controller.satuanTender.value == 2
                                            ? ' Unit'
                                            : controller.satuanTender.value == 1
                                                ? ' Ton'
                                                : ' ' +
                                                    controller
                                                        .satuanVolume.value)
                                        .tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                textAlign: controller.satuanTender.value == 2
                                    ? TextAlign.right
                                    : null,
                                color: Colors.black),
                          ))
                    ],
                  )),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 56),
            ])),
      ),
    );
  }

  Widget fifthPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formFive,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(Get.context) * 20,
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  'InfoPraTenderDetailLabelPersyaratanKualifikasiLampiran'
                      .tr, //Persyaratan Kualifikasi / Lampiran

                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(ListColor.colorGrey3)),
              controller.dataKualifikasiPraTender.length > 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          for (var index = 0;
                              index <
                                  controller.dataKualifikasiPraTender.length;
                              index++)
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      controller.dataKualifikasiPraTender[index]
                                          ['tglDibuat'],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor
                                          .colorTimePersyaratanKualifikasi)),
                                  CustomText(
                                      controller.dataKualifikasiPraTender[index]
                                          ['isi'],
                                      fontSize: 14,
                                      height: 1.4,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  index !=
                                          controller.dataKualifikasiPraTender
                                                  .length -
                                              1
                                      ? SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                      : SizedBox(),
                                ]),
                        ])
                  : controller.nama_file.value == ""
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              CustomText("-",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ])
                      : SizedBox(),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              controller.nama_file.value != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            controller.cekLampiran =
                                await SharedPreferencesHelper.getHakAkses(
                                    "Lihat dan Download File Persyaratan/Lampiran Pra Tender",denganLoading:true);
                            if (SharedPreferencesHelper.cekAkses(
                                controller.cekLampiran)) {
                              controller.lihat(controller.link.value,
                                  controller.nama_file.value);
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: controller.cekLampiran
                                          ? Color(ListColor.colorBlue)
                                          : Color(ListColor.colorAksesDisable)),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          50)),
                              child: CustomText(
                                  'InfoPraTenderDetailLabelLihatLampiran'
                                      .tr, // Lihat
                                  fontSize: 12,
                                  color: controller.cekLampiran
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorAksesDisable),
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            controller.cekLampiran =
                                await SharedPreferencesHelper.getHakAkses(
                                    "Lihat dan Download File Persyaratan/Lampiran Pra Tender",denganLoading:true);
                            if (SharedPreferencesHelper.cekAkses(
                                controller.cekLampiran)) {
                              controller.shareData(controller.link.value, true);
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          11,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4),
                              decoration: BoxDecoration(
                                  color: controller.cekLampiran
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorAksesDisable),
                                  border: Border.all(
                                      color: controller.cekLampiran
                                          ? Color(ListColor.colorBlue)
                                          : Color(ListColor.colorAksesDisable)),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          50)),
                              child: CustomText(
                                  'InfoPraTenderDetailLabelBagikan'
                                      .tr, // Download
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
              CustomText(
                  'InfoPraTenderDetailLabelCatatanTambahan'
                      .tr, // Catatan Tambahan
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              controller.dataNote.length > 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          for (var index = 0;
                              index < controller.dataNote.length;
                              index++)
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      controller.dataNote[index]['tglDibuat'],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor
                                          .colorTimePersyaratanKualifikasi)),
                                  CustomText(controller.dataNote[index]['isi'],
                                      fontSize: 14,
                                      height: 1.4,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  index != controller.dataNote.length - 1
                                      ? SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                      : SizedBox()
                                ]),
                        ])
                  : CustomText("-",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
              SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
              controller.status.value.toString() != "1"
                  ? Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              'InfoPraTenderDetailLabelStatus'
                                  .tr, // Status Info Pra Tender
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.colorGrey3)),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          CustomText(
                              controller.status.value.toString() == "2"
                                  ? 'InfoPraTenderDetailLabelSelesai'
                                      .tr // Selesai
                                  : controller.status.value.toString() == "3"
                                      ? 'InfoPraTenderDetailLabelBatal'
                                          .tr // Batal
                                      : "",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: controller.status.value.toString() == "2"
                                  ? Color(ListColor.colorLabelSelesai)
                                  : controller.status.value.toString() == "3"
                                      ? Color(ListColor.colorLabelBatal)
                                      : Colors.transparent)
                        ],
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 56),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (controller.time != null) {
      controller.time.cancel();
    }

    Get.back();
  }
}
