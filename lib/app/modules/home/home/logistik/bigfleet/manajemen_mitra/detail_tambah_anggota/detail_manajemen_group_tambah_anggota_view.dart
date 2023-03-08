import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/detail_tambah_anggota/detail_manajemen_group_tambah_anggota_controller.dart';

import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DetailManajemenGroupTambahAnggotaView
    extends GetView<DetailManajemenGroupTambahAnggotaController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Container(
      color: Color(ListColor.colorWhite),
      child: WillPopScope(
        onWillPop: () {
          controller.onWillPop();
          return Future.value(false);
        },
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
              child: Container(
                height: GlobalVariable.ratioWidth(Get.context) * 56,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(ListColor.colorBlack).withOpacity(0.15),
                      blurRadius: GlobalVariable.ratioWidth(Get.context) * 15,
                      spreadRadius: 0,
                      offset: Offset(
                          0, GlobalVariable.ratioWidth(Get.context) * 4)),
                ], color: Colors.white),
                child:
                    //  Stack(alignment: Alignment.bottomCenter, children: [
                    //   Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 12,
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomBackButton(
                          context: Get.context,
                          iconColor: Color(ListColor.colorWhite),
                          backgroundColor: Color(ListColor.colorBlue),
                          onTap: () {
                            controller.onWillPop();
                            // Get.back();
                          }),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      Obx(
                        () => Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            1,
                                    color: Color(ListColor.colorStroke)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        8)),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CustomTextField(
                                        context: Get.context,
                                        autofocus: false,
                                        onChanged: (value) {
                                          controller.searchOnChange(value);
                                        },
                                        controller: controller.searchBar,
                                        textInputAction: TextInputAction.search,
                                        onSubmitted: (value) {},
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        textSize: 14,
                                        newInputDecoration: InputDecoration(
                                            hintText:
                                                "LoadRequestInfoLabelSearchHint"
                                                    .tr,
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(
                                                    ListColor.colorLightGrey2)),
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            isDense: true,
                                            isCollapsed: true,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    36,
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    9,
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    32,
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    0))),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6),
                                  child: SvgPicture.asset(
                                    "assets/ic_search.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: controller.isShowClearSearch.value
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.onClearSearch();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          4),
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                "assets/ic_close1,5.svg",
                                                color:
                                                    Color(ListColor.colorGrey3),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        15,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        15,
                                              )))
                                      : SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //   ]),
                //   Container(
                //       width: MediaQuery.of(context).size.width,
                //       height: 2,
                //       color: Color(ListColor.colorLightBlue5))
                // ]),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                          children: List.generate(
                        controller.tempListMitra.length,
                        (index) {
                          return _listItems(index);
                        },
                      )),
                    ),
                  ),
                )),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(ListColor.colorBlack).withOpacity(0.16),
                          blurRadius:
                              GlobalVariable.ratioWidth(Get.context) * 55,
                          spreadRadius: 0,
                          offset: Offset(
                              0, GlobalVariable.ratioWidth(Get.context) * -3),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 10,
                          ),
                          topRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10)),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(
                          text: "Simpan",
                          height: 32,
                          marginTop: 12,
                          marginBottom: 12,
                          paddingLeft: 59,
                          paddingRight: 59,
                          backgroundColor: Color(ListColor.colorBlue),
                          onTap: () {
                            controller.addMitraIntoGroup();
                            // Get.back(
                            //     result: [controller.tempSelectedMitra.value]);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItems(
    int index,
  ) {
    var mitra = controller.tempListMitra[index];
    return Container(
      margin: EdgeInsets.only(
          top: index == 0 ? GlobalVariable.ratioWidth(Get.context) * 20 : 0,
          bottom: GlobalVariable.ratioWidth(Get.context) * 20),
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
                right: GlobalVariable.ratioWidth(Get.context) * 12),
            width: GlobalVariable.ratioWidth(Get.context) * 60,
            height: GlobalVariable.ratioWidth(Get.context) * 60,
            child: CircleAvatar(
              radius: GlobalVariable.ratioWidth(Get.context) * 25.0,
              backgroundImage:
                  NetworkImage(GlobalVariable.urlImage + mitra.avatar),
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                mitra.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                color: Color(ListColor.colorDarkGrey3),
                fontSize: 12,
                height: 1.2,
                fontWeight: FontWeight.w700,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 2,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 2),
                child: CustomText(
                  mitra.city,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: Color(ListColor.colorDarkGrey3),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(Get.context) * 16),
                    height: GlobalVariable.ratioWidth(Get.context) * 12,
                    width: GlobalVariable.ratioWidth(Get.context) * 12,
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      "assets/number_truck_icon.svg",
                      height: GlobalVariable.ratioWidth(Get.context) * 12,
                      width: GlobalVariable.ratioWidth(Get.context) * 12,
                      color: Color(ListColor.color4),
                    ),
                  ),
                  CustomText(
                    mitra.qtyTruck + " unit",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: Color(ListColor.colorGrey4),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          )),
          Obx(
            () {
              var selected = controller.tempSelectedMitra.contains(mitra).obs;
              return _button(
                  marginLeft: GlobalVariable.ratioWidth(Get.context) * 12,
                  useBorder: true,
                  width: 80,
                  height: 24,
                  text: selected.value ? "Terpilih" : "Pilih",
                  color: Color(selected.value
                      ? ListColor.colorLightGrey4
                      : ListColor.colorWhite),
                  backgroundColor: Color(selected.value
                      ? ListColor.colorWhite
                      : ListColor.colorBlue),
                  borderColor: Color(selected.value
                      ? ListColor.colorLightGrey4
                      : ListColor.colorBlue),
                  onTap: () {
                    if (selected.value) {
                      selected.value = false;
                      controller.tempSelectedMitra.remove(mitra);
                    } else {
                      selected.value = true;
                      controller.tempSelectedMitra.add(mitra);
                    }
                  });
            },
          )
        ],
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
    double fontSize = 12,
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
                      text,
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
