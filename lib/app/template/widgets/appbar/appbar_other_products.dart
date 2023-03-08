import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

///Appbar ini digunakan untuk halaman Barang Lainnya Dari Penjual
class AppBarOtherProducts extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onClickBack;

  AppBarOtherProducts({
    Key key,
    this.title = '',
    @required this.onClickBack,
  });

  @override
  final Size preferredSize = Size(double.infinity, GlobalVariable.ratioWidth(Get.context) * 60);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
      decoration: BoxDecoration(
        color: Color(ListColor.colorBlueTemplate), 
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
      height: GlobalVariable.ratioWidth(context) * 60,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 16,),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomBackButton(
              context: context,
              iconColor: Color(ListColor.colorBlueTemplate),
              backgroundColor: Color(ListColor.colorWhite),
              onTap: onClickBack,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomText(
                      title,
                      fontWeight: FontWeight.w700,
                      color: Color(ListColor.colorWhite),
                      fontSize: 16,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}