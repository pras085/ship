import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/otp_phone/otp_phone_controller.dart';
import 'package:muatmuat/app/modules/privacy_and_policy_register/privacy_policy_register_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_condition_point_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class PrivacyPolicyRegisterView extends GetView<PrivacyPolicyRegisterController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ListColor.colorBlue),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(ListColor.colorBlue),
          body: Stack(
            children: [
              Container(
                alignment: Alignment.topLeft,
                color: Color(ListColor.colorBlue),
                width: double.infinity,
                height: double.infinity,
                child: Image.asset("assets/meteor_putih.png", 
                  width: GlobalVariable.ratioWidth(Get.context) * 91, 
                  height: GlobalVariable.ratioWidth(Get.context) * 91,),
              ),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 24,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 24,
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomBackButton2(
                            context: Get.context,
                            onTap: () {
                              Get.back();
                            }
                          ),
                        ),
                        Container(
                          child: SvgPicture.asset(
                            "assets/ic_logo_muatmuat_putih.svg",
                            height: GlobalVariable.ratioWidth(Get.context) * 21,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: CustomText(
                              "GeneralLRPrivacyLabelKebijakanPrivasi".tr,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 367,
                            margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 18,
                              bottom: 0,
                              right: GlobalVariable.ratioWidth(Get.context) * 16,
                              left: GlobalVariable.ratioWidth(Get.context) * 16
                            ),
                            decoration: BoxDecoration(
                              color: Color(ListColor.colorWhite),
                              borderRadius: BorderRadius.circular( GlobalVariable.ratioWidth(Get.context) * 8)
                            ),
                            child: Obx(() => !controller.isSuccess.value ? Center(
                              child: Container(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(ListColor.colorBlue)),
                                )
                              ))
                            : NotificationListener<ScrollNotification>(
                                onNotification: (notif) {
                                  if (notif.metrics.pixels > 0 &&
                                      notif.metrics.atEdge) {
                                    controller.atBottom.value = true;
                                    print("dibawah");
                                  }
                                  return true;
                                },
                                child: RawScrollbar(
                                  thumbColor: Color(ListColor.colorGrey9),
                                          thickness: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              4,
                                          radius: Radius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  3),
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(Get.context) * 14,
                                      bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                                      right: GlobalVariable.ratioWidth(Get.context) * 16,
                                      left: GlobalVariable.ratioWidth(Get.context) * 16
                                    ),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Html(
                                              data: controller.listPoint[0].data,
                                              style: {
                                                "body": Style(
                                                  textAlign: TextAlign.justify,
                                                  margin: EdgeInsets.zero,
                                                  padding: EdgeInsets.zero,
                                                  fontFamily: "AvenirNext",
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(ListColor.colorLightGrey4),
                                                  fontSize: FontSize(GlobalVariable.ratioFontSize(Get.context) * 12),
                                                ),
                                              },
                                              onLinkTap: (url) {
                                                print("Opening $url...");
                                                controller.urlLauncher(url);
                                              },
                                            ),
                                          )
                                        ]
                                      ),
                                    )
                                  ),
                                ),
                              )
                            ),
                          ),
                          for (int i = 0; i < controller.listPoint.length; i++)
                            i == 0 ? SizedBox.shrink() : Container(
                              margin: EdgeInsets.only(
                                top: i == 1 ? GlobalVariable.ratioWidth(Get.context) * 20 
                                : GlobalVariable.ratioWidth(Get.context) * 12
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                                      right: GlobalVariable.ratioWidth(Get.context) * 12,
                                      top: GlobalVariable.ratioWidth(Get.context) * 3
                                    ),
                                    child: Obx(() => CheckBoxCustom2(
                                      onChanged: controller.atBottom.value ? (value) {
                                        controller.listCheck[i] = value;
                                        controller.isOK.value = controller.isAllCheck();
                                      } : null,
                                      size: 16,
                                    )),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(Get.context) * 5,
                                        right: GlobalVariable.ratioWidth(Get.context) * 20
                                      ),
                                      child: Html(
                                        data: controller.listPoint[i].data,
                                        style: {
                                          '*': Style(
                                            margin: EdgeInsets.zero,
                                            padding: EdgeInsets.zero,
                                          ),
                                          'p': Style(
                                            fontSize: FontSize(
                                              GlobalVariable.ratioWidth(context) * 12
                                            ),
                                            lineHeight: LineHeight(1.2),
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          Obx(() => _button(
                            marginTop: 32,
                            marginLeft: 16,
                            marginRight: 16,
                            marginBottom: 146,
                            text: "GeneralLRTermsLabelSelanjutnya".tr,
                            color: Color(controller.isOK.value ? ListColor.colorBlue : ListColor.colorLightGrey4),
                            backgroundColor: Color(controller.isOK.value ? ListColor.colorYellow : ListColor.colorLightGrey2),
                            height: 36,
                            fontSize: 14,
                            onTap: controller.isOK.value ? () {
                              controller.doRegisterUser();
                              // GetToPage.toNamed<OtpPhoneController>(
                              //   Routes.OTP_PHONE_REGISTER,
                              //   arguments: controller.userModel.value
                              // );
                            } : null
                          )),
                        ]
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getListTermsAndCondition() {
    List<Widget> list = [];
    if (controller.listPoint.length > 0) {
      for (int i = 0; i < controller.listPoint.length; i++) {
        TermsAndConditionsPointModel termsAndConditionsPointModel =
            controller.listPoint[i];
        list.add(_getDetailTermsAndCondition(termsAndConditionsPointModel, i));
      }
    }
    return list;
  }

  Widget _getDetailTermsAndCondition(
      TermsAndConditionsPointModel termsAndConditionsPointModel, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: termsAndConditionsPointModel.isChecked,
          onChanged: controller.isSuccess.value
              ? (value) {
                  controller.setCheckbox(value, index);
                }
              : null,
          checkColor: Color(ListColor.colorBlue),
          activeColor: Colors.transparent,
        ),
        Expanded(
          child: Html(
            data: termsAndConditionsPointModel.data,
            onLinkTap: (url) {
              print("Opening $url...");
              controller.urlLauncher(url);
            },
          ),
        ),
      ],
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
            onTap: onTap == null
                ? null
                : () {
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
