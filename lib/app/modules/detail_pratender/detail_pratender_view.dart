import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/detail_pratender/detail_pratender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailPratenderView extends GetView<DetailPratenderController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(!controller.onDownloading.value);
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomText("Detail Pra Tender"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText("TD-012",
                                fontWeight: FontWeight.bold,
                                color: Color(ListColor.color4),
                                fontSize: 24),
                            Container(height: 10),
                            CustomText("PratenderDetailDateCreated".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: CustomText("10 Juni 2020")),
                            CustomText("PratenderDetailAnnouncementPeriod".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child:
                                    CustomText("10 Juni 2020 - 20 Juni 2020")),
                            CustomText("PratenderDetailPickupType".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: CustomText("One Destination")),
                            CustomText("PratenderDetailPickupLocation".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: CustomText("Surabaya")),
                            CustomText("PratenderDetailDestinationLocation".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: CustomText("Jakarta")),
                            CustomText("PratenderDetailTruckType".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: CustomText("Truk Tronton")),
                            CustomText("PratenderDetailCarrierType".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: CustomText("Box")),
                            CustomText("PratenderDetailTruckTotal".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: CustomText("30 unit")),
                            CustomText("PratenderDetailJobDate".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child:
                                    CustomText("30 Juni 2020 - 30 Juni 2021")),
                            CustomText("PratenderDetailDescription".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child:
                                    CustomText("Lorem Ipsum dolor sit amet")),
                            CustomText("PratenderDetailDocuments".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: CustomText(
                                              "Syarat dan ketentuan")),
                                      MaterialButton(
                                        color: Color(ListColor.color4),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        onPressed: () async {
                                          var status = await Permission.storage
                                              .request();
                                          if (status.isGranted) {
                                            controller.onDownloading.value =
                                                true;
                                            controller.onProgress.value = 0.0;
                                            controller.testDownload(
                                                // "https://media1.tenor.com/images/9cbd7be4f75bb816d1539e5df6f02019/tenor.gif");
                                                "https://assetlogistik.com/assets/pdf/coba.pdf");
                                          } else {
                                            print('Permission Denied!');
                                          }
                                        },
                                        child: CustomText("Download",
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            CustomText("PratenderDetailStatus".tr,
                                fontWeight: FontWeight.bold),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: CustomText("Aktif"))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(color: Colors.black12, height: 1),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            width: 35,
                            height: 35,
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(3),
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Icon(Icons.edit, color: Colors.grey),
                            )),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              Get.toNamed(Routes.PESERTA_PRATENDER);
                            },
                            color: Color(ListColor.color4),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: CustomText(
                                "PratenderDetailParticipantList".tr,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Obx(() => controller.onDownloading.value == false
                  ? SizedBox.shrink()
                  : Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                        child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText("Downloading"),
                                Container(height: 10),
                                LinearProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(ListColor.color4)),
                                    value: controller.onProgress.value)
                              ],
                            )),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
