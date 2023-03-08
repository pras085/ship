import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class LoadingDialog {
  BuildContext context;
  final _keyDialog = GlobalKey<State>();
  bool _showDialog = false;

  LoadingDialog(this.context);

  Future showLoadingDialog() async {
    if (!_showDialog) {
      _showDialog = true;
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new WillPopScope(
                onWillPop: () async => false,
                child: SimpleDialog(
                    key: _keyDialog,
                    backgroundColor: Colors.black54,
                    children: <Widget>[
                      Center(
                        child: Column(children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            'GlobalLabelDialogLoading'.tr,
                            color: Colors.blueAccent,
                          )
                        ]),
                      )
                    ]));
          });
    }
  }

  void dismissDialog() {
    if (_showDialog) {
      Get.back();
    }
  }
}
