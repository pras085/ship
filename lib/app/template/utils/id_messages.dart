import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:timeago/timeago.dart';

class LocaleMessagesId implements LookupMessages {
  @override
  String aDay(int hours) => hours >= 24 ? 'Kemarin' : 'Hari Ini';

  @override
  String aboutAMinute(int minutes) => minutes >= 60 ? '1 menit yang lalu' : '$minutes detik yang lalu';

  @override
  String aboutAMonth(int days) => days >= 30 ? '1 bulan yang lalu' : '$days hari yang lalu';

  @override
  String aboutAYear(int year) => year >= 12 ? '1 tahun yang lalu' : '$year bulan yang lalu';

  @override
  String aboutAnHour(int minutes) => minutes > 60 ? '1 jam yang lalu' : '$minutes menit yang lalu';

  @override
  String days(int days) => days <= 7 ? '$days hari yang lalu' : Utils.formatDate(value: (DateTime.now().subtract(Duration(days: days))).toIso8601String(), format: 'dd MMM yyyy');

  @override
  String hours(int hours) => '$hours jam yang lalu';

  @override
  String minutes(int minutes) => '$minutes menit yang lalu';

  @override
  String months(int months) => '$months bulan yang lalu';

  @override
  String years(int years) => '$years tahun yang lalu';
  
  @override
  String lessThanOneMinute(int seconds) => '$seconds detik yang lalu';

  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String wordSeparator() => ' ';
}