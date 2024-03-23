// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:routine_realm/database.dart';
import 'package:routine_realm/habit.dart';
import 'package:routine_realm/newdialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //initiate hive box
  final _myBox = Hive.box('TestBox');
  RealmDatabase db = RealmDatabase();

  //controller to read habit name
  final _controller = TextEditingController();

  double ProgressPercent = 0;

  //checkbox imgs
  List CheckboxImg = ['assets/CheckBoxFalse2.png', 'assets/CheckBoxTrue2.png'];
  var imgIndex = 0;

  //initial state of the app. Load necessary habits from database
  @override
  void initState() {
    db.loadData();

    super.initState();
  }

  //dialog box to enter details of new habit
  void NewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return NewHabitDialog(
          controller: _controller,
          onSave: () => AddHabit(),
        );
      },
    );
  }

  // adds new habit into a list
  void AddHabit() {
    setState(() {
      debugPrint("habit name : ${_controller.text}");
      db.HabitList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void changeStatus(int index) {
    setState(() {
      db.HabitList[index][1] = !db.HabitList[index][1];
    });
    db.updateDatabase();
  }

  void DeleteHabit(int index) {
    setState(() {
      db.HabitList.removeAt(index);
    });
    db.updateDatabase();
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
            height: 420,
            child: ListView.builder(
              itemCount: db.HabitList.length,
              itemBuilder: (context, index) {
                return RealmCard(
                  name: db.HabitList[index][0],
                  taskStatus: db.HabitList[index][1],
                  onCheck: () => changeStatus(index),
                  onDelete: (context) => DeleteHabit(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
