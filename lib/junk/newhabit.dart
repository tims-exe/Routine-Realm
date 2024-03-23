import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewHabitDialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;

  NewHabitDialogBox({
    super.key,
    required this.controller,
    required this.onSave,
  });

  final habitTitleController = TextEditingController();
  // final habitDescController = TextEditingController();

  var habitTitle = '';
  //var habitDesc = '';

  final _myBox = Hive.box('TestBox');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 21, 42, 41),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: const Text(
        'New Realm',
        style: TextStyle(
          color: Color.fromRGBO(232, 253, 242, 1),
          fontSize: 30,
        ),
      ),
      content: TextField(
                controller: habitTitleController,
                style: TextStyle(color: Color.fromRGBO(232, 253, 242, 1)),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(232, 253, 242, 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(232, 253, 242, 0.3), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(232, 253, 242, 0.6), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: TextButton(
              onPressed: onSave,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Color.fromRGBO(232, 253, 242, 1),
                ),
              )),
        ),
      ],
    );
  }
}

/*
habitTitle = habitTitleController.text.trim();
                //habitDesc = habitDescController.text.trim();
                print('title : $habitTitle');
                //print('Desc : $habitDesc');
                if (habitTitle != '' && habitTitle != '') {
                  _myBox.put(3, [habitTitle]);
                }
                Navigator.of(context).pop(); */

/*
content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: TextField(
                controller: habitTitleController,
                style: TextStyle(color: Color.fromRGBO(232, 253, 242, 1)),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(232, 253, 242, 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(232, 253, 242, 0.3), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(232, 253, 242, 0.6), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            TextField(
              controller: habitDescController,
              style: TextStyle(color: Color.fromRGBO(232, 253, 242, 1)),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(232, 253, 242, 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(232, 253, 242, 0.3), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(232, 253, 242, 0.6), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
 */