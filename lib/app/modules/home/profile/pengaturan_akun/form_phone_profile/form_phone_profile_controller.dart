import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class FormPhoneProfileController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;

  TextEditingController phoneController = TextEditingController();

  // cek validasi di view
  var isValid = true.obs;
  var isFilled = false.obs;

  var tokenFromOtp = "".obs;

  @override
  void onInit() {
    super.onInit();
    tokenFromOtp.value = Get.arguments;
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          "Please Wait....",
                          color: Colors.blueAccent,
                        )
                      ]),
                    )
                  ]));
        });
  }
}
