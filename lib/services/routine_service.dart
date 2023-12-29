import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/routine.dart';

late Future<Database> futureDb;

Future<void> initRoutinesDb() async {
  futureDb = openDatabase(join(await getDatabasesPath(), 'elements.db'),
      onCreate: createRoutinesTable, version: 1);
}

Future<void> createRoutinesTable(Database elementsDb, int version) async {
  elementsDb.execute('CREATE TABLE routines('
      'id INTEGER PRIMARY KEY,'
      'name TEXT,'
      'elements TEXT)');
}

Future<void> addRoutineToDb(Routine routine) async {
  Database db = await futureDb;
  await db.insert('routines', routine.toMap());
}

Future<List<Routine>> getAllRoutines() async {
  List<Future<Routine>> futureRoutines = [];

  Database db = await futureDb;
  final List<Map<String, dynamic>> maps = await db.query('routines');
  for (Map<String, dynamic> map in maps) {
    futureRoutines.add(Routine.fromMap(map));
  }
  return Future.wait(futureRoutines);
}
