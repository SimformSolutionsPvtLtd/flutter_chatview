// This code is sourced from the timeago package available on pub.dev. link: https://pub.dev/packages/timeago

import 'package:chatview/src/utils/timeago/en_messages.dart';
import 'package:chatview/src/utils/timeago/lookupmessages.dart';
import 'package:flutter/foundation.dart';

String _default = 'en';

Map<String, LookupMessages> _lookupMessagesMap = {
  'en': EnMessages(),
  'en_short': EnShortMessages(),
};

/// Sets the default [locale]. By default it is `en`.
///
/// Example
/// ```
/// setLocaleMessages('fr', FrMessages());
/// setDefaultLocale('fr');
/// ```
void setDefaultLocale(String locale) {
  assert(_lookupMessagesMap.containsKey(locale),
      '[locale] must be a registered locale');
  _default = locale;
}

/// Sets a [locale] with the provided [lookupMessages] to be available when
/// using the [format] function.
///
/// Example:
/// ```dart
/// setLocaleMessages('fr', FrMessages());
/// ```
///
/// If you want to define locale message implement [LookupMessages] interface
/// with the desired messages
///
void setLocaleMessages(String locale, LookupMessages lookupMessages) {
  _lookupMessagesMap[locale] = lookupMessages;
}

/// Formats provided [date] to a fuzzy time like 'a moment ago'
///
/// - If [locale] is passed will look for message for that locale, if you want
///   to add or override locales use [setLocaleMessages]. Defaults to 'en'
/// - If [clock] is passed this will be the point of reference for calculating
///   the elapsed time. Defaults to DateTime.now()
/// - If [allowFromNow] is passed, format will use the From prefix, ie. a date
///   5 minutes from now in 'en' locale will display as "5 minutes from now"
String format(DateTime date,
    {String? locale, DateTime? clock, bool allowFromNow = false}) {
  final locale0 = locale ?? _default;
  if (_lookupMessagesMap[locale0] == null) {
    debugPrint(
        "Locale [$locale0] has not been added, using [$_default] as fallback. To add a locale use [setLocaleMessages]");
  }
  final allowFromNow0 = allowFromNow;
  final messages = _lookupMessagesMap[locale0] ?? EnMessages();
  final clock0 = clock ?? DateTime.now();
  var elapsed = clock0.millisecondsSinceEpoch - date.millisecondsSinceEpoch;

  String prefix, suffix;

  if (allowFromNow0 && elapsed < 0) {
    elapsed = date.isBefore(clock0) ? elapsed : elapsed.abs();
    prefix = messages.prefixFromNow();
    suffix = messages.suffixFromNow();
  } else {
    prefix = messages.prefixAgo();
    suffix = messages.suffixAgo();
  }

  final num seconds = elapsed / 1000;
  final num minutes = seconds / 60;
  final num hours = minutes / 60;
  final num days = hours / 24;
  final num months = days / 30;
  final num years = days / 365;

  String result;
  if (seconds < 45) {
    result = messages.lessThanOneMinute(seconds.round());
  } else if (seconds < 90) {
    result = messages.aboutAMinute(minutes.round());
  } else if (minutes < 45) {
    result = messages.minutes(minutes.round());
  } else if (minutes < 90) {
    result = messages.aboutAnHour(minutes.round());
  } else if (hours < 24) {
    result = messages.hours(hours.round());
  } else if (hours < 48) {
    result = messages.aDay(hours.round());
  } else if (days < 30) {
    result = messages.days(days.round());
  } else if (days < 60) {
    result = messages.aboutAMonth(days.round());
  } else if (days < 365) {
    result = messages.months(months.round());
  } else if (years < 2) {
    result = messages.aboutAYear(months.round());
  } else {
    result = messages.years(years.round());
  }

  return [prefix, result, suffix]
      .where((str) => str.isNotEmpty)
      .join(messages.wordSeparator());
}
