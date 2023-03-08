import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_ark_get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/get_contact_shipper_by_transporter_ark.dart';
import 'package:muatmuat/app/core/function/api/get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/contact_shipper_model_ark.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/modules/ARK/chat/chat_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomARKContactPartnerModalSheetBottomController extends GetxController {
  final contactData = ContactTransporterByShipperModel().obs;
  var contactWAData = ContactTransporterByShipperModel().obs;
  void showContact(
      {ContactTransporterByShipperModel contactDataParam,
      void Function(ContactTransporterByShipperModel) onReceiveContact,
      String firstMessage = "",
      @required String transporterID}) {
    contactData.value = contactDataParam;
    // contactWAData.value = null;
    if (contactData.value == null) {
      _getContact(transporterID, onReceiveContact);
      _getWA(transporterID, onReceiveContact);
    }
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20))),
        context: Get.context,
        builder: (context) {
          return Obx(
            () => contactData.value == null || contactWAData == null
                ? Container(
                    width: MediaQuery.of(Get.context).size.width,
                    height: 200,
                    child: Center(
                        child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator())))
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Container(
                            width: 38,
                            height: 4,
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorLightGrey16),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20))),
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 11,
                            vertical: 12),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                // child: Icon(
                                //   Icons.close,
                                //   size: 30,
                                // ),
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        'ic_close_simple.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24),
                              ),
                            ),
                            Container(
                              child: CustomText("GlobalContactLabelTitle".tr,
                                  color: Color(ListColor.colorBlue),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      _picWidget(
                          "GlobalContactLabelPIC1".tr,
                          contactData.value.namePic1,
                          contactData.value.contactPic1 ?? "0",
                          // contactData.value.isWa1),
                          contactWAData.value.contactPic1 == null
                              ? false
                              : contactData.value.contactPic1 ==
                                  contactWAData.value.contactPic1),
                      contactData.value.namePic1.replaceAll("-", "").isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      _picWidget(
                          "GlobalContactLabelPIC2".tr,
                          contactData.value.namePic2,
                          contactData.value.contactPic2 ?? "0",
                          // contactData.value.isWa2),
                          contactWAData.value.contactPic2 == null
                              ? false
                              : contactData.value.contactPic2 ==
                                  contactWAData.value.contactPic2),
                      contactData.value.namePic2.replaceAll("-", "").isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      _picWidget(
                          "GlobalContactLabelPIC3".tr,
                          contactData.value.namePic3,
                          contactData.value.contactPic3 ?? "0",
                          // contactData.value.isWa3),
                          contactWAData.value.contactPic3 == null
                              ? false
                              : contactData.value.contactPic3 ==
                                  contactWAData.value.contactPic3),
                      contactData.value.namePic3.replaceAll("-", "").isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      _optionView(
                          SvgPicture.asset(
                            GlobalVariable.imagePath + "socmed_logo_call.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 22,
                            height: GlobalVariable.ratioWidth(Get.context) * 22,
                          ),
                          "GlobalContactLabelEmergencyNumber".tr,
                          phoneText(contactData.value.phone), () async {
                        Get.back();
                        await callByPhone(contactData.value.phone);
                      }, subTextColor: Color(ListColor.color4)),
                      contactData.value.phone.isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      _optionView(
                          SvgPicture.asset(
                            GlobalVariable.imagePath +
                                "socmed_logo_whatsapp_contact.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 22,
                            height: GlobalVariable.ratioWidth(Get.context) * 22,
                          ),
                          "GlobalContactLabelEmergencyWA".tr,
                          phoneText(contactData.value.phoneWA), () async {
                        Get.back();
                        openWhatsapp(contactData.value.phoneWA);
                      }, subTextColor: Color(ListColor.color4)),
                      contactData.value.phoneWA.isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          await GetToPage.toNamed<ChatController>(Routes.CHAT,
                              arguments: [
                                // transporterID, //dataUser
                                "219",
                                firstMessage,
                              ]);
                        },
                        child: _optionView(
                          SvgPicture.asset(
                            GlobalVariable.imagePath + "socmed_logo_inbox.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 22,
                            height: GlobalVariable.ratioWidth(Get.context) * 22,
                          ),
                          "GlobalContactLabelInbox".tr,
                          "GlobalContactLabelConnectToInbox".tr,
                          () async {
                            // Get.back();
                            // openPhoneDialog();
                          },
                        ),
                      ),
                      _lineSaparator(),
                      _optionView(
                        SvgPicture.asset(
                          GlobalVariable.imagePath + "socmed_logo_email.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 22,
                          height: GlobalVariable.ratioWidth(Get.context) * 22,
                        ),
                        "GlobalContactLabelEmail".tr,
                        contactData.value.email,
                        // transporter.email.isEmpty
                        //     ? transporter.nama + "@gmail.com"
                        //     : transporter.email,
                        () async {
                          Get.back();
                          openEmail(contactData.value.email);
                        },
                      ),
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 7)
                    ],
                  ),
          );
        });
  }

  Widget _optionView(
      Widget widget, String text, String subText, Function function,
      {Color subTextColor: Colors.grey}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
          vertical: GlobalVariable.ratioWidth(Get.context) * 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGrey3)),
              Container(height: GlobalVariable.ratioWidth(Get.context) * 4),
              subText.isNull
                  ? SizedBox.shrink()
                  : CustomText(subText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
            ],
          )),
          Container(
              margin: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 10),
              child: GestureDetector(onTap: function, child: widget)),
        ],
      ),
    );
  }

  Future<void> callByPhone(String phone) async {
    await launch("tel:$phone");
  }

  void openWhatsapp(String phone) {
    FlutterOpenWhatsapp.sendSingleMessage(
        phone[0] == "0" ? "+62${phone.substring(1)}" : phone, "");
  }

  void openEmail(String path) {
    var emailUri = Uri(
      scheme: "mailto",
      path: path,
    );
    launch(emailUri.toString());
  }

  String phoneText(String phone) {
    // var fixPhone = phone.replaceAll("-", "");
    var fixPhone = phone.toString();
    var stringPhone = "";
    // print(fixPhone.length);
    for (var index = 0; index < fixPhone.length; index++) {
      if (index != 0 && index % 4 == 0) {
        stringPhone += "-${fixPhone[index]}";
      } else {
        stringPhone += fixPhone[index];
      }
    }
    return stringPhone;
  }

  void openPhoneDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: Get.context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 8, left: 18, right: 18, bottom: 18),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Icon(Icons.close_rounded,
                          size: GlobalVariable.ratioWidth(Get.context) * 24),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: CustomText("No Telepon yang Bisa Dihubungi",
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)))
                  ],
                ),
              ),
              _optionView(
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CustomText("PIC 1")),
                  "Thomas",
                  "0812392939291", () async {
                Get.back();
                await callByPhone("0812392939291");
              }),
              _optionView(
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CustomText("PIC 2")),
                  "Danny",
                  "08572993857", () async {
                Get.back();
                await callByPhone("08572993857");
              }),
              _optionView(
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CustomText("PIC 3")),
                  "-",
                  "-",
                  () async {}),
              _optionView(
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CustomText("Nomer Darurat")),
                  "Johannes",
                  "081292993959", () async {
                Get.back();
                await callByPhone("081292993959");
              }),
            ],
          );
        });
  }

  Widget _textTitle(String title) {
    return CustomText(title,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(ListColor.colorGrey3));
  }

  Widget _picWidget(
      String title, String namePic, String contactPic, bool isWa) {
    return namePic == "-"
        ? SizedBox.shrink()
        : Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 73,
                    child: _textTitle(title)),
                Expanded(
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(namePic,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            Container(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 4),
                            CustomText(phoneText(contactPic),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16),
                        child: GestureDetector(
                          onTap: () async {
                            Get.back();
                            await callByPhone(contactPic);
                          },
                          child: SvgPicture.asset(
                            GlobalVariable.imagePath + "socmed_logo_call.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 18,
                            height: GlobalVariable.ratioWidth(Get.context) * 18,
                          ),
                        ),
                      ),
                      !isWa
                          ? SizedBox.shrink()
                          : Container(
                              margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      16),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                  openWhatsapp(contactPic);
                                },
                                child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      "socmed_logo_whatsapp_contact.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18,
                                ),
                              ),
                            ),
                    ])),
              ],
            ),
          );
  }

  Widget _lineSaparator() {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        height: GlobalVariable.ratioWidth(Get.context) * 0.5,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey5).withOpacity(0.29));
  }

  Future _getContact(String transporterID,
      void Function(ContactTransporterByShipperModel) onReceiveContact) async {
    ContactShipperModel response =
        await CustomArkGetContactTransporterByShipper.getContact(transporterID);
    print(response);
    if (response != null) {
      contactData.value = response.contactTransporterByShipperModel;
      print(response.contactTransporterByShipperModel);
    }
    if (onReceiveContact != null) onReceiveContact(contactData.value);
  }

  Future _getWA(String transporterID,
      void Function(ContactTransporterByShipperModel) onReceiveContact) async {
    ContactShipperModel response =
        await CustomArkGetContactTransporterByShipper.getWA(transporterID);
    if (response != null) {
      contactWAData.value = response.contactTransporterByShipperModel;
      print(response.contactTransporterByShipperModel);
    }
    if (onReceiveContact != null) onReceiveContact(contactData.value);
  }
}
