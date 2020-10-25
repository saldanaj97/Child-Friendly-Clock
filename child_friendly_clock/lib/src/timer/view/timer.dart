import 'package:flutter/material.dart';
import '../../widgets/view/navbar.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
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
      ),
      backgroundColor: const Color(0xff2d2e40),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TIMER NUMBERS
            Text('00:00:00', style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // PLAY PAUSE BUTTONS
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: new Icon(
                      Icons.stop,
                      color: Color(0xff2d2e40),
                      size: 75,
                    ),
                    onPressed: () {
                      print('Pause Pressed');
                    },
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: new Icon(
                      Icons.play_arrow,
                      color: Color(0xff2d2e40),
                      size: 75,
                    ),
                    onPressed: () {
                      print('Play Pressed');
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
                          child: Text(
                            '1 Min',
                            style: TextStyle(color: Colors.white, fontSize: 43),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            print('1 min pressed');
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(bottom: 35),
                        child: RawMaterialButton(
                          child: Text(
                            '5 Min',
                            style: TextStyle(color: Colors.white, fontSize: 43),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.pink,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            print('5 min pressed');
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
                          child: Text(
                            '10 Min',
                            style: TextStyle(color: Colors.white, fontSize: 43),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            print('10 min pressed');
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: RawMaterialButton(
                          child: Text(
                            '30 Min',
                            style: TextStyle(color: Colors.white, fontSize: 43),
                            textAlign: TextAlign.center,
                          ),
                          fillColor: Colors.amber[400],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          onPressed: () {
                            print('30 min pressed');
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
}
