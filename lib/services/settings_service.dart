import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Future<Database> futureDb;

Future<void> initSettingsDb() async {
  futureDb = openDatabase(join(await getDatabasesPath(), 'settings.db'),
      onCreate: _createTable, version: 1);
  await loadLanguage();
}

enum Language {
  english('english', 'English'),
  german('german', 'Deutsch');

  const Language(this.name, this.displayName);
  final String name;
  final String displayName;
}

late Language currentLanguage;

Language getLanguage() {
  return currentLanguage;
}

Future<void> loadLanguage() async {
  String languageString = await _getSetting('language');

  for(Language language in Language.values) {
    if(language.name == languageString) {
      currentLanguage = language;
      return;
    }
  }
  currentLanguage = Language.english;
}

Future<void> updateLanguage(Language language) async {
  currentLanguage = language;
  await _updateSetting('language', language.name);
}


Future<void> _createTable(Database db, int version) async {
  await db.execute('CREATE TABLE settings('
      'setting TEXT,'
      'option TEXT)');

  await db.insert('settings', {'setting': 'language', 'option': 'english'});
}

Future<String> _getSetting(String setting) async {
  Database db = await futureDb;
  List<Map<String, Object?>> res = await db.query('settings', columns: ['option'], where: 'setting = ?', whereArgs: [setting]);
  return res[0]['option'].toString();
}


Future<void> _updateSetting(String setting, String option) async {
  Database db = await futureDb;
  db.update(
    'settings',
    {'setting': setting, 'option': option},
    where: 'setting = ?',
    whereArgs: [setting]
  );
}