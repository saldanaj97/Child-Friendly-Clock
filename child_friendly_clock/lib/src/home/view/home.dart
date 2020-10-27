import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:child_friendly_clock/src/home/controller/controller.dart';
import './../../widgets/view/navbar.dart';
import './clock/clock.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
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
      ),
      backgroundColor: const Color(0xff2d2e40),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              //margin: EdgeInsets.only(left: 20),
              // TODO: Make the 'Morning' message dyanmic to the time that it is
              child: greetingMessage(),
            ),
            Container(
              //margin: EdgeInsets.only(left: 20),
              child: todaysDate(),
            ),
            Container(
              child: currentTime(),
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

  // TODO: Make the 'Morning' message dyanmic to the time that it is
  Widget greetingMessage() {
    var timeOfDay = 'Morning';

    return Container(
      //margin: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Text('Good', style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: 'Open Sans')),
          Text(timeOfDay, style: TextStyle(color: Colors.red[400], fontSize: 45, fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget todaysDate() {
    /* var day;
    var date;
    var month; */

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('Today', style: TextStyle(color: Colors.red[400], fontSize: 40, fontWeight: FontWeight.bold)),
              Text(' is', style: TextStyle(color: Colors.white, fontSize: 40)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('January 1, 2020', style: TextStyle(color: Colors.white, fontSize: 37, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget currentTime() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('The', style: TextStyle(color: Colors.white, fontSize: 40)),
              Text(' time ', style: TextStyle(color: Colors.red[400], fontSize: 40, fontWeight: FontWeight.bold)),
              Text('is ', style: TextStyle(color: Colors.white, fontSize: 40)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('00', style: TextStyle(color: Colors.orange, fontSize: 37, fontWeight: FontWeight.w600)),
              Text(':', style: TextStyle(color: Colors.white, fontSize: 37, fontWeight: FontWeight.w600)),
              Text('00', style: TextStyle(color: Colors.cyan, fontSize: 37, fontWeight: FontWeight.w600)),
              Text('AM', style: TextStyle(color: Colors.white, fontSize: 37, fontWeight: FontWeight.w600))
            ],
          ),
        ],
      ),
    );
  }
}
