import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';
import 'package:muatmuat/global_variable.dart';

class MarkerTruck extends Marker {
  final BaseLTSMMarkerModel baseLTSMMarkerModel;
  MarkerTruck({@required this.baseLTSMMarkerModel})
      : super(
            anchorPos: AnchorPos.align(AnchorAlign.top),
            height: baseLTSMMarkerModel.heightMarker,
            width: baseLTSMMarkerModel.widthMarker,
            point: LatLng(baseLTSMMarkerModel.lat, baseLTSMMarkerModel.lng),
            builder: (ctx) => GestureDetector(
                  onTap: baseLTSMMarkerModel.isChoosen
                      ? () {
                          baseLTSMMarkerModel.onTapWhenChoose();
                        }
                      : null,
                  child: Container(
                      color: Colors.transparent,
                      child: Image(
                          image: AssetImage(baseLTSMMarkerModel.isChoosen
                              ? "assets/marker_area_pickup_active.png"
                              : "assets/marker_area_pickup_nonactive.png"))
                      // child: SvgPicture.asset(
                      //   baseLTSMMarkerModel.isChoosen
                      //       ? "assets/truck_marker_selected.svg"
                      //       : "assets/truck_marker_unselected.svg",
                      //   width: 100,
                      //   height: 100,
                      // ),
                      // Image(
                      //   image: AssetImage("assets/" +
                      //       (baseMarkerModel.isChoosen
                      //           ? "marker_from_icon.png"
                      //           : "marker_dest_icon.png")),
                      //   width: 25,
                      //   height: 25,
                      // ),
                      ),
                ));

  factory MarkerTruck.copy(MarkerTruck markerTruck) {
    return MarkerTruck(
        baseLTSMMarkerModel:
            BaseLTSMMarkerModel.copy(markerTruck.baseLTSMMarkerModel));
  }
}

class BaseLTSMMarkerModel {
  double widthMarker;
  double heightMarker;

  String id;
  String kode;
  String destinasi;
  String truck;
  String address;
  String lastUpdate;
  String lastUpdateWaktu;
  DateTime lastUpdateRaw;
  String jumlahTruk;
  String siapMuat;
  String sudahDipesan;
  String posisiTruk;
  String truckPosition;
  String cityTransporter;
  String transporterEmail;
  String transporterName;
  String transporterID;
  bool isGold;
  double lat;
  double lng;
  bool isChoosen;
  void Function() onTapWhenChoose;
  ContactTransporterByShipperModel contact;

  BaseLTSMMarkerModel(
      {this.widthMarker = 48,
      this.heightMarker = 48,
      @required this.id,
      @required this.kode,
      @required this.destinasi,
      @required this.truck,
      @required this.address,
      @required this.lastUpdate,
      @required this.lastUpdateWaktu,
      @required this.lastUpdateRaw,
      @required this.jumlahTruk,
      @required this.siapMuat,
      @required this.sudahDipesan,
      @required this.posisiTruk,
      @required this.truckPosition,
      @required this.cityTransporter,
      @required this.transporterEmail,
      @required this.transporterName,
      @required this.transporterID,
      @required this.isGold,
      @required this.lat,
      @required this.lng,
      this.isChoosen = false,
      @required this.onTapWhenChoose,
      this.contact});

  factory BaseLTSMMarkerModel.copy(BaseLTSMMarkerModel bmm) {
    return BaseLTSMMarkerModel(
        widthMarker: bmm.widthMarker,
        heightMarker: bmm.heightMarker,
        id: bmm.id,
        kode: bmm.kode,
        destinasi: bmm.destinasi,
        truck: bmm.truck,
        address: bmm.address,
        lastUpdate: bmm.lastUpdate,
        lastUpdateWaktu: bmm.lastUpdateWaktu,
        lastUpdateRaw: bmm.lastUpdateRaw,
        jumlahTruk: bmm.jumlahTruk,
        siapMuat: bmm.siapMuat,
        sudahDipesan: bmm.sudahDipesan,
        posisiTruk: bmm.posisiTruk,
        truckPosition: bmm.truckPosition,
        cityTransporter: bmm.cityTransporter,
        transporterEmail: bmm.transporterEmail,
        transporterName: bmm.transporterName,
        transporterID: bmm.transporterID,
        isGold: bmm.isGold,
        lat: bmm.lat,
        lng: bmm.lng,
        isChoosen: bmm.isChoosen,
        onTapWhenChoose: bmm.onTapWhenChoose,
        contact: bmm.contact);
  }

  factory BaseLTSMMarkerModel.fromJson(BuildContext context,
      Map<String, dynamic> json, void Function() onTapWhenChoose) {
    var getLastUpdate = json["LastUpdate"].toString().split(" ");
    // print(json["ID"].toString() +
    //         "  " +
    //         json["Kode"] +
    //         "  " +
    //         json["Destinasi"] +
    //         "  " +
    //         json["Truck"] +
    //         "  " +
    //         json["Address"] +
    //         "  " +
    //         json["LastUpdate"] +
    //         "  " +
    //         "${getLastUpdate[3]} ${getLastUpdate[4]}" +
    //         "  " +
    //         json["JumlahTruk"] +
    //         "  " +
    //         json["SiapMuat"] +
    //         "  " +
    //         json["SudahDipesan"] +
    //         "  " +
    //         json["PosisiTruk"] +
    //         "  " +
    //         json["TruckPosition"] +
    //         "  " +
    //         json["CityTransporter"] +
    //         "  " +
    //         json["TransporterEmail"] ??
    //     "###" +
    //             "  " +
    //             json["TransporterName"] +
    //             "  " +
    //             json["TransporterID"].toString() +
    //             "  " +
    //             json["IsGold"].toString() ==
    //         "1" +
    //             "  " +
    //             json["Latitude"].toString() +
    //             "  " +
    //             json["Longitude"].toString() +
    //             "  ");
    String lastUpdateTanggal =
        "${getLastUpdate[0]} ${getLastUpdate[1]} ${getLastUpdate[2]} ${getLastUpdate[3]}";
    return BaseLTSMMarkerModel(
        widthMarker: GlobalVariable.ratioWidth(context) * 28,
        heightMarker: GlobalVariable.ratioWidth(context) * 34,
        id: json["ID"].toString(),
        kode: json["Kode"],
        destinasi: json["Destinasi"],
        truck: json["Truck"],
        address: (json["Address"].toString().contains(",")
            ? "Kec. "
            : "" ) + json["Address"],
        lastUpdate: json["LastUpdate"],
        lastUpdateWaktu: "${getLastUpdate[3]} ${getLastUpdate[4]}",
        // lastUpdateRaw: DateFormat("dd MMM yyyy HH:mm").parse(lastUpdateTanggal),
        lastUpdateRaw: DateFormat('yyyy-MM-dd HH:mm:ss')
            .parse(json["LastUpdateRaw"].toString()),
        jumlahTruk: json["JumlahTruk"],
        siapMuat: json["SiapMuat"],
        sudahDipesan: json["SudahDipesan"],
        posisiTruk: json["PosisiTruk"],
        truckPosition: json["TruckPosition"],
        cityTransporter: json["CityTransporter"],
        transporterEmail: json["TransporterEmail"] ?? "",
        transporterName: json["TransporterName"],
        transporterID: json["TransporterID"].toString(),
        isGold: json["IsGold"].toString() == "1",
        lat: double.parse(json["Latitude"].toString()),
        lng: double.parse(json["Longitude"].toString()),
        onTapWhenChoose: onTapWhenChoose);
  }
}
