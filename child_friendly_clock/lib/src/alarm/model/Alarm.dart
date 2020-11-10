import 'dart:convert';

Alarm alarmFromJson(String str) => Alarm.fromJson(json.decode(str));

String alarmToJson(Alarm data) => json.encode(data.toJson());

class Alarm {
  String name;
  int alarmID;
  String period;
  int hour;
  int minute;
  int second;
  List<bool> frequency;
  String note;

  Alarm({this.name, this.alarmID, this.period, this.hour, this.minute, this.second, this.frequency, this.note});

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
        name: json["name"],
        alarmID: json["alarmID"],
        period: json["period"],
        hour: json["hour"],
        minute: json["minute"],
        second: json["second"],
        frequency: [json["sun"] == 1, json["mon"] == 1, json["tues"] == 1, json["wed"] == 1, json["thur"] == 1, json["fri"] == 1, json["sat"] == 1],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "alarmID": alarmID,
        "period": period,
        "hour": hour,
        "minute": minute,
        "second": second,
        "sun": frequency[0] ? 1 : 0,
        "mon": frequency[0] ? 1 : 0,
        "tues": frequency[0] ? 1 : 0,
        "wed": frequency[0] ? 1 : 0,
        "thur": frequency[0] ? 1 : 0,
        "fri": frequency[0] ? 1 : 0,
        "sat": frequency[0] ? 1 : 0,
        "note": note,
      };
}
