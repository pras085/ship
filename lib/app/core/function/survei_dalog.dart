import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';

class SurveiDialog{
  static void showSurveiDialog(BuildContext context){
    var selectedSurveiOption = "0".obs;
    var textController = TextEditingController();
    var lebar = 20 * GlobalVariable.ratioWidth(Get.context);
    var loadingSurvei = true.obs;
    var listSurveiOption = [].obs;
    var withAlpha = false.obs;
    getListSurveiOption(listSurveiOption, loadingSurvei, withAlpha);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          // key: _keyDialog,
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 10)
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(()=>
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.ratioWidth(context) * 23,
                          vertical: GlobalVariable.ratioWidth(context) * 30
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: GlobalVariable.ratioWidth(context) * 4
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: CustomText(
                                  // "SubscriptionCancelConfirmation".tr,
                                  "Selamat Datang di Ekosistem muatmuat",
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: GlobalVariable.ratioWidth(context) * 20
                              ),
                              child: CustomText(
                                // "SubscriptionCancelConfirmationMessage".tr,
                                "Bantu kami mengisi survei berikut ini. Partisipasi Anda sangat berarti untuk pengembangan muatmuat.",
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Container(  
                              margin: EdgeInsets.only(
                                bottom: GlobalVariable.ratioWidth(context) * 14
                              ),                                          
                              child: CustomText(
                                // "SubscriptionCancelConfirmationMessage".tr,
                                "Darimana Anda Mengetahui muatmuat?",
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            for(var index = 0; index < listSurveiOption.value.length; index++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Obx(() => 
                                          RadioButtonCustom(
                                            colorSelected: Color(ListColor.colorBlue),
                                            colorUnselected: Color(ListColor.colorLightGrey7),
                                            isWithShadow: true,
                                            isDense: true,
                                            width: lebar,
                                            height: lebar,
                                            groupValue: selectedSurveiOption.value,
                                            value: listSurveiOption[index]["ID"].toString(),
                                            onChanged: (value) {
                                              selectedSurveiOption.value = value;
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 14),
                                          child: Expanded(
                                            child: CustomText(
                                              listSurveiOption[index]["Name"],
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(ListColor.colorDarkGrey3),
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: GlobalVariable.ratioWidth(context) * 12,
                                  ),
                                ],
                              ),
                            Obx(() => selectedSurveiOption.value != listSurveiOption.length.toString()
                              ? SizedBox(
                                  height: GlobalVariable.ratioWidth(context) * 30
                                )
                              : SizedBox.shrink()
                            ),
                            Obx(() => selectedSurveiOption.value == listSurveiOption.length.toString()
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioWidth(Get.context) * 0,
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                    GlobalVariable.ratioWidth(Get.context) * 0,
                                    GlobalVariable.ratioWidth(Get.context) * 30,
                                  ),
                                  height: GlobalVariable.ratioWidth(Get.context) * 40,
                                  // TARUH BORDER TEXTFIELD DISINI
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                                      color: Color(ListColor.colorLightGrey10)
                                    ),
                                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)
                                  ),
                                  padding: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                          context: Get.context,
                                          autofocus: false,
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {
                                            
                                          },
                                          controller: textController,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            height: 1.2,
                                          ),
                                          textSize: 14,
                                          newInputDecoration: InputDecoration(
                                            hintText: "Masukkan Jawaban Anda",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(ListColor.colorLightGrey2)
                                            ),
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
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _button(
                                  // Get.context,
                                  marginRight: 4,
                                  text: "Lewati",
                                  height: 36,
                                  width: 104,
                                  useBorder: true,
                                  borderSize: 1,
                                  borderColor: Color(ListColor.colorBlue),
                                  color: Color(ListColor.colorBlue),
                                  backgroundColor: Colors.white,
                                  onTap: () {
                                    Get.back();
                                  }
                                ),
                                _button(
                                  // Get.context,
                                  marginLeft: 4,
                                  text: "Kirim",
                                  height: 36,
                                  width: 104,
                                  color: Colors.white,
                                  backgroundColor: Color(ListColor.colorBlue),
                                  onTap: () {
                                    if(selectedSurveiOption.value == listSurveiOption.length.toString() && textController.text.isEmpty){
                                      CustomToastTop.show(context: Get.context, isSuccess: 0, message: "Please fill the form");
                                    } else {
                                      doAddSurvei(selectedSurveiOption.value, 
                                      selectedSurveiOption.value == listSurveiOption.length.toString()
                                      ? textController.text
                                      : listSurveiOption.value.firstWhere(
                                        (element) => 
                                        element["ID"].toString() == selectedSurveiOption.value)["Name"],
                                      loadingSurvei, withAlpha);
                                    }
                                  }
                                ),
                              ],
                            )
                          ],
                        )
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 12,
                            top: GlobalVariable.ratioWidth(Get.context) * 12
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                "assets/ic_close1,5.svg",
                                color: Color(ListColor.colorBlue),
                                width: GlobalVariable.ratioWidth(Get.context) * 15,
                                height: GlobalVariable.ratioWidth(Get.context) * 15,
                              )
                            )
                          ),
                        )
                      ),
                      !loadingSurvei.value 
                        ? SizedBox.shrink() 
                        : Positioned.fill(
                          child: Obx(()=>
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: GlobalVariable.ratioWidth(context) * 23,
                                vertical: GlobalVariable.ratioWidth(context) * 30
                              ),
                              decoration: BoxDecoration(
                                color: withAlpha.value ? Colors.grey.withAlpha(120) : Colors.white,
                                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 10)
                              ),
                              child: Center(child: CircularProgressIndicator())
                            ),
                          )
                        )
                    ]
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  static void getListSurveiOption(List listSurveiOption, RxBool loadingSurvei, RxBool withAlpha) async {
    withAlpha.value = false;
    loadingSurvei.value = true;
    var result = await ApiHelper(context: Get.context, isShowDialogLoading: false).fetchDataFromUrlPOSTMuatMuat(ApiHelper.urlInternal + "api/get_survey_option", {"Locale" : GlobalVariable.languageType});
    if(result["Message"] != null && result["Message"]["Code"] == 200){
      listSurveiOption.clear();
      listSurveiOption.addAll(result["Data"]);
      loadingSurvei.value = false;
    }
  }

  static void doAddSurvei(String id, String text, RxBool loadingSurvei, RxBool withAlpha) async {
    withAlpha.value = true;
    loadingSurvei.value = true;
    var result = await ApiHelper(context: Get.context, isShowDialogLoading: false).fetchDataFromUrlPOSTMuatMuatAfterLogin(
      ApiHelper.urlInternal + "backend/do_add_survey_users", 
      {
        "RateID" : id, 
        "RateStr" : text
      }
    );
    if(result["Message"] != null && result["Message"]["Code"] == 200){
      loadingSurvei.value = false;
      Get.back();
      CustomToastTop.show(context: Get.context, isSuccess: 1, message: "Survei berhasil dikirim!");
    } else {
      loadingSurvei.value = false;
      CustomToastTop.show(context: Get.context, isSuccess: 0, message: result["Message"]["Text"]);
    }
  }

  static Widget _button({
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
          onTap: () {
            onTap();
          },
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