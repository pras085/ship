import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_view.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'search_page_buyer_controller.dart';

class SearchPageBuyer extends StatefulWidget {
  @override
  _SearchPageBuyerState createState() => _SearchPageBuyerState();
}

class _SearchPageBuyerState extends State<SearchPageBuyer> {

  var searchController = TextEditingController();
  final controller = Get.put(SearchPageBuyerController());

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    controller.search.value = args ?? "";
    controller.searchController.text = args ?? "";
    controller.locationResult.value = controller.locationController.location.value;
    controller.fetchHistoryLocation();
  }

  @override
  void dispose() {
    controller.dispose();
    Get.delete<SearchPageBuyerController>();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(context) * 96),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.15),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 15,
                    offset: Offset(
                      0,
                      GlobalVariable.ratioWidth(Get.context) * 4,
                    ),
                  ),
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 4,
                    ),
                    child: CustomBackButton(
                      context: context,
                      iconColor: Colors.white,
                      backgroundColor: Color(ListColor.colorBlue),
                      onTap: Get.back,
                    ),
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 8,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: GlobalVariable.ratioWidth(context) * 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFC6CBD4),
                            ),
                            borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(context) * 8,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 8,
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: GlobalVariable.ratioWidth(context) * 8,
                                ),
                                child: Image.asset(
                                  GlobalVariable.urlImageTemplateBuyer + 'loop_kat.png',
                                  height: GlobalVariable.ratioWidth(context) * 20,
                                  width: GlobalVariable.ratioWidth(context) * 20,
                                  color: Color(0xFF002D84),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 2),
                                  child: TextField(
                                    controller: controller.searchController,
                                    decoration: new InputDecoration.collapsed(
                                      hintText: 'Masukkan Pencarian',
                                      hintStyle: TextStyle(
                                        fontFamily: 'AvenirNext', 
                                        color: Color(ListColor.colorGreyTemplate6), 
                                        fontWeight: FontWeight.w600, 
                                        fontSize: GlobalVariable.ratioWidth(context) * 14,
                                      ),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(100),
                                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
                                    ],
                                    style: TextStyle(
                                      fontFamily: 'AvenirNext', 
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600, 
                                      fontSize: GlobalVariable.ratioWidth(context) * 14,
                                    ),
                                    onSubmitted: (String str) async {
                                      controller.search.value = str;
                                      // save search to local and get back to previous page
                                      if (str.trim().isNotEmpty) {
                                        controller.saveToLocal(str);
                                      }
                                      Get.back(
                                        result: [
                                          str,
                                          controller.locationResult.value,
                                        ],
                                      );
                                    },
                                    onChanged: (String str) async {
                                      controller.search.value = str;
                                    },
                                  ),
                                ),
                              ),
                              Obx(() => controller.search.value.isNotEmpty ? GestureDetector(
                                onTap: () {
                                  controller.searchController.clear();
                                  controller.search.value = "";
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    GlobalVariable.ratioWidth(context) * 6,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/ic_close_frame.svg',
                                    height: GlobalVariable.ratioWidth(context) * 20,
                                    width: GlobalVariable.ratioWidth(context) * 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ) : SizedBox.shrink()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        InkWell(
                          onTap: () async {
                            final res = await Get.to(SelectLocationBuyerView());
                            if (res != null && res is SelectLocationBuyerModel) {
                              controller.locationResult.value = res;
                            } else if (res != null && res is int) {
                              controller.locationResult.value = null;
                            }
                          },
                          child: Container(
                            height: GlobalVariable.ratioWidth(context) * 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xFFC6CBD4),
                              ),
                              borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(context) * 8,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 8,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                  ),
                                  child: Image.asset(
                                    GlobalVariable.urlImageTemplateBuyer +
                                        'pin_buyer.png',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                  ),
                                ),
                                Expanded(
                                  child: Obx(() => CustomText(
                                    controller.locationResult.value != null 
                                    ? controller.locationResult.value.description 
                                    : "Indonesia", 
                                    fontWeight: FontWeight.w500, 
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Obx(() {
            if (controller.historyResponse.value.state == ResponseStates.COMPLETE) {
              final dataList = controller.historyResponse.value.data;
              return dataList.isEmpty ? SizedBox.shrink() : SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            "Pencarian Terakhir", 
                            fontWeight: FontWeight.w600, 
                            fontSize: 14,
                            height: 16.8/14,
                            withoutExtraPadding: true,
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        InkWell(
                          onTap: () {
                            // clear all history
                            controller.deleteAll();
                          },
                          child: CustomText(
                            "Hapus Semua", 
                            fontWeight: FontWeight.w500, 
                            fontSize: 12,
                            height: 14.4/12,
                            color: Color(ListColor.colorBlue),
                            textAlign: TextAlign.end,
                            withoutExtraPadding: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(context) * 2,
                    ),
                    _lineSaparator(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      separatorBuilder: (_, __) {
                        return _lineSaparator();
                      },
                      itemBuilder: (c, i) {
                        return InkWell(
                          onTap: () {
                            Get.back(
                              result: [
                                dataList[i]['name'],
                                controller.locationResult.value,
                              ],
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/ic_time_notif.svg',
                                width: GlobalVariable.ratioWidth(Get.context) * 18,
                                height: GlobalVariable.ratioWidth(Get.context) * 18,
                              ),
                              SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) * 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: GlobalVariable.ratioWidth(Get.context) * 252,
                                  child: CustomText(
                                    dataList[i]['name'],
                                    fontSize: 14,
                                    height: 16.8/14,
                                    withoutExtraPadding: true,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.deleteByID(dataList[i]['id']);
                                },
                                child: SvgPicture.asset('assets/ic_close_frame.svg',
                                  color: Color(0xFFF71717),
                                  width: GlobalVariable.ratioWidth(Get.context) * 14,
                                  height: GlobalVariable.ratioWidth(Get.context) * 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ),
      ),
    );
  }

  Widget _lineSaparator() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(Get.context) * 12,
      ),
      height: GlobalVariable.ratioWidth(Get.context) * 0.5,
      width: MediaQuery.of(Get.context).size.width,
      color: Color(ListColor.colorLightGrey10),
    );
  }

}