import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrequencyButton extends StatefulWidget {
  final String day;
  final bool active;
  final VoidCallback toggle;
  FrequencyButton({this.day, this.active, this.toggle});

  @override
  _FrequencyButtonState createState() => _FrequencyButtonState();
}

class _FrequencyButtonState extends State<FrequencyButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.active) {
      return RawMaterialButton(
          child: Text(widget.day, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Colors.grey[200])),
          shape: CircleBorder(),
          fillColor: Colors.blue[500],
          onPressed: widget.toggle,
          constraints: BoxConstraints(minWidth: 45, minHeight: 45, maxWidth: 50, maxHeight: 50));
    } else {
      return RawMaterialButton(
        child: Text(widget.day, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Colors.grey[900])),
        shape: CircleBorder(),
        fillColor: Colors.grey[200],
        onPressed: widget.toggle,
        constraints: BoxConstraints(minWidth: 45, minHeight: 45, maxWidth: 50, maxHeight: 50),
      );
    }
  }
}
