import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/add_elements.dart';

void main() {
  Future<void> pumpAddElements(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: AddElements(apparatus: Apparatus.pommelHorse),
    ));
  }

  testWidgets("'F+' filter shows difficulty F and G, hides D and E",
      (tester) async {
    await pumpAddElements(tester);

    await tester.tap(find.widgetWithText(ChoiceChip, 'F+'));
    await tester.pump();

    expect(find.text('F Combination'), findsOneWidget);
    expect(find.text('G Combination'), findsOneWidget);
    expect(find.text('D Combination'), findsNothing);
    expect(find.text('E Combination'), findsNothing);
  });

  testWidgets('no filter selected shows every difficulty', (tester) async {
    await pumpAddElements(tester);

    expect(find.text('D Combination'), findsOneWidget);
    expect(find.text('F Combination'), findsOneWidget);
    expect(find.text('G Combination'), findsOneWidget);
  });
}
