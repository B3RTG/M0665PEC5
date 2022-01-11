import 'package:flutter/cupertino.dart';

class CounterModel with ChangeNotifier {
  int _count = 0;

  //getter for the property
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
