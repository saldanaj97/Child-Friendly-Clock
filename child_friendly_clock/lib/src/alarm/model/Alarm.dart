import 'dart:convert';

Alarm alarmFromJson(String str) => Alarm.fromJson(json.decode(str));

String alarmToJson(Alarm data) => json.encode(data.toJson());

class Alarm{
  String name;
  int alarmID;
  String period;
  int hour;
  int minute;
  int second;

  Alarm({
    this.name,
    this.alarmID,
    this.period,
    this.hour,
    this.minute,
    this.second
  });

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
    name: json["name"],
    alarmID: json["alarmID"],
    period: json["period"],
    hour: json["hour"],
    minute: json["minute"],
    second: json["second"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "alarmID": alarmID,
    "period": period,
    "hour": hour,
    "minute": minute,
    "second": second
  };
}