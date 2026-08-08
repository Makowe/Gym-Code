import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../l10n/app_localizations.dart';

late Future<Database> futureDb;

const Locale _fallbackLocale = Locale('en');

/// Language names written in their own language, shown in the language picker.
const Map<String, String> localeDisplayNames = {
  'en': 'English',
  'de': 'Deutsch',
};

/// Values the pre-l10n settings format stored in the `language` setting.
const Map<String, String> _legacyLanguageNames = {
  'english': 'en',
  'german': 'de',
};

/// The locale the app currently renders in.
///
/// [MaterialApp] is rebuilt whenever this changes, so every screen already on
/// the navigation stack picks up a language switch immediately.
final ValueNotifier<Locale> localeNotifier =
    ValueNotifier<Locale>(_fallbackLocale);

Future<void> initSettingsDb() async {
  futureDb = openDatabase(join(await getDatabasesPath(), 'settings.db'),
      onCreate: _createTable, version: 1);
  await loadLocale();
}

String displayNameOf(Locale locale) =>
    localeDisplayNames[locale.languageCode] ?? locale.languageCode;

Future<void> loadLocale() async {
  final String stored = await _getSetting('language');
  final String code = _legacyLanguageNames[stored] ?? stored;

  localeNotifier.value = AppLocalizations.supportedLocales.firstWhere(
    (Locale locale) => locale.languageCode == code,
    orElse: () => _fallbackLocale,
  );
}

Future<void> updateLocale(Locale locale) async {
  localeNotifier.value = locale;
  await _updateSetting('language', locale.languageCode);
}

Future<void> _createTable(Database db, int version) async {
  await db.execute('CREATE TABLE settings('
      'setting TEXT,'
      'option TEXT)');

  await db.insert('settings',
      {'setting': 'language', 'option': _fallbackLocale.languageCode});
}

Future<String> _getSetting(String setting) async {
  Database db = await futureDb;
  List<Map<String, Object?>> res = await db.query('settings',
      columns: ['option'], where: 'setting = ?', whereArgs: [setting]);
  return res.isEmpty ? '' : res.first['option'].toString();
}

Future<void> _updateSetting(String setting, String option) async {
  Database db = await futureDb;
  await db.update('settings', {'setting': setting, 'option': option},
      where: 'setting = ?', whereArgs: [setting]);
}
