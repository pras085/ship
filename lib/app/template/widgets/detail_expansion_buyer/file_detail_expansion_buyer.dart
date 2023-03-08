import 'package:flutter/material.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/child_detail_expansion_buyer.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class FileDetailExpansionBuyer extends ChildDetailExpansionBuyer {

  final int itemCount;
  final TileFileDetailExtensionBuyer Function(BuildContext context, int i) itemBuilder;

  FileDetailExpansionBuyer({
    @required this.itemCount,
    @required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) {
        return SizedBox(
          height: GlobalVariable.ratioWidth(context) * 12,
        );
      },
      itemBuilder: itemBuilder,
    );
  }

}

class TileFileDetailExtensionBuyer extends StatelessWidget {

  final String image;
  final String label;
  final VoidCallback onTap;

  const TileFileDetailExtensionBuyer({
    @required this.image,
    @required this.label,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: GlobalVariable.ratioWidth(context) * 67,
        padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(ListColor.colorGreyTemplate6),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
        ),
        child: Row(
          children: [
            SizedBox(
              width: GlobalVariable.ratioWidth(context) * 68,
              height: GlobalVariable.ratioWidth(context) * 53,
              child: Image.network(image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(context) * 12,
            ),
            Expanded(
              child: CustomText(label,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 16.8/14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}