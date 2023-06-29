import 'package:intl/intl.dart';

/// Items in a DateTime object
enum DateTimeItem {
  year,
  month,
  day,
  hour,
  minute,
  second,
  millisecond,
  microsecond;

  static DateTime uniqueDateTime() => _unique();
  static Set<DateTimeItem> set() => _set;
  static bool isLeapYear([DateTime? dateTime]) => ((dateTime ?? DateTime.now()).isLeapYear());
  static String sqliteDateTime([DateTime? dateTime]) => (dateTime ?? DateTime.now()).sqliteDateTime;
}

final _set = {...DateTimeItem.values};

DateTime? _baseTime;

DateTime _unique() {
  DateTime newTime = (_baseTime ?? DateTime.now()).toUtc();
  _baseTime = (_baseTime != newTime) ? newTime : newTime.add(const Duration(microseconds: 100));
  return _baseTime!;
}

extension DateTimeExtension on DateTime {
  String timeStamp({bool utc = false}) {
    final String format = DateFormat('HH:mm:ss.SSS').format(utc ? toUtc() : toLocal());
    return (utc) ? '${format}Z' : format;
  }

  String asKey() => toUtc().toIso8601String().replaceAll(':', '').replaceAll('.', '').replaceAll('-', '').replaceAll('T', '').replaceAll('Z', '');

  int daysInMonth() => (isLeapYear() && month == 2) ? 29 : [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];

  bool isLeapYear() => (year % 400 == 0)
      ? true
      : (year % 100 == 0)
          ? false
          : (year % 4 == 0);

  String monthText([String fmt = 'MMM']) => DateFormat(fmt).format(this);

  String shortTime([String fmt = 'h:mm a']) => DateFormat(fmt).format(this);
  String shortDate([String fmt = 'dd-MMM-yyyy']) => DateFormat(fmt).format(this);

  String get sqliteDateTime => toUtc().toIso8601String();

  int get hour12 => (hour == 0)
      ? 12
      : (hour < 13)
          ? hour
          : hour - 12;

  DateTime update(DateTimeItem element, {required int to}) {
    return DateTime(
      (element == DateTimeItem.year ? to : year),
      (element == DateTimeItem.month ? to : month),
      (element == DateTimeItem.day ? to : day),
      (element == DateTimeItem.hour ? to : hour),
      (element == DateTimeItem.minute ? to : minute),
      (element == DateTimeItem.second ? to : second),
      (element == DateTimeItem.millisecond ? to : millisecond),
      (element == DateTimeItem.microsecond ? to : microsecond),
    );
  }

  /// Updates the DateTime by +/- on DateTimeItems
  DateTime next(DateTimeItem element, {int add = 1, bool toLastDay = true}) {
    switch (element) {
      case DateTimeItem.year:
        final result = copyWith(year: year + add);
        return (result.month == month) ? result : copyWith(day: day - 1).next(element, add: add);

      case DateTimeItem.month:
        final int dayCap = (toLastDay && day == daysInMonth())
            ? copyWith(
                month: month + add,
                day: 1,
              ).daysInMonth()
            : day;
        final result = copyWith(month: month + add, day: dayCap);
        return result;

      case DateTimeItem.day:
        return copyWith(day: day + add);

      case DateTimeItem.hour:
        return copyWith(hour: hour + add);

      case DateTimeItem.minute:
        return copyWith(minute: minute + add);

      case DateTimeItem.second:
        return copyWith(second: second + add);

      case DateTimeItem.microsecond:
        return copyWith(microsecond: microsecond + add);

      case DateTimeItem.millisecond:
        return copyWith(millisecond: millisecond + add);
    }
  }

  DateTime round([DateTimeItem element = DateTimeItem.second]) {
    switch (element) {
      case DateTimeItem.year:
        return DateTime(year);
      case DateTimeItem.month:
        return DateTime(year, month);
      case DateTimeItem.day:
        return DateTime(year, month, day);
      case DateTimeItem.hour:
        return DateTime(year, month, day, hour);
      case DateTimeItem.minute:
        return DateTime(year, month, day, hour, minute);
      case DateTimeItem.second:
        return DateTime(year, month, day, hour, minute, second);
      case DateTimeItem.millisecond:
        return DateTime(year, month, day, hour, minute, second, millisecond);
      case DateTimeItem.microsecond:
        return DateTime(year, month, day, hour, minute, second, millisecond, microsecond);
    }
  }
}
