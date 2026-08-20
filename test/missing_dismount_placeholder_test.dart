import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/edit_routine.dart';
import 'package:gym_code/pages/view_routine.dart';
import 'package:gym_code/theme/theme.dart';

import 'constants/test_routines_pommel_horse.dart';

void main() {
  Future<void> pumpPage(WidgetTester tester, Widget page) async {
    // Uses the app's real theme (not a bare default MaterialApp theme)
    // because the pages rely on the WarningColors ThemeExtension.
    const MaterialTheme materialTheme = MaterialTheme(TextTheme());
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: materialTheme.light(),
      home: page,
    ));
  }

  group('ViewRoutine', () {
    testWidgets('shows the missing dismount placeholder when there is none',
        (tester) async {
      await pumpPage(
          tester, ViewRoutine(routine: shortRoutineNoDismount.copy()));

      expect(find.text('Missing dismount'), findsOneWidget);
    });

    testWidgets('hides the missing dismount placeholder when there is one',
        (tester) async {
      await pumpPage(
          tester, ViewRoutine(routine: shortRoutineWithDismount.copy()));

      expect(find.text('Missing dismount'), findsNothing);
    });
  });

  group('EditRoutine', () {
    testWidgets('shows the missing dismount placeholder when there is none',
        (tester) async {
      await pumpPage(
          tester,
          EditRoutine(
              routine: shortRoutineNoDismount.copy(), isNew: false));

      expect(find.text('Missing dismount'), findsOneWidget);
    });

    testWidgets('hides the missing dismount placeholder when there is one',
        (tester) async {
      await pumpPage(
          tester,
          EditRoutine(
              routine: shortRoutineWithDismount.copy(), isNew: false));

      expect(find.text('Missing dismount'), findsNothing);
    });

    testWidgets(
        'placeholder disappears after deleting the routine down to just '
        'the dismount', (tester) async {
      await pumpPage(
          tester,
          EditRoutine(
              routine: shortRoutineNoDismount.copy(), isNew: false));
      expect(find.text('Missing dismount'), findsOneWidget);

      // Delete every element; the placeholder should disappear once the
      // routine is empty (nothing to warn about yet).
      while (find.byIcon(Icons.delete).evaluate().isNotEmpty) {
        await tester.tap(find.byIcon(Icons.delete).first);
        await tester.pump();
      }

      expect(find.text('Missing dismount'), findsNothing);
    });
  });
}
