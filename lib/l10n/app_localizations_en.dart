// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get delete => 'Delete';

  @override
  String get keep => 'Keep';

  @override
  String get modify => 'Modify';

  @override
  String get close => 'Close';

  @override
  String get allRoutines => 'All Routines';

  @override
  String get settings => 'Settings';

  @override
  String get addElements => 'Add Elements';

  @override
  String get renameRoutine => 'Rename Routine';

  @override
  String get deleteRoutine => 'Delete Routine';

  @override
  String get language => 'Language';

  @override
  String get routine => 'Routine';

  @override
  String get unnamedRoutine => 'Unnamed Routine';

  @override
  String get newRoutine => 'New Routine';

  @override
  String get value => 'Value';

  @override
  String get group => 'Group';

  @override
  String get dValue => 'D Value';

  @override
  String get totalElements => 'Total Elements';

  @override
  String get countedElements => 'Counted Elements';

  @override
  String get dScore => 'D Score';

  @override
  String get penalty => 'Penalty';

  @override
  String get elementsByValue => 'Elements by Value';

  @override
  String get elements => 'Elements';

  @override
  String get groups => 'Groups';

  @override
  String get routineNameLabel => 'Routine name';

  @override
  String get elementAdded => 'Element added';

  @override
  String confirmDeleteRoutine(String routineName) {
    return 'Do you really want to delete the routine \"$routineName\"?';
  }

  @override
  String get elementInvalidRepetition =>
      'Invalid Element: The element was already shown.';

  @override
  String get elementInvalidTooManyFlops =>
      'Invalid Element: Only one flop per routine can be counted.';

  @override
  String get elementInvalidTooManyCombinations =>
      'Invalid Element: Only 1 Combination per routine can be counted';

  @override
  String get elementInvalidMissingPredecessor =>
      'Invalid: The element requires a specific predecessor element.';

  @override
  String get elementInvalidDismountNotAtEnd =>
      'Invalid Element: Dismounts must be the last element of the routine.';

  @override
  String get invalidElement => 'Invalid Element';

  @override
  String get allApparatuses => 'Apparatuses';

  @override
  String get apparatusFloor => 'Floor';

  @override
  String get apparatusPommelHorse => 'Pommel Horse';

  @override
  String get apparatusRings => 'Rings';

  @override
  String get apparatusVault => 'Vault';

  @override
  String get apparatusParallelBars => 'Parallel Bars';

  @override
  String get apparatusHorizontalBar => 'Horizontal Bar';
}
