import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class TextHelper {
  static String dateFromMysqlString(String? str){
    if(str == null) return '';
    return DateFormat('dd MMM kk:mm').format(DateTime.parse(str));
  }

  static String convertDateAndTime(DateTime? date){
    if(date == null) return '';
    return DateFormat('dd MMM yyyy kk:mm').format(date);
  }

  static String convertDate(DateTime? date){
    if(date == null) return '';
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String convertShortDate(DateTime? date){
    if(date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String convertShortDateAndTime(DateTime? date){
    if(date == null) return '';
    return DateFormat('dd/MM/yyyy kk:mm').format(date);
  }

  static String convertDateToMysql(DateTime? date){
    if(date == null) return '';
    return DateFormat('yyyy-MM-dd kk:mm').format(date);
  }

  static String convertDateOnly(DateTime? date){
    if(date == null) return '';
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String convertTimeOnly(DateTime? date){
    if(date == null) return '';
    return DateFormat('kk:mm').format(date);
  }

  static String dateAgoFromMysqlString(String? str){
    if(str == null) return '';
    return timeago.format(DateTime.parse(str));
  }

  static bool isUrl(String text){
    // RegExp exp = RegExp(r'^(https?:\\/\\/)?((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|((\\d{1,3}\\.){3}\\d{1,3}))(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*(\\?[;&a-z\\d%_.~+=-]*)?(\\#[-a-z\\d_]*)?$');
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    return exp.hasMatch(text);
  }
}