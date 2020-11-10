import 'package:child_friendly_clock/src/widgets/view/menubar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './../../widgets/view/navbar.dart';
import './clock/clock.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  var now = new DateTime.now();
  Timer _everySecond;

  void handleClick(String value) {
    switch (value) {
      case 'Parental Controls':
        print("Parental Controls clicked");
        //Todo: add parental controls functionality
        break;
      case 'Reset App':
        print("reset app chosen");
        showAlertDialog(context);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    now = new DateTime.now();
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!mounted) return;
      setState(() {
        now = new DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clock',
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 40,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: const Color(0xff2d2e40),
        leading: PopupMenuButton<String>(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 45,
          ),
          onSelected: handleClick,
          itemBuilder: (BuildContext context) {
            return {"Parental Controls", "Reset App"}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ),
      backgroundColor: const Color(0xff2d2e40),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: greetingMessage(now.hour),
            ),
            Container(
              child: todaysDate(now.month, now.day, now.year),
            ),
            Container(
              child: currentTime(now.hour, now.minute),
            ),
            Container(
              child: Clock(),
            )
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }

// Function to deterimine if it is morning, afternoon, or night
  String timeOfDay(int hour) {
    String timeOfDay = '';

    if (hour >= 20 || hour < 4) {
      // 8pm - 4am
      timeOfDay = 'Night';
    } else if (hour >= 5 || hour < 11) {
      // 5am - 11am
      timeOfDay = 'Morning';
    } else if (hour >= 12 || hour <= 19) {
      // 12pm - 7pm
      timeOfDay = 'Afternoon';
    } else {
      timeOfDay = 'undefined';
    }
    return timeOfDay;
  }

  String numToMonth(int monthNum) {
    String month;
    if (monthNum == 1) {
      month = 'January ';
    } else if (monthNum == 2) {
      month = 'February ';
    } else if (monthNum == 3) {
      month = 'March ';
    } else if (monthNum == 4) {
      month = 'April ';
    } else if (monthNum == 5) {
      month = 'May ';
    } else if (monthNum == 6) {
      month = 'June ';
    } else if (monthNum == 7) {
      month = 'July ';
    } else if (monthNum == 8) {
      month = 'August ';
    } else if (monthNum == 9) {
      month = 'September ';
    } else if (monthNum == 10) {
      month = 'October ';
    } else if (monthNum == 11) {
      month = 'November ';
    } else {
      month = 'December ';
    }
    return month;
  }

  Widget greetingMessage(int hour) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Text('Good ', style: TextStyle(color: Colors.white, fontSize: 40, fontFamily: 'Open Sans')),
          Text(timeOfDay(hour), style: TextStyle(color: Colors.red[400], fontSize: 40, fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget todaysDate(int month, int day, int year) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('The ', style: TextStyle(color: Colors.white, fontSize: 35)),
              Text('date ', style: TextStyle(color: Colors.red[400], fontSize: 35, fontWeight: FontWeight.bold)),
              Text('is', style: TextStyle(color: Colors.white, fontSize: 35)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(numToMonth(month), style: TextStyle(color: Colors.white, fontSize: 37, fontWeight: FontWeight.w600)),
              Text(day.toString() + ', ', style: TextStyle(color: Colors.white, fontSize: 37, fontWeight: FontWeight.w600)),
              Text(year.toString(), style: TextStyle(color: Colors.white, fontSize: 37, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget currentTime(int hour, int minute) {
    var hourConversion = hour % 12;
    var minConversion = '0';
    var am_pm;

    if (hour >= 0 && hour < 12) {
      am_pm = 'AM';
    } else {
      am_pm = 'PM';
    }

    if (hourConversion == 0) {
      hourConversion = 12;
    }

    if (minute < 10) {
      minConversion = '0' + minute.toString();
    } else {
      minConversion = minute.toString();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text('The', style: TextStyle(color: Colors.white, fontSize: 35)),
              Text(' time ', style: TextStyle(color: Colors.red[400], fontSize: 35, fontWeight: FontWeight.bold)),
              Text('is ', style: TextStyle(color: Colors.white, fontSize: 35)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(hourConversion.toString(), style: TextStyle(color: Colors.orange, fontSize: 37, fontWeight: FontWeight.w600)),
              Text(':', style: TextStyle(color: Colors.white, fontSize: 37, fontWeight: FontWeight.w600)),
              Text(minConversion, style: TextStyle(color: Colors.cyan, fontSize: 37, fontWeight: FontWeight.w600)),
              Text(am_pm, style: TextStyle(color: Colors.white, fontSize: 37, fontWeight: FontWeight.w600))
            ],
          ),
        ],
      ),
    );
  }
}
