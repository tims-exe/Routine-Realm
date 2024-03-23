// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'home.dart';

class HabitCard extends StatefulWidget {
  final String habitName;

  const HabitCard({
    super.key,
    required this.habitName,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  List CheckboxImg = ['assets/CheckBoxFalse2.png', 'assets/CheckBoxTrue2.png'];
  var imgIndex = 0;

  @override
  Widget build(BuildContext context) {
    const color_text = Color.fromRGBO(21, 209, 121, 1);
    const gradient = LinearGradient(colors: [
      Color.fromRGBO(30, 43, 59, 1),
      Color.fromRGBO(33, 101, 81, 1)
    ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 0, right: 0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            /*
            SetImageIndex st = SetImageIndex(index: imgIndex);
            st.checkIndex();
            */
            (imgIndex == 0) ? imgIndex = 1 : imgIndex = 0;
          });
        },
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
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  habitName,
                  style: TextStyle(
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
                  onPressed: () {
                    setState(() {
                      (imgIndex == 0) ? imgIndex = 1 : imgIndex = 0;
                    });
                  },
                  icon: Image(
                    image: AssetImage(CheckboxImg[imgIndex]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class SetImageIndex {
  int index;
  SetImageIndex({
    required this.index,
  });
  
  int checkIndex(){
    ImgStatus im = ImgStatus(status: status)
    if (index == 0){
      return 1;
    }
    else {
      return 0;
    }
  }
}
*/
