import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';

class DBProvider{
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  // singleton. When you call this it will check if an instance of this file
  // exists. If it doesn't then it will make a new instance of this class.
  Future<Database> get database async{
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;

  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cf_clock.db'),
      onCreate: (db, version) async{
        await db.execute('''
          CREATE TABLE alarm(
          alarmID INTEGER PRIMARY KEY,
          period TEXT,
          name TEXT,
          hour INTEGER,
          minute INTEGER,
          second INTEGER,
          mon INTEGER,
          tues INTEGER,
          wed INTEGER,
          thur INTEGER,
          fri INTEGER,
          sat INTEGER,
          sun INTEGER
          );
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async{
        var batch = db.batch();
        if(oldVersion == 1) {
          batch.execute("ALTER TABLE alarm ADD COLUMN mon INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN tues INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN wed INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN thur INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN fri INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN sat INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN sun INTEGER;");
        }
        else if(oldVersion == 2) {
          batch.execute("ALTER TABLE alarm ADD COLUMN tues INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN wed INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN thur INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN fri INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN sat INTEGER;");
          batch.execute("ALTER TABLE alarm ADD COLUMN sun INTEGER;");
        }
        await batch.commit();
      },
      version: 3
    );
  }

  newAlarm(Alarm newAlarm) async{
    final db = await database;

    var res = await db.rawInsert('''
      INSERT INTO alarm(
        period, name, hour, minute, second, sun, mon, tues, wed, thur, fri, sat
      ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
    ''', [newAlarm.period, newAlarm.name, newAlarm.hour, newAlarm.minute, newAlarm.second, newAlarm.frequency[0],newAlarm.frequency[1],newAlarm.frequency[2],newAlarm.frequency[3],newAlarm.frequency[4],newAlarm.frequency[5],newAlarm.frequency[6],]);

    return res;
  }

  deleteAlarm(int alarmID) async{
    final db = await database;

    int count = await db.rawDelete("DELETE FROM alarm WHERE alarmID = ?", [alarmID]);

    //if count isn't one we either didn't delete anything or deleted more than we wanted to.
    if(count == 1)
      return 1;
    else
      return -1;
  }

  editAlarm(Alarm editAlarm) async {
    final db = await database;

    var res = db.rawUpdate( " Update Alarm Set Period = ?, hour = ?, minute = ?, second = ?, sun = ?,mon = ?, tue = ?, wed = ?, thur = ?, fri = ?, sat = ? where name = ? ",
          [editAlarm.period, editAlarm.hour, editAlarm.minute, editAlarm.second,
          editAlarm.frequency[0],editAlarm.frequency[1],editAlarm.frequency[2], editAlarm.frequency[3],
          editAlarm.frequency[4],editAlarm.frequency[5], editAlarm.frequency[6],
          editAlarm.name]);
    return res;

  }

  Future<dynamic> getAlarms() async{
    final db = await database;

    var master = await db.query("sqlite_master");
    //print(master.toString());

    var res = await db.query("alarm");

    if(res.length == 0)
      return null;
    else{
      return res.isNotEmpty ? res : Null;
    }

  }
}