import 'package:gym_code/classes/invalid_element_reason.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/classes/routine_hint.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:test/test.dart';

import 'constants/test_routines_pommel_horse.dart';

var ruleSet = RuleSet();

void main() {
  group('Basic Rule set Functions', () {
    test('Mark Valid Elements invalidates a dismount that is not at the end',
        () {
      ruleSet.markValidElements(routineDismountInMiddle);

      expect(routineDismountInMiddle.elements.map((e) => e.isValid),
          [true, false, true]);
      expect(routineDismountInMiddle.elements.map((e) => e.invalidReason),
          [null, InvalidElementReason.dismountNotAtEnd, null]);
    });

    test('Mark Valid Elements keeps only the last dismount valid', () {
      ruleSet.markValidElements(routineMultipleDismounts);

      expect(routineMultipleDismounts.elements.map((e) => e.isValid),
          [true, false, true]);
      expect(routineMultipleDismounts.elements.map((e) => e.invalidReason),
          [null, InvalidElementReason.dismountNotAtEnd, null]);
    });

    test('Evaluate Routine does not throw on an empty routine', () {
      ruleSet.evaluateRoutine(emptyRoutine);

      expect(emptyRoutine.result?.dScore, 0.0);
      expect(emptyRoutine.result?.penalty, 8.0);
    });

    test('Mark Valid Elements', () {
      List<Routine> routines = [
        shortRoutineNoDismount,
        shortRoutineWithDismount,
        longRoutineWithDismount,
        shortRoutineRepetition,
        multipleRepetitions
      ];

      List<List<bool>> expectedResult = [
        [true, true, true, true],
        [true, true, true, true, true],
        [true, true, true, true, true, true, true, true, true],
        [true, false],
        [true, true, false, false, false, true],
      ];

      for (int i = 0; i < routines.length; i++) {
        ruleSet.markValidElements(routines[i]);
        expect(routines[i].elements.map((e) => e.isValid), expectedResult[i]);
      }
    });

    test('Mark Valid Elements sets invalidReason on repetitions', () {
      ruleSet.markValidElements(shortRoutineRepetition);
      ruleSet.markValidElements(multipleRepetitions);

      expect(shortRoutineRepetition.elements.map((e) => e.invalidReason),
          [null, InvalidElementReason.repetition]);
      expect(multipleRepetitions.elements.map((e) => e.invalidReason), [
        null,
        null,
        InvalidElementReason.repetition,
        InvalidElementReason.repetition,
        InvalidElementReason.repetition,
        null
      ]);
    });

    test('Mark All Valued Elements', () {
      List<Routine> routinesAllValued = [
        shortRoutineNoDismount,
        shortRoutineWithDismount,
        mediumRoutineNoDismount,
        mediumRoutineWithDismount
      ];
      for (var routine in routinesAllValued) {
        ruleSet.markValidElements(routine);
        ruleSet.markValuedElements(routine);
        // all elements should be valued
        for (var element in routine.elements) {
          expect(element.isValued, true);
        }
      }
    });

    test('Do not Mark invalid Elements', () {
      ruleSet.markValidElements(shortRoutineNoDismount);
      shortRoutineNoDismount.elements[0].isValid = false;
      ruleSet.markValuedElements(shortRoutineNoDismount);

      expect(shortRoutineNoDismount.elements.map((e) => e.isValued),
          [false, true, true, true]);
    });

    test('Find Dismount', () {
      expect(ruleSet.findDismount(shortRoutineNoDismount), null);
      expect(ruleSet.findDismount(shortRoutineWithDismount),
          shortRoutineWithDismount.elements[4]);
    });

    test('Count valued elements beside dismount', () {
      // expect same result as in test above because there is no dismount
      for (var element in shortRoutineNoDismount.elements) {
        element.isValued = true;
      }

      expect(
          ruleSet.countValuedElementsBesideDismount(shortRoutineNoDismount,
              ruleSet.findDismount(shortRoutineNoDismount)),
          4);
      shortRoutineNoDismount.elements[1].isValued = false;
      expect(
          ruleSet.countValuedElementsBesideDismount(shortRoutineNoDismount,
              ruleSet.findDismount(shortRoutineNoDismount)),
          3);

      // expect different result because new routine contains a dismount
      for (var element in shortRoutineWithDismount.elements) {
        element.isValued = true;
      }
      RoutineElement? dismount = ruleSet.findDismount(shortRoutineWithDismount);

      expect(
          ruleSet.countValuedElementsBesideDismount(
              shortRoutineWithDismount, dismount),
          4);
      shortRoutineWithDismount.elements[1].isValued = false;
      expect(
          ruleSet.countValuedElementsBesideDismount(
              shortRoutineWithDismount, dismount),
          3);
      shortRoutineWithDismount.elements[4].isValued = false;
      expect(
          ruleSet.countValuedElementsBesideDismount(
              shortRoutineWithDismount, dismount),
          3);
    });

    test('Add Hints flags a routine without a dismount', () {
      expect(ruleSet.addHints(shortRoutineNoDismount),
          [RoutineHint.codeOfPoints, RoutineHint.missingDismount]);
      expect(ruleSet.addHints(shortRoutineWithDismount),
          [RoutineHint.codeOfPoints]);
    });

    test('Add Hints does not flag a missing dismount for an empty routine', () {
      expect(ruleSet.addHints(emptyRoutine), [RoutineHint.codeOfPoints]);
    });

    test('Evaluate Routine stores hints on the result', () {
      ruleSet.evaluateRoutine(shortRoutineNoDismount);
      expect(shortRoutineNoDismount.result?.hints,
          [RoutineHint.codeOfPoints, RoutineHint.missingDismount]);

      ruleSet.evaluateRoutine(shortRoutineWithDismount);
      expect(
          shortRoutineWithDismount.result?.hints, [RoutineHint.codeOfPoints]);
    });

    test('Mark highest elements in long routines', () {
      List<Routine> longRoutines = [
        longRoutineNoDismount,
        longRoutineWithDismount,
        longRoutineOtherOrder
      ];

      List<List<bool>> expectedResult = [
        [true, true, true, true, true, true, true, false],
        [true, true, true, true, true, true, true, false, true],
        [true, true, true, true, true, true, false, true, true],
      ];

      for (int i = 0; i < longRoutines.length; i++) {
        ruleSet.markValidElements(longRoutines[i]);
        ruleSet.markValuedElements(longRoutines[i]);
        expect(
            longRoutines[i].elements.map((e) => e.isValued), expectedResult[i]);
      }
    });
  });
}
