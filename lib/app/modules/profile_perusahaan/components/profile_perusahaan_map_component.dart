import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:latlong/latlong.dart';

import '../../../../global_variable.dart';

class ProfilePerusahaanMapComponent extends StatefulWidget {

  final ProfilePerusahaanModel model;

  const ProfilePerusahaanMapComponent({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _ProfilePerusahaanMapComponentState createState() => _ProfilePerusahaanMapComponentState();
}

class _ProfilePerusahaanMapComponentState extends State<ProfilePerusahaanMapComponent> {

  final mapController = MapController();
  ProfilePerusahaanController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.move(LatLng(
        double.parse(widget.model.data.companyLatitude ?? "0"), 
        double.parse(widget.model.data.companyLongitude ?? "0"),
      ), mapController.zoom ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: GlobalVariable.ratioWidth(context) * 152,
        child: Column(
          children: [
            Expanded(
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
                        width: GlobalVariable.ratioWidth(context) * 18.86,
                        height: GlobalVariable.ratioWidth(context) * 23.45,
                        point: LatLng(
                          double.parse(widget.model.data.companyLatitude ?? "0"), 
                          double.parse(widget.model.data.companyLongitude ?? "0"),
                        ),
                        builder: (ctx) => Image.asset(
                          "assets/pin_new.png",
                          width:
                              GlobalVariable.ratioWidth(context) *
                                  18.86,
                          height:
                              GlobalVariable.ratioWidth(context) *
                                  23.45,
                        ),
                      ),
                  ])
                ],
              ),
            ),
            Material(
              color: Color(ListColor.colorBlue),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.PROFILE_PERUSAHAAN_VIEW_LOCATION);
                },
                child: Container(
                  width: double.infinity,
                  height: GlobalVariable.ratioWidth(context) * 35,
                  child: Center(
                    child: CustomText("Lihat Lokasi",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}