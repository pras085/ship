import 'package:flutter/services.dart';
import 'package:muatmuat/app/utils/utils.dart';

class ThousandSeparatorFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // if (newValue.text.isEmpty) return newValue.copyWith(text: "0", selection: TextSelection.collapsed(offset: 1));
    
    if (newValue.selection.baseOffset == 0) return newValue;

    bool useDecimal = false;
    String afterDecimal = "";
    String newText = newValue.text;

    if (newValue.text.contains(",")) {
      int posDecimal = newValue.text.indexOf(",");
      afterDecimal = newValue.text.substring(posDecimal);
      newText = newValue.text.substring(0, posDecimal);
      useDecimal = true;
    }

    if (afterDecimal.length > 3) afterDecimal = afterDecimal.substring(0, 3);

    newText = Utils.removeNumberFormat(newText);
    newText = Utils.delimeter(newText);

    if (useDecimal) newText = '$newText,${afterDecimal.replaceAll(',', '')}';

    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }
}