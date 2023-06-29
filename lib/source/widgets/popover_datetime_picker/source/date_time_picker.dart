part of '../popover_datetime_picker.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    required this.initialDateTime,
    required this.onDateChanged,
    required this.dateBackgroundColor,
    required this.timeBackgroundColor,
    required this.headerColor,
    required this.includeSeconds,
    required this.showDate,
    required this.showTime,
  });
  final DateTime initialDateTime;
  final Color dateBackgroundColor;
  final Color timeBackgroundColor;
  final Color headerColor;
  final Function(TimeManager selectedTime) onDateChanged;
  final bool includeSeconds;
  final bool showDate;
  final bool showTime;

  @override
  ObservingStatefulWidget<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends ObservingStatefulWidget<DateTimePicker> {
  PickerType currentPickerType = PickerType.date;

  late TimeManager timeManager;

  @override
  void initState() {
    super.initState();
    timeManager = TimeManager(dateTime: widget.initialDateTime.round(), showTime: widget.showTime);
  }

  @override
  Widget build(BuildContext context) {
    final dateColor = widget.dateBackgroundColor;
    final timeColor = widget.timeBackgroundColor;
    return Column(
      children: [
        _PickerHeader(
          timeManager: timeManager,
          headerColor: widget.headerColor,
          showDate: widget.showDate,
          showTime: widget.showTime,
          onSet: (DateTime? dateTime) {},
        ),
        DateTimeHeader(
          onPickerChanged: (pickerType) {
            setState(() {
              currentPickerType = pickerType;
            });
          },
          dateBackgroundColor: dateColor,
          timeBackgroundColor: timeColor,
          showDate: widget.showDate,
          showTime: widget.showTime,
        ),
        const Divider(
          color: Colors.deepPurple,
          height: 1,
          thickness: 1,
        ),
        _displayType(dateColor, timeColor),
      ],
    );
  }

  Widget _displayType(Color dateColor, Color timeColor) {
    Widget datePicker() => DatePicker(
          timeManager: timeManager,
          onDateChanged: (manager) {
            setState(() => timeManager = manager);
            widget.onDateChanged(manager);
          },
          dateBackgroundColor: dateColor,
        );
    Widget timePicker() => TimePicker(
          timeManager: timeManager,
          onTimeChanged: (manager) {
            setState(() => timeManager = manager);
            widget.onDateChanged(manager);
          },
          timeBackgroundColor: timeColor,
          includeSeconds: widget.includeSeconds,
        );

    if (widget.showDate && widget.showTime) {
      return AnimatedCrossFade(
        crossFadeState: currentPickerType == PickerType.date ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 500),
        firstChild: datePicker(),
        secondChild: timePicker(),
      );
    }

    return widget.showDate ? datePicker() : timePicker();
  }
}

Widget _buildSeperator(String text) {
  return ListWheelScrollView(
    itemExtent: _itemExtent,
    diameterRatio: _diameterRatio,
    magnification: _magnification,
    useMagnifier: true,
    physics: const FixedExtentScrollPhysics(),
    children: List.generate(
      1,
      (index) => Center(
        child: Text(text).fontSize(_fSize),
      ),
    ),
  );
}
