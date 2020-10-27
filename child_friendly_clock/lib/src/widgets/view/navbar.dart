import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../home/view/home.dart';
import '../../alarm/view/alarm.dart';
import '../../stopwatch/view/stopwatch.dart';
import '../../timer/view/timer.dart';

class Navbar extends StatelessWidget {
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
                  Navigator.push(context, SizeRoute(page: Home()));
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
                Navigator.push(context, SizeRoute(page: alarm()));
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
                Navigator.push(context, SizeRoute(page: Timer()));
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
                Navigator.push(context, SizeRoute(page: StopwatchPage()));
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

class SizeRoute extends PageRouteBuilder {
  final Widget page;
  SizeRoute({this.page})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => Align(
            child: SizeTransition(sizeFactor: animation, child: child),
          ),
        );
}
