import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../../global_variable.dart';

class MapBuyerView extends StatefulWidget {

  final double lat;
  final double lng;
  final String address;

  const MapBuyerView({
    @required this.lat,
    @required this.lng,
    @required this.address,
  });

  @override
  _MapBuyerViewState createState() => _MapBuyerViewState();
}

class _MapBuyerViewState extends State<MapBuyerView> {

  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.move(LatLng(
        widget.lat, 
        widget.lng,
      ), mapController.zoom ?? 0);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        isBlueMode: true,
        isCenter: false,
        isWithBackgroundImage: true,
        title: "Peta Lokasi",
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                center: GlobalVariable.centerMap,
                zoom: 13.0,
              ),
              mapController: mapController,
              layers: [
                GlobalVariable.tileLayerOptions,
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: GlobalVariable.ratioWidth(context) * 22,
                      height: GlobalVariable.ratioWidth(context) * 27,
                      point: LatLng(
                        widget.lat, 
                        widget.lng,
                      ),
                      builder: (ctx) => SvgPicture.asset(
                        "assets/new_marker_buyers.svg",
                        width: GlobalVariable.ratioWidth(context) * 22,
                        height: GlobalVariable.ratioWidth(context) * 27,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 12),
                  topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 12),
                ),
              ),
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: GlobalVariable.ratioWidth(context) * 116,
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(context) * 16,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                        color: Color(ListColor.colorLightGrey16),
                      ),
                      width: GlobalVariable.ratioWidth(context) * 38,
                      height: GlobalVariable.ratioWidth(context) * 2.74,
                      margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(context) * 8,
                        bottom: GlobalVariable.ratioWidth(context) * 13.26,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: GlobalVariable.ratioWidth(context) * 18,
                      ),
                      child: CustomText("Lokasi",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.colorBlue),
                      ),
                    ),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(context) * 16,
                    ),
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 24,
                      width: GlobalVariable.ratioWidth(context) * 328,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/new_marker_buyers.svg",
                            width: GlobalVariable.ratioWidth(context) * 24,
                            height: GlobalVariable.ratioWidth(context) * 24,
                          ),
                          SizedBox(width: GlobalVariable.ratioWidth(context) * 9,),
                          Expanded(
                            child: CustomText(
                              '${widget.address}',
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(ListColor.colorDarkGrey3),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}