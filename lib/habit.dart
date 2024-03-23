import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class RealmCard extends StatelessWidget {
  final String name;
  final bool taskStatus;
  Function(BuildContext)? onDelete;
  VoidCallback onCheck;

  RealmCard({
    super.key,
    required this.name,
    required this.taskStatus,
    required this.onDelete,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    //initialising colours
    const color_text = Color.fromRGBO(21, 209, 121, 1);
    const gradient = LinearGradient(colors: [
      Color.fromRGBO(30, 43, 59, 1),
      Color.fromRGBO(33, 101, 81, 1)
    ]);

    //check task status
    String img;
    if (taskStatus) {
      img = 'assets/CheckBoxTrue2.png';
    } else {
      img = 'assets/CheckBoxFalse2.png';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 0, right: 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: OutlinedButton(
          onPressed: onCheck,
          style: ButtonStyle(side: MaterialStateProperty.all(BorderSide.none)),
          child: Container(
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: gradient,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: color_text,
                      fontSize: 25,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: onCheck,
                    icon: Image(
                      image: AssetImage(img),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
