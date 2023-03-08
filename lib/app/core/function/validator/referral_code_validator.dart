import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReferralCodeValidator {
  static String validate(
      {@required String value, String warningIfValueFormatNotMatch}) {
    int minMaxLength = 8;
    warningIfValueFormatNotMatch = warningIfValueFormatNotMatch == null
        ? "GlobalValidatorLabelReferralCodeFalseFormat".tr
        : warningIfValueFormatNotMatch;
    String messageWarning = (value.isNotEmpty && value.length != minMaxLength)
        ? warningIfValueFormatNotMatch
        : null;
    return messageWarning;
  }
}
