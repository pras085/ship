import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

import '../../global_variable.dart';

class DownloadUtils {

  static doDownload({
    @required BuildContext context,
    @required String url,
    VoidCallback onDownloadComplete,
    bool isShare = false,
  }) {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 8),
          ),
          child: _DownloadDialog(
            url: url,
            isShare: isShare,
            onDownloadComplete: onDownloadComplete,
          ),
        );
      },
    );
  }

}

class _DownloadDialog extends StatefulWidget {

  final bool isShare;
  final String url;
  final VoidCallback onDownloadComplete;

  const _DownloadDialog({
    Key key,
    @required this.url,
    this.isShare = false,
    this.onDownloadComplete,
  }) : super(key: key);

  @override
  __DownloadDialogState createState() => __DownloadDialogState();
}

class __DownloadDialogState extends State<_DownloadDialog> {

  String filePath = '';
  String fileName = '';
  ReceivePort _port = ReceivePort();
  var onDownloading = false;
  double downloadProgress = null;
  String downloadId;

  @override
  void initState() {
    super.initState();

    // CODE FROM FILE EXAMPLE
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);

    downloadFile(widget.url);
    
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
      if (mounted) setState(() { downloadProgress = message[2] / 100;});
      print(message[2].toString());
      if (message[2] == 100.0 && onDownloading) {
        onDownloading = false;
        setState(() {});
        Get.back();
        if (!widget.isShare) {
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
    var status = await Permission.storage.request();
    if (status.isGranted) {
      onDownloading = true;
      filePath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
      fileName = "${DateFormat('ddMMyyyyhhmmss').format(DateTime.now())}.${url.split(".").last}";
      downloadId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: filePath,
        showNotification: true,
        fileName: fileName,
        openFileFromNotification: true
      );
      setState(() {});
    } else {
      print('Permission Denied!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 8),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText("Downloading...",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 8,
            ),
            LinearProgressIndicator(
              value: downloadProgress,
              valueColor: AlwaysStoppedAnimation(Color(ListColor.colorBlue)),
              backgroundColor: Color(ListColor.colorGrey3),
            ),
            CustomText("${((downloadProgress ?? 0) * 100).toStringAsFixed(0)}%",
              color: Color(ListColor.colorBlue),
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _button(
                  context: context,
                  onTap: () {
                    FlutterDownloader.cancel(taskId: downloadId);
                    Get.back();
                  },
                  backgroundColor: Color(ListColor.colorBlue),
                  customWidget: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(context) * 4,
                      horizontal: GlobalVariable.ratioWidth(context) * 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel,
                          color: Colors.black,
                        ),
                        CustomText("Cancel",
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({
    @required BuildContext context,
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * marginLeft,
          GlobalVariable.ratioWidth(context) * marginTop,
          GlobalVariable.ratioWidth(context) * marginRight,
          GlobalVariable.ratioWidth(context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(context).size.width
              : null
          : GlobalVariable.ratioWidth(context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * paddingLeft,
                  GlobalVariable.ratioWidth(context) * paddingTop,
                  GlobalVariable.ratioWidth(context) * paddingRight,
                  GlobalVariable.ratioWidth(context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius)),
              child: Center(
                child: customWidget == null
                    ? CustomText(
                        text ?? "",
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: color,
                      )
                    : customWidget,
              ),
            )),
      ),
    );
  }

}