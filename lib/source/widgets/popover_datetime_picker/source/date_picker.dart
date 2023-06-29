part of '../popover_datetime_picker.dart';

class DatePicker extends StatefulWidget {
  final TimeManager timeManager;
  final Function(TimeManager timeManager) onDateChanged;
  final Color dateBackgroundColor;

  const DatePicker({
    super.key,
    required this.timeManager,
    required this.onDateChanged,
    required this.dateBackgroundColor,
  });

  @override
  ObservingStatefulWidget<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends ObservingStatefulWidget<DatePicker> {
  late ListWheelScrollView dayPicker;

  final dayController = FixedExtentScrollController();
  final monthController = FixedExtentScrollController();
  final yearController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    int daysInMonth = widget.timeManager.daysInMonth;
    dayPicker = _buildDayPicker(daysInMonth);
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    dayPicker.controller?.jumpTo((widget.timeManager.dateTime.day - 1) * _itemExtent);
    ListWheelScrollView yearPicker = _buildYearPicker() as ListWheelScrollView;
    yearPicker.controller?.jumpTo((widget.timeManager.dateTime.year - _years.first) * _itemExtent);
    ListWheelScrollView monthPicker = _buildMonthPicker() as ListWheelScrollView;
    monthPicker.controller?.jumpTo(((widget.timeManager.dateTime.month + _monthsInYear) - 1) * _itemExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.dateBackgroundColor,
        width: _pickerSize.width,
        height: _pickerSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 50, child: _buildDayPicker(widget.timeManager.daysInMonth)),
            SizedBox(width: 10, child: _buildSeperator('-')),
            SizedBox(width: 50, child: _buildMonthPicker()),
            SizedBox(width: 10, child: _buildSeperator('-')),
            SizedBox(width: 60, child: _buildYearPicker()),
          ],
        ));
  }

  // Define a list of years to be used in the year picker
  final List<int> _years = List<int>.generate(_yearSpan, (int index) => DateTime.now().year - (_yearSpan ~/ 2) + index);

  // Define the day picker widget
  ListWheelScrollView _buildDayPicker(int daysInMonth) {
    return ListWheelScrollView.useDelegate(
      itemExtent: _itemExtent,
      diameterRatio: _diameterRatio,
      controller: dayController,
      magnification: _magnification,
      useMagnifier: true,
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) => Center(
          child: Text('${index + 1}').fontSize(_fSize),
        ),
        childCount: daysInMonth,
      ),
      onSelectedItemChanged: (index) {
        setState(() {
          widget.timeManager.day = index + 1;
        });
        widget.onDateChanged(widget.timeManager);
      },
    );
  }

  // Define the month picker widget
  Widget _buildMonthPicker() {
    return ListWheelScrollView(
      itemExtent: _itemExtent,
      diameterRatio: _diameterRatio,
      controller: monthController,
      magnification: _magnification,
      useMagnifier: true,
      physics: const FixedExtentScrollPhysics(),
      children: List.generate(
        _monthsInYear * 3,
        (index) => Center(
          child: Text(DateFormat('MMM').format(DateTime(2000, (index % _monthsInYear) + 1))).fontSize(_fSize),
        ),
      ),
      onSelectedItemChanged: (index) {
        setState(() {
          widget.timeManager.month = (index % _monthsInYear) + 1;
        });
        widget.onDateChanged(widget.timeManager);
      },
    );
  }

  // Define the year picker widget
  Widget _buildYearPicker() {
    return ListWheelScrollView(
      itemExtent: _itemExtent,
      diameterRatio: _diameterRatio,
      controller: yearController,
      magnification: _magnification,
      useMagnifier: true,
      physics: const FixedExtentScrollPhysics(),
      children: List.generate(
        _years.length,
        (index) => Center(
          child: Text('${_years[index]}').fontSize(_fSize),
        ),
      ),
      onSelectedItemChanged: (index) {
        setState(() {
          widget.timeManager.year = _years[index];
        });
        widget.onDateChanged(widget.timeManager);
      },
    );
  }
}
