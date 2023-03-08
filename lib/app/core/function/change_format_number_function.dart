class ChangeFormatNumberFunction {
  static String convertPhoneNumber(String number) {
    final formatAngkaDepan = RegExp("^0");
    String result = number.replaceAllMapped(RegExp("^62"), (match) => "0");
    result = !formatAngkaDepan.hasMatch(result) ? ("0" + result) : result;
    return result;
  }
}
