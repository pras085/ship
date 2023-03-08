import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/transporter_model_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_bottom_sheet_base.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoPemenangLelangContactBottomSheet
    extends GetView<ZoPemenangLelangController> {
  final Transporter contact;
  final bool isLoading;

  const ZoPemenangLelangContactBottomSheet({
    Key key,
    this.contact,
    this.isLoading = false,
  }) : super(key: key);

  static ShapeBorder getShape() =>
      ZoPemenangLelangBaseBottomSheetBase.getShape();

  static Color getBackgroundColor() =>
      ZoPemenangLelangBaseBottomSheetBase.getBackgroundColor();

  Future<void> callByPhone(String phone) async {
    await launch("tel://$phone");
  }

  Future<void> smsByPhone(String phone) async {
    await launch("sms://$phone");
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
    print('phone: $phone');
    if (phone == null || phone.trim().isEmpty || phone.trim() == '-')
      return null;
    var fixPhone = phone.replaceAll("-", "");
    var stringPhone = "";
    for (var index = 0; index < fixPhone.length; index++) {
      if (index != 0 && index % 4 == 0) {
        stringPhone += "-${fixPhone[index]}";
      } else {
        stringPhone += fixPhone[index];
      }
    }
    print('stringPhone: $stringPhone');
    return stringPhone;
  }

  @override
  Widget build(BuildContext context) {
    return ZoPemenangLelangBaseBottomSheetBase(
      title:
          "LelangMuatPesertaLelangPesertaLelangLabelTitleAndaInginMenghubungiVia",
      rows: [
        if (isLoading || contact == null) ...[
          Container(
            height: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text('Data Tidak Ditemukan'.tr),
            ),
          ),
        ] else ...[
          _PICWidget(
            index: 1,
            name: contact.namaPic1,
            number: phoneText(contact.contactPic1),
            hasWA: contact.isWa1,
            onTap: () async => await callByPhone(contact.contactPic1),
            onWATap: () => openWhatsapp(contact.contactPic1),
          ),
          _PICWidget(
            index: 2,
            name: contact.namaPic2,
            number: phoneText(contact.contactPic2),
            hasWA: contact.isWa2,
            onTap: () async => await callByPhone(contact.contactPic2),
            onWATap: () => openWhatsapp(contact.contactPic2),
          ),
          _PICWidget(
            index: 3,
            name: contact.namaPic3,
            number: phoneText(contact.contactPic3),
            hasWA: contact.isWa3,
            onTap: () async => await callByPhone(contact.contactPic3),
            onWATap: () => openWhatsapp(contact.contactPic3),
          ),
          _ContactWidget(
            title: "LelangMuatPesertaLelangPesertaLelangLabelTitleNoDarurat",
            contact: phoneText(contact.emergencyHP),
            asset: "assets/ic_telp.svg",
            onTap: () async => await callByPhone(contact.emergencyHP),
          ),
          _ContactWidget(
            title: 'LelangMuatPesertaLelangPesertaLelangLabelTitleWADarurat',
            contact: phoneText(contact.emergencyWA),
            asset: "assets/ic_wa.png",
            onTap: () => openWhatsapp(contact.emergencyWA),
          ),
          _ContactWidget(
            title: 'Inbox'.tr,
            description: 'Terhubung dengan inbox Transporter'.tr,
            contact: 'Terhubung dengan inbox Transporter'.tr,
            // phoneText(contact.inbox) ??
            //   phoneText(contact.emergencyHP) ??
            //   phoneText(contact.emergencyWA),
            asset: "assets/ic_message_local.svg",
            onTap: () async => await smsByPhone(contact.emergencyHP),
          ),
          _ContactWidget(
            title: 'Email'.tr,
            contact: contact.email == null || contact.email.isEmpty
                ? null
                : contact.email,
            asset: "assets/ic_message_email.svg",
            onTap: () => openEmail(contact.email),
          ),
        ],
      ],
    );
  }
}

class _PICWidget extends StatelessWidget {
  final int index;
  final String name;
  final String number;
  final bool hasWA;
  final void Function() onTap;
  final void Function() onWATap;

  const _PICWidget({
    Key key,
    this.index,
    this.name,
    this.number,
    this.hasWA = false,
    this.onTap,
    this.onWATap,
  }) : super(key: key);

  bool _hasValue(String string) =>
      (string != null && string.trim().isNotEmpty && string.trim() != '-');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
        vertical: GlobalVariable.ratioWidth(context) * 12,
      ),
      child: Row(
        children: [
          Container(
            width: GlobalVariable.ratioWidth(context) * 78,
            child: CustomText(
              "PIC ${index ?? ''}${_hasValue(number) ? '\n' : ''}".tr,
              color: Color(ListColor.colorLightGrey14),
              fontSize: GlobalVariable.ratioFontSize(context) * 14,
              fontWeight: FontWeight.w600,
              height: GlobalVariable.ratioFontSize(context) * (16.8 / 14),
            ),
          ),
          Expanded(
            child: CustomText(
              (_hasValue(number)
                      ? '${_hasValue(name) ? name : 'PIC $index'}\n$number'
                      : '-')
                  .tr,
              color: Color(ListColor.colorBlack),
              fontSize: GlobalVariable.ratioFontSize(context) * 14,
              fontWeight: FontWeight.w600,
              height: GlobalVariable.ratioFontSize(context) * (16.8 / 14),
            ),
          ),
          if (_hasValue(number))
            GestureDetector(
              onTap: onTap ??
                  () {
                    print("$name phone tapped");
                  },
              child: SizedBox(
                height: GlobalVariable.ratioFontSize(context) * 18,
                width: GlobalVariable.ratioFontSize(context) * 18,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/ic_telp.svg",
                    width: GlobalVariable.ratioFontSize(context) * 18,
                  ),
                ),
              ),
            ),
          if (_hasValue(number) && hasWA) ...[
            SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
            GestureDetector(
              onTap: onWATap ??
                  () {
                    print("$name WA tapped");
                  },
              child: SizedBox(
                height: GlobalVariable.ratioFontSize(context) * 18,
                width: GlobalVariable.ratioFontSize(context) * 18,
                child: Center(
                  child: Image.asset(
                    "assets/ic_wa.png",
                    width: GlobalVariable.ratioFontSize(context) * 18,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ContactWidget extends StatelessWidget {
  final String title;
  final String contact;
  final String description;
  final String asset;
  final void Function() onTap;

  const _ContactWidget({
    Key key,
    this.title,
    this.contact,
    this.description,
    this.asset,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
        vertical: GlobalVariable.ratioWidth(context) * 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText(
                  (title ?? "Kontak Lainnya").tr,
                  color: Color(ListColor.colorLightGrey14),
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                  height: GlobalVariable.ratioFontSize(context) * (14.4 / 12),
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
                CustomText(
                  (contact == null ? '-' : description ?? contact).tr,
                  color: Color(ListColor.colorBlack),
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                  height: GlobalVariable.ratioFontSize(context) * (14.4 / 12),
                ),
              ],
            ),
          ),
          if (contact != null &&
              contact.trim().isNotEmpty &&
              contact.trim() != '-')
            GestureDetector(
              onTap: onTap ??
                  () {
                    print("$title tapped");
                  },
              child: SizedBox(
                height: GlobalVariable.ratioFontSize(context) * 22,
                width: GlobalVariable.ratioFontSize(context) * 22,
                child: Center(
                  child: asset.contains('.svg')
                      ? SvgPicture.asset(
                          asset,
                          width: GlobalVariable.ratioFontSize(context) * 22,
                        )
                      : Image.asset(
                          asset,
                          width: GlobalVariable.ratioFontSize(context) * 22,
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
