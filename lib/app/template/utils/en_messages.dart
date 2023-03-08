import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:timeago/timeago.dart';

class LocaleMessagesEn implements LookupMessages {
  @override
  String aDay(int hours) => hours >= 24 ? 'Yesterday' : 'Today';

  @override
  String aboutAMinute(int minutes) => minutes >= 60 ? 'a minute ago' : '$minutes seconds ago';

  @override
  String aboutAMonth(int days) => days >= 30 ? 'a month ago' : '$days days ago';

  @override
  String aboutAYear(int year) => year >= 12 ? 'a year ago' : '$year months ago';

  @override
  String aboutAnHour(int minutes) => minutes > 60 ? 'an hour ago' : '$minutes minutes ago';

  @override
  String days(int days) => days <= 7 ? '$days days ago' : Utils.formatDate(value: (DateTime.now().subtract(Duration(days: days))).toIso8601String(), format: 'dd MMM yyyy');

  @override
  String hours(int hours) => '$hours hours ago';

  @override
  String minutes(int minutes) => '$minutes minutes ago';

  @override
  String months(int months) => '$months months ago';

  @override
  String years(int years) => '$years years ago';
  
  @override
  String lessThanOneMinute(int seconds) => '$seconds seconds ago';

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