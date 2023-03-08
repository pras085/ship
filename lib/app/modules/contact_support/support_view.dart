import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/contact_support/support_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/test_form_field_widget2.dart';
import 'package:validators/validators.dart' as validator;

class SupportView extends GetView<SupportController> {
  final form = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var emptyMessage = false.obs;

  double widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText('Contact Support'),
        ),
        body: SafeArea(
            child: Center(
          child: Form(
            key: form,
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextFormFieldWidget2(
                  title: 'title'.tr,
                  validator: (String value) {
                    if (value.isEmpty) return 'Field cannot be empty';
                    return null;
                  },
                  width: widthContent(context),
                  isPassword: false,
                  isEmail: false,
                  isPhoneNumber: false,
                  textEditingController: titleController,
                  darkBackground: false,
                ),
              ),
              Container(
                width: widthContent(context),
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: CustomText('message'.tr, color: Colors.black)),
                    Obx(() => Container(
                            child: CustomTextField(
                          context: Get.context,
                          controller: messageController,
                          newInputDecoration: InputDecoration(
                              fillColor: Colors.white,
                              errorMaxLines: 2,
                              contentPadding: EdgeInsets.all(10.0),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.color4), width: 5.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorText: emptyMessage.value
                                  ? "Field cannot be empty"
                                  : null),
                          minLines: 6,
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                        )))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  color: Color(ListColor.color4),
                  onPressed: () {
                    emptyMessage.value = messageController.text.isEmpty;
                    if (form.currentState.validate() &&
                        messageController.text.isNotEmpty) {
                      controller.sendSupport(
                          titleController.text, messageController.text);
                    }
                  },
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomText('Submit Report',
                      color: Colors.white, fontSize: 18),
                ),
              )
            ]),
          ),
        )));
  }
}
