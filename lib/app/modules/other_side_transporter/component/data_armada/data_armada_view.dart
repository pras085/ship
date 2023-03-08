import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/data_armada/data_armada_model.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';

import 'data_armada_controller.dart';

class DataArmadaView extends GetView<DataArmadaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        isBlueMode: true,
        isWithBackgroundImage: true,
        title: "Data Armada",
        onClickBack: () => Get.back(),
        isCenter: false,
        isWithShadow: false,
      ),
      body: Obx(() {
        if (controller.dataArmada.value.state == ResponseStates.COMPLETE) {
          final data = controller.dataArmada.value.data;
          return content(context, data);
        } else if (controller.dataArmada.value.state == ResponseStates.ERROR) {
          return ErrorDisplayComponent(
            "${controller.dataArmada.value.exception}",
            onRefresh: () => controller.fetchData(),
          );
        }
        return LoadingComponent();
      }),
    );
  }

  Widget content(BuildContext context, DataTruckModel snapData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: GlobalVariable.ratioWidth(context) * 82,
            width: GlobalVariable.ratioWidth(context) * 360,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: GlobalVariable.ratioWidth(context) * 9.17,
                          left: GlobalVariable.ratioWidth(context) * 16,
                          top: GlobalVariable.ratioWidth(context) * 20),
                      child: CustomText(
                        'Data Armada',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
                    CustomText(
                      'Jumlah truk',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(context) * 10),
                    CustomText(
                      snapData.data.truckListCount.toString() + ' unit',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ],
            ),
          ),
          for (var i = 0; i < snapData.data.truckList.length; i++)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 20,
                  width: double.infinity,
                  child: ColoredBox(color: Color(ListColor.colorLightGrey3)),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(context) * 14,
                    horizontal: GlobalVariable.ratioWidth(context) * 17,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: GlobalVariable.ratioWidth(context) * 54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
                              child: Material(
                                child: CachedNetworkImage(
                                  imageUrl: snapData.data.truckList[i].picturePath ?? '',
                                  height: GlobalVariable.ratioWidth(context) * 54,
                                  width: GlobalVariable.ratioWidth(context) * 90,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Image.asset('assets/template_buyer/truck_placeholder_template.png'),
                                ),
                              ),
                            ),
                            SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
                            Expanded(
                              child: Container(
                                height: GlobalVariable.ratioWidth(context) * 54,
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      snapData.data.truckList[i].headTxt,
                                      color: Color(ListColor.colorBlack1),
                                      fontWeight: FontWeight.w600,
                                      withoutExtraPadding: true,
                                    ),
                                    SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                                    CustomText(
                                      snapData.data.truckList[i].carrierTxt,
                                      color: Color(ListColor.colorLightGrey4),
                                      withoutExtraPadding: true,
                                    ),
                                    SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(context) * 102),
                        height: GlobalVariable.ratioWidth(context) * 92,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: GlobalVariable.ratioWidth(context) * 24,
                                  width: GlobalVariable.ratioWidth(context) * 24,
                                  color: Colors.white,
                                  child: Image.asset(
                                    'assets/trukicon.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                                CustomText(
                                  snapData.data.truckList[i].qty.toString() + ' unit',
                                  color: Color(ListColor.colorBlack1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  withoutExtraPadding: true,
                                )
                              ],
                            ),
                            SizedBox(height: GlobalVariable.ratioWidth(context) * 10),
                            Row(
                              children: [
                                Container(
                                  height: GlobalVariable.ratioWidth(context) * 24,
                                  width: GlobalVariable.ratioWidth(context) * 24,
                                  color: Colors.white,
                                  child: Image.asset(
                                    'assets/timbangan.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                                CustomText(
                                  snapData.data.truckList[i].capacityTxt.toString(),
                                  color: Color(ListColor.colorBlack1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  withoutExtraPadding: true,
                                )
                                // CustomText('21 - 24 Ton', color: Color(ListColor.colorBlack1), fontSize: 14, fontWeight: FontWeight.w600,)
                              ],
                            ),
                            SizedBox(height: GlobalVariable.ratioWidth(context) * 10),
                            Row(
                              children: [
                                Container(
                                  height: GlobalVariable.ratioWidth(context) * 24,
                                  width: GlobalVariable.ratioWidth(context) * 24,
                                  color: Colors.white,
                                  child: Image.asset(
                                    'assets/dimensi.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
                                CustomText(
                                  snapData.data.truckList[i].dimensionTxt.toString(),
                                  color: Color(ListColor.colorBlack1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  withoutExtraPadding: true,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
