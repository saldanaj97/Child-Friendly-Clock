import 'package:flutter/material.dart';
import './clock_face.dart';

class ClockBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClockFace(),
          ),
        ],
      ),
    );
  }
}
