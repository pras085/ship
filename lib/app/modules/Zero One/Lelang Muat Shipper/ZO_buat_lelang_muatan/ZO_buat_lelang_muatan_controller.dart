import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_truck_satuan/ZO_filter_truck_satuan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen_tambah/ZO_map_full_screen_tambah_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select/ZO_map_select_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_search_lokasi/ZO_search_lokasi_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:latlong/latlong.dart';

//
class ZoBuatLelangMuatanController extends GetxController {
  var slideIndex = 0.obs;
  var pageController = PageController();
  var title = "".obs;

//TextForm
  final periodeAwalController = TextEditingController().obs;
  final periodeAkhirController = TextEditingController().obs;
  final jumlahTruk = TextEditingController(text: "0").obs;
  final jenisTruk = TextEditingController().obs;
  final jenisCarrier = TextEditingController().obs;
  final muatan = TextEditingController().obs;
  final berat = TextEditingController().obs;
  final volume = TextEditingController().obs;
  final panjang = TextEditingController().obs;
  final lebar = TextEditingController().obs;
  final tinggi = TextEditingController().obs;
  final jumlahKoli = TextEditingController().obs;
  final alamatSatuan = TextEditingController().obs;
  final detailalamatSatuan = TextEditingController().obs;
  final provinsiSatuan = TextEditingController().obs;
  final namaPicSatuan = TextEditingController().obs;
  final noTelpPicSatuam = TextEditingController().obs;
  final alamatSatuanDestinasi = TextEditingController().obs;
  final detailalamatSatuanDestinasi = TextEditingController().obs;
  final provinsiSatuanDestinasi = TextEditingController().obs;
  final namaPicSatuanDestinasi = TextEditingController().obs;
  final noTelpPicSatuamDestinasi = TextEditingController().obs;
  final ekspektasiwaktupickup = TextEditingController().obs;
  final ekspektasiwaktupickupDestinasi = TextEditingController().obs;
  final hargaUnitTruk = TextEditingController().obs;
  final nilaiBarang = TextEditingController().obs;
  final tempatmuatlainlainform = TextEditingController().obs;
  final tempatbongkarlainlainform = TextEditingController().obs;
  final lainlainTerminPembayaranForm = TextEditingController().obs;
  final catatanTambahan = TextEditingController().obs;

  final MapController mapController = MapController();
  var currentLocation = LatLng(0, 0).obs;
  var listRoute = List<LatLng>().obs;
  var location = Location();

  var mapControllerDestinasi = MapController();
  var currentLocationDestinasi = LatLng(0, 0).obs;

  List listCurentLocation = [];
  List listCurentLocationDestinasi = [];
  var listjenismuatan = [].obs;

//radiobutton
  var radioButtonSatuMultipleLokasi =
      "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr.obs;
  var radioButtonTerbukaTertutup = "1".obs;
  var radioButtonSatuMultipleLokasiDestinasi =
      "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr.obs;
  var radioButtonMakHarga = "1".obs;
  var terminPembayaran =
      "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermCashLoad".tr.obs;

  //dropdown
  var dropdownJumlahLokasi = 2.obs;
  var dropdownJumlahLokasiDestinasi = 2.obs;
  var selectedjenismuatan = "".obs;
  // List<DropdownMenuItem> dropdownJenisMuatan = [];
  var selectedVolume = "m3".obs;
  var selectedDimensiKoli = "m".obs;
  var berjangkaDropdown = 1.obs;
  var bagianwaktuinformasiPickup = "WIB".obs;
  var bagianwaktuinformasiDestinasi = "WIB".obs;

  List pin = [
    'assets/pin1.svg',
    'assets/pin2_biru.svg',
    'assets/pin3_biru.svg',
    'assets/pin4_biru.svg',
    'assets/pin5_biru.svg'
  ];

  List currentLocationList = [];
  List currentLocationDestinasiList = [];
  var latLng = LatLng(0, 0).obs;
  var pointY = 200.0;

//checkbox
  // var checkBoxLainTempatBongkar = false.obs;
  var checkBoxTarifJasaTransport = false.obs;
  var checkBoxAsuransiBarang = false.obs;
  var checkBoxBiayaPengawalan = false.obs;
  var checkBoxBiayaJalan = false.obs;
  var tempatMuatForklift = false.obs;
  var tempatMuatCrane = false.obs;
  var tempatMuatJasaTenagaMuat = false.obs;
  var tempatMuatLainLain = false.obs;
  var tempatBongkarForklift = false.obs;
  var tempatBongkarCrane = false.obs;
  var tempatBongkarJasaTenagaMuat = false.obs;
  var tempatBongkarLainLain = false.obs;

  //list
  var listFilterJenisTruck = [].obs;
  var tempFilterJenisTruck = {}.obs;
  var listFilterJenisCarrier = [].obs;
  var tempFilterJenisCarrier = {}.obs;
  List<TextEditingController> alamatMulti = [];
  List<TextEditingController> detailalamatMulti = [];
  List<TextEditingController> provinsiMulti = [];
  List<TextEditingController> namaPicMulti = [];
  List<TextEditingController> noTelpPicMulti = [];
  List<TextEditingController> alamatMultiDestinasi = [];
  List<TextEditingController> detailalamatMultiDestinasi = [];
  List<TextEditingController> provinsiMultiDestinasi = [];
  List<TextEditingController> namaPicMultiDestinasi = [];
  List<TextEditingController> noTelpPicMultiDestinasi = [];
  List<TextEditingController> city = [];
  List<TextEditingController> lat = [];
  List<TextEditingController> lng = [];
  List<TextEditingController> provinceIdList = [];
  List<TextEditingController> cityDestinasi = [];
  List<TextEditingController> latDestinasi = [];
  List<TextEditingController> lngDestinasi = [];
  List<TextEditingController> provinceIdListDestinasi = [];

  var tempLokasiPickup = "".obs;

  //StringKosong
  var lingImg = "".obs;
  var beratMaxDimensiVolume = "- Ton/-x-x-/-m3".obs;
  var isKosongEkspektasiWaktuPickup = false.obs;
  var isKosongEkspektasiWaktuDestinasi = false.obs;
  var isKosongPeriodeAwal = false.obs;
  var isKosongPeriodeAkhir = false.obs;
  var isKosong = false.obs;
  var isKosongJenisMuatan = false.obs;
  var isKosongAlamatSatuan = false.obs;
  var isKosongAlamatMulti = [].obs;
  var isKosongAlamatSatuanDestinasi = false.obs;
  var isKosongAlamatMultiDestinasi = [].obs;
  var jumlahTrukCount = 0.obs;
  var isShowInfo = false.obs;
  var dateAwal = "".obs;
  var dateAkhir = "".obs;
  var truckId = "".obs;
  var headId = "".obs;
  var carrierId = "".obs;
  var provinceId = "".obs;
  var provinceIdDestinasi = "".obs;
  var ekspektasiwaktupickupValue = "".obs;
  var ekspektasiwaktupickupValueDestinasi = "".obs;

  //map
  var locationResultMap = {}.obs;
  var locationResultMapDestinasi = {}.obs;

  var checkBoxTarifJasaTransportVal = "".obs;
  var checkBoxAsuransiBarangVal = "".obs;
  var checkBoxBiayaPengawalanVal = "".obs;
  var checkBoxBiayaJalanVal = "".obs;
  var tempatMuatForkliftVal = "".obs;
  var tempatMuatCraneVal = "".obs;
  var tempatMuatJasaTenagaMuatVal = "".obs;
  var tempatMuatLainLainVal = "".obs;
  var tempatBongkarForkliftVal = "".obs;
  var tempatBongkarCraneVal = "".obs;
  var tempatBongkarJasaTenagaMuatVal = "".obs;
  var tempatBongkarLainLainVal = "".obs;

  var lainlaintermin = false.obs;

  ValueNotifier<DateTime> firstExpWaktu =
      ValueNotifier<DateTime>(DateTime(DateTime.now().year - 5));
  DateTime curdate = DateTime.now();
  DateTime inisialDateEndPicker = DateTime.now();
  DateTime inisialDestinasiWaktu = DateTime.now();
  DateTime firstdate;
  DateTime firstdatePick;
  DateTime firstdateDes;
  var isSelectStartDate = false.obs;

  var idBid = "".obs;
  var dataDetail = [].obs;

  // List<DropdownMenuItem> buildDropdownJenisMuatan(List _listJenisMuatan,
  //     {String resVal}) {
  //   List<DropdownMenuItem> items = [];
  //   for (var i in _listJenisMuatan) {
  //     print("PAPAPAPA $resVal ${i["Description"].toString()}");
  //     items.add(DropdownMenuItem(
  //       value: i["Description"].toString(),
  //       child: Text(
  //         i["Description"].toString(),
  //         style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
  //             color: i["Description"].toString() == resVal
  //                 ? Color(ListColor.colorBlue)
  //                 : Colors.black),
  //       ),
  //     ));
  //   }
  //   return items;
  // }

  @override
  void onInit() {
    idBid.value = Get.arguments[0];
    if (idBid.value != "") {
      getDetailDataLelangMuatan();
    } else {
      getCurrentLocation();
    }
    updateTitle();
    getCurrentDateApi();
    getListJenisTruck();
    getJenisMuatan();

    alamatMulti = [];
    listCurentLocation = [];
    listCurentLocationDestinasi = [];
    for (var i = 0; i < dropdownJumlahLokasi.value; i++) {
      alamatMulti.add(TextEditingController());
      detailalamatMulti.add(TextEditingController());
      provinsiMulti.add(TextEditingController());
      namaPicMulti.add(TextEditingController());
      noTelpPicMulti.add(TextEditingController());
      isKosongAlamatMulti.add(false);
      city.add(TextEditingController());
      lat.add(TextEditingController());
      lng.add(TextEditingController());
      provinceIdList.add(TextEditingController());
      currentLocationList.add(LatLng(0, 0));
      listCurentLocation.add(LatLng(0, 0));
    }
    alamatMultiDestinasi = [];
    for (var i = 0; i < dropdownJumlahLokasiDestinasi.value; i++) {
      alamatMultiDestinasi.add(TextEditingController());
      detailalamatMultiDestinasi.add(TextEditingController());
      provinsiMultiDestinasi.add(TextEditingController());
      namaPicMultiDestinasi.add(TextEditingController());
      noTelpPicMultiDestinasi.add(TextEditingController());
      isKosongAlamatMultiDestinasi.add(false);
      cityDestinasi.add(TextEditingController());
      latDestinasi.add(TextEditingController());
      lngDestinasi.add(TextEditingController());
      provinceIdListDestinasi.add(TextEditingController());
      currentLocationDestinasiList.add(LatLng(0, 0));
      listCurentLocationDestinasi.add(LatLng(0, 0));
    }
    // location.onLocationChanged.listen((LocationData current) {
    //   print("KFAFHGDHCA $current");
    //   if (current.accuracy < 50) {
    //     currentLocation.value = LatLng(current.latitude, current.longitude);
    //     mapController.move(currentLocation.value, 17.7);
    //   }
    // });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  String formatThousand(num number) {
    if (number == null) return null;
    var format = number is int ? '#,###' : '#,###.###';
    var formattedOriginal = NumberFormat(format).format(number);
    var formatted = formattedOriginal;

    formatted = formatted.replaceAll(',', '.');
    if (formattedOriginal.contains('.')) {
      formatted = formatted.replaceFirst('.', ',', formatted.lastIndexOf('.'));
    }

    debugPrint('debug-formatThousand: $formatted');

    return formatted;
  }

  getDetailDataLelangMuatan() async {
    try {
      var resLoginAs = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getUserShiper(GlobalVariable.role);

      if (resLoginAs["Message"]["Code"] == 200) {
        var res = await ApiHelper(
                context: Get.context,
                isShowDialogLoading: true,
                isShowDialogError: false)
            .getDetailBid(idBid.value, resLoginAs["LoginAs"].toString(),
                GlobalVariable.role);

        if (res["Message"]["Code"] == 200) {
          dataDetail.clear();
          (res["Data"]["BidItem"] as List).forEach((element) {
            radioButtonTerbukaTertutup.value = element["BidType"];
            headId.value = element["HeadId"].toString();
            jenisTruk.value.text = element["HeadName"];
            carrierId.value = element["CarrierId"].toString();
            jenisCarrier.value.text = element["CarrierName"];
            jumlahTrukCount.value = element["TruckQty"];
            jumlahTruk.value.text =
                formatThousand(num.tryParse('${element["TruckQty"]}')) ??
                    '${element["TruckQty"]}';
            muatan.value.text = element["Cargo"];
            selectedjenismuatan.value = element["IdCargoType"];
            berat.value.text =
                formatThousand(num.tryParse('${element["Weight"]}')) ??
                    '${element["Weight"]}';
            var expVol = element["Volume"].toString().split(" ");
            volume.value.text =
                formatThousand(num.tryParse('${expVol[0]}')) ?? '${expVol[0]}';
            selectedVolume.value = expVol[1];
            var expDimensi = element["Dimension"].toString().split(" ");
            var expDimensi2 = expDimensi[0].toString().split("*_*_*");
            panjang.value.text =
                formatThousand(num.tryParse('${expDimensi2[0]}')) ??
                    '${expDimensi2[0]}';
            lebar.value.text =
                formatThousand(num.tryParse('${expDimensi2[1]}')) ??
                    '${expDimensi2[1]}';
            tinggi.value.text =
                formatThousand(num.tryParse('${expDimensi2[2]}')) ??
                    '${expDimensi2[2]}';
            selectedDimensiKoli.value = expDimensi[1];
            jumlahKoli.value.text =
                formatThousand(num.tryParse('${element["KoliQty"]}')) ??
                    '${element["KoliQty"]}';
            radioButtonSatuMultipleLokasi.value = element["PickupType"];
            radioButtonSatuMultipleLokasiDestinasi.value =
                element["DestinationType"];
            catatanTambahan.value.text = res["Data"]["BidNote"][0]["Note"];
            if (element["MaxPrice"] > 0) {
              radioButtonMakHarga.value = "1";
              var currencyFormarter = NumberFormat("#,###", "ID");
              hargaUnitTruk.value.text =
                  currencyFormarter.format(element["MaxPrice"]);
            } else {
              radioButtonMakHarga.value = "2";
            }
            var expHrgPenawaran =
                element["PriceInclude"].toString().split("*_*_*");
            for (var i = 0; i < expHrgPenawaran.length; i++) {
              if (expHrgPenawaran[i] ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleTransportFee".tr) {
                checkBoxTarifJasaTransport.value = true;
                checkBoxTarifJasaTransportVal.value =
                    "LelangMuatBuatLelangBuatLelangLabelTitleTransportFee".tr;
              }
              if (expHrgPenawaran[i] ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleItemInsurance".tr) {
                checkBoxAsuransiBarang.value = true;
                checkBoxAsuransiBarangVal.value =
                    "LelangMuatBuatLelangBuatLelangLabelTitleItemInsurance".tr;
                var currencyFormarter = NumberFormat("#,###", "ID");
                nilaiBarang.value.text =
                    currencyFormarter.format(element["ItemPrice"]);
              }
              if (expHrgPenawaran[i] ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleEscortFee".tr) {
                checkBoxBiayaPengawalan.value = true;
                checkBoxBiayaPengawalanVal.value =
                    "LelangMuatBuatLelangBuatLelangLabelTitleEscortFee".tr;
              }
              if (expHrgPenawaran[i] ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleTollFee".tr) {
                checkBoxBiayaJalan.value = true;
                checkBoxBiayaJalanVal.value =
                    "LelangMuatBuatLelangBuatLelangLabelTitleTollFee".tr;
              }
            }

            var expTmpMuat =
                element["HandlingLoadingPrice"].toString().split("*_*_*");
            for (var i = 0; i < expTmpMuat.length; i++) {
              if (expTmpMuat[i] == "ForkLift") {
                tempatMuatForklift.value = true;
                tempatMuatForkliftVal.value = "ForkLift";
              } else if (expTmpMuat[i] == "Crane") {
                tempatMuatCrane.value = true;
                tempatMuatCraneVal.value = "Crane";
              } else if (expTmpMuat[i] ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleJasaTenaga".tr) {
                tempatMuatJasaTenagaMuat.value = true;
                tempatMuatJasaTenagaMuatVal.value =
                    "LelangMuatBuatLelangBuatLelangLabelTitleJasaTenaga".tr;
              } else if (expTmpMuat[i] ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr) {
                tempatMuatLainLain.value = true;
                tempatMuatLainLainVal.value =
                    "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr;
              } else {
                // print("SDLALDSALFALFAS ${expTmpMuat[i]}");
                // if (expTmpMuat[i] ==
                //     "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr) {
                tempatmuatlainlainform.value.text = expTmpMuat[i];
                // }
              }
            }

            var expTmpBongkar =
                element["HandlingUnloadingPrice"].toString().split("*_*_*");
            for (var i = 0; i < expTmpBongkar.length; i++) {
              if (expTmpBongkar[i] == "ForkLift") {
                tempatBongkarForklift.value = true;
                tempatBongkarForkliftVal.value = "ForkLift";
              } else if (expTmpBongkar[i] == "Crane") {
                tempatBongkarCrane.value = true;
                tempatBongkarCraneVal.value = "Crane";
              } else if (expTmpBongkar[i] ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleJasaTenaga".tr) {
                tempatBongkarJasaTenagaMuat.value = true;
                tempatBongkarJasaTenagaMuatVal.value =
                    "LelangMuatBuatLelangBuatLelangLabelTitleJasaTenaga".tr;
              } else if (expTmpBongkar[i] ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr) {
                tempatBongkarLainLain.value = true;
                tempatBongkarLainLainVal.value =
                    "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr;
              } else {
                // if (expTmpBongkar[i] ==
                //     "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr) {
                tempatbongkarlainlainform.value.text = expTmpBongkar[i];
                // }
              }
            }

            var expVal = element["PaymentTerm"].toString().split("*_*_*");

            if (element["PaymentTerm"] ==
                "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermCashLoad"
                    .tr) {
              terminPembayaran.value = element["PaymentTerm"];
            }
            if (element["PaymentTerm"] ==
                "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermCashUnload"
                    .tr) {
              terminPembayaran.value = element["PaymentTerm"];
            }
            if (expVal[0] ==
                "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture"
                    .tr) {
              var expVal = element["PaymentTerm"].toString().split("*_*_*");
              terminPembayaran.value = expVal[0];
              berjangkaDropdown.value = int.parse(expVal[1]);
            }
            if (expVal[0] ==
                "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr) {
              var expVal = element["PaymentTerm"].toString().split("*_*_*");
              terminPembayaran.value = expVal[0];
              lainlainTerminPembayaranForm.value.text = expVal[1];
              lainlaintermin.value = true;
            }
            // var exppickupeta = element["PickupEta"].toString().split(" ");
            // ekspektasiwaktupickupValue.value = element["PickupEtaSalin"];
            // ekspektasiwaktupickup.value.text =
            //     "${exppickupeta[0]} ${exppickupeta[1]} ${exppickupeta[2]} ${exppickupeta[3]}";
            // bagianwaktuinformasiPickup.value = element["PickupEtaTimezone"];
            var listPick = [];
            var listDest = [];
            alamatMulti = [];
            listCurentLocation = [];
            listCurentLocationDestinasi = [];
            alamatMultiDestinasi = [];
            (res["Data"]["BidLocation"] as List).forEach((el) {
              if (el["Type"] == "0") {
                if (element["PickupType"] ==
                    "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr) {
                  alamatSatuan.value.text = el["Address"];
                  detailalamatSatuan.value.text = el["DetailAddress"];
                  getProvinceById(el["ProvinceId"]);
                  provinceId.value = el["ProvinceId"].toString();
                  locationResultMap.value["city"] = el["City"];
                  namaPicSatuan.value.text = el["PicName"] ?? "";
                  noTelpPicSatuam.value.text = el["PicNo"] ?? "";
                  locationResultMap.value["lng"] = el["Longitude"];
                  locationResultMap.value["lat"] = el["Latitude"];
                  currentLocation.value = LatLng(
                      double.parse(locationResultMap.value["lat"]),
                      double.parse(locationResultMap.value["lng"]));
                  listCurentLocation = [];
                  listCurentLocation.add(LatLng(
                      double.parse(locationResultMap.value["lat"]),
                      double.parse(locationResultMap.value["lng"])));
                  mapController.onReady.then((value) {
                    mapController.move(currentLocation.value, 17.7);
                  });
                }
                if (element["PickupType"] ==
                    "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                        .tr) {
                  listPick.add(res["Data"]["BidLocation"].indexOf(el));
                  dropdownJumlahLokasi.value = listPick.length;
                  int idx = listPick.indexWhere(
                      (item) => item == res["Data"]["BidLocation"].indexOf(el));
                  alamatMulti.add(TextEditingController());
                  detailalamatMulti.add(TextEditingController());
                  provinsiMulti.add(TextEditingController());
                  namaPicMulti.add(TextEditingController());
                  noTelpPicMulti.add(TextEditingController());
                  isKosongAlamatMulti.add(false);
                  city.add(TextEditingController());
                  lat.add(TextEditingController());
                  lng.add(TextEditingController());
                  provinceIdList.add(TextEditingController());
                  currentLocationList.add(LatLng(0, 0));
                  listCurentLocation.add(LatLng(0, 0));
                  alamatMulti[idx].text = el["Address"];
                  detailalamatMulti[idx].text = el["DetailAddress"];
                  getProvinceByIdMulti(el["ProvinceId"], idx);
                  provinceIdList[idx].text = el["ProvinceId"].toString();
                  city[idx].text = el["City"];
                  namaPicMulti[idx].text = el["PicName"];
                  noTelpPicMulti[idx].text = el["PicNo"];
                  lng[idx].text = el["Longitude"];
                  lat[idx].text = el["Latitude"];
                  currentLocation.value = LatLng(double.parse(el["Latitude"]),
                      double.parse(el["Longitude"]));
                  currentLocationList[idx] = LatLng(
                      double.parse(el["Latitude"]),
                      double.parse(el["Longitude"]));
                  listCurentLocation = [];
                  listCurentLocation = currentLocationList;
                  mapController.onReady.then((value) {
                    mapController.move(currentLocationList[idx], 6);
                  });
                }
              }

              if (el["Type"] == "1") {
                if (element["DestinationType"] ==
                    "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr) {
                  alamatSatuanDestinasi.value.text = el["Address"];
                  detailalamatSatuanDestinasi.value.text = el["DetailAddress"];
                  getProvinceByIdDestinasi(el["ProvinceId"]);
                  provinceIdDestinasi.value = el["ProvinceId"].toString();
                  locationResultMapDestinasi.value["city"] = el["City"];
                  namaPicSatuanDestinasi.value.text = el["PicName"] ?? "";
                  noTelpPicSatuamDestinasi.value.text = el["PicNo"] ?? "";
                  locationResultMapDestinasi.value["lng"] = el["Longitude"];
                  locationResultMapDestinasi.value["lat"] = el["Latitude"];
                  currentLocationDestinasi.value = LatLng(
                      double.parse(locationResultMapDestinasi.value["lat"]),
                      double.parse(locationResultMapDestinasi.value["lng"]));
                  listCurentLocationDestinasi = [];
                  listCurentLocationDestinasi.add(LatLng(
                      double.parse(locationResultMapDestinasi.value["lat"]),
                      double.parse(locationResultMapDestinasi.value["lng"])));
                  mapControllerDestinasi.onReady.then((value) {
                    mapControllerDestinasi.move(
                        currentLocationDestinasi.value, 17.7);
                  });
                }
                if (element["DestinationType"] ==
                    "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                        .tr) {
                  listDest.add(res["Data"]["BidLocation"].indexOf(el));
                  dropdownJumlahLokasiDestinasi.value = listDest.length;
                  int idx = listDest.indexWhere(
                      (item) => item == res["Data"]["BidLocation"].indexOf(el));
                  alamatMultiDestinasi.add(TextEditingController());
                  detailalamatMultiDestinasi.add(TextEditingController());
                  provinsiMultiDestinasi.add(TextEditingController());
                  namaPicMultiDestinasi.add(TextEditingController());
                  noTelpPicMultiDestinasi.add(TextEditingController());
                  isKosongAlamatMultiDestinasi.add(false);
                  cityDestinasi.add(TextEditingController());
                  latDestinasi.add(TextEditingController());
                  lngDestinasi.add(TextEditingController());
                  provinceIdListDestinasi.add(TextEditingController());
                  currentLocationDestinasiList.add(LatLng(0, 0));
                  listCurentLocationDestinasi.add(LatLng(0, 0));

                  alamatMultiDestinasi[idx].text = el["Address"];
                  detailalamatMultiDestinasi[idx].text = el["DetailAddress"];
                  getProvinceByIdMultiDestinasi(el["ProvinceId"], idx);
                  provinceIdListDestinasi[idx].text =
                      el["ProvinceId"].toString();
                  cityDestinasi[idx].text = el["City"];
                  namaPicMultiDestinasi[idx].text = el["PicName"];
                  noTelpPicMultiDestinasi[idx].text = el["PicNo"];
                  lngDestinasi[idx].text = el["Longitude"];
                  latDestinasi[idx].text = el["Latitude"];
                  currentLocationDestinasi.value = LatLng(
                      double.parse(el["Latitude"]),
                      double.parse(el["Longitude"]));
                  currentLocationDestinasiList[idx] = LatLng(
                      double.parse(el["Latitude"]),
                      double.parse(el["Longitude"]));
                  listCurentLocationDestinasi = [];
                  listCurentLocationDestinasi = currentLocationDestinasiList;
                  mapControllerDestinasi.onReady.then((value) {
                    mapControllerDestinasi.move(
                        currentLocationDestinasiList[idx], 6);
                  });
                }
              }
            });

            // lingImg.value = element["TruckPicture"];
            // beratMaxDimensiVolume.value
            // dataDetail.add(element);
            getSpecificTruck(
                element["HeadId"].toString(), element["CarrierId"].toString());

            for (var i = 0; i < dropdownJumlahLokasi.value; i++) {
              alamatMulti.add(TextEditingController());
              detailalamatMulti.add(TextEditingController());
              provinsiMulti.add(TextEditingController());
              namaPicMulti.add(TextEditingController());
              noTelpPicMulti.add(TextEditingController());
              isKosongAlamatMulti.add(false);
              city.add(TextEditingController());
              lat.add(TextEditingController());
              lng.add(TextEditingController());
              provinceIdList.add(TextEditingController());
              currentLocationList.add(LatLng(0, 0));
              listCurentLocation.add(LatLng(0, 0));
            }
            for (var i = 0; i < dropdownJumlahLokasiDestinasi.value; i++) {
              alamatMultiDestinasi.add(TextEditingController());
              detailalamatMultiDestinasi.add(TextEditingController());
              provinsiMultiDestinasi.add(TextEditingController());
              namaPicMultiDestinasi.add(TextEditingController());
              noTelpPicMultiDestinasi.add(TextEditingController());
              isKosongAlamatMultiDestinasi.add(false);
              cityDestinasi.add(TextEditingController());
              latDestinasi.add(TextEditingController());
              lngDestinasi.add(TextEditingController());
              provinceIdListDestinasi.add(TextEditingController());
              currentLocationDestinasiList.add(LatLng(0, 0));
              listCurentLocationDestinasi.add(LatLng(0, 0));
            }
          });
        } else {
          CustomToast.show(
              context: Get.context,
              sizeRounded: 6,
              message: res["Message"]["Text"].toString());
        }
      }
    } catch (e) {
      print("GAGAL $e");
    }
  }

  getCurrentDateApi() async {
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      var res = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getCurrentDate(
              GlobalVariable.role, resLoginAs["LoginAs"].toString());

      if (res["Message"]["Code"] == 200) {
        if (res["Data"] != "") {
          curdate = DateTime.parse(res["Data"]);
        } else {
          curdate = DateTime.now();
        }
      }
    }
  }

  Future<void> getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    currentLocation.value =
        LatLng(_locationData.latitude, _locationData.longitude);
    mapController.onReady.then((value) {
      mapController.move(currentLocation.value, 17.7);
    });

    listCurentLocation = [];

    if (radioButtonSatuMultipleLokasi.value ==
        "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr) {
      listCurentLocation
          .add(LatLng(_locationData.latitude, _locationData.longitude));
    } else {
      listCurentLocation = [];
      for (var i = 0; i < dropdownJumlahLokasi.value; i++) {
        listCurentLocation
            .add(LatLng(_locationData.latitude, _locationData.longitude));
        currentLocationList[i] =
            LatLng(_locationData.latitude, _locationData.longitude);
      }
    }

    for (var i = 0; i < dropdownJumlahLokasi.value; i++) {}

    currentLocationDestinasi.value =
        LatLng(_locationData.latitude, _locationData.longitude);
    mapControllerDestinasi.onReady.then((value) {
      mapControllerDestinasi.move(currentLocationDestinasi.value, 17.7);
    });

    for (var i = 0; i < dropdownJumlahLokasiDestinasi.value; i++) {}

    listCurentLocationDestinasi = [];
    if (radioButtonSatuMultipleLokasiDestinasi.value ==
        "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr) {
      listCurentLocationDestinasi
          .add(LatLng(_locationData.latitude, _locationData.longitude));
    } else {
      listCurentLocationDestinasi = [];
      for (var i = 0; i < dropdownJumlahLokasiDestinasi.value; i++) {
        listCurentLocationDestinasi
            .add(LatLng(_locationData.latitude, _locationData.longitude));
        currentLocationDestinasiList[i] =
            LatLng(_locationData.latitude, _locationData.longitude);
      }
    }

    // print("KFAFHGDHCA ${currentLocation.value}");
  }

  datestartPicker() async {
    var picked = await showDatePicker(
        context: Get.context,
        initialDate: curdate,
        firstDate: curdate,
        lastDate: DateTime(20200));

    if (picked != null) {
      inisialDateEndPicker = picked;
      isSelectStartDate.value = true;

      String isMonth = "";
      if (picked.month.toString().length > 1) {
        isMonth = "${picked.month}";
      } else {
        isMonth = "0${picked.month}";
      }

      String isDay = "";
      if (picked.day.toString().length > 1) {
        isDay = "${picked.day}";
      } else {
        isDay = "0${picked.day}";
      }

      dateAwal.value = "${picked.year}-$isMonth-$isDay";
      periodeAwalController.value.text = "$isDay/$isMonth/${picked.year}";
      isKosongPeriodeAwal.value = false;
    }
  }

  dateendPicker() async {
    var picked = await showDatePicker(
        context: Get.context,
        initialDate: firstdate == null ? inisialDateEndPicker : firstdate,
        firstDate: inisialDateEndPicker,
        lastDate: DateTime(inisialDateEndPicker.year,
            inisialDateEndPicker.month, inisialDateEndPicker.day + 3));

    if (picked != null) {
      firstExpWaktu.value = picked;
      firstdate = picked;
      String isDayend = "";
      if (picked.day.toString().length > 1) {
        isDayend = "${picked.day}";
      } else {
        isDayend = "0${picked.day}";
      }

      String isMonthend = "";
      if (picked.month.toString().length > 1) {
        isMonthend = "${picked.month}";
      } else {
        isMonthend = "0${picked.month}";
      }

      dateAkhir.value = "${picked.year}-$isMonthend-$isDayend";
      periodeAkhirController.value.text =
          "$isDayend/$isMonthend/${picked.year}";
      isKosongPeriodeAkhir.value = false;
    }
  }

  jumlahTrukDropdown({int select = 0}) {
    // alamatMulti = [];
    int lengthIdx = 0;
    lengthIdx = select;
    dropdownJumlahLokasi.value = select;
    listCurentLocation = [];
    currentLocationList = [];
    alamatMulti.clear();
    detailalamatMulti.clear();
    provinsiMulti.clear();
    namaPicMulti.clear();
    noTelpPicMulti.clear();
    isKosongAlamatMulti.clear();
    city.clear();
    lat.clear();
    lng.clear();
    provinceIdList.clear();
    for (var i = 0; i < lengthIdx; i++) {
      alamatMulti.add(TextEditingController());
      detailalamatMulti.add(TextEditingController());
      provinsiMulti.add(TextEditingController());
      namaPicMulti.add(TextEditingController());
      noTelpPicMulti.add(TextEditingController());
      isKosongAlamatMulti.add(false);
      city.add(TextEditingController());
      lat.add(TextEditingController());
      lng.add(TextEditingController());
      provinceIdList.add(TextEditingController());
      currentLocationList.add(currentLocation.value);
      listCurentLocation.add(currentLocation.value);
      mapController.onReady.then((value) {
        mapController.move(currentLocation.value, 6);
      });
    }
  }

  jumlahTrukDropdownDestinasi({int select = 0}) {
    // alamatMultiDestinasi = [];
    int lengthIdx = 0;
    lengthIdx = select;
    dropdownJumlahLokasiDestinasi.value = select;
    listCurentLocationDestinasi = [];
    currentLocationDestinasiList = [];
    alamatMultiDestinasi.clear();
    detailalamatMultiDestinasi.clear();
    provinsiMultiDestinasi.clear();
    namaPicMultiDestinasi.clear();
    noTelpPicMultiDestinasi.clear();
    isKosongAlamatMultiDestinasi.clear();
    cityDestinasi.clear();
    latDestinasi.clear();
    lngDestinasi.clear();
    provinceIdListDestinasi.clear();
    for (var i = 0; i < lengthIdx; i++) {
      alamatMultiDestinasi.add(TextEditingController());
      detailalamatMultiDestinasi.add(TextEditingController());
      provinsiMultiDestinasi.add(TextEditingController());
      namaPicMultiDestinasi.add(TextEditingController());
      noTelpPicMultiDestinasi.add(TextEditingController());
      isKosongAlamatMultiDestinasi.add(false);
      cityDestinasi.add(TextEditingController());
      latDestinasi.add(TextEditingController());
      lngDestinasi.add(TextEditingController());
      provinceIdListDestinasi.add(TextEditingController());
      currentLocationDestinasiList.add(currentLocationDestinasi.value);
      listCurentLocationDestinasi.add(currentLocationDestinasi.value);
      mapControllerDestinasi.onReady.then((value) {
        mapControllerDestinasi.move(currentLocation.value, 6);
      });
    }
  }

  void isShowInfoAction() {
    if (isShowInfo.value) {
      isShowInfo.value = false;
    } else {
      isShowInfo.value = true;
    }
  }

  void getListJenisTruck() async {
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .listHeadTruck();
    if (resultCity["Message"]["Code"] == 200) {
      listFilterJenisTruck.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterJenisTruck.add(element);
      });
    }
  }

  void getListJenisCarrier(String headId) async {
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: true,
            isShowDialogError: false)
        .listCarrierTruckByTruck(headID: headId);
    if (resultCity != null && resultCity["Message"]["Code"] == 200) {
      listFilterJenisCarrier.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterJenisCarrier.add(element);
      });
      jenisCarrier.value.text = resultCity["Data"][0]["Description"].toString();
      carrierId.value = resultCity["Data"][0]["ID"].toString();
      // lingImg.value = resultCity["Data"][0]["ImageCarrier"].toString();
      getSpecificTruck(headId, resultCity["Data"][0]["ID"].toString());
    }
  }

  Future getSpecificTruck(String headID, String carrierID) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getSpecificTruck(headID, carrierID);
    if (res["Message"]["Code"] == 200) {
      beratMaxDimensiVolume.value = res["Data"]["Tonase"].toString() +
          " Ton/" +
          res["Data"]["Length"].toString() +
          " x " +
          res["Data"]["Width"].toString() +
          " x " +
          res["Data"]["Height"].toString() +
          "/" +
          res["Data"]["Volume"].toString();

      lingImg.value = res["Data"]["TruckURL"].toString();
      truckId.value = res["Data"]["TruckID"].toString();
    }
  }

  Future getJenisMuatan() async {
    var resJenisMuatan = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getJenisMuatan();

    listjenismuatan.clear();
    if (resJenisMuatan["Message"]["Code"] == 200) {
      (resJenisMuatan["Data"] as List).forEach((element) {
        listjenismuatan.add(element["Description"]);
      });

      // dropdownJenisMuatan = buildDropdownJenisMuatan(resJenisMuatan["Data"]);
    }
    // if (listjenismuatan.isEmpty) {
    //   listjenismuatan.addAll([
    //     'Padat',
    //     'Cair',
    //     'Curah',
    //   ]);
    // }
  }

  void cariTruck() async {
    beratMaxDimensiVolume.value = "";
    var result = await GetToPage.toNamed<ZoFilterTruckSatuanController>(
        Routes.ZO_FILTER_TRUCK_SATUAN,
        arguments: [
          List.from(listFilterJenisTruck.value),
          "LelangMuatBuatLelangBuatLelangLabelTitleTruckType".tr
        ],
        preventDuplicates: false);
    if (result != null) {
      tempFilterJenisTruck.value = result;
      headId.value = result["ID"].toString();
      jenisTruk.value.text = result["Description"].toString();
      getListJenisCarrier(result["ID"].toString());
    }
  }

  void cariCarrier() async {
    beratMaxDimensiVolume.value = "";
    var result = await GetToPage.toNamed<ZoFilterTruckSatuanController>(
        Routes.ZO_FILTER_TRUCK_SATUAN,
        arguments: [
          List.from(listFilterJenisCarrier.value),
          "LelangMuatBuatLelangBuatLelangLabelTitleCarrierType".tr
        ],
        preventDuplicates: false);
    if (result != null) {
      tempFilterJenisCarrier.value = result;
      carrierId.value = result["ID"].toString();
      jenisCarrier.value.text = result["Description"].toString();
      getSpecificTruck(
          tempFilterJenisTruck.value["ID"].toString(), result["ID"].toString());
    }
  }

  // void getListLokasiPickup() async {
  //   var resultCity =
  //       await ApiHelper(context: Get.context, isShowDialogLoading: false)
  //           .fetchSearchCity("");
  //   if (resultCity["Message"]["Code"] == 200) {
  //     areaPickup.clear();
  //     (resultCity["Data"] as List).forEach((element) {
  //       areaPickup = element;
  //     });
  //   } else {
  //     // failedGetListFilter.value = true;
  //   }
  // }

  getProvinceById(int idProvince) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvince();
    if (res["Message"]["Code"] == 200) {
      (res["Data"] as List).forEach((element) {
        if (element["Code"] == idProvince) {
          provinsiSatuan.value.text = element["Description"];
        }
      });
    }
  }

  getProvinceByIdMulti(int idProvince, int idx) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvince();
    if (res["Message"]["Code"] == 200) {
      (res["Data"] as List).forEach((element) {
        if (element["Code"] == idProvince) {
          provinsiMulti[idx].text = element["Description"];
        }
      });
    }
  }

  getProvinceByIdDestinasi(int idProvince) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvince();
    if (res["Message"]["Code"] == 200) {
      (res["Data"] as List).forEach((element) {
        if (element["Code"] == idProvince) {
          provinsiSatuanDestinasi.value.text = element["Description"];
        }
      });
    }
  }

  getProvinceByIdMultiDestinasi(int idProvince, int idx) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvince();
    if (res["Message"]["Code"] == 200) {
      (res["Data"] as List).forEach((element) {
        if (element["Code"] == idProvince) {
          provinsiMultiDestinasi[idx].text = element["Description"];
        }
      });
    }
  }

  getProvinceFilter(String province, int idx) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvinceFilter(province);
    if (res["Message"]["Code"] == 200) {
      (res["Data"] as List).forEach((element) {
        if (idx == null) {
          provinsiSatuan.value.text = element["Description"].toString();
          provinceId.value = element["Code"].toString();
        } else {
          provinsiMulti[idx].text = element["Description"].toString();
          provinceIdList[idx].text = element["Code"].toString();
        }
      });
    }
  }

  Future<void> getLokasiDetail(String placeid, int idx) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchInfoFromAddress(placeID: placeid);

    if (idx == null) {
      provinsiSatuan.value.text = res["province"];
      getProvinceFilter(res["province"], idx);
      locationResultMap.value = res;
      currentLocation.value = LatLng(res["lat"], res["lng"]);
      listCurentLocation = [];
      listCurentLocation.add(LatLng(res["lat"], res["lng"]));
      mapController.onReady.then((value) {
        mapController.move(currentLocation.value, 17.7);
      });
    } else {
      provinsiMulti[idx].text = res["province"];
      getProvinceFilter(res["province"], idx);
      city[idx].text = res["city"].toString();
      lat[idx].text = res["lat"].toString();
      lng[idx].text = res["lng"].toString();
      currentLocation.value = LatLng(res["lat"], res["lng"]);
      currentLocationList[idx] = LatLng(res["lat"], res["lng"]);
      listCurentLocation = [];
      listCurentLocation = currentLocationList;
      mapController.onReady.then((value) {
        mapController.move(currentLocationList[idx], 6);
      });
    }
  }

  void cariLokasi(String argu, int idx) async {
    var curLok;
    if (idx == null) {
      curLok = currentLocation.value;
    } else {
      curLok = currentLocationList[idx];
    }
    var result = await GetToPage.toNamed<ZoSearchLokasiController>(
        Routes.ZO_SEARCH_LOKASI,
        arguments: [argu, idx, "0", curLok],
        preventDuplicates: false);
    if (result != null) {
      if (result["idx"] == null) {
        if (result["placeId"] != "") {
          print("reFSDF $result");
          getLokasiDetail(result["placeId"], result["idx"]);
        }
        alamatSatuan.value.text = result["val"];

        if (result["kota"] != "") {
          locationResultMap.value["city"] = result["kota"];
        }

        if (result["provinsi"] != "") {
          provinsiSatuan.value.text = result["provinsi"];
          getProvinceFilter(result["provinsi"], null);
        }

        if (result["ltlg"] != "") {
          locationResultMap.value["lng"] = result["ltlg"].longitude;
          locationResultMap.value["lat"] = result["ltlg"].latitude;
          currentLocation.value =
              LatLng(result["ltlg"].latitude, result["ltlg"].longitude);

          mapController.onReady.then((value) {
            mapController.move(currentLocation.value, GlobalVariable.zoomMap);
          });
        }
      } else {
        if (result["placeId"] != "") {
          getLokasiDetail(result["placeId"], result["idx"]);
        }
        alamatMulti[result["idx"]].text = result["val"];

        if (result["kota"] != "") {
          city[idx].text = result["kota"];
        }

        if (result["provinsi"] != "") {
          provinsiMulti[result["idx"]].text = result["provinsi"];
          getProvinceFilter(result["provinsi"], result["idx"]);
        }

        if (result["ltlg"] != "") {
          lat[result["idx"]].text = result["ltlg"].latitude.toString();
          lng[result["idx"]].text = result["ltlg"].longitude.toString();
          currentLocationList[result["idx"]] =
              LatLng(result["ltlg"].latitude, result["ltlg"].longitude);

          mapController.onReady.then((value) {
            mapController.move(
                currentLocationList[result["idx"]], GlobalVariable.zoomMap);
          });
        }
      }
    }
  }

  getProvinceFilterDestinasi(String province, int idx) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvinceFilter(province);
    if (res["Message"]["Code"] == 200) {
      (res["Data"] as List).forEach((element) {
        if (idx == null) {
          provinsiSatuanDestinasi.value.text =
              element["Description"].toString();
          provinceIdDestinasi.value = element["Code"].toString();
        } else {
          provinsiMultiDestinasi[idx].text = element["Description"].toString();
          provinceIdListDestinasi[idx].text = element["Code"].toString();
        }
      });
    }
  }

  Future<void> getLokasiDetailDestinasi(String placeid, int idx) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchInfoFromAddress(placeID: placeid);
    if (idx == null) {
      provinsiSatuanDestinasi.value.text = res["province"];
      getProvinceFilterDestinasi(res["province"], idx);
      locationResultMapDestinasi.value = res;
      listCurentLocationDestinasi = [];
      listCurentLocationDestinasi.add(LatLng(res["lat"], res["lng"]));
      currentLocationDestinasi.value = LatLng(res["lat"], res["lng"]);
      mapControllerDestinasi.onReady.then((value) {
        mapControllerDestinasi.move(currentLocationDestinasi.value, 17.7);
      });
    } else {
      provinsiMultiDestinasi[idx].text = res["province"];
      getProvinceFilterDestinasi(res["province"], idx);
      cityDestinasi[idx].text = res["city"].toString();
      latDestinasi[idx].text = res["lat"].toString();
      lngDestinasi[idx].text = res["lng"].toString();
      listCurentLocationDestinasi = [];
      listCurentLocationDestinasi = currentLocationDestinasiList;
      currentLocationDestinasi.value = LatLng(res["lat"], res["lng"]);
      currentLocationDestinasiList[idx] = LatLng(res["lat"], res["lng"]);
      mapControllerDestinasi.onReady.then((value) {
        mapControllerDestinasi.move(currentLocationDestinasiList[idx], 6);
      });
    }
  }

  void cariLokasiDestinasi(String argu, int idx) async {
    var curLok;
    if (idx == null) {
      curLok = currentLocationDestinasi.value;
    } else {
      curLok = currentLocationDestinasiList[idx];
    }
    var result = await GetToPage.toNamed<ZoSearchLokasiController>(
        Routes.ZO_SEARCH_LOKASI,
        arguments: [argu, idx, "1", curLok],
        preventDuplicates: false);
    if (result != null) {
      if (result["idx"] == null) {
        if (result["placeId"] != "") {
          getLokasiDetailDestinasi(result["placeId"], result["idx"]);
        }
        alamatSatuanDestinasi.value.text = result["val"];
        if (result["kota"] != "") {
          locationResultMapDestinasi.value["city"] = result["kota"];
        }
        if (result["provinsi"] != "") {
          provinsiSatuanDestinasi.value.text = result["provinsi"];
          getProvinceFilterDestinasi(result["provinsi"], null);
        }
        if (result["ltlg"] != "") {
          locationResultMapDestinasi.value["lng"] = result["ltlg"].longitude;
          locationResultMapDestinasi.value["lat"] = result["ltlg"].latitude;

          currentLocationDestinasi.value =
              LatLng(result["ltlg"].latitude, result["ltlg"].longitude);
          mapControllerDestinasi.onReady.then((value) {
            mapControllerDestinasi.move(
                currentLocationDestinasi.value, GlobalVariable.zoomMap);
          });
        }
      } else {
        if (result["placeId"] != "") {
          getLokasiDetailDestinasi(result["placeId"], result["idx"]);
        }
        alamatMultiDestinasi[result["idx"]].text = result["val"];
        if (result["kota"] != "") {
          cityDestinasi[idx].text = result["kota"];
        }
        if (result["provinsi"] != "") {
          provinsiMultiDestinasi[result["idx"]].text = result["provinsi"];
          getProvinceFilterDestinasi(result["provinsi"], result["idx"]);
        }
        if (result["ltlg"] != "") {
          latDestinasi[result["idx"]].text = result["ltlg"].latitude.toString();
          lngDestinasi[result["idx"]].text =
              result["ltlg"].longitude.toString();

          currentLocationDestinasiList[result["idx"]] =
              LatLng(result["ltlg"].latitude, result["ltlg"].longitude);
          mapControllerDestinasi.onReady.then((value) {
            mapControllerDestinasi.move(
                currentLocationDestinasiList[result["idx"]],
                GlobalVariable.zoomMap);
          });
        }
      }
    }
  }

  void updateTitle() {
    switch (slideIndex.value) {
      case 0:
        {
          title.value = "LelangMuatBuatLelangBuatLelangLabelTitleBidData".tr;
          break;
        }
      case 1:
        {
          title.value =
              "LelangMuatBuatLelangBuatLelangLabelTitleDataKebutuhan".tr;
          break;
        }
      case 2:
        {
          title.value = "LelangMuatBuatLelangBuatLelangLabelTitleCargoData".tr;
          break;
        }
      case 3:
        {
          title.value =
              "LelangMuatBuatLelangBuatLelangLabelTitleInformasiPickup".tr;
          break;
        }
      case 4:
        {
          title.value =
              "LelangMuatBuatLelangBuatLelangLabelTitleInformasiDestinasi".tr;
          break;
        }
      case 5:
        {
          title.value =
              "LelangMuatBuatLelangBuatLelangLabelTitleDataPenawaran".tr;
          break;
        }
    }
  }

  pembatalanBuatLelang() {
    Get.back();
    CustomToast.show(
        context: Get.context,
        sizeRounded: 6,
        message:
            "LelangMuatBuatLelangBuatLelangLabelTitleLelangBerhasilBatal".tr);
  }

  saveLelangBuatan(
      String roleProfile,
      String loginAs,
      String shippercode,
      String shipperemail,
      String shippername,
      String shipperavatar,
      String shippertimezone,
      String startdate,
      String enddate,
      String bidtype,
      String truckqty,
      String truckpicture,
      String headid,
      String headname,
      String carrierid,
      String carriername,
      String truckid,
      String cargo,
      String idcargotype,
      String weight,
      String volume,
      String dimension,
      String koliqty,
      String pickuptype,
      String pickupeta,
      String pickupetatimezone,
      String destinationtype,
      String destinationeta,
      String destinationetatimezone,
      String maxprice,
      String priceinclude,
      String itemprice,
      String handlingloadingprice,
      String handlingunloadingpriceString,
      String paymentterm,
      String provincepickup,
      String provincedestination,
      String citypickup,
      String citydestination,
      String notes,
      List location) async {
    try {
      var res = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: true,
              isShowDialogError: false)
          .postBuatLelangMuatan(
              roleProfile,
              loginAs,
              shippercode,
              shipperemail,
              shippername,
              shipperavatar,
              shippertimezone,
              startdate,
              enddate,
              bidtype,
              truckqty,
              truckpicture,
              headid,
              headname,
              carrierid,
              carriername,
              truckid,
              cargo,
              idcargotype,
              weight,
              volume,
              dimension,
              koliqty,
              pickuptype,
              pickupeta,
              pickupetatimezone,
              destinationtype,
              destinationeta,
              destinationetatimezone,
              maxprice,
              priceinclude,
              itemprice,
              handlingloadingprice,
              handlingunloadingpriceString,
              paymentterm,
              provincepickup,
              provincedestination,
              citypickup,
              citydestination,
              notes,
              location);

      if (res["Message"]["Code"] == 200) {
        Get.back(result: true);
        CustomToast.show(
            context: Get.context,
            sizeRounded: 6,
            message:
                'LelangMuatBuatLelangBuatLelangLabelTitleBerhasilMembuatLelang'
                    .tr
                    .replaceAll("\\n", "\n"));
      } else {
        Get.back(result: false);
        CustomToast.show(
            context: Get.context, sizeRounded: 6, message: 'GAGAL SAVE');
      }
    } catch (e) {
      Get.back(result: false);
      CustomToast.show(
          context: Get.context, sizeRounded: 6, message: 'GAGAL SAVE $e');
      print("GAGAL SAVE $e");
    }
  }

  Future<void> saveLelangMuatan(
      String awal, String akhir, String jenisLelang) async {
    var listLocation = [];

    if (alamatSatuan.value.text != "") {
      Map<String, dynamic> mapData = {
        "type": "0",
        "address": alamatSatuan.value.text,
        "detail_address": detailalamatSatuan.value.text,
        "province_id": provinceId.value,
        "city": locationResultMap.value["city"] ?? "",
        "pic_name": namaPicSatuan.value.text,
        "pic_no": noTelpPicSatuam.value.text,
        "longitude": locationResultMap.value["lng"] ?? "",
        "latitude": locationResultMap.value["lat"] ?? "",
      };
      listLocation.add(mapData);
    }

    for (var i = 0; i < alamatMulti.length; i++) {
      if (alamatMulti[i].text != "") {
        Map<String, dynamic> mapData = {
          "type": "0",
          "address": alamatMulti[i].text,
          "detail_address": detailalamatMulti[i].text,
          "province_id": provinceIdList[i].text,
          "city": city[i].text,
          "pic_name": namaPicMulti[i].text,
          "pic_no": noTelpPicMulti[i].text,
          "longitude": lng[i].text,
          "latitude": lat[i].text,
        };
        listLocation.add(mapData);
      }
    }

    if (alamatSatuanDestinasi.value.text != "") {
      Map<String, dynamic> mapData = {
        "type": "1",
        "address": alamatSatuanDestinasi.value.text,
        "detail_address": detailalamatSatuanDestinasi.value.text,
        "province_id": provinceIdDestinasi.value,
        "city": locationResultMapDestinasi.value["city"] ?? "",
        "pic_name": namaPicSatuanDestinasi.value.text,
        "pic_no": noTelpPicSatuamDestinasi.value.text,
        "longitude": locationResultMapDestinasi.value["lng"] ?? "",
        "latitude": locationResultMapDestinasi.value["lat"] ?? "",
      };
      listLocation.add(mapData);
    }

    for (var i = 0; i < alamatMultiDestinasi.length; i++) {
      if (alamatMultiDestinasi[i].text != "") {
        Map<String, dynamic> mapData = {
          "type": "1",
          "address": alamatMultiDestinasi[i].text,
          "detail_address": detailalamatMultiDestinasi[i].text,
          "province_id": provinceIdListDestinasi[i].text,
          "city": cityDestinasi[i].text,
          "pic_name": namaPicMultiDestinasi[i].text,
          "pic_no": noTelpPicMultiDestinasi[i].text,
          "longitude": lngDestinasi[i].text,
          "latitude": latDestinasi[i].text,
        };
        listLocation.add(mapData);
      }
    }

    var hrgpenawaran = [];
    if (checkBoxTarifJasaTransport.value) {
      hrgpenawaran.add(checkBoxTarifJasaTransportVal.value);
    }

    if (checkBoxAsuransiBarang.value) {
      hrgpenawaran.add(checkBoxAsuransiBarangVal.value);
    }

    if (checkBoxBiayaPengawalan.value) {
      hrgpenawaran.add(checkBoxBiayaPengawalanVal.value);
    }

    if (checkBoxBiayaJalan.value) {
      hrgpenawaran.add(checkBoxBiayaJalanVal.value);
    }

    var tmpMuat = [];
    if (tempatMuatForklift.value) {
      tmpMuat.add(tempatMuatForkliftVal.value);
    }

    if (tempatMuatCrane.value) {
      tmpMuat.add(tempatMuatCraneVal.value);
    }

    if (tempatMuatJasaTenagaMuat.value) {
      tmpMuat.add(tempatMuatJasaTenagaMuatVal.value);
    }

    if (tempatMuatLainLain.value) {
      tmpMuat.add(tempatMuatLainLainVal.value);
      tmpMuat.add(tempatmuatlainlainform.value.text);
    }

    var tmpBongkar = [];
    if (tempatBongkarForklift.value) {
      tmpBongkar.add(tempatBongkarForkliftVal.value);
    }

    if (tempatBongkarCrane.value) {
      tmpBongkar.add(tempatBongkarCraneVal.value);
    }

    if (tempatBongkarJasaTenagaMuat.value) {
      tmpBongkar.add(tempatBongkarJasaTenagaMuatVal.value);
    }

    if (tempatBongkarLainLain.value) {
      tmpBongkar.add(tempatBongkarLainLainVal.value);
      tmpBongkar.add(tempatbongkarlainlainform.value.text);
    }

    var terminBerjangka = [];
    if (terminPembayaran.value ==
        "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture".tr) {
      terminBerjangka.add(terminPembayaran.value);
      terminBerjangka.add(berjangkaDropdown.value.toString());
    }

    var terminLainLain = [];
    if (terminPembayaran.value ==
        "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr) {
      terminLainLain.add(terminPembayaran.value);
      terminLainLain.add(lainlainTerminPembayaranForm.value.text);
    }

    String dimensi = "";
    if (panjang.value.text != "" &&
        lebar.value.text != "" &&
        tinggi.value.text != "") {
      String p = "";
      String l = "";
      String t = "";
      if (panjang.value.text.contains(",")) {
        p = panjang.value.text;
      } else {
        p = panjang.value.text + ",00";
      }

      if (lebar.value.text.contains(",")) {
        l = lebar.value.text;
      } else {
        l = lebar.value.text + ",00";
      }

      if (tinggi.value.text.contains(",")) {
        t = tinggi.value.text;
      } else {
        t = tinggi.value.text + ",00";
      }
      dimensi = p + "*_*_*" + l + "*_*_*" + t + " " + selectedDimensiKoli.value;
    }

    String vol = "";
    if (volume.value.text != "") {
      vol = volume.value.text + " " + selectedVolume.value;
    }

    var loginAs = "";
    var shipperCode = "";
    var shipperEmail = "";
    var shipperName = "";
    var shipperAvatar = "";
    var shipperTimezone = "";
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      loginAs = resLoginAs["LoginAs"].toString();
      var res = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getProfilShipper(resLoginAs["LoginAs"].toString());

      if (res["Message"]["Code"] == 200) {
        shipperCode = res["Data"]["Code"];
        shipperEmail = res["Data"]["Email"];
        shipperName = res["Data"]["ShipperName"];
        shipperAvatar = res["Data"]["Avatar"];
      }
    }

    var resTimezone = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getTimeZoneShipper(GlobalVariable.docID);

    if (resTimezone["Message"]["Code"] == 200) {
      (resTimezone["Data"] as List).forEach((element) {
        if (element["ID"] == resTimezone["SupportingData"]["Used"]) {
          shipperTimezone = element["Alias"].toString();
        }
      });
    }

    // Map<String, dynamic> data = {
    String roleProfile = GlobalVariable.role;
    String loginas = loginAs;
    String shippercode = shipperCode;
    String shipperemail = shipperEmail;
    String shippername = shipperName;
    String shipperavatar = shipperAvatar;
    String shippertimezone = shipperTimezone;
    String startdate = awal;
    String enddate = akhir;
    String bidtype = jenisLelang;
    String truckqty = jumlahTrukCount.value.toString();
    String truckpicture = lingImg.value;
    String headid = headId.value;
    String headname = jenisTruk.value.text;
    String carrierid = carrierId.value;
    String carriername = jenisCarrier.value.text;
    String truckid = truckId.value;
    String cargo = muatan.value.text;
    String idcargotype = selectedjenismuatan.value;
    String weight = berat.value.text.replaceAll('.', '');
    String volumePar = vol.replaceAll('.', '');
    String dimension = dimensi.replaceAll('.', '').replaceAll(',', '.');
    String koliqty = jumlahKoli.value.text.replaceAll('.', '');
    String pickuptype = radioButtonSatuMultipleLokasi.value;
    String pickupeta = ekspektasiwaktupickupValue.value;
    String pickupetatimezone = bagianwaktuinformasiPickup.value;
    String destinationtype = radioButtonSatuMultipleLokasiDestinasi.value;
    String destinationeta = ekspektasiwaktupickupValueDestinasi.value;
    String destinationetatimezone = bagianwaktuinformasiDestinasi.value;
    String maxprice = radioButtonMakHarga.value == "1"
        ? hargaUnitTruk.value.text.replaceAll(".", "")
        : "0";
    String priceinclude = hrgpenawaran.join("*_*_*").toString();
    String itemprice = checkBoxAsuransiBarang.value
        ? nilaiBarang.value.text == ""
            ? "0"
            : nilaiBarang.value.text.replaceAll(".", "")
        : "0";
    String handlingloadingprice = tmpMuat.join("*_*_*");
    String handlingunloadingprice = tmpBongkar.join("*_*_*");
    String paymentterm = terminPembayaran.value ==
            "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture".tr
        ? terminBerjangka.join("*_*_*").toString()
        : terminPembayaran.value ==
                "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr
            ? terminLainLain.join("*_*_*").toString()
            : terminPembayaran.value;
    String provincepickup = radioButtonSatuMultipleLokasi.value ==
            "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr
        ? provinceId.value
        : provinceIdList[0].text;
    String provincedestination = radioButtonSatuMultipleLokasiDestinasi.value ==
            "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr
        ? provinceIdDestinasi.value
        : provinceIdListDestinasi[0].text;
    String citypickup = radioButtonSatuMultipleLokasi.value ==
            "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr
        ? locationResultMap.value["city"] ?? ""
        : city[0].text;
    String citydestination = radioButtonSatuMultipleLokasiDestinasi.value ==
            "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr
        ? locationResultMapDestinasi.value["city"] ?? ""
        : cityDestinasi[0].text;
    String notes = catatanTambahan.value.text;
    List location = listLocation;
    // };

    saveLelangBuatan(
        roleProfile,
        loginas,
        shippercode,
        shipperemail,
        shippername,
        shipperavatar,
        shippertimezone,
        startdate,
        enddate,
        bidtype,
        truckqty,
        truckpicture,
        headid,
        headname,
        carrierid,
        carriername,
        truckid,
        cargo,
        idcargotype,
        weight,
        volumePar,
        dimension,
        koliqty,
        pickuptype,
        pickupeta,
        pickupetatimezone,
        destinationtype,
        destinationeta,
        destinationetatimezone,
        maxprice,
        priceinclude,
        itemprice,
        handlingloadingprice,
        handlingunloadingprice,
        paymentterm,
        provincepickup,
        provincedestination,
        citypickup,
        citydestination,
        notes,
        location);
  }

  toMapPinSelectPickup() async {
    var result = await GetToPage.toNamed<ZoMapSelectController>(
        Routes.ZO_MAP_SELECT,
        arguments: {
          ZoMapSelectController.latLngKey: currentLocation.value,
          ZoMapSelectController.imageMarkerKey: SvgPicture.asset(
            "assets/pin7.svg",
            width: GlobalVariable.ratioFontSize(Get.context) * 26.27,
            height: GlobalVariable.ratioFontSize(Get.context) * 34,
          ),
          ZoMapSelectController.addressKey: ""
        });
    if (result != null) {
      alamatSatuan.value.text = result[1];
      locationResultMap.value["lng"] = result[0].longitude;
      locationResultMap.value["lat"] = result[0].latitude;
      locationResultMap.value["city"] = result[3];

      getProvinceFilter(result[2], null);

      currentLocation.value = LatLng(result[0].latitude, result[0].longitude);
      mapController.onReady.then((value) {
        mapController.move(LatLng(result[0].latitude, result[0].longitude),
            GlobalVariable.zoomMap);
      });
    }
  }

  void toMapFullScreenTambahPickup() async {
    var result = await GetToPage.toNamed<ZoMapFullScreenTambahController>(
        Routes.ZO_MAP_FULL_SCREEN_TAMBAH,
        arguments: {
          ZoMapFullScreenTambahController.latLngKey: currentLocation.value,
          // ZoMapFullScreenTambahController.imageMarkerKey: SvgPicture.asset(
          //   "assets/pin_truck_icon.svg",
          //   width: GlobalVariable.ratioWidth(Get.context) * 24,
          //   height: GlobalVariable.ratioWidth(Get.context) * 24,
          // ),
          ZoMapFullScreenTambahController.addressKey: "",
          ZoMapFullScreenTambahController.listCurLok:
              List.from(listCurentLocation),
          ZoMapFullScreenTambahController.typePickupDestinasi: "pickup",
          ZoMapFullScreenTambahController.latLngKeyList: alamatMulti,
          ZoMapFullScreenTambahController.latLngList: currentLocationList,
          ZoMapFullScreenTambahController.kotaListPar: city,
          ZoMapFullScreenTambahController.provinsiListPar: provinsiMulti
        });
    if (result != null) {
      // if (result["ltlg"].length > 1) {
      for (var idx = 0; idx < result["ltlg"].length; idx++) {
        alamatMulti[idx].text = result["address"][idx];
        if (result["ltlg"][idx] != "") {
          lat[idx].text = result["ltlg"][idx].latitude.toString();
          lng[idx].text = result["ltlg"][idx].longitude.toString();
        } else {
          lat[idx].text = "0";
          lng[idx].text = "0";
        }

        city[idx].text = result["kota"][idx];
        // getProvinceFilter(result["provinsi"][idx], idx);
        // if () {
        if (result["placeId"][idx] != "0") {
          if (result["placeId"][idx] != "") {
            getLokasiDetail(result["placeId"][idx], idx);
          } else {
            provinsiMulti[idx].text = "";
            provinceIdList[idx].text = "";
          }
        } else {
          if (result["provinsi"][idx] != "") {
            var pro = "";
            if (result["provinsi"][idx] == "Daerah Khusus Ibukota Jakarta") {
              pro = "Dki Jakarta";
            } else {
              pro = result["provinsi"][idx];
            }
            getProvinceFilter(pro, idx);
          } else {
            provinsiMulti[idx].text = "";
            provinceIdList[idx].text = "";
          }
        }

        // } else {
        // provinsiMulti[idx].text = "";
        // provinceIdList[idx].text = "";
        // }

        currentLocation.value =
            LatLng(result["ltlg"][0].latitude, result["ltlg"][0].longitude);
        currentLocationList[idx] =
            LatLng(result["ltlg"][idx].latitude, result["ltlg"][idx].longitude);
        mapController.onReady.then((value) {
          mapController.move(
              LatLng(result["ltlg"][0].latitude, result["ltlg"][0].longitude),
              8);
        });
      }
      // } else {
      //   alamatSatuan.value.text = result["address"][0];
      //   locationResultMap.value["lng"] = result["ltlg"][0].longitude;
      //   locationResultMap.value["lat"] = result["ltlg"][0].latitude;
      // }

      // _getDataInfoFromAddressPlaceID(
      //     address: result[1], latLngParam: result[0]);
    }
  }

  toMapPinSelectDestinasi() async {
    var result = await GetToPage.toNamed<ZoMapSelectController>(
        Routes.ZO_MAP_SELECT,
        arguments: {
          ZoMapSelectController.latLngKey: currentLocationDestinasi.value,
          ZoMapSelectController.imageMarkerKey: SvgPicture.asset(
            "assets/pin7.svg",
            width: GlobalVariable.ratioFontSize(Get.context) * 26.27,
            height: GlobalVariable.ratioFontSize(Get.context) * 34,
          ),
          ZoMapSelectController.addressKey: ""
        });
    if (result != null) {
      alamatSatuanDestinasi.value.text = result[1];
      locationResultMapDestinasi.value["lng"] = result[0].longitude;
      locationResultMapDestinasi.value["lat"] = result[0].latitude;
      locationResultMapDestinasi.value["city"] = result[3];

      getProvinceFilterDestinasi(result[2], null);

      currentLocationDestinasi.value =
          LatLng(result[0].latitude, result[0].longitude);
      mapControllerDestinasi.onReady.then((value) {
        mapControllerDestinasi.move(
            LatLng(result[0].latitude, result[0].longitude),
            GlobalVariable.zoomMap);
      });
    }
  }

  void toMapFullScreenTambahDestinasi() async {
    var result = await GetToPage.toNamed<ZoMapFullScreenTambahController>(
        Routes.ZO_MAP_FULL_SCREEN_TAMBAH,
        arguments: {
          ZoMapFullScreenTambahController.latLngKey:
              currentLocationDestinasi.value,
          // ZoMapFullScreenTambahController.imageMarkerKey: SvgPicture.asset(
          //   "assets/pin_truck_icon.svg",
          //   width: GlobalVariable.ratioWidth(Get.context) * 24,
          //   height: GlobalVariable.ratioWidth(Get.context) * 24,
          // ),
          ZoMapFullScreenTambahController.addressKey: "",
          ZoMapFullScreenTambahController.listCurLok:
              List.from(listCurentLocationDestinasi),
          ZoMapFullScreenTambahController.typePickupDestinasi: "destinasi",
          ZoMapFullScreenTambahController.latLngKeyList: alamatMultiDestinasi,
          ZoMapFullScreenTambahController.latLngList:
              currentLocationDestinasiList,
          ZoMapFullScreenTambahController.kotaListPar: cityDestinasi,
          ZoMapFullScreenTambahController.provinsiListPar:
              provinsiMultiDestinasi
        });
    if (result != null) {
      // if (result["ltlg"].length > 1) {
      for (var idx = 0; idx < result["ltlg"].length; idx++) {
        alamatMultiDestinasi[idx].text = result["address"][idx];
        if (result["ltlg"][idx] != "") {
          latDestinasi[idx].text = result["ltlg"][idx].latitude.toString();
          lngDestinasi[idx].text = result["ltlg"][idx].longitude.toString();
        } else {
          latDestinasi[idx].text = "0";
          lngDestinasi[idx].text = "0";
        }
        cityDestinasi[idx].text = result["kota"][idx];

        // getProvinceFilterDestinasi(result["provinsi"][idx], idx);

        if (result["placeId"][idx] != "0") {
          if (result["placeId"][idx] != "") {
            getLokasiDetailDestinasi(result["placeId"][idx], idx);
          } else {
            provinsiMultiDestinasi[idx].text = "";
            provinceIdListDestinasi[idx].text = "";
          }
        } else {
          if (result["provinsi"][idx] != "") {
            var pro = "";
            if (result["provinsi"][idx] == "Daerah Khusus Ibukota Jakarta") {
              pro = "Dki Jakarta";
            } else {
              pro = result["provinsi"][idx];
            }
            getProvinceFilterDestinasi(pro, idx);
          } else {
            provinsiMultiDestinasi[idx].text = "";
            provinceIdListDestinasi[idx].text = "";
          }
        }

        currentLocationDestinasi.value =
            LatLng(result["ltlg"][0].latitude, result["ltlg"][0].longitude);
        currentLocationDestinasiList[idx] =
            LatLng(result["ltlg"][idx].latitude, result["ltlg"][idx].longitude);
        mapControllerDestinasi.onReady.then((value) {
          mapControllerDestinasi.move(
              LatLng(result["ltlg"][0].latitude, result["ltlg"][0].longitude),
              8);
        });
      }
      // } else {
      //   alamatSatuanDestinasi.value.text = result["address"][0];
      //   locationResultMapDestinasi.value["lng"] = result["ltlg"][0].longitude;
      //   locationResultMapDestinasi.value["lat"] = result["ltlg"][0].latitude;
      // }

      // _getDataInfoFromAddressPlaceID(
      //     address: result[1], latLngParam: result[0]);
    }
  }
}
