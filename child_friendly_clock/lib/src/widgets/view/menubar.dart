import 'package:child_friendly_clock/src/alarm/view/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../alarm/utils/database.dart';
import '../../widgets/view/navbar.dart';
import '../../home/view/home.dart';

showAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      });

  Widget continueButton = FlatButton(
      child: Text("Delete Everything"),
      onPressed: () {
        //Todo: needs to connect to database and reset everything
        DBProvider.db.resetApplication();
        Navigator.pushReplacement(context, SizeRoute(page: Home()));
      });

  AlertDialog alert = AlertDialog(
    title: Text("Reset App"),
    content: Text("Are you sure you want to reset the app? \n This will remove all previously saved settings"),
    actions: [
      cancelButton,
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
