import 'package:flutter/material.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaListField extends StatelessWidget {
  final String label;
  final String value;

  const ZoNotifikasiHargaListField({
    Key key,
    this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          '$label',
          color: Color(ListColor.colorGrey3),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * 8,
        ),
        CustomText(
          '${value ?? '-'}',
          color: Color(ListColor.colorBlack),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
