import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_condition_point_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ListColor.colorBlue),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: CustomText('TACLabelTitle'.tr,
                  fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Obx(() => !controller.isSuccess.value
                    ? Center(
                        child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()))
                    : SingleChildScrollView(
                        child: Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Obx(
                          () => Column(children: _getListTermsAndCondition()
                              // [
                              //   Container(
                              //     // margin: EdgeInsets.only(top: 20),
                              //     child: Html(
                              //       data: controller.termsConditionData.value,
                              //       onLinkTap: (url) {
                              //         print("Opening $url...");
                              //         controller.urlLauncher(url);
                              //       },
                              //     )

                              //     ,
                              //   ),
                              // ],
                              ),
                        ),
                      ))),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(ListColor.colorBlue),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Obx(
                  //   () => Row(
                  //     children: [
                  //       Theme(
                  //         data: ThemeData(unselectedWidgetColor: Colors.white),
                  //         child: Checkbox(
                  //           value: controller.isAgreeTC.value,
                  //           onChanged: controller.isSuccess.value
                  //               ? (value) {
                  //                   controller.isAgreeTC.value = value;
                  //                 }
                  //               : null,
                  //           checkColor: Color(ListColor.color5),
                  //           activeColor: Colors.transparent,
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Text('TACLabelAgree'.tr,
                  //             style: TextStyle(
                  //                 color: Color(ListColor.color5),
                  //                 fontWeight: FontWeight.bold)),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Obx(
                    () => Container(
                      margin: EdgeInsets.only(top: 10),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            side: BorderSide(color: Colors.white, width: 2)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        onPressed: controller.isSuccess.value
                            ? () {
                                controller.onAccept(context);
                              }
                            : null,
                        child: CustomText('TACButtonNext'.tr,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
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
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12),
    //           border: Border.all(width: 1, color: Colors.grey),
    //         ),
    //         child: Html(
    //           data: termsAndConditionsPointModel.data,
    //           onLinkTap: (url) {
    //             print("Opening $url...");
    //             controller.urlLauncher(url);
    //           },
    //         )),
    //     Row(
    //       children: [
    //         Checkbox(
    //           value: termsAndConditionsPointModel.isChecked,
    //           onChanged: controller.isSuccess.value
    //               ? (value) {
    //                   controller.setCheckbox(value, index);
    //                 }
    //               : null,
    //           checkColor: Color(ListColor.colorBlue),
    //           activeColor: Colors.transparent,
    //         ),
    //         Expanded(
    //           child: Text('TACLabelAgree'.tr,
    //               style: TextStyle(
    //                   color: Colors.black, fontWeight: FontWeight.bold)),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
