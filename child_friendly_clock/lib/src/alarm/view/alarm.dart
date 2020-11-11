//import 'dart:js';

import 'package:child_friendly_clock/src/widgets/view/menubar.dart';
import 'package:child_friendly_clock/src/widgets/view/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './alarm_cards.dart';
import './CreateAlarm.dart';
import 'package:child_friendly_clock/src/alarm/utils/database.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';

class alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<alarm> {
  Future alarmsFuture;

  @override
  void initState() {
    super.initState();
    alarmsFuture = getAlarms();
  }

  getAlarms() async {
    final alarmsData = await DBProvider.db.getAlarms();
    return alarmsData;
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
        setState(() {
          alarmsFuture = getAlarms();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2d2e40),
      appBar: AppBar(
        backgroundColor: const Color(0xff2d2e40),
        centerTitle: false,
        elevation: 0,
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 45,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateAlarm(
                    clickCallback: () => setState(
                      () {
                        alarmsFuture = getAlarms();
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          FutureBuilder(
            future: alarmsFuture,
            builder: (_, alarmsData) {
              if (alarmsData.hasData) {
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      Map<String, dynamic> read = alarmsData.data[index];
                      Alarm rowAlarm = Alarm.fromJson(read);
                      return AlarmCards(
                        alarm: rowAlarm,
                        updateListCallback: () => setState(() {
                          alarmsFuture = getAlarms();
                        }),
                      ); // One individual Alarm
                    },
                    childCount: alarmsData.data.length,
                  ),
                );
              } else {
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text('No Alarms Set', style: TextStyle(color: Colors.white, fontSize: 30)),
                      );
                    },
                    childCount: 1,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 2.25),
                );
              }
            },
          )
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
