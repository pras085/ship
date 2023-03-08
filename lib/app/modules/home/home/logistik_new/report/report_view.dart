import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/radio_button_custom_widget.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/report/report_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ReportView extends GetView<ReportController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.back();
        return false;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: _AppBar(
              preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
            ),
            backgroundColor: Colors.white,
            body: Obx(() =>
              controller.loading.value ? Center(child: CircularProgressIndicator()) : _showPage(),
            )
          ),
        ),
      ),
    );
  }

  Widget _showPage() {
    if(controller.pageIndex.value == 1) {
      return _firstPage();
    } else {
      return _secondPage();
    }
  }

  Widget _firstPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: controller.scrollControllerFirstPage,
            child: Obx(() => Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16, 
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'LaporkanIndexKategoriPelanggaran'.tr,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 3),
                  for (var i = 0; i < controller.reportCategory.length; i++) Container(
                    decoration: BoxDecoration(
                      border: i == controller.reportCategory.length - 1 ? null : Border(
                        bottom: BorderSide(
                          color: Color(ListColor.colorLightGrey10),
                          width: GlobalVariable.ratioWidth(Get.context) * 0.5
                        )
                      )
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 17
                    ),
                    child: Row(
                      children: [
                        RadioButtonCustom(
                          isWithShadow: true,
                          isDense: true,
                          toggleable: true,
                          height: GlobalVariable.ratioWidth(Get.context) * 16,
                          width: GlobalVariable.ratioWidth(Get.context) * 16,
                          groupValue: controller.groupValue.value,
                          value: (controller.reportCategory[i]['ID']).toString(),
                          onChanged: (value) {
                            print('Index: $i');
                            controller.groupValue.value = value;
                            controller.selectedCategory.value = value;
                            controller.checkFormFilled(controller.pageIndex.value);
                          },
                        ),
                        SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 6),
                        CustomText(
                          controller.reportCategory[i]['name'],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(ListColor.colorGrey3),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]
                    ),
                  )
                ],
              ), 
            )),
          )
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
              spreadRadius: 0,
              offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3)
            )]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
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
                text: "LaporkanIndexBatal".tr,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorBlue),
                backgroundColor: Colors.white,
                onTap: () async {
                  controller.back();
                }
              ),
              Obx(() => _button(
               width: 160,
                height: 32,
                marginLeft: 4,
                marginTop: 16,
                marginRight: 16,
                marginBottom: 16,
                borderSize: 1,
                borderRadius: 18,
                text: "LaporkanIndexSelanjutnya".tr,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: controller.isFilled.value ? Colors.white : Color(ListColor.colorLightGrey4),
                backgroundColor: controller.isFilled.value ? Color(ListColor.colorBlue) : Color(ListColor.colorLightGrey2),
                onTap: !controller.isFilled.value ? null : () {
                  controller.pageIndex.value = 2;
                }
              )),
            ],
          ),
        )
      ],
    );
  }

  Widget _secondPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: controller.scrollControllerSecondPage,
            child: Obx(() => Container(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16, 
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'LaporkanIndexDeskripsiPelanggaran'.tr + "*",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  CustomTextField(
                    context: Get.context,
                    controller: controller.textEditingController,
                    textInputAction: TextInputAction.search,
                    textSize: 14,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    maxLength: 300,
                    onChanged: (value) {
                      controller.counter.value = value.length;
                      controller.checkFormFilled(controller.pageIndex.value);
                    },
                    newInputDecoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      counterText: '${controller.counter.value}/300',
                      hintText: 'LaporkanIndexMasukkanDeskripsiPelanggaran'.tr,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey2),
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                        vertical: GlobalVariable.ratioWidth(Get.context) * 8
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey7),
                          width: GlobalVariable.ratioWidth(Get.context) * 1
                        ),
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey7),
                          width: GlobalVariable.ratioWidth(Get.context) * 1
                        ),
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey7),
                          width: GlobalVariable.ratioWidth(Get.context) * 1
                        ),
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                      ),
                    )
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                  CustomText(
                    'LaporkanIndexLampiranBukti'.tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 6),
                  CustomText(
                    'LaporkanIndexFormatFile'.tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                  _formProof()
                ],
              )
            )),
          )
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
              spreadRadius: 0,
              offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -3)
            )]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
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
                text: "LaporkanIndexBatal".tr,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorBlue),
                backgroundColor: Colors.white,
                onTap: () async {
                  controller.back();
                }
              ),
              _button(
               width: 160,
                height: 32,
                marginLeft: 4,
                marginTop: 16,
                marginRight: 16,
                marginBottom: 16,
                borderSize: 1,
                borderRadius: 18,
                text: "LaporkanIndexLaporkan".tr,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: controller.isFilledSecondPage.value ? Colors.white : Color(ListColor.colorLightGrey4),
                backgroundColor: controller.isFilledSecondPage.value ? Color(ListColor.colorBlue) : Color(ListColor.colorLightGrey2),
                onTap: !controller.isFilledSecondPage.value ? null : () {
                  controller.doReport();
                }
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _formProof() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _progressBar(
          paddingBottom: 16
        ),
        Obx(() => controller.fileProof.isNotEmpty && controller.fileProof[controller.fileProof.length-1] == null ?
          _errorUpload(
            marginLeft: 0,
            marginRight: 0,
            marginBottom: 16,
            errorMessage: controller.fileProofResult[controller.fileProofResult.length-1],
          ) :
          SizedBox.shrink()
        ),
        Obx( () =>
          Container(
            // margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            constraints: BoxConstraints(
              minHeight: GlobalVariable.ratioWidth(Get.context) * 0,
              maxHeight: GlobalVariable.ratioWidth(Get.context) * 160
            ),
            child: RawScrollbar(
              thumbColor: Color(ListColor.colorGrey3),
              thickness: GlobalVariable.ratioWidth(Get.context) * 4,
              radius: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
              child: ListView.builder(
                controller: controller.fileProofScrollController,
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.fileProofResult.length,
                itemBuilder: (context, index) {
                  if(controller.fileProofResult[index].toString().contains(".")){
                     return _successUpload(
                      marginLeft: 0,
                      marginRight: 0,
                      marginBottom: 16,
                      message: controller.fileProofResult[index],
                      index: index
                    );
                  }
                  return SizedBox.shrink();
                }
              ),
            ),
          )
        ),
        Obx(() => controller.fileProof.length < 5 || controller.fileProof.any((element) => element == null)
          ? Align(
            alignment: Alignment.centerLeft,
            child: _button(
              width: 119,
              height: 30,
              marginLeft: 0,
              marginRight: 0,
              useBorder: false,
              borderRadius: 18,
              backgroundColor: Color(ListColor.colorBlue),
              customWidget: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/ic_upload_seller.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 12,
                    height: GlobalVariable.ratioWidth(Get.context) * 12,
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                  CustomText(
                    "Upload",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
              onTap: (){
                controller.showUpload();
              }
            ),
          )
          : SizedBox.shrink()
        ),
      ],
    );
  }

  Widget _progressBar({
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0
  }) {
    return Obx(() => controller.ratioPerForm[0] == -1.0 ? Container() : Padding(
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * paddingLeft, 
        GlobalVariable.ratioWidth(Get.context) * paddingTop, 
        GlobalVariable.ratioWidth(Get.context) * paddingRight, 
        GlobalVariable.ratioWidth(Get.context) * paddingBottom, 
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(Get.context).size.width - (GlobalVariable.ratioWidth(Get.context) * 32),
            height: GlobalVariable.ratioWidth(Get.context) * 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 9),
              color: Color(ListColor.colorLightGrey2)
            ),
          ),
          AnimatedContainer(
            duration: controller.ratioPerForm[0] == 0 ? Duration.zero : Duration(milliseconds: 200),
            width: (MediaQuery.of(Get.context).size.width - (GlobalVariable.ratioWidth(Get.context) * 32)) * controller.ratioPerForm[0],
            height: GlobalVariable.ratioWidth(Get.context) * 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 9),
              color: Color(controller.ratioPerForm[0] == 0 ? ListColor.colorLightGrey2 : ListColor.colorBlue),
            )
          )
        ],
      ),
    ));
  }

  Widget _divider({
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double width,
    double height,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft,
        GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight,
        GlobalVariable.ratioWidth(Get.context) * marginBottom
      ),
      width: maxWidth ? double.infinity : GlobalVariable.ratioWidth(Get.context) * width,
      height: GlobalVariable.ratioWidth(Get.context) * height,
      color: Color(ListColor.colorLightGrey10),
    );
  }

  Widget _successUpload({
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    String message,
    int index,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft, 
        GlobalVariable.ratioWidth(Get.context) * marginTop, 
        GlobalVariable.ratioWidth(Get.context) * marginRight, 
        GlobalVariable.ratioWidth(Get.context) * marginBottom, 
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
            child: SvgPicture.asset(
              "assets/ic_success_upload_seller.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 16,
              height: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 16),
              child: CustomText(
                message,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
                color: Color(ListColor.colorGreen3),
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                controller.fileProof.removeAt(index);
                controller.fileProofResult.removeAt(index);
                controller.checkFormFilled(controller.pageIndex.value);
              },
              child: SvgPicture.asset(
                "assets/ic_close_file.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 16,
                height: GlobalVariable.ratioWidth(Get.context) * 16,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
            child: GestureDetector(
              onTap: (){
                controller.showUpload();
                controller.changeIndex = index;
              },
              child: CustomText(
                  "Ubah File",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  color: Color(ListColor.colorBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorUpload({
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    String errorMessage,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft, 
        GlobalVariable.ratioWidth(Get.context) * marginTop, 
        GlobalVariable.ratioWidth(Get.context) * marginRight, 
        GlobalVariable.ratioWidth(Get.context) * marginBottom, 
      ),
      child: Row(
        crossAxisAlignment: errorMessage == "GlobalValidationLabelFileFormatAndSize".tr ? 
        CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
            // padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 2),
            child: SvgPicture.asset(
              "assets/ic_error_upload_seller.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 16,
              height: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
          ),
          Flexible(
            child: CustomText(
              errorMessage,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.colorRed),
            ),
          ),
        ],
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
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft,
        GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight,
        GlobalVariable.ratioWidth(Get.context) * marginBottom
      ),
      width: width == null ? maxWidth ? MediaQuery.of(Get.context).size.width : null : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
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
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        border: useBorder
          ? Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * borderSize,
              color: borderColor ?? Color(ListColor.colorBlue),
            )
          : null
      ),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
          ),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * paddingLeft,
              GlobalVariable.ratioWidth(Get.context) * paddingTop,
              GlobalVariable.ratioWidth(Get.context) * paddingRight,
              GlobalVariable.ratioWidth(Get.context) * paddingBottom
            ),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            child: customWidget == null
              ? CustomText(
                  text ?? "",
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                )
              : customWidget,
          )
        ),
      ),
    );
  }
}

class _AppBar extends PreferredSize {
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        color: Color(ListColor.colorWhite),
        child: Container(
          width: MediaQuery.of(Get.context).size.width,
          padding: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 16,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomBackButton(
                backgroundColor: Color(ListColor.colorBlue),
                iconColor: Colors.white,
                context: Get.context,
                onTap: () {
                  Get.back();
                }
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 20),
                  child: CustomText(
                    "LaporkanIndexLaporkanTransporter".tr,
                    color: Color(ListColor.colorBlue),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  _AppBar({this.preferredSize});
}