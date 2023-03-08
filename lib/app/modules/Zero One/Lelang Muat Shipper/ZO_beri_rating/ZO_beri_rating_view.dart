import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_beri_rating/ZO_beri_rating_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoBeriRatingView extends GetView<ZoBeriRatingController> {
  const ZoBeriRatingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            GlobalVariable.ratioWidth(context) * 60,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color(ListColor.colorBlue),
              boxShadow: [
                BoxShadow(
                  offset: Offset(
                    GlobalVariable.ratioWidth(context) * 0,
                    GlobalVariable.ratioWidth(context) * 4,
                  ),
                  blurRadius: GlobalVariable.ratioWidth(context) * 15,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  right: GlobalVariable.ratioWidth(context) * 0,
                  child: Image(
                    image: const AssetImage("assets/fallin_star_3_icon.png"),
                    height: GlobalVariable.ratioFontSize(context) * 75,
                    width: GlobalVariable.ratioFontSize(context) * 154,
                    fit: BoxFit.cover,
                  ),
                ),
                AppBar(
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  leading: null,
                  title: null,
                  toolbarHeight: GlobalVariable.ratioWidth(context) * 60,
                  flexibleSpace: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      const _ZoBeriRatingAppBarContent(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _ZoBeriRatingBody()),
            Obx(
              () => _ZoBeriRatingBottomBar(
                onTap:
                    controller.isLoading.isTrue ? null : controller.onSubmitted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZoBeriRatingAppBarContent extends StatelessWidget {
  const _ZoBeriRatingAppBarContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        GlobalVariable.ratioWidth(context) * 16,
      ),
      child: Row(
        children: [
          ClipOval(
            child: Material(
              shape: const CircleBorder(),
              color: Color(ListColor.colorWhite),
              child: InkWell(
                onTap: () {
                  Get.back(result: false);
                },
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  width: GlobalVariable.ratioFontSize(context) * 24,
                  height: GlobalVariable.ratioFontSize(context) * 24,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: GlobalVariable.ratioFontSize(context) * 14,
                      color: Color(ListColor.colorBlue),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
          CustomText(
            "LelangMuatPesertaLelangPesertaLelangLabelTitleBeriNilaiTransporter"
                .tr,
            color: Color(ListColor.colorWhite),
            fontSize: GlobalVariable.ratioFontSize(context) * 16,
            fontWeight: FontWeight.w700,
            height: GlobalVariable.ratioFontSize(context) * 19.2 / 16,
          ),
        ],
      ),
    );
  }
}

class _ZoBeriRatingTransporterNameWidget extends StatelessWidget {
  final String transporterName;
  final int truckOffer;

  const _ZoBeriRatingTransporterNameWidget({
    Key key,
    @required this.transporterName,
    this.truckOffer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          "LelangMuatPesertaLelangPesertaLelangLabelTitleNamaTransporter".tr,
          color: Color(ListColor.colorLightGrey14),
          fontSize: GlobalVariable.ratioFontSize(context) * 14,
          fontWeight: FontWeight.w700,
          height: GlobalVariable.ratioFontSize(context) * 16.8 / 14,
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
        CustomText(
          "$transporterName ${truckOffer == null ? '' : '($truckOffer Unit)'}",
          color: Color(ListColor.colorBlack),
          fontSize: GlobalVariable.ratioFontSize(context) * 14,
          fontWeight: FontWeight.w600,
          height: GlobalVariable.ratioFontSize(context) * 16.8 / 14,
        ),
      ],
    );
  }
}

class _ZoBeriRatingRatingWidget extends StatelessWidget {
  final int initialRating;
  final int maxRating;
  final void Function(int rating) onChanged;

  const _ZoBeriRatingRatingWidget({
    Key key,
    this.initialRating,
    this.maxRating,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          "LelangMuatPesertaLelangPesertaLelangLabelTitleNilaiTransporter".tr,
          color: Color(ListColor.colorLightGrey14),
          fontSize: GlobalVariable.ratioFontSize(context) * 14,
          fontWeight: FontWeight.w700,
          height: GlobalVariable.ratioFontSize(context) * 16.8 / 14,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
        RatingBar.builder(
          initialRating: initialRating == null ||
                  initialRating > maxRating ||
                  initialRating < 0
              ? 0.0
              : initialRating.toDouble(),
          itemCount: maxRating,
          glow: false,
          unratedColor: Color(ListColor.colorLightGrey2),
          itemPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 4,
          ),
          wrapAlignment: WrapAlignment.center,
          itemSize: GlobalVariable.ratioFontSize(context) * 32,
          itemBuilder: (context, index) {
            return SvgPicture.asset("assets/ic_rating_star.svg");
          },
          onRatingUpdate: (rating) {
            if (onChanged != null) {
              onChanged(rating.ceil());
            }
          },
        ),
      ],
    );
  }
}

class _ZoBeriRatingCommentWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errorText;
  final bool isErrorTextVisible;

  const _ZoBeriRatingCommentWidget({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.hintText,
    @required this.errorText,
    this.isErrorTextVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          labelText,
          color: Color(ListColor.colorLightGrey14),
          fontSize: GlobalVariable.ratioFontSize(context) * 14,
          fontWeight: FontWeight.w700,
          height: GlobalVariable.ratioFontSize(context) * 16.8 / 14,
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * 102,
          child: CustomTextField(
            cursorColor: Color(ListColor.colorBlue),
            maxLines: null,
            minLines: 5,
            context: context,
            newInputDecoration: InputDecoration(
              border: _getBorder(context),
              errorBorder: _getBorder(context),
              focusedBorder: _getBorder(context),
              enabledBorder: _getBorder(context),
              hintText: hintText,
              hintMaxLines: 10,
              hintStyle: TextStyle(
                color: Color(ListColor.colorLightGrey2),
              ),
            ),
            controller: controller,
            newContentPadding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(context) * 12,
              vertical: GlobalVariable.ratioWidth(context) * 13,
            ),
            style: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(context) * 14,
              fontWeight: FontWeight.w600,
              height: GlobalVariable.ratioFontSize(context) * (16.8 / 14),
            ),
            keyboardType: TextInputType.multiline,
          ),
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
        Visibility(
          maintainAnimation: true,
          maintainSize: true,
          maintainState: true,
          visible: isErrorTextVisible,
          child: CustomText(
            errorText,
            color: Color(ListColor.colorRed),
            fontSize: GlobalVariable.ratioFontSize(context) * 12,
            fontWeight: FontWeight.w600,
            height: GlobalVariable.ratioFontSize(context) * 14.4 / 12,
          ),
        ),
      ],
    );
  }

  ShapeBorder _getBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          GlobalVariable.ratioWidth(context) * 6,
        ),
        borderSide: BorderSide(
          color: Color(ListColor.colorLightGrey19),
        ),
      );
}

class _ZoBeriRatingBody extends GetView<ZoBeriRatingController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(context) * 16,
          vertical: GlobalVariable.ratioWidth(context) * 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ZoBeriRatingTransporterNameWidget(
              transporterName: controller.transporterName,
              truckOffer: controller.truckOffer,
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 24),
            Obx(
              () => _ZoBeriRatingRatingWidget(
                initialRating: controller.rating.value,
                maxRating: 5,
                onChanged: controller.onRatingChanged,
              ),
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 24),
            Obx(
              () => _ZoBeriRatingCommentWidget(
                controller: controller.qualityController,
                labelText:
                    "LelangMuatPesertaLelangPesertaLelangLabelTitleKualitasPelayanan"
                        .tr,
                hintText: "Berikan Komentar Penilaian Anda".tr,
                errorText: "Anda harus mengisi kualitas pelayanan".tr,
                isErrorTextVisible: controller.isQualityErrorVisible.isTrue,
              ),
            ),
            SizedBox(height: GlobalVariable.ratioWidth(context) * 6),
            Obx(
              () => _ZoBeriRatingCommentWidget(
                controller: controller.priceController,
                labelText:
                    "LelangMuatPesertaLelangPesertaLelangLabelTitleHargaLayanan"
                        .tr,
                hintText:
                    "Berikan Komentar mengenai harga layanan yang di berikan"
                        .tr,
                errorText: "Anda harus mengisi harga layanan".tr,
                isErrorTextVisible: controller.isPriceErrorVisible.isTrue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZoBeriRatingBottomBar extends StatelessWidget {
  final void Function() onTap;

  const _ZoBeriRatingBottomBar({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(
              GlobalVariable.ratioWidth(context) * 0,
              GlobalVariable.ratioWidth(context) * -3,
            ),
            blurRadius: GlobalVariable.ratioWidth(context) * 55,
            color: Color.fromRGBO(0, 0, 0, 0.161),
          ),
        ],
        color: Color(ListColor.colorLightBlue6),
      ),
      padding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(context) * 26,
            ),
            color: Color(ListColor.colorBlue),
            child: InkWell(
              radius: GlobalVariable.ratioWidth(context) * 26,
              borderRadius: BorderRadius.circular(
                GlobalVariable.ratioWidth(context) * 26,
              ),
              onTap: onTap ?? () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(context) * 18.5,
                  vertical: GlobalVariable.ratioWidth(context) * 9,
                ),
                child: Center(
                  child: CustomText(
                    "LelangMuatPesertaLelangPesertaLelangLabelTitleBeriNilaiTransporter"
                        .tr,
                    color: Color(ListColor.colorWhite),
                    fontSize: GlobalVariable.ratioFontSize(context) * 12,
                    fontWeight: FontWeight.w700,
                    height: GlobalVariable.ratioFontSize(context) * 14.4 / 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
