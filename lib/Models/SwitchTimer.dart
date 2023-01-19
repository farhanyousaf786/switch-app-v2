import 'package:flutter/foundation.dart';

class SwitchTimer extends ChangeNotifier {
  int _remainingTime = 60;

  int getRemainingTime() {
    return _remainingTime;
  }

  updateRemainingTime() {
    _remainingTime--;
    notifyListeners();
  }
}
