import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/routine_element.dart';
import '../constants/element_list_pommel_horse.dart';
import '../constants/element_list_pommel_horse_national.dart';

late Future<Database> _futureDb;
late Future<List<RoutineElement>> _futureElementsPommelHorse;

Future<void> initElementsDb() async {
  _futureDb = openDatabase(join(await getDatabasesPath(), 'elements.db'),
      onCreate: createElementsTable, version: 1);
  _futureElementsPommelHorse = loadAllElements();
}

Future<void> createElementsTable(Database elementsDb, int version) async {
  elementsDb.execute('CREATE TABLE pommel_horse('
      'id TEXT PRIMARY KEY,'
      'nameInt TEXT,'
      'name TEXT,'
      'difficulty TEXT,'
      '`group` INTEGER)');

  List<Future<int>> futures = [];

  for (RoutineElement element in ELEMENTS_POMMEL_HORSE) {
    futures.add(elementsDb.insert('pommel_horse', element.toMap()));
  }

  for (RoutineElement element in ELEMENTS_POMMEL_HORSE_NATIONAL) {
    futures.add(elementsDb.insert('pommel_horse', element.toMap()));
  }
  await Future.wait(futures);
}

Future<List<RoutineElement>> loadAllElements() async {
  List<RoutineElement> elements = [];
  Database db = await _futureDb;
  final List<Map<String, dynamic>> maps = await db.query('pommel_horse');
  for (Map<String, dynamic> map in maps) {
    elements.add(RoutineElement.fromMap(map));
  }
  return elements;
}

Future<List<RoutineElement>> getAllElements() async {
  return await _futureElementsPommelHorse;
}

Future<RoutineElement> getRoutineElementById(String id) async {
  List<RoutineElement> allElements = await getAllElements();
  RoutineElement? element = allElements.firstWhere(
    (element) => element.id == id,
  );
  return element.copy();
}
