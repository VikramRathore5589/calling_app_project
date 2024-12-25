import 'package:flutter/cupertino.dart';

class BottomNavigationBarProvider extends ChangeNotifier{
  int currentIndex = 0;
  void changeValue( index){
    currentIndex = index;
    notifyListeners();}
}