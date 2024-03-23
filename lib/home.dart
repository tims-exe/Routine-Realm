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
  final _myBox = Hive.box('RealmBox');
  RealmDatabase db = RealmDatabase();

  //controller to read habit name
  final _controller = TextEditingController();

  //progress variables
  int checkedHabits = 0;
  double ProgressPercent = 0;

  //initial state of the app. Load necessary habits from database
  @override
  void initState() {
    db.loadData();
    db.checkHabits();
    checkedHabits = db.checked;
    updateProgress();

    super.initState();
  }

  void updateProgress() {
    setState(() {
      double n = checkedHabits / db.HabitList.length;
      ProgressPercent = double.parse(n.toStringAsFixed(2));
      if (ProgressPercent.isNaN) {
        ProgressPercent = 0;
      }
    });
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
      if (_controller.text.trim() != '') {
        db.HabitList.add([_controller.text, false]);
        _controller.clear();
        updateProgress();
      }
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void changeStatus(int index) {
    setState(() {
      db.HabitList[index][1] = !db.HabitList[index][1];
      if (db.HabitList[index][1]) {
        checkedHabits += 1;
      } else {
        checkedHabits -= 1;
      }
      updateProgress();
    });
    db.updateDatabase();
  }

  void DeleteHabit(int index) {
    setState(() {
      if (db.HabitList[index][1]) {
        checkedHabits -= 1;
      }
      db.HabitList.removeAt(index);
      updateProgress();
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    //colors defined
    const color1 = Color.fromRGBO(69, 233, 177, 1);
    const color2 = Color.fromRGBO(11, 100, 119, 1);
    const color_text = Color.fromRGBO(21, 209, 121, 1);

    String prgsText = "Progress - ${(ProgressPercent * 100).toInt()}%";

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
                        setState(() {
                          _controller.clear();
                        });
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
              physics: const BouncingScrollPhysics(),
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
