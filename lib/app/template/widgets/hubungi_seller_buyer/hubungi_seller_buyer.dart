import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/modules/buyer/api_buyer.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:url_launcher/url_launcher.dart';

class HubungiSellerBuyerComponent extends StatefulWidget {
  final Map data;

  HubungiSellerBuyerComponent({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _HubungiSellerBuyerComponentState createState() => _HubungiSellerBuyerComponentState();
}

class _HubungiSellerBuyerComponentState extends State<HubungiSellerBuyerComponent> {
  Map args;
  var dataModelResponse = ResponseState<Map>();
  var idSeller;

  @override
  void initState() {
    super.initState();
    print('Without COmpon');

    if (widget.data != null) {
      args = widget.data;
    }
    fetchContactSeller();
  }

  Future<void> fetchContactSeller() async {
    try {
      setState(() {
        dataModelResponse = ResponseState.loading();
        idSeller = "${args['data_seller']['ID']}";
        print(idSeller);
      });

      var response = await ApiBuyer(context: Get.context).getContactSellerProfile(idSeller);
      if (response != null) {
        if (response['Data'] != null && response['Message']['Code'] == 200) {
          setState(() {
            dataModelResponse = ResponseState.complete(response["Data"]);
          });
        } else {
          // error
          if (response["Message"] != null && response["Message"]["Text"] != null) {
            throw ("${response["Message"]["Text"]}");
          }
          throw ("Data tidak ada!");
        }
      } else {
        // error
        throw ("Data tidak ada!");
      }
    } catch (e) {
      print("ERROR :: $e");
      setState(() {
        dataModelResponse = ResponseState.error("$e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (c) {
      if (dataModelResponse.state == ResponseStates.COMPLETE) {
        final dataContact = dataModelResponse.data;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                  color: Color(ListColor.colorGreyTemplate7),
                ),
                width: GlobalVariable.ratioWidth(context) * 38,
                height: GlobalVariable.ratioWidth(context) * 3,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 6,
                  bottom: GlobalVariable.ratioWidth(context) * 15,
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 24,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'ic_close_grey.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        "Anda Ingin Menghubungi Via",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: GlobalVariable.ratioWidth(context) * 8), // SUDAH DIKURANG MARGIN ATASNYA
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (dataContact['NamePic1'] != null && dataContact['NamePic1'] != '-')
                    contentPIC(
                      context: context,
                      title: 'PIC 1',
                      name: '${dataContact['NamePic1']}',
                      phone: '${dataContact['PhonePic1']}',
                      onCallTap: () => openDialPad('${dataContact['PhonePic1']}'),
                      onWaTap: () => launchWhatsApp('${dataContact['PhonePic1']}'),
                    ),
                  if (dataContact['NamePic2'] != null && dataContact['NamePic2'] != '-')
                    contentPIC(
                      context: context,
                      title: 'PIC 2',
                      name: dataContact['NamePic2'],
                      phone: dataContact['PhonePic2'],
                      onCallTap: () => openDialPad(dataContact['PhonePic2'].toString()),
                      onWaTap: () => launchWhatsApp(dataContact['PhonePic2'].toString()),
                    ),
                  if (dataContact['NamePic3'] != null && dataContact['NamePic3'] != '-')
                    contentPIC(
                      context: context,
                      title: 'PIC 3',
                      name: dataContact['NamePic2'],
                      phone: dataContact['PhonePic3'],
                      onCallTap: () => openDialPad(dataContact['PhonePic3'].toString()),
                      onWaTap: () => launchWhatsApp(dataContact['PhonePic3'].toString()),
                    ),
                  content(
                    context: context,
                    title: 'No Telepon',
                    value: dataContact['EmergencyPhone'] ?? '',
                    icon: SvgPicture.asset(
                      'assets/detail_compro_buyer/ic_blue_phone_buyer.svg',
                      height: GlobalVariable.ratioWidth(context) * 22,
                      width: GlobalVariable.ratioWidth(context) * 22,
                      color: Color(ListColor.colorGreenTemplate),
                    ),
                    onTap: () => openDialPad(dataContact['EmergencyPhone']),
                  ),
                  content(
                    context: context,
                    title: 'WhatsApp',
                    value: dataContact['EmergencyWA'] ?? '',
                    icon: Image.asset(
                      'assets/ic_whatsapp.png',
                      height: GlobalVariable.ratioWidth(context) * 22,
                      width: GlobalVariable.ratioWidth(context) * 22,
                    ),
                    onTap: () => launchWhatsApp(dataContact['EmergencyWA']),
                  ),
                  content(
                    context: context,
                    title: 'Inbox',
                    value: 'Terhubung dengan inbox ',
                    icon: SvgPicture.asset(
                      'assets/contact_message_icon.svg',
                      height: GlobalVariable.ratioWidth(context) * 22,
                      width: GlobalVariable.ratioWidth(context) * 22,
                    ),
                    company: widget.data['data_seller']['nama_individu_perusahaan'],
                    onTap: () async {
                      await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                      Chat.toID(idSeller.toString());
                    },
                  ),
                ],
              )
            ],
          ),
        );
      } else if (dataModelResponse.state == ResponseStates.ERROR) {
        return Container(
          height: GlobalVariable.ratioWidth(context) * 200,
          width: double.infinity,
          child: Center(
            child: ErrorDisplayComponent(
              "${dataModelResponse.exception}",
              onRefresh: () => fetchContactSeller(),
            ),
          ),
        );
      }
      return Container(
        height: GlobalVariable.ratioWidth(context) * 200,
        width: double.infinity,
        child: Center(
          child: LoadingComponent(),
        ),
      );
    });
  }

  Future openDialPad(String phoneNumber) async {
    Uri uri = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      CustomToastTop.show(
        context: Get.context,
        isSuccess: 0,
        message: 'Tidak bisa mengakses nomor berikut',
      );
      throw 'Could not launch $uri';
    }
  }

  Future launchWhatsApp(String phoneNumber) async {
    var formatter = phoneNumber.replaceAll('-', '');
    formatter = phoneNumber.replaceAll('+', '');
    // var url = Uri.parse("whatsapp://send?phone=$formatter&text=Helloo");
    try {
      await FlutterOpenWhatsapp.sendSingleMessage(formatter, 'Hallo');
    } catch (e) {
      throw 'Could not launch $e';
    }
  }

  Widget contentPIC({
    @required BuildContext context,
    @required String title,
    @required String name,
    @required String phone,
    @required Function onCallTap,
    Function onWaTap,
  }) {
    return Container(
      // height: GlobalVariable.ratioWidth(context) * 47,
      width: double.infinity,
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 16),
      padding: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(context) * 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      child: Container(
        // height: GlobalVariable.ratioWidth(context) * 35,
        width: double.infinity,
        padding: EdgeInsets.zero, margin: EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title,
              color: Color(ListColor.colorGreyTemplate8),
              fontWeight: FontWeight.w600,
              withoutExtraPadding: true,
            ),
            SizedBox(width: GlobalVariable.ratioWidth(context) * 42),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  name,
                  fontWeight: FontWeight.w600,
                  withoutExtraPadding: true,
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
                CustomText(
                  phone,
                  fontWeight: FontWeight.w600,
                  withoutExtraPadding: true,
                  fontSize: 12,
                ),
                // SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onCallTap,
                    child: SvgPicture.asset(
                      'assets/detail_compro_buyer/ic_phone_green_buyer.svg',
                      height: GlobalVariable.ratioWidth(context) * 18,
                      width: GlobalVariable.ratioWidth(context) * 18,
                      // color: Color(ListColor.colorGreenTemplate1),
                    ),
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
                  InkWell(
                    onTap: onWaTap,
                    child: Image.asset(
                      'assets/ic_whatsapp.png',
                      height: GlobalVariable.ratioWidth(context) * 18,
                      width: GlobalVariable.ratioWidth(context) * 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget content({
    @required BuildContext context,
    @required String title,
    @required String value,
    @required Widget icon,
    String company,
    @required Function onTap,
  }) {
    return Container(
      // height: GlobalVariable.ratioWidth(context) * 47,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(context) * 12),
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      child: Container(
        // height: GlobalVariable.ratioWidth(context) * 35,
        width: double.infinity,
        padding: EdgeInsets.zero, margin: EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  color: Color(ListColor.colorGreyTemplate8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
                RichText(
                  text: TextSpan(
                    text: value,
                    style: TextStyle(
                      fontFamily: 'AvenirNext',
                      fontSize: GlobalVariable.ratioWidth(context) * 14,
                      color: Color(ListColor.colorBlackTemplate),
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      if (company != null)
                        TextSpan(
                          text: company,
                          style: TextStyle(
                            fontFamily: 'AvenirNext',
                            fontSize: GlobalVariable.ratioWidth(context) * 14,
                            color: Color(ListColor.colorBlackTemplate1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (value != null && value != '-') Spacer(),
            if (value != null && value != '-')
              Padding(
                padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 6),
                child: InkWell(
                  onTap: onTap,
                  child: icon,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HubungiSellerBuyerWithEmailComponent extends StatefulWidget {
  final Map data;
  final int bottomSheetType;

  HubungiSellerBuyerWithEmailComponent({
    Key key,
    this.data,
    this.bottomSheetType,
  }) : super(key: key);

  @override
  _HubungiSellerBuyerWithEmailComponentState createState() => _HubungiSellerBuyerWithEmailComponentState();
}

class _HubungiSellerBuyerWithEmailComponentState extends State<HubungiSellerBuyerWithEmailComponent> {
  Map args;
  var dataModelResponse = ResponseState<Map>();
  var idSeller;
  var emailSeller;

  @override
  void initState() {
    super.initState();
    print('With Email COmpon ' + '${widget.bottomSheetType}');
    if (widget.data != null) {
      args = widget.data;
      idSeller = "${args['data_seller']['ID']}";
      print(idSeller);
    }
    fetchContactSeller();
  }

  Future<void> fetchContactSeller() async {
    try {
      setState(() {
        dataModelResponse = ResponseState.loading();
      });
      var response;
      response = await Future.wait([
        ApiBuyer(context: Get.context).getContactSellerProfile(idSeller),
        ApiBuyer(context: Get.context).getEmailSeller(idSeller),
      ]);
      if (response[0] != null && response[1] != null) {
        if (response[0]['Data'] != null &&
            response[0]['Message']['Code'] == 200 &&
            response[1]['Data'] != null &&
            response[1]['Message']['Code'] == 200) {
          setState(() {
            emailSeller = '${response[1]["Data"]['Email']}';
            dataModelResponse = ResponseState.complete(response[0]["Data"]);
          });
        } else {
          if (response[0]['Message'] != null &&
              response[0]['Message']['Text'] != null &&
              response[1]['Message'] != null &&
              response[1]['Message']['Text'] != null) {
            // if (response["Message"] != null && response["Message"]["Text"] != null) {
            throw ("${response[0]["Message"]["Text"] ?? response[1]["Message"]["Text"]}");
          }
          throw ("Data tidak ada!");
        }
      } else {
        throw ("Data tidak ada!");
      }
    } catch (e) {
      print("ERROR :: $e");
      setState(() {
        dataModelResponse = ResponseState.error("$e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (c) {
      if (dataModelResponse.state == ResponseStates.COMPLETE) {
        final dataContact = dataModelResponse.data;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                  color: Color(ListColor.colorGreyTemplate7),
                ),
                width: GlobalVariable.ratioWidth(context) * 38,
                height: GlobalVariable.ratioWidth(context) * 3,
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 6,
                  bottom: GlobalVariable.ratioWidth(context) * 15,
                ),
              ),
              Container(
                height: GlobalVariable.ratioWidth(context) * 24,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'ic_close_grey.svg',
                          width: GlobalVariable.ratioWidth(context) * 24,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          color: Color(ListColor.colorBlueTemplate1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        "Anda Ingin Menghubungi Via",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: GlobalVariable.ratioWidth(context) * 8), // SUDAH DIKURANG MARGIN ATASNYA
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.bottomSheetType == 0) // Just Email
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        content(
                          context: context,
                          title: 'Email',
                          value: emailSeller != "" ? emailSeller : "-",
                          icon: SvgPicture.asset(
                            'assets/Email.svg',
                            color: Color(ListColor.colorYellowTemplate2),
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                          ),
                          onTap: () => openEmail(emailSeller) ,
                        )
                      ],
                    )
                  else if (widget.bottomSheetType == 1) // Without PIC
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        content(
                          context: context,
                          title: 'No Telepon',
                          value: dataContact['EmergencyPhone'] ?? '',
                          icon: SvgPicture.asset(
                            'assets/detail_compro_buyer/ic_blue_phone_buyer.svg',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                            color: Color(ListColor.colorGreenTemplate),
                          ),
                          onTap: () => openDialPad(dataContact['EmergencyPhone']),
                        ),
                        content(
                          context: context,
                          title: 'WhatsApp',
                          value: dataContact['EmergencyWA'] ?? '',
                          icon: Image.asset(
                            'assets/ic_whatsapp.png',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                          ),
                          onTap: () => launchWhatsApp(dataContact['EmergencyWA']),
                        ),
                        content(
                          context: context,
                          title: 'Inbox',
                          value: 'Terhubung dengan inbox ',
                          icon: SvgPicture.asset(
                            'assets/contact_message_icon.svg',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                          ),
                          company: widget.data['data_seller']['nama_individu_perusahaan'],
                          onTap: () async {
                            await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                            Chat.toID(idSeller.toString());
                          },
                        ),
                      ],
                    )
                  else if (widget.bottomSheetType == 2) // showing all include email
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (dataContact['NamePic1'] != null && dataContact['NamePic1'] != '-')
                          contentPIC(
                            context: context,
                            title: 'PIC 1',
                            name: '${dataContact['NamePic1']}',
                            phone: '${dataContact['PhonePic1']}',
                            onCallTap: () => openDialPad('${dataContact['PhonePic1']}'),
                            onWaTap: () => launchWhatsApp('${dataContact['PhonePic1']}'),
                          ),
                        if (dataContact['NamePic2'] != null && dataContact['NamePic2'] != '-')
                          contentPIC(
                            context: context,
                            title: 'PIC 2',
                            name: dataContact['NamePic2'],
                            phone: dataContact['PhonePic2'],
                            onCallTap: () => openDialPad(dataContact['PhonePic2'].toString()),
                            onWaTap: () => launchWhatsApp(dataContact['PhonePic2'].toString()),
                          ),
                        if (dataContact['NamePic3'] != null && dataContact['NamePic3'] != '-')
                          contentPIC(
                            context: context,
                            title: 'PIC 3',
                            name: dataContact['NamePic2'],
                            phone: dataContact['PhonePic3'],
                            onCallTap: () => openDialPad(dataContact['PhonePic3'].toString()),
                            onWaTap: () => launchWhatsApp(dataContact['PhonePic3'].toString()),
                          ),
                        content(
                          context: context,
                          title: 'No Telepon',
                          value: dataContact['EmergencyPhone'] ?? '',
                          icon: SvgPicture.asset(
                            'assets/detail_compro_buyer/ic_blue_phone_buyer.svg',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                            color: Color(ListColor.colorGreenTemplate),
                          ),
                          onTap: () => openDialPad(dataContact['EmergencyPhone']),
                        ),
                        content(
                          context: context,
                          title: 'WhatsApp',
                          value: dataContact['EmergencyWA'] ?? '',
                          icon: Image.asset(
                            'assets/ic_whatsapp.png',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                          ),
                          onTap: () => launchWhatsApp(dataContact['EmergencyWA']),
                        ),
                        content(
                          context: context,
                          title: 'Inbox',
                          value: 'Terhubung dengan inbox ',
                          icon: SvgPicture.asset(
                            'assets/contact_message_icon.svg',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                          ),
                          company: widget.data['data_seller']['nama_individu_perusahaan'],
                          onTap: () async {
                            await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                            Chat.toID(idSeller.toString());
                          },
                        ),
                        content(
                          context: context,
                          title: 'Email',
                          value: emailSeller != "" ? emailSeller : "-",
                          icon: SvgPicture.asset(
                            'assets/Email.svg',
                            color: Color(ListColor.colorYellowTemplate2),
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                          ),
                          onTap: () {},
                        ),
                      ],
                    )
                  else // Default
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (dataContact['NamePic1'] != null && dataContact['NamePic1'] != '-')
                          contentPIC(
                            context: context,
                            title: 'PIC 1',
                            name: '${dataContact['NamePic1']}',
                            phone: '${dataContact['PhonePic1']}',
                            onCallTap: () => openDialPad('${dataContact['PhonePic1']}'),
                            onWaTap: () => launchWhatsApp('${dataContact['PhonePic1']}'),
                          ),
                        if (dataContact['NamePic2'] != null && dataContact['NamePic2'] != '-')
                          contentPIC(
                            context: context,
                            title: 'PIC 2',
                            name: dataContact['NamePic2'],
                            phone: dataContact['PhonePic2'],
                            onCallTap: () => openDialPad(dataContact['PhonePic2'].toString()),
                            onWaTap: () => launchWhatsApp(dataContact['PhonePic2'].toString()),
                          ),
                        if (dataContact['NamePic3'] != null && dataContact['NamePic3'] != '-')
                          contentPIC(
                            context: context,
                            title: 'PIC 3',
                            name: dataContact['NamePic2'],
                            phone: dataContact['PhonePic3'],
                            onCallTap: () => openDialPad(dataContact['PhonePic3'].toString()),
                            onWaTap: () => launchWhatsApp(dataContact['PhonePic3'].toString()),
                          ),
                        content(
                          context: context,
                          title: 'No Telepon',
                          value: dataContact['EmergencyPhone'] ?? '',
                          icon: SvgPicture.asset(
                            'assets/detail_compro_buyer/ic_blue_phone_buyer.svg',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                            color: Color(ListColor.colorGreenTemplate),
                          ),
                          onTap: () => openDialPad(dataContact['EmergencyPhone']),
                        ),
                        content(
                          context: context,
                          title: 'WhatsApp',
                          value: dataContact['EmergencyWA'] ?? '',
                          icon: Image.asset(
                            'assets/ic_whatsapp.png',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                          ),
                          onTap: () => launchWhatsApp(dataContact['EmergencyWA']),
                        ),
                        content(
                          context: context,
                          title: 'Inbox',
                          value: 'Terhubung dengan inbox ',
                          icon: SvgPicture.asset(
                            'assets/contact_message_icon.svg',
                            height: GlobalVariable.ratioWidth(context) * 22,
                            width: GlobalVariable.ratioWidth(context) * 22,
                          ),
                          company: widget.data['data_seller']['nama_individu_perusahaan'],
                          onTap: () async {
                            await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                            Chat.toID(idSeller.toString());
                          },
                        ),
                      ],
                    ),
                ],
              )
            ],
          ),
        );
      } else if (dataModelResponse.state == ResponseStates.ERROR) {
        return Container(
          height: GlobalVariable.ratioWidth(context) * 200,
          width: double.infinity,
          child: Center(
            child: ErrorDisplayComponent(
              "${dataModelResponse.exception}",
              onRefresh: () => fetchContactSeller(),
            ),
          ),
        );
      }
      return Container(
        height: GlobalVariable.ratioWidth(context) * 200,
        width: double.infinity,
        child: Center(
          child: LoadingComponent(),
        ),
      );
    });
  }

  Future openDialPad(String phoneNumber) async {
    Uri uri = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      CustomToastTop.show(
        context: Get.context,
        isSuccess: 0,
        message: 'Tidak bisa mengakses nomor berikut',
      );
      throw 'Could not launch $uri';
    }
  }

  Future openEmail(String path) async {
    var emailUri = Uri(
      scheme: "mailto",
      path: path,
    );
    launch(emailUri.toString());
  }


  Future launchWhatsApp(String phoneNumber) async {
    var formatter = phoneNumber.replaceAll('-', '');
    formatter = phoneNumber.replaceAll('+', '');
    // var url = Uri.parse("whatsapp://send?phone=$formatter&text=Helloo");
    try {
      await FlutterOpenWhatsapp.sendSingleMessage(formatter, 'Hallo');
    } catch (e) {
      throw 'Could not launch $e';
    }
  }

  Widget contentPIC({
    @required BuildContext context,
    @required String title,
    @required String name,
    @required String phone,
    @required Function onCallTap,
    Function onWaTap,
  }) {
    return Container(
      // height: GlobalVariable.ratioWidth(context) * 47,
      width: double.infinity,
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 16),
      padding: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(context) * 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      child: Container(
        // height: GlobalVariable.ratioWidth(context) * 35,
        width: double.infinity,
        padding: EdgeInsets.zero, margin: EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title,
              color: Color(ListColor.colorGreyTemplate8),
              fontWeight: FontWeight.w600,
              withoutExtraPadding: true,
            ),
            SizedBox(width: GlobalVariable.ratioWidth(context) * 42),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  name,
                  fontWeight: FontWeight.w600,
                  withoutExtraPadding: true,
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
                CustomText(
                  phone,
                  fontWeight: FontWeight.w600,
                  withoutExtraPadding: true,
                  fontSize: 12,
                ),
                // SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onCallTap,
                    child: SvgPicture.asset(
                      'assets/detail_compro_buyer/ic_phone_green_buyer.svg',
                      height: GlobalVariable.ratioWidth(context) * 18,
                      width: GlobalVariable.ratioWidth(context) * 18,
                      // color: Color(ListColor.colorGreenTemplate1),
                    ),
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
                  InkWell(
                    onTap: onWaTap,
                    child: Image.asset(
                      'assets/ic_whatsapp.png',
                      height: GlobalVariable.ratioWidth(context) * 18,
                      width: GlobalVariable.ratioWidth(context) * 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget content({
    @required BuildContext context,
    @required String title,
    @required String value,
    @required Widget icon,
    String company,
    @required Function onTap,
  }) {
    return Container(
      // height: GlobalVariable.ratioWidth(context) * 47,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(context) * 12),
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      child: Container(
        // height: GlobalVariable.ratioWidth(context) * 35,
        width: double.infinity,
        padding: EdgeInsets.zero, margin: EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  color: Color(ListColor.colorGreyTemplate8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
                RichText(
                  text: TextSpan(
                    text: value,
                    style: TextStyle(
                      fontFamily: 'AvenirNext',
                      fontSize: GlobalVariable.ratioWidth(context) * 14,
                      color: Color(ListColor.colorBlackTemplate),
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      if (company != null)
                        TextSpan(
                          text: company,
                          style: TextStyle(
                            fontFamily: 'AvenirNext',
                            fontSize: GlobalVariable.ratioWidth(context) * 14,
                            color: Color(ListColor.colorBlackTemplate1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (value != null && value != '-') Spacer(),
            if (value != null && value != '-')
              Padding(
                padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(context) * 6),
                child: InkWell(
                  onTap: onTap,
                  child: icon,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
