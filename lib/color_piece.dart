import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'dart:ui';

class Onepiece extends StatelessWidget {
  final Color selectedColor;

  Onepiece(this.selectedColor, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      color: Colors.black,
      opacity: 0.4,
      offset: const Offset(4, 4),
      child: Image.asset(
        'images/colorpiece.jpg',
        color: selectedColor,
      ),
    );
  }
}
