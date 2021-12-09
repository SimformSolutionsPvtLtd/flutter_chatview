import 'package:intl/intl.dart';

import '../constants.dart';

extension TimeDifference on DateTime {
  String get getDay {
    final DateTime tempDate = DateFormat(dateFormat).parse(toString());
    final DateFormat formatter = DateFormat.yMMMMd(en_us);
    final differenceInDays = tempDate.difference(DateTime.now()).inDays;
    if (differenceInDays == 0) {
      return today;
    } else if (differenceInDays <= 1 && differenceInDays >= -1) {
      return yesterday;
    } else {
      return formatter.format(tempDate);
    }
  }

  String get getDateFromDateTime {
    final DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }

  String get getTimeFromDateTime => DateFormat.Hm().format(this);
}
