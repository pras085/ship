import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/main.dart';
import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:muatmuat/app/template/widgets/hubungi_seller_buyer/hubungi_seller_buyer.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global_variable.dart';

class DialogBuyer {
  /// USAGE sorting(),
  /// to show a modal bottom sheet for sorting option list
  /// [onReset] a callback to handle user action when tap on Reset button.
  /// [itemCount] pass the length from data.
  /// [itemBuilder] it will recreate your widget as many as [itemCount].
  static void sorting({
    @required BuildContext context,
    @required VoidCallback onReset,
    @required int itemCount,
    @required Widget Function(BuildContext context, int i) itemBuilder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: GlobalVariable.ratioWidth(context) * 604,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                  color: Color(ListColor.colorGreyTemplate7),
                ),
                width: GlobalVariable.ratioWidth(context) * 38,
                height: GlobalVariable.ratioWidth(context) * 3,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 6,
                  bottom: GlobalVariable.ratioWidth(context) * 15,
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 24,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'ic_close_grey.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        "Urutkan",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: onReset,
                        child: CustomText(
                          "Reset",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorBlueTemplate1),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
              Container(
                width: GlobalVariable.ratioWidth(context) * 328,
                child: ListView.separated(
                  itemCount: itemCount,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) {
                    return Container(
                      width: double.infinity,
                      height: GlobalVariable.ratioWidth(context) * 0.5,
                      color: Color(ListColor.colorGreyTemplate9),
                      margin: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(context) * 16,
                      ),
                    );
                  },
                  itemBuilder: itemBuilder,
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
            ],
          ),
        );
      },
    );
  }

  /// USAGE detail(),
  /// to show a modal bottom sheet for detail bidang keahlian/
  /// layanan/rute yang dilayani etc.
  /// [title] title for bottomsheet
  /// [listDetail] pass your data here.
  static void detail({
    @required BuildContext context,
    String title,
    String content = "",
    List<String> listDetail,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: GlobalVariable.ratioWidth(context) * 604,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                  color: Color(ListColor.colorGreyTemplate7),
                ),
                width: GlobalVariable.ratioWidth(context) * 38,
                height: GlobalVariable.ratioWidth(context) * 3,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 6,
                  bottom: GlobalVariable.ratioWidth(context) * 15,
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 24,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'ic_close_grey.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        title,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
              Container(
                width: GlobalVariable.ratioWidth(context) * 328,
                child: listDetail == null
                    ? CustomText(
                        content,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 16.8 / 14,
                        withoutExtraPadding: true,
                      )
                    : ListView.separated(
                        itemCount: listDetail.length,
                        shrinkWrap: true,
                        separatorBuilder: (_, __) {
                          return Container(
                            height: GlobalVariable.ratioWidth(context) * 12,
                          );
                        },
                        itemBuilder: (c, i) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(context) * 8,
                            ),
                            child: CustomText(
                              "\u2022  ${listDetail[i]}",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 36,
              ),
              _button(
                onTap: Get.back,
                height: 32,
                borderRadius: 6,
                backgroundColor: Color(ListColor.colorBlueTemplate1),
                color: Colors.white,
                text: "OK",
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
            ],
          ),
        );
      },
    );
  }

  /// to show a modal bottom sheet for detail pengalaman kerja human capital
  static void detailPengalamanKerja({
    @required BuildContext context,
    String title,
    String currentWork,
    String pengalamanKerja,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: GlobalVariable.ratioWidth(context) * 604,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                  color: Color(ListColor.colorGreyTemplate7),
                ),
                width: GlobalVariable.ratioWidth(context) * 38,
                height: GlobalVariable.ratioWidth(context) * 3,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 6,
                  bottom: GlobalVariable.ratioWidth(context) * 15,
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 24,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'ic_close_grey.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        title,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
              CustomText("Posisi Pekerjaan Terakhir/Saat ini",
                fontSize: 14,
                height: 16.8/14,
                fontWeight: FontWeight.w700,
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 8,
              ),
              CustomText(currentWork,
                fontSize: 14,
                height: 16.8/14,
                fontWeight: FontWeight.w500,
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 8,
              ),
              _divider(context),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
              CustomText(pengalamanKerja,
                fontSize: 14,
                height: 16.8/14,
                fontWeight: FontWeight.w500,
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 36,
              ),
              _button(
                onTap: Get.back,
                height: 32,
                borderRadius: 6,
                backgroundColor: Color(ListColor.colorBlueTemplate1),
                color: Colors.white,
                text: "OK",
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
            ],
          ),
        );
      },
    );
  }

  /// to show a modal bottom sheet for detail KEAHLIAN DAN BAKAT | HUMAN CAPITAL
  static void detailKeahlianBakat({
    @required BuildContext context,
    String title,
    Map data,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 16),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: GlobalVariable.ratioWidth(context) * 604,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                  color: Color(ListColor.colorGreyTemplate7),
                ),
                width: GlobalVariable.ratioWidth(context) * 38,
                height: GlobalVariable.ratioWidth(context) * 3,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 6,
                  bottom: GlobalVariable.ratioWidth(context) * 15,
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 24,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'ic_close_grey.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        title,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
              CustomText("${data.keys.first}",
                fontSize: 14,
                height: 16.8/14,
                fontWeight: FontWeight.w700,
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 8,
              ),
              CustomText("${data.values.first}",
                fontSize: 14,
                height: 16.8/14,
                fontWeight: FontWeight.w500,
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 8,
              ),
              _divider(context),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
              CustomText("${data.keys.last}",
                fontSize: 14,
                height: 16.8/14,
                fontWeight: FontWeight.w700,
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 8,
              ),
              CustomText("${data.values.last}",
                fontSize: 14,
                height: 16.8/14,
                fontWeight: FontWeight.w500,
                withoutExtraPadding: true,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 36,
              ),
              _button(
                onTap: Get.back,
                height: 32,
                borderRadius: 6,
                backgroundColor: Color(ListColor.colorBlueTemplate1),
                color: Colors.white,
                text: "OK",
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 24,
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _divider(context) {
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 0.5,
      color: Color(0xFF707070),
    );
  }

  static showCallBottomSheet({
    @required Map listData,
    bool isHumanCapital = false,
    int bottomSheetType,
    /* JENIS BOTTOM SHEET TYPE
      0 : just showing email
      1 : without pic
      2 : showing all include email
      3 : default 
    */
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 16),
          topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 16),
        ),
      ),
      backgroundColor: Colors.white,
      context: Get.context,
      builder: (context) {
        return isHumanCapital  
          ? HubungiSellerBuyerWithEmailComponent(
            data: listData,
            bottomSheetType: bottomSheetType,
          ) 
          : HubungiSellerBuyerComponent(data: listData);
      },
    );
  }
}

// Widget For Sorting Tile Dialog
/// [label] require a string, it use for give a name the main tile
/// [childCount] pass the length of submenu/radiobutton that you need.
/// [childBuilder] it's useful for you to create a view from each data by the length that you pass in [childCount].
Widget SortingTileDialogBuyer({
  @required BuildContext context,
  @required String label,
  @required int childCount,
  @required Widget Function(BuildContext context, int i) childBuilder,
}) {
  return Container(
    width: GlobalVariable.ratioWidth(context) * 328,
    constraints: BoxConstraints(
      minHeight: GlobalVariable.ratioWidth(context) * 73,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          textAlign: TextAlign.center,
          withoutExtraPadding: true,
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * 12,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: childCount,
          itemBuilder: childBuilder,
          separatorBuilder: (_, __) {
            return SizedBox(
              height: GlobalVariable.ratioWidth(context) * 12,
            );
          },
        ),
      ],
    ),
  );
}

// Widget For Sorting Tile Dialog
/// [groupValue] pass your variable that collect data for radio button here.
/// [value] value for each radio button.
/// [text] a string after radio button (LABEL/TITLE).
/// [onTap] a callback for you to handle condition when user tap the tile.
Widget SortingTileContentDialogBuyer({
  @required BuildContext context,
  @required String groupValue,
  @required String value,
  @required String text,
  VoidCallback onTap,
}) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: GlobalVariable.ratioWidth(context) * 16,
    ),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          IgnorePointer(
            ignoring: true,
            child: RadioButtonCustom(
              colorSelected: Color(ListColor.colorBlue),
              colorUnselected: Color(0xFFDBE2EA),
              isWithShadow: true,
              isDense: true,
              width: GlobalVariable.ratioWidth(context) * 16,
              height: GlobalVariable.ratioWidth(context) * 16,
              groupValue: groupValue,
              value: value,
              onChanged: (value) {},
            ),
          ),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
          Expanded(
            child: CustomText(
              text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorGreyTemplate8),
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

// PRIVATE CUSTOM BUTTON
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
    margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * marginLeft, GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight, GlobalVariable.ratioWidth(Get.context) * marginBottom),
    width: width == null
        ? maxWidth
            ? MediaQuery.of(Get.context).size.width
            : null
        : GlobalVariable.ratioWidth(Get.context) * width,
    height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
    decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: useShadow
            ? <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.shadowColor).withOpacity(0.08),
                  blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                  spreadRadius: 0,
                  offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                ),
              ]
            : null,
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        border: useBorder
            ? Border.all(
                width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                color: borderColor ?? Color(ListColor.colorBlue),
              )
            : null),
    child: Material(
      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
      color: Colors.transparent,
      child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
          ),
          onTap: () {
            onTap();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * paddingLeft, GlobalVariable.ratioWidth(Get.context) * paddingTop,
                GlobalVariable.ratioWidth(Get.context) * paddingRight, GlobalVariable.ratioWidth(Get.context) * paddingBottom),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(borderRadius)),
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
