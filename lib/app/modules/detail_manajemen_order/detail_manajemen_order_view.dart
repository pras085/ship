import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/detail_manajemen_order/detail_manajemen_order_controller.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailManajemenOrderView extends GetView<DetailManajemenOrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Detail Order"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50,
                child: buildMap()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() => controller.loadList.value
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                          color: Colors.white),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator()),
                          ),
                          CustomText("Loading"),
                        ],
                      ))
                  : SlidingUpPanel(
                      backdropEnabled: true,
                      minHeight: 150,
                      maxHeight: MediaQuery.of(context).size.height - 100,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      collapsed: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.dehaze_rounded, color: Colors.grey),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              width: 19,
                                              height: 19,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: Colors.green),
                                            ),
                                            CustomText('Surabaya',
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 7),
                                            child: Dash(
                                              direction: Axis.vertical,
                                              length: 24,
                                              dashLength: 5,
                                              dashThickness: 5,
                                              dashColor: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              width: 19,
                                              height: 19,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: Colors.red),
                                            ),
                                            CustomText('Jakarta',
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 12),
                                    child: MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 25),
                                                content: detailOrder(),
                                              );
                                            });
                                      },
                                      color: Color(ListColor.color4),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: CustomText("Detail",
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      panel: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (content, index) {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    index == 0
                                        ? SizedBox.shrink()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 7),
                                              child: Dash(
                                                direction: Axis.vertical,
                                                length: 24,
                                                dashLength: 5,
                                                dashThickness: 5,
                                                dashColor: Colors.grey,
                                              ),
                                            ),
                                          ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          width: 19,
                                          height: 19,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Color(ListColor.color4)),
                                        ),
                                        CustomText('Lokasi ${(10 - index)}',
                                            fontSize: 20, color: Colors.grey),
                                      ],
                                    )
                                  ]);
                            },
                          ),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMap() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        interactiveFlags: InteractiveFlag.none,
        zoom: 13.0,
      ),
      layers: [
        GlobalVariable.tileLayerOptions,
        MarkerLayerOptions(markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(51.5, -0.09),
            builder: (ctx) => Icon(
              Icons.arrow_drop_down,
              color: Colors.red,
            ),
          ),
        ])
      ],
    );
  }

  Widget detailOrder() {
    return Container(
      width: MediaQuery.of(Get.context).size.width,
      height: 300,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("No. Order: T-01",
                        fontWeight: FontWeight.bold, fontSize: 28),
                    CustomText("PT. Logistik Jaya Abadi",
                        fontWeight: FontWeight.bold, fontSize: 14),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: CustomText("Lokasi Pick-up",
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, bottom: 10),
                        child: CustomText("Jakarta")),
                    CustomText("Lokasi Destinasi",
                        fontWeight: FontWeight.bold, fontSize: 13),
                    Container(
                        margin: EdgeInsets.only(left: 10, bottom: 10),
                        child: CustomText("Surabaya")),
                    CustomText("Waktu Pengiriman",
                        fontWeight: FontWeight.bold, fontSize: 13),
                    Container(
                        margin: EdgeInsets.only(left: 10, bottom: 10),
                        child: CustomText("11.45, 12/01/2021")),
                    CustomText("Status",
                        fontWeight: FontWeight.bold, fontSize: 13),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: CustomText("Menunggu Konfirmasi Partner",
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: MaterialButton(
              onPressed: () {
                Navigator.of(Get.context).pop();
              },
              color: Color(ListColor.color4),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: CustomText("OK", color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
