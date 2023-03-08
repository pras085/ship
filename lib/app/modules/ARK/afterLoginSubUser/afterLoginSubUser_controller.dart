import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/buyer/halaman_awal/halaman_awal_view.dart';
import 'package:muatmuat/app/modules/home/home/home/menu_horizontal_scroll1_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet3/bigfleets3_controller.dart';
import 'package:muatmuat/app/modules/login/login_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:muatmuat/app/network/api_helper.dart' as apiInternal;

class AfterLoginSubUserController extends GetxController {
  var login = false; //Sudah Login Atau Belum
  //TODO: Implement BigfleetsController

  List<String> imgList = [];
  var transporationStoreList = [].obs;
  var dealerKaroseriList = [].obs;
  var repairMaintenanceList = [].obs;
  var propertyWarehouseList = [].obs;

  // final listLogisticMenu = [].obs;

  var imageSliders = [].obs;
  var loading = true.obs;
  var newNotif = false.obs;

  final indexImageSlider = 0.obs;
  String bellIcon = GlobalVariable.imagePath + "icon bell-red.svg";
  String namaUser = GlobalVariable.userModelGlobal.name;
  String salam = "";

  var listWidgetLogistic = <Widget>[].obs;
  var listWidgetSupport = <Widget>[].obs;
  final double _spaceMenu = GlobalVariable.ratioWidth(Get.context) * 20;
  var listArticle = [].obs;

  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) =>
      _getWidthOfScreen(context) < _getHeightOfScreen(context)
          ? _getWidthOfScreen(context)
          : _getHeightOfScreen(context);
  double _marginHorizontal() => _spaceMenu * 2;
  double _widthContainer(BuildContext context) =>
      _getSizeSmallestWidthHeight(context) - 32;
  double _widthPerMenu(BuildContext context) =>
      (_widthContainer(context) - _marginHorizontal()) / 3;
  double _heightPerMenu(BuildContext context) =>
      (_widthPerMenu(context) * 1.17).roundToDouble();
  double _sizeTextMenu(BuildContext context) => _heightPerMenu(context) / 11.2;
  double _sizeIconMenu(BuildContext context) => _widthPerMenu(context) / 1.5;
  bool onCompleted = false;

  @override
  void onInit() async {
    // print(Get.parameters);
    // // login = Get.arguments[0];
    // login = true;
    // print(login);

    // await reset();
  }

  void firstInit() async {
    if (!onCompleted) { 
      onCompleted = true;
      print(Get.parameters);
      // login = Get.arguments[0];
      login = true;
      print(login);

      await reset();
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() async {
    print('LOGIN : ' + login.toString());
  }

  void reset() async {
     loading.value = true;
    imgList.clear();
    transporationStoreList.clear();
    dealerKaroseriList.clear();
    repairMaintenanceList.clear();
    propertyWarehouseList.clear();
    imageSliders.clear();
    listWidgetLogistic.clear();
    listWidgetSupport.clear();
    listArticle.clear();
    
    if (login) {
      var dataUser = await GlobalVariable.getStatusUser(Get.context);
      GlobalVariable.subUser = dataUser['IsSubUser'] == 1 ? true : false;
      if (GlobalVariable.role == "2") {
        SharedPreferencesHelper.setUserShipperID(
            dataUser['ShipperID'].toString());
      } else if (GlobalVariable.role == "4") {
        SharedPreferencesHelper.setUserTransporterID(
            dataUser['TransporterID'].toString());
      }
    }
    // print('TES');
    var hour = DateTime.now().hour;
    if (hour >= 4 && hour < 12) {
      salam = "ManajemenUserLandingPageSelamatPagi".tr;
    } else if (hour >= 12 && hour < 18) {
      salam = "ManajemenUserLandingPageSelamatSiang".tr;
    } else if (hour >= 18 && hour <= 24 || hour >= 0 && hour < 4) {
      salam = "ManajemenUserLandingPageSelamatMalam".tr;
    }

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getMenuAvailable();

    if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      print(data);
      var arrayLogistik =
          data.where((element) => element['IsPro'] == true).toList();
      for (var x = 0; x < arrayLogistik.length; x++) {
        listWidgetLogistic.add(menuWidget(arrayLogistik, x));
      }

      var arrayKebutuhan =
          data.where((element) => element['IsPro'] == false).toList();

      for (var x = 0; x < arrayKebutuhan.length; x++) {
        listWidgetSupport.add(menuWidget(arrayKebutuhan, x));
      }

      listWidgetSupport.refresh();
      listWidgetLogistic.refresh();
    }

    // await getTransportationStore();
    // await getDealerKaroseri();
    // await getRepairMaintanance();
    // await getPropertyWarehouse();

    await getDataArticle();
    await getNotif();
    await getDataCarousel();
    imageSliders.value = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 6,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(Get.context).size.width,
                        ),
                        // Image(
                        //   image: AssetImage(GlobalVariable.imagePath+"" + item),
                        //   width: MediaQuery.of(Get.context).size.width,
                        //   fit: BoxFit.cover,
                        // ),
                        // Positioned(
                        //   bottom: 0.0,
                        //   left: 0.0,
                        //   right: 0.0,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Color.fromARGB(200, 0, 0, 0),
                        //           Color.fromARGB(0, 0, 0, 0)
                        //         ],
                        //         begin: Alignment.bottomCenter,
                        //         end: Alignment.topCenter,
                        //       ),
                        //     ),
                        //     // padding: EdgeInsets.symmetric(
                        //     //     vertical: 10.0, horizontal: 20.0),
                        //   ),
                        // ),
                      ],
                    )),
              ),
            ))
        .toList();
        await Utils.initDynamicLinks();
    loading.value = false;
  }

  void setFavourite(int index, String jenis) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        });

    String idKategori = "";
    String idSubKategori = "";
    String idIklan = "";
    String isWishList = "";
    if (jenis == "TRANSPORTATION_STORE") {
      idKategori = transporationStoreList[index]['KategoriID'].toString();
      idSubKategori = transporationStoreList[index]['SubKategoriID'].toString();
      idIklan = transporationStoreList[index]['ID'].toString();
      isWishList = transporationStoreList[index]['favorit'].toString();
      if (isWishList == "0") {
        isWishList = "1";
      } else {
        isWishList = "0";
      }
    } else if (jenis == "DEALER_KAROSERI") {
      idKategori = dealerKaroseriList[index]['KategoriID'].toString();
      idSubKategori = dealerKaroseriList[index]['SubKategoriID'].toString();
      idIklan = dealerKaroseriList[index]['ID'].toString();
      isWishList = dealerKaroseriList[index]['favorit'].toString();
      if (isWishList == "0") {
        isWishList = "1";
      } else {
        isWishList = "0";
      }
    } else if (jenis == "REPAIR_MAINTENANCE") {
      idKategori = repairMaintenanceList[index]['KategoriID'].toString();
      idSubKategori = repairMaintenanceList[index]['SubKategoriID'].toString();
      idIklan = repairMaintenanceList[index]['ID'].toString();
      isWishList = repairMaintenanceList[index]['favorit'].toString();
      if (isWishList == "0") {
        isWishList = "1";
      } else {
        isWishList = "0";
      }
    } else if (jenis == "PROPERTY_WAREHOUSE") {
      idKategori = propertyWarehouseList[index]['KategoriID'].toString();
      idSubKategori = propertyWarehouseList[index]['SubKategoriID'].toString();
      idIklan = propertyWarehouseList[index]['ID'].toString();
      isWishList = propertyWarehouseList[index]['favorit'].toString();
      if (isWishList == "0") {
        isWishList = "1";
      } else {
        isWishList = "0";
      }
    }

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .setFavourite(idKategori, idSubKategori, idIklan, isWishList);

    if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
      Get.back();
      var data = result['Data'];
      if (jenis == "TRANSPORTATION_STORE") {
        transporationStoreList[index]['favorit'] = isWishList;
      } else if (jenis == "DEALER_KAROSERI") {
        dealerKaroseriList[index]['favorit'] = isWishList;
      } else if (jenis == "REPAIR_MAINTENANCE") {
        repairMaintenanceList[index]['favorit'] = isWishList;
      } else if (jenis == "PROPERTY_WAREHOUSE") {
        propertyWarehouseList[index]['favorit'] = isWishList;
      }
    }
    transporationStoreList.refresh();
    dealerKaroseriList.refresh();
    repairMaintenanceList.refresh();
    propertyWarehouseList.refresh();
  }

  // Future getTransportationStore() async {
  //   loading.value = true;
  //   var result = await ApiHelper(
  //           context: Get.context,
  //           isShowDialogLoading: false,
  //           isShowDialogError: false)
  //       .getListBuyer("transportation store", 21, login);

  //   if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
  //     var data = result['Data'];
  //     for (int i = 0; i < data.length; i++) {
  //       var gambar = "";
  //       if (data[i]['Foto'].length > 0) {
  //         if (data[i]['Foto'][0] != null) {
  //           String tipe = GlobalVariable.cekFotoOrVideo(data[i]['Foto'][0]);
  //           if (tipe == "video") {
  //             var namaFile = data[i]['Foto'][0].split("/").last.split(".")[0];
  //             var savedLocation = (await getTemporaryDirectory()).path +
  //                 "/" +
  //                 namaFile +
  //                 ".png";

  //             var existed = await File(savedLocation).exists();

  //             if (!existed) {
  //               gambar = await VideoThumbnail.thumbnailFile(
  //                 video: data[i]['Foto'][0],
  //                 imageFormat: ImageFormat.PNG,
  //                 maxHeight:
  //                     (GlobalVariable.ratioWidth(Get.context) * 224).toInt(),
  //                 quality: 50,
  //               );
  //             } else {
  //               gambar = savedLocation;
  //             }
  //           } else if (tipe == "image") {
  //             gambar = data[i]['Foto'][0];
  //           }
  //         }
  //       }

  //       data[i]["gambar"] = gambar;

  //       data[i]['detail'] = {
  //         "ManajemenUserLandingPageKondisi".tr: data[i]['Kondisi'],
  //         "ManajemenUserLandingPageTahunProduksi".tr: data[i]['TahunKendaraan'],
  //       };

  //       transporationStoreList.add(data[i]);
  //     }
  //   }
  //   transporationStoreList.refresh();
  //   loading.value = false;
  // }

  //update internal
  Future getTransportationStore() async {
    // loading.value = true;
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListBuyer("transportation store", 21, login);

    if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (int i = 0; i < data.length; i++) {
        var thumbs = data[i]['Foto'] ?? data[i]['fotovideo'];
        var gambar = "";
        if (thumbs is List && thumbs.length > 0) {
          String tipe = GlobalVariable.cekFotoOrVideo(thumbs[0] ?? '');
          if (tipe == "video") {
            var namaFile = (thumbs[0] ?? '').split("/").last.split(".")[0];
            var savedLocation = (await getTemporaryDirectory()).path +
                "/" +
                namaFile +
                ".png";

            var existed = await File(savedLocation).exists();

            if (!existed) {
              gambar = await VideoThumbnail.thumbnailFile(
                video: thumbs[0] ?? '',
                imageFormat: ImageFormat.PNG,
                maxHeight:
                    (GlobalVariable.ratioWidth(Get.context) * 224).toInt(),
                quality: 50,
              );
            } else {
              gambar = savedLocation;
            }
          } else if (tipe == "image") {
            gambar = thumbs[0] ?? '';
          }
        }

        data[i]["gambar"] = gambar;

        data[i]['detail'] = {
          "ManajemenUserLandingPageKondisi".tr: data[i]['Kondisi'],
          "ManajemenUserLandingPageTahunProduksi".tr: data[i]['TahunKendaraan'],
        };

        transporationStoreList.add(data[i]);
      }
    }
    transporationStoreList.refresh();
    // loading.value = false;
  }

  Future getDealerKaroseri() async {
    // loading.value = true;
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListBuyer("dealer & karoseri", 21, login);

    if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (int i = 0; i < data.length; i++) {
        var gambar = "";
        if (data[i]['Foto'].length > 0) {
          if (data[i]['Foto'][0]['Foto_image'] != null) {
            String tipe =
                GlobalVariable.cekFotoOrVideo(data[i]['Foto'][0]['Foto_image']);
            if (tipe == "video") {
              var namaFile = data[i]['Foto'][0]['Foto_image']
                  .split("/")
                  .last
                  .split(".")[0];
              var savedLocation = (await getTemporaryDirectory()).path +
                  "/" +
                  namaFile +
                  ".png";

              var existed = await File(savedLocation).exists();

              if (!existed) {
                gambar = await VideoThumbnail.thumbnailFile(
                  video: data[i]['Foto'][0]['Foto_image'],
                  imageFormat: ImageFormat.PNG,
                  maxHeight:
                      (GlobalVariable.ratioWidth(Get.context) * 224).toInt(),
                  quality: 50,
                );
              } else {
                gambar = savedLocation;
              }
            } else if (tipe == "image") {
              gambar = data[i]['Foto'][0]['Foto_image'];
            }
          }
        }

        data[i]["gambar"] = gambar;

        data[i]['detail'] = {
          "ManajemenUserLandingPageJenis".tr: data[i]['JenisTruk'],
          "ManajemenUserLandingPageEngine".tr: data[i]['Engine'],
          "ManajemenUserLandingPageVolEngine".tr: data[i]['VolEngine'],
          "ManajemenUserLandingPageOutputHP".tr: data[i]['OutputHP'],
          "ManajemenUserLandingPageTahun".tr: data[i]['TahunPembuatan_'],
          "ManajemenUserLandingPageMaxGVW".tr: data[i]['MaxGVW'],
        };

        dealerKaroseriList.add(data[i]);
      }
    }
    dealerKaroseriList.refresh();
    // loading.value = false;
  }

  Future getRepairMaintanance() async {
    // loading.value = true;
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListBuyer("Repair & Maintenance Services", 3, login);

    if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (int i = 0; i < data.length; i++) {
        var gambar = data[i]['data_seller']['image_seller'];

        data[i]["gambar"] = gambar;

        data[i]['detail'] = {
          "ManajemenUserLandingPageTipeLayanan".tr: data[i]['TipeLayanan']
              .replaceAll('\'', '')
              .replaceAll('\\', '')
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll('\"', ''),
          "ManajemenUserLandingPageMerkYangDilayani".tr: data[i]
              ['MerkYangDilayani'],
          "ManajemenUserLandingPageTahunBerdiri".tr: data[i]['TahunBerdiri'],
        };

        repairMaintenanceList.add(data[i]);
      }
    }
    repairMaintenanceList.refresh();
    // loading.value = false;
  }

  Future getPropertyWarehouse() async {
    // loading.value = true;
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListBuyer("property & warehouse", 21, login);

    if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (int i = 0; i < data.length; i++) {
        var gambar = "";
        if (data[i]['Foto'].length > 0) {
          if (data[i]['Foto'][0] != null) {
            String tipe = GlobalVariable.cekFotoOrVideo(data[i]['Foto'][0]);
            if (tipe == "video") {
              var namaFile = data[i]['Foto'][0].split("/").last.split(".")[0];
              var savedLocation = (await getTemporaryDirectory()).path +
                  "/" +
                  namaFile +
                  ".png";

              var existed = await File(savedLocation).exists();

              if (!existed) {
                gambar = await VideoThumbnail.thumbnailFile(
                  video: data[i]['Foto'][0],
                  imageFormat: ImageFormat.PNG,
                  maxHeight:
                      (GlobalVariable.ratioWidth(Get.context) * 224).toInt(),
                  quality: 50,
                );
              } else {
                gambar = savedLocation;
              }
            } else if (tipe == "image") {
              gambar = data[i]['Foto'][0];
            }
          }
        }

        data[i]["gambar"] = gambar;

        data[i]['detail'] = {
          "ManajemenUserLandingPageLB".tr: data[i]['LuasBangunan'],
          "ManajemenUserLandingPageLT".tr: data[i]['LuasTanah'],
          "ManajemenUserLandingPageDaya".tr: data[i]['DayaListrik'],
          "ManajemenUserLandingPageLebarJalan".tr: data[i]['LebarJalan'],
        };

        propertyWarehouseList.add(data[i]);
      }
    }
    propertyWarehouseList.refresh();
    // loading.value = false;
  }

  Future getDataCarousel() async {
    // loading.value = true;
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDataCarousel();

    if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (int i = 0; i < data.length; i++) {
        imgList.add(data[i]["Image"]);
      }
    }
    // loading.value = false;
  }

  Future getDataArticle() async {
    // loading.value = true;
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDataArticle("2");

    if (result != null && result['Message'] != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      listArticle.addAll(data);
      // for (int i = 0; i < data.length; i++) {
      //   imgList.add(data[i]["image"]);
      // }
    }
    // loading.value = false;
  }

  Future getNotif() async {
    var result = await apiInternal.ApiHelper(
      context: Get.context,
      isShowDialogLoading: false,
      isShowDialogError: false
    ).getListNotifAll();

    if (result['Message']['Code'].toString() == '200') {
      newNotif.value = result['SupportingData']['NotReadCount'] > 0;
    }
  }

  Widget menuWidget(data, x) {
    return Expanded(
        child: GestureDetector(
            onTap: () async {
              // UPDATE INTERNAL START
              if (data[x]['ID'] == 1 && data[x]['IsPro']) {
                if (login) {
                  showDialog(
                  context: Get.context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  });
                  var dataUser =
                      await GlobalVariable.getStatusUser(Get.context);
                  Get.back();

                  //JIKA USER (BUKAN SUB USER)
                  if (!GlobalVariable.subUser) {
                    if ((GlobalVariable.role == "2" &&
                            dataUser['ShipperIsVerifBF'] == 1) ||
                        (GlobalVariable.role == "4" &&
                            dataUser['TransporterIsVerifBF'] == 1)) {
                      print('MASUK');
                      // change page by refo intern
                      // Get.toNamed(Routes.BIGFLEETS2);
                      GetToPage.toNamed<Bigfleets3Controller>(Routes.BIGFLEETS3,);
                    } else {
                      print('DAFTAR');
                      Get.toNamed(Routes.SELAMAT_DATANG, arguments: [
                        'BIGFLEET',
                        (GlobalVariable.role == "2" ? "SHIPPER" : "TRANSPORTER")
                      ]);
                    }
                  } else {
                    if ((GlobalVariable.role == "2" &&
                            dataUser['ShipperIsVerifBF'] == 1) ||
                        (GlobalVariable.role == "4" &&
                            dataUser['TransporterIsVerifBF'] == 1)) {
                      print('MASUK');
                      // change page by refo intern
                      // Get.toNamed(Routes.BIGFLEETS2);
                      GetToPage.toNamed<Bigfleets3Controller>(Routes.BIGFLEETS3,);
                    } else {
                      showDialogAkses('ManajemenUserLandingPageBigFleets'.tr);
                    }
                  }
                } else {
                  Get.back();
                  popUpDaftar();
                }
              } else if (data[x]['ID'] == 2 && data[x]['IsPro']) {
                if (login) {
                  showDialog(
                  context: Get.context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  });
                  var dataUser =
                      await GlobalVariable.getStatusUser(Get.context);
                  Get.back();

                  if (!GlobalVariable.subUser) {
                    if ((GlobalVariable.role == "2" &&
                            dataUser['ShipperIsVerifTM'] == 1) ||
                        (GlobalVariable.role == "4" &&
                            dataUser['TransporterIsVerifTM'] == 1)) {
                      print('MASUK');
                      Get.toNamed(Routes.TRANSPORT_MARKET);
                    } else {
                      print('DAFTAR');
                      Get.toNamed(Routes.SELAMAT_DATANG, arguments: [
                        'TRANSPORTMARKET',
                        (GlobalVariable.role == "2" ? "SHIPPER" : "TRANSPORTER")
                      ]);
                    }
                  } else {
                    if ((GlobalVariable.role == "2" &&
                            dataUser['ShipperIsVerifTM'] == 1) ||
                        (GlobalVariable.role == "4" &&
                            dataUser['TransporterIsVerifTM'] == 1)) {
                      Get.toNamed(Routes.TRANSPORT_MARKET);
                    } else {
                      showDialogAkses(
                          'ManajemenUserLandingPageTransportMarket'.tr);
                    }
                  }
                } else {
                  Get.back();
                  popUpDaftar();
                }
          }
          else if (data[x]['ID'] == 89) { // Transportation Store
            Get.to(HalamanAwalView(),
              arguments: BuyerArgs(
                id: 4,
                menuName: data[x]['Title']
              ),
            );
          }
          else if (data[x]['ID'] == 95) { // Dealer & Karoseri
            Get.to(HalamanAwalView(),
              arguments: BuyerArgs(
                id: 8,
                menuName: data[x]['Title']
              ),
            );
          }
          else if (data[x]['ID'] == 104) { // Repair & Maintenance
            Get.to(HalamanAwalView(),
              arguments: BuyerArgs(
                id: 5,
                menuName: data[x]['Title']
              ),
            );
          }
          else if (data[x]['ID'] == 107) { // Human Capital
            Get.to(HalamanAwalView(),
              arguments: BuyerArgs(
                id: 9,
                menuName: data[x]['Title']
              ),
            );
          }
          else if (data[x]['ID'] == 108) { // Places & Promo
            Get.to(HalamanAwalView(),
              arguments: BuyerArgs(
                id: 10,
                menuName: data[x]['Title']
              ),
            );
          }
          else if (data[x]['ID'] == 98) { // Property & Warehouse
            Get.to(HalamanAwalView(),
              arguments: BuyerArgs(
                id: 6,
                menuName: data[x]['Title']
              ),
            );
          }
          else if (data[x]['ID'] == 109) { // Transportasi Intermoda
            Get.to(HalamanAwalView(),
              arguments: BuyerArgs(
                id: 7,
                menuName: data[x]['Title']
              ),
            );
          }
          else {
                Get.back();
                popUpList();
              }
              // UPDATE INTERNAL DONE
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 10),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 6)),
              ),
              padding: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 16,
                bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                left: GlobalVariable.ratioWidth(Get.context) * 12,
                right: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    child: data[x]['Icon'] != null
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: data[x]['Icon'],
                            imageBuilder: (context, imageProvider) => Container(
                              width: double.infinity,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 48,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: GlobalVariable.ratioWidth(Get.context) * 48,
                          ),
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(Get.context) * 12,
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: GlobalVariable.ratioWidth(Get.context) * 28,
                      child: CustomText(
                        data[x]['Title'],
                        fontSize: 10,
                        maxLines: 2,
                        wrapSpace: true,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            )));
  }

  void showDialogAkses(String namaMenu) {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 32,
                  right: GlobalVariable.ratioWidth(Get.context) * 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Stack(children: [
                        Positioned(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "ManajemenUserLandingPageWarningAccess1"
                                                  .tr,
                                          style: TextStyle(
                                            fontFamily: "AvenirNext",
                                            fontWeight: FontWeight.w500,
                                            height: 1.4,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " " + namaMenu,
                                          style: TextStyle(
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    14,
                                            fontFamily: "AvenirNext",
                                            fontWeight: FontWeight.w700,
                                            height: 1.4,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "ManajemenUserLandingPageWarningAccess2"
                                                  .tr,
                                          style: TextStyle(
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    14,
                                            fontFamily: "AvenirNext",
                                            fontWeight: FontWeight.w500,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                          right: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                              child: GestureDetector(
                                                  child: SvgPicture.asset(
                                            GlobalVariable.imagePath +
                                                'ic_close_blue.svg',
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            color: Color(ListColor.color4),
                                          ))),
                                        ))
                                  ],
                                ))),
                      ])))));
        });
  }

  List<Widget> _createListMenu(
      List<MenuHorizontalScroll> listMenu, BuildContext context) {
    List<Widget> listWidget = [];
    for (MenuHorizontalScroll data in listMenu) {
      listWidget.add(Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(0, 7),
            ),
          ],
        ),
        height: _heightPerMenu(context),
        width: _widthPerMenu(context),
        child: Material(
          borderRadius:
              BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 10),
            ),
            onTap: data.onPress != null ? data.onPress : () => print("null"),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 10),
              ),
              padding: EdgeInsets.all(9),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Image(
                          image: AssetImage(
                              GlobalVariable.imagePath + "" + data.urlIcon),
                          width: _sizeIconMenu(context),
                          height: _sizeIconMenu(context),
                          fit: BoxFit.fitWidth,
                        ),
                      ]),
                    ),
                    Stack(alignment: Alignment.center, children: [
                      CustomText(
                        "\n",
                        textAlign: TextAlign.center,
                        color: Colors.transparent,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        data.title,
                        textAlign: TextAlign.center,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ])
                  ]),
            ),
          ),
        ),
      ));
    }
    return listWidget;
  }

  void openOtherApps() async {
    OpenAppstore.launch(androidAppId: "com.miHoYo.GenshinImpact", iOSAppId: "");
  }

  void popUpDaftar() {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 32),
                          Expanded(
                            // margin: EdgeInsets.only(
                            //   top: GlobalVariable.ratioWidth(Get.context) *
                            //       24,
                            // ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            "ManajemenUserLandingPageSilahkanMasuk"
                                                .tr,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            height: 1.5,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                          Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                Container(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          100,
                                                  child: MaterialButton(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            22,
                                                        vertical: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8),
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .all(Radius.circular(
                                                                GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    20)),
                                                        side: BorderSide(
                                                            color: Color(
                                                                ListColor
                                                                    .color4))),
                                                    color:
                                                        Color(ListColor.color4),
                                                    onPressed: () {
                                                      Get.back();
                                                      GetToPage.toNamed<
                                                              LoginController>(
                                                          Routes.LOGIN);
                                                    },
                                                    child: CustomText(
                                                      "ManajemenUserLandingPageMasuk"
                                                          .tr, //Masuk
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                                Container(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        100,
                                                    child: MaterialButton(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              22,
                                                          vertical: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              8),
                                                      elevation: 0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          20)),
                                                          side: BorderSide(
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  1.5,
                                                              color: Color(
                                                                  ListColor
                                                                      .color4))),
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        Get.back();
                                                        GetToPage.toNamed<
                                                                RegisterUserController>(
                                                            Routes
                                                                .REGISTER_USER);
                                                      },
                                                      child: CustomText(
                                                        "ManajemenUserLandingPageDaftar"
                                                            .tr, // Daftar
                                                        color: Color(
                                                            ListColor.color4),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    )),
                                              ])),
                                          SizedBox(
                                              height:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24)
                                        ])),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))
                        ],
                      )))));
        });
  }

  void popUpList() {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 32),
                          Expanded(
                            // margin: EdgeInsets.only(
                            //   top: GlobalVariable.ratioWidth(Get.context) *
                            //       24,
                            // ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            "LIST".tr,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            height: 1.5,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                              height:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24)
                                        ])),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))
                        ],
                      )))));
        });
  }

  void popUpDetail(String jenis) {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 32),
                          Expanded(
                            // margin: EdgeInsets.only(
                            //   top: GlobalVariable.ratioWidth(Get.context) *
                            //       24,
                            // ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            jenis + " DETAIL".tr,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            height: 1.5,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                              height:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24)
                                        ])),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))
                        ],
                      )))));
        });
  }

  void popUpSeller() {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 32),
                          Expanded(
                            // margin: EdgeInsets.only(
                            //   top: GlobalVariable.ratioWidth(Get.context) *
                            //       24,
                            // ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            "SELLER",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            height: 1.5,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                              height:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24)
                                        ])),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))
                        ],
                      )))));
        });
  }

  void lainnya(String jenis) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 32),
                          Expanded(
                            // margin: EdgeInsets.only(
                            //   top: GlobalVariable.ratioWidth(Get.context) *
                            //       24,
                            // ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            jenis + "Lainnya".tr,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            height: 1.5,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                              height:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24)
                                        ])),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))
                        ],
                      )))));
        });
  }
}
