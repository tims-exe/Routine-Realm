// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';

class NewHabitDialog extends StatelessWidget {
  final controller;
  VoidCallback onSave;

  NewHabitDialog({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 21, 42, 41),
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
        cursorColor: const Color.fromRGBO(232, 253, 242, 0.5),
        controller: controller,
        style: const TextStyle(color: Color.fromRGBO(232, 253, 242, 1)),
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle: const TextStyle(
            color: Color.fromRGBO(232, 253, 242, 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(232, 253, 242, 0.3), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
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
