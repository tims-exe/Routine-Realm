import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  VoidCallback onDelete;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 21, 42, 41),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: const Text(
        'Delete Realm ?',
        style: TextStyle(
          color: Color.fromRGBO(232, 253, 242, 1),
          fontSize: 30,
        ),
      ),
      content: const Text(
        '',
        style: TextStyle(
          color: Color.fromRGBO(232, 253, 242, 1),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onDelete,
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
              onPressed: onCancel,
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
