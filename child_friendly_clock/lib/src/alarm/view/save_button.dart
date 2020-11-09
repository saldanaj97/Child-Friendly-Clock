import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatefulWidget {
  final VoidCallback save;
  final bool active;
  SaveButton({this.active, this.save});

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.active) {
      return FlatButton(
        height: 40,
        minWidth: 135,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text('Save',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            )),
        color: Colors.lightBlue,
        onPressed: () {
          widget.save();
        },
        //height: 100,
      );
    } else {
      return FlatButton(
        height: 40,
        minWidth: 135,
        textColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text('Save',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            )),
        color: Colors.grey[800],
        onPressed: () {},
        //height: 100,
      );
    }
  }
}
