extension DateStrExt on DateTime {
  String get numericDate => '$day/$month/$year';

  String get dateFormated {
    final local = toLocal();
    final day = local.day;
    final month = local.month;
    final year = local.year;
    return '$day ${_getMonthStr(month)} $year';
  }

  String get dateFormatedShort {
    final local = toLocal();
    final day = local.day;
    final month = local.month;
    return '$day ${_getMonthStr(month)}';
  }

  String get datetimeFormated => '$timeFormated - $dateFormated';

  String get timeFormated {
    final local = toLocal();
    final hr = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$hr:$min';
  }

  String get timeFormatedWithUnit {
    final local = toLocal();
    final unit = local.hour < 12 ? 'AM' : 'PM';
    final hrInt = local.hour > 12 ? local.hour - 12 : local.hour;
    final hr = hrInt.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$hr:$min $unit';
  }

  String get weekdayStr {
    return _getWeekdayStr(weekday);
  }

  bool isSameDay(DateTime date) {
    return difference(date).inDays == 0;
  }
}

String _getMonthStr(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return 'None';
  }
}

String _getWeekdayStr(int day) {
  switch (day) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return 'None';
  }
}
