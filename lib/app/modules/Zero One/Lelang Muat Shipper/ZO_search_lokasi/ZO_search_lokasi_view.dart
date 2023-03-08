import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_search_lokasi/ZO_search_lokasi_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/checkbox_custom_widget_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoSearchLokasiView extends GetView<ZoSearchLokasiController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {},
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(context) * 53),
            child: Container(
              // height: GlobalVariable.ratioWidth(context) * 56.8,
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
                                        Get.back(result: "loading");
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
                                  key: ValueKey("CariLokasi "),
                                  context: Get.context,
                                  autofocus: true,
                                  onChanged: (value) {
                                    controller.addTextSearch(value);
                                  },
                                  controller: controller.cari.value,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (value) {
                                    controller.onSubmitSearch();
                                  },
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
                                        "LelangMuatBuatLelangBuatLelangLabelTitleCariLokasi"
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
                                    width:
                                        GlobalVariable.ratioFontSize(context) *
                                            28,
                                    height:
                                        GlobalVariable.ratioFontSize(context) *
                                            28,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.onClearSearch();
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
                            width: GlobalVariable.ratioWidth(context) * 2,
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    controller.argumn.value,
                                    width:
                                        GlobalVariable.ratioFontSize(context) *
                                            26,
                                    height:
                                        GlobalVariable.ratioFontSize(context) *
                                            26,
                                  ))),
                        ],
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
          ),
          body: Obx(
            () => Padding(
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 20,
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 20),
              child: ListView(
                children: [
                  _pilihLokasi(),
                  _sizedBox(18),
                  if (controller.cariList.value.length > 0) _lineSeparator(),
                  if (controller.cariList.value.length > 0) _sizedBox(18),
                  if (controller.cariList.value.length > 0)
                    Container(
                      child: CustomText(
                        "LelangMuatBuatLelangBuatLelangLabelTitleHasilPencarian"
                            .tr,
                        fontWeight: FontWeight.w700,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorGrey3),
                      ),
                    ),
                  if (controller.cariList.value.length > 0) _sizedBox(15),
                  for (var i = 0; i < controller.cariList.value.length; i++)
                    _lokasiSearch(i),
                  if (controller.terakhirDicariList.value.length > 0)
                    _lineSeparator(),
                  if (controller.terakhirDicariList.value.length > 0)
                    _sizedBox(18),
                  if (controller.terakhirDicariList.value.length > 0)
                    _terakhirDicari(),
                  if (controller.transaksiTerakhirList.value.length > 0)
                    _lineSeparator(),
                  if (controller.transaksiTerakhirList.value.length > 0)
                    _sizedBox(18),
                  if (controller.transaksiTerakhirList.value.length > 0)
                    _transaksiTerakhir()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _sizedBox(double nil) {
    return SizedBox(
      height: GlobalVariable.ratioWidth(Get.context) * nil,
    );
  }

  Widget _lineSeparator() {
    return Container(
        height: 1,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey5).withOpacity(0.29));
  }

  _pilihLokasi() {
    return Container(
      child: GestureDetector(
        onTap: () {
          controller.toMapPinSelect();
          // controller.onTapTextField.value = true;
          // controller.cari.value.text =
          //     controller.listChoosenReturn.value[idx].toString();
          // controller.addTextSearch(controller.cari.value.text);
          // controller.onSubmitSearch();
        },
        child: Row(
          children: [
            Container(
              child: SvgPicture.asset(
                "assets/lokasi_blue.svg",
                width: GlobalVariable.ratioFontSize(Get.context) * 18,
                height: GlobalVariable.ratioFontSize(Get.context) * 18,
              ),
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(Get.context) * 15,
            ),
            Expanded(
              child: CustomText(
                "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderChooseLocation"
                    .tr,
                fontWeight: FontWeight.w600,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                color: Color(ListColor.colorBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _lokasiSearch(int idx) {
    return Column(
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              // controller.onTapTextField.value = true;
              controller.chooseLokasi(
                  controller.cariList.value[idx]["title"].toString(),
                  controller.cariList.value[idx]["id"].toString());
              // controller.addTextSearch(controller.cari.value.text);
              // controller.onClickText();
            },
            child: Row(
              children: [
                Container(
                    child: SvgPicture.asset(
                  "assets/ic_terakhir_dicari.svg",
                  height: GlobalVariable.ratioFontSize(Get.context) * 24,
                  width: GlobalVariable.ratioFontSize(Get.context) * 24,
                )
                    //     Icon(
                    //   Icons.location_on_outlined,
                    //   color: Color(ListColor.colorLightGrey4),
                    //   size: GlobalVariable.ratioFontSize(Get.context) * 26,
                    // ),
                    ),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                Expanded(
                  child: CustomText(
                    controller.cariList.value[idx]["title"].toString(),
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    color: Color(ListColor.colorLightGrey4),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        _sizedBox(16),
      ],
    );
  }

  _terakhirDicari() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: CustomText(
            "LelangMuatBuatLelangBuatLelangLabelTitleTerakhirCari".tr,
            fontWeight: FontWeight.w700,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            color: Color(ListColor.colorGrey3),
          ),
        ),
        _sizedBox(15),
        for (var idx = 0;
            idx < controller.terakhirDicariList.value.length;
            idx++)
          Column(
            children: [
              Container(
                child: GestureDetector(
                  onTap: () {
                    controller.cari.value.text =
                        controller.terakhirDicariList.value[idx]["Address"];
                    controller.addTextSearch(
                        controller.terakhirDicariList.value[idx]["Address"]);
                    // controller.chooseLokasi(
                    //     controller.cariList.value[idx]["title"].toString(),
                    //     controller.cariList.value[idx]["id"].toString());
                  },
                  child: Row(
                    children: [
                      Container(
                          child: SvgPicture.asset(
                        "assets/ic_terakhir_dicari.svg",
                        height: GlobalVariable.ratioFontSize(Get.context) * 24,
                        width: GlobalVariable.ratioFontSize(Get.context) * 24,
                      )

                          // Icon(
                          //   Icons.location_on_outlined,
                          //   color: Color(ListColor.colorLightGrey4),
                          //   size: GlobalVariable.ratioFontSize(Get.context) * 26,
                          // ),
                          ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      Expanded(
                        child: CustomText(
                          controller.terakhirDicariList.value[idx]["Address"],
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          color: Color(ListColor.colorLightGrey4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _sizedBox(15),
            ],
          )
      ],
    );
  }

  _transaksiTerakhir() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: CustomText(
            "LelangMuatBuatLelangBuatLelangLabelTitleTransaksiTerakhir".tr,
            fontWeight: FontWeight.w700,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            color: Color(ListColor.colorGrey3),
          ),
        ),
        _sizedBox(15),
        for (var idx = 0;
            idx < controller.transaksiTerakhirList.value.length;
            idx++)
          Column(
            children: [
              Container(
                child: GestureDetector(
                  onTap: () {
                    controller.cari.value.text =
                        controller.transaksiTerakhirList.value[idx]["Address"];
                    controller.addTextSearch(
                        controller.transaksiTerakhirList.value[idx]["Address"]);
                    // controller.onTapTextField.value = true;
                    // controller.cari.value.text =
                    //     controller.listChoosenReturn.value[idx].toString();
                    // controller.addTextSearch(controller.cari.value.text);
                    // controller.onSubmitSearch();
                  },
                  child: Row(
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          "assets/timer_icon.svg",
                          width: GlobalVariable.ratioFontSize(Get.context) * 24,
                          height:
                              GlobalVariable.ratioFontSize(Get.context) * 24,
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      Expanded(
                        child: CustomText(
                          controller.transaksiTerakhirList.value[idx]
                              ["Address"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          color: Color(ListColor.colorGrey3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _sizedBox(15),
            ],
          )
      ],
    );
  }
}
