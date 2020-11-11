import 'dart:ui';

import 'package:child_friendly_clock/src/alarm/utils/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:child_friendly_clock/src/alarm/view/save_button.dart';
import 'package:child_friendly_clock/src/alarm/view/frequency_button.dart';




class EditAlarm extends StatefulWidget {
  final Alarm editAlarm;
  final VoidCallback clickCallback;
  EditAlarm({this.clickCallback, this.editAlarm});

  @override
  _EditAlarmState createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm>{
  TextEditingController _alarmNameController = new TextEditingController();
  bool canSave = true;
  int hour, minute;
  Future alarmsFuture;
  List<bool> _selections = [false, false];
  List<int> _frequency = [0, 0, 0, 0, 0, 0, 0];
  // Future alarmsFuture;

  @override
  void initState() {
    super.initState();
    alarmsFuture = getAlarms();
    _alarmNameController.text = widget.editAlarm.name;
    if(widget.editAlarm.period == "AM"){
      _selections[0] = true;
    }
    else{
      _selections[1] = true;
    }
    _frequency = widget.editAlarm.frequency;
  }

  getAlarms() async {
    final alarmsData = await DBProvider.db.getAlarms();
    return alarmsData;
  }


// Function that will contain the dropdown for the expandable list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 45, 45, 70),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Edit Alarm'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 55, 55, 70),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Name: ',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      )),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none, hintText: "Enter name", hintStyle: TextStyle(color: Colors.grey[500])),
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      controller: _alarmNameController,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                      onChanged: (text) {
                        setState(() {
                          if(text == ''){
                            canSave = false;
                          }
                          else{
                            canSave = true;
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Time:',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      )),
                  SizedBox(width: 20.0),
                  NumberPicker.integer(
                      initialValue: widget.editAlarm.hour,
                      minValue: 1,
                      maxValue: 12,
                      listViewWidth: 35.0,
                      onChanged: (newValue) => setState(() => widget.editAlarm.hour = newValue)),
                  Text(':',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      )),
                  NumberPicker.integer(
                      initialValue: widget.editAlarm.minute,
                      minValue: 0,
                      zeroPad: true,
                      maxValue: 59,
                      listViewWidth: 60.0,
                      onChanged: (newValue) => setState(() => widget.editAlarm.minute = newValue)),
                  ToggleButtons(
                    children: [Text('AM'), Text('PM')],
                    isSelected: _selections,
                    onPressed: (int index){
                      setState(() {
                        for(int btnIndex = 0; btnIndex < _selections.length; btnIndex++){
                          if(btnIndex == index){
                            _selections[btnIndex] = true;
                            if(btnIndex == 0) {
                              widget.editAlarm.period = "AM";
                            }
                            else{
                              widget.editAlarm.period = "PM";
                            }
                          }
                          else{
                            _selections[btnIndex] = false;
                          }
                        }
                      });
                    },
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child:
                    FrequencyButton(day: 'Sun', active: _frequency[0] == 1, toggle: () => setState(() {
                      if(_frequency[0] == 1)
                        _frequency[0] = 0;
                      else
                        _frequency[0] = 1;
                    }))),
                    Expanded(child:
                    FrequencyButton(day: 'Mon', active: _frequency[1] == 1, toggle: () => setState(() {
                      if(_frequency[1] == 1)
                        _frequency[1] = 0;
                      else
                        _frequency[1] = 1;
                    }))),
                    Expanded(child:
                    FrequencyButton(day: 'Tues', active: _frequency[2] == 1, toggle: () => setState(() {
                      if(_frequency[2] == 1)
                        _frequency[2] = 0;
                      else
                        _frequency[2] = 1;
                    }))),
                    Expanded(child:
                    FrequencyButton(day: 'Wed', active: _frequency[3] == 1, toggle: () => setState(() {
                      if(_frequency[3] == 1)
                        _frequency[3] = 0;
                      else
                        _frequency[3] = 1;
                    }))),
                    Expanded(child:
                    FrequencyButton(day: 'Thurs', active: _frequency[4] == 1, toggle: () => setState(() {
                      if(_frequency[4] == 1)
                        _frequency[4] = 0;
                      else
                        _frequency[4] = 1;
                    }))),
                    Expanded(child:
                    FrequencyButton(day: 'Fri', active: _frequency[5] == 1, toggle: () => setState(() {
                      if(_frequency[5] == 1)
                        _frequency[5] = 0;
                      else
                        _frequency[5] = 1;
                    }))),
                    Expanded(child:
                    FrequencyButton(day: 'Sat', active: _frequency[6] == 1, toggle: () => setState(() {
                      if(_frequency[6] == 1)
                        _frequency[6] = 0;
                      else
                        _frequency[6] = 1;
                    })))
                  ]
              ),
              Divider(color: Colors.grey[400], height: 5.0),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FlatButton(
                        textColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text('Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )
                        ),
                        color: Colors.white,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SaveButton(
                        active: canSave,
                        save: () {
                          widget.editAlarm.frequency = _frequency;
                          widget.editAlarm.name = _alarmNameController.text;
                          widget.clickCallback();
                          //Todo: add database functionality to update existing entry based off of widget.editAlarm
                          DBProvider.db.editAlarm(widget.editAlarm);
                          Navigator.pop(context);
                        }
                    )
                  ]
              )
            ],)
        )
    );
  }

}