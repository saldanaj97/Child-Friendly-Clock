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
      return Expanded(
          child: FlatButton(
            textColor: Colors.white,
            shape: CircleBorder(),
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
          ));
    } else {
      return Expanded(
          child: FlatButton(
            textColor: Colors.grey,
            shape: CircleBorder(),
            child: Text('Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            color: Colors.grey[800],
            onPressed: () {},
            //height: 100,
          ));
    }
  }
}