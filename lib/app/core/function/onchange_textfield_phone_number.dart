import 'package:flutter/cupertino.dart';

class OnChangeTextFieldPhoneNumber {
  static void checkPhoneNumber(
      TextEditingController Function() textEditingController, String value) {
    int pos = textEditingController().selection.base.offset;
    String replace = value.replaceAllMapped(RegExp("[^0-9]"), (match) => "");
    if (replace != value) {
      textEditingController().text = replace;
      textEditingController().selection =
          TextSelection.fromPosition(TextPosition(offset: pos - 1));
    }
  }
}
