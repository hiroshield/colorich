import 'package:colorich/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

class Onepiece extends StatelessWidget {
  final Color selectedColor;

  Onepiece(this.selectedColor);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: Container(color: selectedColor),
          onTap: () {},
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / -90,
          top: MediaQuery.of(context).size.width / 8.5,
          width: 30,
          height: 30,
          child: CircleAvatar(
            backgroundColor: puzzleList[0].selectedColor,
            //１列目（puzzleListのindex%3=>0) {親のselectedColor}
            //２列目（puzzleListのindex%3=>1) {1つ前の親のselectedColor}
            //３列目（puzzleListのindex%3=>0) {colorを親カラーと同じにする。}
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width / -90,
          left: MediaQuery.of(context).size.width / 8.5,
          width: 30,
          height: 30,
          child: CircleAvatar(
            backgroundColor: puzzleList[0].selectedColor,
            //１行目(puzzleListのindex<3){親のselectedColor}
            //２行目(puzzleListのindex>3){そのindex-3の親のselectedColor}
          ),
        ),
      ],
    );
  }
}
