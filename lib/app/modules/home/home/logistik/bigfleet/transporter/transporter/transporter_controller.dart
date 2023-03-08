import 'dart:isolate';
import 'dart:ui';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/core/function/api/get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/transporter_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io' show File, Platform;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:latlong/latlong.dart';

class TransporterController extends GetxController
    with SingleGetTickerProviderMixin {
  var statusMitra = "0".obs;
  var txtButtonMitra = "".obs;
  var iconButtonMitra = Icons.add.obs;
  // var iconButtonMitra = "".obs;
  var show = false.obs;
  var transporterID = 0.obs;
  var listMedia = [].obs;
  var imgList = <String>[].obs;
  var videoList = <String>[].obs;

  var profil = Map().obs;
  var kendaraan = [].obs;
  var contacts = Map().obs;
  var thumbnailVideo = [].obs;
  var imageSliders = <Widget>[].obs;
  final indexImageSlider = 0.obs;
  var position = 0.obs;

  var regexVideo = RegExp("(^.*)(.mp4)");
  var listTestimony = [].obs;
  var rating = Map().obs;
  var totalRating = 0.0.obs;

  var loadMedia = true;
  var loadContact = true;
  var loadDetail = true;
  var loadProfile = true.obs;
  var loadVideo = true.obs;
  var loadTestimony = true.obs;

  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  ReceivePort _port = ReceivePort();
  String downloadId;
  String fileName;
  var tapDownload = false;
  String filePath = "";
  var processing = false.obs;
  var change = Map();

  // var namaTransporter = "".obs;
  // var avatar = "".obs;
  // var isGold = false;
  Transporter transporter;

  ContactPartnerModalSheetBottomController _contactModalBottomSheetController;

  @override
  void onInit() async {
    transporterID.value = int.parse(Get.arguments[0].toString());
    _contactModalBottomSheetController =
        Get.put(ContactPartnerModalSheetBottomController());
    // namaTransporter.value = Get.arguments[1].toString();
    // avatar.value = Get.arguments[2].toString();
    // isGold = Get.arguments[3];
    // fileName = Get.arguments[1].toString() + " CV.pdf";
    getDetailTransporter();
    getStatusMitra();
    getContact();
    getMedia();
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void getDetailTransporter() async {
    var result =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchDetailTransporter(transporterID.value.toString());
    if (result['Data'] is List) Fluttertoast.showToast(msg: 'Tidak ada data');
    transporter = Transporter.fromJson(result["Data"]);
    // avatar.value = transporter.avatar;
    // isGold = transporter.isGold;
    fileName = transporter.nama + " CV.pdf";
    loadDetail = false;
    checkLoadAll();
  }

  void updateButtonMitra() {
    switch (statusMitra.value) {
      case "0":
        txtButtonMitra.value = "DetailTransporterLabelAddPartner".tr;
        iconButtonMitra.value = Icons.add;
        // iconButtonMitra.value = "assets/add_mitra.svg";
        break;
      case "1":
        txtButtonMitra.value = "DetailTransporterLabelBalasPermintaan".tr;
        iconButtonMitra.value = Icons.live_help_outlined;
        // iconButtonMitra.value = "assets/balas_mitra.svg";
        break;
      case "2":
        txtButtonMitra.value = "DetailTransporterLabelBatalPermintaan".tr;
        iconButtonMitra.value = Icons.pending_actions;
        // iconButtonMitra.value = "assets/pending_mitra.svg";
        break;
      case "3":
        txtButtonMitra.value = "DetailTransporterLabelRemovePartner".tr;
        iconButtonMitra.value = Icons.delete;
        // iconButtonMitra.value = "assets/delete_mitra.svg";
        break;
    }
  }

  void onPressButtonMitra() {
    switch (statusMitra.value) {
      case "0":
        addMitra();
        break;
      case "1":
        approveRejectDialog();
        break;
      case "2":
        cancelRequest();
        break;
      case "3":
        removeMitra();
        break;
    }
  }

  void addMitra() async {
    // GlobalAlertDialog.showAlertDialogCustom(
    //   title: "Peringatan",
    //   message: "DetailTransporterLabelAddQuestion".tr,
    //   context: Get.context,
    //   labelButtonPriority1: "Ya",
    //   labelButtonPriority2: "Tidak",
    //   // labelButtonPriority1: "DetailTransporterLabelSendRequest".tr,
    //   // labelButtonPriority2: "DetailTransporterLabelCancel".tr,
    //   onTapPriority1: () async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response = await ApiHelper(
            context: Get.context, isShowDialogLoading: false)
        .requestAsPartner(shipperID.toString(), transporterID.value.toString());
    var message = MessageFromUrlModel.fromJson(response['Message']);
    if (message.code == 200) {
      change["2"] = true;
      statusMitra.value = "2";
      updateButtonMitra();
      CustomToast.show(
          context: Get.context,
          // message: "DetailTransporterLabelHasBeenSent".tr);
          customMessage: RichText(text: TextSpan(
            style: TextStyle(
              color: Colors.white,
              fontSize: GlobalVariable.ratioWidth(Get.context) * 12,
              height: 1.2
            ),
            children: [
              TextSpan(text: "ListTransporterLabelAddPartner".tr, style: TextStyle(fontWeight: FontWeight.w500)),
              TextSpan(text: "\n${transporter.nama}", style: TextStyle(fontWeight: FontWeight.w700))
            ]
          )));
    } else {
      GlobalAlertDialog.showDialogError(
          message: response["Data"]["Message"],
          context: Get.context,
          isDismissible: false);
    }
    //   },
    // );
    // GlobalAlertDialog.showDialogError(.showAlertDialogConfirmButton(
    //     "DetailTransporterLabelAddQuestion".tr,
    //     "DetailTransporterLabelSendRequest".tr,
    //     "DetailTransporterLabelCancel".tr, () async {
    //   var shipperID = await SharedPreferencesHelper.getUserShipperID();
    //   var response =
    //       await ApiHelper(context: Get.context, isShowDialogLoading: false)
    //           .requestAsPartner(
    //               shipperID.toString(), transporterID.value.toString());
    //   var message = MessageFromUrlModel.fromJson(response['Message']);
    //   if (message.code == 200) {
    //     change["2"] = true;
    //     statusMitra.value = "2";
    //     updateButtonMitra();
    //     CustomToast.show(
    //         context: Get.context,
    //         message: "DetailTransporterLabelHasBeenSent".tr);
    //   } else {
    //     GlobalAlertDialog.showDialogError(
    //         message: response["Data"]["Message"], context: Get.context);
    //   }
    // });
  }

  Future removeMitra() async {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Peringatan",
      message: "DetailTransporterLabelRemoveQuestion".tr,
      customMessage: Container(
        margin: EdgeInsets.only(
            bottom: GlobalVariable.ratioWidth(Get.context) * 20),
        child: GlobalAlertDialog.getTextRichtWidget(
            "DetailTransporterLabelRemoveQuestion".tr,
            ":NAMA_TRANSPORTER",
            transporter.nama),
      ),
      context: Get.context,
      labelButtonPriority1: "Ya",
      labelButtonPriority2: "Tidak",
      onTapPriority1: () async {
        var shipperID = await SharedPreferencesHelper.getUserShipperID();
        var response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .removePartner("",
                    transporterID: transporterID.value.toString(),
                    shipperID: shipperID.toString());
        var message = MessageFromUrlModel.fromJson(response['Message']);
        if (message.code == 200) {
          change["0"] = true;
          statusMitra.value = "0";
          updateButtonMitra();
          CustomToast.show(
              context: Get.context,
              message: "DetailTransporterLabelRemoveSuccess".tr);
        } else {
          GlobalAlertDialog.showAlertDialogCustom(
              title: "Error".tr,
              customMessage: Container(
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                child: GlobalAlertDialog.convertHTMLToText(message.code == 500
                    ? response['Data']['Message']
                    : message.text),
              ),
              context: Get.context,
              labelButtonPriority1: "OK",
              onTapPriority1: () {});
        }
      },
    );
    // GlobalAlertDialog.showDialogError(.showAlertDialogConfirmButton(
    //     "DetailTransporterLabelRemoveQuestion".tr,
    //     "DetailTransporterLabelRemovePartner".tr,
    //     "DetailTransporterLabelCancel".tr, () async {
    //   var shipperID = await SharedPreferencesHelper.getUserShipperID();
    //   var response =
    //       await ApiHelper(context: Get.context, isShowDialogLoading: false)
    //           .removePartner("",
    //               transporterID: transporterID.value.toString(),
    //               shipperID: shipperID.toString());
    //   var message = MessageFromUrlModel.fromJson(response['Message']);
    //   if (message.code == 200) {
    //     change["0"] = true;
    //     statusMitra.value = "0";
    //     updateButtonMitra();
    //     CustomToast.show(
    //         context: Get.context,
    //         message: "DetailTransporterLabelRemoveSuccess".tr);
    //   } else {
    //     GlobalAlertDialog.showDialogError(
    //         message: message.code == 500
    //             ? response['Data']['Message']
    //             : message.text,
    //         context: Get.context);
    //   }
    // });
  }

  void cancelRequest() async {
    GlobalAlertDialog.showAlertDialogCustom(
        title: "GlobalDialogCancelReqPartnerTitle".tr,
        customMessage: Container(
          margin: EdgeInsets.only(
              bottom: GlobalVariable.ratioWidth(Get.context) * 20),
          child: GlobalAlertDialog.getTextRichtWidget(
              "GlobalDialogCancelReqPartnerDesc".tr,
              ":NAMA_TRANSPORTER",
              transporter.nama),
        ),
        context: Get.context,
        onTapPriority1: () {},
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority2: () async {
          var shipperID = await SharedPreferencesHelper.getUserShipperID();
          var response =
              await ApiHelper(context: Get.context, isShowDialogLoading: true)
                  .fetchSetDataRequestCancelMitraByShipper("",
                      transporterID: transporterID.value.toString(),
                      shipperID: shipperID.toString());
          var message = MessageFromUrlModel.fromJson(response['Message']);
          if (message.code == 200) {
            change["2"] = true;
            statusMitra.value = "0";
            updateButtonMitra();
            CustomToast.show(
                context: Get.context,
                message: "DetailTransporterLabelHasBeenCancelled".tr);
          } else {
            GlobalAlertDialog.showDialogError(
                message: response["Data"]["Message"],
                context: Get.context,
                isDismissible: false);
          }
        });
    // GlobalAlertDialog.showAlertDialogCustom(
    //   title: "Peringatan",
    //   message: "DetailTransporterLabelCancelQuestion".tr,
    //   context: Get.context,
    //   labelButtonPriority1: "Ya",
    //   labelButtonPriority2: "Tidak",
    //   // labelButtonPriority1: "DetailTransporterLabelBatalPermintaan".tr,
    //   // labelButtonPriority2: "DetailTransporterLabelCancel".tr,
    //   onTapPriority1: () async {
    //     var shipperID = await SharedPreferencesHelper.getUserShipperID();
    //     var response =
    //         await ApiHelper(context: Get.context, isShowDialogLoading: true)
    //             .fetchSetDataRequestCancelMitraByShipper("",
    //                 transporterID: transporterID.value.toString(),
    //                 shipperID: shipperID.toString());
    //     var message = MessageFromUrlModel.fromJson(response['Message']);
    //     if (message.code == 200) {
    //       change["2"] = true;
    //       statusMitra.value = "0";
    //       updateButtonMitra();
    //       CustomToast.show(
    //           context: Get.context,
    //           message: "DetailTransporterLabelHasBeenCancelled".tr);
    //     } else {
    //       GlobalAlertDialog.showDialogError(
    //           message: response["Data"]["Message"],
    //           context: Get.context,
    //           isDismissible: false);
    //     }
    //   },
    // );
  }

  void approveRejectDialog() async {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Peringatan",
      message: "DetailTransporterLabelApproveRejectQuestion".tr,
      context: Get.context,
      labelButtonPriority1: "DetailTransporterLabelApprove".tr,
      labelButtonPriority2: "DetailTransporterLabelReject".tr,
      onTapPriority1: () {
        approveRejectMitra("1");
      },
      onTapPriority2: () {
        approveRejectMitra("-1");
      },
    );
  }

  void approveRejectMitra(String status) async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .fetchSetDataApproveRejectMitraByShipper("", status,
                transporterID: transporterID.value.toString(),
                shipperID: shipperID.toString());
    var message = MessageFromUrlModel.fromJson(response['Message']);
    if (message.code == 200) {
      if (status == "1") change["0"] = true;
      change["1"] = true;
      statusMitra.value = status == "1" ? "3" : "0";
      updateButtonMitra();
      CustomToast.show(
          context: Get.context,
          message: status == "1"
              ? "DetailTransporterLabelHasBeenApproved".tr
              : "DetailTransporterLabelHasBeenRejected".tr);
    } else {
      GlobalAlertDialog.showDialogError(
          message: response["Data"]["Message"],
          context: Get.context,
          isDismissible: false);
    }
  }

  void getStatusMitra() async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchCheckStatusTransporterAsMitra(
                shipperID.toString(), transporterID.value.toString());
    Map<dynamic, dynamic> responseStatus = response["Data"][0];
    statusMitra.value = responseStatus["Status"].toString();
    updateButtonMitra();
  }

  Widget buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isCurrentPage
              ? Color(ListColor.colorIndicatorSelectedBigFleet)
              : Color(ListColor.colorIndicatorNotSelectedBigFleet),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.white)),
    );
  }

  void contactPartner() {
    _contactModalBottomSheetController.showContact(
        "",
        transporterID: transporterID.value.toString());
  }

  Widget optionView(
      Widget widget, String text, String subText, Function function,
      {Color subTextColor: Colors.grey, Widget subWidget}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(right: 13),
              child: GestureDetector(onTap: function, child: widget)),
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
    );
  }

  Future<void> callByPhone(String phone) async {
    await launch("tel:$phone");
  }

  void openWhatsapp(String phone) {
    FlutterOpenWhatsapp.sendSingleMessage(phone, "");
  }

  void openEmail() {
    var emailUri = Uri(
      scheme: "mailto",
      path: "joeychan0308@gmail.com",
    );
    launch(emailUri.toString());
  }

  void addToPhoneContact() async {
    var newContact = Contact(displayName: transporter.nama);
    newContact.phones = [
      Item(label: "mobile", value: transporter.noTelp.toString())
    ];
    await ContactsService.addContact(newContact).then((value) {
      GlobalAlertDialog.showAlertDialogCustom(
          title: 'GlobalLabelSuccess'.tr,
          isDismissible: false,
          message: 'DetailTransporterLabelSuccess'.tr,
          context: Get.context,
          labelButtonPriority1: 'GlobalButtonOK'.tr);
    }).catchError((e) {
      print(e.toString);
    });
  }

  void getMedia() async {
    // var responseBody = await ApiHelper(
    //         context: Get.context,
    //         isShowDialogLoading: false,
    //         isShowDialogError: false)
    //     .getTransporterMedia(transporterID.value.toString());
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getTransporterMedia("2");
    listMedia.clear();
    List<dynamic> getMedia = responseBody["Data"];
    getMedia.forEach((element) {
      listMedia.add("https://assetlogistik.com/assets/" + element["Media"]);
    });
    getListPicture();
    getListVideo();
    loadMedia = false;
    checkLoadAll();
  }

  void getListVideo() async {
    thumbnailVideo.clear();
    videoList.clear();
    listMedia.forEach((element) {
      if (regexVideo.hasMatch(element)) {
        videoList.add(element);
      }
    });
  }

  void getListPicture() async {
    imageSliders.clear();
    listMedia.forEach((element) {
      if (!regexVideo.hasMatch(element)) {
        imageSliders.add(Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: element,
            imageBuilder: (context, imageProvider) => Container(
              width: 1000,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
          ),
        ));
      }
    });
  }

  void getContact() async {
    ContactTransporterByShipperResponseModel response =
        await GetContactTransporterByShipper.getContact(
            transporterID.value.toString());
    contacts.clear();
    contacts.addAll(response.contactDataJson);
    contacts.value.remove("Avatar");
    loadContact = false;
    checkLoadAll();
  }

  void getThumbnailVideo() async {
    if (loadVideo.value) {
      loadVideo.value = true;
      videoList.value.forEach((element) async {
        final uint8list = await VideoThumbnail.thumbnailData(
          video: element,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 300,
          quality: 25,
        );
        thumbnailVideo.add(uint8list);
      });
      loadVideo.value = false;
    }
  }

  void getProfile() async {
    if (loadProfile.value) {
      // var responseBody = await ApiHelper(
      //         context: Get.context,
      //         isShowDialogLoading: false,
      //         isShowDialogError: false)
      //     .getTransporterProfile(transporterID.value.toString());
      var responseBody = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getTransporterProfile("38");
      Map getProfile = responseBody["Data"];
      // namaTransporter.value = getProfile["Transporter"].toString();
      // getProfile.removeWhere((key, value) =>
      //     key.toString() == "Transporter" || key.toString() == "TransporterID");\
      kendaraan.clear();
      kendaraan.value = getProfile["Truck"];
      profil.clear();
      profil.value = getProfile;
      loadProfile.value = false;
    }
  }

  void getTestimony() async {
    if (loadTestimony.value) {
      // var responseBody = await ApiHelper(
      //         context: Get.context,
      //         isShowDialogLoading: false,
      //         isShowDialogError: false)
      //     .getTransporterTestimony(transporterID.value.toString());
      var responseBody = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getTransporterTestimony("2");
      listTestimony.clear();
      listTestimony.addAll(responseBody["Data"]);
      responseBody = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getTransporterRating("2");
      rating.clear();
      rating.addAll(responseBody["Data"]);
      totalRating.value = 0.0;
      rating.values.forEach((element) {
        totalRating += element;
      });
      loadTestimony.value = false;
    }
  }

  void checkLoadAll() {
    show.value = !loadMedia && !loadContact && !loadDetail;
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

  Future downloadFile() async {
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        onDownloading.value = true;
        onProgress.value = 0.0;
        processing.value = true;
        var savedLocation =
            (await _findLocalPath()) + Platform.pathSeparator + 'Download';
        var mitraURL =
            //"https://media1.tenor.com/images/9cbd7be4f75bb816d1539e5df6f02019/tenor.gif";
            await getMitraCVLink(
                "https://assetlogistik.com/generate/profile_transporter/?id=${transporterID.value}&app=1");
        processing.value = false;
        downloadId = await FlutterDownloader.enqueue(
            url: mitraURL,
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
        downloadFile();
      } else {
        Share.shareFiles([savePath]);
      }
    } else {
      print('Permission Denied!');
    }
  }

  void shareTransporter() {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: CustomText("Share",
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)))
                    ],
                  ),
                ),
                optionView(Icon(Icons.upload_file), "Share File".tr, null,
                    () async {
                  Navigator.of(context).pop();
                  await shareFile();
                }),
                optionView(Icon(Icons.link), "Share Link".tr, null, () async {
                  Navigator.of(context).pop();
                  Share.share("View my website in https://assetlogistik.com");
                }, subWidget: Icon(Icons.copy)),
              ],
            ),
          );
        });
  }

  Future<String> getMitraCVLink(String url) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchMitraCV(url);
    return responseBody["Data"].toString();
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0/";
  }

  void onClickMap() {
    Get.toNamed(Routes.MAP_DETAIL_TRANSPORTER, arguments: [
      LatLng(double.parse(transporter.latitude),
          double.parse(transporter.longitude)),
      transporter.alamat,
    ]);
  }

  void showGoldInfo() {
    showDialog(
        context: Get.context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            // title: CustomText("DetailTransporterLabelKelengkapanDokumen".tr),
            content: Container(
              padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 8,
                  bottom: GlobalVariable.ratioWidth(Get.context) * 8,
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("assets/ic_gold.png"),
                            height: GlobalVariable.ratioWidth(Get.context) * 23,
                            fit: BoxFit.fitHeight,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 4),
                            child: CustomText('Gold Transporter',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6),
                                child: SvgPicture.asset(
                                  "assets/ic_close1,5.svg",
                                  color: Color(ListColor.colorBlue),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10,
                                )
                                // Icon(Icons.close,
                                //     color: Color(ListColor.color4)
                                )),
                      )
                    ],
                  ),
                  Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 10),
                  CustomText(
                      "        " +
                          "DetailTransporterLabelKelengkapanDokumen".tr,
                      textAlign: TextAlign.justify,
                      height: 1.2,
                      color: Color(ListColor.colorDarkGrey3),
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                  Container(
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 4),
                            child: SvgPicture.asset(
                              "assets/ic_check.svg",
                              color: Color(ListColor.colorBlue),
                              width: GlobalVariable.ratioWidth(Get.context) * 8,
                            )
                            // Icon(Icons.check,
                            //     color: Color(ListColor.colorBlue))
                            ),
                        Expanded(
                          child: CustomText('DetailTransporterLabelCopySTNK'.tr,
                              textAlign: TextAlign.justify,
                              height: 1.2,
                              color: Color(ListColor.colorDarkGrey3),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 4),
                            child: Container(
                                child: SvgPicture.asset(
                              "assets/ic_check.svg",
                              color: Color(ListColor.colorBlue),
                              width: GlobalVariable.ratioWidth(Get.context) * 8,
                            ))
                            // Icon(Icons.check,
                            //     color: Color(ListColor.colorBlue))
                            ),
                        Expanded(
                          child: CustomText(
                              'DetailTransporterLabelMelengkapiProfilPerusahaan'
                                  .tr,
                              textAlign: TextAlign.justify,
                              height: 1.2,
                              color: Color(ListColor.colorDarkGrey3),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 4),
                            child: SvgPicture.asset(
                              "assets/ic_check.svg",
                              color: Color(ListColor.colorBlue),
                              width: GlobalVariable.ratioWidth(Get.context) * 8,
                            )
                            // Icon(Icons.check,
                            //     color: Color(ListColor.colorBlue))
                            ),
                        Expanded(
                          child: CustomText(
                              'DetailTransporterLabelKelengkapanPersyaratan'.tr,
                              textAlign: TextAlign.justify,
                              height: 1.2,
                              color: Color(ListColor.colorDarkGrey3),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 10),
                  CustomText("        " + "DetailTransporterLabelKeputusan".tr,
                      textAlign: TextAlign.justify,
                      height: 1.2,
                      color: Color(ListColor.colorDarkGrey3),
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ],
              ),
            ),
          );
        });
  }
}
