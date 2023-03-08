import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_controller.dart';

class UbahKontakPicView extends GetView<UbahKontakPicController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return WillPopScope(
      onWillPop: () async {
        controller.cancel();
        return false;
      },
      child: Obx(
        () => Scaffold(
          extendBodyBehindAppBar: true,
          // primary: true,
          // resizeToAvoidBottomInset: true,
          appBar: AppBarProfile(
            title: "Ubah Kontak PIC",
            isCenter: false,
            onClickBack: () => controller.cancel(),
            isBlueMode: true,
            isWithBackgroundImage: true,
          ),
          body: Obx(() {
            if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
              return _content(
                context,
                // controller.dataModelResponse.value.data,
              );
            } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
              return ErrorDisplayComponent(
                "${controller.dataModelResponse.value.exception}",
                onRefresh: () => controller.fetchDataPicFromAPi(),
              );
            }
            return LoadingComponent();
          }),
          bottomNavigationBar: controller.dataModelResponse.value.state == ResponseStates.COMPLETE
              ? Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 64,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                        spreadRadius: 0,
                        offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3))
                  ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _button(
                          width: 160,
                          height: 32,
                          marginLeft: 16,
                          marginTop: 16,
                          marginRight: 4,
                          marginBottom: 16,
                          useBorder: true,
                          borderColor: Color(ListColor.colorBlue),
                          borderSize: 1,
                          borderRadius: 18,
                          text: "Batal",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorBlue),
                          backgroundColor: Colors.white,
                          onTap: () async {
                            controller.cancel();
                          }),
                      Obx(
                        () => _button(
                          width: 160,
                          height: 32,
                          marginLeft: 4,
                          marginTop: 16,
                          marginRight: 16,
                          marginBottom: 16,
                          borderRadius: 18,
                          onTap: () => controller.isFilled.value == false ? () {} : controller.checkFieldIsValid(),
                          backgroundColor: controller.isFilled.value == true ? Color(ListColor.colorBlue) : Color(ListColor.colorLightGrey2),
                          text: 'Simpan',
                          color: controller.isFilled.value ? Color(ListColor.colorWhite) : Color(ListColor.colorLightGrey4),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          useBorder: false,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _content(context
      // KontakPicShipperModel snapData,
      ) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(ListColor.colorWhite),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _begin(),
                    _formNamaPIC1(),
                    _formNoHpPIC1(),
                    _formNamaPIC2(),
                    _formNoHpPIC2(),
                    _formNamaPIC3(),
                    _formNoHpPIC3(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _begin() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16, GlobalVariable.ratioWidth(Get.context) * 24, GlobalVariable.ratioWidth(Get.context) * 16, 0),
      child: CustomText(
        'Masukkan Kontak PIC Perusahaan Anda untuk dihubungi oleh Shipper',
        fontSize: 12,
        height: 14.4 / 12,
        color: Color(ListColor.colorLightGrey4),
      ),
    );
  }

  Widget _formNamaPIC1() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'Nama PIC 1*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              // margin: EdgeInsets.fromLTRB(
              //     GlobalVariable.ratioWidth(Get.context) * 0,
              //     GlobalVariable.ratioWidth(Get.context) * 12,
              //     GlobalVariable.ratioWidth(Get.context) * 0,
              //     GlobalVariable.ratioWidth(Get.context) * 24),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isNamaPic1Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorBlack),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.' ]")),
                        LengthLimitingTextInputFormatter(255)
                      ],
                      controller: controller.namaPIC1C.value,
                      onChanged: (value) async {
                        // controller.isNamaPic1Valid.value = true;
                        controller.makeAllValid();
                        if (controller.namaPic1.value != value) {
                          controller.namaPic1.value = value;
                        }
                        await controller.checkAllFieldIsFilled();
                      },
                      newInputDecoration: InputDecoration(
                        hintText: 'Masukkan nama PIC',
                        hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
                        fillColor: Colors.transparent,
                        filled: true,
                        isDense: true,
                        isCollapsed: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 2,
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  InkWell(
                    onTap: () async {
                      await controller.pickContact1();
                      await controller.checkAllFieldIsFilled();
                    },
                    child: Obx(
                      () => SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(
                          controller.namaPic1.value == "" ? ListColor.colorLightGrey2 : ListColor.colorBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formNoHpPIC1() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'No. HP PIC 1*',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 0),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(
                      controller.isNoPic1Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed,
                    )),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                keyboardType: TextInputType.number,
                controller: controller.noHpPIC1C.value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(
                    ListColor.colorBlack,
                  ),
                ),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(14)],
                onChanged: (value) async {
                  controller.makeAllValid();
                  await controller.checkAllFieldIsFilled();
                },

                // initialValue: controller.noHpPIC1C.value.text.isNotEmpty
                //     ? controller.noHpPIC1C.value.text
                //     : "",
                newInputDecoration: InputDecoration(
                  hintText: 'Masukkan No. HP PIC',
                  hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                  isCollapsed: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formNamaPIC2() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'Nama PIC 2',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isNamaPic2Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CustomTextFormField(
                        context: Get.context,
                        autofocus: false,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(
                            ListColor.colorBlack,
                          ),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.' ]")),
                          LengthLimitingTextInputFormatter(255)
                        ],
                        controller: controller.namaPIC2C.value,
                        onChanged: (value) {
                          // controller.isOptionalFilled.value = true;
                          controller.makeAllValid();
                          if (controller.namaPic2.value != value) {
                            controller.namaPic2.value = value;
                          }
                          controller.checkAllFieldIsFilled();
                        },
                        newInputDecoration: InputDecoration(
                          hintText: 'Masukkan Nama PIC',
                          hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
                          fillColor: Colors.transparent,
                          filled: true,
                          isDense: true,
                          isCollapsed: true,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await controller.pickContact2();
                      // await controller
                      //     .checkNamleField2(controller.namaPIC2C.value.text);
                    },
                    child: Obx(
                      () => SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(
                          controller.namaPic2.value == "" ? ListColor.colorLightGrey2 : ListColor.colorBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formNoHpPIC2() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'No. HP PIC 2',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(
                      controller.isNoPic2Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed,
                    )),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: CustomTextFormField(
                context: Get.context,
                autofocus: false,
                controller: controller.noHpPIC2C.value,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(
                    ListColor.colorBlack,
                  ),
                ),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(14)],
                onChanged: (value) async {
                  controller.makeAllValid();
                  await controller.checkAllFieldIsFilled();
                },
                newInputDecoration: InputDecoration(
                  hintText: 'Masukkan No. HP PIC',
                  hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                  isCollapsed: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formNamaPIC3() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
          CustomText(
            'Nama PIC 3',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 12),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              decoration: BoxDecoration(
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(controller.isNamaPic3Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)),
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Expanded(
                      child: CustomTextFormField(
                        context: Get.context,
                        autofocus: false,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(
                            ListColor.colorBlack,
                          ),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.' ]")),
                          LengthLimitingTextInputFormatter(255)
                        ],
                        onChanged: (value) {
                          controller.makeAllValid();
                          if (controller.namaPic3.value != value) {
                            controller.namaPic3.value = value;
                          }
                          controller.checkAllFieldIsFilled();
                        },
                        controller: controller.namaPIC3C.value,
                        newInputDecoration: InputDecoration(
                          hintText: 'Nama PIC 3',
                          hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
                          fillColor: Colors.transparent,
                          filled: true,
                          isDense: true,
                          isCollapsed: true,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  InkWell(
                    onTap: () async {
                      await controller.pickContact3();
                    },
                    child: Obx(
                      () => SvgPicture.asset(
                        'assets/find_contact.svg',
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: Color(
                          controller.namaPic3.value == "" ? ListColor.colorLightGrey2 : ListColor.colorBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formNoHpPIC3() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'No. HP PIC 3',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorLightGrey4),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 0, GlobalVariable.ratioWidth(Get.context) * 24),
            padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
              vertical: GlobalVariable.ratioWidth(Get.context) * 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(controller.isNoPic3Valid.value == true ? ListColor.colorLightGrey10 : ListColor.colorRed)),
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
            ),
            child: CustomTextFormField(
              context: Get.context,
              autofocus: false,
              controller: controller.noHpPIC3C.value,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(
                  ListColor.colorBlack,
                ),
              ),
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(14)],
              onChanged: (value) async {
                controller.makeAllValid();
                await controller.checkAllFieldIsFilled();
              },
              newInputDecoration: InputDecoration(
                hintText: 'Masukkan No. HP PIC',
                hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(ListColor.colorLightGrey2)),
                fillColor: Colors.transparent,
                filled: true,
                isDense: true,
                isCollapsed: true,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 2,
                ),
              ),
            ),
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
            )),
      ),
    );
  }
}
