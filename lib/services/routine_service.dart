import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/routine.dart';
import '../constants/element_list_pommel_horse.dart';

Routine sampleRoutine1 = Routine(
    name: 'Beispielübung',
    elements: [
      p_1_1,
      p_1_3,
      p_1_7,
      p_1_8,
      p_1_13,
      p_2_1,
      p_2_92,
      p_3_1,
    ]
);
Routine sampleRoutine2 = Routine(
    elements: [
      p_1_1,
    ]
);

late Future<Database> futureDb;

Future<void> initRoutinesDb() async {
  futureDb = openDatabase(join(await getDatabasesPath(), 'routines.db'),
      onCreate: createRoutinesTable, version: 1);
}

Future<void> createRoutinesTable(Database db, int version) async {
  await db.execute('CREATE TABLE routines('
      'id INTEGER PRIMARY KEY,'
      'name TEXT,'
      'elements TEXT)');
  await _storeNewRoutine(sampleRoutine1, db);
  await _storeNewRoutine(sampleRoutine2, db);
}


Future<void> storeRoutine(Routine routine) async {
  if(routine.id != null) {
    // routine is already existing -> update
    return _updateExistingRoutine(routine);
  }
  else {
    // routine is newly created -> store
    int id = await _storeNewRoutine(routine);
    routine.id = id;
  }
}

Future<int> _storeNewRoutine(Routine routine, [Database? db]) async {
  // During setup of the sample routines, the field futureDb might not be set.
  // Therefore, the optional argument db allows passing of the db directly.
  db ??= await futureDb;
  return await db.insert('routines', routine.toMap());
}

Future<void> _updateExistingRoutine(Routine routine) async {
  Database db = await futureDb;
  await db.update('routines', routine.toMap(), where: 'id = ?', whereArgs: [routine.id]);
}

Future<void> deleteRoutine(int routineId) async {
  Database db = await futureDb;
  await db.delete('routines', where: 'id = ?', whereArgs: [routineId]);
}


Future<List<Routine>> getAllRoutines() async {
  Database db = await futureDb;
  List<Future<Routine>> futureRoutines = [];

  final List<Map<String, dynamic>> maps = await db.query('routines');
  for (Map<String, dynamic> map in maps) {
    futureRoutines.add(Routine.fromMap(map));
  }
  return Future.wait(futureRoutines);
}
