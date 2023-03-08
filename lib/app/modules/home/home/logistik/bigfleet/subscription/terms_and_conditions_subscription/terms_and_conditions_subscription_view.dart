import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/tac_point_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/terms_and_conditions_subscription_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class TermsAndConditionsSubscriptionView
    extends GetView<TermsAndConditionsSubscriptionController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuild());
    return Scaffold(
      appBar: AppBarDetail(
        title: ('SubscriptionCreateLabelTnC'.tr).replaceAll("\\n", "\n"),
      ),
      body: Container(
        color: Color(ListColor.colorWhite),
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : controller.isSuccess
                  ? SingleChildScrollView(
                      child: Column(
                        children: _listContent(),
                      ),
                    )
                  : SizedBox.shrink(),
        ),
      ),
      bottomNavigationBar: _bottomListButton(),
    );
  }

  Widget _bottomListButton() {
    return Container(
      padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight:
              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0x54000000),
              spreadRadius: GlobalVariable.ratioWidth(Get.context) * 2,
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 40,
              offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 20)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                controller.onAccept(Get.context);
              },
              // style: OutlinedButton.styleFrom(
              //     backgroundColor: Color(ListColor.color4),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 26)),
              //     )),
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 160,
                height: GlobalVariable.ratioWidth(Get.context) * 32,
                decoration: BoxDecoration(
                    color: Color(ListColor.colorBlue),
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 26)),
                alignment: Alignment.center,
                child: CustomText(
                  'SubscriptionContinue'.tr,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  List<Widget> _listContent() {
    List<Widget> list = [];
    if (controller.listPoint.length > 0) {
      for (int i = 0; i < controller.listPoint.length; i++) {
        if (i == 0)
          list.add(
              _getDetailContentTermsAndCondition(controller.listPoint[i].data));
        else
          list.add(_getDetailTermsAndCondition(controller.listPoint[i], i));
      }
      if (controller.isErrorCheck.value) {
        list.add(Container(
          width: MediaQuery.of(Get.context).size.width,
          constraints: BoxConstraints(minHeight: GlobalVariable.ratioWidth(Get.context) * 38,),
          margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(Get.context) * 5,
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              right: GlobalVariable.ratioWidth(Get.context) * 16,
              bottom: GlobalVariable.ratioWidth(Get.context) * 24),
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 30,
              vertical: GlobalVariable.ratioWidth(Get.context) * 0),
          decoration: BoxDecoration(
              color: Color(ListColor.colorLightRed3),
              borderRadius: BorderRadius.all(
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6))),
          child: Center(
            child: CustomText(
              'SubscriptionAlertTOC'.tr,
              color: Color(ListColor.colorRed),
              fontWeight: FontWeight.w600,
              fontSize: 12,
              height: 1.25,
              textAlign: TextAlign.center,
            ),
          ),
        ));
      }
      // list.add(SizedBox(
      //   height: GlobalVariable.ratioWidth(Get.context) * 80,
      // ));
    }
    return list;
  }

  Widget _getDetailContentTermsAndCondition(String content) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 16,
        GlobalVariable.ratioWidth(Get.context) * 20,
        GlobalVariable.ratioWidth(Get.context) * 16,
        GlobalVariable.ratioWidth(Get.context) * 24,
      ),
      child: Container(
        height: GlobalVariable.ratioWidth(Get.context) * 302,
        decoration: BoxDecoration(
          border: Border.all(
            width: GlobalVariable.ratioWidth(Get.context) * 1,
            color: Color(ListColor.colorLightGrey2),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: NotificationListener(
          onNotification: (notif) {
            if (notif.metrics.pixels > 0 && notif.metrics.atEdge) {
              controller.atBottom.value = true;
            }
            return true;
          },
          child: RawScrollbar(
            thumbColor: Color(ListColor.colorLightGrey4),
            radius:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 28),
            thickness: GlobalVariable.ratioWidth(Get.context) * 2,
            child: ListView(
              padding: EdgeInsets.all(
                GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Html(
                  data: content,
                  style: {
                    "*": Style(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    ),
                    "body": Style(
                      fontFamily: "AvenirNext",
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w400,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: FontSize(
                        GlobalVariable.ratioFontSize(Get.context) * 14,
                      ),
                    ),
                    "b": Style(
                      fontWeight: FontWeight.w600,
                    ),
                  },
                  onLinkTap: (url) {
                    print("Opening $url...");
                    controller.urlLauncher(url);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDetailTermsAndCondition(
    TACPointModel termsAndConditionsPointModel,
    int index,
  ) {
    return GestureDetector(
      onTap: () => controller.setCheckbox(
          !termsAndConditionsPointModel.isChecked, index),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 18,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 2,
                right: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              child: CheckBoxCustom(
                border: 1,
                isWithShadow: true,
                value: termsAndConditionsPointModel.isChecked,
                size: 16,
                paddingTop: 0,
                paddingBottom: 0,
                paddingLeft: 0,
                paddingRight: 0,
                shadowSize: 18,
                onChanged: controller.isSuccess
                    ? (value) {
                        controller.setCheckbox(value, index);
                      }
                    : null,
              ),
            ),
            Expanded(
              child: Container(
                child: Html(
                  data: termsAndConditionsPointModel.data,
                  style: {
                    "*": Style(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    ),
                    "body": Style(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      fontFamily: "AvenirNext",
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorGrey4),
                      fontSize: FontSize(
                          GlobalVariable.ratioFontSize(Get.context) * 14),
                    ),
                  },
                  onLinkTap: (url) {
                    print("Opening $url...");
                    controller.urlLauncher(url);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
