import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PhoneNumberValidator {
  static String validate(
      {@required String value,
      String warningIfEmpty,
      String warningIfFormatNotMatch,
      int minLength = 10,
      bool isMustZeroFirst = false}) {
    warningIfEmpty = warningIfEmpty == null
        ? "GlobalValidatorLabelPhoneNumberIsEmpty".tr
        : warningIfEmpty;
    warningIfFormatNotMatch = warningIfFormatNotMatch == null
        ? "GlobalValidatorLabelPhoneNumberFalseFormat".tr
        : warningIfFormatNotMatch;
    String messageWarning;
    if (value.isEmpty)
      messageWarning = warningIfEmpty;
    else if (value.length < minLength)
      messageWarning = warningIfFormatNotMatch;
    else if (value.length > 0 &&
        value.substring(0, 1) != "0" &&
        isMustZeroFirst)
      messageWarning = "GlobalValidatorLabelPhoneNumberFalseFormat2".tr;
    else if (value.length > 1 &&
        value.substring(0, 2) != "08" &&
        isMustZeroFirst)
      messageWarning = "GlobalValidatorLabelPhoneNumberFalseFormat2".tr;
    else if (value[0].allMatches(value).length == value.length)
      messageWarning = "GlobalValidatorLabelPhoneNumberFalseFormat2".tr;
    return messageWarning;
  }
}
