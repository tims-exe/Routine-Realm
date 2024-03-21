// home_page.dart
// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:routine_realm/dialog.dart';
import 'package:routine_realm/habitCard.dart';
import 'package:routine_realm/newhabit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habits = [];
  var HabitTileCount = 0;
  double ProgressPercent = 0;
  var count = 1;
  var imgIndex = 0;
  String setImg = '';
  List CheckboxImg = ['assets/CheckBoxFalse2.png', 'assets/CheckBoxTrue2.png'];

  void HabitDesc() {
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

  void NewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return NewHabitDialogBox();
      },
    );
  }

  Widget HabitTile() {
    return GestureDetector(
      onLongPress: () => HabitDesc(),
      child: HabitCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const color1 = Color.fromRGBO(69, 233, 177, 1);
    const color2 = Color.fromRGBO(11, 100, 119, 1);
    const color_text = Color.fromRGBO(21, 209, 121, 1);

    var prgs = 40;
    String prgsText = "Today's Progress - $prgs%";

    const gradient1 = LinearGradient(colors: [color1, color2]);

    return Container(
      padding: const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                        AddHabit();
                      },
                      icon: const Image(
                        image: AssetImage('assets/AddIcon.png'),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 420,
            //color: color4,
            child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return HabitTile();
                }),
          ),
        ],
      ),
    );
  }

  void AddHabit() {
    setState(() {
      habits.add('habit');
      HabitTileCount++;
      debugPrint(habits[habits.length - 1]);
    });
  }

  void DeleteHabit() {
    setState(() {
      habits.removeLast();
      HabitTileCount--;
      debugPrint('removed');
      Navigator.of(context).pop();
    });
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