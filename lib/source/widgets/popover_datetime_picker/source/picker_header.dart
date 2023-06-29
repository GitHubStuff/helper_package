part of '../popover_datetime_picker.dart';

class _PickerHeader extends StatelessWidget {
  final TimeManager timeManager;
  final Color headerColor;
  final Function(DateTime? dateTimeResult) onSet;
  final bool showDate;
  final bool showTime;

  const _PickerHeader({
    required this.timeManager,
    required this.headerColor,
    required this.onSet,
    required this.showDate,
    required this.showTime,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = timeManager.dateTime;
    final dayOfWeek = DateFormat("EEE").format(dateTime);
    final dateLine = Text('${dateTime.shortDate()} $dayOfWeek');
    final timeLine = Text(dateTime.shortTime("h:mm:ss a"));
    return Container(
      color: headerColor,
      width: _pickerSize.width,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showTime) timeLine,
              if (showDate) dateLine,
            ],
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              onSet(timeManager.dateTime);
              Navigator.of(context).pop(timeManager.dateTime);
            },
            child: const Chip(label: Text('Set')),
          )
        ],
      ).paddingSymmetric(horizontal: 8.0),
    );
  }
}
