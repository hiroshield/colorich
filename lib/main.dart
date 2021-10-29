import 'package:flutter/material.dart';
import 'view/home/my_home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
  bool backups = await box.get('backup', defaultValue: false);
  bool notifications = await box.get('notice', defaultValue: false);
  TimeOfDay timers = await box.get(
    'timers',
    defaultValue: const TimeOfDay(hour: 21, minute: 00),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
