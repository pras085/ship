import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/find_truck/find_truck_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FindTruckView extends GetView<FindTruckController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50,
                child: buildMap(context)),
            Obx(
              () => controller.loadList.value
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(20),
                          child: CustomText(
                              "There's a truck number ${controller.closestTruck.value} at ${controller.closeDistance.value.toStringAsFixed(3)}km")),
                    ),
            ),
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
                      maxHeight: MediaQuery.of(context).size.height - 100,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      collapsed: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)),
                              color: Colors.white),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Center(
                              child: CustomText(
                            "^\nSwipe to see details",
                            textAlign: TextAlign.center,
                          ))),
                      panel: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                        child: ListView.builder(
                          itemCount: controller.listTruck.length,
                          itemBuilder: (content, index) {
                            var truck = controller.listTruck.value[index];
                            return Container(
                              child: CustomText(
                                  "Truck $index: ${truck.latitude}, ${truck.longitude}"),
                            );
                          },
                        ),
                      ))),
            ),
            Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("assets/map_marker_red_icon.png"),
                width: 40,
                height: 40,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMap(BuildContext context) {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 0.0,
        ),
        layers: [
          GlobalVariable.tileLayerOptions,
          MarkerLayerOptions(
            markers: [
              // for (int index = 0; index < controller.listTruck.length; index++)
              //   Marker(
              //     width: 80.0,
              //     height: 80.0,
              //     point: controller.listTruck.value[index],
              //     builder: (ctx) => Container(
              //       child: FlutterLogo(),
              //     ),
              //   ),
              (!controller.currentLocation.isNull)
                  ? Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.currentLocation.value,
                      builder: (ctx) => Container(
                        child: Icon(Icons.location_on),
                      ),
                    )
                  : null
            ],
          ),
          PolylineLayerOptions(polylines: [
            Polyline(
                points: controller.listRoute.value,
                strokeWidth: 4,
                color: Colors.purple)
          ])
        ],
      ),
    );
  }
}
