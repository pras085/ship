import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/utils/en_messages.dart';
import 'package:muatmuat/app/template/utils/id_messages.dart';
import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:muatmuat/app/template/widgets/card/card_item.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Class ini merupakan turunan dari CardItem yang dipakai untuk menampilkan lowongan, perusahaan, dll.
class CardCompany extends CardItem {
  /// [topLabel] terletak diatas gambar, jika dikosongi maka tidak akan ditampilkan.
  final String topLabel;
  final LabelColor topLabelColor;
  final String imageUrl;
  final String title;
  /// [subtitle] terletak dibawah title. Jika [subtitle] digunakan maka foto akan berbentuk persegi.
  final String subtitle;
  /// [detailTop] seperti halnya detail namun terletak dibawah title.
  final Map detailTop;
  /// [information] merupakan detail tertentu dengan icon.
  final Information information;
  /// [address] terletak dibawah gambar.
  final String address;
  /// [detail] harus diisi dengan format namaLabel dan value.
  /// 
  /// Contoh:
  /// {"Kondisi": "Bekas", "Warna": "Merah"}
  final Map detail;
  TextStyle detailLabelStyle;
  TextStyle detailValueStyle;
  /// [date] dapat digunakan untuk tanggal di bagian bawah dengan format berapa lama telah berlangsung dari waktu sekarang.
  final DateTime date;
  /// [tags] ditampilkan dipaling bawah card
  final List<BadgeModel> tags;

  CardCompany({
    Function() onTap,
    bool highlight = false, 
    bool verified = false, 
    bool favorite = false,
    Function() onFavorited,
    bool report = false,
    Function() onReported,
    this.topLabel,
    this.topLabelColor = LabelColor.blue,
    @required this.imageUrl,
    this.address,
    this.title,
    this.subtitle,
    this.detailTop,
    this.information,
    this.detail,
    this.detailLabelStyle,
    this.detailValueStyle,
    String location,
    this.date,
    this.tags,
    BoxShadow cardShadow,
    bool individu
  }) : super(onTap: onTap, width: 328, highlight: highlight, verified: verified, favorite: favorite, onFavorited: onFavorited, report: report, onReported: onReported, location: location, cardShadow: cardShadow, individu: individu ?? false);

  @override
  Widget build(BuildContext context) {
    if (detailLabelStyle == null) detailLabelStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.2, color: Color(ListColor.colorGreyTemplate3));
    if (detailValueStyle == null) detailValueStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.2, color: Colors.black);

    timeago.setLocaleMessages('id', LocaleMessagesId());
    timeago.setLocaleMessages('en', LocaleMessagesEn());

    return wrapper(
      child: Padding(
        padding: EdgeInsets.only(
          top: GlobalVariable.ratioWidth(context) * 8,
          bottom: GlobalVariable.ratioWidth(context) * 6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (topLabel != null) ...[
              Stack(
                children: [
                  Container(
                    height: GlobalVariable.ratioWidth(context) * 22,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 6),
                        topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 90)
                      ),
                      child: SvgPicture.asset(
                        topLabelColor == LabelColor.blue ? GlobalVariable.urlImageTemplateBuyer + 'top_label_blue_template.svg' : topLabelColor == LabelColor.yellow ? GlobalVariable.urlImageTemplateBuyer + 'top_label_yellow_template.svg' : GlobalVariable.urlImageTemplateBuyer + 'top_label_orange_template.svg',
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Container(
                    height: GlobalVariable.ratioWidth(context) * 22,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: CustomText(
                      topLabel,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      height: 1.2,
                      color: topLabelColor == LabelColor.blue || topLabelColor == LabelColor.orange ? Colors.white : Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
            ],
            Row(
              children: [
                Container(
                  width: GlobalVariable.ratioWidth(context) * ((subtitle != null || detailTop != null) ? 50 : 89),
                  decoration: BoxDecoration(
                    color: Color(0xFFC6CBD4),
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 5),
                    border: Border.all(color: Color(ListColor.colorGreyTemplate3))
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 5),
                    child: Image.network(
                      imageUrl,
                      width: GlobalVariable.ratioWidth(context) * ((subtitle != null || detailTop != null) ? 50 : 89),
                      height: GlobalVariable.ratioWidth(context) * 50,    
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Image.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'company_profile_placeholder_template.png', 
                          height: GlobalVariable.ratioWidth(context) * 50, 
                          width: GlobalVariable.ratioWidth(context) * ((subtitle != null || detailTop != null) ? 50 : 89), 
                          fit: BoxFit.cover
                        );
                      },
                      errorBuilder: (context, child, stackTrace) {
                        return Image.asset(
                          GlobalVariable.urlImageTemplateBuyer + 'company_profile_placeholder_template.png', 
                          height: GlobalVariable.ratioWidth(context) * 50, 
                          width: GlobalVariable.ratioWidth(context) * ((subtitle != null || detailTop != null) ? 50 : 89), 
                          fit: BoxFit.cover);
                      },
                    ),
                  ),
                ),
                SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
                Expanded(
                  child: Container(
                    height: (subtitle != null || detailTop != null) ? null : GlobalVariable.ratioWidth(context) * 50,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(ListColor.colorGreyTemplate3),
                          width: GlobalVariable.ratioWidth(context) * 1
                        )
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: (subtitle != null || detailTop != null) ? MainAxisAlignment.start : MainAxisAlignment.center,
                      crossAxisAlignment: (subtitle != null || detailTop != null) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          title ?? "",
                          fontWeight: FontWeight.w700,
                          fontSize: (subtitle != null || detailTop != null) ? 12 : 14,
                          height: 1.2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: (subtitle != null || detailTop != null) ? TextAlign.start : TextAlign.center,
                        ),
                        if (subtitle != null) ...[
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
                          CustomText(
                            subtitle,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 1.2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
                        ],
                        if (detailTop != null) ...[
                          for (var i = 0; i < detailTop.keys.toList().length; i++) Padding(
                            padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(context) * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    (detailTop.keys.toList()[i] ?? "") + " :",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    height: 1.2,
                                    color: Color(ListColor.colorGreyTemplate3),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  CustomText(
                                    (detailTop.values.toList()[i]).toString() ?? "",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    height: 1.2,
                                    color: Colors.black,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis
                                  )
                                ],
                              )
                          ) 
                        ]
                      ],
                    ),
                  )
                )
              ],
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
            if (information != null) ...[
              SizedBox(height: GlobalVariable.ratioWidth(context) * 3),
              _infoIcon(),
            ] else ...[
              Container(
                height: GlobalVariable.ratioWidth(context) * 32,
                width: double.infinity,
                child: CustomText(
                  address ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (detail != null)
              for (var i = 0; i < detail.keys.toList().length; i++) Padding(
                padding: EdgeInsets.only(
                  top: i == detail.keys.toList().length - 1 ? 0 : GlobalVariable.ratioWidth(context) * 6), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        (detail.keys.toList()[i] ?? "") + " :",
                        fontWeight: detailLabelStyle.fontWeight ?? FontWeight.w500,
                        fontSize: detailLabelStyle.fontSize ?? 12,
                        height: detailLabelStyle.height ?? 1.2,
                        color: detailLabelStyle.color ?? Colors.black,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      CustomText(
                        (detail.values.toList()[i]).toString() ?? "",
                        fontWeight: detailValueStyle.fontWeight ?? FontWeight.w600,
                        fontSize: detailValueStyle.fontSize ?? 12,
                        height: detailValueStyle.height ?? 1.2,
                        color: detailValueStyle.color ?? Colors.black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      )
                    ],
                  )
              ) 
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoIcon() {
    return Column(
      children: [
        if (information.salary != null) Row(
          children: [
            SvgPicture.asset(Information.salaryIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.salary, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
        if (information.gender != null) SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        if (information.gender != null) Row(
          children: [
            SvgPicture.asset(Information.genderIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(
              child: Row(
                children: [
                  CustomText(information.gender, fontWeight: FontWeight.w500, fontSize: 12),
                  CustomText(" \u2022 ", fontWeight: FontWeight.w500, fontSize: 12),
                  CustomText(information.age, fontWeight: FontWeight.w500, fontSize: 12),
                ],
              ),
            ),
          ],
        ),
        if (information.place != null) SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        if (information.place != null) Row(
          children: [
            SvgPicture.asset(Information.placeIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.place, fontWeight: FontWeight.w500, fontSize: 12, overflow: TextOverflow.ellipsis,)),
          ],
        ),
        if (information.deadline != null) SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        if (information.deadline != null) Row(
          children: [
            SvgPicture.asset(Information.deadlineIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.deadline, fontWeight: FontWeight.w500, fontSize: 12, overflow: TextOverflow.ellipsis,)),
          ],
        ),
        if (information.education != null) Row(
          children: [
            SvgPicture.asset(Information.educationIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.education, fontWeight: FontWeight.w500, fontSize: 12, overflow: TextOverflow.ellipsis,)),
          ],
        ),
        if (information.experience != null) SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        if (information.experience != null) Row(
          children: [
            SvgPicture.asset(Information.experienceIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.experience, fontWeight: FontWeight.w500, fontSize: 12, overflow: TextOverflow.ellipsis,)),
          ],
        ),
        if (information.staff != null) SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        if (information.staff != null) Row(
          children: [
            SvgPicture.asset(Information.staffIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.staff, fontWeight: FontWeight.w500, fontSize: 12, overflow: TextOverflow.ellipsis,)),
          ],
        ),
        if (information.skill != null) SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        if (information.skill != null) Row(
          children: [
            SvgPicture.asset(Information.skillIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.skill, fontWeight: FontWeight.w500, fontSize: 12, overflow: TextOverflow.ellipsis,)),
          ],
        ),
        if (information.job != null) SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        if (information.job != null) Row(
          children: [
            SvgPicture.asset(Information.jobIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.job, fontWeight: FontWeight.w500, fontSize: 12, overflow: TextOverflow.ellipsis,)),
          ],
        ),
        if (information.preference != null) SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        if (information.preference != null) Row(
          children: [
            SvgPicture.asset(Information.preferenceIcon, width: GlobalVariable.ratioWidth(Get.context) * 12, height: GlobalVariable.ratioWidth(Get.context) * 12),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Flexible(child: CustomText(information.preference, fontWeight: FontWeight.w500, fontSize: 12, overflow: TextOverflow.ellipsis,)),
          ],
        ),
      ],
    );
  }

  Widget footer({double fontSize, double height}) {
    if (location != null && date == null) return super.footer(fontSize: 12, height: 1.2);
    if (date != null) {
      Widget dateWidget = Padding(
        padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              GlobalVariable.urlImageTemplateBuyer + 'ic_time_template.svg', 
              height: GlobalVariable.ratioWidth(Get.context) * 11,
              width: GlobalVariable.ratioWidth(Get.context) * 11
            ),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            CustomText(
              timeago.format(date, locale: Get.locale == const Locale('id') ? 'id' : 'en'),
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: Color(ListColor.colorGreyTemplate3),
            ),
          ],
        ),
      );
      if (location == null) {
        return dateWidget;
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 2),
              child: SvgPicture.asset(
                GlobalVariable.urlImageTemplateBuyer + 'ic_pin_blue_template.svg',
                width: GlobalVariable.ratioWidth(Get.context) * 11,
                height: GlobalVariable.ratioWidth(Get.context) * 11,
              ),
            ),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 2.5,
                ),
                child: CustomText(
                  location,
                  color: Color(ListColor.colorGreyTemplate3),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            dateWidget
          ],
        );
      }
    }
    if (tags != null && tags.isNotEmpty) return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 8.5),
      child: Wrap(
        spacing: GlobalVariable.ratioWidth(Get.context) * 4,
        children: tags.map((e) => Container(
          padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 8, 
            GlobalVariable.ratioWidth(Get.context) * 4, 
            GlobalVariable.ratioWidth(Get.context) * 8, 
            GlobalVariable.ratioWidth(Get.context) * 2
          ),
          decoration: BoxDecoration(
            color: Color(ListColor.colorBlueTemplate2),
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)
          ),
          child: CustomText(
            e.label,
            fontWeight: FontWeight.w600,
            fontSize: 10,
            height: 1.2,
            color: Color(ListColor.colorBlueTemplate1),
          ),
        )).toList(),
      ),
    );
    return Container();
  }
}

class BadgeModel {

  final String label;
  final String labelTooltip;

  const BadgeModel({
    this.label,
    this.labelTooltip,
  });

}

class Information {
  // salary
  final String salary;
  final String salaryTooltipMessage;
  static const String salaryIcon = 'assets/template_buyer/ic_salary_blue_template.svg';

  final String gender;
  final String age;
  final String genderTooltipMessage;
  final String ageTooltipMessage;
  static const String genderIcon = 'assets/template_buyer/ic_gender_blue_template.svg';

  final String place;
  static const String placeIcon = 'assets/template_buyer/ic_pin_blue_template.svg';

  final String deadline;
  static const String deadlineIcon = 'assets/template_buyer/ic_time_blue_template.svg';

  final String education;
  static const String educationIcon = 'assets/template_buyer/ic_education_blue_template.svg';

  final String experience;
  static const String experienceIcon = 'assets/template_buyer/ic_experience_blue_template.svg';

  final String staff;
  static const String staffIcon = 'assets/template_buyer/ic_staff_blue_template.svg';

  final String skill;
  static const String skillIcon = 'assets/template_buyer/ic_skill_blue_template.svg';

  final String job;
  static const String jobIcon = 'assets/template_buyer/ic_job_blue_template.svg';
  
  final String preference;
  static const String preferenceIcon = 'assets/template_buyer/ic_pin_blue_template.svg';

  Information({
    this.salary, 
    this.salaryTooltipMessage, 
    this.gender, 
    this.age, 
    this.genderTooltipMessage, 
    this.ageTooltipMessage, 
    this.place, 
    this.deadline, 
    this.education, 
    this.experience, 
    this.staff, 
    this.skill, 
    this.job, 
    this.preference,
  });
}