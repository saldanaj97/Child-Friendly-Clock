import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../home/view/home.dart';
import '../../alarm/view/alarm.dart';
import '../../stopwatch/view/stopwatch.dart';
import '../../timer/view/timer.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff2d2e40),
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: IconButton(
                icon: Icon(Icons.watch_later, color: Colors.white, size: 35),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                }),
            title: Text(
              'Clock',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
        BottomNavigationBarItem(
          icon: IconButton(
              icon: Icon(Icons.alarm, color: Colors.white, size: 35),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => alarm()));
              }),
          title: Text(
            'Alarm',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              icon: Icon(Icons.hourglass_bottom, color: Colors.white, size: 35),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Timer()));
              }),
          title: Text(
            'Timer',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              icon: Icon(Icons.timer, color: Colors.white, size: 35),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => StopwatchPage()));
              }),
          title: Text(
            'Stopwatch',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
