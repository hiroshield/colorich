import 'dart:ui';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:after_layout/after_layout.dart';
import 'package:colorich/view/new/new_piece_view.dart';
import 'package:colorich/view/tool/settings.dart';
import 'package:colorich/view/home/time_line.dart';
import 'package:colorich/view/tool/colodice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AfterLayoutMixin<MyHomePage> {
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
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    scrollToBottom(const Duration(seconds: 1), Curves.linear);
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
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
            padding: const EdgeInsets.only(left: 7.0, bottom: 1.0, right: 7.0),
            child: GestureDetector(
                onTap: () => scrollToBottom(scrollDuration, scrollCurves),
                onLongPress: () => scrollToTop(),
                child: const Text('ColoRich',
                    style: TextStyle(
                        fontSize: 36.0,
                        fontFamily: "KleeOne",
                        fontWeight: FontWeight.w600)))),
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
                  return Settings();
                }));
              }),
        ],
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, bottom: 0, right: 0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              child: GridView.count(
                controller: scrollController,
                crossAxisCount: 3,
                children: puzzleList,
              ))),
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
                    width: 88))),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: 50,
        ),
      ),
    );
  }
}
