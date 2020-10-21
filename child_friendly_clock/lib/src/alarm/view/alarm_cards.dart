import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class AlarmCards extends StatefulWidget {
  @override
  _AlarmCardsState createState() => _AlarmCardsState();
}

enum FormType {
  regular,
  edit,
  delete,
}


class _AlarmCardsState extends State<AlarmCards> {
  FormType _form = FormType.regular;
  bool isSwitched = false;

  void _formChange() async {
    setState(() {
      if(_form == FormType.regular){
        _form = FormType.edit;
      }
      else{
        _form = FormType.regular;
      }
    });
  }

  void _formChange2() async{
    setState(() {
      _form = FormType.delete;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_form == FormType.regular) {
      return Container(
        child: Transform.translate(
          offset: Offset(35.0, 0),
          child: SizedBox(
            width: 315.0,
            height: 255.0,
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          SvgPicture.string(
                            daytime_alarm_background,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            child: Stack(
                              children: <Widget>[
                                /* **** ALARM LABEL AND ON/OFF SWITCH **** */
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 10,
                                          top: 5,
                                          right: 20,
                                          bottom: 10),
                                      child: Icon(
                                        Icons.arrow_right,
                                        size: 45,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Work',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 25,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.2,
                                      origin: Offset(-525, 0),
                                      child: Switch(
                                        value: isSwitched,
                                        onChanged: (value) {
                                          setState(() {
                                            isSwitched = value;
                                            print(isSwitched);
                                          });
                                        },
                                        activeTrackColor: Colors
                                            .lightGreenAccent,
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                /* **** DAYS ALARM IS ACTIVE **** */
                                Container(
                                  margin: EdgeInsets.only(top: 50, left: 24),
                                  child: Text(
                                    'Mon - Fri',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 25,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                /* **** TIME AND DROP DOWN ROW **** */
                                Container(
                                  margin: EdgeInsets.only(top: 75),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 24),
                                        child: Text(
                                          '05:00 AM',
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 25,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 120),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_downward,
                                            color: Colors.white,
                                          ),
                                          iconSize: 35,
                                          onPressed: () {
                                            _formChange();
                                            print('Pressed');
                                          }, //
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (_form == FormType.edit) {
      return Container(
        child: Transform.translate(
          offset: Offset(35.0, 0),
          child: SizedBox(
            width: 315.0,
            height: 255.0,
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          SvgPicture.string(
                            daytime_alarm_background,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            child: Stack(
                              children: <Widget>[
                                /* **** ALARM LABEL AND ON/OFF SWITCH **** */
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 10,
                                          top: 5,
                                          right: 20,
                                          bottom: 10),
                                      child: Icon(
                                        Icons.arrow_right,
                                        size: 45,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Test',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 25,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.2,
                                      origin: Offset(-525, 0),
                                      child: Switch(
                                        value: isSwitched,
                                        onChanged: (value) {
                                          setState(() {
                                            isSwitched = value;
                                            print(isSwitched);
                                          });
                                        },
                                        activeTrackColor: Colors
                                            .lightGreenAccent,
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                /* **** DAYS ALARM IS ACTIVE **** */
                                Container(
                                  margin: EdgeInsets.only(top: 50, left: 24),
                                  child: Text(
                                    'Mon - Fri',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 25,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                /* **** TIME AND DROP DOWN ROW **** */
                                Container(
                                  margin: EdgeInsets.only(top: 75),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 24),
                                        child: Text(
                                          '05:00 AM',
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 25,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 85),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color:Colors.amber,
                                          ),
                                          iconSize: 35,
                                          onPressed: (){
                                            _formChange2();
                                            print('Pressed');
                                          }
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 190),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_upward,
                                            color: Colors.white,
                                          ),
                                          iconSize: 35,
                                          onPressed: (){
                                            _formChange();
                                            print('Pressed');
                                          },
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    if(_form == FormType.delete){
      _form = FormType.regular;
      return Container();
    }
  }
}


// Gradient background for the daytime alarm
const String daytime_alarm_background =
    '<svg viewBox="93.0 116.0 305.0 120.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="0" stdDeviation="25"/></filter><linearGradient id="gradient" x1="0.0" y1="0.5" x2="1.0" y2="0.5"><stop offset="0.0" stop-color="#ffff6262"  /><stop offset="1.0" stop-color="#fff962ff"  /></linearGradient></defs><path transform="translate(93.0, 116.0)" d="M 23.29501914978027 0 L 280.7049560546875 0 C 293.5704956054688 0 304.0000305175781 8.954304695129395 304.0000305175781 20 L 304.0000305175781 101 C 304.0000305175781 112.0456924438477 293.5704956054688 121 280.7049560546875 121 L 23.29501914978027 121 C 10.42953491210938 121 0 112.0456924438477 0 101 L 0 20 C 0 8.954304695129395 10.42953491210938 0 23.29501914978027 0 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';

// Gradient background for the nighttime alarm
const String nighttime_alarm_background =
    '<svg viewBox="93.0 614.0 305.0 120.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="0" stdDeviation="25"/></filter><linearGradient id="gradient" x1="0.0" y1="0.5" x2="1.0" y2="0.5"><stop offset="0.0" stop-color="#ff626eff"  /><stop offset="1.0" stop-color="#ff00f5ff"  /></linearGradient></defs><path transform="translate(93.0, 614.0)" d="M 23.37516021728516 0 L 281.6707153320312 0 C 294.5804443359375 0 305.0458374023438 8.954304695129395 305.0458374023438 20 L 305.0458374023438 101 C 305.0458374023438 112.0456924438477 294.5804443359375 121 281.6707153320312 121 L 23.37516021728516 121 C 10.46541595458984 121 0 112.0456924438477 0 101 L 0 20 C 0 8.954304695129395 10.46541595458984 0 23.37516021728516 0 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
