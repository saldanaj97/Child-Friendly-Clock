import 'package:flutter/material.dart';

showNote(BuildContext context, String userNote) {
  Widget continueButton = FlatButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.pop(context);
      });

  AlertDialog alert = AlertDialog(
    title: Text('Note'),
    content: Text(userNote),
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
