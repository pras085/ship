import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoPromoTransporterSheetBase extends StatelessWidget {
  final String title;
  final List<Widget> rows;
  final Color titleColor;
  final AlignmentGeometry titleAlignment;
  final void Function() onClose;

  const ZoPromoTransporterSheetBase({
    Key key,
    this.rows,
    this.title,
    this.titleColor,
    this.onClose,
    this.titleAlignment = Alignment.center,
  }) : super(key: key);

  static ShapeBorder getShape() => const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      );

  static Color getBackgroundColor() => Color(ListColor.colorWhite);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: GlobalVariable.ratioWidth(context) * 4),
        Container(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(ListColor.colorLightGrey16),
              ),
              height: GlobalVariable.ratioWidth(context) * 3,
              width: GlobalVariable.ratioWidth(context) * 38,
            ),
          ),
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 16),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(context) * 21,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: titleAlignment == Alignment.centerLeft ||
                          titleAlignment == Alignment.topLeft ||
                          titleAlignment == Alignment.bottomLeft
                      ? GlobalVariable.ratioWidth(context) * 30
                      : 0,
                ),
                child: Align(
                  alignment: titleAlignment,
                  child: CustomText(
                    title.tr ?? "",
                    color: titleColor ?? Color(ListColor.colorBlue),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    // height: GlobalVariable.ratioFontSize(context) * (16.8 / 14),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(context) * 16,
              ),
              child: GestureDetector(
                onTap: () {
                  if (onClose != null) {
                    onClose();
                  }
                  Get.back();
                },
                child: SvgPicture.asset(
                  "assets/ic_close_simple.svg",
                  color: Color(ListColor.colorBlack),
                  width: GlobalVariable.ratioFontSize(context) * 24,
                  height: GlobalVariable.ratioFontSize(context) * 24,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: GlobalVariable.ratioWidth(context) * 23),
        ListView.separated(
          shrinkWrap: true,
          itemCount: rows.length,
          itemBuilder: (context, index) => rows[index],
          separatorBuilder: (context, index) => Divider(
            color: Color(ListColor.colorLightGrey10),
            height: GlobalVariable.ratioWidth(context) * 0.5,
            thickness: GlobalVariable.ratioWidth(context) * 0.5,
            indent: GlobalVariable.ratioWidth(context) * 16,
            endIndent: GlobalVariable.ratioWidth(context) * 16,
          ),
        ),
        // if (rows == null || rows.isEmpty)
        //   const SizedBox.shrink()
        // else ...[
        //   for (int i = 0; i < rows.length - 1; i++) ...[
        //     rows[i],

        //   ],
        //   rows[rows.length - 1],
        // ],
        SizedBox(height: GlobalVariable.ratioWidth(context) * 5),
      ],
    );
  }
}
