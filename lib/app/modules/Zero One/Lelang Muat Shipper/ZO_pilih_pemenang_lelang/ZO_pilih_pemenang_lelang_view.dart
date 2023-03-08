import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_lelang/ZO_pilih_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoPilihPemenangLelangView
    extends GetView<ZoPilihPemenangLelangController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  GlobalVariable.ratioWidth(context) *
                      (_appBar.preferredSize.height + 142)),
              child: Obx(() => Container(
                  height: _appBar.preferredSize.height + 142,
                  color: Color(ListColor.color4),
                  child: Stack(alignment: Alignment.center, children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image(
                        image: AssetImage("assets/fallin_star_3_icon.png"),
                        height: _appBar.preferredSize.height + 10,
                        // width: MediaQuery.of(context).size.width * 0.3,
                        // fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 19,
                          right: GlobalVariable.ratioWidth(Get.context) * 19,
                          top: GlobalVariable.ratioFontSize(Get.context) * 13),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                child: ClipOval(
                                  child: Material(
                                      shape: CircleBorder(),
                                      color: Colors.white,
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
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      28,
                                              child: Center(
                                                  child: Icon(
                                                Icons.arrow_back_ios_rounded,
                                                size: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    19,
                                                color: Color(ListColor.color4),
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
                                      context: Get.context,
                                      readOnly: true,
                                      onTap: () {
                                        controller.searchPesertaLelang();
                                      },
                                      onChanged: (value) {},
                                      // controller: controller
                                      //     .searchTextEditingController.value,
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) {},
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      newContentPadding: EdgeInsets.symmetric(
                                          horizontal: 42,
                                          vertical: GlobalVariable.ratioWidth(
                                                  context) *
                                              6),
                                      textSize: GlobalVariable.ratioFontSize(
                                              context) *
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
                                            color: Color(
                                                ListColor.colorLightGrey2),
                                            fontWeight: FontWeight.w600),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                    // Align(
                                    //     alignment: Alignment.centerRight,
                                    //     child: GestureDetector(
                                    //       onTap: () {},
                                    //       child: Container(
                                    //           margin: EdgeInsets.only(right: 10),
                                    //           child: Icon(
                                    //             Icons.close_rounded,
                                    //             color:
                                    //                 Color(ListColor.colorGrey3),
                                    //             size:
                                    //                 GlobalVariable.ratioFontSize(
                                    //                         Get.context) *
                                    //                     28,
                                    //           )),
                                    //     )),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          0),
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.showSort();
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
                                                  "assets/sort_active_white.svg",
                                                  width: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      22,
                                                  height: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      22,
                                                )
                                              : SvgPicture.asset(
                                                  "assets/sorting_icon.svg",
                                                  width: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      22,
                                                  height: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      22,
                                                  color: Colors.white,
                                                )))),
                            ],
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioFontSize(context) * 26,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            width: MediaQuery.of(context).size.width,
                            height: GlobalVariable.ratioFontSize(context) * 102,
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          "LelangMuatPesertaLelangPesertaLelangLabelTitleKebutuhan"
                                              .tr,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        CustomText(
                                          controller.truckQty.value,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        SizedBox(height: 2),
                                        CustomText(
                                          "Unit",
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  14,
                                          fontWeight: FontWeight.w500,
                                        )
                                      ],
                                    ),
                                  )),
                                  VerticalDivider(
                                    color: Color(ListColor.colorLightGrey10),
                                    width:
                                        GlobalVariable.ratioFontSize(context) *
                                            8,
                                    thickness: 0.5,
                                    // indent: 10,
                                    // endIndent: 10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          "LelangMuatPesertaLelangPesertaLelangLabelTitleTerpilih"
                                              .tr,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        CustomText(
                                          controller.terpilih.value,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        CustomText(
                                          "Unit",
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  14,
                                          fontWeight: FontWeight.w500,
                                        )
                                      ],
                                    ),
                                  )),
                                  VerticalDivider(
                                    color: Color(ListColor.colorLightGrey10),
                                    width:
                                        GlobalVariable.ratioFontSize(context) *
                                            8,
                                    thickness: 0.5,
                                    // indent: 10,
                                    // endIndent: 10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                            "LelangMuatPesertaLelangPesertaLelangLabelTitleSisa"
                                                .tr,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(ListColor.colorRed)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        CustomText(controller.sisa.value,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(ListColor.colorRed)),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        CustomText("Unit",
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(ListColor.colorRed))
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]))),
            ),
            body: Obx(() => Container(
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                    child: SmartRefresher(
                        enablePullUp: true,
                        enablePullDown: true,
                        controller: controller.refreshPesertaLelang,
                        onLoading: () {
                          controller.loadData();
                        },
                        onRefresh: () {
                          controller.refreshDataSmart();
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioFontSize(context) * 16,
                                    GlobalVariable.ratioFontSize(context) * 14,
                                    GlobalVariable.ratioFontSize(context) * 16,
                                    GlobalVariable.ratioFontSize(context) * 14),
                                child: Row(
                                  children: [
                                    Container(child: SizedBox.shrink()),
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomText(
                                        controller.listParticipant.length > 0
                                            ? "LelangMuatTabHistoryTabHistoryLabelTitleTotalPesertaLelang"
                                                    .tr +
                                                " : ${controller.listParticipant.length}"
                                            : "",
                                        color: Colors.black,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      GlobalVariable.ratioFontSize(context) *
                                          16,
                                      GlobalVariable.ratioFontSize(context) * 0,
                                      GlobalVariable.ratioFontSize(context) *
                                          16,
                                      GlobalVariable.ratioFontSize(context) *
                                          14),
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
                                            if (controller
                                                    .listParticipant.length >
                                                0)
                                              for (var i = 0;
                                                  i <
                                                      controller.listParticipant
                                                          .length;
                                                  i++)
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14),
                                                  child: listPerItem(i),
                                                ),
                                          ],
                                        )),
                            ],
                          ),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            GlobalVariable.ratioFontSize(Get.context) * 16,
                        vertical:
                            GlobalVariable.ratioFontSize(Get.context) * 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withAlpha(70),
                              offset: Offset(0, -2),
                              blurRadius: 2,
                              spreadRadius: 3)
                        ]),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              color: Color(ListColor.color4),
                              onPressed: () {
                                if (controller.pilihPemenangLelangList.length >
                                    0) {
                                  controller.pilihPemenangLelang(
                                      controller.idBid.value,
                                      controller.pilihPemenangLelangList.value);
                                }
                              },
                              child: CustomText(
                                  "LelangMuatPesertaLelangPesertaLelangLabelTitlePilihPemenangLelang"
                                      .tr,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ])))));
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
                                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePilih"
                                            .tr,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)
                                    : CustomText(
                                        "LelangMuatPesertaLelangPesertaLelangLabelTitleUbah"
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

  // _opsi(int idx) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       enableDrag: true,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(
  //                   GlobalVariable.ratioWidth(Get.context) * 20),
  //               topRight: Radius.circular(
  //                   GlobalVariable.ratioWidth(Get.context) * 20))),
  //       backgroundColor: Colors.white,
  //       context: Get.context,
  //       builder: (context) {
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Container(
  //                 margin: EdgeInsets.only(
  //                     top: GlobalVariable.ratioWidth(Get.context) * 3,
  //                     bottom: GlobalVariable.ratioWidth(Get.context) * 16),
  //                 child: Container(
  //                   width: GlobalVariable.ratioWidth(Get.context) * 38,
  //                   height: 3,
  //                   decoration: BoxDecoration(
  //                       color: Color(ListColor.colorLightGrey16),
  //                       borderRadius: BorderRadius.all(Radius.circular(20))),
  //                 )),
  //             Stack(
  //               alignment: Alignment.centerLeft,
  //               children: [
  //                 Align(
  //                     alignment: Alignment.center,
  //                     child: Container(
  //                       child: CustomText(
  //                           "LelangMuatBuatLelangBuatLelangLabelTitleOpsi".tr,
  //                           fontWeight: FontWeight.w700,
  //                           color: Color(ListColor.colorBlue),
  //                           fontSize:
  //                               GlobalVariable.ratioFontSize(context) * 14),
  //                     )),
  //                 Container(
  //                     margin: EdgeInsets.only(
  //                         top: FontTopPadding.getSize(14),
  //                         left: GlobalVariable.ratioWidth(Get.context) * 12),
  //                     child: GestureDetector(
  //                       child: Icon(
  //                         Icons.close_rounded,
  //                         size: GlobalVariable.ratioFontSize(Get.context) * 27,
  //                       ),
  //                       onTap: () {
  //                         Get.back();
  //                       },
  //                     )),
  //               ],
  //             ),
  //             _opsiList(context, idx)
  //           ],
  //         );
  //       });
  // }

  // _opsiList(BuildContext context, int idx) {
  //   return Column(
  //     children: [
  //       ListTile(
  //         leading: CustomText(
  //           "LelangMuatPesertaLelangPesertaLelangLabelTitleNego".tr,
  //           fontSize: GlobalVariable.ratioFontSize(context) * 14,
  //           fontWeight: FontWeight.w600,
  //         ),
  //         onTap: () {
  //           Get.back();
  //           showDialog(
  //               context: context,
  //               barrierDismissible: true,
  //               builder: (BuildContext context) {
  //                 return Dialog(
  //                   key: GlobalKey<State>(),
  //                   backgroundColor: Colors.white,
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: Container(
  //                       child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Stack(alignment: Alignment.bottomCenter, children: [
  //                         Align(
  //                             alignment: Alignment.topRight,
  //                             child: Container(
  //                               margin: EdgeInsets.only(right: 3, top: 3),
  //                               child: GestureDetector(
  //                                   onTap: () {
  //                                     Get.back();
  //                                   },
  //                                   child: Container(
  //                                       padding:
  //                                           EdgeInsets.only(right: 5, top: 5),
  //                                       child: Icon(
  //                                         Icons.close_rounded,
  //                                         color: Color(ListColor.color4),
  //                                         size: GlobalVariable.ratioFontSize(
  //                                                 context) *
  //                                             24,
  //                                       ))),
  //                             )),
  //                       ]),
  //                       Container(
  //                         child: Column(
  //                           children: [
  //                             CustomText(
  //                                 "LelangMuatPesertaLelangPesertaLelangLabelTitleReqNegoHarga"
  //                                     .tr,
  //                                 fontWeight: FontWeight.w700,
  //                                 fontSize:
  //                                     GlobalVariable.ratioFontSize(context) *
  //                                         14,
  //                                 color: Colors.black),
  //                             SizedBox(
  //                               height: 4,
  //                             ),
  //                             CustomText("PT. Truck Maju Jaya",
  //                                 fontWeight: FontWeight.w600,
  //                                 fontSize:
  //                                     GlobalVariable.ratioFontSize(context) *
  //                                         12,
  //                                 color: Color(ListColor.colorLightGrey4)),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 24,
  //                       ),
  //                       Container(
  //                         padding:
  //                             EdgeInsets.only(left: 16, right: 16, bottom: 24),
  //                         child: Column(
  //                             mainAxisSize: MainAxisSize.min,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Expanded(
  //                                     child: CustomText(
  //                                         "LelangMuatPesertaLelangPesertaLelangLabelTitleHargaAwal"
  //                                             .tr,
  //                                         fontWeight: FontWeight.w600,
  //                                         fontSize:
  //                                             GlobalVariable.ratioFontSize(
  //                                                     context) *
  //                                                 14,
  //                                         color: Colors.black),
  //                                   ),
  //                                   Expanded(
  //                                     child: CustomText("daj",
  //                                         fontWeight: FontWeight.w600,
  //                                         fontSize:
  //                                             GlobalVariable.ratioFontSize(
  //                                                     context) *
  //                                                 14,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ],
  //                               ),
  //                               SizedBox(
  //                                 height: 20,
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   Expanded(
  //                                     child: CustomText(
  //                                         "LelangMuatPesertaLelangPesertaLelangLabelTitlePermintaanHarga"
  //                                             .tr,
  //                                         fontWeight: FontWeight.w600,
  //                                         fontSize:
  //                                             GlobalVariable.ratioFontSize(
  //                                                     context) *
  //                                                 14,
  //                                         color: Colors.black),
  //                                   ),
  //                                   Expanded(
  //                                     child: CustomTextField(
  //                                         context: Get.context,
  //                                         // controller: controller.nilaiBarang.value,
  //                                         keyboardType: TextInputType.number,
  //                                         inputFormatters: [
  //                                           FilteringTextInputFormatter
  //                                               .digitsOnly,
  //                                           ThousanSeparatorFormater()
  //                                         ],
  //                                         style: TextStyle(
  //                                             fontWeight: FontWeight.w600,
  //                                             color: Color(
  //                                                 ListColor.colorLightGrey4),
  //                                             fontSize:
  //                                                 GlobalVariable.ratioFontSize(
  //                                                         Get.context) *
  //                                                     14),
  //                                         newContentPadding: EdgeInsets.symmetric(
  //                                             horizontal:
  //                                                 GlobalVariable.ratioWidth(
  //                                                         Get.context) *
  //                                                     12,
  //                                             vertical:
  //                                                 GlobalVariable.ratioWidth(
  //                                                         Get.context) *
  //                                                     8),
  //                                         textSize: GlobalVariable.ratioFontSize(
  //                                                 Get.context) *
  //                                             14,
  //                                         newInputDecoration: InputDecoration(
  //                                           isDense: true,
  //                                           isCollapsed: true,
  //                                           hintText:
  //                                               "Rp 900.000", // "Cari Area Pick Up",
  //                                           fillColor: Colors.white,
  //                                           filled: true,
  //                                           hintStyle: TextStyle(
  //                                               color: Color(
  //                                                   ListColor.colorLightGrey2),
  //                                               fontWeight: FontWeight.w600,
  //                                               fontSize: GlobalVariable
  //                                                       .ratioFontSize(
  //                                                           Get.context) *
  //                                                   14),
  //                                           enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Color(ListColor
  //                                                     .colorLightGrey19),
  //                                                 width: 1.0),
  //                                             borderRadius:
  //                                                 BorderRadius.circular(6),
  //                                           ),
  //                                           border: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Color(ListColor
  //                                                     .colorLightGrey19),
  //                                                 width: 1.0),
  //                                             borderRadius:
  //                                                 BorderRadius.circular(6),
  //                                           ),
  //                                           focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Color(ListColor
  //                                                     .colorLightGrey19),
  //                                                 width: 1.0),
  //                                             borderRadius:
  //                                                 BorderRadius.circular(6),
  //                                           ),
  //                                         )),
  //                                   )
  //                                 ],
  //                               ),
  //                               SizedBox(
  //                                 height: 20,
  //                               ),
  //                               OutlinedButton(
  //                                 style: OutlinedButton.styleFrom(
  //                                     backgroundColor: Color(ListColor.color4),
  //                                     side: BorderSide(
  //                                         width: 2,
  //                                         color: Color(ListColor.color4)),
  //                                     shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(20)),
  //                                     )),
  //                                 onPressed: () {
  //                                   Get.back();
  //                                 },
  //                                 child: Container(
  //                                   padding: EdgeInsets.symmetric(
  //                                       horizontal: 35, vertical: 10),
  //                                   child: Stack(
  //                                       alignment: Alignment.center,
  //                                       children: [
  //                                         CustomText("Kirim",
  //                                             fontWeight: FontWeight.w600,
  //                                             color: Colors.white),
  //                                       ]),
  //                                 ),
  //                               )
  //                             ]),
  //                       ),
  //                     ],
  //                   )),
  //                 );
  //               });
  //         },
  //       ),
  //       _lineSaparator(),
  //       ListTile(
  //         leading: CustomText(
  //           "LelangMuatPesertaLelangPesertaLelangLabelTitleLihatProfilTransporter"
  //               .tr,
  //           fontSize: GlobalVariable.ratioFontSize(context) * 14,
  //           fontWeight: FontWeight.w600,
  //         ),
  //         onTap: () {
  //           Get.back();
  //         },
  //       ),
  //       _lineSaparator(),
  //       ListTile(
  //         leading: CustomText(
  //           "LelangMuatPesertaLelangPesertaLelangLabelTitleLihatFilePenawaran"
  //               .tr,
  //           fontSize: GlobalVariable.ratioFontSize(context) * 14,
  //           fontWeight: FontWeight.w600,
  //         ),
  //         onTap: () {
  //           Get.back();
  //         },
  //       )
  //     ],
  //   );
  // }

  // Widget _lineSaparator() {
  //   return Container(
  //       height: GlobalVariable.ratioWidth(Get.context) * 1,
  //       margin: EdgeInsets.only(
  //           left: GlobalVariable.ratioWidth(Get.context) * 16,
  //           right: GlobalVariable.ratioWidth(Get.context) * 16),
  //       width: MediaQuery.of(Get.context).size.width,
  //       color: Color(ListColor.colorLightGrey10));
  // }

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
