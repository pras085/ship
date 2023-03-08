import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/hasil_cari_harga_transport/hasil_cari_harga_transport_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/search_location_address/search_location_address_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_diumumkan_kepada/select_diumumkan_kepada_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_head_carrier/select_head_carrier_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

class CariHargaTransportController extends GetxController {
  List<String> imgList = [];

  var imageSliders = [].obs;

  final indexImageSlider = 0.obs;

  var loading = true.obs;
  var selectedPickup = {
    "ID": "",
    "Text": "",
    "District": "",
    "City": "",
    "DistrictID": "",
    "CityID": "",
  }.obs;
  var selectedDestinasi = {
    "ID": "",
    "Text": "",
    "District": "",
    "City": "",
    "DistrictID": "",
    "CityID": "",
  }.obs;
  var selectedJenisTruk = {
    "ID": 0,
    "Text": "",
  }.obs;
  var selectedJenisCarrier = {
    "ID": 0,
    "Text": "",
  }.obs;
  var selectedNamaTransport = {
    "ID": 0,
    "Text": "",
  }.obs;
  var urlGambarTrukCarrier = "".obs;
  var checkboxPromo = false.obs;
  var checkboxGoldTransporter = false.obs;
  var checkboxRegularTransporter = false.obs;
  var checkboxJumlahArmada =
      {"1-50": false, "51-100": false, "101-300": false, "300+": false}.obs;
  var showFirstTime = true.obs;
  var dataTransporter = [].obs;
  @override
  void onInit() async {
    await getBanner();
    showFirstTime.value =
        await SharedPreferencesHelper.getCariHargaTransportPertamaKali();
    super.onInit();
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void onSubmit() async {
    var result = await GetToPage.toNamed<HasilCariHargaTransportController>(
        Routes.HASIL_CARI_HARGA_TRANSPORT,
        arguments: [
          selectedPickup.value,
          selectedDestinasi.value,
          selectedJenisTruk.value,
          selectedJenisCarrier.value,
          selectedNamaTransport.value,
          checkboxPromo.value,
          checkboxGoldTransporter.value,
          checkboxRegularTransporter.value,
          checkboxJumlahArmada.value,
        ]);
    if (result != null) {}
  }

  void onResetTextbox(String menu) {
    print(menu);
    if (menu == "truk") {
      selectedJenisTruk.value = {
        "ID": 0,
        "Text": "",
      };
      selectedJenisCarrier.value = {
        "ID": 0,
        "Text": "",
      };
      urlGambarTrukCarrier.value = "";
    }
    if (menu == 'carrier') {
      selectedJenisCarrier.value = {
        "ID": 0,
        "Text": "",
      };
      urlGambarTrukCarrier.value = "";
    }
    if (menu == "transport") {
      selectedNamaTransport.value = {
        "ID": 0,
        "Text": "",
      };
    }
  }

  void onSelectPickup() async {
    var result = await GetToPage.toNamed<SearchLocationAddressController>(
        Routes.SEARCH_LOCATION_ADDRESS,
        arguments: ["CariHargaTransportIndexCariLokasiPickup".tr]);
    if (result != null) {
      print(result);
      selectedPickup['ID'] = result['ID'];
      selectedPickup['Text'] = result['Text'];
      selectedPickup['DistrictID'] = result['DistrictID'].toString();
      selectedPickup['District'] = result['District'];
      selectedPickup['CityID'] = result['CityID'].toString();
      selectedPickup['City'] = result['City'];
      selectedPickup.refresh();
      print(selectedPickup);
    }
  }

  void onSelectDestinasi() async {
    var result = await GetToPage.toNamed<SearchLocationAddressController>(
        Routes.SEARCH_LOCATION_ADDRESS,
        arguments: ["CariHargaTransportIndexCariLokasiDestinasi".tr]);
    if (result != null) {
      print(result);
      selectedDestinasi['ID'] = result['ID'];
      selectedDestinasi['Text'] = result['Text'];
      selectedDestinasi['District'] = result['District'];
      selectedDestinasi['City'] = result['City'];
      selectedDestinasi['DistrictID'] = result['DistrictID'].toString();
      selectedDestinasi['CityID'] = result['CityID'].toString();
      selectedDestinasi.refresh();
      print(selectedDestinasi);
    }
  }

  void switchLokasiPickupDestinasi() {
    String id = selectedDestinasi['ID'];
    String text = selectedDestinasi['Text'];
    String district = selectedDestinasi['District'];
    String districtID = selectedDestinasi['DistrictID'];
    String city = selectedDestinasi['City'];
    String cityID = selectedDestinasi['CityID'];
    print(text);
    selectedDestinasi['ID'] = selectedPickup['ID'];
    selectedDestinasi['Text'] = selectedPickup['Text'];
    selectedDestinasi['District'] = selectedPickup['District'];
    selectedDestinasi['City'] = selectedPickup['City'];
    selectedDestinasi['DistrictID'] = selectedPickup['DistrictID'];
    selectedDestinasi['CityID'] = selectedPickup['CityID'];
    selectedPickup['ID'] = id;
    selectedPickup['Text'] = text;
    selectedPickup['District'] = district;
    selectedPickup['City'] = city;
    selectedPickup['DistrictID'] = districtID;
    selectedPickup['CityID'] = cityID;
    selectedPickup.refresh();
    selectedDestinasi.refresh();
  }

  void onSelectJenisTruk() async {
    var result = await GetToPage.toNamed<SelectHeadCarrierController>(
        Routes.SELECT_HEAD_CARRIER_TRUCK,
        arguments: ['0', selectedJenisTruk['ID']]);
    if (result != null) {
      selectedJenisTruk['ID'] = result['ID'];
      selectedJenisTruk['Text'] = result['Description'];
      selectedJenisCarrier['ID'] = 0;
      selectedJenisCarrier['Text'] = "";
      selectedJenisTruk.refresh();
      selectedJenisCarrier.refresh();
      urlGambarTrukCarrier.value = "";
      print(selectedJenisTruk);
    }
  }

  void onSelectJenisCarrier() async {
    var result = await GetToPage.toNamed<SelectHeadCarrierController>(
        Routes.SELECT_HEAD_CARRIER_TRUCK,
        arguments: ['1', selectedJenisCarrier['ID'], selectedJenisTruk['ID']]);
    if (result != null) {
      selectedJenisCarrier['ID'] = result['ID'];
      selectedJenisCarrier['Text'] = result['Description'];
      selectedJenisCarrier.refresh();
      getDetailTruk();
    }
  }

  Future getDetailTruk() async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {},
              child: Center(child: CircularProgressIndicator()));
        });

    String shipperID = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getTruckDetail(selectedJenisTruk['ID'].toString(),
            selectedJenisCarrier['ID'].toString());

    if (result != null && result['Message']['Code'].toString() == '200') {
      Get.back(result: true);
      urlGambarTrukCarrier.value = result['Data']['TruckURL'];
    } else {
      Get.back(result: true);
    }
  }

  Future getTransporterList() async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {},
              child: Center(child: CircularProgressIndicator()));
        });

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getTransporterList();

    if (result != null && result['Message']['Code'].toString() == '200') {
      Get.back(result: true);
      var data = result["Data"];
      dataTransporter.clear();
      for (int i = 0; i < data.length; i++) {
        dataTransporter.add({
          "id": data[i]['TransporterID'],
          "nama": data[i]['Name'],
          "linkFoto": data[i]['Avatar'],
        });
      }
    } else {
      Get.back(result: true);
    }
  }

  void onSelectTransporter() async {
    if (dataTransporter.value.length <= 0) {
      await getTransporterList();
    }
    var result = await GetToPage.toNamed<SelectDiumumkanKepadaController>(
        Routes.SELECT_DIUMUMKAN_KEPADA,
        arguments: [
          dataTransporter.value,
          "CariHargaTransportIndexCariTransporter".tr
        ]);
    if (result != null) {
      // print(result);
      selectedNamaTransport['ID'] = result['id'];
      selectedNamaTransport['Text'] = result['nama'];
    }
  }

  void getBanner() async {
    String page = "HargaTransport";
    imgList.clear();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getBanner();

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'][page];
      (data as List).forEach((element) {
        imgList.add(element);
      });

      print(imgList.length.toString() + " Gambar");

      imageSliders.value = imgList
          .map((item) => Container(
                child: Container(
                  child: ClipRRect(
                      child: Stack(
                    children: <Widget>[
                      Image(
                        image: NetworkImage(item),
                        width: MediaQuery.of(Get.context).size.width,
                        height: GlobalVariable.ratioWidth(Get.context) * 156,
                        fit: BoxFit.contain,
                      ),
                    ],
                  )),
                ),
              ))
          .toList();
    }
  }
}
