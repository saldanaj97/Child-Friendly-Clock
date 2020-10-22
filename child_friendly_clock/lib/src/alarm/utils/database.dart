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
          second INTEGER)
        ''');
      },
      version: 1
    );
  }

  newAlarm(Alarm newAlarm) async{
    final db = await database;

    var res = await db.rawInsert('''
      INSERT INTO alarm(
        period, name, hour, minute, second
      ) VALUES (?,?,?,?,?)
    ''', [newAlarm.period, newAlarm.name, newAlarm.hour, newAlarm.minute, newAlarm.second]);

    return res;
  }

  Future<dynamic> getAlarm() async{
    final db = await database;
    var res = await db.query("alarm");
    if(res.length == 0)
      return null;
    else{
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }

  }
}