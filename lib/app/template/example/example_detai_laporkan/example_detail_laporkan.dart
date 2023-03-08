import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_halaman_laporkan_buyer.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_with_text_widget.dart';
import 'package:muatmuat/global_variable.dart';

import 'example_detail_laporkan_controller.dart';

class ExampleDetailLaporkanView extends GetView<ExampleDetailLaporkanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDetailBuyer(
        onClickBack: () => Get.back(),
        isWithPrefix: false,
        title: 'Laporkan Iklan',
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(ListColor.colorWhiteTemplate),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: GlobalVariable.ratioWidth(context) * 500,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 16,
                    GlobalVariable.ratioWidth(context) * 20,
                    GlobalVariable.ratioWidth(context) * 16,
                    GlobalVariable.ratioWidth(context) * 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        'Pilih kategori pelanggaran yang terjadi pada iklan ini',
                        fontWeight: FontWeight.w700,
                        height: 16.8 / 14,
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 20),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(
                              height: GlobalVariable.ratioWidth(context) * 0.5,
                              color: Color(ListColor.colorGreyTemplate8),
                              margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
                            );
                          },
                          // shrinkWrap: true,
                          itemCount: controller.listReport.length,
                          itemBuilder: (context, i) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadioButtonCustomWithText(
                                  isTextOnRightOfCheckBox: true,
                                  radioSize: 16,
                                  value: controller.listReport[i].toString(),
                                  // colorSelected: Color(ListColor.colorBlue),
                                  // colorUnselected: Color(ListColor.colorGreyTemplate4),
                                  groupValue: controller.selectedValue,
                                  toggleable: true,
                                  onChanged: (value) {
                                    controller.selectedValue = value;
                                    log('::: ' + controller.selectedValue);
                                    controller.valueObs.value = value;
                                  },
                                  isWithShadow: true,
                                  isDense: true,
                                  customTextWidget: CustomText(
                                    controller.listReport[i],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorGreyTemplate3),
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // width: GlobalVariable.ratioWidth(context) * 16,
                                  // height: GlobalVariable.ratioWidth(context) * 16,
                                ),
                                // SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                              ],
                            );
                          },
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
      bottomNavigationBar: componentFixedButton(context, controller.isCheck, controller.textC, 'Lanjutkan'),
    );
  }

  Widget componentFixedButton(
    BuildContext context,
    RxBool isCheck,
    TextEditingController textC,
    String label,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
        vertical: GlobalVariable.ratioWidth(context) * 12,
      ),
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhiteTemplate),
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _button(
              width: 160,
              height: 32,
              borderRadius: 26,
              text: 'Batalkan',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.colorWhiteTemplate),
              backgroundColor: Color(ListColor.colorBlueTemplate1),
              onTap: () async {}),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
          Obx(
            () => _button(
              width: 160,
              height: 32,
              borderRadius: 26,
              onTap: () => openBottomSheet(
                context: context,
                textController: controller.textC,
                isChecked: controller.isCheck,
              ),
              backgroundColor: Color(ListColor.colorWhiteTemplate),
              text: 'Lanjutkan',
              color: Color(controller.valueObs.value != "" ? ListColor.colorBlueTemplate1 : ListColor.colorGreyTemplate5),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              useBorder: true,
              borderColor: Color(controller.valueObs.value != "" ? ListColor.colorBlueTemplate1 : ListColor.colorGreyTemplate5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(
      {double height,
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
      Widget customWidget}) {
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
                    text,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: color,
                  )
                : customWidget,
          ),
        ),
      ),
    );
  }

  void openBottomSheet({
    @required BuildContext context,
    @required TextEditingController textController,
    @required RxBool isChecked,
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
      builder: (context) {
        return Container(
          width: double.infinity,
          height: GlobalVariable.ratioWidth(context) * 482,
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
                        "Laporkan Iklan",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: GlobalVariable.ratioWidth(context) * 24),
              Container(
                width: GlobalVariable.ratioWidth(context) * 328,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 17,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        'Detail Pelanggaran*',
                        fontWeight: FontWeight.w600,
                        withoutExtraPadding: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(context) * 12, //coba
                        bottom: GlobalVariable.ratioWidth(context) * 16,
                      ),
                      padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 8),
                      height: GlobalVariable.ratioWidth(context) * 100,
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(ListColor.colorGreyTemplate2),
                        ),
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
                        color: Color(ListColor.colorWhiteTemplate),
                      ),
                      child: CustomTextFormField(
                        newContentPadding: EdgeInsets.zero,
                        context: context,
                        controller: textController,
                        newInputDecoration: InputDecoration(
                          hintText: 'Jelaskan pelanggaran yang terjadi',
                          isDense: true,
                          hintStyle: TextStyle(
                            color: Color(ListColor.colorGreyTemplate8),
                            fontWeight: FontWeight.w500,
                            fontSize: GlobalVariable.ratioWidth(context) * 12,
                          ),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 105,
                width: GlobalVariable.ratioWidth(context) * 328,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 17,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        'Foto Bukti Laporan',
                        fontWeight: FontWeight.w600,
                        withoutExtraPadding: true,
                      ),
                    ),
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 76,
                      width: double.infinity,
                      color: Color(ListColor.colorWhiteTemplate),
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(context) * 12,
                        bottom: GlobalVariable.ratioWidth(context) * 8,
                      ),
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                log('::::: ' + i.toString());
                                controller.showUpload();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(context) * 12),
                                padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
                                  border: Border.all(color: Color(ListColor.colorShadowTemplate2)),
                                ),
                                child: SvgPicture.asset(
                                  GlobalVariable.urlImageTemplateBuyer + 'gallery_add_template.svg',
                                  height: GlobalVariable.ratioWidth(context) * 24,
                                  width: GlobalVariable.ratioWidth(context) * 24,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    CustomText(
                      'Format file jpg/png max. 5MB',
                      fontSize: 10,
                      color: Color(ListColor.colorGreyTemplate3),
                      withoutExtraPadding: true,
                    ),
                  ],
                ),
              ),
              Container(
                // height: GlobalVariable.ratioWidth(context) * 32,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
                decoration: BoxDecoration(
                  color: Color(ListColor.colorWhiteTemplate),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(ListColor.colorGreyTemplate9),
                      width: GlobalVariable.ratioWidth(context) * 0.5,
                    ),
                    top: BorderSide(
                      color: Color(ListColor.colorGreyTemplate9),
                      width: GlobalVariable.ratioWidth(context) * 0.5,
                    ),
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CheckBoxCustom2(
                      onChanged: (bool) {
                        isChecked.value = bool;
                      },
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                    Expanded(
                      child: CustomText(
                        'Saya dengan ini menyataka bahwa segala informasi yang dilaporkan memang benar',
                        withoutExtraPadding: true,
                        color: Color(ListColor.colorGreyTemplate3),
                        height: 16.8 / 14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              componentFixeedButtonDialogForm(
                context: context,
                detailObs: controller.valueObs,
                controller: controller.textC,
                onReportTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget componentFixeedButtonDialogForm({
    @required BuildContext context,
    @required Function onReportTap,
    @required TextEditingController controller,
    RxString detailObs,
    String label,
  }) {
    return Container(
      // height: GlobalVariable.ratioWidth(context) * 32,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 12,
      ),
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhiteTemplate),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _button(
            width: 160,
            height: 32,
            borderRadius: 26,
            text: 'Batalkan',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorWhiteTemplate),
            backgroundColor: Color(ListColor.colorBlueTemplate1),
            onTap: () async {},
          ),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
          Obx(
            () => _button(
              width: 160,
              height: 32,
              borderRadius: 26,
              onTap: () => detailObs.value != "" ? () => onReportTap : () {},
              // onTap: () => onReportTap,
              backgroundColor: Color(ListColor.colorWhiteTemplate),
              color: Color(detailObs.value != "" ? ListColor.colorBlueTemplate1 : ListColor.colorGreyTemplate5),
              text: 'Laporkan',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              useBorder: true,
              borderColor: Color(detailObs.value != "" ? ListColor.colorBlueTemplate1 : ListColor.colorGreyTemplate5),
            ),
          ),
        ],
      ),
    );
  }
}
