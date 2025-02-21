import 'package:flutter/cupertino.dart';

class NameProvider with ChangeNotifier {
  String name = "Hello World";

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }
}
