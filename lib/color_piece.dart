import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'new_piece_view.dart';

class Onepiece extends StatelessWidget {
  final Color selectedColor;
  Onepiece(@required this.selectedColor);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/colorpiece.jpg',
      color: selectedColor,
    );
  }
}
