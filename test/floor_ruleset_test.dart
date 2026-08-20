import 'package:gym_code/classes/invalid_element_reason.dart';
import 'package:gym_code/classes/rulesets/ruleset_floor.dart';
import 'package:test/test.dart';

import 'constants/test_routines_floor.dart';

var ruleSet = FloorRuleSet();

void main() {
  group('Floor specific Dismount Identification', () {
    test('Last element of group 3 is the dismount', () {
      expect(ruleSet.findDismount(routineDismountInGroupThree),
          routineDismountInGroupThree.elements[2]);
    });

    test('Routine has no dismount if the last element is group 1', () {
      expect(ruleSet.findDismount(routineLastElementGroupOne), null);
    });

    test(
        'Routine has no dismount if the last element is a designated '
        'no-dismount id', () {
      expect(ruleSet.findDismount(routineLastElementIsNoDismountId), null);
    });

    test('Empty routine has no dismount', () {
      expect(ruleSet.findDismount(emptyRoutine), null);
    });
  });

  group('Floor specific Element Validity', () {
    test('Dismount not at the end rule does not apply to floor', () {
      // The general ruleset would invalidate a group-4 element that is not
      // last; floor never invalidates for this reason since group 4 is not
      // treated as a dismount marker.
      ruleSet.markValidElements(routineWithGroupFourNonDismount);

      expect(routineWithGroupFourNonDismount.elements.map((e) => e.isValid),
          [true, true, true, true]);
    });

    test(
        'An earlier element sharing the dismount\'s id is invalidated, '
        'the dismount itself stays valid', () {
      ruleSet.markValidElements(routineEarlierElementRepeatsDismount);

      expect(
          routineEarlierElementRepeatsDismount.elements.map((e) => e.isValid),
          [true, false, true, true]);
      expect(
          routineEarlierElementRepeatsDismount.elements
              .map((e) => e.invalidReason),
          [null, InvalidElementReason.repetition, null, null]);
    });
  });

  group('Floor specific Group Scoring', () {
    test('Group 4 scores the presence bonus even without a group 4 dismount',
        () {
      ruleSet.evaluateRoutine(routineWithGroupFourNonDismount);

      expect(routineWithGroupFourNonDismount.result?.groups,
          {1: 0.5, 2: 0.5, 3: 0.5, 4: 0.5});
      expect(routineWithGroupFourNonDismount.result?.dScore, 3.0);
      expect(routineWithGroupFourNonDismount.result?.penalty, 4.0);
    });
  });

  group('Floor Ruleset full evaluation', () {
    test('Routine with a dismount in group 3', () {
      ruleSet.evaluateRoutine(mediumRoutineWithDismount);

      expect(mediumRoutineWithDismount.elements.map((e) => e.isValued),
          [true, true, true, true, true, true]);
      expect(mediumRoutineWithDismount.result?.groups,
          {1: 0.5, 2: 0.5, 3: 0.5, 4: 0.0});
      expect(mediumRoutineWithDismount.result?.dScore, 2.5);
      expect(mediumRoutineWithDismount.result?.penalty, 2.0);
    });

    test('Evaluate Routine does not throw on an empty routine', () {
      ruleSet.evaluateRoutine(emptyRoutine);

      expect(emptyRoutine.result?.dScore, 0.0);
      expect(emptyRoutine.result?.penalty, 8.0);
    });
  });
}
