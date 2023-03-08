import 'package:azlogistik_chat/utilities/config.dart';

class ModelHelper {
  static String stringFromJson(dynamic val){
    if(val == null) return "";
    return val.toString();
  }

  static bool boolFromJson(dynamic val){
    if(val == null) return false;
    var fval = val.toString().toLowerCase();
    return (fval == "true" || fval == "1")  ? true : false;
  }

  static double doubleFromJson(dynamic val){
    if(val == null) return 0;
    return double.tryParse(val.toString()) ?? 0;
  }

  static int intFromJson(dynamic val){
    if(val == null) return 0;
    return int.tryParse(val.toString()) ?? 0;
  }

  static DateTime? dateTimeFromJson(dynamic dateString){
    if(dateString == null) return null;
    return DateTime.tryParse(dateString.toString());
  }
  
  static DateTime? dateTimeLocalFromJson(dynamic dateString){
    if(dateString == null) return null;
    
    return DateTime.tryParse(dateString.toString())
      ?.subtract(Config.serverTimezone)
      .add(DateTime.now().timeZoneOffset);
  }
}