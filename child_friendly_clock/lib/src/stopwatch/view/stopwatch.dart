import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/widgets/view/navbar.dart';
import 'package:child_friendly_clock/src/stopwatch/controller/controller.dart';

class Stopwatch extends StatefulWidget {
  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  var hoursStr = '00';
  var minutesStr = '00';
  var secondsStr = '00';
  var timerStream;
  var timerSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stopwatch',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$hoursStr:$minutesStr:$secondsStr',
            style: TextStyle(fontSize: 80, color: Colors.white),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                onPressed: () {
                  timerStream = stopWatchStream();
                  timerSubscription = timerStream.listen((int newTick) {
                    setState(() {
                      hoursStr = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
                      minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
                      secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
                    });
                  });
                },
                color: Colors.green,
                child: Text(
                  'Start',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              SizedBox(width: 40),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                onPressed: () {
                  timerSubscription.cancel();
                  timerStream = null;
                  setState(() {
                    hoursStr = '00';
                    minutesStr = '00';
                    secondsStr = '00';
                  });
                },
                color: Colors.red,
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
