import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/dropdown_overlay.dart';
import 'package:muatmuat/global_variable.dart';

import 'custom_text.dart';

class OutlineDropdownComponent extends StatelessWidget {

  final Map selectedData;
  final List<Map> dataList;
  final Function(Map value) onSelected;
  final String hint;
  final String keyName; // name for show to ui
  final Color focusColor;

  const OutlineDropdownComponent({
    Key key,
    @required this.selectedData,
    @required this.dataList,
    @required this.onSelected,
    this.hint = "choose..",
    @required this.keyName,
    this.focusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownOverlay<Map>(
      value: selectedData,
      dataList: dataList,
      contentPadding: EdgeInsets.symmetric(
        vertical: GlobalVariable.ratioWidth(context) * 6,
        horizontal: GlobalVariable.ratioWidth(context) * 12,
      ),
      itemBuilder: (ctx, data) {
        return GestureDetector(
          onTap: () {
            onSelected(data);
            FocusScope.of(ctx).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(context) * 6,
            ),
            child: CustomText(data[keyName],
              color: Color(ListColor.colorLightGrey4),
              withoutExtraPadding: true,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
      borderWidth: GlobalVariable.ratioWidth(context) * 1,
      radius: GlobalVariable.ratioWidth(context) * 6,
      borderColor: FocusScope.of(context).hasFocus ? focusColor ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
      builder: (ctx, data, isOpen, hasFocus) {
        return Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
            side: BorderSide(
              color: hasFocus ? focusColor ?? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey2),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(context) * 8,
              horizontal: GlobalVariable.ratioWidth(context) * 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(data != null ? data[keyName] : hint),
                ),
                SvgPicture.asset(isOpen ? GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_up.svg' : GlobalVariable.urlImageTemplateBuyer + 'ic_chevron_down.svg',
                  width: GlobalVariable.ratioWidth(context) * 16,
                  height: GlobalVariable.ratioWidth(context) * 16,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}