import 'package:colorich/shuffle_color/colodice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:ui';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'new_piece_view.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColoRich',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ColoRich'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 7.0, bottom: 1.0, right: 7.0),
          child: GestureDetector(
            // onTap: (){
            //  １タップで、最新のピースへ移動する
            // },
            // onLongPress: () {
            //  RGB使用割合のViewを左側から表示させる
            // },
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 36.0,
                fontFamily: "KleeOne",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(Icons.search, size: 30),
            ),
            onPressed: () {
              //右に飛んて、カレンダーを表示して、それぞれをタップしたら、編集画面に飛べる。
            },
          ),
          IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(Icons.shuffle, size: 30),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ColoDice();
              }));
            },
          ),
          IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(top: 5, right: 15),
              child: Icon(Icons.settings_rounded, size: 30),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Settings();
              }));
              //右に飛んで、設定画面に飛ぶ。
              //バックアップ、意見メール、アプリ評価、インスタ、アプリ情報、著作権、メッセ
            },
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Colors.redAccent,
            Colors.greenAccent,
            Colors.blueAccent,
          ],
        ),
      ),
      body: const Center(),
      floatingActionButton: MaterialButton(
        shape: const CircleBorder(),
        child: SimpleShadow(
          opacity: 0.3,
          color: Colors.black,
          offset: const Offset(0, 6.5),
          child: const Image(
            image: AssetImage('images/ccc.png'),
            height: 80,
            width: 80,
          ),
        ),
        onPressed: () {
          showCupertinoModalBottomSheet(
            barrierColor: const Color.fromARGB(100, 0, 0, 0),
            topRadius: const Radius.circular(33),
            duration: const Duration(milliseconds: 400),
            context: context,
            builder: (context) {
              return const NewPieceView();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
