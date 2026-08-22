import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/apparatus.dart';
import '../classes/routine.dart';
import '../classes/rulesets/ruleset.dart';
import '../constants/element_list_pommel_horse.dart';
import 'ruleset_service.dart';

Routine sampleRoutine1 = Routine(
    // Seeded once on first launch, before the user's locale is known
    // (initSettingsDb runs after initRoutinesDb) -- English matches the
    // app's default/fallback locale. The name is a plain, user-editable
    // field afterwards, so it cannot react to later locale switches.
    name: 'Sample Routine',
    apparatus: Apparatus.pommelHorse,
    elements: [
      p_1_1,
      p_1_15,
      p_1_7,
      p_1_2,
      p_1_25,
      p_2_1,
      p_2_74,
      p_3_1,
    ]);
Routine sampleRoutine2 = Routine(apparatus: Apparatus.pommelHorse, elements: [
  p_1_1,
]);

late Future<Database> futureDb;

Future<void> initRoutinesDb() async {
  futureDb = openDatabase(join(await getDatabasesPath(), 'routines.db'),
      onCreate: createRoutinesTable,
      onUpgrade: upgradeRoutinesTable,
      version: 4);
}

Future<void> createRoutinesTable(Database db, int version) async {
  await db.execute('CREATE TABLE routines('
      'id INTEGER PRIMARY KEY,'
      'name TEXT,'
      'apparatus TEXT,'
      'elements TEXT,'
      'd_score REAL,'
      'penalty REAL,'
      'rules TEXT)');
  _evaluate(sampleRoutine1);
  _evaluate(sampleRoutine2);
  await _storeNewRoutine(sampleRoutine1, db);
  await _storeNewRoutine(sampleRoutine2, db);
}

void _evaluate(Routine routine) {
  final RuleSet ruleSet = getRuleSetForApparatus(routine.apparatus);
  ruleSet.evaluateRoutine(routine);
}

Future<void> upgradeRoutinesTable(
    Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    await db.execute('ALTER TABLE routines ADD COLUMN apparatus TEXT');
  }
  if (oldVersion < 3) {
    await db.execute('ALTER TABLE routines ADD COLUMN d_score REAL');
    await db.execute('ALTER TABLE routines ADD COLUMN penalty REAL');
  }
  if (oldVersion < 4) {
    await db.execute('ALTER TABLE routines ADD COLUMN rules TEXT');
  }
}

Future<void> storeRoutine(Routine routine) async {
  if (routine.id != null) {
    // routine is already existing -> update
    return _updateExistingRoutine(routine);
  } else {
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
  await db.update('routines', routine.toMap(),
      where: 'id = ?', whereArgs: [routine.id]);
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
