import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/button_filter_widget.dart';
import 'package:muatmuat/app/widgets/custom_expansion_component.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'manajemen_notifikasi_aplikasi_controller.dart';

class ManajemenNotifikasiAplikasiView extends GetView<ManajemenNotifikasiAplikasiController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBarDetailProfil(
          type: 1,
          onClickBack: () {
            Get.back(result: true);
          },
          titleWidget: Obx(() =>
            Container(
              margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 40,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 8,
                GlobalVariable.ratioWidth(Get.context) * 12),
              height: GlobalVariable.ratioWidth(Get.context) * 32,
              // TARUH BORDER TEXTFIELD DISINI
              decoration: BoxDecoration(
                // border: Border.all(
                //   width: GlobalVariable.ratioWidth(Get.context) * 1,
                //   color: controller.isValid.value
                //       ? Color(ListColor.colorLightGrey10)
                //       : Color(ListColor.colorRed)
                // ),
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 8),
                color: Colors.white
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomTextFormField(
                        // key: controller.useremailph.value,
                        context: Get.context,
                        autofocus: false,
                        onChanged: (value) {
                          controller.resetFilter();
                          controller.applyFilter();
                          controller.getNotifSetting(query: value, showLoading: false);
                          controller.searchValue.value = value;
                        },
                        controller: controller.searchController,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.2,
                        ),
                        textSize: 14,
                        keyboardType: TextInputType.text,
                        newInputDecoration: InputDecoration(
                          hintText: "Cari Menu/Modul".tr,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey2)),
                          fillColor: Colors.transparent,
                          filled: true,
                          isDense: true,
                          isCollapsed: true,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(Get.context) * 34,
                            GlobalVariable.ratioWidth(Get.context) * 9,
                            GlobalVariable.ratioWidth(Get.context) * 6,
                            GlobalVariable.ratioWidth(Get.context) * 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // TARUH ICON DISINI
                  Container(
                    margin: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 6),
                    child: SvgPicture.asset(
                      "assets/ic_search.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 20,
                      height: GlobalVariable.ratioWidth(Get.context) * 20,
                    ),
                  ),                
                  Align(
                    alignment: Alignment.centerRight,
                    child: controller.searchValue.value != "" 
                      ? GestureDetector(
                        onTap: () {
                          controller.searchController.text = "";
                          controller.searchValue.value = "";
                          controller.resetFilter();
                          controller.applyFilter();
                          controller.getNotifSetting(query: "", showLoading: false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 6
                          ),
                          height: GlobalVariable.ratioWidth(Get.context) * 24,
                          width: GlobalVariable.ratioWidth(Get.context) * 24,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            "assets/ic_close_simple.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.colorGrey3),
                          )
                        )
                      )
                      :
                      SizedBox.shrink()
                  ),
                ],
              ),
            ),
          ),          
        ),
        body: Obx(() => controller.isLoading.value
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
              )
            )
          : !controller.notFound.value 
            ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(ListColor.colorLightGrey6),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                    ),
                    color: Color(ListColor.colorLightGrey6),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => controller.searchValue.value == ""
                          ? Container(
                            margin: EdgeInsets.only(
                              bottom: GlobalVariable.ratioWidth(context) * 14
                            ),
                            child: ButtonFilterWidget(
                              isActive: controller.isFiltered.value,
                              onTap: () {
                                controller.showFilter();
                              }
                            ),
                          )
                          : SizedBox.shrink()
                        ),
                        Obx(() => !controller.isFiltered.value && controller.searchValue.value == ""
                          ? Container(
                            margin: EdgeInsets.only(
                              bottom: GlobalVariable.ratioWidth(context) * 14
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: GlobalVariable.ratioWidth(context) * 14
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                            ),
                            height: GlobalVariable.ratioWidth(context) * 52,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    "Notifikasi di Aplikasi",
                                    color: Color(ListColor.colorLightGrey4),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Obx(() =>
                                  Container(
                                    width: GlobalVariable.ratioWidth(context) * 40,
                                    height: GlobalVariable.ratioWidth(context) * 24,
                                    child: FlutterSwitch(
                                      width: GlobalVariable.ratioWidth(context) * 40,
                                      // height: GlobalVariable.ratioWidth(context) * 24,
                                      value: controller.toggleAllNotif.value,
                                      onToggle: (val) {
                                        controller.setNotifSettingAll(toggle: val, showLoading: true);
                                      }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : SizedBox.shrink()
                        ),
                        // UMUM
                        Obx(() => controller.isShowGeneral.value && controller.listModelManajemenVerifikasiGeneral.isNotEmpty
                          ? Container(
                            margin: EdgeInsets.only(
                              bottom: GlobalVariable.ratioWidth(context) * 14
                            ),
                            child: ListItemExpansionComponent(
                              initiallyOpen: true,
                              header: Container(
                                child: CustomText(
                                  controller.listModelManajemenVerifikasiGeneral[0].categoryName,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              content: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(context) * 16
                                    ),
                                    height: GlobalVariable.ratioWidth(context) * 52,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            "Profil dan Pengaturan Akun",
                                            color: Color(ListColor.colorLightGrey4),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Obx(() =>
                                          Container(
                                            width: GlobalVariable.ratioWidth(context) * 40,
                                            height: GlobalVariable.ratioWidth(context) * 24,
                                            child: FlutterSwitch(
                                              width: GlobalVariable.ratioWidth(context) * 40,
                                              // height: GlobalVariable.ratioWidth(context) * 24,
                                              value: controller.listModelManajemenVerifikasiGeneral[0].pushNotifToggle.value,
                                              onToggle: (val) async {
                                                controller.setNotifSetting(model: controller.listModelManajemenVerifikasiGeneral[0], toggle: val, showLoading: true);
                                              }
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          : SizedBox.shrink()
                        ),
                        // BF
                        Obx(() => controller.isShowBf.value && controller.listModelManajemenVerifikasiBf.isNotEmpty
                          ? Container(
                            margin: EdgeInsets.only(
                              bottom: GlobalVariable.ratioWidth(context) * 14
                            ),
                            child: ListItemExpansionComponent(
                              initiallyOpen: true,
                              header: Container(
                                child: CustomText(
                                  controller.listModelManajemenVerifikasiBf[0].categoryName,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              content: Column(
                                children: [
                                  if(controller.searchValue.value == "")...[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(context) * 16
                                      ),
                                      height: GlobalVariable.ratioWidth(context) * 52,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              "Semua Modul",
                                              color: Color(ListColor.colorLightGrey4),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Obx(() =>
                                            Container(
                                              width: GlobalVariable.ratioWidth(context) * 40,
                                              height: GlobalVariable.ratioWidth(context) * 24,
                                              child: FlutterSwitch(
                                                width: GlobalVariable.ratioWidth(context) * 40,
                                                // height: GlobalVariable.ratioWidth(context) * 24,
                                                value: controller.toggleNotifBf.value,
                                                onToggle: (val) {
                                                  controller.toggleNotifBf.value = val;
                                                  controller.setNotifSetting(model: controller.listModelManajemenVerifikasiBf[0], toggle: val, showLoading: true);
                                                }
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  for(int i = 0; i < controller.listModelManajemenVerifikasiBf.length; i++)...[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(context) * 16
                                      ),
                                      height: GlobalVariable.ratioWidth(context) * 52,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SubstringHighlight(
                                              text: controller.listModelManajemenVerifikasiBf[i].subCategoryName,
                                              caseSensitive: false,
                                              term: controller.searchValue.value,
                                              textStyle: TextStyle(
                                                fontFamily: "AvenirNext",
                                                fontSize: GlobalVariable.ratioFontSize(context) * 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(ListColor.colorLightGrey4),
                                              ),
                                              textStyleHighlight: TextStyle(
                                                fontFamily: "AvenirNext",
                                                fontSize: GlobalVariable.ratioFontSize(context) * 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            // child: CustomText(
                                            //   controller.listModelManajemenVerifikasiBf[i].subCategoryName,
                                            //   color: Color(ListColor.colorLightGrey4),
                                            //   fontWeight: FontWeight.w600,
                                            // ),
                                          ),
                                          Obx(() =>
                                            Container(
                                              width: GlobalVariable.ratioWidth(context) * 40,
                                              height: GlobalVariable.ratioWidth(context) * 24,
                                              child: FlutterSwitch(
                                                width: GlobalVariable.ratioWidth(context) * 40,
                                                // height: GlobalVariable.ratioWidth(context) * 24,
                                                value: controller.listModelManajemenVerifikasiBf[i].pushNotifToggle.value,
                                                onToggle: (val) async {
                                                  controller.setNotifSettingChild(model: controller.listModelManajemenVerifikasiBf[i], toggle: val, showLoading: true);
                                                }
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          )
                          : SizedBox.shrink()
                        ),
                        // TM
                        Obx(() => controller.isShowTm.value && controller.listModelManajemenVerifikasiTm.isNotEmpty
                          ? Container(
                            margin: EdgeInsets.only(
                              bottom: GlobalVariable.ratioWidth(context) * 14
                            ),
                            child: ListItemExpansionComponent(
                              initiallyOpen: true,
                              header: Container(
                                child: CustomText(
                                  controller.listModelManajemenVerifikasiTm[0].categoryName,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              content: Column(
                                children: [
                                  if(controller.searchValue.value == "")...[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(context) * 16
                                      ),
                                      height: GlobalVariable.ratioWidth(context) * 52,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              "Semua Modul",
                                              color: Color(ListColor.colorLightGrey4),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Obx(() =>
                                            Container(
                                              width: GlobalVariable.ratioWidth(context) * 40,
                                              height: GlobalVariable.ratioWidth(context) * 24,
                                              child: FlutterSwitch(
                                                width: GlobalVariable.ratioWidth(context) * 40,
                                                // height: GlobalVariable.ratioWidth(context) * 24,
                                                value: controller.toggleNotifTm.value,
                                                onToggle: (val) {
                                                  controller.toggleNotifTm.value = val;
                                                  controller.setNotifSetting(model: controller.listModelManajemenVerifikasiTm[0], toggle: val, showLoading: true);
                                                }
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  for(int i = 0; i < controller.listModelManajemenVerifikasiTm.length; i++)...[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(context) * 16
                                      ),
                                      height: GlobalVariable.ratioWidth(context) * 52,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SubstringHighlight(
                                              text: controller.listModelManajemenVerifikasiTm[i].subCategoryName,
                                              caseSensitive: false,
                                              term: controller.searchValue.value,
                                              textStyle: TextStyle(
                                                fontFamily: "AvenirNext",
                                                fontSize: GlobalVariable.ratioFontSize(context) * 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(ListColor.colorLightGrey4),
                                              ),
                                              textStyleHighlight: TextStyle(
                                                fontFamily: "AvenirNext",
                                                fontSize: GlobalVariable.ratioFontSize(context) * 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            // child: CustomText(
                                            //   controller.listModelManajemenVerifikasiTm[i].subCategoryName,
                                            //   color: Color(ListColor.colorLightGrey4),
                                            //   fontWeight: FontWeight.w600,
                                            // ),
                                          ),
                                          Obx(() =>
                                            Container(
                                              width: GlobalVariable.ratioWidth(context) * 40,
                                              height: GlobalVariable.ratioWidth(context) * 24,
                                              child: FlutterSwitch(
                                                width: GlobalVariable.ratioWidth(context) * 40,
                                                // height: GlobalVariable.ratioWidth(context) * 24,
                                                value: controller.listModelManajemenVerifikasiTm[i].pushNotifToggle.value,
                                                onToggle: (val) async {
                                                  controller.setNotifSettingChild(model: controller.listModelManajemenVerifikasiTm[i], toggle: val, showLoading: true);
                                                }
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          )
                          : SizedBox.shrink()
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            : Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: SvgPicture.asset(
                      "assets/ic_management_lokasi_no_search.svg",
                      height: GlobalVariable.ratioWidth(Get.context) * 95,
                    )
                  ),
                  Container(
                    height: 12,
                  ),
                  Container(
                    child: CustomText(
                      "LocationManagementLabelNoKeywordFound".tr.replaceAll("\\n", "\n"),
                      textAlign:TextAlign.center,
                      color: Color(ListColor.colorLightGrey14),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.2,
                    )
                  )
                ],
              )
            ),
        ),
      ),
    );
  }
}

class ListItemExpansionComponent
    extends StatefulWidget {
  final Widget header;
  final Widget content;
  final bool initiallyOpen;

  const ListItemExpansionComponent({
    Key key,
    @required this.header,
    @required this.content,
    this.initiallyOpen = false,
  }) : super(key: key);

  @override
  _ListItemExpansionComponentState createState() =>
      _ListItemExpansionComponentState();
}

class _ListItemExpansionComponentState
    extends State<ListItemExpansionComponent> {
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    isOpen = widget.initiallyOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          GlobalVariable.ratioWidth(context) * 6,
        ),
        // side: BorderSide(
        //   color: Color(ListColor.colorLightGrey10),
        // ),
      ),
      color: Colors.white,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: CustomExpansionComponent(
        header: Material(
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(
          //     color: Color(ListColor.colorLightGrey10),
          //   ),
          // ),
          color: Colors.white,
          // elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              border: isOpen 
                ? Border(
                  bottom: BorderSide(color: Color(ListColor.colorStroke))
                )
                : null,
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () => setState(() {
                isOpen = !isOpen;
              }),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(context) * 16,
                  vertical: GlobalVariable.ratioWidth(context) * 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: widget.header,
                    ),
                    SvgPicture.asset(
                      isOpen
                          ? GlobalVariable.urlImageTemplateBuyer + "ic_chevron_up.svg"
                          : GlobalVariable.urlImageTemplateBuyer + "ic_chevron_down.svg",
                      width: GlobalVariable.ratioWidth(context) * 24,
                      height: GlobalVariable.ratioWidth(context) * 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        isOpen: isOpen,
        content: widget.content,
      ),
    );
  }
}

class AppBarDetailProfil extends PreferredSize {
  Color color;
  Color backgroundColor;

  final String title;
  final Widget customBody;
  final List<Widget> prefixIcon;
  final VoidCallback onClickBack;
  final int type;
  final Widget titleWidget;
  final bool isWithShadow;

  AppBarDetailProfil({
    Key key,
    this.title = '',
    this.customBody,
    this.prefixIcon,
    this.onClickBack,
    this.type,
    this.isWithShadow = true,
    this.titleWidget,
  });

  @override
  final Size preferredSize = GlobalVariable.preferredSizeAppBar;

  @override
  Widget build(BuildContext context) {
    if(type == 1){
      backgroundColor = Color(ListColor.colorBlue);
      color = Color(ListColor.colorWhite);
    }
    else if(type == 2){
      backgroundColor = Color(ListColor.colorYellowTransporter);
      color = Color(ListColor.colorBlack);
    }
    else if(type == 3){
      backgroundColor = Color(ListColor.colorLightBlue11);
      color = Color(ListColor.colorWhite);
    }

    return Container(
      decoration: BoxDecoration(color: backgroundColor, boxShadow: [
        if (isWithShadow)
          BoxShadow(
            offset: Offset(
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * 4,
            ),
            blurRadius: GlobalVariable.ratioWidth(context) * 15,
            color: Colors.black.withOpacity(0.20),
          ),
      ]),
      child: SafeArea(
        child: Container(
          height: GlobalVariable.ratioWidth(context) * 56,
          color: backgroundColor,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                ),
                child: customBody == null
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 5,
                            right: 0,
                            child: Image(
                              image: AssetImage("assets/fallin_star_3_icon.png"),
                              height: GlobalVariable.ratioWidth(context) * 56,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: _backButtonWidget(context),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: _titleProfileWidget(),
                          ),
                          prefixIcon != null
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ...prefixIcon,
                                    ],
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      )
                    : customBody,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleProfileWidget() {
    return titleWidget ?? CustomText(
      title,
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      textAlign: TextAlign.center,
    );
  }

  Widget _backButtonWidget(context) {
    return CustomBackButton(
      context: context,
      backgroundColor: color,
      iconColor: backgroundColor,
      onTap: onClickBack ?? Get.back,
    );
  }
}