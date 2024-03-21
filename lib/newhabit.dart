import 'package:flutter/material.dart';

class NewHabitDialogBox extends StatelessWidget {
  const NewHabitDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(21, 36, 42, 1),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: const Text(
        'Description',
        style: TextStyle(
          color: Color.fromRGBO(232, 253, 242, 1),
          fontSize: 30,
        ),
      ),
      content: const Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        style: TextStyle(
          color: Color.fromRGBO(232, 253, 242, 1),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: TextButton(
              onPressed: () {},
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color.fromRGBO(232, 253, 242, 1),
                ),
              )),
        ),
      ],
    );
  }
}
