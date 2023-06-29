import 'package:flutter/material.dart';
import '../../../extensions/date_time_extensions.dart';

class TimeManager {
  late DateTime _dateTime;
  late TimeOfDay _timeOfDay;

  DateTime get dateTime => DateTime(
        _dateTime.year,
        _dateTime.month,
        _dateTime.day,
        _timeOfDay.hour,
        _timeOfDay.minute,
        _dateTime.second,
      );
  int get daysInMonth => dateTime.daysInMonth();

  TimeManager({required DateTime dateTime, required bool showTime})
      : _dateTime = dateTime {
    _dateTime =
        _dateTime.round(showTime ? DateTimeItem.second : DateTimeItem.day);
    _timeOfDay = TimeOfDay.fromDateTime(_dateTime);
  }

  bool isAm() => _timeOfDay.period == DayPeriod.am;

  set year(int newYear) {
    final int month = _dateTime.month;
    _dateTime = _dateTime.update(DateTimeItem.year, to: newYear);
    if (_dateTime.month != month) {
      final int daysInMonth = DateTime(newYear, month, 1).daysInMonth();
      _dateTime = _dateTime.update(DateTimeItem.day, to: daysInMonth);
      _dateTime = _dateTime.update(DateTimeItem.month, to: month);
    }
  }

  set month(int newMonth) {
    final int year = _dateTime.year;
    _dateTime = _dateTime.update(DateTimeItem.month, to: newMonth);
    if (_dateTime.month != newMonth) {
      final int daysInMonth = DateTime(year, newMonth, 1).daysInMonth();
      _dateTime = _dateTime.update(DateTimeItem.day, to: daysInMonth);
      _dateTime = _dateTime.update(DateTimeItem.month, to: newMonth);
    }
  }

  set day(int newDay) =>
      _dateTime = _dateTime.update(DateTimeItem.day, to: newDay);

  int get hour => _timeOfDay.hour;
  set hour(int newHour) {
    if (newHour == 12) {
      newHour = _timeOfDay.period == DayPeriod.am ? 0 : 12;
    } else if (_timeOfDay.period == DayPeriod.pm) {
      newHour += 12;
    }
    _timeOfDay = _timeOfDay.replacing(hour: newHour);
  }

  int get minute => _timeOfDay.minute;
  set minute(int newMinute) =>
      _timeOfDay = _timeOfDay.replacing(minute: newMinute);

  int get second => _dateTime.second;
  set second(int newSecond) =>
      _dateTime = _dateTime.update(DateTimeItem.second, to: newSecond);

  set period(DayPeriod newPeriod) {
    if (_timeOfDay.period == newPeriod) return;
    int hour = (newPeriod == DayPeriod.am)
        ? _timeOfDay.hour - 12
        : _timeOfDay.hour + 12;
    _timeOfDay = _timeOfDay.replacing(hour: hour);
  }
}
