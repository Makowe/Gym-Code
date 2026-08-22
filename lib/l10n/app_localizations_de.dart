// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get delete => 'Löschen';

  @override
  String get keep => 'Behalten';

  @override
  String get modify => 'Bearbeiten';

  @override
  String get close => 'Schließen';

  @override
  String get allRoutines => 'Alle Übungen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get addElements => 'Elemente hinzufügen';

  @override
  String get routineSettings => 'Übungseinstellungen';

  @override
  String get deleteRoutine => 'Übung löschen';

  @override
  String get language => 'Sprache';

  @override
  String get theme => 'Design';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get routine => 'Übung';

  @override
  String get unnamedRoutine => 'Unbenannte Übung';

  @override
  String get newRoutine => 'Neue Übung';

  @override
  String get value => 'Wert';

  @override
  String get group => 'Gruppe';

  @override
  String get dValue => 'D-Wert';

  @override
  String get totalElements => 'Geturnte Elemente';

  @override
  String get countedElements => 'Gezählte Elemente';

  @override
  String get dScore => 'D-Note';

  @override
  String get penalty => 'Penalty';

  @override
  String get dScoreAbbrev => 'D';

  @override
  String get penaltyAbbrev => 'Pen';

  @override
  String get elementsByValue => 'Elemente nach Wert';

  @override
  String get elements => 'Elemente';

  @override
  String get groups => 'Gruppen';

  @override
  String get routineNameLabel => 'Übungsname';

  @override
  String get elementAdded => 'Element hinzugefügt';

  @override
  String confirmDeleteRoutine(String routineName) {
    return 'Soll die Übung \"$routineName\" wirklich gelöscht werden?';
  }

  @override
  String get elementInvalidRepetition =>
      'Element Ungültig: Das Element wurde bereits gezeigt.';

  @override
  String get elementInvalidTooManyFlops =>
      'Element Ungültig: Es kann nur ein Flop pro Übung gewertet werden.';

  @override
  String get elementInvalidTooManyCombinations =>
      'Element Ungültig: Es kann nur eine Kombination pro Übung gewertet werden.';

  @override
  String get elementInvalidMissingPredecessor =>
      'Element Ungültig: Element kann nur in direkter Folge mit einem anderen Element geturnt werden.';

  @override
  String get elementInvalidDismountNotAtEnd =>
      'Element Ungültig: Abgänge müssen das letzte Element der Übung sein.';

  @override
  String get elementInvalidTooManyStrengthElementsInARow =>
      'Element Ungültig: Mehr als 3 Kraftelemente hintereinander.';

  @override
  String get invalidElement => 'Ungültiges Element';

  @override
  String get routineMissingDismount => 'Abgang fehlt';

  @override
  String get missingElements => 'Zu wenig Elemente';

  @override
  String get codeOfPoints => 'Code de Pointage (2025-28)';

  @override
  String get codeOfPointsShort => 'CdP (25-28)';

  @override
  String get lk1 => 'Kür modifiziert LK1 (2025-28)';

  @override
  String get lk1short => 'LK1 (25-28)';

  @override
  String get rulebook => 'Regelwerk';

  @override
  String get allApparatuses => 'Geräte';

  @override
  String get apparatusFloor => 'Boden';

  @override
  String get apparatusPommelHorse => 'Pauschenpferd';

  @override
  String get apparatusRings => 'Ringe';

  @override
  String get apparatusVault => 'Sprung';

  @override
  String get apparatusParallelBars => 'Barren';

  @override
  String get apparatusHorizontalBar => 'Reck';
}
