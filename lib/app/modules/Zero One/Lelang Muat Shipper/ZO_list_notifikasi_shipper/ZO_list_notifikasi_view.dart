import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_notifikasi_shipper/ZO_list_notifikasi_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoListNotifikasiShipperView
    extends GetView<ZoListNotifikasiShipperController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
          onWillPop: () async {},
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(64),
              child: Container(
                height: 64,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ], color: Colors.white),
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                      height: 64,
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10),
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
                                        Get.back(
                                            result: "backListLelangMuatan");
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
                          Expanded(
                              child: Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(context) * 25),
                              child: Center(
                                child: CustomText(
                                  "LelangMuatBuatLelangBuatLelangLabelTitleNotifikasi"
                                      .tr,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      GlobalVariable.ratioFontSize(context) *
                                          14,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
            body: Obx(
              () => Container(
                color: Color(ListColor.colorWhite1),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    for (var idx = 0;
                        idx < controller.listDataNotifikasi.value.length;
                        idx++)
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (!controller.disabletopeserta.value) {
                            controller.toPesertaLelang(
                                controller.listDataNotifikasi.value[idx]["ID"]
                                    .toString(),
                                controller
                                    .listDataNotifikasi.value[idx]["ID_notif"]
                                    .toString());
                          }
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: controller.listDataNotifikasi.value[idx]
                                            ["is_read"] ==
                                        0
                                    ? Color.fromRGBO(219, 232, 255, 0.5)
                                        .withOpacity(0.5)
                                    : Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      GlobalVariable.ratioWidth(context) * 16,
                                      GlobalVariable.ratioWidth(context) * 12,
                                      GlobalVariable.ratioWidth(context) * 16,
                                      GlobalVariable.ratioWidth(context) * 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: CustomText(
                                          controller.listDataNotifikasi
                                              .value[idx]["ket"],
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  14,
                                          fontWeight: FontWeight.w600,
                                          height: GlobalVariable.ratioFontSize(
                                                  context) *
                                              (17 / 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: GlobalVariable.ratioFontSize(
                                                context) *
                                            4,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/ic_time_notif.svg",
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                14,
                                          ),
                                          SizedBox(
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                4,
                                          ),
                                          Container(
                                            child: CustomText(
                                              controller.listDataNotifikasi
                                                  .value[idx]["created"],
                                              color:
                                                  Color(ListColor.colorGrey3),
                                              fontSize:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // if (controller.listDataNotifikasi.value.length - 1 !=
                              //     idx)
                              //   _lineSaparator(),
                            ],
                          ),
                        ),
                      ),

                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12,
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12),
                    //   child: Container(
                    //     child: CustomText(
                    //       "Ada 4 Transporter baru mengikuti Lelang LM-22-000002",
                    //       fontSize: GlobalVariable.ratioWidth(context) * 14,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // _lineSaparator(),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12,
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12),
                    //   child: Container(
                    //     child: CustomText(
                    //       "Lelang LM-22-000004, akan berakhir pada tanggal 5 Jan 2022, mohon segera tentukan pemenang.",
                    //       fontSize: GlobalVariable.ratioWidth(context) * 14,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // _lineSaparator(),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12,
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12),
                    //   child: Container(
                    //     child: CustomText(
                    //       "Respons nego harga lelang LMT-LM-22-000005 dari PT.Truck Maju Bersama: Penawaran Baru 3.000.000",
                    //       fontSize: GlobalVariable.ratioWidth(context) * 14,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // _lineSaparator(),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12,
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12),
                    //   child: Container(
                    //     child: CustomText(
                    //       "Response nego harga lelang LMT-LM-22-000005 dari PT.Indah Murni: Disetujui.",
                    //       fontSize: GlobalVariable.ratioWidth(context) * 14,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // _lineSaparator(),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12,
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12),
                    //   child: Container(
                    //     child: CustomText(
                    //       "Response nego harga lelang LMT-LM-22-000005 dari PT.Indah Murni: Disetujui.",
                    //       fontSize: GlobalVariable.ratioWidth(context) * 14,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // _lineSaparator(),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12,
                    //       GlobalVariable.ratioWidth(context) * 16,
                    //       GlobalVariable.ratioWidth(context) * 12),
                    //   child: Container(
                    //     child: CustomText(
                    //       "Response nego harga lelang LMT-LM-22-000005 dari PT.Indah Murni: Disetujui.",
                    //       fontSize: GlobalVariable.ratioWidth(context) * 14,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // _lineSaparator(),
                  ],
                ),
              ),
            ),
          )),
    );
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
}
