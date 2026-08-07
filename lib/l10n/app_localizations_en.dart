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
  String get routineInvalidTooManyDismounts =>
      'Invalid routine: too many dismounts';

  @override
  String get routineInvalidDismountNotAtEnd =>
      'Invalid routine: dismount not at the end';
}
