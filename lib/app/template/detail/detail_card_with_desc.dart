import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DetailCardWithDesc extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String desc;
  final Function onTap;

  DetailCardWithDesc({
    Key key,
    @required this.imageUrl,
    @required this.name,
    @required this.desc,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailBuyer(
        onClickBack: Get.back,
        isWithPrefix: false,
        title: 'Detail Promo',
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(ListColor.colorBgTemplate1),
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
              Expanded(
                child: Container(
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
                        name,
                        withoutExtraPadding: true,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
                      CustomText(
                        desc,
                        withoutExtraPadding: true,
                        height: 16.8 / 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              )
            ],
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
