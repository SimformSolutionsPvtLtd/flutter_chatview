import 'package:timeago/timeago.dart';

// Override "en" locale messages with custom messages that are more precise and short
// setLocaleMessages('en', ReceiptsCustomMessages())

// my_custom_messages.dart
class ReceiptsCustomMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'now';
  @override
  String aboutAMinute(int minutes) => '$minutes m ago';
  @override
  String minutes(int minutes) => '$minutes m ago';
  @override
  String aboutAnHour(int minutes) => '$minutes m ago';
  @override
  String hours(int hours) => '$hours h ago';
  @override
  String aDay(int hours) => '$hours h ago';
  @override
  String days(int days) => '$days d ago';
  @override
  String aboutAMonth(int days) => '$days d ago';
  @override
  String months(int months) => '$months mo ago';
  @override
  String aboutAYear(int year) => '$year y ago';
  @override
  String years(int years) => '$years y ago';
  @override
  String wordSeparator() => ' ';
}
