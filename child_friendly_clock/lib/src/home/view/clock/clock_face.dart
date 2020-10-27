import 'package:child_friendly_clock/src/home/view/clock/clock_hands.dart';
import 'package:flutter/material.dart';
import './clock_dial_painter.dart';

class ClockFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF434974),
          ),
          child: Stack(
            children: <Widget>[
              //dial and numbers go here
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(10),
                child: CustomPaint(
                  painter: ClockDialPainter(clockText: ClockText.arabic),
                ),
              ),
              //clock hands go here
              ClockHands(),
              //centerpoint
              Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
