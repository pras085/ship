import 'dart:isolate';
import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:ext_storage/ext_storage.dart';

class DetailPratenderController extends GetxController {
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  ReceivePort _port = ReceivePort();
  String downloadId;

  @override
  void onInit() async {
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);
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
      if (message[2] == 100.0 && onDownloading.value) {
        onDownloading = false.obs;
        CustomToast.show(context: Get.context, message: "Download complete'");
      }
    });
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping("downloader_send_port");
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void testDownload(String url) async {
    var savedLocation =
        (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    downloadId = await FlutterDownloader.enqueue(
        url: url,
        // savedDir: externalDir.path,
        savedDir: savedLocation,
        showNotification: true,
        openFileFromNotification: true);
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0/";
    // return ExtStorage.getExternalStorageDirectory();
  }
}
