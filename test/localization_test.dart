import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_code/classes/invalid_routine_reason.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/l10n/app_localizations.dart';

/// Pumps a minimal app in [locale] and hands back its [AppLocalizations].
Future<AppLocalizations> localizationsFor(
    WidgetTester tester, Locale locale) async {
  late AppLocalizations l10n;
  await tester.pumpWidget(MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Builder(builder: (BuildContext context) {
      l10n = AppLocalizations.of(context);
      return const SizedBox();
    }),
  ));
  return l10n;
}

void main() {
  testWidgets('every supported locale resolves every message', (tester) async {
    for (final Locale locale in AppLocalizations.supportedLocales) {
      final AppLocalizations l10n = await localizationsFor(tester, locale);

      expect(l10n.localeName, locale.languageCode);
      expect(l10n.save, isNotEmpty);
      expect(l10n.allRoutines, isNotEmpty);
      expect(l10n.unnamedRoutine, isNotEmpty);
      expect(l10n.confirmDeleteRoutine('Floor A'), contains('Floor A'));
      expect(l10n.routineInvalidTooManyDismounts, isNotEmpty);
      expect(l10n.routineInvalidDismountNotAtEnd, isNotEmpty);
    }
  });

  testWidgets('translations actually differ between locales', (tester) async {
    final AppLocalizations en =
        await localizationsFor(tester, const Locale('en'));
    final String englishSave = en.save;

    final AppLocalizations de =
        await localizationsFor(tester, const Locale('de'));

    expect(englishSave, 'Save');
    expect(de.save, 'Speichern');
  });

  testWidgets('routine display name follows the active locale', (tester) async {
    final Routine unnamed = Routine(elements: []);

    final AppLocalizations en =
        await localizationsFor(tester, const Locale('en'));
    expect(unnamed.getDisplayName(en), 'Unnamed Routine');

    final AppLocalizations de =
        await localizationsFor(tester, const Locale('de'));
    expect(unnamed.getDisplayName(de), 'Unbenannte Übung');

    final Routine named = Routine(name: 'Kür', elements: []);
    expect(named.getDisplayName(de), 'Kür');
  });

  testWidgets('invalid-routine reason text follows the active locale',
      (tester) async {
    final Routine routine = Routine(elements: [])
      ..invalidReason = InvalidRoutineReason.tooManyDismounts;

    final AppLocalizations en =
        await localizationsFor(tester, const Locale('en'));
    expect(routine.getInvalidReasonText(en),
        'Invalid routine: too many dismounts');

    final AppLocalizations de =
        await localizationsFor(tester, const Locale('de'));
    expect(routine.getInvalidReasonText(de),
        'Ungültige Übung: Mehr als ein Abgang');

    routine.invalidReason = InvalidRoutineReason.dismountNotAtEnd;
    expect(routine.getInvalidReasonText(en),
        'Invalid routine: dismount not at the end');
    expect(routine.getInvalidReasonText(de),
        'Ungültige Übung: Abgang nicht am Ende');
  });
}
