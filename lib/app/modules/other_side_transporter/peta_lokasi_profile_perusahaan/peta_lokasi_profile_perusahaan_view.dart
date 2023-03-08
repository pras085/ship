import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class PetaLokasiProfilePerusahaanViews extends StatefulWidget {
  @override
  _PetaLokasiProfilePerusahaanViewState createState() => _PetaLokasiProfilePerusahaanViewState();
}

class _PetaLokasiProfilePerusahaanViewState extends State<PetaLokasiProfilePerusahaanViews> {

  OtherSideTransController controller = Get.find();
  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.move(LatLng(
        double.parse(controller.dataPerusahaan.data.companyLatitude ?? "0"), 
        double.parse(controller.dataPerusahaan.data.companyLongitude ?? "0"),
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
        // isYellowMode: true,
        isCenter: false,
        isWithBackgroundImage: true,
        title: "Lihat Lokasi",
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
                        double.parse(controller.dataPerusahaan.data.companyLatitude ?? "0"), 
                        double.parse(controller.dataPerusahaan.data.companyLongitude ?? "0"),
                      ),
                      builder: (ctx) => Image.asset(
                        "assets/pin_new.png",
                        width:
                            GlobalVariable.ratioWidth(context) *
                                22,
                        height:
                            GlobalVariable.ratioWidth(context) *
                                27,
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
                          Image.asset('assets/pin_kuning.png', 
                            height: GlobalVariable.ratioWidth(context) * 24, 
                            width: GlobalVariable.ratioWidth(context) * 24,
                          ),
                          SizedBox(width: GlobalVariable.ratioWidth(context) * 9,),
                          Expanded(
                            child: CustomText(
                              '${controller.dataPerusahaan.data.companyAddress}',
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