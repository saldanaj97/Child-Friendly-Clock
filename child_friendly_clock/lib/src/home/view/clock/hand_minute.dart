import 'dart:math';

import 'package:flutter/material.dart';

class MinuteHandPainter extends CustomPainter {
  final Paint minuteHandPaint;
  int minutes;
  int seconds;

  MinuteHandPainter({this.minutes, this.seconds}) : minuteHandPaint = new Paint() {
    minuteHandPaint.color = Colors.cyan;
    minuteHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * ((this.minutes + (this.seconds / 60)) / 60));

    // hour_hand
    double hour_hand_xs = size.width / 300;
    double hour_hand_ys = size.height / 100;

    Path minuteHand = Path()
      ..moveTo(6.56 * hour_hand_xs, 0 * hour_hand_ys)
      ..cubicTo(10.18 * hour_hand_xs, 0 * hour_hand_ys, 13.11 * hour_hand_xs, 2.94 * hour_hand_ys, 13.11 * hour_hand_xs, 6.56 * hour_hand_ys)
      ..cubicTo(13.11 * hour_hand_xs, 45.95 * hour_hand_ys, 10.18 * hour_hand_xs, 48.88 * hour_hand_ys, 6.56 * hour_hand_xs, 48.88 * hour_hand_ys)
      ..cubicTo(2.94 * hour_hand_xs, 48.88 * hour_hand_ys, 0 * hour_hand_xs, 45.95 * hour_hand_ys, 0 * hour_hand_xs, 42.33 * hour_hand_ys)
      ..lineTo(0 * hour_hand_xs, 6.56 * hour_hand_ys)
      ..cubicTo(0 * hour_hand_xs, 2.94 * hour_hand_ys, 2.94 * hour_hand_xs, 0 * hour_hand_ys, 6.56 * hour_hand_xs, 0 * hour_hand_ys)
      ..close();

    minuteHand = minuteHand.shift(Offset(hour_hand_xs * -5, hour_hand_ys * -47));

    canvas.drawPath(minuteHand, minuteHandPaint);
    canvas.drawShadow(minuteHand, Colors.black, 4.0, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
