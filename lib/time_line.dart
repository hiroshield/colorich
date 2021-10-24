import 'package:flutter/material.dart';
import 'color_piece.dart';

List<Onepiece> puzzleList = [
  Onepiece(Colors.green),
  Onepiece(Colors.lime),
  Onepiece(Colors.purpleAccent),
  Onepiece(Colors.lightBlueAccent),
  Onepiece(Colors.teal),
  Onepiece(Colors.cyanAccent),
  Onepiece(Colors.green),
  Onepiece(Colors.redAccent),
  Onepiece(Colors.pinkAccent),
  Onepiece(Colors.lime),
  Onepiece(Colors.purpleAccent),
  Onepiece(Colors.lightBlueAccent),
  Onepiece(Colors.teal),
  Onepiece(Colors.teal),
  Onepiece(Colors.cyanAccent),
  Onepiece(Colors.green),
  Onepiece(Colors.redAccent),
  Onepiece(Colors.pinkAccent),
  Onepiece(Colors.lime),
  Onepiece(Colors.purpleAccent),
  Onepiece(Colors.lightBlueAccent),
  Onepiece(Colors.teal),
];
/*
[n行目] top: piecewidth * 0.66(n-1)　　
商の値でnを振り分ける

[l列目]left: window.physicalSize.width*0.092*(n-1)
余りの値でlを振り分ける

10→10/3=3余り１
top: piecewidth*0.66(3-1)
left:window.physicalSize.width*0.092*(1-1)


 */
