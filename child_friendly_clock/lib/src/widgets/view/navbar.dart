import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.watch_later, color: Colors.white, size: 35),
            title: Text(
              'Clock',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.alarm, color: Colors.white, size: 35),
            title: Text(
              'Alarm',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_bottom, color: Colors.white, size: 35),
            title: Text(
              'Timer',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.timer, color: Colors.white, size: 35),
            title: Text(
              'Stopwatch',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
      ],
    );
  }
}
