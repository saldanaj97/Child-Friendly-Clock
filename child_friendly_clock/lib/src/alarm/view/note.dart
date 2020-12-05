import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

showNote(BuildContext context, String userNote, int alarmID) {
  Widget continueButton = FlatButton(
      child: Text("Close"),
      onPressed: () {
        if(alarmID != -1){
          SendPort port;
          port ??= IsolateNameServer.lookupPortByName('alarm $alarmID isolate');

          port?.send(alarmID);
        }
        Navigator.pop(context);
      });

  AlertDialog alert = AlertDialog(
    title: Text('Note'),
    content: SingleChildScrollView(child:  Text(userNote)),
    actions: [
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
