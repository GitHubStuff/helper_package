import 'package:flutter_test/flutter_test.dart';
import 'package:helper_package/helper_package.dart';

void main() {
  group('DateTime Tests', () {
    test('asKey', () {
      final d1 = DateTime(2020, 1, 1, 11, 22, 33, 44, 55).toLocal().asKey();
      expect(d1, '20200101162233044055');
    });

    test('Round', () {
      final d1 = DateTime(2020, 1, 1, 11, 22, 33, 44, 55).round();
      expect(d1.isAtSameMomentAs(DateTime(2020, 1, 1, 11, 22, 33, 0, 0)), true);
    });

    test('sqlite', () {
      final d1 = DateTime(2020, 1, 1, 11, 22, 33, 44, 55).toLocal().sqliteDateTime;
      expect(d1, '2020-01-01T16:22:33.044055Z');
    });

    test('Unique Time', () {
      final d1 = DateTimeItem.uniqueDateTime();
      final d2 = DateTimeItem.uniqueDateTime();
      expect(d1.isAtSameMomentAs(d2), false);
    });

    test('Month Text', () {
      expect(DateTime(2020, 1).monthText(), 'Jan'); // January

      expect(DateTime(2020, 2).monthText(), 'Feb'); //Leap year February
      expect(DateTime(2021, 2).monthText(), 'Feb'); //Leap year February

      expect(DateTime(2020, 3).monthText(), 'Mar'); // March
      expect(DateTime(2020, 4).monthText(), 'Apr'); // April
      expect(DateTime(2020, 5).monthText(), 'May'); // May
      expect(DateTime(2020, 6).monthText(), 'Jun'); // June
      expect(DateTime(2020, 7).monthText(), 'Jul'); // July
      expect(DateTime(2020, 8).monthText(), 'Aug'); // August
      expect(DateTime(2020, 9).monthText(), 'Sep'); // September
      expect(DateTime(2020, 10).monthText(), 'Oct'); // October
      expect(DateTime(2020, 11).monthText(), 'Nov'); // November
      expect(DateTime(2020, 12).monthText(), 'Dec'); // December
    });
    test('Days in Month', () {
      expect(DateTime(2020, 1).daysInMonth(), 31); // January

      expect(DateTime(2020, 2).daysInMonth(), 29); //Leap year February
      expect(DateTime(2021, 2).daysInMonth(), 28); //Leap year February

      expect(DateTime(2020, 3).daysInMonth(), 31); // March
      expect(DateTime(2020, 4).daysInMonth(), 30); // April
      expect(DateTime(2020, 5).daysInMonth(), 31); // May
      expect(DateTime(2020, 6).daysInMonth(), 30); // June
      expect(DateTime(2020, 7).daysInMonth(), 31); // July
      expect(DateTime(2020, 8).daysInMonth(), 31); // August
      expect(DateTime(2020, 9).daysInMonth(), 30); // September
      expect(DateTime(2020, 10).daysInMonth(), 31); // October
      expect(DateTime(2020, 11).daysInMonth(), 30); // November
      expect(DateTime(2020, 12).daysInMonth(), 31); // December
    });
    test('DateTime.now() returns a DateTime', () {
      var dateTime = DateTime.now();
      expect(dateTime, isA<DateTime>());
    });

    test('Is Leap year', () {
      var dateTime = DateTime(2020, 1, 1);
      expect(dateTime.isLeapYear(), true);
    });

    test('Is Not Leap year', () {
      var dateTime = DateTime(2021, 1, 1);
      expect(dateTime.isLeapYear(), false);
    });
  });
}
