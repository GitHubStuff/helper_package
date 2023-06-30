import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:helper_package/helper_package.dart';

part 'clock_painter.dart';

/// ClockFace
/// Displays a clock face with hour, minute, and optional second hands.
/// The clock face can be configured to display the time in any time zone (default is local).
/// * [backgroundColor] - the color of the background
/// * [dimension] - the height and width of the clock face
/// * [faceColor] - the color of the clock face
/// * [faceNumberOffset] - the offset of the numbers from the edge of the clock face
/// * [hourColor] - the color of the hour hand
/// * [minuteColor] - the color of the minute hand
/// * [numberStyle] - the style of the numbers on the clock face
/// * [secondColor] - the color of the second hand (null to not display)
/// * [tickColor] - the color of the tick marks
/// * [tickStroke] - the width of the tick marks
/// * [utcMinuteOffset] - the number of minutes offset from UTC (e.g. -7 hours is -7 * 60)
/// * [borderColor] - the color of the border
///
class ClockFace extends StatelessWidget {
  final Color backgroundColor;
  final Color faceColor;
  final Color hourColor;
  final Color minuteColor;
  final Color tickColor;
  final Color borderColor;
  final Color? secondColor;
  final double dimension;
  final double tickStroke;
  final double? faceNumberOffset;
  final int? utcMinuteOffset;
  final TextStyle? numberStyle;

  const ClockFace({
    super.key,
    this.utcMinuteOffset,
    this.dimension = 100.0,
    this.faceColor = Colors.white,
    this.tickColor = Colors.black,
    this.hourColor = Colors.black,
    this.minuteColor = Colors.black,
    this.borderColor = Colors.black,
    this.secondColor,
    this.numberStyle = const TextStyle(color: Colors.black, fontSize: 12.0),
    this.backgroundColor = Colors.transparent,
    this.faceNumberOffset = 12.0,
    this.tickStroke = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    assert(tickStroke >= 1.0);
    final utcOffset =
        utcMinuteOffset ?? DateTime.now().timeZoneOffset.inMinutes;
    final initalDateTime =
        DateTime.now().toUtc().add(Duration(hours: utcOffset));
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1), (_) {
        return DateTime.now().toUtc().add(Duration(minutes: utcOffset));
      }),
      initialData: DateTime.now().toUtc().add(Duration(minutes: utcOffset)),
      builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
        return Container(
          height: dimension,
          width: dimension,
          color: backgroundColor,
          child: CustomPaint(
            painter: _ClockPainter(
              dateTime: snapshot.data ?? initalDateTime,
              faceColor: faceColor,
              tickColor: tickColor,
              hourColor: hourColor,
              minuteColor: minuteColor,
              secondColor: secondColor,
              numberStyle: numberStyle,
              borderColor: borderColor,
              faceNumberOffset: faceNumberOffset,
              tickStroke: tickStroke,
            ),
          ).paddingAll(4.0),
        );
      },
    );
  }
}

