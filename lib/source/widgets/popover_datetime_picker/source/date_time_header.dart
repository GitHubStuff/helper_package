part of '../popover_datetime_picker.dart';

class DateTimeHeader extends StatelessWidget {
  const DateTimeHeader({
    super.key,
    required this.onPickerChanged,
    required this.dateBackgroundColor,
    required this.timeBackgroundColor,
    required this.showDate,
    required this.showTime,
  });
  final Color dateBackgroundColor;
  final Color timeBackgroundColor;
  final Function(PickerType pickerType) onPickerChanged;
  final bool showDate;
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    assert(showDate || showTime, 'At least one of showDate or showTime must be true');
    return SizedBox(
      width: _pickerSize.width,
      child: Row(
        children: [
          if (showDate)
            Expanded(
              child: InkWell(
                onTap: () => onPickerChanged(PickerType.date),
                child: Container(
                  height: _itemExtent,
                  color: dateBackgroundColor,
                  child: const Center(
                    child: Text(
                      'Date',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          if (showTime)
            Expanded(
              child: InkWell(
                onTap: () {
                  onPickerChanged(PickerType.time);
                },
                child: Container(
                  height: _itemExtent,
                  color: timeBackgroundColor,
                  child: const Center(
                    child: Text(
                      'Time',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
