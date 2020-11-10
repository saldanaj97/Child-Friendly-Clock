import 'package:flutter/material.dart';
import './clock_body.dart';

/* Tutorial for clock found here https://medium.com/@NPKompleet/creating-an-analog-clock-in-flutter-i-68def107d9f4 */
class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClockBody(),
        ],
      ),
    );
  }
}
