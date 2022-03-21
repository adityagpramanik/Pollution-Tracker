import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ptracker/utils/event.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper.init();
  static final DatabaseHelper instance = DatabaseHelper.init();

  static Database? _database;

  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "events.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database database, int version) async {
    await database.execute('''
    create table event(
      eid text primary key,
      start text,
      end text,
      sloat double,
      slotb double,
      slotc double
    )
    ''');
  }

  void getEvents() async {
    Database db = await instance.database;
    var events = await db.query('event');

    print(events);
  }

  void addEvent(Event event) async {
    Database db = await instance.database;

    try {
      await db.execute('''
    insert into event values(
      "${event.eid}",
      "${event.start}",
      "${event.end}",
      ${event.slota},
      ${event.slotb},
      ${event.slotc}
    )
    ''');
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
