import 'package:flutter/material.dart';

class TabProvider with ChangeNotifier {
  int selectedIndex = 0;


  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}