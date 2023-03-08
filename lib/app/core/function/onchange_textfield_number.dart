import 'package:flutter/cupertino.dart';

class OnChangeTextFieldNumber {
  static void checkNumber(
      TextEditingController Function() textEditingController,
      String value,
      bool removeZeroFront) {
    if (value == "" && removeZeroFront) {
      textEditingController().text = "0";
      textEditingController().selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController().text.length));
    } else {
      int pos = textEditingController().selection.base.offset;
      String replace = removeZeroFront
          ? value.replaceAllMapped(RegExp("(^0*)|([^0-9])"), (match) => "")
          : value.replaceAllMapped(RegExp("[^0-9]"), (match) => "");
      replace = replace.replaceAll("-", "");
      replace = replace.replaceAll(",", "");
      if (replace.isEmpty || int.parse(replace) <= 0) replace = "0";
      if (replace != value) {
        textEditingController().text = replace;
        textEditingController().selection =
            TextSelection.fromPosition(TextPosition(
                offset: replace == "0"
                    ? textEditingController().text.length
                    : pos == 0
                        ? 0
                        : pos - 1));
      }
    }
  }

  static void checkDecimal(
      TextEditingController Function() textEditingController, String value) {
    if (value == "") {
      textEditingController().text = "0";
      textEditingController().selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController().text.length));
    } else {
      int pos = textEditingController().selection.base.offset;
      String replace = value.replaceAll(".", "");
      replace = replace.replaceAll("-", "");
      var replaceSplit = replace.split("");
      if (",".allMatches(replace).length > 1) {
        replaceSplit.removeAt(replace.lastIndexOf(","));
      }
      if (replaceSplit.length > 1 &&
          replaceSplit[0] == "0" &&
          replaceSplit[1] != ",") {
        replaceSplit.removeAt(0);
      }
      replace = (replaceSplit[0] == "," ? "0" : "") + replaceSplit.join();
      var splitText = replace.split(",");
      if (splitText.length == 2 && splitText[1].length >= 3) {
        replace = splitText[0] + "," + splitText[1][0] + splitText[1][1];
      }
      if (replace != value) {
        textEditingController().text = replace;
        textEditingController().selection = TextSelection.fromPosition(
            TextPosition(offset: pos == 0 ? 0 : pos - 1));
      }
    }
  }
}
