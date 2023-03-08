import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/maps_function.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoMapFullScreenController extends GetxController {
  // var listTruck = List<LatLng>().obs;
  var loadList = true.obs;
  // var closestTruck = 0.obs;
  // var closeDistance = 0.0.obs;
  var currentLocation = LatLng(0, 0).obs;
  // var listRoute = List<LatLng>().obs;
  var location = Location();
  var mapController = MapController();

  var listDataMap = [].obs;
  var title = "".obs;

  List iconLocation = [
    'assets/pin1.svg',
    'assets/pin2_biru.svg',
    'assets/pin3_biru.svg',
    'assets/pin4_biru.svg',
    'assets/pin5_biru.svg'
  ];

  @override
  void onInit() {
    title.value = Get.arguments[1];
    listDataMap.clear();
    var listData = List.from(Get.arguments[0]);
    listData.forEach((element) {
      listDataMap.add(element);
      loadList.value = false;
    });

    // Future.delayed(Duration(seconds: 0)).then((_) {
    //   lokasiDetail();
    // });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  // lokasiDetail() {
  //   return showModalBottomSheet(
  //       isScrollControlled: true,
  //       isDismissible: false,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(10), topRight: Radius.circular(10))),
  //       backgroundColor: Colors.white,
  //       context: Get.context,
  //       builder: (context) {
  //         return SingleChildScrollView(
  //             child: Container(
  //           padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(Get.context).viewInsets.bottom),
  //           child: Obx(
  //             () => Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.only(
  //                     top: GlobalVariable.ratioWidth(Get.context) * 4,
  //                   ),
  //                   height: GlobalVariable.ratioWidth(Get.context) * 3,
  //                   width: GlobalVariable.ratioWidth(Get.context) * 38,
  //                   color: Color(ListColor.colorLightGrey16),
  //                 ),
  //                 Container(
  //                   padding: EdgeInsets.fromLTRB(
  //                     GlobalVariable.ratioWidth(context) * 16,
  //                     GlobalVariable.ratioWidth(context) * 16,
  //                     GlobalVariable.ratioWidth(context) * 16,
  //                     GlobalVariable.ratioWidth(context) * 13,
  //                   ),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Center(
  //                         child: CustomText(
  //                           title.value,
  //                           fontSize: GlobalVariable.ratioWidth(context) * 14,
  //                           fontWeight: FontWeight.w700,
  //                           color: Color(ListColor.colorBlue),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: GlobalVariable.ratioWidth(context) * 34,
  //                       ),
  //                       ListView.builder(
  //                         shrinkWrap: true,
  //                         itemCount: listDataMap.value.length,
  //                         itemBuilder: (content, index) {
  //                           return Container(
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               children: [
  //                                 Row(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   children: [
  //                                     Column(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.start,
  //                                       children: [
  //                                         if (listDataMap.value.length > 1)
  //                                           Container(
  //                                             child: SvgPicture.asset(
  //                                               iconLocation[index],
  //                                               width:
  //                                                   GlobalVariable.ratioWidth(
  //                                                           Get.context) *
  //                                                       24,
  //                                               height:
  //                                                   GlobalVariable.ratioWidth(
  //                                                           Get.context) *
  //                                                       24,
  //                                             ),
  //                                           )
  //                                         else
  //                                           Container(
  //                                             child: SvgPicture.asset(
  //                                               "assets/pin_kuning_satu_lokasi.svg",
  //                                               width:
  //                                                   GlobalVariable.ratioWidth(
  //                                                           Get.context) *
  //                                                       24,
  //                                               height:
  //                                                   GlobalVariable.ratioWidth(
  //                                                           Get.context) *
  //                                                       24,
  //                                             ),
  //                                           ),
  //                                         if (listDataMap.value.length - 1 !=
  //                                             index)
  //                                           Padding(
  //                                             padding: EdgeInsets.only(
  //                                                 left:
  //                                                     GlobalVariable.ratioWidth(
  //                                                             context) *
  //                                                         10),
  //                                             child: Container(
  //                                               child: SvgPicture.asset(
  //                                                 "assets/garis_alur_perjalanan.svg",
  //                                                 // width: GlobalVariable.ratioWidth(Get.context) * 12,
  //                                                 height:
  //                                                     GlobalVariable.ratioWidth(
  //                                                             Get.context) *
  //                                                         34,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                       ],
  //                                     ),
  //                                     SizedBox(
  //                                       width:
  //                                           GlobalVariable.ratioWidth(context) *
  //                                               15,
  //                                     ),
  //                                     Expanded(
  //                                       child: CustomText(
  //                                         listDataMap.value[index]["Address"],
  //                                         fontSize: GlobalVariable.ratioWidth(
  //                                                 context) *
  //                                             14,
  //                                         fontWeight: FontWeight.w600,
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                                 SizedBox(
  //                                   height:
  //                                       GlobalVariable.ratioWidth(context) * 12,
  //                                 )
  //                               ],
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ));
  //       });
  // }
}
