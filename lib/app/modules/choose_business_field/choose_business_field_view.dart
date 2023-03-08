import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/choose_business_field/choose_business_field_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class ChooseBusinessFieldView extends GetView<ChooseBusinessFieldController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ListColor.colorBlue),
      child: SafeArea(
        child: Scaffold(
          appBar: _AppBar(
            preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 8,
                ),
                height: GlobalVariable.ratioWidth(context) * 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(context) * 1,
                    color: Color(ListColor.colorLightGrey10)
                  ),
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6
                  )
                ),
                padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * 16,
                  GlobalVariable.ratioWidth(context) * 8,
                  GlobalVariable.ratioWidth(context) * 12,
                  GlobalVariable.ratioWidth(context) * 8,
                ),
                child: Obx(() => Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(context) * 8,
                      ),
                      child: SvgPicture.asset(
                        "assets/ic_search.svg",
                        width: GlobalVariable.ratioWidth(context) * 24,
                        height: GlobalVariable.ratioWidth(context) * 24,
                        color: controller.text.value == ""
                          ? Color(ListColor.colorLightGrey2)
                          : Color(ListColor.colorBlack),
                      ),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        context: context,
                        autofocus: false,
                        onChanged: (value) {
                          controller.search(search: value);
                        },
                        controller: controller.searchController,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.2,
                        ),
                        textSize: 14,
                        newInputDecoration: InputDecoration(
                          hintText: "BFTMRegisterAllCariBidangUsaha".tr,
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
                            top: GlobalVariable.ratioWidth(context) * 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),                   
              ),
              Obx(() => Expanded(
                child: ListView.builder(
                  itemCount: controller.businessFieldsTemp.length,
                  itemBuilder: (context, index) {
                    int id = controller.businessFieldsTemp[index][controller.businessIdKey];
                    String code = controller.businessFieldsTemp[index][controller.businessCodeKey];
                    String description = controller.businessFieldsTemp[index][controller.businessDesc];

                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.onTap(
                          businessId: id,
                          businessCode: code,
                          businessDesc: description
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 12,
                          GlobalVariable.ratioWidth(context) * 16,
                          GlobalVariable.ratioWidth(context) * 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              description,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                              color: Color(ListColor.colorLightGrey4),
                            ),
                            SizedBox(height: 12),
                            if (index != controller.businessFieldsTemp.length - 1) ...[
                              Divider(
                                thickness: 1,
                                color: Color(ListColor.colorLightGrey2),
                                height: 0
                              ),
                            ]
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends PreferredSize {
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<FormPendaftaranIndividuController>();
    return SafeArea(
        child: Container(
            height: preferredSize.height,
            color: Color(ListColor.colorBlue),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image(
                    image: AssetImage("assets/fallin_star_3_icon.png"),
                    height: GlobalVariable.ratioWidth(Get.context) * 67,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  width: MediaQuery.of(Get.context).size.width,
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 16,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  ),
                  child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomBackButton(
                          backgroundColor: Colors.white,
                          iconColor: Color(ListColor.colorBlue),
                          context: Get.context,
                          onTap: () {
                            Get.back();
                          }),
                      // _CustomBackButton(
                      //     context: Get.context,
                      //     backgroundColor: Color(ListColor.color4),
                      //     iconColor: Color(ListColor.colorWhite),
                      //     onTap: () {
                      //       Get.back();
                      //     }),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 8),
                          child: CustomText(
                            "BFTMRegisterAllPilihBidangUsaha".tr,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  _AppBar({this.preferredSize});
}