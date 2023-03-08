import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import '../../ubah_data_usaha_controller.dart';
import 'search_location_map_marker_data_usaha_controller.dart';

class CustomedAppBar extends PreferredSize {
  final String title;
  Widget bottom;
  Widget customBody;
  double heightAppBarOnly;
  final bool centerTitle;
  final int color;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    heightAppBarOnly = heightAppBarOnly == null ? preferredSize.height : heightAppBarOnly;

    return SafeArea(
        child: Container(
      height: preferredSize.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: heightAppBarOnly,
              color: Color(color ?? ListColor.color4),
              child: Stack(children: [
                Positioned(
                  top: 5,
                  right: 0,
                  child: Image(
                    image: AssetImage("assets/fallin_star_3_icon.png"),
                    height: heightAppBarOnly,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: customBody == null
                      ? (centerTitle ?? true)
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: _backButtonWidget()),
                                Align(alignment: Alignment.center, child: _titleProfileWidget())
                              ],
                            )
                          : Row(
                              children: [
                                SizedBox(width: 12),
                                _backButtonWidget(),
                                SizedBox(width: 12),
                                _titleProfileWidget(fontSize: 18, fontWeight: FontWeight.w600)
                              ],
                            )
                      : customBody,
                )
              ])),
          bottom != null ? bottom : SizedBox.shrink(),
        ],
      ),
    ));
  }

  Widget _titleProfileWidget({double fontSize = 18, FontWeight fontWeight = FontWeight.w700}) {
    return CustomText(
      title,
      color: Colors.white,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  Widget _backButtonWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: ClipOval(
          child: Material(
              shape: CircleBorder(),
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Get.back(result: 'back');
                  },
                  child: Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: GlobalVariable.ratioWidth(Get.context) * 12, // 30 * 0.7,
                        color: Color(ListColor.color4),
                      ))))),
        ),
      ),
    );
  }

  CustomedAppBar({this.preferredSize, this.title, this.bottom, this.heightAppBarOnly, this.customBody, this.centerTitle, this.color});
}

class SearchLocationMapMarkerDataUsahaView extends GetView<SearchLocationMapMarkerDataUsahaController> {
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
                      text ?? "",
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return WillPopScope(
      onWillPop: () {
        Get.back(result: 'back');
      },
      child: Obx(
        () => Container(
          color: Color(ListColor.colorBlue),
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CustomedAppBar(
                title: 'Atur Pin Lokasi',
                centerTitle: false,
                preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
              ),
              // PreferredSize(
              //   preferredSize:
              //       Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
              //   child: Container(
              //     height: GlobalVariable.ratioWidth(Get.context) * 56,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(boxShadow: <BoxShadow>[
              //       BoxShadow(
              //           color: Color(ListColor.colorLightGrey).withOpacity(0.5),
              //           blurRadius: 10,
              //           spreadRadius: 2,
              //           offset: Offset(0, 8)),
              //     ], color: Colors.white),
              //     child: Stack(alignment: Alignment.bottomCenter, children: [
              //       Column(mainAxisSize: MainAxisSize.max, children: [
              //         Expanded(
              //           child: Container(
              //             alignment: Alignment.center,
              //             padding: EdgeInsets.symmetric(
              //                 horizontal:
              //                     GlobalVariable.ratioWidth(Get.context) * 16),
              //             child: Row(
              //               mainAxisSize: MainAxisSize.max,
              //               children: [
              //                 Container(
              //                   child: ClipOval(
              //                     child: Material(
              //                         shape: CircleBorder(),
              //                         color: Color(ListColor.color4),
              //                         child: InkWell(
              //                             onTap: () {
              //                               Get.back(result: 'back');
              //                             },
              //                             child: Container(
              //                                 width: GlobalVariable.ratioWidth(
              //                                         Get.context) *
              //                                     24,
              //                                 height: GlobalVariable.ratioWidth(
              //                                         Get.context) *
              //                                     24,
              //                                 child: Center(
              //                                     child: Icon(
              //                                   Icons.arrow_back_ios_rounded,
              //                                   size: GlobalVariable.ratioWidth(
              //                                           Get.context) *
              //                                       12,
              //                                   color: Colors.white,
              //                                 ))))),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: GlobalVariable.ratioWidth(Get.context) * 12,
              //                 ),
              //                 SizedBox(
              //                   width: 10,
              //                 ),
              //                 Expanded(
              //                   child: Obx(
              //                     () => CustomText(
              //                         controller
              //                             .informationMarker.value.formattedAddress,
              //                         maxLines: 1,
              //                         overflow: TextOverflow.ellipsis,
              //                         fontSize: 11,
              //                         fontWeight: FontWeight.w600,
              //                         color: Colors.black),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 5,
              //                 ),
              //                 Obx(
              //                   () => Container(
              //                       width: 20,
              //                       height: 20,
              //                       child: controller.informationMarker.value
              //                                   .formattedAddress !=
              //                               ""
              //                           ? SizedBox.shrink()
              //                           : CircularProgressIndicator(
              //                               strokeWidth: 2.0,
              //                             )),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       ]),
              //     ]),
              //   ),
              // ),
              body: controller.wait.value
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: Container(
                        width: GlobalVariable.ratioWidth(context) * 70,
                        height: GlobalVariable.ratioWidth(context) * 70,
                        child: CircularProgressIndicator(),
                      )),
                    )
                  : Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height - 50, child: buildMap(context)),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMap(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: controller.mapController.value,
        options: MapOptions(
          interactiveFlags: InteractiveFlag.pinchMove | InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          maxZoom: GlobalVariable.zoomMap,
          center: GlobalVariable.centerMap,
          onPositionChanged: (position, hasGesture) {
            controller.setPositionMarker(LatLng(position.center.latitude, position.center.longitude));
          },
        ),
        layers: [
          TileLayerOptions(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
        ],
      ),
      Stack(
        children: [
          Obx(
            () => !controller.showWarning.value
                ? SizedBox.shrink()
                : Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: MediaQuery.of(Get.context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorRed3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: CustomText("Mohon memasukkan pin lokasi dengan benar",
                                      fontSize: 12, fontWeight: FontWeight.w500, color: Color(ListColor.colorRed))),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                    onTap: () {
                                      controller.showWarning.value = false;
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 12,
                                    )))
                          ],
                        ))),
          ),
          Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * -29),
                child: controller.imageMarker,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Obx(
                () => Container(
                  height: GlobalVariable.ratioWidth(context) * 165.87,
                  width: GlobalVariable.ratioWidth(context) * 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 26), topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 26)),
                    color: Color(ListColor.colorWhite),
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 26),
                    //   topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 26),
                    // )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 8,
                      ),
                      Container(
                        width: GlobalVariable.ratioWidth(context) * 38,
                        height: GlobalVariable.ratioWidth(context) * 2.74,
                        decoration: BoxDecoration(
                            color: Color(ListColor.colorLightGrey16), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4)),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 13.26,
                      ),
                      CustomText(
                        'Lokasi',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.colorBlue),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 16,
                      ),
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 24,
                        width: GlobalVariable.ratioWidth(context) * 328,
                        decoration: BoxDecoration(
                            // color: Colors.red
                            ),
                        child: Row(children: [
                          Image.asset('assets/pin_kuning.png', height: GlobalVariable.ratioWidth(context) * 24, width: GlobalVariable.ratioWidth(context) * 24),
                          // CustomText('Jalan Jalan Jalan Jalan Jalan Jalan Jalan Jalan Jalan Jalan', overflow: TextOverflow.ellipsis,)
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 9,
                          ),
                          Expanded(
                            child: controller.informationMarker.value.formattedAddress != ""
                                ? Obx(
                                    () => CustomText(
                                      controller.informationMarker.value.formattedAddress,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(ListColor.colorDarkGrey3),
                                    ),
                                  )
                                : CustomText(
                                    'Sedang Memuat Alamat...',
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(ListColor.colorDarkGrey3),
                                  ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 23.54,
                      ),
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 60.33,
                        width: GlobalVariable.ratioWidth(context) * 360,
                        decoration: BoxDecoration(
                            // color: Colors.red
                            ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: GlobalVariable.ratioWidth(context) * 16,
                            ),
                            //refo
                            _button(
                                color: Color(ListColor.colorBlue),
                                useBorder: true,
                                text: 'Batal',
                                borderRadius: 18,
                                borderColor: Color(ListColor.colorBlue),
                                width: 160,
                                height: 39.02,
                                onTap: () {
                                  Get.back(result: 'back');
                                }),
                            SizedBox(
                              width: GlobalVariable.ratioWidth(context) * 8,
                            ),
                            _button(
                                onTap: () async {
                                  final UbahDataUsahaController ubahDataUsahaC = Get.find();
                                  log('refo');
                                  var result = await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false)
                                      .fetchInformationLatlong(controller.currentLang.value.toString(), controller.currentLong.value.toString());
                                  if (result != null) {
                                    controller.districtid.value = result["Data"]["districtid"].toString();
                                    ubahDataUsahaC.distid.value = result["Data"]["districtid"].toString();
                                    //  print(controller.districtid.value + ' ikura');
                                    controller.onApplyButton();
                                  }
                                },
                                color: Color(ListColor.colorWhite),
                                useBorder: true,
                                text: 'Simpan',
                                borderRadius: 18,
                                backgroundColor: Color(ListColor.colorBlue),
                                borderColor: Color(ListColor.colorBlue),
                                width: 160,
                                height: 39.02)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ]);
  }
}

class _AppBar extends PreferredSize {
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<LokasiBFTMController>();
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
                            Get.back(result: 'back');
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
                          margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 8),
                          child: CustomText(
                            "Atur Pin Lokasi",
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
