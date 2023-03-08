import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:get/get.dart';
import 'package:open_appstore/open_appstore.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'custom_text.dart';

class ButtonBottomDemoWidget extends StatelessWidget {
  void Function() onTap;
  String modul;
  String sisi;
  String tab;

  ButtonBottomDemoWidget(
      {@required this.onTap, this.modul, this.sisi, this.tab});
  @override
  Widget build(BuildContext context) {
    return sisi == 'TRANSPORTER' && tab == 'TRANSPORTER'
        ? Container(
            height: GlobalVariable.ratioWidth(Get.context) * 64,
            width: MediaQuery.of(Get.context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        color: Color(ListColor.colorLightGrey10),
                        width: GlobalVariable.ratioWidth(Get.context) * 0.5))),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16,
                    top: GlobalVariable.ratioWidth(Get.context) * 16,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 16,
                  ),
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorIndicatorSelectedBigFleet2),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        topRight: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        bottomLeft: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        bottomRight: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20)),
                  ),
                  child: CustomText(
                    "DemoTransportMarketTransporterIndexDaftarMenjadiTransporter"
                        .tr, //Daftar Menjadi Transporter
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  )),
            ))
        : sisi == 'TRANSPORTER' && tab == 'SHIPPER'
            ? Container(
                height: GlobalVariable.ratioWidth(Get.context) * 64,
                width: MediaQuery.of(Get.context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                            color: Color(ListColor.colorLightGrey10),
                            width:
                                GlobalVariable.ratioWidth(Get.context) * 0.5))),
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 16,
                        right: GlobalVariable.ratioWidth(Get.context) * 16,
                        top: GlobalVariable.ratioWidth(Get.context) * 16,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 16,
                      ),
                      decoration: BoxDecoration(
                        color: Color(ListColor.colorBlue),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 20),
                            topRight: Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 20),
                            bottomLeft: Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 20),
                            bottomRight: Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 20)),
                      ),
                      child: CustomText(
                        "DemoTransportMarketTransporterIndexDapatkanAplikasiMuatMuat"
                            .tr, //Dapatkan Aplikasi muatmuat
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      )),
                ))
            : sisi == "SHIPPER" && tab == 'SHIPPER'
                ? Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 64,
                    width: MediaQuery.of(Get.context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                                color: Color(ListColor.colorLightGrey10),
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    0.5))),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                            right: GlobalVariable.ratioWidth(Get.context) * 16,
                            top: GlobalVariable.ratioWidth(Get.context) * 16,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 16,
                          ),
                          decoration: BoxDecoration(
                            color: Color(ListColor.colorBlue),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20),
                                topRight: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20),
                                bottomLeft: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20),
                                bottomRight: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                          ),
                          child: CustomText(
                            "DemoTransportMarketShipperIndexDaftarMenjadiShipper"
                                .tr, //Daftar Menjadi Shipper
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          )),
                    ))
                : Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 64,
                    width: MediaQuery.of(Get.context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                                color: Color(ListColor.colorLightGrey10),
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    0.5))),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                            right: GlobalVariable.ratioWidth(Get.context) * 16,
                            top: GlobalVariable.ratioWidth(Get.context) * 16,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 16,
                          ),
                          decoration: BoxDecoration(
                            color: Color(
                                ListColor.colorIndicatorSelectedBigFleet2),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20),
                                topRight: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20),
                                bottomLeft: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20),
                                bottomRight: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                          ),
                          child: CustomText(
                            "DemoTransportMarketShipperIndexDapatkanAplikasiMuatMuatTransporter"
                                .tr, //Dapatkan Aplikasi muatmuat Transporter
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          )),
                    ));
  }
}
