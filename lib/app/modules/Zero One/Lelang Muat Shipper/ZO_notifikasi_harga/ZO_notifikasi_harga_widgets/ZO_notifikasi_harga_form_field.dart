import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaPromoFormModel {
  final String value;
  final Widget widget;

  const ZoNotifikasiHargaPromoFormModel(this.value, this.widget);
}

class ZoNotifikasiHargaFormFieldItem {
  final String value;
  final String display;

  const ZoNotifikasiHargaFormFieldItem({
    @required this.value,
    @required this.display,
  });

  factory ZoNotifikasiHargaFormFieldItem.fromValue(String value) {
    return ZoNotifikasiHargaFormFieldItem(
      display: value,
      value: value,
    );
  }

  @override
  String toString() {
    return 'ZoNotifikasiHargaStringFormFieldItem(value: $value, display: $display)';
  }
}

class ZoNotifikasiHargaFormField extends StatelessWidget {
  final String label;
  final String value;
  final List<ZoNotifikasiHargaFormFieldItem> items;
  final void Function() onTap;
  final bool isDropdown;
  final void Function(String) onChanged;
  final String selectedValueDisplay;

  const ZoNotifikasiHargaFormField({
    Key key,
    this.label,
    this.value,
    this.onTap,
    this.items,
    this.isDropdown = false,
    this.onChanged,
    this.selectedValueDisplay,
  }) : super(key: key);

  static OutlineInputBorder getBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(ListColor.colorLightGrey19),
      ),
      borderRadius: BorderRadius.circular(6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    debugPrint('$value');
    debugPrint('$items');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          label,
          color: Color(ListColor.colorGrey3),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * 8,
        ),
        if (isDropdown)
          LayoutBuilder(builder: (context, constraints) {
            final textStyle = TextStyle(
              color: Color(ListColor.colorLightGrey4),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );
            bool isFocused = false;
            return StatefulBuilder(builder: (context, setState) {
              return GestureDetector(
                onTap: () {
                  setState(() => isFocused = !isFocused);
                  debugPrint(isFocused.toString());
                },
                child:
                    // DropdownButtonFormField(
                    //   selectedItemBuilder: (context) {
                    //     return items
                    //         .map(
                    //           (item) => CustomText(
                    //             value,
                    //             color: textStyle.color,
                    //             fontSize: textStyle.fontSize,
                    //             fontWeight: textStyle.fontWeight,
                    //             height: textStyle.height,
                    //           ),
                    //         )
                    //         .toList();
                    //   },
                    //   decoration: InputDecoration(
                    //     contentPadding: EdgeInsets.all(
                    //       GlobalVariable.ratioWidth(context) * 12,
                    //     ),
                    //     isDense: true,
                    //     fillColor: Colors.white,
                    //     focusColor: Colors.white,
                    //     hoverColor: Colors.white,
                    //     border: OutlineInputBorder(
                    //       gapPadding: 0,
                    //       borderSide: BorderSide(
                    //         width: 1,
                    //         color: Color(ListColor.colorLightGrey19),
                    //       ),
                    //       borderRadius: BorderRadius.circular(6),
                    //     ),
                    //     // ),
                    //   ),
                    IntrinsicHeight(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      DropdownBelow(
                        itemWidth: constraints.maxWidth,
                        itemTextstyle: textStyle,
                        boxTextstyle:
                            textStyle.copyWith(color: Colors.transparent),
                        boxPadding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.ratioWidth(context) * 12,
                        ),
                        boxWidth: constraints.maxWidth,
                        boxDecoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        items: items
                            .map(
                              (item) => DropdownMenuItem(
                                value: item.value,
                                child: CustomText(
                                  item.display,
                                  color: textStyle.color,
                                  fontSize: textStyle.fontSize,
                                  fontWeight: textStyle.fontWeight,
                                  height: textStyle.height,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: onChanged,
                        isDense: true,
                        icon: Icon(
                          // isFocused
                          //     ? Icons.keyboard_arrow_up
                          // :
                          Icons.keyboard_arrow_down,
                          color: Colors.transparent,
                          size: GlobalVariable.ratioFontSize(context) * 24,
                        ),
                        hint: CustomText(
                          value ?? ZoNotifikasiHargaStrings.dropdownHint.tr,
                          fontWeight: textStyle.fontWeight,
                          fontSize: textStyle.fontSize,
                          color: textStyle.color,
                        ),
                        value: value,
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: Container(
                          padding: EdgeInsets.all(
                              GlobalVariable.ratioWidth(context) * 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(ListColor.colorLightGrey19),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  value == null
                                      ? ZoNotifikasiHargaStrings.dropdownHint.tr
                                      : value,
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  // height:
                                  //     GlobalVariable.ratioFontSize(context) * (16.8 / 14),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(ListColor.colorGrey3),
                                size:
                                    GlobalVariable.ratioFontSize(context) * 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          })
        else
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(ListColor.colorLightGrey19),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      value == null
                          ? ZoNotifikasiHargaStrings.dropdownHint.tr
                          : value,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      // height:
                      //     GlobalVariable.ratioFontSize(context) * (16.8 / 14),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(ListColor.colorGrey3),
                    size: GlobalVariable.ratioFontSize(context) * 24,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
