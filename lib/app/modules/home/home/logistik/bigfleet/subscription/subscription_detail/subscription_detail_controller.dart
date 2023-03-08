import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/metode_pembayaran.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/alert_dialog/subscription_popup_konfirmasi_pembatalan_pembayaran.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/api_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/subscription_detail_paket_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/tipe_paket.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pembayaran_subscription/pembayaran_subscription_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'dart:io' show File, Platform;
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class SubscriptionDetailController extends GetxController {
  var loading = true.obs;
  var refreshData = false;
  var refreshPanel = false;

  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  ReceivePort _port = ReceivePort();
  String downloadId;
  String fileName;
  var tapDownload = false;
  String filePath = "";
  var processing = false.obs;

  int id;
  TipeLayananSubscription tipe;
  TipeDetailSubscription tipeDetail;
  List<SubscriptionDetailPaketModel> listData = [];
  String kodePesanan = '';
  String tanggalPesanan = '';
  String waktuPembayaran = '';

  ///status pesanan 0 mengunggu pembayaran
  ///status pesanan 1 pembayaran diterima
  ///status pesanan 2 pembayaran dibatalkan
  ///status pesanan 3 pembayaran kadaluarsa
  int statusPesanan = 0;
  String batasPembayaran = '';
  String kodeVoucher = '';
  int hargaLayanan = 0;
  int hargaSubUsers = 0;
  int jumlahSubUsersBayar = 0;
  int jumlahSubUsersGratis = 0;
  double hargaDiskon = 0;
  int biayaLayanan = 0;
  double pajak = 0;
  double totalHarga = 0;
  String iconPembayaran = '';
  String paymentID = "";
  String nomerRekening = "";
  String metodePembayaran = '';
  String statusPesananMenungguWaktu = '';
  String statusPesananMenungguStatus = '';
  String statusPesananWaktu = '';
  String statusPesananStatus = '';
  bool isNext;
  var loadingBatal = false.obs;

  @override
  void onInit() async {
    // fileName = "testFile.gif";
    id = Get.arguments[0];
    tipe = Get.arguments[1];
    tipeDetail = Get.arguments[2];
    getData();
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  getData() async {
    loading.value = true;
    MessageFromUrlModel message;
    var body = {
      "OrderID": id.toString(),
    };
    var response;
    if (tipe == TipeLayananSubscription.BF) {
      response = await ApiSubscription(
              context: Get.context, isShowDialogLoading: false)
          .getDetailOrderByShipper(body);
    } else {
      response = await ApiSubscription(
              context: Get.context, isShowDialogLoading: false)
          .getDetailOrderSubusersByShipper(body);
    }
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
      List data = response['Data'];
      listData = [];
      data.forEach((element) {
        listData.add(SubscriptionDetailPaketModel.fromJson(element));
        if ((element as Map).containsKey("OrderPaymentID"))
          paymentID = element["OrderPaymentID"].toString();
      });
      if (response['Footer'].length != 0) {
        fileName = "${response['Footer'][0]['DocNumber']}.pdf";
        kodePesanan = response['Footer'][0]['DocNumber'];
        tanggalPesanan = response['Footer'][0]['DocDate'];
        waktuPembayaran = response['Footer'][0]['DateTimeReceived'];
        statusPesanan = response['Footer'][0]['Status'];
        batasPembayaran = response['Footer'][0]['PaymentExpired'];
        kodeVoucher = response['Footer'][0]['KodeVoucher'];
        hargaLayanan = response['Footer'][0]['HargaLayanan'];
        hargaSubUsers = response['Footer'][0]['HargaSubUser'];
        jumlahSubUsersBayar = response['Footer'][0]['QtyUserBerbayar'];
        jumlahSubUsersGratis = response['Footer'][0]['QtyUserGratis'];
        hargaDiskon = (response['Footer'][0]['HargaDiskon'] as int).toDouble();
        biayaLayanan = response['Footer'][0]['FeeLayanan'];
        pajak = (response['Footer'][0]['Tax'] as int).toDouble();
        totalHarga = (response['Footer'][0]['GrandTotal'] as int).toDouble();
        iconPembayaran = response['Footer'][0]['PaymentIcon'];
        metodePembayaran = response['Footer'][0]['MetodePembayaran'];
        nomerRekening = response['Footer'][0]['NoRekening'];
        isNext = response['IsNext'] == 1;
        if (statusPesanan != 0) {
          statusPesananMenungguWaktu =
              response['Footer'][0]['StatusExpand'][0]['Date'];
          statusPesananMenungguStatus =
              response['Footer'][0]['StatusExpand'][0]['Str'];
          statusPesananWaktu = response['Footer'][0]['StatusExpand'][1]['Date'];
          statusPesananStatus = response['Footer'][0]['StatusExpand'][1]['Str'];
        }
      }
      // if (response['ArrayOrder'].length != 0) {
      //   paymentID = response['ArrayOrder'][0]['PaymentID'].toString();
      // }
    } else {
      //show error
    }
    loading.value = false;
  }

  void bayarSekarang() async {
    var content = MetodePembayaranModel(
        paymentID: paymentID,
        noRek: nomerRekening,
        paymentName: metodePembayaran,
        thumbnail: iconPembayaran);
    var resultPayment =
        await GetToPage.toNamed<PembayaranSubscriptionController>(
            Routes.PEMBAYARAN_SUBSCRIPTION,
            arguments: [
          content,
          totalHarga,
          batasPembayaran,
          tipe == TipeLayananSubscription.BF
              ? (hargaLayanan + hargaSubUsers)
              : hargaSubUsers,
          jumlahSubUsersBayar,
          jumlahSubUsersGratis,
          kodeVoucher,
          hargaDiskon,
          biayaLayanan.toDouble(),
          pajak,
          tipe == TipeLayananSubscription.SU,
          id,
          isNext
        ]);
    print("RESULT FROM PAYMENT : $resultPayment");
    if (resultPayment != null && resultPayment[1] == "justRefresh") {
      refreshData = true;
      refreshPanel = false; // avoid auto back from menunggu pembayaran list
      getData();
    } else if (resultPayment != null && resultPayment[1] != "justRefresh") {
      refreshData = true;
      refreshPanel = true;
      // getData();
      if ((resultPayment[0] is String) && (resultPayment[0] as String).length > 0) {
        Get.back(result: [refreshData, refreshPanel, resultPayment]);
      } else {
        CustomToast.show(
          context: Get.context,
          message: tipe == TipeLayananSubscription.SU
              ? 'SubscriptionAlertSubUserBuySuccess'.tr
              : 'SubscriptionAlertSubscriptionBuySuccess'.tr
          // "Pembelian ${tipe == TipeLayananSubscription.SU ? "Sub User" : "Subscription"} berhasil",
        );
        Get.back(result: [refreshData, refreshPanel, null]);
      }
      // if (tipe == TipeLayananSubscription.SU) {
      //   CustomToast.show(
      //       context: Get.context,
      //       message: "Pembelian Sub User berhasil",
      //       buttonText: "Tutup");
      // } else {
      //   resultPembayaranSubsciption(listData[0].name, listData[0].periode,
      //       kredit: resultPayment[2] == "8");
      // }
    }
  }

  // void resultPembayaranSubsciption(String namaPaket, String periode,
  //     {bool kredit = true}) {
  //   var textPeriode = periode.replaceAll("-", "sampai dengan");
  //   if (kredit) {
  //     GlobalAlertDialog.showAlertDialogCustom(
  //         context: Get.context,
  //         isDismissible: false,
  //         title: "Selamat Berhasil!",
  //         message:
  //             "Selamat Anda berhasil berlangganan $namaPaket. Langganan Berlaku $textPeriode",
  //         labelButtonPriority1: "Oke",
  //         positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
  //   } else {
  //     GlobalAlertDialog.showAlertDialogCustom(
  //         context: Get.context,
  //         isDismissible: false,
  //         title: "",
  //         customMessage: Container(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(
  //                     bottom: GlobalVariable.ratioHeight(Get.context) * 28),
  //                 child: SvgPicture.asset("assets/pembayaran_berhasil.svg",
  //                     width: GlobalVariable.ratioWidth(Get.context) * 124,
  //                     height: GlobalVariable.ratioWidth(Get.context) * 124),
  //               ),
  //               CustomText(
  //                 "Pembayaran Berhasil",
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //               Container(height: GlobalVariable.ratioHeight(Get.context) * 11),
  //               CustomText(
  //                 "Selamat Anda berhasil berlangganan $namaPaket. Langganan Berlaku $textPeriode",
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w500,
  //                 height: 1.2,
  //                 textAlign: TextAlign.center,
  //               ),
  //             ],
  //           ),
  //         ),
  //         labelButtonPriority1: "Oke",
  //         positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
  //   }
  // }

  void showAskBatalDialog() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        isDismissible: true,
        title: "SubscriptionCancelOrder".tr,
        message: "SubscriptionAlertCancelConfirmation".tr,
        labelButtonPriority1: GlobalAlertDialog.yesLabelButton,
        labelButtonPriority2: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () {
          showBatalDialog();
        },
        onTapPriority2: () {},
        positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2);
  }

  void showBatalDialog() {
    SubscriptionPopupKonfirmasiPembatalanPembayaran.showAlertDialog(
        context: Get.context);
  }
  // void showBatalDialog() {
  //   var selected = "0".obs;
  //   var textController = TextEditingController();
  //   GlobalAlertDialog.showAlertDialogCustom(
  //       context: Get.context,
  //       disableGetBack: true,
  //       isDismissible: true,
  //       title: "Konfirmasi Pembatalan",
  //       customMessage: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CustomText(
  //             "Apakah alasan membatalkan pesanan?",
  //             fontWeight: FontWeight.w500,
  //           ),
  //           Container(height: GlobalVariable.ratioWidth(Get.context) * 14),
  //           Container(
  //             margin: EdgeInsets.symmetric(
  //                 vertical: GlobalVariable.ratioWidth(Get.context) * 7),
  //             child: Row(
  //               mainAxisSize: MainAxisSize.max,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Obx(
  //                   () => RadioButtonCustom(
  //                     isWithShadow: true,
  //                     isDense: true,
  //                     width: GlobalVariable.ratioWidth(Get.context) * 15,
  //                     groupValue: selected.value,
  //                     value: "1",
  //                     onChanged: (value) {
  //                       selected.value = value;
  //                     },
  //                   ),
  //                 ),
  //                 Container(
  //                   width: GlobalVariable.ratioWidth(Get.context) * 15,
  //                 ),
  //                 Expanded(
  //                     child: CustomText(
  //                   "Ingin mengubah pesanan",
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w500,
  //                   color: Color(ListColor.colorDarkGrey3),
  //                 )),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             margin: EdgeInsets.symmetric(
  //                 vertical: GlobalVariable.ratioWidth(Get.context) * 7),
  //             child: Row(
  //               mainAxisSize: MainAxisSize.max,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Obx(
  //                   () => RadioButtonCustom(
  //                     isWithShadow: true,
  //                     isDense: true,
  //                     width: GlobalVariable.ratioWidth(Get.context) * 15,
  //                     groupValue: selected.value,
  //                     value: "2",
  //                     onChanged: (value) {
  //                       selected.value = value;
  //                     },
  //                   ),
  //                 ),
  //                 Container(
  //                   width: GlobalVariable.ratioWidth(Get.context) * 15,
  //                 ),
  //                 Expanded(
  //                     child: CustomText(
  //                   "Tidak lagi ingin berlangganan",
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w500,
  //                   color: Color(ListColor.colorDarkGrey3),
  //                 )),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             margin: EdgeInsets.symmetric(
  //                 vertical: GlobalVariable.ratioWidth(Get.context) * 7),
  //             child: Row(
  //               mainAxisSize: MainAxisSize.max,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Obx(
  //                   () => RadioButtonCustom(
  //                     isWithShadow: true,
  //                     isDense: true,
  //                     width: GlobalVariable.ratioWidth(Get.context) * 15,
  //                     groupValue: selected.value,
  //                     value: "3",
  //                     onChanged: (value) {
  //                       selected.value = value;
  //                     },
  //                   ),
  //                 ),
  //                 Container(
  //                   width: GlobalVariable.ratioWidth(Get.context) * 15,
  //                 ),
  //                 Expanded(
  //                     child: CustomText(
  //                   "Ingin mengubah metode pembayaran",
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w500,
  //                   color: Color(ListColor.colorDarkGrey3),
  //                 )),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             margin: EdgeInsets.symmetric(
  //                 vertical: GlobalVariable.ratioWidth(Get.context) * 7),
  //             child: Row(
  //               mainAxisSize: MainAxisSize.max,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Obx(
  //                   () => RadioButtonCustom(
  //                     isWithShadow: true,
  //                     isDense: true,
  //                     width: GlobalVariable.ratioWidth(Get.context) * 15,
  //                     groupValue: selected.value,
  //                     value: "4",
  //                     onChanged: (value) {
  //                       selected.value = value;
  //                     },
  //                   ),
  //                 ),
  //                 Container(
  //                   width: GlobalVariable.ratioWidth(Get.context) * 15,
  //                 ),
  //                 Expanded(
  //                     child: CustomText(
  //                   "Lainnya",
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w500,
  //                   color: Color(ListColor.colorDarkGrey3),
  //                 )),
  //               ],
  //             ),
  //           ),
  //           Row(
  //             mainAxisSize: MainAxisSize.max,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 width: GlobalVariable.ratioWidth(Get.context) * 30,
  //               ),
  //               Expanded(
  //                   child: Obx(
  //                 () => selected.value == "4"
  //                     ? CustomTextFormField(
  //                         context: Get.context,
  //                         controller: textController,
  //                         minLines: 3,
  //                         maxLines: 3,
  //                         style: TextStyle(fontWeight: FontWeight.w600),
  //                         textSize: 12,
  //                         newInputDecoration: InputDecoration(
  //                           contentPadding: EdgeInsets.all(
  //                               GlobalVariable.ratioWidth(Get.context) * 6),
  //                           fillColor: Colors.white,
  //                           border: OutlineInputBorder(
  //                             borderSide: BorderSide(
  //                                 color: Color(ListColor.colorGrey2),
  //                                 width: 1.0),
  //                             borderRadius: BorderRadius.circular(6),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: BorderSide(
  //                                 color: Color(ListColor.color4), width: 2.0),
  //                             borderRadius: BorderRadius.circular(6),
  //                           ),
  //                         ),
  //                       )
  //                     : SizedBox.shrink(),
  //               )),
  //             ],
  //           )
  //         ],
  //       ),
  //       labelButtonPriority1: "Batalkan",
  //       labelButtonPriority2: "Kembali",
  //       onTapPriority1: () {
  // if (selected.value == "0") {
  //   CustomToast.show(
  //       context: Get.context,
  //       message: "Pilih salah satu alasannya",
  //       buttonText: "Tutup");
  // } else if (selected.value == "4" && textController.text.isEmpty) {
  //   CustomToast.show(
  //       context: Get.context,
  //       message: "Alasan harus diisi",
  //       buttonText: "Tutup");
  // } else {
  //   var message = "";
  //   switch (selected.value) {
  //     case "1":
  //       {
  //         message = "Ingin mengubah pesanan";
  //         break;
  //       }
  //     case "2":
  //       {
  //         message = "Tidak lagi ingin berlangganan";
  //         break;
  //       }
  //     case "3":
  //       {
  //         message = "Ingin mengubah metode pembayaran";
  //         break;
  //       }
  //     default:
  //       {
  //         message = textController.text;
  //       }
  //   }
  //   Get.back();
  //   batalOrder(message);
  // }
  //       },
  //       onTapPriority2: () {
  //         Get.back();
  //       },
  //       positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1);
  // }

  void batalOrder(String pesan) async {
    loadingBatal.value = true;
    var result = tipe == TipeLayananSubscription.BF
        ? await ApiSubscription(
                context: Get.context,
                isShowDialogError: false,
                isShowDialogLoading: false)
            .doCancelOrderSubscription(id.toString(), pesan)
        : await ApiSubscription(
                context: Get.context,
                isShowDialogError: false,
                isShowDialogLoading: false)
            .doCancelOrderSubuser(id.toString(), pesan);
    if (result != null) {
      if (result["Message"]["Code"] == 200) {
        refreshData = true;
        getData();
        CustomToast.show(
          context: Get.context,
          message: "SubscriptionAlertCancelSuccess".tr,
        );
      } else {
        GlobalAlertDialog.showDialogError(
            context: Get.context,
            title: "",
            message: result["Data"]["Message"],
            labelButtonPriority1: "Ok");
      }
    }
    loadingBatal.value = false;
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
        if (tapDownload) {
          CustomToast.show(
              context: Get.context,
              message: "DetailTransporterLabelDownloadComplete".tr);
        } else {
          Share.shareFiles([filePath]);
        }
      }
    });
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping("downloader_send_port");
  }

  Future cekDownloadFile() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var savePath = (await _findLocalPath()) +
          Platform.pathSeparator +
          'Download' +
          Platform.pathSeparator +
          fileName;
      if (await File(savePath).exists()) {
        GlobalAlertDialog.showAlertDialogCustom(
            context: Get.context,
            title: "Warning",
            message:
                "File sebelumnya telah didownload, apakah yakin untuk men-download ulang?",
            labelButtonPriority1: GlobalAlertDialog.noLabelButton,
            labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
            positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
            onTapPriority1: () {},
            onTapPriority2: () async {
              var error = "";
              try {
                await File(savePath).delete(recursive: true);
              } catch (e) {
                error = e.toString();
              }
              if (error.isEmpty)
                downloadFile();
              else
                GlobalAlertDialog.showDialogError(
                    context: Get.context, message: error, isDismissible: false);
            });
      } else {
        downloadFile();
      }
    } else {
      print('Permission Denied!');
    }
  }

  void downloadFile() async {
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        onDownloading.value = true;
        onProgress.value = 0.0;
        processing.value = true;
        var savedLocation =
            (await _findLocalPath()) + Platform.pathSeparator + 'Download';
        var pdfURL = await getPDFLink(
            "${ApiHelper.url}generate/faktur_subscription_bf/?idx=${GlobalVariable.docID}&role=2&id=${id}&type=${tipe == TipeLayananSubscription.BF ? "0" : "1"}&app=1");
        processing.value = false;
        downloadId = await FlutterDownloader.enqueue(
            url: pdfURL,
            savedDir: savedLocation,
            showNotification: true,
            fileName: fileName,
            openFileFromNotification: true);
      } else {
        CustomToast.show(
          context: Get.context,
          message: "Permission denied!",
        );
        print('Permission Denied!');
      }
    } catch (error) {
      // update some val
      onDownloading.value = false;
      onProgress.value = 0.0;
      processing.value = false;
      
      if (kDebugMode) print("ERROR DOWNLOAD : $error");
      CustomToast.show(
        context: Get.context,
        message: "Download failed!",
      );
    }
  }

  void shareFile() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var fileDirectory = (await _findLocalPath()) +
          Platform.pathSeparator +
          'Download' +
          Platform.pathSeparator;
      var savePath = fileDirectory + fileName;
      if (!await File(savePath).exists()) {
        tapDownload = false;
        filePath = savePath;
        cekDownloadFile();
      } else {
        Share.shareFiles([savePath]);
      }
    } else {
      print('Permission Denied!');
    }
  }

  Widget optionView(
      Widget widget, String text, String subText, Function function,
      {Color subTextColor: Colors.grey, Widget subWidget}) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(margin: EdgeInsets.only(right: 13), child: widget),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text, fontSize: 16, fontWeight: FontWeight.w500),
                Container(height: 8),
                subText.isNull
                    ? SizedBox.shrink()
                    : CustomText(subText, fontSize: 14, color: subTextColor),
              ],
            )),
            subWidget == null
                ? SizedBox.shrink()
                : Container(margin: EdgeInsets.only(left: 13), child: widget),
          ],
        ),
      ),
    );
  }

  Future<String> getPDFLink(String url) async {
    if (kDebugMode) print(url);
    var responseBody = await ApiSubscription(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchPDFLink(url);
    return responseBody["Data"].toString();
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0/";
  }
}
