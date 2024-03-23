// ignore_for_file: non_constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';

class RealmDatabase{
  List HabitList = [];
  int checked = 0;

  final _myBox = Hive.box('RealmBox');

  void updateDatabase(){
    _myBox.put("HABITLIST", HabitList);
  }

  void loadData(){
    if (_myBox.get('HABITLIST') != null){
      HabitList = _myBox.get('HABITLIST');
    }
  }

  void checkHabits(){
    for (int i = 0; i < HabitList.length; i++){
      if (HabitList[i][1] == true){
        checked++;
      }
    }
  }
}