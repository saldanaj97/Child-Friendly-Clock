import 'package:flutter/material.dart';
import './clock_body.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClockBody(),
        ],
      ),
    );
  }
}
