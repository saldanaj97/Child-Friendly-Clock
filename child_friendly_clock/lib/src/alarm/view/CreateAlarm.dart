import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';
import 'package:child_friendly_clock/src/alarm/utils/database.dart';
<<<<<<< HEAD
import 'package:flutter_picker/flutter_picker.dart';
=======
import 'package:child_friendly_clock/src/alarm/view/save_button.dart';
import 'package:child_friendly_clock/src/alarm/view/frequency_button.dart';
>>>>>>> master



class CreateAlarm extends StatefulWidget {
  final VoidCallback clickCallback;
  CreateAlarm({this.clickCallback});

  @override
  _CreateAlarmState createState() => _CreateAlarmState();
}

class _CreateAlarmState extends State<CreateAlarm> {
  TextEditingController _nameController;
  var newAlarm = Alarm(hour: 8, minute: 0, second: 0, period: "AM", name: "None");
  double proxyMinute = 0.0;
  List<bool> _selections = [true, false];
  List<bool> _frequency = [false, false, false, false, false, false, false]; // for every day of the week starting with sunday
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 45, 70),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add Alarm'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 55, 55, 70),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(),
                NumberPicker.integer(
                    initialValue: newAlarm.hour,
                    minValue: 1,
                    maxValue: 12,
                    listViewWidth: 100.0,
                    haptics: true,
                    onChanged: (newValue) => setState(() => newAlarm.hour = newValue)),
                Text(
                  ':',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                NumberPicker.integer(
                    initialValue: newAlarm.minute,
                    minValue: 0,
                    maxValue: 59,
                    zeroPad: true,
                    listViewWidth: 60.0,
                    onChanged: (newValue) => setState(() => newAlarm.minute = newValue)),
                ToggleButtons(
                  children: [Text('AM'), Text('PM')],
                  isSelected: _selections,
                  onPressed: (int index) {
                    setState(() {
                      for (int btnIndex = 0; btnIndex < _selections.length; btnIndex++) {
                        if (btnIndex == index) {
                          _selections[btnIndex] = true;
                          if (btnIndex == 0)
                            newAlarm.period = "AM";
                          else
                            newAlarm.period = "PM";
                        } else {
                          _selections[btnIndex] = false;
                        }
                      }
                    });
                  },
                )
              ],
            ),
            Divider(color: Colors.grey[400], height: 5.0),
            Row(
              children: <Widget>[
                Text(
                  'Name:',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none, hintText: 'enter name', hintStyle: TextStyle(color: Colors.grey[500])),
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                    ),
                    onChanged: (text) {
                      setState(() {
                        if (text != '') {
                          canSave = true;
                        } else {
                          canSave = false;
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
                    initialValue: newAlarm.hour,
                    minValue: 1,
                    maxValue: 12,
                    listViewWidth: 35.0,
                    onChanged: (newValue) => setState(() => newAlarm.hour = newValue)),
                Text(':',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
                NumberPicker.integer(
                    initialValue: newAlarm.minute,
                    minValue: 0,
                    maxValue: 59,
                    zeroPad: true,
                    listViewWidth: 60.0,
                    onChanged: (newValue) => setState(() => newAlarm.minute = newValue)),
                ToggleButtons(
                    children: [Text('AM'), Text('PM')],
                    isSelected: _selections,
                    onPressed: (int index) {
                      setState(() {
                        for (int btnIndex = 0; btnIndex < _selections.length; btnIndex++) {
                          if (btnIndex == index) {
                            _selections[btnIndex] = true;
                            if (btnIndex == 0)
                              newAlarm.period = "AM";
                            else
                              newAlarm.period = "PM";
                          } else {
                            _selections[btnIndex] = false;
                          }
                        }
                      });
                    })
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child:
                FrequencyButton(day: 'Sun', active: _frequency[0], toggle: () => setState(() {
                  _frequency[0] = !_frequency[0];
                }))),
                Expanded(child:
                FrequencyButton(day: 'Mon', active: _frequency[1], toggle: () => setState(() {
                  _frequency[1] = !_frequency[1];
                }))),
                Expanded(child:
                FrequencyButton(day: 'Tues', active: _frequency[2], toggle: () => setState(() {
                  _frequency[2] = !_frequency[2];
                }))),
                Expanded(child:
                FrequencyButton(day: 'Wed', active: _frequency[3], toggle: () => setState(() {
                  _frequency[3] = !_frequency[3];
                }))),
                Expanded(child:
                FrequencyButton(day: 'Thurs', active: _frequency[4], toggle: () => setState(() {
                  _frequency[4] = !_frequency[4];
                }))),
                Expanded(child:
                FrequencyButton(day: 'Fri', active: _frequency[5], toggle: () => setState(() {
                  _frequency[5] = !_frequency[5];
                }))),
                Expanded(child:
                FrequencyButton(day: 'Sat', active: _frequency[6], toggle: () => setState(() {
                  _frequency[6] = !_frequency[6];
                })))
              ]
            ),
            Divider(color: Colors.grey[400], height: 5.0),
            SizedBox(height: 20.0),
            Row(
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
                      )),
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pop(), //height: 100,
                )),
                //savebutton
                SaveButton(
                    active: canSave,
                    save: () {
                      newAlarm.name = _nameController.text;
                      newAlarm.frequency = _frequency;
                      DBProvider.db.newAlarm(newAlarm);
                      widget.clickCallback();
                      Navigator.pop(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget timeSelector() {
    showPickerNumber(BuildContext context) {
      return Picker(
          adapter: NumberPickerAdapter(data: [
            NumberPickerColumn(begin: 0, end: 999),
            NumberPickerColumn(begin: 100, end: 200),
          ]),
          delimiter: [
            PickerDelimiter(
                child: Container(
              width: 30.0,
              alignment: Alignment.center,
              child: Icon(Icons.more_vert),
            ))
          ],
          hideHeader: true,
          title: new Text("Please Select"),
          onConfirm: (Picker picker, List value) {
            print(value.toString());
            print(picker.getSelectedValues());
          }).showDialog(context);
    }
  }
}
