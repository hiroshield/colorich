import 'package:colorich/shuffle_color/colodice.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:ui';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'new_piece_view.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'settings.dart';
import 'color_piece.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

final pieceColorProvider = Provider((ref) => 'ColoRich');

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
  final piecewidth = window.physicalSize.width * 0.14;
  final scrollDuration = const Duration(milliseconds: 777);
  final scrollCurves = Curves.easeInOut;
  final newScrollCurves = Curves.easeInOutBack;
  ScrollController scrollController = ScrollController();

  void scrollToBottom(duration, curve) {
    final bottomOffset = scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      bottomOffset,
      duration: duration,
      curve: curve,
    );
  }

  void scrollToTop() {
    final topOffset = scrollController.position.minScrollExtent;
    scrollController.animateTo(
      topOffset,
      duration: scrollDuration,
      curve: scrollCurves,
    );
  }

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 7.0, bottom: 1.0, right: 7.0),
          child: GestureDetector(
            onTap: () {
              scrollToBottom(
                scrollDuration,
                scrollCurves,
              );
            },
            onLongPress: () {
              scrollToTop();
            },
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
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, bottom: 100, right: 10),
        child: GridView.count(
          // crossAxisSpacing: 10,
          // mainAxisSpacing: 10,
          controller: scrollController,
          crossAxisCount: 3,
          children: puzzleList,
        ),
      ),
      floatingActionButton: MaterialButton(
        shape: const CircleBorder(),
        child: CircleAvatar(
          radius: 44,
          backgroundColor: Colors.white,
          child: SimpleShadow(
            opacity: 0.3,
            color: Colors.black,
            offset: const Offset(0, 7),
            child: const Image(
              image: AssetImage('images/ccc.png'),
              height: 88,
              width: 88,
            ),
          ),
        ),
        // onLongPress: () {},
        //↑左からRGBの円グラフ（RGBPieChart）を出す。
        onPressed: () async {
          await showCupertinoModalBottomSheet(
            barrierColor: const Color.fromARGB(100, 0, 0, 0),
            topRadius: const Radius.circular(33),
            duration: const Duration(milliseconds: 400),
            context: context,
            builder: (context) {
              return const NewPieceView();
            },
          );
          scrollToBottom(scrollDuration, Curves.easeInOut);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

List<Onepiece> puzzleList = [
  Onepiece(Colors.green),
  Onepiece(Colors.redAccent),
  Onepiece(Colors.pinkAccent),
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
  Onepiece(Colors.cyanAccent),
  Onepiece(Colors.green),
  Onepiece(Colors.redAccent),
  Onepiece(Colors.pinkAccent),
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
  Onepiece(Colors.cyanAccent),
  Onepiece(Colors.green),
  Onepiece(Colors.redAccent),
  Onepiece(Colors.pinkAccent),
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
  Onepiece(Colors.cyanAccent),
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
