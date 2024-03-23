// ignore_for_file: non_constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';

class RealmDatabase{
  List HabitList = [];

  final _myBox = Hive.box('TestBox');

  void updateDatabase(){
    _myBox.put("HABITLIST", HabitList);
  }

  void loadData(){
    if (_myBox.get('HABITLIST') != null){
      HabitList = _myBox.get('HABITLIST');
    }
  }
}