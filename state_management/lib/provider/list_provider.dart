import 'package:flutter/cupertino.dart';

class ListProvider with ChangeNotifier {
  List<Map<String, dynamic>> ydata = [];

  void addData(Map<String, dynamic> data) {
    ydata.add(data);
    notifyListeners();
  }

  List<Map<String, dynamic>> getData() {
    return [
      {'name': "Yash", 'age': '21'}
    ];
  }
}
