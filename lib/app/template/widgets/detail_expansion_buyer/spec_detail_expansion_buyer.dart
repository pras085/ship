import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/child_detail_expansion_buyer.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:get/get.dart';

class SpecDetailExpansionBuyer extends ChildDetailExpansionBuyer {

  final bool lastBorder;
  final Map dataDetail;

  SpecDetailExpansionBuyer({
    this.dataDetail,
    this.lastBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    print("DATA DETAIL :: $dataDetail");
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dataDetail.length,
      separatorBuilder: (_, i) {
        if (dataDetail.values.toList()[i] == null) {
          return SizedBox.shrink();
        }
        return Container(
          width: double.infinity,
          height: GlobalVariable.ratioWidth(context) * 0.5,
          color: Color(ListColor.colorGreyTemplate2),
          margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(context) * 8,
            bottom: GlobalVariable.ratioWidth(context) * 12,
          ),
        );
      },
      itemBuilder: (ctx, i) {
        if (dataDetail.values.toList()[i] == null) {
          return SizedBox.shrink();
        }
        return Column(
          children: [
            _KeyValueFileDetailExtensionBuyer(
              // label: "${dataDetail.keys.toList()[i]}".capitalize, 
              label: "${dataDetail.keys.toList()[i]}",
              // value: "${dataDetail.values.toList()[i]}".capitalize, 
              value: "${dataDetail.values.toList()[i]}",
            ),
            if (i == dataDetail.length-1 && lastBorder)
              Container(
                width: double.infinity,
                height: GlobalVariable.ratioWidth(context) * 0.5,
                color: Color(ListColor.colorGreyTemplate2),
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(context) * 8,
                ),
              ),
          ],
        );
      }, 
    );
  }

}

class _KeyValueFileDetailExtensionBuyer extends StatelessWidget {

  final String label;
  final String value;

  const _KeyValueFileDetailExtensionBuyer({
    @required this.label,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomText(label,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            withoutExtraPadding: true,
            height: 16.8/14,
            color: Color(ListColor.colorGreyTemplate3),
          ),
        ),
        SizedBox(
          width: GlobalVariable.ratioWidth(context) * 12,
        ),
        Expanded(
          child: CustomText(value,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            withoutExtraPadding: true,
            height: 16.8/14,
          ),
        ),
      ],
    );
  }
}