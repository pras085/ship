import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../global_variable.dart';

class DetailTitleComproDetailBuyer extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const DetailTitleComproDetailBuyer({
    @required this.label,
    @required this.value,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: GlobalVariable.ratioWidth(context) * 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            // "assets/ic_profil.svg",
            icon,
            width: GlobalVariable.ratioWidth(context) * 16,
            height: GlobalVariable.ratioWidth(context) * 16,
            color: Color(ListColor.colorBlueTemplate1),
          ),
          SizedBox(
            width: GlobalVariable.ratioWidth(context) * 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.colorGreyTemplate3),
                ),
                SizedBox(
                  height: GlobalVariable.ratioWidth(context) * (icon == "assets/detail_compro_buyer/ic_alamat_detail_buyer.svg" ? 9 : 12), // -2px CustomText
                ),
                InkWell(
                  onTap: Utils.hasValidUrl(value) ? () async {
                    if (!await canLaunch(value)) {
                      CustomToastTop.show(
                        context: context, 
                        isSuccess: 0,
                        message: "could not go to the link!",
                      );
                    } else {
                      await launch(value);
                    }
                  } : null,
                  child: CustomText(
                    value,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Utils.hasValidUrl(value) ? Color(ListColor.colorBlue) : Colors.black,
                    decoration: Utils.hasValidUrl(value) ? TextDecoration.underline : TextDecoration.none,
                    height: 1.2,
                    withoutExtraPadding: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}