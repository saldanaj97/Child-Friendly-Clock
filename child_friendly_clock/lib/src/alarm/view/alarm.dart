import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './alarm_cards.dart';

class Alarm extends StatefulWidget {
  Alarm({
    Key key,
  }) : super(key: key);

  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2d2e40),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            backgroundColor: const Color(0xff2d2e40),
            centerTitle: false,
            title: Text(
              'Alarms',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 40,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 45,
                ),
                onPressed: null,
              ),
            ],
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.25,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return AlarmCards();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff2d2e40),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.timer, color: Colors.white), title: Text('Clock', style: TextStyle(color: Colors.white))),
          BottomNavigationBarItem(icon: Icon(Icons.watch, color: Colors.white), title: Text('Alarm', style: TextStyle(color: Colors.white))),
          BottomNavigationBarItem(icon: Icon(Icons.watch, color: Colors.white), title: Text('Timer', style: TextStyle(color: Colors.white))),
          BottomNavigationBarItem(icon: Icon(Icons.watch, color: Colors.white), title: Text('Stopwatch', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

/* Extra images and backgrounds for the alarm screen */
const String plus_button =
    '<svg viewBox="323.0 35.0 30.1 30.1" ><path transform="translate(314.04, 26.04)" d="M 37.23765182495117 22.1627311706543 L 25.91679763793945 22.1627311706543 L 25.91679763793945 10.84187602996826 C 25.91679763793945 9.80950927734375 25.0721321105957 8.96484375 24.03976440429688 8.96484375 C 23.00739669799805 8.96484375 22.1627311706543 9.80950927734375 22.1627311706543 10.84187602996826 L 22.1627311706543 22.1627311706543 L 10.84187602996826 22.1627311706543 C 9.80950927734375 22.1627311706543 8.96484375 23.00739669799805 8.96484375 24.03976440429688 C 8.96484375 24.55595016479492 9.176009178161621 25.02520751953125 9.516222953796387 25.36541748046875 C 9.85643482208252 25.70563125610352 10.32569217681885 25.91679763793945 10.84187602996826 25.91679763793945 L 22.1627311706543 25.91679763793945 L 22.1627311706543 37.23765182495117 C 22.1627311706543 37.75383758544922 22.37389755249023 38.22309494018555 22.714111328125 38.56330490112305 C 23.05432510375977 38.90351867675781 23.52358245849609 39.11468505859375 24.03976440429688 39.11468505859375 C 25.0721321105957 39.11468505859375 25.91679763793945 38.27001953125 25.91679763793945 37.23765182495117 L 25.91679763793945 25.91679763793945 L 37.23765182495117 25.91679763793945 C 38.27001953125 25.91679763793945 39.11468505859375 25.0721321105957 39.11468505859375 24.03976440429688 C 39.11468505859375 23.00739669799805 38.27001953125 22.1627311706543 37.23765182495117 22.1627311706543 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
