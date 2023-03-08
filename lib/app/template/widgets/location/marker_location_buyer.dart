import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/buyer/map/map_buyer_view.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../global_variable.dart';

class MarkerLocationBuyer extends StatefulWidget {

  final String title;
  final String address;
  final bool hideAddress;
  final double latitude;
  final double longitude;

  const MarkerLocationBuyer({
    Key key,
    @required this.title,
    this.address,
    this.hideAddress = false,
    @required this.latitude,
    @required this.longitude,
  }) : super(key: key);

  @override
  State<MarkerLocationBuyer> createState() => _MarkerLocationBuyerState();
}

class _MarkerLocationBuyerState extends State<MarkerLocationBuyer> {
  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.move(LatLng(
        widget.latitude, 
        widget.longitude,
      ), mapController.zoom ?? 0);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 24,
        horizontal: GlobalVariable.ratioWidth(context) * 16,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            widget.title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 19.2/16,
            withoutExtraPadding: true,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(context) * 16,
          ),
          if (!widget.hideAddress && widget.address != null)
            Container(
              margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(context) * 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on,
                    size: GlobalVariable.ratioWidth(context) * 18,
                    color: Color(0xFF176CF7),
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(context) * 4,
                  ),
                  Expanded(
                    child: CustomText(
                      widget.address,
                      fontSize: 14,
                      color: Color(0xFF676767),
                      fontWeight: FontWeight.w500,
                      height: 14/14,
                      withoutExtraPadding: true,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            width: GlobalVariable.ratioWidth(context) * 328,
            height: GlobalVariable.ratioWidth(context) * 168,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                GlobalVariable.ratioWidth(context) * 12,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: GlobalVariable.centerMap,
                    zoom: 13.0,
                    interactiveFlags: InteractiveFlag.none,
                    // allowPanning: false,
                    // enableMultiFingerGestureRace: false,

                  ),
                  mapController: mapController,
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: GlobalVariable.ratioWidth(context) * 22,
                          height: GlobalVariable.ratioWidth(context) * 27,
                          point: LatLng(
                            widget.latitude,
                            widget.longitude,
                          ),
                          builder: (ctx) =>
                          SvgPicture.asset(
                          "assets/new_marker_buyers.svg",
                          width: GlobalVariable.ratioWidth(context) * 22,
                          height: GlobalVariable.ratioWidth(context) * 27,
                          ), 
                          // Image.asset(
                          //   "assets/pin_new.png",
                          //   width:
                          //       GlobalVariable.ratioWidth(context) *
                          //           22,
                          //   height:
                          //       GlobalVariable.ratioWidth(context) *
                          //           27,
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: widget.hideAddress || widget.address == null ? null : () {
                    Get.to(
                      () => MapBuyerView(
                        lat: widget.latitude, 
                        lng: widget.longitude, 
                        address: widget.address ?? "-",
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: GlobalVariable.ratioWidth(context) * 328,
                    height: GlobalVariable.ratioWidth(context) * 168,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
 }
}