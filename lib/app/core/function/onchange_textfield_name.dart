import 'package:flutter/material.dart';

class OnChangeTextFieldName {
  static void checkNameFormat(
      TextEditingController Function() textEditingController, String value) {
    int pos = textEditingController().selection.base.offset;
    String replace =
        value.replaceAllMapped(RegExp("[^a-zA-Z ]"), (match) => "");
    if (replace != value) {
      textEditingController().text = replace;
      int posAfter = pos == 0 ? 0 : pos - 1;
      if (posAfter > replace.length) posAfter = replace.length;
      textEditingController().selection =
          TextSelection.fromPosition(TextPosition(offset: posAfter));
    }
  }
}
