import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:gym_code/services/settings_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String databaseName = "vocabulary.db";
const String tableName = "vocabulary";
const String columnId = "id";
const String columnText = "text";
const String columnTranslation = "translation";
const String columnLanguage = "language";

const Map<String, String> vocabularyFiles = {
  "german": "assets/vocabulary_german.csv",
  "english": "assets/vocabulary_english.csv"
};

late Future<Database> futureDb;

Future<void> initVocabularyDb() async {
  var databasesPath = await

  getDatabasesPath();

  String path = join(databasesPath, databaseName);

  // Create the database if it doesn't exist
  futureDb = openDatabase
    (
      path, version: 1, onCreate: (db, version) async {
    db.execute('''
        CREATE TABLE $tableName (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnText TEXT NOT NULL,
          $columnTranslation TEXT NOT NULL,
          $columnLanguage TEXT NOT NULL
        )
      ''');

    // Insert initial data
    for (String language in vocabularyFiles.keys) {
      String content = await rootBundle.loadString(vocabularyFiles[language]!);
      List<List<String>> vocab = const CsvToListConverter(
        shouldParseNumbers: false,
        fieldDelimiter: ',',
        eol: '\n',
      ).convert(content);
      
      for(List<String> word in vocab) {
        db.insert('vocabulary', {
          'text': word[0],
          'translation': word[1],
          'language': language
        });
      }
    }
  });
}

Future<String> getVocabulary(String text) async {
  Database db = await futureDb;
  Language language = getLanguage();

  List<Map<String, Object?>> res = await db.query(
    'vocabulary',
    columns: ['translation'],
    where: 'text = ? AND language = ?',
    whereArgs: [text, language.name]
  );

  return res[0]['translation'].toString();

}