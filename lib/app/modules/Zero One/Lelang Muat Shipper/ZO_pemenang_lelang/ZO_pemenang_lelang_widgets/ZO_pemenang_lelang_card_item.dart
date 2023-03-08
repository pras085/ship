import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_bottom_sheet_option.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPemenangLelangCardItem extends GetView<ZoPemenangLelangController> {
  final int index;

  const ZoPemenangLelangCardItem(this.index);

  @override
  Widget build(BuildContext context) {
    print("$index");
    return Container(
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhite),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 13),
            blurRadius: 20,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CardHeader(
              index: index,
              avatar: controller.bidWinnerList[index].transporterAvatar,
              name: controller.bidWinnerList[index].transporterName,
              date: controller.bidWinnerList[index].created,
              isGold: controller.bidWinnerList[index].isGold != "0",
              onMenuTap: () async {
                var shouldRefresh = await Get.bottomSheet(
                  ZoPemenangLelangRateBottomSheet(winnerIndex: index),
                  shape: ZoPemenangLelangRateBottomSheet.getShape(),
                  backgroundColor:
                      ZoPemenangLelangRateBottomSheet.getBackgroundColor(),
                  isScrollControlled: true,
                );

                print("shouldRefresh: $shouldRefresh");

                if (shouldRefresh ?? false) {
                  controller.reset();
                }
              },
            ),
            _CardBody(
              price: controller.bidWinnerList[index].initialPrice,
              unit: controller.bidWinnerList[index].truckOffer,
              stars: controller.bidWinnerList[index].star,
              expectationDate: controller.bidWinnerList[index].pickedDate,
              timeZone: controller.bidWinnerList[index].created.split(" ").last,
            ),
            Divider(
              color: Color(ListColor.colorLightGrey2),
              height: GlobalVariable.ratioWidth(context) * 0.5,
            ),
            _CardFooter(index: index),
          ],
        ),
      ),
    );
  }
}

class _CardFooter extends GetView<ZoPemenangLelangController> {
  final int index;

  const _CardFooter({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalVariable.ratioWidth(context) * 16,
        vertical: GlobalVariable.ratioWidth(context) * 7,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Material(
            child: InkWell(
              onTap: () {
                int id = controller.bidWinnerList[index].id;
                controller.showContactBottomSheet(id);
              },
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(context) * 24,
                  vertical: GlobalVariable.ratioWidth(context) * 7,
                ),
                decoration: BoxDecoration(
                  color: Color(ListColor.colorBlue),
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child: CustomText(
                  "LTRResultLabelCallTransporter".tr,
                  color: Color(ListColor.colorWhite),
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                  height: GlobalVariable.ratioFontSize(context) * (14.4 / 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final int unit;
  final int price;
  final int stars;
  final String expectationDate;
  final String timeZone;

  const _CardBody({
    Key key,
    this.unit,
    this.price,
    this.stars,
    this.expectationDate,
    this.timeZone = "WIB",
  }) : super(key: key);

  Widget _buildRow(BuildContext context, String asset, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: GlobalVariable.ratioFontSize(context) * 16,
          width: GlobalVariable.ratioFontSize(context) * 16,
          child: Center(
            child: asset.toLowerCase().contains('svg')
                ? SvgPicture.asset(
                    asset,
                    color: Color(ListColor.colorBlue),
                    width: GlobalVariable.ratioFontSize(context) * 16,
                  )
                : Image.asset(
                    asset,
                    color: Color(ListColor.colorBlue),
                    width: GlobalVariable.ratioFontSize(context) * 16,
                  ),
          ),
        ),
        SizedBox(width: GlobalVariable.ratioWidth(context) * 20),
        Expanded(
          child: CustomText(
            text.tr,
            fontWeight: FontWeight.w500,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            height: GlobalVariable.ratioFontSize(context) * (16.8 / 14),
            color: Color(ListColor.colorGrey4),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateFormat("yyyy-M-d HH:mm:ss").parse(expectationDate);
    String formatted = DateFormat("dd MMM yyyy HH:mm").format(dateTime);
    String priceFormatted =
        NumberFormat('#,###').format(price.toInt()).replaceAll(',', '.');

    return Container(
      padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRow(context, "assets/ic_menu_dashboard_promo_transport.png",
              "Rp $priceFormatted"),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
          _buildRow(context, "assets/ic_truck_blue.svg", "$unit Unit".tr),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
          _buildRow(
            context,
            "assets/ic_star.svg",
            stars == null || (stars < 1 || stars > 5) ? "-" : "$stars Bintang",
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
          _buildRow(
            context,
            "assets/time_circle_icon.svg",
            "$formatted $timeZone",
          ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final int index;
  final String avatar;
  final String name;
  final String date;
  final bool isGold;
  final void Function() onMenuTap;

  const _CardHeader({
    Key key,
    @required this.index,
    @required this.avatar,
    @required this.name,
    @required this.date,
    this.isGold = false,
    @required this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateFormat("yyyy-M-d HH:mm:ss").parse(date);
    // String formatted =
    //     '${DateFormat("dd MMM yyyy HH:mm").format(dateTime)} WIB';
    Match match = date == null || date.isEmpty
        ? null
        : ' '.allMatches(date.trim()).elementAt(2);
    String newLineDate = date.replaceRange(match.start, match.end, '\n');

    return Container(
      padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
      decoration: BoxDecoration(
        color: Color(ListColor.colorLightBlue),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Material(
              shape: const CircleBorder(),
              color: Color(ListColor.color4),
              child: Container(
                width: GlobalVariable.ratioFontSize(context) * 32,
                height: GlobalVariable.ratioFontSize(context) * 32,
                color: const Color(0xffff4000),
                child: Center(
                  child: avatar == null || avatar.isEmpty
                      ? CustomText(
                          (name ?? 'N/A').tr,
                          color: Color(ListColor.colorWhite),
                          fontSize: GlobalVariable.ratioFontSize(context) * 10,
                          fontWeight: FontWeight.w600,
                          height:
                              GlobalVariable.ratioFontSize(context) * (12 / 10),
                        )
                      : Image.network(avatar, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
          Expanded(
            child: CustomText(
              name.tr,
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(context) * 14,
              height: GlobalVariable.ratioFontSize(context) * (16.8 / 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isGold) ...[
            GestureDetector(
              onTap: () {
                showDialog(
                    context: Get.context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return Dialog(
                        key: GlobalKey<State>(),
                        insetPadding: EdgeInsets.symmetric(vertical: 34.0),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(alignment: Alignment.bottomCenter, children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        "assets/ic_gold.png",
                                        height: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            22.88,
                                        width: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            17.29,
                                      ),
                                    ),
                                    SizedBox(
                                      width: GlobalVariable.ratioFontSize(
                                              context) *
                                          4,
                                    ),
                                    CustomText("Gold Transporter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            12,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 3, top: 3),
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: Color(ListColor.color4),
                                              size:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      24,
                                            ))),
                                  )),
                            ]),
                            SizedBox(
                              height:
                                  GlobalVariable.ratioFontSize(context) * 12,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: GlobalVariable.ratioFontSize(context) *
                                      16,
                                  right: GlobalVariable.ratioFontSize(context) *
                                      16,
                                  bottom:
                                      GlobalVariable.ratioFontSize(context) *
                                          8),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        "    " +
                                            "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldHead"
                                                .tr,
                                        textAlign: TextAlign.justify,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            12,
                                        height: GlobalVariable.ratioFontSize(
                                                context) *
                                            (14.4 / 12),
                                        color: Color(ListColor.colorDarkGrey3),
                                        fontWeight: FontWeight.w500),
                                    SizedBox(
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          12,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.0),
                                          child: SvgPicture.asset(
                                            "assets/check_blue_ic.svg",
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                14,
                                          ),
                                        ),
                                        SizedBox(
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                4),
                                        Expanded(
                                          child: CustomText(
                                              "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldSatu"
                                                  .tr,
                                              textAlign: TextAlign.justify,
                                              fontSize:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      12,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      (14.4 / 12),
                                              color: Color(
                                                  ListColor.colorDarkGrey3),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.0),
                                          child: SvgPicture.asset(
                                            "assets/check_blue_ic.svg",
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                14,
                                          ),
                                        ),
                                        SizedBox(
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                4),
                                        Expanded(
                                          child: CustomText(
                                              "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldDua"
                                                  .tr,
                                              textAlign: TextAlign.justify,
                                              fontSize:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      12,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      (14.4 / 12),
                                              color: Color(
                                                  ListColor.colorDarkGrey3),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.0),
                                          child: SvgPicture.asset(
                                            "assets/check_blue_ic.svg",
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                14,
                                          ),
                                        ),
                                        SizedBox(
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                4),
                                        Expanded(
                                            child: CustomText(
                                                "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldTiga"
                                                    .tr,
                                                textAlign: TextAlign.justify,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    12,
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    (14.4 / 12),
                                                color: Color(
                                                    ListColor.colorDarkGrey3),
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.0),
                                          child: SvgPicture.asset(
                                            "assets/check_blue_ic.svg",
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                14,
                                          ),
                                        ),
                                        SizedBox(
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                4),
                                        Expanded(
                                            child: CustomText(
                                                "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldEmpat"
                                                    .tr,
                                                textAlign: TextAlign.justify,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    12,
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    (14.4 / 12),
                                                color: Color(
                                                    ListColor.colorDarkGrey3),
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.0),
                                          child: SvgPicture.asset(
                                            "assets/check_blue_ic.svg",
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                14,
                                          ),
                                        ),
                                        SizedBox(
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                4),
                                        Expanded(
                                            child: CustomText(
                                                "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldLima"
                                                    .tr,
                                                textAlign: TextAlign.justify,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    12,
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    (14.4 / 12),
                                                color: Color(
                                                    ListColor.colorDarkGrey3),
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          12,
                                    ),
                                    CustomText(
                                        "    " +
                                            "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldFooter"
                                                .tr,
                                        textAlign: TextAlign.justify,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            12,
                                        height: GlobalVariable.ratioFontSize(
                                                context) *
                                            (14.4 / 12),
                                        color: Color(ListColor.colorDarkGrey3),
                                        fontWeight: FontWeight.w500),
                                  ]),
                            ),
                          ],
                        )),
                      );
                    });
              },
              child: Image.asset(
                "assets/ic_gold.png",
                width: GlobalVariable.ratioFontSize(Get.context) * 21,
                // height: GlobalVariable.ratioFontSize(Get.context) * 27,
              ),
            ),
            SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
          ],
          CustomText(
            newLineDate.tr,
            textAlign: TextAlign.right,
            color: Color(ListColor.colorBlue),
            fontWeight: FontWeight.w600,
            fontSize: GlobalVariable.ratioFontSize(context) * 10,
            height: GlobalVariable.ratioFontSize(context) * (12 / 10),
          ),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onMenuTap ?? () {},
              child: Container(
                child: Icon(
                  Icons.more_vert,
                  size: GlobalVariable.ratioFontSize(Get.context) * 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
