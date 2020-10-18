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
        BottomNavigationBarItem(icon: Icon(Icons.timer, color: Colors.white), title: Text('Clock', style: TextStyle(color: Colors.white))),
        BottomNavigationBarItem(icon: Icon(Icons.watch, color: Colors.white), title: Text('Alarm', style: TextStyle(color: Colors.white))),
        BottomNavigationBarItem(icon: Icon(Icons.watch, color: Colors.white), title: Text('Timer', style: TextStyle(color: Colors.white))),
        BottomNavigationBarItem(icon: Icon(Icons.watch, color: Colors.white), title: Text('Stopwatch', style: TextStyle(color: Colors.white))),
      ],
    );
  }
}
