// home_page.dart
// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:routine_realm/database.dart';
import 'package:routine_realm/dialog.dart';
import 'package:routine_realm/habitCard.dart';
import 'package:routine_realm/newhabit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initiate hive box
  final _myBox = Hive.box('TestBox');
  RealmDatabase db = RealmDatabase();

  final _controller = TextEditingController();

  //varibales
  var HabitTileCount = 0;
  double ProgressPercent = 0;
  var imgIndex = 0;
  String setImg = '';
  List CheckboxImg = ['assets/CheckBoxFalse2.png', 'assets/CheckBoxTrue2.png'];

  //var index = 100;
  //List indexs = [];

  //temporary variables
  List habits = [];
  var count = 1;
  List testlist = [];

  @override
  void initState() {
    db.loadData();

    super.initState();
  }

  //Habit Description displays dialog box
  void ConfirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onDelete: () => DeleteHabit(),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //dialog box to enter details of new habit
  void NewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return NewHabitDialogBox(
          controller: _controller,
          onSave: () => AddHabit(),
        );
      },
    );
  }

  // adds new habit into a list
  void AddHabit() {
    setState(() {
      db.HabitList.add([_controller.text.trim(), false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // deletes habit from the list
  void DeleteHabit() {
    setState(() {
      habits.removeLast();
      HabitTileCount--;
      debugPrint('removed');
      Navigator.of(context).pop();
    });
  }

  // displays habit tile
  Widget HabitTile(int index) {
    return GestureDetector(
      onLongPress: () => ConfirmDelete(),
      child: HabitCard(

      ),
    );
  }

  void testHive() {
    /*
    indexs.add(index);
    _myBox.put(index, 'micha $index');
    testlist.add(_myBox.get(index));
    index++;*/
  }

  @override
  Widget build(BuildContext context) {
    //colors defined
    const color1 = Color.fromRGBO(69, 233, 177, 1);
    const color2 = Color.fromRGBO(11, 100, 119, 1);
    const color_text = Color.fromRGBO(21, 209, 121, 1);

    //var prgs = 40;
    String prgsText = "Today's Progress - $ProgressPercent%";

    const gradient1 = LinearGradient(colors: [color1, color2]);

    //main container
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          //Title
          ShaderMask(
            shaderCallback: (bounds) {
              return gradient1.createShader(
                  Rect.fromLTRB(0, 0, bounds.width, bounds.height));
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Routine\nRealm',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: color1,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          //Progress
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 8),
            child: Text(
              prgsText,
              style: const TextStyle(
                color: color_text,
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          //Progress bar
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: LinearPercentIndicator(
              lineHeight: 12,
              percent: ProgressPercent,
              barRadius: const Radius.circular(16),
              backgroundColor: const Color.fromRGBO(30, 43, 59, 1),
              progressColor: color_text,
            ),
          ),

          //Realm list header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20, left: 18),
                child: Text(
                  'Your Realm',
                  style: TextStyle(
                    color: color_text,
                    fontSize: 22,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 15),
                child: SizedBox(
                  height: 37,
                  child: IconButton(
                      onPressed: () {
                        NewHabit();
                        //AddHabit();
                      },
                      icon: const Image(
                        image: AssetImage('assets/AddIcon.png'),
                      )),
                ),
              ),
            ],
          ),

          // ListView
          SizedBox(
            //height: 420,
            height: 300,
            //color: color4,
            child: ListView.builder(
              itemCount: db.HabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(index);
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () => testHive(),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

/*
class ImgStatus{
  //bool status;
  int checkStatus(int status){
    if (status == 0){
      
    } 
  }

}
*/
/*
          const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                'Test 2',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
          )*/
