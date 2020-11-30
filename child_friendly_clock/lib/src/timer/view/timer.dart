import 'dart:async';
import 'package:numberpicker/numberpicker.dart';
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
  int hours = 0;
  int mins = 0;
  int seconds = 0;
  int secondsPassed = 60;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
          updateMin();
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

  Future _showMinDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 60,
          title: new Text("Hours:"),
          initialIntegerValue: 0,
        );
      },
    ).then((value) => {
          if (value != null) setState(() => mins = value),
        });
  }

  Future _showHourDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 24,
          title: new Text("Hours:"),
          initialIntegerValue: 0,
        );
      },
    ).then((value) => {
          if (value != null) setState(() => hours = value),
        });
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TIMER NUMBERS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: FloatingActionButton(
                    heroTag: 'hourDial',
                    elevation: 0,
                    child: Text('00', style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                    onPressed: _showHourDialog,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(':', style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                Container(
                  width: 100,
                  height: 100,
                  child: FloatingActionButton(
                    heroTag: 'minDial',
                    elevation: 0,
                    child: Text(formattedMinutes(), style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                    onPressed: _showMinDialog,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(':', style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(formattedSeconds(), style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // PLAY PAUSE BUTTONS
              children: [
                Container(
                  width: 125,
                  height: 125,
                  child: FloatingActionButton(
                    heroTag: 'PauseButton',
                    elevation: 15,
                    backgroundColor: Colors.red,
                    child: Text('Reset', style: TextStyle(fontSize: 30)),
                    onPressed: () {
                      print('Pause Pressed');
                      _timer.cancel();
                      setState(() {
                        _counter = 0;
                        mins = 0;
                        hours = 0;
                      });
                    },
                  ),
                ),
                Container(
                  width: 125,
                  height: 125,
                  child: FloatingActionButton(
                    heroTag: 'StartButton',
                    elevation: 15,
                    backgroundColor: Colors.green,
                    child: Text('Start', style: TextStyle(fontSize: 30)),
                    onPressed: () {
                      print('Start Pressed');
                      _counter += hours * 3600;
                      _counter += mins * 60;
                      secondsPassed = 59;
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
                        height: MediaQuery.of(context).size.height / 5.75,
                        width: MediaQuery.of(context).size.height / 5.75,
                        margin: EdgeInsets.only(bottom: 20),
                        child: RawMaterialButton(
                          elevation: 15,
                          child: Text(
                            '1 Min',
                            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.aspectRatio * 90),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            setState(() {
                              mins = 1;
                            });
                          },
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 5.75,
                        width: MediaQuery.of(context).size.height / 5.75,
                        margin: EdgeInsets.only(bottom: 20),
                        child: RawMaterialButton(
                          elevation: 15,
                          child: Text(
                            '5 Min',
                            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.aspectRatio * 90),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.pink,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            setState(() {
                              mins = 5;
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
                        height: MediaQuery.of(context).size.height / 5.75,
                        width: MediaQuery.of(context).size.height / 5.75,
                        child: RawMaterialButton(
                          elevation: 15,
                          child: Text(
                            '10 Min',
                            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.aspectRatio * 90),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            setState(() {
                              mins = 10;
                            });
                          },
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 5.75,
                        width: MediaQuery.of(context).size.height / 5.75,
                        child: RawMaterialButton(
                          elevation: 15,
                          child: Text(
                            '30 Min',
                            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.aspectRatio * 90),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.amber[400],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            setState(() {
                              mins = 30;
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

  String formattedMinutes() {
    String formattedTime = '';

    if (mins >= 0 && mins <= 9) {
      formattedTime = '0' + mins.toString();
    } else if (mins >= 10) {
      formattedTime = mins.toString();
    }
    return formattedTime;
  }

  String formattedSeconds() {
    String formattedTime = '';
    int sec = 0;

    if (_counter % 60 > 0) {
      sec = _counter % 60;
    }

    if (sec >= 0 && sec <= 9) {
      formattedTime += '0' + sec.toString();
    } else if (sec > 9) {
      formattedTime += sec.toString();
    }
    return formattedTime;
  }

  void updateMin() {
    if (secondsPassed == 59) {
      mins--;
      secondsPassed = 0;
    } else {
      secondsPassed++;
    }
  }
}
