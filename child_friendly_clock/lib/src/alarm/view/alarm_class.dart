
class AlarmClass {
  //fields
  String time = "";
  bool AM_PM = true;
  // bool array for frequency of alarms: no repeat, repeat daily, repeat weekly, repeat montly, repeat yearly
  var frequency = [false, true, false, false, false];
  String name = "";


  void setAlarm(String nameGiven, String timeGiven, bool am_pmGiven, var frequencyGiven){
    //ToDo connect to database
    time = timeGiven;
    AM_PM = am_pmGiven;
    frequency = frequencyGiven;
    name = nameGiven;
  }

  void deleteAlarm(String nameGiven){
    //ToDo connect to database

    //delete(nameGiven);
  }

  void editAlarm(String nameGiven, String timeGiven, bool am_pmGiven, var frequencyGiven){
    //Todo connect to database
    time = timeGiven;
    AM_PM = am_pmGiven;
    frequency = frequencyGiven;
    name = nameGiven;
  }

  AlarmClass getAlarm(String name){
    //Todo connect to database, determine what parameter needed to get alarm
    return null;
  }
}