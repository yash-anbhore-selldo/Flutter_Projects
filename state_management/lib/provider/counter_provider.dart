import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CounterProvider with ChangeNotifier {
  int counter = 0;

  void incCounter() {
    counter++;
    notifyListeners();
  }

  void resetCounter() {
    counter = 0;
    notifyListeners();
  }

  void decCounter() {
    counter--;
    notifyListeners();
  }
}
