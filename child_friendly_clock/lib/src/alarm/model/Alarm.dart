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
  List<int> frequency;

  Alarm({
    this.name,
    this.alarmID,
    this.period,
    this.hour,
    this.minute,
    this.second,
    this.frequency
  });

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
    name: json["name"],
    alarmID: json["alarmID"],
    period: json["period"],
    hour: json["hour"],
    minute: json["minute"],
    second: json["second"],
    frequency: [json["sun"], json["mon"], json["tues"], json["wed"], json["thur"], json["fri"], json["sat"]]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "alarmID": alarmID,
    "period": period,
    "hour": hour,
    "minute": minute,
    "second": second,
    "sun": frequency[0],
    "mon": frequency[0],
    "tues": frequency[0],
    "wed": frequency[0],
    "thur": frequency[0],
    "fri": frequency[0],
    "sat": frequency[0],
  };
}