import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/add_elements.dart';
import 'package:gym_code/pages/edit_routine.dart';
import 'package:gym_code/pages/view_routine.dart';
import 'package:gym_code/theme/theme.dart';
import 'package:gym_code/widgets/button_group.dart';
import 'package:gym_code/widgets/routine_result_card.dart';

import 'constants/test_routines_pommel_horse.dart';

void main() {
  const double bottomInsetPhysical = 96.0; // simulated Android gesture bar

  Future<void> pumpWithBottomInset(WidgetTester tester, Widget page) async {
    tester.view.padding = const FakeViewPadding(bottom: bottomInsetPhysical);
    addTearDown(() => tester.view.resetPadding());

    const MaterialTheme materialTheme = MaterialTheme(TextTheme());
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: materialTheme.light(),
      home: page,
    ));
    await tester.pumpAndSettle();
  }

  double logicalBottomInset(WidgetTester tester) =>
      bottomInsetPhysical / tester.view.devicePixelRatio;

  double screenHeight(WidgetTester tester) =>
      tester.view.physicalSize.height / tester.view.devicePixelRatio;

  testWidgets('ViewRoutine: RoutineResultCard clears the bottom system inset',
      (tester) async {
    await pumpWithBottomInset(
        tester, ViewRoutine(routine: shortRoutineWithDismount.copy()));

    final Rect cardRect = tester.getRect(find.byType(RoutineResultCard));
    expect(
        cardRect.bottom,
        lessThanOrEqualTo(
            screenHeight(tester) - logicalBottomInset(tester) + 0.5));
  });

  testWidgets(
      // RoutineResultCard, not ButtonGroup, is the bottom-most widget here:
      // the button group was deliberately placed above it (see git history).
      'EditRoutine: RoutineResultCard clears the bottom system inset',
      (tester) async {
    await pumpWithBottomInset(tester,
        EditRoutine(routine: shortRoutineWithDismount.copy(), isNew: false));

    final Rect cardRect = tester.getRect(find.byType(RoutineResultCard));
    expect(
        cardRect.bottom,
        lessThanOrEqualTo(
            screenHeight(tester) - logicalBottomInset(tester) + 0.5));
  });

  testWidgets('AddElements: ButtonGroup clears the bottom system inset',
      (tester) async {
    await pumpWithBottomInset(
        tester, const AddElements(apparatus: Apparatus.pommelHorse));

    final Rect groupRect = tester.getRect(find.byType(ButtonGroup));
    expect(
        groupRect.bottom,
        lessThanOrEqualTo(
            screenHeight(tester) - logicalBottomInset(tester) + 0.5));
  });
}
