import 'package:gym_code/classes/rulesets/lk1/ruleset_lk1_floor.dart';
import 'package:test/test.dart';

import '../constants/test_routines_floor.dart';

var ruleSet = FloorRuleSetLk1();

void main() {
  group('Floor LK1 specific Dismount Identification', () {
    test('Last element of group 3 is the dismount', () {
      expect(ruleSet.findDismount(routineDismountInGroupThree),
          routineDismountInGroupThree.elements[2]);
    });

    test('Routine has no dismount if the last element is group 1', () {
      expect(ruleSet.findDismount(routineLastElementGroupOne), null);
    });
  });

  group('Floor LK1 Ruleset full evaluation', () {
    test('National elements stay valid, unlike under Code of Points', () {
      ruleSet.evaluateRoutine(mediumRoutineWithDismount);

      expect(mediumRoutineWithDismount.elements.map((e) => e.isValued),
          [true, true, true, true, true, true]);
      expect(mediumRoutineWithDismount.result?.groups,
          {1: 0.5, 2: 0.5, 3: 0.5, 4: 0.0});
      expect(mediumRoutineWithDismount.result?.dScore, closeTo(2.5, 1e-9));
      expect(mediumRoutineWithDismount.result?.penalty, 2.0);
    });

    test(
        'Group 4 scores the flat LK1 bonus (no difficulty tiers) even '
        'without a group 4 dismount', () {
      ruleSet.evaluateRoutine(routineWithGroupFourNonDismount);

      expect(routineWithGroupFourNonDismount.result?.groups,
          {1: 0.5, 2: 0.5, 3: 0.5, 4: 0.5});
      expect(
          routineWithGroupFourNonDismount.result?.dScore, closeTo(3.0, 1e-9));
      expect(routineWithGroupFourNonDismount.result?.penalty, 4.0);
    });
  });
}
