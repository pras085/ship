import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'page_checkbox_buyer.dart';

class CheckboxBuyer extends StatelessWidget {

  final String title;
  final List listCheckbox;
  final List listAliasCheckbox;
  final List selectedListCheckbox;
  final Function(String value) onCheckboxTap;
  final Function(List value) onUpdate;

  const CheckboxBuyer({
    @required this.title, // the title of your checkbox.
    @required this.listCheckbox, // the list of your checkbox.
    this.listAliasCheckbox, // the list of your aliases checkbox.
    @required this.selectedListCheckbox, // the selectedList of your checkbox.
    @required this.onCheckboxTap, // onCheckbox tap when the checkbox is component not a page.
    @required this.onUpdate, // onUpdate, here gives you value after moving page from checkbox page.
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontSize: 14,
          color: Color(ListColor.colorBlack),
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * 12,
        ),
        for (int i=0;i<(listCheckbox.length > 5 ? 5 : listCheckbox.length);i++)
          Container(
            margin: EdgeInsets.only(
              bottom: i != listCheckbox.length-1 ? GlobalVariable.ratioWidth(context) * 12 : 0,
            ),
            child: InkWell(
              onTap: () => onCheckboxTap(listCheckbox[i]),
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: true,
                    child: CheckBoxCustom(
                      border: 1,
                      size: 20,
                      isWithShadow: true,
                      paddingTop: 0,
                      paddingLeft: 0,
                      paddingRight: 0,
                      paddingBottom: 0,
                      onChanged: null,
                      value: selectedListCheckbox.contains(listCheckbox[i]),
                    ),
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(context) * 8,
                  ),
                  Expanded(
                    child: CustomText(
                      "${listAliasCheckbox != null ? listAliasCheckbox[i] : listCheckbox[i]}",
                      fontSize: 14,
                      color: Color(ListColor.colorGreyTemplate3),
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (listCheckbox.length > 5)
          InkWell(
            onTap: () async {
              final result = await Get.to(() => PageCheckboxBuyer(
                title: title,
                listCheckbox: listCheckbox,
                selectedListCheckbox: selectedListCheckbox,
              )) as List;
              if (result != null) {
                onUpdate(result);
              }
            },
            child: CustomText(
              "Lihat Pilihan Lainnya",
              fontSize: 12,
              color: Color(ListColor.colorBlueTemplate1),
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}