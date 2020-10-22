import 'dart:async';

class Model {
  Duration timerInterval = Duration(seconds: 1);
  int counter = 0;
  Timer timer;

  void stopTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
      counter = 0;
      StreamController().close();
    }
  }

  void tick(_) {
    counter++;
    StreamController().add(counter);
  }

  void startTimer() {
    timer = Timer.periodic(timerInterval, tick);
  }
}
