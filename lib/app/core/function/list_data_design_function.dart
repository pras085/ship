import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/enum/list_data_design_type_button_corner_right_enum.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/models/transporter_list_design_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'dart:math';

import 'package:muatmuat/global_variable.dart';

class ListDataDesignFunction {
  final void Function(dynamic result, int index) resultValueFunction;
  bool isListMitra;
  bool isUsingTwoButtonRightOfDesc;

  String labelJoin = "";
  String labelButton1RightOfDesc = "";
  String labelButton2RightOfDesc = "";

  Function(int) onTapButton1RightOfDesc;
  Function(int) onTapButton2RightOfDesc;

  List<TransporterListDesignModel> listData = [];

  List<Color> _listColor = [
    Color(ListColor.color4),
    Color(ListColor.colorRed),
    Color(ListColor.colorGreen),
  ];

  ListDataDesignFunction(
    this.isListMitra, {
    this.resultValueFunction,
    this.labelJoin,
    this.isUsingTwoButtonRightOfDesc = false,
    this.onTapButton1RightOfDesc,
    this.onTapButton2RightOfDesc,
    this.labelButton1RightOfDesc = "",
    this.labelButton2RightOfDesc = "",
  });

  void addDataList(List<TransporterListDesignModel> list) {
    var rnd = Random();
    for (int i = 0; i < list.length; i++) {
      list[i].backgroundColor = _listColor[rnd.nextInt(3)];
    }
    listData.addAll(list);
  }

  void clearList() {
    listData.clear();
  }

  Widget getTransporterTileWidget(int index,
      {ListDataDesignTypeButtonCornerRight typeButton =
          ListDataDesignTypeButtonCornerRight.NONE,
      @required ListDataMitraFrom dari,
      void Function() onTapBottonCornerRight,
      bool disableaccept,
      bool disablereject
      }) {
    return _transporterTile(listData[index], index,
        typeButton: typeButton,
        onTapBottonCornerRight: onTapBottonCornerRight,
        dari: dari,
        disableaccept: disableaccept,
        disablereject: disablereject);
  }

  Widget _transporterTile(TransporterListDesignModel dataTransporter, int index,
      {ListDataDesignTypeButtonCornerRight typeButton =
          ListDataDesignTypeButtonCornerRight.NONE,
      @required ListDataMitraFrom dari,
      void Function() onTapBottonCornerRight,
      bool disableaccept,
      bool disablereject
      }) {
    double borderRadius = GlobalVariable.ratioWidth(Get.context) * 10;
    return GestureDetector(
      onTap: () async {
        // var result = await Get.toNamed(Routes.TRANSPORTER, arguments: [
        //   dataTransporter.transporterID,
        //   dataTransporter.transporterName,
        //   dataTransporter.avatar,
        //   dataTransporter.isGoldTransporter
        // ]);
        var result = await Get.toNamed(Routes.OTHERSIDE, arguments: [
          dataTransporter.transporterID,
          dataTransporter.isGoldTransporter,
        ]);
        if (resultValueFunction != null) resultValueFunction(result, index);
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              /*index == 0 ? 0 : 15*/ 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 12),
          // margin:
          //     EdgeInsets.fromLTRB(11, 11, 11, index != (totalIndex - 1) ? 0 : 11),
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
                alignment: Alignment.centerLeft,
                height: GlobalVariable.ratioWidth(Get.context) * 48,
                padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 9),
                decoration: BoxDecoration(
                    color: Color(ListColor.colorLightBlue6),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadius),
                        topRight: Radius.circular(borderRadius))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _circleAvatar(
                        dataTransporter.avatar, dataTransporter.initials),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              dataTransporter.transporterName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              height: 1.2,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey4),
                            ),
                            SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 3),
                            CustomText(dataTransporter.city,
                                maxLines: 1,
                                height: 1.2,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorGrey3))
                          ],
                        ),
                      ),
                    ),
                    !isListMitra && dataTransporter.isAlreadyBecomePartner
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 22,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6)),
                                  color: Color(ListColor.colorLightBlue3),
                                ),
                                child: CustomText(
                                    "ListTransporterMitraDesignLabelMitra".tr,
                                    color: Color(ListColor.color4),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    dataTransporter.isGoldTransporter
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              SvgPicture.asset(
                                "assets/golden_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    // SizedBox(
                    //   width: 5,
                    // ),
                    typeButton != ListDataDesignTypeButtonCornerRight.NONE &&
                            onTapBottonCornerRight != null
                        ? Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: onTapBottonCornerRight,
                              child: typeButton ==
                                      ListDataDesignTypeButtonCornerRight.CLOSE
                                  ? Container(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 30,
                                        color: Colors.red,
                                      ))
                                  : Container(
                                      child: SvgPicture.asset(
                                      "assets/ic_more_vert.svg",
                                      color: Color(ListColor.colorDarkGrey7),
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                    )),
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 10,
                    GlobalVariable.ratioWidth(Get.context) * 14,
                    GlobalVariable.ratioWidth(Get.context) * 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(borderRadius),
                  //     bottomRight: Radius.circular(borderRadius))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _itemDescMitra("assets/support_area_icon.svg",
                              dataTransporter.serviceArea),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8,
                          ),
                          _itemDescMitra("assets/type_truck_icon.svg",
                              dataTransporter.yearFounded),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8,
                          ),
                          _itemDescMitra("assets/number_truck_icon.svg",
                              dataTransporter.numberTruck + " unit"),
                          // _itemDescMitra("assets/date_join_icon.svg",
                          //     dataTransporter.joinDate),
                        ],
                      ),
                    ),
                    (_isUsingButtonRightOfDescription())
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 5,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _button(
                                      text: labelButton1RightOfDesc,
                                      marginTop: 13,
                                      marginBottom: 8,
                                      backgroundColor: disableaccept == true? Color(ListColor.colorGrey2) : Color(ListColor.colorBlue),
                                      useBorder: false,
                                      onTap: () async {
                                        var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "411", showDialog: false);
                                        if (!hasAccess) {
                                          return;
                                        }
                                        onTapButton1RightOfDesc(index);
                                      }),
                                  _button(
                                      marginBottom: 13,
                                      text: labelButton2RightOfDesc,
                                      color: disablereject == true? Color(ListColor.colorGrey2) : Color(ListColor.colorBlue),
                                      borderColor: disablereject == true? ListColor.colorGrey2 : ListColor.colorBlue,
                                      onTap: () async {
                                        var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "413", showDialog: false);
                                        if (!hasAccess) {
                                          return;
                                        }
                                        onTapButton2RightOfDesc(index);
                                      }),
                                ],
                              )
                            ],
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(Get.context).size.width,
                height: GlobalVariable.ratioWidth(Get.context) * 0.5,
                color: Color(ListColor.colorLightGrey2),
              ),
              Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 40,
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: CustomText(
                              (labelJoin == null
                                      ? "ListTransporterMitraDesignLabelJoinSince"
                                          .tr
                                      : labelJoin) +
                                  ": " +
                                  dataTransporter.joinDate,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              height: 1.2,
                              fontSize: 10,
                              color: Color(ListColor.color4))),
                      _isUsingButtonRightOfDescription()
                          ? SizedBox.shrink()
                          : SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                            ),
                      Material(
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 18),
                        color: _isUsingButtonRightOfDescription()
                            ? Colors.transparent
                            : Color(ListColor.color4),
                        child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 18),
                            ),
                            onTap: () async {
                              // var result = await Get.toNamed(Routes.TRANSPORTER,
                              //     arguments: [
                              //       dataTransporter.transporterID,
                              //       dataTransporter.transporterName,
                              //       dataTransporter.avatar,
                              //       dataTransporter.isGoldTransporter
                              //     ]);
                               var result = await Get.toNamed(Routes.OTHERSIDE, arguments: [
                               dataTransporter.transporterID,
                               dataTransporter.isGoldTransporter
                               ]);
                              if (resultValueFunction != null)
                                resultValueFunction(result, index);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: _isUsingButtonRightOfDescription()
                                    ? 0
                                    : dari == ListDataMitraFrom.TRANSPORTER
                                        ? GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24
                                        : GlobalVariable.ratioWidth(
                                                Get.context) *
                                            28,
                                width: _isUsingButtonRightOfDescription()
                                    ? 0
                                    : dari == ListDataMitraFrom.TRANSPORTER
                                        ? GlobalVariable.ratioWidth(
                                                Get.context) *
                                            80
                                        : GlobalVariable.ratioWidth(
                                                Get.context) *
                                            107,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            18)),
                                child: CustomText(
                                    _isUsingButtonRightOfDescription()
                                        ? ""
                                        : dari == ListDataMitraFrom.TRANSPORTER
                                            ? 'ListTransporterMitraDesignLabelDetail'
                                                .tr
                                            : "PartnerManagementLabelViewProfile".tr,
                                    color: Colors.white,
                                    fontSize: 12,
                                    height: 1.2,
                                    fontWeight: FontWeight.w600))),
                      )
                    ],
                  ))
            ],
          )),
    );
  }

  Widget _itemDescMitra(String urlIcon, String title) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(urlIcon,
              width: GlobalVariable.ratioWidth(Get.context) * 16,
              height: GlobalVariable.ratioWidth(Get.context) * 16),
          SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 16),
          Expanded(
            child: CustomText(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                color: Color(ListColor.colorGrey4),
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _circleAvatar(String urlImage, String initials) {
    return Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Container(
          width: GlobalVariable.ratioWidth(Get.context) * 32,
          height: GlobalVariable.ratioWidth(Get.context) * 32,
          child: urlImage == ""
              ? _defaultAvatar(initials)
              : CachedNetworkImage(
                  errorWidget: (context, value, err) =>
                      _defaultAvatar(initials),
                  imageUrl: urlImage,
                  imageBuilder: (context, imageProvider) => Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 32,
                    height: GlobalVariable.ratioWidth(Get.context) * 32,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                ),
        ));
  }

  Widget _defaultAvatar(String initials) {
    return Container(
      width: GlobalVariable.ratioWidth(Get.context) * 32,
      height: GlobalVariable.ratioWidth(Get.context) * 32,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 35))),
    );
  }

  bool _isUsingButtonRightOfDescription() => (isUsingTwoButtonRightOfDesc &&
      onTapButton1RightOfDesc != null &&
      onTapButton2RightOfDesc != null);

  Widget _button({
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
    bool useBorder = true,
    double borderRadius = 18,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    int borderColor,
    Color backgroundColor = Colors.white,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: GlobalVariable.ratioWidth(Get.context) * 80,
      height: GlobalVariable.ratioWidth(Get.context) * 24,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(borderColor),
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
