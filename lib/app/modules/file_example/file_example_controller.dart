import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class FileExampleController extends GetxController {
  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var processing = false.obs;
  var tapDownload = false;
  String filePath = "";
  String downloadId;
  var url = "".obs;
  
  @override
  void onInit() {
    super.onInit();
    url.value = Get.arguments;
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
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

  static void downloadCallBack(id, status, progress) {
    SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0/";
  }

  Future downloadFile(String url) async {
    print(url);
    print(url.split(".")[url.split(".").length - 1]);
    var status = await Permission.storage.request();
    if (status.isGranted) {
      onDownloading.value = true;
      onProgress.value = 0.0;
      processing.value = true;
      var savedLocation = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
      processing.value = false;
      downloadId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: savedLocation,
        showNotification: true,
        fileName: "${DateFormat('ddMMyyyyhhmmss').format(DateTime.now())}.${url.split(".")[url.split(".").length - 1]}",
        openFileFromNotification: true
      );
    } else {
      print('Permission Denied!');
    }
  }
}