import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_promo_transporter_model.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterLatestSearchItem extends StatelessWidget {
  final ZoPromoTransporterLatestSearchDataModel data;
  final void Function() onTap;
  final void Function() onCloseTap;
  const ZoPromoTransporterLatestSearchItem({
    Key key,
    @required this.data,
    this.onTap,
    this.onCloseTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(context) * 8,
            horizontal: GlobalVariable.ratioWidth(context) * 16,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/timer_icon.svg',
                height: GlobalVariable.ratioFontSize(context) * 16,
                width: GlobalVariable.ratioFontSize(context) * 16,
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
              Expanded(
                  child: CustomText(
                '${data.query}',
                fontSize: 12,
                height: 14.4 / 12,
                withoutExtraPadding: true,
                fontWeight: FontWeight.w500,
              )),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 16),
              GestureDetector(
                onTap: onCloseTap,
                child: SvgPicture.asset(
                  'assets/ic_close_zo.svg',
                  height: GlobalVariable.ratioFontSize(context) * 12,
                  width: GlobalVariable.ratioFontSize(context) * 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
