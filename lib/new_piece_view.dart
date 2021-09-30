import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:cyclop/cyclop.dart';
import 'package:simple_shadow/simple_shadow.dart';

class NewPieceView extends StatefulWidget {
  const NewPieceView({Key? key}) : super(key: key);

  @override
  _NewPieceViewState createState() => _NewPieceViewState();
}

class _NewPieceViewState extends State<NewPieceView> {
  Color selectedColor = Colors.cyan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SimpleShadow(
                child: Image(
                  image: const AssetImage('images/colorpiece.jpg'),
                  color: selectedColor,
                  height: window.physicalSize.height * 0.08,
                ),
                opacity: 0.5,
                color: Colors.black,
                offset: const Offset(4, 4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleShadow(
                      child: const Text(
                        'Howdy?',
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      opacity: 0.5,
                      color: Colors.black,
                      offset: const Offset(1, 1)),
                  const SizedBox(width: 18.0),
                  SimpleShadow(
                    child: ColorButton(
                        color: selectedColor,
                        darkMode: false,
                        boxShape: BoxShape.circle,
                        size: 35,
                        config: const ColorPickerConfig(
                          enableOpacity: false,
                          enableLibrary: true,
                        ),
                        onColorChanged: (value) {
                          setState(() {
                            selectedColor = value;
                          });
                        }),
                    opacity: 0.3,
                    color: Colors.black87,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MaterialButton(
        shape: const CircleBorder(),
        child: const Image(
          image: AssetImage('images/new_peace_sign.png'),
          color: Colors.black,
          width: 80,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      //ColorPicker
      //DiaryText
    );
  }
}
