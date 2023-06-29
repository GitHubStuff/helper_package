import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockFace extends StatelessWidget {
  final int utcOffset;
  final Color faceColor;
  final Color tickColor;
  final Color hourColor;
  final Color minuteColor;
  final Color? secondColor;
  final TextStyle? numberStyle;
  final Color backgroundColor;
  final double? faceNumberOffset;
  final double tickStroke;

  const ClockFace({
    super.key,
    this.utcOffset = -4,
    this.faceColor = Colors.white,
    this.tickColor = Colors.black,
    this.hourColor = Colors.black,
    this.minuteColor = Colors.black,
    this.secondColor,
    this.numberStyle = const TextStyle(color: Colors.black, fontSize: 16.0),
    this.backgroundColor = Colors.transparent,
    this.faceNumberOffset = 15.0,
    this.tickStroke = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    assert(tickStroke >= 1.0);

    final initalDateTime =
        DateTime.now().toUtc().add(Duration(hours: utcOffset));
    return StreamBuilder(
      stream: Stream.periodic(
          secondColor == null
              ? const Duration(minutes: 1)
              : const Duration(seconds: 1), (_) {
        return DateTime.now().toUtc().add(Duration(hours: utcOffset));
      }),
      initialData: DateTime.now().toUtc().add(Duration(hours: utcOffset)),
      builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
        return Container(
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
              faceNumberOffset: faceNumberOffset,
              tickStroke: tickStroke,
            ),
          ),
        );
      },
    );
  }
}

class _ClockPainter extends CustomPainter {
  final DateTime dateTime;
  final Color faceColor;
  final Color tickColor;
  final Color hourColor;
  final Color minuteColor;
  final Color? secondColor;
  final TextStyle? numberStyle;
  final double? faceNumberOffset;
  final double tickStroke;

  _ClockPainter({
    required this.dateTime,
    required this.faceColor,
    required this.tickColor,
    required this.hourColor,
    required this.minuteColor,
    required this.secondColor,
    required this.numberStyle,
    required this.faceNumberOffset,
    required this.tickStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final strokeWidth = radius / 20;
    final shortTickLength = radius / 20;
    final longTickLength = radius / 10;

    // Draw the clock face
    canvas.drawCircle(center, radius, Paint()..color = faceColor);

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw the hour and minute ticks
    for (var i = 0; i < 60; i++) {
      final tickLength = i % 5 == 0 ? longTickLength : shortTickLength;
      final tickPosition = Offset(
        center.dx + (radius - tickLength) * cos(i * pi / 30),
        center.dy + (radius - tickLength) * sin(i * pi / 30),
      );
      final tickEndPosition = Offset(
        center.dx + radius * cos(i * pi / 30),
        center.dy + radius * sin(i * pi / 30),
      );

      canvas.drawLine(
        tickPosition,
        tickEndPosition,
        Paint()
          ..color = tickColor
          ..strokeWidth = tickStroke,
      );

      // Draw the hour numbers
      if (numberStyle != null && i % 5 == 0) {
        final numberRadius = radius - (faceNumberOffset ?? 0);
        final numberPosition = Offset(
          center.dx + numberRadius * cos((i - 15) * pi / 30),
          center.dy + numberRadius * sin((i - 15) * pi / 30),
        );

        textPainter.text = TextSpan(
          text: '${i ~/ 5 == 0 ? 12 : i ~/ 5}',
          style: numberStyle,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          numberPosition -
              Offset(textPainter.width / 2, textPainter.height / 2),
        );
      }
    }

    // Draw the hour hand
    final hourHandAngle = dateTime.hour * pi / 6 + dateTime.minute * pi / 360;
    final hourHandLength = radius / 2;
    final hourHandPosition = Offset(
      center.dx + hourHandLength * cos(hourHandAngle - pi / 2),
      center.dy + hourHandLength * sin(hourHandAngle - pi / 2),
    );

    canvas.drawLine(
      center,
      hourHandPosition,
      Paint()
        ..color = hourColor
        ..strokeWidth = strokeWidth,
    );

    // Draw the minute hand
    final minuteHandAngle = dateTime.minute * pi / 30;
    final minuteHandLength = radius * 3 / 4;
    final minuteHandPosition = Offset(
      center.dx + minuteHandLength * cos(minuteHandAngle - pi / 2),
      center.dy + minuteHandLength * sin(minuteHandAngle - pi / 2),
    );

    canvas.drawLine(
      center,
      minuteHandPosition,
      Paint()
        ..color = minuteColor
        ..strokeWidth = strokeWidth / 2,
    );

    // Draw the minute hand
    if (secondColor == null) {
      return;
    }
    final secondHandAngle = dateTime.second * pi / 30;
    final secondHandLength = radius * 4 / 5;
    final secondHandPosition = Offset(
      center.dx + secondHandLength * cos(secondHandAngle - pi / 2),
      center.dy + secondHandLength * sin(secondHandAngle - pi / 2),
    );

    canvas.drawLine(
      center,
      secondHandPosition,
      Paint()
        ..color = secondColor!
        ..strokeWidth = strokeWidth / 3,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
