import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/create_group_tambah_anggota/create_group_tambah_anggota_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_detail_manajemen_group_mitra/search_detail_manajemen_group_mitra_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class SearchDetailManajemenGroupMitraView
    extends GetView<SearchDetailManajemenGroupMitraController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Container(
      color: Color(ListColor.colorWhite),
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
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 4)),
              ], color: Colors.white),
              child: Container(
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
                          Get.back();
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
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
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
                                          hintText: "Cari Nama Mitra".tr,
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
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
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
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  15,
                                              height: GlobalVariable.ratioWidth(
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
                    GestureDetector(
                        onTap: () {
                          // if (!(controller.listData.length <= 1 &&
                          //     controller.filterKota.isEmpty &&
                          //     controller.filterProvince.isEmpty))
                          //   controller.showSort();
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                left: GlobalVariable.ratioWidth(Get.context) *
                                    12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  // controller.sort.keys.isNotEmpty
                                  //     ? Colors.white
                                  //     :
                                  Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset("assets/sorting_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                color:
                                    // (controller.listData.length <= 1 &&
                                    //         controller.filterKota.isEmpty &&
                                    //         controller.filterProvince.isEmpty)
                                    //     ? Color(ListColor.colorLightGrey2)
                                    //     : controller.sort.keys.isNotEmpty
                                    //         ?
                                    // Color(ListColor.color4):
                                    Colors.black))),
                  ],
                ),
              ),
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
              // Container(
              //   width: double.infinity,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //       boxShadow: <BoxShadow>[
              //         BoxShadow(
              //           color: Color(ListColor.colorBlack).withOpacity(0.16),
              //           blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
              //           spreadRadius: 0,
              //           offset: Offset(
              //               0, GlobalVariable.ratioWidth(Get.context) * -3),
              //         ),
              //       ],
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(
              //             GlobalVariable.ratioWidth(Get.context) * 10,
              //           ),
              //           topRight: Radius.circular(
              //               GlobalVariable.ratioWidth(Get.context) * 10)),
              //       color: Colors.white),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       _button(
              //           text: "Simpan",
              //           height: 32,
              //           marginTop: 12,
              //           marginBottom: 12,
              //           paddingLeft: 59,
              //           paddingRight: 59,
              //           backgroundColor: Color(ListColor.colorBlue),
              //           onTap: () {
              //             Get.back(
              //                 result: [controller.tempSelectedMitra.value]);
              //           }),
              //     ],
              //   ),
              // ),
            ],
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
          left: GlobalVariable.ratioWidth(Get.context) * 16,
          right: GlobalVariable.ratioWidth(Get.context) * 16,
          top: index == 0 ? GlobalVariable.ratioWidth(Get.context) * 20 : 0,
          bottom: GlobalVariable.ratioWidth(Get.context) * 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorBlack).withOpacity(0.1),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
          ),
        ],
        borderRadius: BorderRadius.all(
            Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
          vertical: GlobalVariable.ratioWidth(Get.context) * 12),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(Get.context) * 14),
              width: GlobalVariable.ratioWidth(Get.context) * 32,
              height: GlobalVariable.ratioWidth(Get.context) * 32,
              child: CircleAvatar(
                radius: GlobalVariable.ratioWidth(Get.context) * 25.0,
                backgroundImage:
                    NetworkImage(mitra.avatar),
                backgroundColor: Colors.transparent,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          mitra.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(mitra.city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Color(ListColor.colorGrey4)),
                        Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 6,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              child: SvgPicture.asset(
                                "assets/support_area_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                            ),
                            Expanded(
                              child: CustomText(mitra.areaLayanan,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  color: Color(ListColor.colorGrey4),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              child: SvgPicture.asset(
                                "assets/type_truck_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                            ),
                            Expanded(
                              child: CustomText(mitra.yearFounded,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  color: Color(ListColor.colorGrey4),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              child: SvgPicture.asset(
                                "assets/number_truck_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                            ),
                            Expanded(
                              child: CustomText(mitra.qtyTruck + " unit",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  color: Color(ListColor.colorGrey4),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(
                          marginLeft: 8,
                          marginBottom: 4,
                          text: "PartnerManagementLabelDetail".tr,
                          width: 72,
                          height: 24,
                          backgroundColor: Color(ListColor.colorBlue),
                          onTap: () {
                            Get.toNamed(Routes.TRANSPORTER, arguments: [
                              mitra.id,
                              mitra.name,
                              mitra.avatar,
                              mitra.isGold
                            ]);
                          }),
                      _button(
                          marginLeft: 8,
                          marginTop: 4,
                          text: "PartnerManagementLabelHapus".tr,
                          width: 72,
                          height: 24,
                          useBorder: true,
                          color: Color(ListColor.colorBlue),
                          onTap: () {
                            if (!controller.loading.value)
                              controller.hapusMitra(mitra);
                          })
                    ],
                  ),
                ],
              ),
            ),
          ]),
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
