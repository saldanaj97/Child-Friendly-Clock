import 'dart:math';
import 'package:flutter/material.dart';

class HourHandPainter extends CustomPainter {
  final Paint hourHandPaint;
  int hours;
  int minutes;

  HourHandPainter({this.hours, this.minutes}) : hourHandPaint = new Paint() {
    hourHandPaint.color = Colors.orange;
    hourHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    // To draw hour hand
    canvas.save();

    canvas.translate(radius, radius);

    //checks if hour is greater than 12 before calculating rotation
    canvas.rotate(this.hours >= 12 ? 2 * pi * ((this.hours - 12) / 12 + (this.minutes / 720)) : 2 * pi * ((this.hours / 12) + (this.minutes / 720)));
    // hour_hand
    double hour_hand_xs = size.width / 300;
    double hour_hand_ys = size.height / 150;

    Path hourHand = Path()
      ..moveTo(6.56 * hour_hand_xs, 0 * hour_hand_ys)
      ..cubicTo(10.18 * hour_hand_xs, 0 * hour_hand_ys, 13.11 * hour_hand_xs, 2.94 * hour_hand_ys, 13.11 * hour_hand_xs, 6.56 * hour_hand_ys)
      ..cubicTo(13.11 * hour_hand_xs, 45.95 * hour_hand_ys, 10.18 * hour_hand_xs, 48.88 * hour_hand_ys, 6.56 * hour_hand_xs, 48.88 * hour_hand_ys)
      ..cubicTo(2.94 * hour_hand_xs, 48.88 * hour_hand_ys, 0 * hour_hand_xs, 45.95 * hour_hand_ys, 0 * hour_hand_xs, 42.33 * hour_hand_ys)
      ..lineTo(0 * hour_hand_xs, 6.56 * hour_hand_ys)
      ..cubicTo(0 * hour_hand_xs, 2.94 * hour_hand_ys, 2.94 * hour_hand_xs, 0 * hour_hand_ys, 6.56 * hour_hand_xs, 0 * hour_hand_ys)
      ..close();

    hourHand = hourHand.shift(Offset(hour_hand_xs * -5, hour_hand_ys * -47));

    canvas.drawPath(hourHand, hourHandPaint);
    canvas.drawShadow(hourHand, Colors.black, 4.0, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(HourHandPainter oldDelegate) {
    return true;
  }
}
