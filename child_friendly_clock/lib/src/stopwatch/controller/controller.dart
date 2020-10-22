import 'dart:async';
import 'package:child_friendly_clock/src/stopwatch/model/model.dart';

Stream<int> stopWatchStream() {
  StreamController<int> streamController;

  void stopTimer() {
    Model().stopTimer();
  }

  void tick(_) {
    Model().tick(_);
  }

  void startTimer() {
    Model().startTimer();
  }

  streamController = StreamController<int>(
    onListen: startTimer,
    onCancel: stopTimer,
    onPause: stopTimer,
    onResume: startTimer,
  );

  return streamController.stream;
}
