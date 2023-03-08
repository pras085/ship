import 'package:flutter/material.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterDetailCard extends StatelessWidget {
  final Color borderColor;
  final Color backgroundColor;
  final String title;
  final Widget child;

  const ZoPromoTransporterDetailCard._({
    Key key,
    @required this.borderColor,
    @required this.backgroundColor,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  factory ZoPromoTransporterDetailCard.grey({
    @required String title,
    @required Widget child,
  }) {
    return ZoPromoTransporterDetailCard._(
      borderColor: Color(ListColor.colorLightGrey2),
      backgroundColor: Color(ListColor.colorLightGrey10).withOpacity(0.2),
      title: title,
      child: child,
    );
  }

  factory ZoPromoTransporterDetailCard.yellow({
    @required String title,
    @required Widget child,
  }) {
    return ZoPromoTransporterDetailCard._(
      borderColor: Color(ListColor.colorYellow4),
      backgroundColor: Color(ListColor.colorYellow4),
      title: title,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(
          '$title',
          color: Color(ListColor.colorBlack),
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 16.8 / 14,
          withoutExtraPadding: true,
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
        Container(
          padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: child,
        ),
      ],
    );
  }
}
