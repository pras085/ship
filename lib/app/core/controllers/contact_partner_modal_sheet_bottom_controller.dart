import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/api/get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_model.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPartnerModalSheetBottomController extends GetxController {
  final contactData = ContactTransporterByShipperModel().obs;

  void showContact(String userID,
      {ContactTransporterByShipperModel contactDataParam,
      void Function(ContactTransporterByShipperModel) onReceiveContact,
      @required String transporterID, String title}) {
    contactData.value = contactDataParam;
    if (title == null) title = "GlobalContactLabelTitle".tr;
    if (contactData.value == null) {
      _getContact(transporterID, onReceiveContact);
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
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Obx(
            () => contactData.value == null
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
                          margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 4,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 17),
                          child: Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 38,
                            height: GlobalVariable.ratioWidth(Get.context) * 3,
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorLightGrey16),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        4))),
                          )),
                      Container(
                        padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 12,
                            right: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 0),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Get.back();
                            //     },
                            //     child: Icon(
                            //       Icons.close,
                            //       size: 30,
                            //     ),
                            //   ),
                            // ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: CustomText(
                                    title,
                                    color: Color(ListColor.colorBlue),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      8),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      child: SvgPicture.asset(
                                    "assets/ic_close1,5.svg",
                                    color: Color(ListColor.colorBlack),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            15,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            15,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _picWidget(
                          "GlobalContactLabelPIC1".tr,
                          contactData.value.namePic1,
                          contactData.value.contactPic1,
                          contactData.value.isWa1),
                      contactData.value.namePic1.replaceAll("-", "").isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      _picWidget(
                          "GlobalContactLabelPIC2".tr,
                          contactData.value.namePic2,
                          contactData.value.contactPic2,
                          contactData.value.isWa2),
                      contactData.value.namePic2.replaceAll("-", "").isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      _picWidget(
                          "GlobalContactLabelPIC3".tr,
                          contactData.value.namePic3,
                          contactData.value.contactPic3,
                          contactData.value.isWa3),
                      contactData.value.namePic3.replaceAll("-", "").isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      if (contactData.value.phone.isNotEmpty) _optionView(
                          SvgPicture.asset(
                            "assets/contact_phone_icon.svg",
                            width:
                                GlobalVariable.ratioWidth(Get.context) * 16.5,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 16.5,
                          ),
                          "GlobalContactLabelEmergencyNumber".tr,
                          phoneText(contactData.value.phone), () async {
                        Get.back();
                        await callByPhone(contactData.value.phone);
                      }, subTextColor: Color(ListColor.color4)),
                      contactData.value.phone.isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      if (contactData.value.phoneWA.isNotEmpty) _optionView(
                          Image(
                            image: AssetImage("assets/ic_whatsapp.png"),
                            width: GlobalVariable.ratioWidth(Get.context) * 22,
                            height: GlobalVariable.ratioWidth(Get.context) * 22,
                            fit: BoxFit.cover,
                          ),
                          "GlobalContactLabelEmergencyWA".tr,
                          phoneText(contactData.value.phoneWA), () async {
                        Get.back();
                        openWhatsapp(contactData.value.phoneWA);
                      }, subTextColor: Color(ListColor.color4)),
                      contactData.value.phoneWA.isNotEmpty
                          ? _lineSaparator()
                          : SizedBox.shrink(),
                      _optionView(
                        SvgPicture.asset(
                          "assets/contact_message_icon.svg",
                          height: GlobalVariable.ratioWidth(Get.context) * 22,
                        ),
                        "GlobalContactLabelInbox".tr,
                        "GlobalContactLabelConnectToInbox".tr,
                        () async {
                          await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                          Chat.toID(contactData.value.userID);
                          // Get.back();
                          // openPhoneDialog();
                        },
                      ),
                      _lineSaparator(),
                      if (contactData.value.email.isNotEmpty) _optionView(
                        SvgPicture.asset(
                          "assets/ic_message.svg",
                          height: GlobalVariable.ratioWidth(Get.context) * 22,
                        ),
                        // Icon(Icons.email,
                        //     color: Color(0xFFFFA217),
                        //     size: GlobalVariable.ratioWidth(Get.context) * 22),
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
              Container(height: GlobalVariable.ratioHeight(Get.context) * 4),
              subText == null
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
    var fixPhone = phone.replaceAll("-", "");
    var stringPhone = "";
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
                          size: GlobalVariable.ratioHeight(Get.context) * 24),
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
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(ListColor.colorGrey3));
  }

  Widget _picWidget(
      String title, String namePic, String contactPic, bool isWa) {
    return namePic == "-"
        ? SizedBox.shrink()
        : Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16, vertical: GlobalVariable.ratioWidth(Get.context) * 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textTitle(title),
                Container(width: 13),
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
                                    GlobalVariable.ratioHeight(Get.context) *
                                        4),
                            CustomText(contactPic,
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
                            "assets/contact_phone_icon.svg",
                            width:
                                GlobalVariable.ratioWidth(Get.context) * 13.5,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 13.5,
                          ),
                        ),
                      ),
                      !isWa
                          ? SizedBox.shrink()
                          : Container(
                              margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                  openWhatsapp(contactPic);
                                },
                                child: Image(
                                  image: AssetImage("assets/ic_whatsapp.png"),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18,
                                  fit: BoxFit.cover,
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
    ContactTransporterByShipperResponseModel response =
        await GetContactTransporterByShipper.getContact(transporterID);
    if (response != null) {
      contactData.value = response.contactTransporterByShipperModel;
    }
    if (onReceiveContact != null) onReceiveContact(contactData.value);
  }
}
