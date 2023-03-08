import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static String delimeter(String number) {
    if (number == "") return number;
    if (number == "null" || number == null) return "";

    final formatter = NumberFormat("#,###.####");
    double raw = double.tryParse(number) ?? 0;
    String result = formatter.format(raw).toString();
    result = result.replaceAll(",", "~~");
    result = result.replaceAll(".", "||");
    result = result.replaceAll("~~", ".");
    result = result.replaceAll("||", ",");

    return result;
  }

  static String removeNumberFormat(String number) {
    String result = number;
    result = result.replaceAll(",", "~~");
    result = result.replaceAll(".", "||");
    result = result.replaceAll("~~", ".");
    result = result.replaceAll("||", "");
    
    return result;
  }

  static formatDate({@required String value, @required String format}) {
    if (value.isEmpty) return "";
    if (Get.locale == null) return DateFormat(format).format(DateTime.parse(value));
    return DateFormat(format).format(DateTime.parse(value));
  }

  static formatCurrency({@required num value, int decimalDigits = 2}) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: value % 1 == 0 ? 0 : decimalDigits).format(value);
  }
}

enum LabelColor {
  yellow, orange, blue
}