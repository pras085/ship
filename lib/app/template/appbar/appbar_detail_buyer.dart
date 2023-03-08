import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class AppBarDetailBuyer extends PreferredSize {
  final String title;
  final Function() onClickBack;
  final Function() onClickShare;
  final Function() onClickFavorite;
  final bool isWithPrefix;
  final bool favorite;

  AppBarDetailBuyer({
    this.title,
    this.isWithPrefix = true,
    this.onClickShare,
    this.onClickFavorite,
    @required this.onClickBack,
    this.favorite = false
  });

  @override
  final Size preferredSize = GlobalVariable.preferredSizeAppBar;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Container(
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhiteTemplate),
        boxShadow: [
          BoxShadow(
            offset: Offset(
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * 4,
            ),
            blurRadius: GlobalVariable.ratioWidth(context) * 15,
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: GlobalVariable.ratioWidth(context) * 56,
          color: Color(ListColor.colorWhite),
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ISFILTER DEFAULT : FALSE
              // ISI TRUE JIKA DIGUNAKAN PADA FILTER
              Align(
                alignment: Alignment.centerLeft,
                child: title != "Filter" ? _backButton(context) : _closeButton(context),
              ),
              Align(
                alignment: Alignment.center,
                child: _titleProfileWidget(),
              ),
              if (isWithPrefix)
                Align(
                  alignment: Alignment.centerRight,
                  child: _prefixIcon(),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _prefixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onClickShare,
            child: SvgPicture.asset(
              GlobalVariable.urlImageTemplateBuyer + 'temp_share.svg',
              height: GlobalVariable.ratioWidth(Get.context) * 24,
              width: GlobalVariable.ratioWidth(Get.context) * 24,
            ),
          ),
        ),
        SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 16),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onClickFavorite(),
            child: SvgPicture.asset(
              GlobalVariable.urlImageTemplateBuyer + "${ favorite ? 'temp_heart_filled.svg' : 'temp_heart.svg'}",
              height: GlobalVariable.ratioWidth(Get.context) * (favorite ? 21 : 24),
              width: GlobalVariable.ratioWidth(Get.context) * (favorite ? 21 : 24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _backButton(context) {
    return CustomBackButton(
      context: context,
      backgroundColor: Color(ListColor.colorBlueTemplate1),
      iconColor: Color(ListColor.colorWhite),
      onTap: onClickBack ?? Get.back,
    );
  }

  Widget _closeButton(context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClickBack ?? Get.back,
        child: Container(
          height: GlobalVariable.ratioWidth(context) * 24,
          child: SvgPicture.asset(
            GlobalVariable.urlImageTemplateBuyer + 'ic_close_shipper.svg',
            color: Color(ListColor.colorBlueTemplate1),
          ),
        ),
      ),
    );
  }

  Widget _titleProfileWidget() {
    return CustomText(
      title != null ? title : "Detail",
      color: Color(ListColor.colorBlackTemplate),
      fontWeight: title == "Filter" ? FontWeight.w600 : FontWeight.w700,
      fontSize: 14,
      textAlign: TextAlign.center,
    );
  }
}
