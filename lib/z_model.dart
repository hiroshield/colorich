import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'colorich_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE  dogs(id INTEGER PRIMARY KEY, time TEXT, color BLOB, story TEXT',
      );
    },
    version: 1,
  );

  Future<void> insertCR(CRModel newCR) async {
    final db = await database;

    await db.insert(
      'newCRs',
      newCR.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CRModel>> newCRs() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('newCRs');

    return List.generate(maps.length, (i) {
      return CRModel(
        id: maps[i]['id'],
        time: maps[i]['time'],
        color: maps[i]['color'],
        story: maps[i]['story'],
      );
    });
  }

  Future<void> updateCR(CRModel newCR) async {
    final db = await database;

    await db.update(
      'newCRs',
      newCR.toMap(),
      where: 'id = ?',
      whereArgs: [newCR.id],
    );
  }

  Future<void> deleteCR(int id) async {
    final db = await database;

    await db.delete(
      'newCRs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  var firstCR = CRModel(
    id: 0,
    time: DateTime.now(),
    color: Color.fromARGB(255, 255, 10, 155),
    story: '夜に食べたブドウが、すごくおいしかった。',
  );
  print(await newCRs());

  firstCR = CRModel(
    id: firstCR.id,
    time: firstCR.time,
    color: firstCR.color,
    story: '新しい文章',
  );

  await updateCR(firstCR);

  print(await newCRs());

  await deleteCR(firstCR.id);

  print(await newCRs());
}

class CRModel {
  final int id;
  final DateTime time;
  final Color color;
  final String story;

  CRModel({
    required this.id,
    required this.time,
    required this.color,
    required this.story,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'color': color,
      'story': story,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'ZDataModel{id: $id, time: $time, color: $color, story: $story}';
  }
}
