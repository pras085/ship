import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_search/ZO_pilih_pemenang_search_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoPilihPemenangSearchView
    extends GetView<ZoPilihPemenangSearchController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(context) * 53),
            child: Container(
              // height: GlobalVariable.ratioWidth(context) * 56.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ], color: Colors.white),
              child: Obx(
                () => Stack(alignment: Alignment.bottomCenter, children: [
                  Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(context) * 10.0,
                          GlobalVariable.ratioWidth(context) * 12.0,
                          GlobalVariable.ratioWidth(context) * 10.0,
                          GlobalVariable.ratioWidth(context) * 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: ClipOval(
                              child: Material(
                                  shape: CircleBorder(),
                                  color: Color(ListColor.color4),
                                  child: InkWell(
                                      onTap: () {
                                        // controller.onClearSearch();
                                        Get.back();
                                      },
                                      child: Container(
                                          width:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  28,
                                          height: GlobalVariable.ratioFontSize(
                                                  context) *
                                              28,
                                          child: Center(
                                              child: Icon(
                                            Icons.arrow_back_ios_rounded,
                                            size: GlobalVariable.ratioFontSize(
                                                    context) *
                                                19,
                                            color: Colors.white,
                                          ))))),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                CustomTextField(
                                  key: ValueKey("CariPesertaLelang"),
                                  context: Get.context,
                                  autofocus: true,
                                  // onTap: () {
                                  //   controller.onTapTextField.value = true;
                                  // },
                                  onChanged: (value) {
                                    controller.addTextSearch(value);
                                  },
                                  controller: controller.cari.value,
                                  textInputAction: TextInputAction.search,
                                  // onSubmitted: (value) {
                                  //   controller.onSubmitSearch();
                                  // },
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  newContentPadding: EdgeInsets.symmetric(
                                      horizontal: 42,
                                      vertical:
                                          GlobalVariable.ratioWidth(context) *
                                              6),
                                  textSize:
                                      GlobalVariable.ratioFontSize(context) *
                                          14,
                                  newInputDecoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText:
                                        "LelangMuatTabHistoryTabHistoryLabelTitleCariPesertaLelang"
                                            .tr, // "Cari Area Pick Up",
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Color(ListColor.colorLightGrey2),
                                        fontWeight: FontWeight.w600),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 7),
                                  child: SvgPicture.asset(
                                    "assets/search_magnifition_icon.svg",
                                    width: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        28,
                                    height: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        28,
                                  ),
                                ),
                                if (controller.onTapTextField.value)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.onClearSearch();
                                        controller.onTapTextField.value = false;
                                        controller.istidakadadata.value = false;
                                        // controller.addTextSearch("");
                                        // controller.onSubmitSearch();
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Color(ListColor.colorGrey3),
                                            size: GlobalVariable.ratioFontSize(
                                                    Get.context) *
                                                28,
                                          )),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 4,
                          ),
                          Obx(() => GestureDetector(
                              onTap: () {
                                if (controller.listParticipant.value.length >
                                    0) {
                                  controller.showSort();
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: controller.issort.isTrue
                                      ? SvgPicture.asset(
                                          "assets/ic_sort_aktif_black.svg",
                                          width: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              22,
                                          height: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              22,
                                        )
                                      : SvgPicture.asset(
                                          "assets/sorting_icon.svg",
                                          width: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              22,
                                          height: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              22,
                                          color: controller
                                                      .listParticipant.length ==
                                                  0
                                              ? Color(ListColor.colorLightGrey2)
                                              : Colors.black,
                                        ))))
                        ],
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
          ),
          body: Obx(() => (controller.listParticipant.length > 0 &&
                  !controller.istidakadadata.value)
              ? controller.isLoading.isTrue
                  ? Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _adaDataPencarian()
              : controller.cari.value.text != ""
                  ? controller.isLoading.isTrue
                      ? Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : _tidakAdaDataPencarian()
                  : controller.isLoading.isTrue
                      ? Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox.shrink())),
    );
  }

  _tidakAdaDataPencarian() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                top: GlobalVariable.ratioWidth(Get.context) * 20),
            child: Html(
                style: {
                  "body":
                      Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero)
                },
                data: '<span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 500; color: #7C9CBF;">' +
                    'LelangMuatBuatLelangBuatLelangLabelTitleTidakDitemukanHasil'
                        .tr +
                    '</span> <span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000;">"${controller.cari.value.text}"</span>')),
        Expanded(
            child: Center(
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: SvgPicture.asset(
                          "assets/ic_management_lokasi_no_search.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 82.3,
                          height: GlobalVariable.ratioWidth(Get.context) * 75,
                        )),
                        Container(
                          height: 12,
                        ),
                        Container(
                            child: CustomText(
                          "LocationManagementLabelNoKeywordFoundFilter"
                              .tr
                              .replaceAll("\\n", "\n"),
                          textAlign: TextAlign.center,
                          color: Color(ListColor.colorLightGrey14),
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          height: 1.2,
                        ))
                      ],
                    ))))
      ],
    );
  }

  _adaDataPencarian() {
    return Obx(() => SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        controller: controller.refreshPesertaLelang,
        onLoading: () {
          controller.loadData();
        },
        onRefresh: () {
          controller.refreshDataSmart();
        },
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                    top: GlobalVariable.ratioWidth(Get.context) * 20),
                child: Html(
                    style: {
                      "body": Style(
                          margin: EdgeInsets.zero, padding: EdgeInsets.zero)
                    },
                    data: '<span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 500; color: #7C9CBF;">' +
                        'LelangMuatBuatLelangBuatLelangLabelTitleMenampilkan'
                            .tr +
                        ' ${controller.listParticipant.value.length} ' +
                        'LelangMuatBuatLelangBuatLelangLabelTitleHasilUntuk'
                            .tr +
                        '</span> <span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000;">"${controller.cari.value.text}"</span>')),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioFontSize(Get.context) * 16,
                    GlobalVariable.ratioFontSize(Get.context) * 0,
                    GlobalVariable.ratioFontSize(Get.context) * 16,
                    GlobalVariable.ratioFontSize(Get.context) * 14),
                child: controller.isLoading.isTrue
                    ? Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Column(
                        children: [
                          if (controller.listParticipant.length > 0)
                            for (var i = 0;
                                i < controller.listParticipant.length;
                                i++)
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14),
                                child: listPerItem(i),
                              ),
                        ],
                      )),
          ],
        )));
  }

  Widget listPerItem(int index) {
    double borderRadius = 10;
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8.5,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorLightBlue9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: GlobalVariable.ratioFontSize(Get.context) * 32,
                      width: GlobalVariable.ratioFontSize(Get.context) * 32,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(controller
                            .listParticipant.value[index]["TransporterAvatar"]),
                      ),
                    ),
                    SizedBox(
                        width: GlobalVariable.ratioFontSize(Get.context) * 16),
                    Container(
                        child: CustomText(
                            controller.listParticipant.value[index]
                                ["TransporterName"],
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            fontWeight: FontWeight.w600)),
                    Expanded(child: SizedBox.shrink())
                  ],
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 14),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/ic_truck_blue.svg",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  18,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      18,
                            ),
                          )),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                                "LelangMuatPesertaLelangPesertaLelangLabelTitleJumlahTrukTersedia"
                                    .tr,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                // maxLines: 1,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14,
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (16.8 / 14)),
                            SizedBox(height: 8),
                            CustomText(
                                controller
                                    .listParticipant.value[index]["truckOffer"]
                                    .toString(),
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorGrey4),
                                // maxLines: 1,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14,
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (16.8 / 14))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioFontSize(Get.context) * 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: Image.asset(
                              "assets/ic_menu_dashboard_promo_transport.png",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  18,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      18,
                              color: Color(ListColor.color4),
                            ),
                          )),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                                "LelangMuatPesertaLelangPesertaLelangLabelTitleHargaDitawarkanPerUnit"
                                    .tr,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                // maxLines: 1,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14,
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (16.8 / 14)),
                            SizedBox(height: 8),
                            CustomText(
                                controller
                                    .converttoIDR(controller.listParticipant
                                        .value[index]["initialPrice"])
                                    .toString(),
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorGrey4),
                                // maxLines: 1,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14,
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (16.8 / 14))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioFontSize(Get.context) * 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/truck_plus_blue.svg",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  18,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      18,
                            ),
                          )),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                              "LelangMuatPesertaLelangPesertaLelangLabelTitleJumlahTrukDipilih"
                                  .tr,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              // maxLines: 1,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                          SizedBox(height: 8),
                          CustomText(
                              controller.listParticipant.value[index]
                                          ["qtyAccepted"] ==
                                      0
                                  ? "-"
                                  : controller.listParticipant
                                      .value[index]["qtyAccepted"]
                                      .toString(),
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorGrey4),
                              // maxLines: 1,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14))
                        ],
                      )),
                    ],
                  )
                ],
              ),
            ),
            Container(
              //garis
              width: MediaQuery.of(Get.context).size.width,
              height: 0.5,
              color: Color(ListColor.colorLightGrey10),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: SizedBox.shrink()),
                  Container(
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onTap: () {
                            showdialogMasukanJumlahTruk(index);
                            if (controller.listParticipant.value[index]
                                    ["qtyAccepted"] ==
                                0) {
                              controller.erorKelebihanInputJumlahTruk.value =
                                  false;
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: controller.listParticipant.value[index]
                                            ["qtyAccepted"] ==
                                        0
                                    ? CustomText(
                                        'LelangMuatPesertaLelangPesertaLelangLabelTitlePilih'
                                            .tr,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)
                                    : CustomText(
                                        'LelangMuatPesertaLelangPesertaLelangLabelTitleUbah'
                                            .tr,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                              ))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _lineSaparator() {
    return Container(
        height: GlobalVariable.ratioWidth(Get.context) * 1,
        margin: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * 16,
            right: GlobalVariable.ratioWidth(Get.context) * 16),
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey10));
  }

  showdialogMasukanJumlahTruk(int indx) {
    if (controller.listParticipant.value[indx]["qtyAccepted"] > 0) {
      controller.jumlahtruck.value.text =
          controller.listParticipant.value[indx]["qtyAccepted"].toString();
    }
    showDialog(
        context: Get.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              Get.back();
              controller.jumlahtruck.value.text = "";
            },
            child: Dialog(
                // key: GlobalKey<State>(),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Obx(
                  () => Container(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(alignment: Alignment.bottomCenter, children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 3, top: 3),
                              child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    controller.jumlahtruck.value.text = "";
                                  },
                                  child: Container(
                                      padding:
                                          EdgeInsets.only(right: 5, top: 5),
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Color(ListColor.color4),
                                        size: GlobalVariable.ratioFontSize(
                                                context) *
                                            24,
                                      ))),
                            )),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Container(
                          child: Column(
                            children: [
                              controller.listParticipant.value[indx]
                                          ["qtyAccepted"] ==
                                      0
                                  ? CustomText(
                                      "LelangMuatPesertaLelangPesertaLelangLabelTitlePopJumlahTruk"
                                              .tr
                                              .replaceAll("\\n", "\n") +
                                          " ${controller.listParticipant.value[indx]["TransporterName"]}",
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.center,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              context) *
                                          14,
                                      color: Colors.black)
                                  : CustomText(
                                      "LelangMuatPesertaLelangPesertaLelangLabelTitlePopUbahJumlahTruk"
                                              .tr
                                              .replaceAll("\\n", "\n") +
                                          " ${controller.listParticipant.value[indx]["TransporterName"]}",
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.center,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              context) *
                                          14,
                                      color: Colors.black),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    "LelangMuatPesertaLelangPesertaLelangLabelTitleJumlahTruk"
                                        .tr,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.start,
                                    fontSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            12,
                                    color: Color(ListColor.colorLightGrey4)),
                                SizedBox(
                                  height: 8,
                                ),
                                Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      CustomTextField(
                                          context: Get.context,
                                          controller:
                                              controller.jumlahtruck.value,
                                          onChanged: (value) {
                                            if (value.length == 0) {
                                              controller
                                                  .erorKelebihanInputJumlahTruk
                                                  .value = false;
                                            }
                                            if (int.parse(value) >
                                                int.parse(
                                                    controller.sisa.value)) {
                                              controller
                                                  .erorKelebihanInputJumlahTruk
                                                  .value = true;
                                            } else {
                                              controller
                                                  .erorKelebihanInputJumlahTruk
                                                  .value = false;
                                            }
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            ThousanSeparatorFormater()
                                          ],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(
                                                  ListColor.colorLightGrey4),
                                              fontSize:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      14),
                                          newContentPadding: EdgeInsets.symmetric(
                                              horizontal: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12,
                                              vertical: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          textSize: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              14,
                                          newInputDecoration: InputDecoration(
                                            isDense: true,
                                            isCollapsed: true,
                                            hintText:
                                                "Contoh: 20", // "Cari Area Pick Up",
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Color(
                                                    ListColor.colorLightGrey2),
                                                fontWeight: FontWeight.w600,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: controller
                                                          .erorKelebihanInputJumlahTruk
                                                          .isTrue
                                                      ? Color(
                                                          ListColor.colorRed)
                                                      : Color(ListColor
                                                          .colorLightGrey19),
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: controller
                                                          .erorKelebihanInputJumlahTruk
                                                          .isTrue
                                                      ? Color(
                                                          ListColor.colorRed)
                                                      : Color(ListColor
                                                          .colorLightGrey19),
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: controller
                                                          .erorKelebihanInputJumlahTruk
                                                          .isTrue
                                                      ? Color(
                                                          ListColor.colorRed)
                                                      : Color(ListColor
                                                          .colorLightGrey19),
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            margin: EdgeInsets.only(right: 13),
                                            child: CustomText(
                                              "Unit",
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      12,
                                            )),
                                      ),
                                    ]),
                                if (controller
                                    .erorKelebihanInputJumlahTruk.isTrue)
                                  SizedBox(
                                    height: 4,
                                  ),
                                if (controller
                                    .erorKelebihanInputJumlahTruk.isTrue)
                                  CustomText(
                                    "LelangMuatPesertaLelangPesertaLelangLabelTitleInfoKelebihanTruk"
                                        .tr,
                                    color: Color(ListColor.colorRed),
                                    fontSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                if (controller
                                    .erorKelebihanInputJumlahTruk.isFalse)
                                  SizedBox(
                                    height: 20,
                                  ),
                              ],
                            ),
                          )),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor:
                                controller.erorKelebihanInputJumlahTruk.isTrue
                                    ? Color(ListColor.colorLightGrey2)
                                    : Color(ListColor.color4),
                            side: BorderSide(
                                width: 2,
                                color: controller
                                        .erorKelebihanInputJumlahTruk.isTrue
                                    ? Color(ListColor.colorLightGrey2)
                                    : Color(ListColor.color4)),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            )),
                        onPressed: () {
                          if (controller.erorKelebihanInputJumlahTruk.isFalse) {
                            Get.back();
                            var list = [];
                            list.add({
                              "id": controller.listParticipant.value[indx]["ID"]
                                  .toString(),
                              "total": controller.jumlahtruck.value.text
                            });
                            if (controller.jumlahtruck.value.text != "") {
                              controller.simpanJmlTruck(
                                  controller.idBid.value, list);
                              controller.jumlahtruck.value.text = "";
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 28, vertical: 10),
                          child: Stack(alignment: Alignment.center, children: [
                            CustomText("Simpan",
                                fontWeight: FontWeight.w600,
                                color: controller
                                        .erorKelebihanInputJumlahTruk.isTrue
                                    ? Color(ListColor.colorLightGrey4)
                                    : Colors.white),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  )),
                )),
          );
        });
  }
}
