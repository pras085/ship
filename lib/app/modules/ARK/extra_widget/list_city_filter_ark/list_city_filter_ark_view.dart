import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

import 'list_city_filter_ark_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';

class ListCityFilterArkView extends GetView<ListCityFilterArkController> {
  ScrollController _scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //search bar
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          child: Container(
            height: GlobalVariable.ratioWidth(Get.context) * 56,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 8),
              ),
            ], color: Colors.white),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 12,
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 11.5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      "ic_back_blue_button.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24))),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 16,
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Obx(() => CustomTextField(
                                context: Get.context,
                                // autofocus: !controller.isLoadingData.value,
                                controller: controller
                                    .searchTextEditingController.value,
                                textInputAction: TextInputAction.search,
                                onChanged: (value) {
                                  controller.addTextSearchCity(value);
                                },
                                onEditingComplete: () {
                                  controller.onSubmitSearch();
                                },
                                textSize: 14,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                newInputDecoration: InputDecoration(
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText: controller.hintText.value,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    color: Color(ListColor.colorLightGrey2),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            32,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6,
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9,
                                    bottom:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.colorLightGrey7),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            1),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.colorLightGrey7),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            1),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.color4),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            1),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                  ),
                                ))),
                            Container(
                              margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      6,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          2),
                              child: SvgPicture.asset(
                                GlobalVariable.imagePath + "ic_search_blue.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Obx(() => controller
                                      .isShowClearSearch.value
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.onClearSearch();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  4),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "ic_close_blue.svg",
                                              color:
                                                  Color(ListColor.colorGrey3),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              height:
                                                  GlobalVariable.ratioWidth(Get.context) * 24)))
                                  : SizedBox.shrink()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Color(ListColor.colorBackgroundTender)),
            ),
            Obx(() => controller.listCity.length <= 0
                // ? Positioned(
                //     // child: Container(
                //     //   height: MediaQuery.of(Get.context).size.height * 50 / 100,
                //     //   alignment: Alignment.center,
                //     top: top,
                //     left: left,
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              GlobalVariable.imagePath +
                                  "ic_pencarian_tidak_ditemukan.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 82,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 93),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 15),
                          CustomText(
                              'ManajemenUserIndexKeywordTidakDitemukan'.tr +
                                  '\n' +
                                  'ManajemenUserIndexDiSistem'
                                      .tr, //Keyword tidak ditemukan disistem,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                              height: 1.2,
                              color: Color(ListColor.colorGrey3))
                        ],
                      ),
                    ),
                  )
                : Container()),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Badge choosen
                Obx(
                  () => controller.listChoosen.length > 0
                      ? Container(
                          constraints: BoxConstraints(
                            maxHeight:
                                GlobalVariable.ratioWidth(Get.context) * 329,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 16,
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                              ),
                              CustomText(
                                controller.choosenLabelText.value == ""
                                    ? "InfoPraTenderTransporterIndexLabelCity"
                                        .tr
                                    : controller.choosenLabelText.value,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(ListColor.colorGrey3),
                              ),
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                              Container(
                                  constraints: BoxConstraints(
                                    minHeight: 0,
                                    maxHeight:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            110,
                                  ),
                                  child: RawScrollbar(
                                    controller:
                                        controller.scrollControllerChoosen,
                                    isAlwaysShown: !controller.hidescroll.value,
                                    radius: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            1),
                                    thumbColor:
                                        Color(ListColor.colorLightGrey4),
                                    thickness:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            2,
                                    // child: ListView(
                                    //   shrinkWrap: true,
                                    //   children: [
                                    //     Wrap(
                                    //       children: [
                                    //         for (int index = 0;
                                    //             index <
                                    //                 controller
                                    //                     .listChoosen.length;
                                    //             index++)
                                    //           controller.badgeChoosen(index),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                    child: SingleChildScrollView(
                                        controller:
                                            controller.scrollControllerChoosen,
                                        child: Wrap(
                                          children: [
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .listChoosen.length;
                                                index++)
                                              controller.badgeChoosen(index),
                                          ],
                                        )),
                                  )),
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              Container(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 2,
                                width: GlobalVariable.ratioWidth(Get.context),
                                color: Color(ListColor.colorLightGrey10),
                              ),
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 6,
                        ),
                ),
                //checkbox
                Expanded(
                  child: Obx(() => Padding(
                      padding: EdgeInsets.only(
                          right: GlobalVariable.ratioWidth(Get.context) * 2),
                      child: controller.listCity.length <= 0
                          ? Container()
                          : RawScrollbar(
                              controller: controller.scrollControllerCheckbox,
                              isAlwaysShown: true,
                              thumbColor: Colors.transparent,
                              thickness: controller.listCity.length <= 0
                                  ? 0
                                  : GlobalVariable.ratioWidth(Get.context) * 5,
                              radius: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 3),
                              child: SingleChildScrollView(
                                  controller:
                                      controller.scrollControllerCheckbox,
                                  child: Column(children: [
                                    // for (int i = 0;
                                    //     i < controller.listChoosen.length;
                                    //     i++)
                                    //   (controller.listCity.containsKey(
                                    //           controller.listChoosen.keys.elementAt(i)))
                                    //       ? checkboxCity(controller.getListCityIndex(
                                    //           controller.listChoosen.keys.elementAt(i)))
                                    //       : Container(),
                                    for (int index = 0;
                                        index < controller.listCity.length;
                                        index++)
                                      checkboxCity(index),
                                    // (!controller.listChoosen.containsKey(controller
                                    //         .listCity.keys
                                    //         .elementAt(index)))
                                    //     ? checkboxCity(index)
                                    //     : Container(),
                                  ]))))),
                ),
                // Expanded(
                //   child: Obx(
                //     () => ListView.builder(
                //         itemCount: controller.listCity.length,
                //         itemBuilder: (context, index) {
                //           return checkboxCity(index);
                //         }),
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 56,
                //   padding: EdgeInsets.symmetric(vertical: 11, horizontal: 23),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                //           topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
                //       boxShadow: <BoxShadow>[
                //         BoxShadow(
                //           color:
                //               Color(ListColor.colorLightGrey).withOpacity(0.5),
                //           blurRadius: 10,
                //           spreadRadius: 4,
                //         ),
                //       ]),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: OutlinedButton(
                //           style: OutlinedButton.styleFrom(
                //               backgroundColor: Colors.white,
                //               side: BorderSide(
                //                   width: 1, color: Color(ListColor.color4)),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                //               )),
                //           onPressed: () {
                //             controller.resetAll();
                //           },
                //           child: Container(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 25, vertical: 10),
                //             child:
                //                 Stack(alignment: Alignment.center, children: [
                //               CustomText(
                //                 "GlobalButtonResetSearchCity".tr,
                //                 fontWeight: FontWeight.w600,
                //                 color: Color(ListColor.color4),
                //                 fontSize: 12,
                //               ),
                //             ]),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Expanded(
                //         child: OutlinedButton(
                //           style: OutlinedButton.styleFrom(
                //               backgroundColor: Color(ListColor.color4),
                //               side: BorderSide(
                //                   width: 1, color: Color(ListColor.color4)),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                //               )),
                //           onPressed: () {
                //             controller.onSubmit();
                //           },
                //           child: Container(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 25, vertical: 10),
                //             child:
                //                 Stack(alignment: Alignment.center, children: [
                //               CustomText(
                //                 "GlobalButtonSaveSearchCity".tr,
                //                 fontWeight: FontWeight.w600,
                //                 color: Colors.white,
                //                 fontSize: 12,
                //               ),
                //             ]),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 23,
                      GlobalVariable.ratioWidth(Get.context) * 10,
                      GlobalVariable.ratioWidth(Get.context) * 23,
                      GlobalVariable.ratioWidth(Get.context) * 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          topRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color:
                              Color(ListColor.colorLightGrey).withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 4,
                        ),
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  width: 2, color: Color(ListColor.color4)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                              )),
                          onPressed: () {
                            controller.resetAll();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child:
                                Stack(alignment: Alignment.center, children: [
                              CustomText("GlobalButtonResetSearchCity".tr,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.color4)),
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(ListColor.color4),
                              side: BorderSide(
                                  width: 2, color: Color(ListColor.color4)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                              )),
                          onPressed: () {
                            controller.onSubmit();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child:
                                Stack(alignment: Alignment.center, children: [
                              CustomText("GlobalButtonSaveSearchCity".tr,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget checkboxCity(int index) {
    double panjangSpasi =
        controller.getInitial(controller.listCity.keys.elementAt(index)) != ""
            ? 0
            : GlobalVariable.ratioWidth(Get.context) * 28;
    // double panjangGaris = MediaQuery.of(Get.context).size.width -
    //     (GlobalVariable.ratioWidth(Get.context) * 42) -
    //     panjangSpasi;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.onCheckCity(
                  index,
                  !controller.listChoosen
                      .containsKey(controller.listCity.keys.elementAt(index)));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 20,
                  controller.listChoosen.length > 0 && index == 0
                      ? 0
                      : GlobalVariable.ratioWidth(Get.context) * 8,
                  GlobalVariable.ratioWidth(Get.context) * 10,
                  GlobalVariable.ratioWidth(Get.context) * 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 28,
                    child: CustomText(
                        controller.getInitial(
                            controller.listCity.keys.elementAt(index)),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                  Expanded(
                    child: Stack(alignment: Alignment.centerLeft, children: [
                      CustomText(controller.listCity.values.elementAt(index),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 14),
                      CustomText("\n",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 14)
                    ]),
                  ),
                  SizedBox(width: 5),
                  CheckBoxCustom(
                    isWithShadow: true,
                    value: controller.listChoosen
                        .containsKey(controller.listCity.keys.elementAt(index)),
                    onChanged: (value) {
                      controller.onCheckCity(index, value);
                    },
                    borderColor: ListColor.colorBlue,
                    borderWidth: 1,
                    size: GlobalVariable.ratioWidth(Get.context) * 12,
                    shadowSize: GlobalVariable.ratioWidth(Get.context) * 20,
                    // checkColor: Colors.white,
                    // activeColor: Color(ListColor.color4),
                  )
                ],
              ),
            ),
          ),
        ),
        // Row(children: [
        //   Container(
        //     width: panjangSpasi,
        //   ),
        //   Container(
        //     margin: EdgeInsets.symmetric(
        //         horizontal: GlobalVariable.ratioWidth(Get.context) * 20),
        //     width: panjangGaris,
        //     // width: double.infinity,
        //     height: 0.5,
        //     color: Color(ListColor.colorLightGrey10),
        //   )
        // ]),
        Container(
          margin: EdgeInsets.only(
            right: GlobalVariable.ratioWidth(Get.context) * 20,
            left: GlobalVariable.ratioWidth(Get.context) * 20 + panjangSpasi,
          ),
          width: MediaQuery.of(Get.context).size.width,
          height: 0.5,
          color: Color(ListColor.colorLightGrey10),
        )
      ],
    );
  }
}
