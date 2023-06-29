part of '../popover_datetime_picker.dart';

class TimePicker extends StatefulWidget {
  final TimeManager timeManager;
  final Function(TimeManager timeManager) onTimeChanged;
  final Color timeBackgroundColor;
  final bool includeSeconds;

  const TimePicker({
    super.key,
    required this.timeManager,
    required this.onTimeChanged,
    required this.timeBackgroundColor,
    required this.includeSeconds,
  });

  @override
  ObservingStatefulWidget<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends ObservingStatefulWidget<TimePicker> {
  final hourController = FixedExtentScrollController();
  final minuteController = FixedExtentScrollController();
  final secondController = FixedExtentScrollController();
  final medianController = FixedExtentScrollController();

  @override
  // ignore: unnecessary_overrides
  void initState() {
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    hourController.jumpTo(((widget.timeManager.hour + _hourCount) - 1) * _itemExtent);
    minuteController.jumpTo(((widget.timeManager.minute + _minuteSecondCount) - 1) * _itemExtent);
    if (widget.includeSeconds) secondController.jumpTo(((widget.timeManager.second + _minuteSecondCount) - 1) * _itemExtent);
    medianController.jumpTo((widget.timeManager.isAm() ? 0 : 1) * _itemExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _pickerSize.width,
      height: _pickerSize.height,
      color: widget.timeBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 30, child: _buildHourPicker()),
          SizedBox(width: 5, child: _buildSeperator(':')),
          SizedBox(width: 30, child: _buildMinutePicker()),
          if (widget.includeSeconds) ...{
            SizedBox(width: 5, child: _buildSeperator(':')),
            SizedBox(width: 30, child: _buildSecondPicker()),
          },
          SizedBox(width: 36, child: _buildPeriodPicker()),
        ],
      ),
    );
  }

  // Define the hour picker widget
  Widget _buildHourPicker() {
    return ListWheelScrollView(
      controller: hourController,
      itemExtent: _itemExtent,
      diameterRatio: 1.5,
      magnification: _magnification,
      useMagnifier: true,
      physics: const FixedExtentScrollPhysics(),
      children: List.generate(
        _hourCount * 3,
        (index) => Center(
          child: Text('${(index % _hourCount) + 1}').fontSize(_fSize),
        ),
      ),
      onSelectedItemChanged: (index) {
        setState(() {
          widget.timeManager.hour = (index % _hourCount) + 1;
        });
        widget.onTimeChanged(widget.timeManager);
      },
    );
  }

  // Define the minute picker widget
  Widget _buildMinutePicker() {
    return ListWheelScrollView(
      controller: minuteController,
      itemExtent: _itemExtent,
      diameterRatio: 1.5,
      magnification: _magnification,
      useMagnifier: true,
      physics: const FixedExtentScrollPhysics(),
      children: List.generate(
        _minuteSecondCount * 3,
        (index) => Center(
          child: Text('${(index % _minuteSecondCount) < 10 ? '0${index % _minuteSecondCount}' : index % _minuteSecondCount}').fontSize(_fSize),
        ),
      ),
      onSelectedItemChanged: (index) {
        setState(() {
          widget.timeManager.minute = (index % _minuteSecondCount);
        });
        widget.onTimeChanged(widget.timeManager);
      },
    );
  }

  // Define the second picker widget
  Widget _buildSecondPicker() {
    return ListWheelScrollView(
      controller: secondController,
      itemExtent: _itemExtent,
      diameterRatio: 1.5,
      magnification: _magnification,
      useMagnifier: true,
      physics: const FixedExtentScrollPhysics(),
      children: List.generate(
        _minuteSecondCount * 3,
        (index) => Center(
          child: Text(
            '${(index % _minuteSecondCount) < 10 ? '0${index % _minuteSecondCount}' : index % _minuteSecondCount}',
          ).fontSize(_fSize),
        ),
      ),
      onSelectedItemChanged: (index) {
        setState(() {
          widget.timeManager.second = (index % _minuteSecondCount);
        });
        widget.onTimeChanged(widget.timeManager);
      },
    );
  }

  // Define the period picker widget
  Widget _buildPeriodPicker() {
    return ListWheelScrollView(
      controller: medianController,
      itemExtent: _itemExtent,
      diameterRatio: 1.5,
      magnification: _magnification,
      useMagnifier: true,
      physics: const FixedExtentScrollPhysics(),
      children: [
        Center(
          child: const Text('AM').fontSize(_fSize),
        ),
        Center(
          child: const Text('PM').fontSize(_fSize),
        ),
      ],
      onSelectedItemChanged: (index) {
        setState(() {
          widget.timeManager.period = index == 0 ? DayPeriod.am : DayPeriod.pm;
        });

        widget.onTimeChanged(widget.timeManager);
      },
    );
  }
}
