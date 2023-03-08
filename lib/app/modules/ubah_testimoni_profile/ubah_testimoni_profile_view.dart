import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'ubah_testimoni_profile_controller.dart';

class UbahTestimoniProfileView extends GetView<UbahTestimoniProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(
        title: "Ubah Testimoni",
        isCenter: false,
        isBlueMode: true,
        isWithBackgroundImage: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: GlobalVariable.ratioWidth(context) * 24,
          horizontal: GlobalVariable.ratioWidth(context) * 16,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(context) * 26,
              ),
              height: GlobalVariable.ratioWidth(context) * 32,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: "${controller.argument.filePath ?? '-'}",
                    width: GlobalVariable.ratioWidth(context) * 32,
                    height: GlobalVariable.ratioWidth(context) * 32,
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(context) * 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("${controller.argument.transporterName ?? '-'}",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText("${controller.argument.tanggalMobile}",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        withoutExtraPadding: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomText("Kualitas Layanan",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 6,
            ),
            RatingBar(
              itemCount: 5,
              minRating: 1,
              maxRating: 5,
              ratingWidget: RatingWidget(
                full: SvgPicture.asset('assets/ic_star_frame.svg',
                  width: GlobalVariable.ratioWidth(context) * 40,
                  height: GlobalVariable.ratioWidth(context) * 40,
                ),
                half: null,
                empty: SvgPicture.asset('assets/ic_star_frame.svg',
                  width: GlobalVariable.ratioWidth(context) * 40,
                  height: GlobalVariable.ratioWidth(context) * 40,
                  color: Color(ListColor.colorLightGrey2),
                ),
              ), 
              allowHalfRating: false,
              initialRating: double.parse("${controller.data.value.rate}"),
              onRatingUpdate: (val) {
                controller.data.value = controller.data.value.copyWith(
                  rate: val.toInt(),
                );
              },
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(context) * 14,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioFontSize(context) * 6),
                border: Border.all(
                  width: GlobalVariable.ratioFontSize(context) * 1,
                  color: Color(ListColor.colorGrey3),
                )
              ),
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioFontSize(context) * 10,
                horizontal: GlobalVariable.ratioFontSize(context) * 12,
              ),
              height: GlobalVariable.ratioFontSize(context) * 128,
              child: CustomTextField(
                context: context,
                controller: controller.contentController,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "AvenirNext",
                  color: Colors.black,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(255),
                ],
                newInputDecoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(
                    fontSize: GlobalVariable.ratioWidth(context) * 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "AvenirNext",
                    color: Color(ListColor.colorLightGrey2),
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Masukkan testimoni Anda",
                  filled: true,
                  isDense: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(context) * 0,
                    GlobalVariable.ratioWidth(context) * 0,
                    GlobalVariable.ratioWidth(context) * 0,
                    GlobalVariable.ratioWidth(context) * 0,
                  ),
                ),
                onChanged: (String str) async {
                  controller.data.value = controller.data.value.copyWith(
                    content: str,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: GlobalVariable.ratioFontSize(context) * 1,
              color: Color(ListColor.colorLightGrey10),
            ),
          ),
        ),
        padding: EdgeInsets.all(
          GlobalVariable.ratioFontSize(context) * 16,
        ),
        height: GlobalVariable.ratioFontSize(context) * 68,
        child: Obx(() => _button(
          context: context,
          paddingLeft: 60,
          paddingRight: 60,
          height: 36,
          borderRadius: 18,
          backgroundColor: Color(controller.isValid ? ListColor.colorBlue : ListColor.colorLightGrey2),
          customWidget: CustomText("Simpan",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            textAlign: TextAlign.center,
            color: Color(controller.isValid ? ListColor.colorWhite : ListColor.colorLightGrey4),
          ),
          onTap: controller.onSaved,
        )),
      ),
    );
  }

  Widget _button({
    @required BuildContext context,
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * marginLeft,
          GlobalVariable.ratioWidth(context) * marginTop,
          GlobalVariable.ratioWidth(context) * marginRight,
          GlobalVariable.ratioWidth(context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(context).size.width
              : null
          : GlobalVariable.ratioWidth(context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(context) * paddingLeft,
                  GlobalVariable.ratioWidth(context) * paddingTop,
                  GlobalVariable.ratioWidth(context) * paddingRight,
                  GlobalVariable.ratioWidth(context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * borderRadius)),
              child: Center(
                child: customWidget == null
                    ? CustomText(
                        text ?? "",
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: color,
                      )
                    : customWidget,
              ),
            )),
      ),
    );
  }

}