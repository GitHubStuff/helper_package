import 'dart:async';

import 'package:flutter/material.dart';
import '../popover/source/popover.dart';
import '/source/extensions/widget_extensions.dart';
import '/source/extensions/date_time_extensions.dart';
import '/source/extensions/text_extensions.dart';
import 'source/time_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../palette/palette.dart';
import '../observing_stateful_widget.dart';

part 'source/date_picker.dart';
part 'source/date_time_header.dart';
part 'source/date_time_picker.dart';
part 'source/picker_header.dart';
part 'source/time_picker.dart';

enum PickerType {
  date,
  time,
  dateTime,
}

const _diameterRatio = 1.5;
const _fSize = 20.0;
const _hourCount = 12;
const _itemExtent = 28.0;
const _magnification = 1.2;
const _minuteSecondCount = 60;
const _monthsInYear = 12;
const _pickerSize = Size(200, 110);
const _yearSpan = 300;
const _widgetSize = Size(200, 187);

class PopoverDateTimePicker extends ConsumerWidget {
  final Widget child;
  final Function(DateTime dateTimeResult) onSet;
  final Function() onDismiss;
  final bool showDate;
  final bool showTime;
  final bool includeSeconds;
  final DateTime? dateTime;
  final Color? backgroundColor;
  final Color? dateBackgroundColor;
  final Color? timeBackgroundColor;

  const PopoverDateTimePicker({
    super.key,
    required this.child,
    required this.onSet,
    required this.onDismiss,
    this.showDate = true,
    this.showTime = true,
    this.includeSeconds = true,
    this.dateTime,
    this.backgroundColor,
    this.dateBackgroundColor,
    this.timeBackgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(paletteProvider);
    final bgColor = backgroundColor ??
        Palette.color(dark: Colors.deepPurple, light: Colors.blue);
    final dateColor = dateBackgroundColor ??
        Palette.color(
          dark: const Color.fromARGB(255, 58, 25, 116),
          light: Colors.blueAccent,
        );
    final timeColor = timeBackgroundColor ??
        Palette.color(dark: Colors.deepPurpleAccent, light: Colors.green);
    TimeManager timeManager =
        TimeManager(dateTime: dateTime ?? DateTime.now(), showTime: showTime);
    return GestureDetector(
      onTap: () async {
        final popoverResult = await showPopover(
          context: context,
          bodyBuilder: (context) {
            return DateTimePicker(
              initialDateTime: timeManager.dateTime,
              headerColor: bgColor,
              dateBackgroundColor: dateColor,
              timeBackgroundColor: timeColor,
              showDate: showDate,
              showTime: showTime,
              includeSeconds: includeSeconds,
              onDateChanged: (TimeManager selectedTime) {
                timeManager = TimeManager(
                    dateTime: selectedTime.dateTime, showTime: showTime);
              },
            );
          },
          //direction: PopoverDirection.left,
          width: _widgetSize.width,
          height: _widgetSize.height,
          arrowHeight: 15,
          arrowWidth: 30,
          backgroundColor: bgColor,
        );
        popoverResult != null ? onSet(timeManager.dateTime) : onDismiss();
      },
      child: child,
    );
  }
}
