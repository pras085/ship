import 'dart:io';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/core/function/api/get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';
import 'dart:isolate';

import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class FakeHomeController extends GetxController {
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var processing = false.obs;
  var tapDownload = false;
  ReceivePort _port = ReceivePort();
  String downloadId;
  String fileName = "";
  String filePath = "";

  var contacts = Map().obs;
  var show = false.obs;
  var loadMedia = true;
  var loadContact = true;
  var loadDetail = true;
  var loadProfile = true.obs;
  var loadVideo = true.obs;
  var loadTestimony = true.obs;

  var transporterID = "".obs;

  ContactPartnerModalSheetBottomController _contactModalBottomSheetController;

  @override
  void onInit() {
    super.onInit();
    // PENYESUAIAN PROFILE PENGGUNA LAIN
    transporterID.value = "102";
    fileName = "CV.pdf";
    _contactModalBottomSheetController = Get.put(ContactPartnerModalSheetBottomController());
    getContact();
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void getContact() async {
    // PENYESUAIAN PROFILE PENGGUNA LAIN
    ContactTransporterByShipperResponseModel response = await GetContactTransporterByShipper.getContact(transporterID.value);
    contacts.clear();
    contacts.addAll(response.contactDataJson);
    contacts.value.remove("Avatar");
    loadContact = false;
    checkLoadAll();
  }

  void contactPartner() {
    _contactModalBottomSheetController.showContact(
      "",
      title: 'UserProfileIndexHubungi'.tr,
      transporterID: transporterID.value.toString(),
    );
  }

  void checkLoadAll() {
    show.value = !loadMedia && !loadContact && !loadDetail;
  }

  static void downloadCallBack(id, status, progress) {
    SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, "downloader_send_port");
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
            message: "DetailTransporterLabelDownloadComplete".tr
          );
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
      print(await _findLocalPath());
      print(Platform.pathSeparator);
      print(fileName);
      var savePath = (await _findLocalPath()) +
          Platform.pathSeparator +
          'Download' +
          Platform.pathSeparator +
          fileName;
      if (await File(savePath).exists()) {
        GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title: "Warning",
          message: "File sebelumnya telah didownload, apakah yakin untuk men-download ulang?",
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
            if (error.isEmpty) {
              downloadFile();
            } else {
              GlobalAlertDialog.showDialogError(context: Get.context, message: error, isDismissible: false);
            }
          }
        );
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
        var savedLocation = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
        var mitraURL = await getMitraCVLink("https://assetlogistik.com/generate/profile_transporter/?id=${transporterID.value}&app=1");
        processing.value = false;
        downloadId = await FlutterDownloader.enqueue(
          url: mitraURL,
          savedDir: savedLocation,
          showNotification: true,
          fileName: fileName,
          openFileFromNotification: true
        );
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

  Future<String> getMitraCVLink(String url) async {
    var responseBody = await ApiHelper(
      context: Get.context,
      isShowDialogLoading: false,
      isShowDialogError: false)
    .fetchMitraCV(url);
    return responseBody["Data"].toString();
  }

  Future<String> _findLocalPath() async {
    print('tes');
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0/";
  }
}