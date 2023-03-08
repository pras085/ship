import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/edit_group/edit_group_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:muatmuat/global_variable.dart';

class EditGroupView extends GetView<EditGroupController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          child: Container(
            height: GlobalVariable.ratioWidth(Get.context) * 56,
            width: Get.context.mediaQuery.size.width,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(ListColor.colorBlack).withOpacity(0.15),
                  blurRadius: GlobalVariable.ratioWidth(Get.context) * 15,
                  spreadRadius: 0,
                  offset:
                      Offset(0, GlobalVariable.ratioWidth(Get.context) * 4)),
            ], color: Colors.white),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 16),
                      child: CustomBackButton(
                          context: Get.context,
                          iconColor: Color(ListColor.colorWhite),
                          backgroundColor: Color(ListColor.colorBlue),
                          onTap: () {
                            Get.back();
                          }),
                    )),
                Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      'Edit Group',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                controller.loading.value
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        width: Get.context.mediaQuery.size.width,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                    // Positioned.fill(
                    //     child: Container(
                    //     alignment: Alignment.center,
                    //     color: Color(0xBB000000),
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         CircularProgressIndicator(),
                    //         Container(height: 8),
                    //         CustomText("Loading", color: Colors.white)
                    //       ],
                    //     ),
                    //   ))
                    : Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 16),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20,
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                8),
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      200)),
                                          child: Obx(
                                            () => Image(
                                                width: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    60,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        60,
                                                fit: BoxFit.cover,
                                                image: controller.selectedImage
                                                        .value.isNull
                                                    ? NetworkImage(
                                                        GlobalVariable
                                                                .urlImage +
                                                            controller
                                                                .group.avatar)
                                                    : FileImage(controller
                                                        .selectedImage.value)),
                                          ),
                                        )),
                                    CustomText(
                                      "Max 1 Mb",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorDarkGrey3),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _button(
                                            height: 24,
                                            paddingLeft: 20,
                                            paddingRight: 20,
                                            marginTop: 8,
                                            marginBottom: 16,
                                            text: "Upload",
                                            borderSize: 1.5,
                                            color: Color(ListColor.colorBlue),
                                            onTap: () {
                                              controller.chooseImage();
                                            }),
                                      ],
                                    ),
                                    // MaterialButton(
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.all(
                                    //             Radius.circular(30)),
                                    //         side: BorderSide(
                                    //             color: Colors.blue, width: 2)),
                                    //     padding: EdgeInsets.symmetric(
                                    //         horizontal: 20, vertical: 0),
                                    //     minWidth: 0,
                                    //     onPressed: () {
                                    //       controller.chooseImage();
                                    //     },
                                    //     child: CustomText("Upload",
                                    //         color: Colors.blue,
                                    //         fontWeight: FontWeight.bold)),
                                    TextFormFieldWidget(
                                      titleColor:
                                          Color(ListColor.colorDarkGrey3),
                                      titleTextStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      title: 'PartnerManagementGroupName'.tr,
                                      width: double.infinity,
                                      validator: (String value) {
                                        return null;
                                      },
                                      isPassword: false,
                                      isEmail: false,
                                      isPhoneNumber: false,
                                      hintText: "PartnerManagementGroupName".tr,
                                      hintTextStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey2)),
                                      textEditingController:
                                          controller.namaController,
                                    ),
                                    TextFormFieldWidget(
                                      titleColor:
                                          Color(ListColor.colorDarkGrey3),
                                      titleTextStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      title: 'PartnerManagementDescription'.tr,
                                      width: double.infinity,
                                      validator: (String value) {
                                        return null;
                                      },
                                      minLines: 4,
                                      isMultiLine: true,
                                      isPassword: false,
                                      isEmail: false,
                                      isPhoneNumber: false,
                                      hintText:
                                          "PartnerManagementDescription".tr,
                                      hintTextStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey2)),
                                      textEditingController:
                                          controller.deskripsiController,
                                    ),
                                    Container(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            17,
                                        margin: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24,
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                "Anggota Group",
                                                color: Color(
                                                    ListColor.colorDarkGrey3),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                controller.showListMitra();
                                              },
                                              padding: EdgeInsets.all(0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    "+ " +
                                                        "PartnerManagementAddMember"
                                                            .tr,
                                                    color:
                                                        Color(ListColor.color4),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                    Obx(
                                      () => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                            controller.selectedMitra.length,
                                            (index) {
                                          var mitra =
                                              controller.selectedMitra[index];
                                          return Container(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                32,
                                            margin: EdgeInsets.only(
                                                bottom:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // ClipRRect(
                                                //     borderRadius:
                                                //         BorderRadius.all(
                                                //             Radius.circular(
                                                //                 35)),
                                                //     child: Image.asset(
                                                //         "assets/gambar_example.jpeg",
                                                //         fit: BoxFit.cover,
                                                //         width: 40,
                                                //         height: 40)),
                                                Container(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          32,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          32,
                                                  child: CircleAvatar(
                                                    radius: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        20.0,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            GlobalVariable
                                                                    .urlImage +
                                                                mitra.avatar),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                ),
                                                Container(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                                Expanded(
                                                    child: CustomText(
                                                  mitra.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorDarkGrey3),
                                                )),
                                                _button(
                                                    height: 24,
                                                    marginLeft: 8,
                                                    marginRight: 4,
                                                    paddingLeft: 23,
                                                    paddingRight: 23,
                                                    text:
                                                        "PartnerManagementLabelDetail"
                                                            .tr,
                                                    color: Color(
                                                        ListColor.colorBlue),
                                                    onTap: () {
                                                      Get.toNamed(
                                                          Routes.TRANSPORTER,
                                                          arguments: [
                                                            mitra.id,
                                                            mitra.name,
                                                            mitra.avatar,
                                                            mitra.isGold
                                                          ]);
                                                    }),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.selectedMitra
                                                        .remove(mitra);
                                                  },
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          24,
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          24,
                                                      child: SvgPicture.asset(
                                                        "assets/ic_close1,5.svg",
                                                        color: Color(ListColor
                                                            .colorBlue),
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            15,
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            15,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _button(
                                        height: 32,
                                        marginTop: 12,
                                        marginBottom: 12,
                                        marginRight: 4,
                                        borderRadius: 26,
                                        text: "PartnerManagementLabelCancel".tr,
                                        color: Color(ListColor.colorBlue),
                                        onTap: () {
                                          Get.back();
                                        }),
                                  ),
                                  Expanded(
                                    child: _button(
                                        height: 32,
                                        marginTop: 12,
                                        marginBottom: 12,
                                        marginLeft: 4,
                                        borderRadius: 26,
                                        text: "PartnerManagementLabelSave".tr,
                                        backgroundColor:
                                            Color(ListColor.colorBlue),
                                        onTap: () {
                                          controller.checkUpdateGroup();
                                        }),
                                    // MaterialButton(
                                    //     onPressed: () {
                                    //       controller.checkUpdateGroup();
                                    //     },
                                    //     color: Colors.blue,
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.all(
                                    //             Radius.circular(20))),
                                    //     child: CustomText(
                                    //         "PartnerManagementLabelSave".tr,
                                    //         color: Colors.white)),
                                  ),
                                ],
                              ),
                            )
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

  Widget _button({
    double height,
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
      width: maxWidth ? MediaQuery.of(Get.context).size.width : null,
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
