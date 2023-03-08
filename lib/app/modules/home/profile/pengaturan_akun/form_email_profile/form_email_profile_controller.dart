import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class FormEmailProfileController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;

  TextEditingController emailController = TextEditingController();

  // cek validasi di view
  var isValid = true.obs;
  var isFilled = false.obs;
  var email = ''.obs;

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

  bool checkRegex(){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(emailController.text);
    if(emailValid) return true;
    return false;
  }
}
