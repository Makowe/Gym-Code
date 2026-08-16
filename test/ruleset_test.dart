import 'package:gym_code/classes/invalid_element_reason.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:test/test.dart';

import 'constants/test_routines_pommel_horse.dart';

var ruleSet = RuleSet();

void main() {
  group('Basic Rule set Functions', () {
    test('Evaluate Routine Validity', () {
      ruleSet.calcRoutineValidity(emptyRoutine);
      ruleSet.calcRoutineValidity(routineDismountInMiddle);
      ruleSet.calcRoutineValidity(routineMultipleDismounts);
      ruleSet.calcRoutineValidity(shortRoutineNoDismount);

      expect(emptyRoutine.isValid, true);
      expect(routineDismountInMiddle.isValid, false);
      expect(routineMultipleDismounts.isValid, false);
      expect(shortRoutineNoDismount.isValid, true);
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
