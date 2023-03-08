import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

class ListHalamanPesertaDetailPenawaranController extends GetxController {
  var validasiSimpan = false;
  var form = GlobalKey<FormState>();
  var dataRute = [];
  var dataRuteTender = [].obs;
  var satuanTender = 0;
  var satuanVolume = '';
  var namaTransporter = '';
  var tanggalPenawaran = '';
  var idTender = '';
  var idTransporter = '';
  var link1 = "".obs;
  var nama_file1 = "".obs;
  var link2 = "".obs;
  var nama_file2 = "".obs;
  int fileke = 0;

  String filePath1 = "";
  String filePath2 = "";
  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onLoading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;

  @override
  void onInit() {
    super.onInit();
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);
    dataRute = Get.arguments[0];
    satuanTender = Get.arguments[1];
    satuanVolume = Get.arguments[2];
    namaTransporter = Get.arguments[3];
    tanggalPenawaran = Get.arguments[4];
    idTender = Get.arguments[5];
    idTransporter = Get.arguments[6];
    onLoading.value = true;
    getPenawaran();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    //FocusScope.of(Get.context).unfocus();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void getPenawaran() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getPenawaranTransporter(idTender, idTransporter);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      nama_file1.value = data['filename_dok1'];
      nama_file2.value = data['filename_dok2'] ?? "";
      link1.value = data['link_dok1'];
      link2.value = data['link_dok2'];

      var listTruk = [];
      for (var x = 0; x < dataRute.length; x++) {
        listTruk = [];
        for (var y = 0; y < dataRute[x]['data'].length; y++) {
          var penawaran = 0;

          for (var z = 0; z < data['penawaran'].length; z++) {
            // print(data['penawaran'][z]['pickup'] + " " + dataRute[x]['pickup']);
            // print(data['penawaran'][z]['destinasi'] +
            //     " " +
            //     dataRute[x]['destinasi']);
            // print(data['penawaran'][z]['trukStr'] +
            //     " " +
            //     dataRute[x]['data'][y]['nama_truk']);
            // print(data['penawaran'][z]['carrierStr'] +
            //     " " +
            //     dataRute[x]['data'][y]['nama_carrier']);

            if (data['penawaran'][z]['pickup'] == dataRute[x]['pickup'] &&
                data['penawaran'][z]['destinasi'] == dataRute[x]['destinasi'] &&
                data['penawaran'][z]['trukStr'] ==
                    dataRute[x]['data'][y]['nama_truk'] &&
                data['penawaran'][z]['carrierStr'] ==
                    dataRute[x]['data'][y]['nama_carrier']) {
              penawaran = data['penawaran'][z]['penawaran'];
            }
          }

          var dataDetail = {
            'jenis_truk': dataRute[x]['data'][y]['jenis_truk'],
            'nama_truk': dataRute[x]['data'][y]['nama_truk'],
            'jenis_carrier': dataRute[x]['data'][y]['jenis_carrier'],
            'nama_carrier': dataRute[x]['data'][y]['nama_carrier'],
            'nilai': dataRute[x]['data'][y]['nilai'],
            'penawaran': penawaran,
          };
          listTruk.add(dataDetail);
        }

        var dataHeader = {
          'pickup': dataRute[x]['pickup'],
          'destinasi': dataRute[x]['destinasi'],
          'data': listTruk,
        };

        dataRuteTender.add(dataHeader);
      }
      onLoading.value = false;
    }
  }

  void shareData(String link, bool usingBaseFileLink) async {
    var namaFile = GlobalVariable.formatNamaFile(link.split("/").last);

    var savedLocation = await _getLocalPath() + "/" + namaFile;
    print("Lokasi Save " + savedLocation);
    var existed = await File(savedLocation).exists();
    print("Exist " + existed.toString());
    //JIKA SUDAH PERNAH DIDOWNLOAD ARAHKAN KE LOCAL
    if (existed) {
      var status = await Permission.storage.request();
      print("Status " + status.toString());
      if (status.isGranted) {
        Share.shareFiles([savedLocation]);
      } else {
        print('Permission Denied!');
      }
    } else {
      //KARENA KETIKA DOWNLOAD, DAN TAP DOWNLOADNYA FALSE, DIA LANGSUNG SHARE
      if (fileke == 1) {
        filePath1 = savedLocation;
      } else if (fileke == 2) {
        filePath2 = savedLocation;
      }
      await download(link, namaFile, usingBaseFileLink);
    }
  }

  void lihat(String link, String fileNameDownload) async {
    var savedLocation = await _getLocalPath() + "/" + fileNameDownload;
    var linkFile = link;
    // if (!link.contains(GlobalVariable.urlFile)) {
    //   linkFile = GlobalVariable.urlFile + link;
    // }

    //JIKA SUDAH PERNAH DIDOWNLOAD ARAHKAN KE LOCAL
    if (await File(savedLocation).exists()) {
      linkFile = savedLocation;
    }

    print(linkFile);
    if (linkFile.split(":").first == "https") {
      print('Debug: Opening File Document Via Internet');
      // Get.toNamed(Routes.LIHAT_PDF, arguments: [fileNameDownload, linkFile]);
      if (await canLaunch(linkFile)) {
        await launch(linkFile);
      } else {
        throw "Could not launch $linkFile";
      }
    } else {
      File myFile = File(linkFile);
      if (myFile.existsSync()) {
        print('Debug: Opening File Document');
        var result = await OpenFile.open(linkFile);
      } else {
        print('Debug: Failed Opening File Document');
      }
    }
  }

  Future<String> _getLocalPath() async {
    return (await _findLocalPath()) + Platform.pathSeparator + 'Download';
  }

  static void downloadCallBack(id, status, progress) {
    SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, "downloader_send_port");
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen((message) {
      onProgress.value = message[2] / 100;
      print(message[2].toString());
      if (message[2] == 100.0 && onDownloading.value) {
        onDownloading.value = false;
        Get.back();
        print(tapDownload);
        if (tapDownload) {
          CustomToast.show(
              context: Get.context,
              message: "DetailTransporterLabelDownloadComplete".tr);
        } else {
          if (fileke == 1) {
            Share.shareFiles([filePath1]);
          } else if (fileke == 2) {
            Share.shareFiles([filePath2]);
          }
        }
      } else if (message[2] == -1) {
        Get.back();
      }
    });
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping("downloader_send_port");
  }

  Future<void> download(
      String url, String fileNameDownload, bool usingBaseFileLink) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
              child: WillPopScope(
                  onWillPop: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 8))),
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 30),
                      padding: EdgeInsets.all(
                          GlobalVariable.ratioWidth(Get.context) * 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(ListColor.color4)),
                              value: onProgress.value)),
                          Container(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                          Obx(() => RichText(
                              text: TextSpan(
                                  text: "Downloading " +
                                      (onProgress.value * 100)
                                          .toInt()
                                          .toString() +
                                      " %", // Menampilkan hasil untuk
                                  style: TextStyle(
                                    fontFamily: "AvenirNext",
                                    color: Color(ListColor.colorBlack),
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                  ),
                                  children: [])))
                        ],
                      ))));
        });
    var status = await Permission.storage.request();
    String urlFile = "";
    // if (!url.contains(GlobalVariable.urlFile)) {
    //   urlFile = GlobalVariable.urlFile;
    // }
    if (status.isGranted) {
      var savedLocation = await _getLocalPath();
      onDownloading.value = true;
      print(urlFile + url);
      String downloadId = await FlutterDownloader.enqueue(
          url: urlFile + url,
          // savedDir: externalDir.path,
          savedDir: savedLocation,
          saveInPublicStorage: true,
          showNotification: true,
          fileName: fileNameDownload,
          openFileFromNotification: true);
    } else {
      print('Permission Denied!');
    }
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0";
    // return ExtStorage.getExternalStorageDirectory();
  }

  Widget unitTrukRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 12)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(Get.context).size.width,
                            padding: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16),
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorHeaderListTender),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    topRight: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10))),
                            child: CustomText(
                              "ProsesTenderLihatPesertaLabelRute".tr +
                                  " " +
                                  (index + 1).toString().tr, // Rute
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      15.5,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.8,
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          41,
                                      dashGap: 1.8,
                                      dashThickness: 1.5,
                                      dashLength: 5,
                                      dashColor: Color(ListColor.colorDash),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                26,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'ic_pickup.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                              ),
                                              CustomText(
                                                  dataRuteTender[index]
                                                      ['pickup'],
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorBlack1B)),
                                            ],
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'ic_destinasi.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                            ),
                                            CustomText(
                                                dataRuteTender[index]
                                                    ['destinasi'],
                                                fontSize: 14,
                                                height: 1.2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    ListColor.colorBlack1B)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (var indexDetail = 0;
                              indexDetail <
                                  dataRuteTender[index]['data'].length;
                              indexDetail++)
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        bottomRight: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10))),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  3,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'ic_truck_grey.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        Expanded(
                                            child: CustomText(
                                                dataRuteTender[index]['data']
                                                            [indexDetail]
                                                        ['nama_truk'] +
                                                    " - " +
                                                    dataRuteTender[index]
                                                                ['data']
                                                            [indexDetail]
                                                        ['nama_carrier'],
                                                fontSize: 14,
                                                height: 1.2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600,
                                                wrapSpace: true,
                                                maxLines: 2,
                                                color: Colors.black))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'muatan.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['nilai']
                                                            .toString()) +
                                                " Unit",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'hargapenawaran.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            "Rp" +
                                                GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['penawaran']
                                                            .toString()) +
                                                " / Unit",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  indexDetail !=
                                          dataRuteTender[index]['data'].length -
                                              1
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              bottom: GlobalVariable
                                                      .ratioWidth(
                                                          Get.context) *
                                                  13), // KARENA ADA HEIGHTNYA
                                          width: MediaQuery.of(Get.context)
                                              .size
                                              .width,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              0.5,
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                        )
                                      : SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                ]))
                        ],
                      )),
                )
              ])
        : SizedBox());
  }

  Widget beratRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 12)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(Get.context).size.width,
                            padding: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16),
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorHeaderListTender),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    topRight: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10))),
                            child: CustomText(
                              "ProsesTenderLihatPesertaLabelRute".tr +
                                  " " +
                                  (index + 1).toString().tr, // Rute
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      15.5,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.8,
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          41,
                                      dashGap: 1.8,
                                      dashThickness: 1.5,
                                      dashLength: 5,
                                      dashColor: Color(ListColor.colorDash),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                26,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'ic_pickup.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                              ),
                                              CustomText(
                                                  dataRuteTender[index]
                                                      ['pickup'],
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorBlack1B)),
                                            ],
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'ic_destinasi.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                            ),
                                            CustomText(
                                                dataRuteTender[index]
                                                    ['destinasi'],
                                                fontSize: 14,
                                                height: 1.2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    ListColor.colorBlack1B)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (var indexDetail = 0;
                              indexDetail <
                                  dataRuteTender[index]['data'].length;
                              indexDetail++)
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        bottomRight: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10))),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'muatan.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['nilai']
                                                            .toString()) +
                                                " Ton",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'hargapenawaran.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            "Rp" +
                                                GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['penawaran']
                                                            .toString()) +
                                                " / Ton",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  indexDetail !=
                                          dataRuteTender[index]['data'].length -
                                              1
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              bottom: GlobalVariable
                                                      .ratioWidth(
                                                          Get.context) *
                                                  13), // KARENA ADA HEIGHTNYA
                                          width: MediaQuery.of(Get.context)
                                              .size
                                              .width,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              0.5,
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                        )
                                      : SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                ]))
                        ],
                      )),
                )
              ])
        : SizedBox());
  }

  Widget volumeRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 12)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(Get.context).size.width,
                            padding: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16),
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorHeaderListTender),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    topRight: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10))),
                            child: CustomText(
                              "ProsesTenderLihatPesertaLabelRute".tr +
                                  " " +
                                  (index + 1).toString().tr, // Rute
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      15.5,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.8,
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          41,
                                      dashGap: 1.8,
                                      dashThickness: 1.5,
                                      dashLength: 5,
                                      dashColor: Color(ListColor.colorDash),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                26,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'ic_pickup.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                              ),
                                              CustomText(
                                                  dataRuteTender[index]
                                                      ['pickup'],
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorBlack1B)),
                                            ],
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'ic_destinasi.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                            ),
                                            CustomText(
                                                dataRuteTender[index]
                                                    ['destinasi'],
                                                fontSize: 14,
                                                height: 1.2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    ListColor.colorBlack1B)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (var indexDetail = 0;
                              indexDetail <
                                  dataRuteTender[index]['data'].length;
                              indexDetail++)
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        bottomRight: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10))),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'muatan.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['nilai']
                                                            .toString()) +
                                                " " +
                                                satuanVolume,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'hargapenawaran.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            "Rp" +
                                                GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['penawaran']
                                                            .toString()) +
                                                " / " +
                                                satuanVolume,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  indexDetail !=
                                          dataRuteTender[index]['data'].length -
                                              1
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              bottom: GlobalVariable
                                                      .ratioWidth(
                                                          Get.context) *
                                                  13), // KARENA ADA HEIGHTNYA
                                          width: MediaQuery.of(Get.context)
                                              .size
                                              .width,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              0.5,
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                        )
                                      : SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                ]))
                        ],
                      )),
                )
              ])
        : SizedBox());
  }
}
