// ignore_for_file: file_names

import 'package:ptracker/utils/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EventDatabase {
  static const tableEvent = 'eventsTable';
  static final EventDatabase instance = EventDatabase._init();

  static Database? _database;

  EventDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print("Db path : $path");

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const doubleType = 'REAL NOT NULL';
    const textType = 'TEXT NOT NULL';
    const datetimeType = 'DATETIME NOT NULL';

    // await db
    //     .execute("CREATE TABLE ? (? ?, ? ?, ? ?, ? ?, ? ?, ? ?, ? ?, ? ?)", [
    //   tableEvent,
    //   EventField.id,
    //   idType,
    //   EventField.valA,
    //   doubleType,
    //   EventField.valB,
    //   doubleType,
    //   EventField.valC,
    //   doubleType,
    //   EventField.distance,
    //   doubleType,
    //   EventField.checkpoint,
    //   datetimeType,
    //   EventField.emission,
    //   doubleType,
    //   EventField.time,
    //   textType
    // ]);

    await db.execute("CREATE TABLE $tableEvent ("
        "${EventField.id} $idType,"
        "${EventField.valA} $doubleType,"
        "${EventField.valB} $doubleType,"
        "${EventField.valC} $doubleType,"
        "${EventField.distance} $doubleType,"
        "${EventField.checkpoint} $datetimeType,"
        "${EventField.emission} $doubleType,"
        "${EventField.time} $datetimeType"
        ");");

    // await db.execute('''
    //   CREATE TABLE $tableEvent (
    //     ${EventField.id} $idType,
    //     ${EventField.valA} $doubleType,
    //     ${EventField.valB} $doubleType,
    //     ${EventField.valC} $doubleType,
    //     ${EventField.distance} $doubleType,
    //     ${EventField.checkpoint} $datetimeType,
    //     ${EventField.emission} $doubleType,
    //     ${EventField.time} $datetimeType
    //     );
    //     ''');
  }

  // create event
  Future<Event> create(Event event) async {
    final db = await instance.database;
    final id = await db.insert(tableEvent, event.toJson());
    return event.copy(id: id);
  }

  // read single tupple
  Future<Event> readEvent(String date) async {
    final db = await instance.database;

    final maps = await db.query(
      tableEvent,
      columns: EventField.values,
      where: '${EventField.time} = ?',
      whereArgs: [date],
    );

    if (maps.isNotEmpty) {
      return Event.fromJson(maps.first);
    } else {
      throw Exception('Row with $date not found');
    }
  }

  Future<List<Event>> readEvents() async {
    final db = await instance.database;

    final orderBy = '${EventField.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableEvent, orderBy: orderBy);

    return result.map((json) => Event.fromJson(json)).toList();
  }

  // update value
  Future<int> update(Event event) async {
    final db = await instance.database;

    return db.update(
      tableEvent,
      event.toJson(),
      where: '${EventField.id} = ?',
      whereArgs: [event.id],
    );
  }

  // delete a tupple
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEvent,
      where: '${EventField.id} = ?',
      whereArgs: [id],
    );
  }

  // close db
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
