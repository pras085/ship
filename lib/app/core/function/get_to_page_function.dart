import 'dart:async';

import 'package:get/get.dart';

class GetToPage {
  static Future _navigation<s>(String page, Future Function() function,
      {dynamic arguments,
      int id,
      bool preventDuplicates = true,
      Map<String, String> parameters,
      bool isRegistered = true}) async {
    try {
      assert(s != dynamic,
          "You must add controller class. Example: GetToPage.toNamed<Bigfleets2Controller>(Routes.BIGFLEETS2);");
      var result;
      if (isRegistered) {
        if (Get.isRegistered<s>()) {
          return;
        }
        result = await function();
      } else {
        result = await function();
        Timer(Duration(milliseconds: 300), () {
            Get.delete<s>();
        });
      }
      return result;
    } catch (err) {
      print(err.toString());
    }

    return null;
  }

  static Future toNamed<s>(String page,
      {dynamic arguments,
      int id,
      bool preventDuplicates = true,
      Map<String, String> parameters,
      bool isRegistered = false}) async {
    return await _navigation<s>(page, () async {
      return await Get.toNamed(page,
          arguments: arguments,
          id: id,
          preventDuplicates: preventDuplicates,
          parameters: parameters);
    },
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        isRegistered: isRegistered);
  }

  static Future offNamed<s>(String page,
      {dynamic arguments,
      int id,
      bool preventDuplicates = true,
      Map<String, String> parameters}) async {
    return await _navigation<s>(page, () async {
      return await Get.offNamed(page,
          arguments: arguments,
          id: id,
          preventDuplicates: preventDuplicates,
          parameters: parameters);
    },
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }

  static Future offAllNamed<s>(String page,
      {dynamic arguments,
      int id,
      bool preventDuplicates = true,
      Map<String, String> parameters}) async {
    return await _navigation<s>(page, () async {
      return await Get.offAllNamed(page,
          arguments: arguments, id: id, parameters: parameters);
    },
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }
}
