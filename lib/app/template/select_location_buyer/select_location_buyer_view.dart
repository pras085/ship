import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'select_location_buyer_controller.dart';

class SelectLocationBuyerView extends StatefulWidget {
  @override
  _SelectLocationBuyerViewState createState() => _SelectLocationBuyerViewState();
}

class _SelectLocationBuyerViewState extends State<SelectLocationBuyerView> {

  var searchController = TextEditingController();
  final controller = Get.put(SelectLocationBuyerController());

  @override
  void initState() {
    super.initState();
    controller.fetchHistoryLocation();
  }

  @override
  void dispose() {
    controller.dispose();
    Get.delete<SelectLocationBuyerController>();
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
                Size.fromHeight(GlobalVariable.ratioWidth(context) * 56),
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
              ),
              child: Center(
                child: Row(
                  children: [
                    CustomBackButton(
                      context: context,
                      iconColor: Colors.white,
                      backgroundColor: Color(ListColor.colorBlue),
                      onTap: Get.back,
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    Expanded(
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
                        child: Obx(
                          () => Row(
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
                                child: CustomTextField(
                                  autofocus: true,
                                  onChanged: (value) {
                                    controller.searchvalue.value = value;
                                    if (controller.searchvalue.value.length >= 3) {
                                      controller.fetchLocation();
                                    }
                                  },
                                  controller: searchController,
                                  textInputAction: TextInputAction.search,
                                  textSize: 14,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                    height: 1.2,
                                  ),
                                  context: context,
                                  newInputDecoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText: "Cari Lokasi",
                                    hintStyle: TextStyle(
                                      color: Color(ListColor.colorLightGrey4),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              if (controller.searchvalue.value.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    searchController.clear();
                                    controller.searchvalue.value = "";
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          10,
                                    ),
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Obx(
            () => controller.searchvalue.value == ""
                ? SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(context) * 20,
                      horizontal: GlobalVariable.ratioWidth(context) * 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              // try {
                                final location = Location();
                                bool serviceEnabled = await location.serviceEnabled();
                                if (!serviceEnabled) {
                                  serviceEnabled = await location.requestService();
                                  if (!serviceEnabled) {
                                    throw("you have to enable your GPS!");
                                  }
                                }

                                PermissionStatus permissionGranted = await location.hasPermission();
                                if (permissionGranted != PermissionStatus.granted) {
                                  permissionGranted = await location.requestPermission();
                                  if (permissionGranted != PermissionStatus.granted) {
                                    throw("you have refused to give the app location permission!");
                                  }
                                }

                                final locationData = await location.getLocation();
                                final response = await ApiBuyer(
                                  context: context,
                                  isShowDialogLoading: true,
                                  isShowDialogError: true,
                                ).getInformationLocationByLatLong({
                                  'Lat': locationData.latitude.toString(),
                                  'Long': locationData.longitude.toString(),
                                });

                                // parse to object
                                final object = SelectLocationBuyerModel(
                                  city: response['Data']['city'],
                                  cityID: response['Data']['cityid'],
                                  description: response['Data']['description'],
                                  districtID: response['Data']['districtid'],
                                  provinceID: response['Data']['provinceid'],
                                  province: response['Data']['province'],
                                  kind: 0, // hardoce cz, from api null.
                                );

                                await _saveToLocal(object);

                                Get.back(
                                  result: object,
                                );
                              // } catch (error) {
                              //   if (kDebugMode) print("ERROR :: $error");
                              //   CustomToastTop.show(
                              //     context: context, 
                              //     isSuccess: 0,
                              //     message: "$error",
                              //   );
                              // }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/target_location_icon.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          19,
                                ),
                                SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10,
                                ),
                                Expanded(
                                  child: CustomText(
                                    "Gunakan lokasi saat ini",
                                    fontSize: 14,
                                    color: Color(ListColor.color4),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _lineSaparator(),
                        Obx(() {
                          if (controller.historyResponse.value.state == ResponseStates.COMPLETE) {
                            final dataList = controller.historyResponse.value.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: GlobalVariable.ratioWidth(context) * 8,
                                ),
                                CustomText(
                                  "Pencarian Terakhir",
                                  fontSize: 16,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w600,
                                ),
                                _lineSaparator(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: dataList.length,
                                  itemBuilder: (c, i) {
                                    return InkWell(
                                      onTap: () {
                                        Get.back(
                                          result: dataList[i],
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                GlobalVariable.urlImageTemplateBuyer + 'pin_buyer.png',
                                                width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                height: GlobalVariable.ratioWidth(Get.context) * 24,
                                              ),
                                              SizedBox(
                                                width: GlobalVariable.ratioWidth(Get.context) * 8,
                                              ),
                                              Expanded(
                                                child: CustomText(
                                                  dataList[i].description,
                                                  fontSize: 14,
                                                  color: Color(0xFF676767),
                                                  fontWeight: FontWeight.w600,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          _lineSaparator(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                          return SizedBox.shrink();
                        }),
                      ],
                    ),
                  )
                : Obx(
                    () {
                      if (controller.dataModelResponse.value.state ==
                          ResponseStates.COMPLETE) {
                        final dataList = controller
                            .dataModelResponse.value.data;
                        if (dataList.isEmpty)
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: GlobalVariable.ratioWidth(context) * 8,
                              horizontal: GlobalVariable.ratioWidth(context) * 16,
                            ),
                            child: InkWell(
                              onTap: () async {
                                Get.back(
                                  result: 0,
                                );
                              },
                              child: Container(
                                height: GlobalVariable.ratioWidth(context) * 42,
                                width: GlobalVariable.ratioWidth(context) * 328,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: GlobalVariable.ratioWidth(context) * 0.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      GlobalVariable.urlImageTemplateBuyer +
                                          'loop_kat.png',
                                      height: GlobalVariable.ratioWidth(context) * 18,
                                      width: GlobalVariable.ratioWidth(context) * 18,
                                    ),
                                    SizedBox(
                                      width: GlobalVariable.ratioWidth(context) * 10,
                                    ),
                                    Expanded(
                                      child: Obx(() => SubstringHighlight(
                                        text: "Indonesia",
                                        term: controller.searchvalue.value,
                                        textStyle: TextStyle(
                                          fontFamily: 'AvenirNext',
                                          fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textStyleHighlight: TextStyle(
                                          fontFamily: 'AvenirNext',
                                          fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          // return Center(
                          //   child: Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       SvgPicture.asset("assets/empty_result_buyer.svg",
                          //         width: GlobalVariable.ratioWidth(context) * 120,
                          //         height: GlobalVariable.ratioWidth(context) * 120,
                          //       ),
                          //       SizedBox(
                          //         height: GlobalVariable.ratioWidth(context) * 16,
                          //       ),
                          //       CustomText("Hasil Tidak Ditemukan",
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w600,
                          //         textAlign: TextAlign.center,
                          //         height: 16.8/14,
                          //         withoutExtraPadding: true,
                          //       ),
                          //     ],
                          //   ),
                          // );
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                            vertical: GlobalVariable.ratioWidth(context) * 8,
                            horizontal: GlobalVariable.ratioWidth(context) * 16,
                          ),
                          itemCount: dataList.length,
                          itemBuilder: (c, i) {
                            return Column(
                              children: [
                                if (i == 0)
                                  InkWell(
                                    onTap: () async {
                                      Get.back(
                                        result: 0,
                                      );
                                    },
                                    child: Container(
                                      height: GlobalVariable.ratioWidth(context) * 42,
                                      width: GlobalVariable.ratioWidth(context) * 328,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: GlobalVariable.ratioWidth(context) * 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            GlobalVariable.urlImageTemplateBuyer +
                                                'loop_kat.png',
                                            height: GlobalVariable.ratioWidth(context) * 18,
                                            width: GlobalVariable.ratioWidth(context) * 18,
                                          ),
                                          SizedBox(
                                            width: GlobalVariable.ratioWidth(context) * 10,
                                          ),
                                          Expanded(
                                            child: Obx(() => SubstringHighlight(
                                              text: "Indonesia",
                                              term: controller.searchvalue.value,
                                              textStyle: TextStyle(
                                                fontFamily: 'AvenirNext',
                                                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textStyleHighlight: TextStyle(
                                                fontFamily: 'AvenirNext',
                                                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                InkWell(
                                  onTap: () async {
                                    await _saveToLocal(dataList[i]);
                                    Get.back(
                                      result: dataList[i],
                                    );
                                  },
                                  child: Container(
                                    height: GlobalVariable.ratioWidth(context) * 42,
                                    width: GlobalVariable.ratioWidth(context) * 328,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: GlobalVariable.ratioWidth(context) * 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          GlobalVariable.urlImageTemplateBuyer +
                                              'loop_kat.png',
                                          height: GlobalVariable.ratioWidth(context) * 18,
                                          width: GlobalVariable.ratioWidth(context) * 18,
                                        ),
                                        SizedBox(
                                          width: GlobalVariable.ratioWidth(context) * 10,
                                        ),
                                        Expanded(
                                          child: Obx(() => SubstringHighlight(
                                            text: dataList[i].description,
                                            term: controller.searchvalue.value,
                                            textStyle: TextStyle(
                                              fontFamily: 'AvenirNext',
                                              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textStyleHighlight: TextStyle(
                                              fontFamily: 'AvenirNext',
                                              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }, 
                        );
                      } else if (controller.dataModelResponse.value.state ==
                          ResponseStates.ERROR) {
                        return ErrorDisplayComponent(
                          "${controller.dataModelResponse.value.exception}",
                          onRefresh: () => controller.fetchLocation(),
                        );
                      }
                      return LoadingComponent();
                    },
                  ),
          ),
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

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            backgroundColor: Colors.black54,
            children: <Widget>[
              Center(
                child: Column(children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText('GlobalLabelDialogLoading'.tr,
                    color: Colors.blueAccent,
                  )
                ]),
              )
            ],
          ),
        );
      });
  }

  Future _saveToLocal(SelectLocationBuyerModel model) async {
    _showLoadingDialog();
    final value = await SharedPreferencesHelper.getHistoryPilihLokasiBuyer();
    final resList = [];
    if (value != null && value != "") {
      final localData = jsonDecode("${value ?? ''}");
      if (localData is List) {
        final reverseLocalData = localData.reversed.toList();
        for (var i=0;i<(reverseLocalData.length > 2 ? 2 : reverseLocalData.length);i++) {
          resList.add(reverseLocalData[i]);
        }
      }
    }
    final list = [
      model.toJson(),
      ...resList,
    ];
    final stringJson = jsonEncode(list);
    await SharedPreferencesHelper.setHistoryPilihLokasiBuyer(stringJson);
    Get.back(
      result: model,
    ); // dismiss the loading dialog.
  }

}
