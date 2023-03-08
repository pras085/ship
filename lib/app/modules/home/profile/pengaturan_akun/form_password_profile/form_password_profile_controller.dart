import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class FormPasswordProfileController extends GetxController {
  final isShowPassword = false.obs;

  final formKey = GlobalKey<FormState>().obs;

  TextEditingController passwordController = TextEditingController();

  // cek validasi di view
  var isValid = true.obs;
  var isFilled = false.obs;
  
  var field1 = "".obs;

  @override
  void onInit() async {
    super.onInit();
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

  void togglePassword() {
    isShowPassword.value = !isShowPassword.value;
  }
}
