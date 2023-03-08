import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/model/model_zona_waktu_dan_bahasa.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/zona_waktu_dan%20bahasa/zona_waktu_dan%20bahasa_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ZonaWaktuDanBahasaView extends GetView<ZonaWaktuDanBahasaController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
        onWillPop: () {
          controller.onWillPop();
          return Future.value(false);
        },
        child: Container(
          color: Color(ListColor.colorBlue),
          child: SafeArea(
            child: Scaffold(
                appBar: AppBarDetail(
                  isBlueMode: true,
                  onClickBack: () {
                    Get.back();
                  },
                  isWithShadow: false,
                  // prefixIcon: [
                  //   SvgPicture.asset(
                  //     "assets/ic_notif_off.svg",
                  //     width: GlobalVariable.ratioWidth(Get.context) * 24,
                  //   )
                  // ],
                  titleWidget: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 44),
                    child: Obx(()=>
                       CustomText(
                        controller.tipe.value == WAKTU_BAHASA.WAKTU 
                        ? "Zona Waktu"
                        : "Pengaturan Bahasa",
                        fontSize: 16,
                        color: Color(ListColor.colorWhite),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                body: Obx(
                  () => controller.isLoading.value
                      ? Container(
                          color: Color(ListColor.colorWhite),
                          padding: EdgeInsets.symmetric(vertical: 40),
                          width: Get.context.mediaQuery.size.width,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator()),
                              ),
                              CustomText("ListTransporterLabelLoading".tr),
                            ],
                          ))
                      : Container(
                          color: Color(ListColor.colorWhite),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     _cardList(),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: GlobalVariable.ratioWidth(Get.context) * 68,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide(
                                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                                    color: Color(ListColor.colorStroke),
                                  ))
                                ),
                                child: _button(
                                  marginLeft: GlobalVariable.ratioWidth(Get.context) * 16,
                                  marginRight: GlobalVariable.ratioWidth(Get.context) * 16,
                                  maxWidth: true,
                                  height: 36,
                                  text: "Ubah",
                                  backgroundColor: Color(ListColor.colorBlue),
                                  onTap: (){
                                    controller.saveData(showLoading: true);
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                )),
          ),
        ));
  }

  Widget _cardList() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
        vertical: GlobalVariable.ratioWidth(Get.context) * 20
      ),
      child: Column(
        children: [
          for(int i = 0; i < controller.listDataWaktuBahasa.length; i++)
            _item((){
              controller.selectData(i, controller.listDataWaktuBahasa[i]);
            }, 
            controller.listDataWaktuBahasa[i].alias,
            // controller.tipe == WAKTU_BAHASA.WAKTU 
            // ? controller.listDataWaktuBahasa[i].alias
            // : controller.listDataWaktuBahasa[i].id == 1
            //   ? "English"
            //   : "Bahasa Indonesia", 
            i),
        ],
      ),
    );
  }

  Widget _item(Function onTap, String text, int i) {
    return GestureDetector(
      onTap: (){onTap();},
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(
            width: GlobalVariable.ratioWidth(Get.context) * 1,
            color: Color(ListColor.colorStroke),
          ))
        ),
        padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 11.5),
        height: GlobalVariable.ratioWidth(Get.context) * 48,
        width: double.infinity,
        child: Obx(()=>
          CustomText(
            text,
            fontWeight: FontWeight.w700,
            color: Color(controller.selected.value["i"] == i ? ListColor.colorBlue : ListColor.colorBlack),
          ),
        ),
      ),
    );
  }

  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text ?? "",
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}