import 'dart:async';
import 'package:child_friendly_clock/src/widgets/view/menubar.dart';
import 'package:flutter/material.dart';
import '../../widgets/view/navbar.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _counter = 0;
  Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timer',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TIMER NUMBERS
            Text(timeToString(_counter), style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // PLAY PAUSE BUTTONS
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: FloatingActionButton(
                    heroTag: 'PauseButton',
                    elevation: 15,
                    backgroundColor: Colors.red,
                    child: new Icon(
                      Icons.stop,
                      color: Color(0xff2d2e40),
                      size: 75,
                    ),
                    onPressed: () {
                      print('Pause Pressed');
                      _timer.cancel();
                    },
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: FloatingActionButton(
                    heroTag: 'StartButton',
                    elevation: 15,
                    backgroundColor: Colors.green,
                    child: new Icon(
                      Icons.play_arrow,
                      color: Color(0xff2d2e40),
                      size: 75,
                    ),
                    onPressed: () {
                      print('Start Pressed');
                      _startTimer();
                    },
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text('Pre-Made Timers', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600)),
            ),
            // PRESET TIMER BUTTONS
            Container(
              child: Column(
                //mainAxisAlignment: ,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(bottom: 35),
                        child: RawMaterialButton(
                          elevation: 15,
                          child: Text(
                            '1 Min',
                            style: TextStyle(color: Colors.white, fontSize: 43),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            setState(() {
                              _counter = 60;
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(bottom: 35),
                        child: RawMaterialButton(
                          elevation: 15,
                          child: Text(
                            '5 Min',
                            style: TextStyle(color: Colors.white, fontSize: 43),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.pink,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            setState(() {
                              _counter = 300;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: RawMaterialButton(
                          elevation: 15,
                          child: Text(
                            '10 Min',
                            style: TextStyle(color: Colors.white, fontSize: 43),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            setState(() {
                              _counter = 600;
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: RawMaterialButton(
                          elevation: 15,
                          child: Text(
                            '30 Min',
                            style: TextStyle(color: Colors.white, fontSize: 43),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.amber[400],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            setState(() {
                              _counter = 1800;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }

  String timeToString(timerAmount) {
    String formattedTime = '';
    int min = 0;
    int sec = 0;

    // Min
    timerAmount %= (24 * 3600);
    if (timerAmount >= 60) {
      min = (timerAmount / 60).toInt();
    }

    // Sec
    timerAmount %= 3600;
    if (timerAmount % 60 > 0) {
      sec = timerAmount % 60;
    }

    // String formatting
    if (min + sec == 0) {
      formattedTime = '00 : 00';
    } else if (min > 0 && min <= 9) {
      formattedTime = '0' + min.toString();
    } else if (min >= 10) {
      formattedTime = min.toString();
    }
    formattedTime += ' : ';
    if (sec >= 0 && sec <= 9) {
      formattedTime += '0' + sec.toString();
    } else if (sec > 10) {
      formattedTime += sec.toString();
    }
    return formattedTime;
  }
}
