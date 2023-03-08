import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DetailCardService extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String priceStart;
  final String priceEnd;
  final String detail ;
  final Function onTap;

  DetailCardService({
    Key key,
    @required this.imageUrl,
    @required this.title,
    @required this.priceStart,
    @required this.priceEnd,
    @required this.detail,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailBuyer(
        onClickBack: Get.back,
        isWithPrefix: false,
        title: 'Jasa Service',
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(ListColor.colorWhiteTemplate),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: GlobalVariable.ratioWidth(context) * 203,
                  ),
                ),
                _divider(context),
                Container(
                  width: double.infinity,
                  color: Color(ListColor.colorWhiteTemplate),
                  padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(context) * 16,
                    vertical: GlobalVariable.ratioWidth(context) * 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        title,
                        withoutExtraPadding: true,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.2,
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 24),
                      if (priceStart.isNotEmpty || priceEnd.isNotEmpty) ...[
                        CustomText(
                          'Harga Jasa',
                          withoutExtraPadding: true,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.2,
                        ),
                        SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                        CustomText(
                          priceStart.isNotEmpty && priceEnd.isNotEmpty ?
                            "${Utils.formatCurrency(value: double.parse(priceStart))} - ${Utils.formatCurrency(value: double.parse(priceEnd))}"
                            : priceStart.isEmpty ? 
                              Utils.formatCurrency(value: double.parse(priceEnd)) 
                              : Utils.formatCurrency(value: double.parse(priceStart)),
                          withoutExtraPadding: true,
                          height: 16.8 / 14,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: GlobalVariable.ratioWidth(context) * 24),
                      ],
                      CustomText(
                        'Detail',
                        withoutExtraPadding: true,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.2,
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                      CustomText(
                        detail,
                        withoutExtraPadding: true,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return SizedBox(
      height: GlobalVariable.ratioWidth(context) * 5,
      child: ColoredBox(color: Colors.transparent),
    );
  }
}
