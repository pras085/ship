import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/utils/en_messages.dart';
import 'package:muatmuat/app/template/utils/id_messages.dart';
import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:muatmuat/app/template/widgets/card/card_item.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Class ini merupakan turunan dari CardItem yang dipakai untuk menampilkan produk.
class CardProduct extends CardItem {
  /// [topLabel] terletak diatas gambar, jika dikosongi maka tidak akan ditampilkan.
  final String topLabel;
  /// [topLabelColor] untuk warna background label.
  final LabelColor topLabelColor;
  final String imageUrl;
  final String title;
  final bool useNegotiationPrice;
  final String negotiationPriceText;
  final num price;
  /// Jika [discountPrice] tidak null, maka yang ditampilkan 2 harga, yaitu harga normal dan harga diskon.
  final double discountPrice;
  /// [subtitle] terletak dibawah harga.
  final String subtitle;
  /// [subtitleWidget] untuk custom widget, dibawah harga.
  /// parameter ini juga mempunyai fungsi lain sebagai pembeda untuk card places promo
  /// tolong jangan diubah!
  final Widget subtitleWidget;
  TextStyle titleStyle;
  TextStyle subtitleStyle;
  /// [detail] harus diisi dengan format namaLabel dan value.
  /// 
  /// Contoh:
  /// {"Kondisi": "Bekas", "Warna": "Merah"}
  final Map detail;
  /// [verticalDetail] jika true maka detail akan dibuat kebawah yaitu label kemudian dibawah valuenya.
  final bool verticalDetail;
  /// [maxWidthDetailLabel] digunakan jika [verticalDetail] bernilai false, karena untuk membatasi width label.
  double maxWidthDetailLabel;
  TextStyle detailLabelStyle;
  TextStyle detailValueStyle;
  /// [description] untuk text biasa dibawah title dan detail harus null / kosong agar dapat tampil.
  final String description;
  /// [date] dapat digunakan untuk tanggal di bagian bawah maupun di atas title.
  final DateTime date;
  /// [showDateAtFooter] bernilai true maka tanggal akan ditampilkan dibawah dengan [formatDate] yang diinginkan.
  final bool showDateAtFooter;
  final String formatDate;
  /// [company] menampilkan nama perusahaan diatas lokasi.
  final String company;
  /// Jika [onContactViewed] tidak bernilai null maka akan menampilkan tombol 'Hubungi' di paling bawah.
  final Function() onContactViewed;

  CardProduct({
    Function() onTap,
    bool highlight = false, 
    bool verified = false, 
    bool favorite = false,
    Function() onFavorited,
    bool report = false,
    Function() onReported,
    this.topLabel,
    this.topLabelColor = LabelColor.blue,
    this.imageUrl,
    @required this.date,
    this.title,
    this.useNegotiationPrice = false,
    this.negotiationPriceText,
    this.price,
    this.discountPrice,
    this.subtitle,
    this.subtitleWidget,
    this.titleStyle,
    this.subtitleStyle,
    this.detail,
    this.verticalDetail = false,
    this.maxWidthDetailLabel,
    this.detailLabelStyle,
    this.detailValueStyle,
    this.description,
    @required String location, 
    this.showDateAtFooter = false,
    this.formatDate = 'dd MMMM',
    this.company,
    this.onContactViewed,
    BoxShadow cardShadow,
  }) : super(onTap: onTap, width: 156, highlight: highlight, verified: verified, favorite: favorite, onFavorited: onFavorited, report: report, onReported: onReported, location: location, cardShadow: cardShadow, individu: false);

  @override
  Widget build(BuildContext context) {
    if (titleStyle == null) titleStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 12,);
    if (subtitleStyle == null) subtitleStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black);
    if (detailLabelStyle == null) detailLabelStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 1.4, color: Colors.black);
    if (detailValueStyle == null) detailValueStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w600, height: 1.4, color: Colors.black);

    timeago.setLocaleMessages('id', LocaleMessagesId());
    timeago.setLocaleMessages('en', LocaleMessagesEn());

    int maxLength = 0;
    if(detail != null){
      for (var i = 0; i < detail.keys.toList().length; i++) {
        if (detail.keys.toList()[i].length >= maxLength) {
          maxLength = detail.keys.toList()[i].length;
        }
      }
    }
    // if (maxLength > 10) maxLength = 10;

    return wrapper(
      child: Padding(
        padding: EdgeInsets.only(
          top: GlobalVariable.ratioWidth(context) * 8,
          bottom: GlobalVariable.ratioWidth(context) * 6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                      withoutExtraPadding: true,
                    ),
                  )
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(context) * 2),
            ],
            if (imageUrl != null)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC6CBD4),
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 5),
                      border: Border.all(color: Color(ListColor.colorGreyTemplate3))
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 5),
                      child: Image.network(
                        imageUrl,
                        width: GlobalVariable.ratioWidth(context) * 140,
                        height: GlobalVariable.ratioWidth(context) * 79,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Image.asset(GlobalVariable.urlImageTemplateBuyer + 'truck_placeholder_template.png', height: GlobalVariable.ratioWidth(context) * 79, fit: BoxFit.cover);
                        },
                        errorBuilder: (context, child, stackTrace) {
                          return Image.asset(GlobalVariable.urlImageTemplateBuyer + 'truck_placeholder_template.png', height: GlobalVariable.ratioWidth(context) * 79, fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                ],
              ),
            if (!showDateAtFooter) ...[
              CustomText(
                timeago.format(date, locale: Get.locale == const Locale('id') ? 'id' : 'en'),
                // date.toIso8601String(),
                fontWeight: FontWeight.w600,
                fontSize: 8,
                color: Color(ListColor.colorGreyTemplate3),
                withoutExtraPadding: true,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
            ],
            if (price != null) ...[
              if (useNegotiationPrice) ...[
                CustomText(
                  negotiationPriceText ?? 'Harga Hubungi Penjual',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  height: 1.2,
                  color: Color(ListColor.colorBlueTemplate1),
                  withoutExtraPadding: true,
                ),
              ] else ...[
                if (title != null && title.isNotEmpty) ...[
                  if (subtitleWidget == null) SizedBox(height: GlobalVariable.ratioWidth(context) * 2),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 31.7, 
                    child: CustomText(
                      title ?? "",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      withoutExtraPadding: true,
                    ),
                  ), 
                ],
                SizedBox(height: GlobalVariable.ratioWidth(context) * 6),
                if (discountPrice != null) ...[
                  CustomText(
                    Utils.formatCurrency(value: discountPrice),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    height: 1,
                    color: Color(ListColor.colorGreyTemplate3),
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Color(0xFF676767),
                    withoutExtraPadding: true,
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(context) * 2),
                  CustomText(
                    Utils.formatCurrency(value: price),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 14.4/12,
                    withoutExtraPadding: true,
                  ),
                ] else ...[
                  CustomText(
                    Utils.formatCurrency(value: price),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1,
                    withoutExtraPadding: true,
                  ),
                ]
              ]
            ] else ...[
              if (title != null && title.isNotEmpty) ...[
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 31.7, 
                  child: CustomText(
                    title,   
                    fontSize: titleStyle.fontSize,
                    color: titleStyle.color,
                    fontWeight: titleStyle.fontWeight,
                    height: 1.2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    withoutExtraPadding: true,
                  ),
                ),
              ]
            ],
            if (subtitle != null) ...[
              CustomText(
                subtitle,
                fontSize: subtitleStyle.fontSize,
                color: subtitleStyle.color,
                fontWeight: subtitleStyle.fontWeight,
                withoutExtraPadding: true,
              )
            ]
            else if (subtitleWidget != null) subtitleWidget,
            if (detail != null && detail.isNotEmpty) ...[
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * (verticalDetail ? 6 : 8),
              ),
              if (verticalDetail)
                for (var i = 0; i < detail.keys.toList().length; i++) 
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: i == detail.keys.toList().length - 1 ? 0 : GlobalVariable.ratioWidth(context) * (verticalDetail ? 4 : 2)), 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            (detail.keys.toList()[i] ?? "") + " :",
                            fontWeight: detailLabelStyle.fontWeight ?? FontWeight.w500,
                            fontSize: detailLabelStyle.fontSize ?? 10,
                            height: detailLabelStyle.height ?? 1.4,
                            color: detailLabelStyle.color ?? Colors.black,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            withoutExtraPadding: true,
                          ),
                          CustomText(
                            (detail.values.toList()[i]).toString() ?? "",
                            fontWeight: detailValueStyle.fontWeight ?? FontWeight.w600,
                            fontSize: detailValueStyle.fontSize ?? 10,
                            height: detailValueStyle.height ?? 1.4,
                            color: detailValueStyle.color ?? Colors.black,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            withoutExtraPadding: true,
                          )
                        ],
                      )
                    )
              else
                Table(
                  columnWidths: <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: FixedColumnWidth(GlobalVariable.ratioWidth(context) * 11),
                    2: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    for (var i = 0; i < detail.keys.toList().length; i++)
                      TableRow(
                        children: [
                          CustomText(
                            detail.keys.toList()[i] ?? "",
                            fontWeight: detailLabelStyle.fontWeight ?? FontWeight.w500,
                            fontSize: detailLabelStyle.fontSize ?? 10,
                            height: detailLabelStyle.height ?? 1.4,
                            color: detailLabelStyle.color ?? Colors.black,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            withoutExtraPadding: true,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(context) * 4),
                            child: CustomText(
                              ":",
                              fontWeight: detailLabelStyle.fontWeight ?? FontWeight.w500,
                              fontSize: detailLabelStyle.fontSize ?? 10,
                              height: detailLabelStyle.height ?? 1.4,
                              color: detailLabelStyle.color ?? Colors.black,
                              withoutExtraPadding: true,
                            ),
                          ),
                          CustomText(
                            (detail.values.toList()[i]).toString() ?? "",
                            fontWeight: detailValueStyle.fontWeight ?? FontWeight.w600,
                            fontSize: detailValueStyle.fontSize ?? 10,
                            height: detailValueStyle.height ?? 1.4,
                            color: detailValueStyle.color ?? Colors.black,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            withoutExtraPadding: true,
                          ),
                        ],
                      ),
                  ],
                ),
            ] else ...[
              SizedBox(height: GlobalVariable.ratioWidth(context) * (price != null ? 6 : 4)),
              CustomText(
                description ?? "",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.2,
                maxLines: price != null ? 2 : 5,
                overflow: price != null ? TextOverflow.ellipsis : TextOverflow.fade,
                withoutExtraPadding: true,
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget footer({double fontSize, double height}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (company != null) ...[
          Container(
            padding: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 5,
              top: GlobalVariable.ratioWidth(Get.context) * 4,
              right: GlobalVariable.ratioWidth(Get.context) * 4,
              bottom: GlobalVariable.ratioWidth(Get.context) * 4,
            ),
            margin: EdgeInsets.only(
              bottom: GlobalVariable.ratioWidth(Get.context) * 8
            ),
            width: MediaQuery.of(Get.context).size.width,
            height: GlobalVariable.ratioWidth(Get.context) * 33.9,
            decoration: BoxDecoration(
              color: Color(ListColor.colorBlueTemplate2),
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 4)
            ),
            alignment: Alignment.center,
            child: CustomText(
              company,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              height: 1.2,
              textAlign: TextAlign.center,
              color: Color(ListColor.colorBlueTemplate1),
              withoutExtraPadding: true,
            ),
          )
        ],
        showDateAtFooter ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              GlobalVariable.urlImageTemplateBuyer + 'ic_pin_blue_template.svg',
              width: GlobalVariable.ratioWidth(Get.context) * 11,
              height: GlobalVariable.ratioWidth(Get.context) * 11,
            ),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 2),
            Expanded(
              child: CustomText(
                location ?? "",
                color: Color(ListColor.colorGreyTemplate3),
                fontSize: 8,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                height: 1.4,
                withoutExtraPadding: true,
              ),
            ),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 4),
            CustomText(
              Utils.formatDate(value: date.toIso8601String(), format: formatDate),
              color: Color(ListColor.colorGreyTemplate3),
              fontSize: 8,
              fontWeight: FontWeight.w500,
              height: 1.4,
              withoutExtraPadding: true,
            )
          ],
        ) :
        super.footer(fontSize: 8, height: 1),
        if (onContactViewed != null) ...[
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),
          button(
            onTap: onContactViewed,
            text: 'Hubungi',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            backgroundColor: Color(ListColor.colorBlueTemplate1),
            height: 28,
            borderRadius: 18
          )
        ]
      ],
    );
  }
}