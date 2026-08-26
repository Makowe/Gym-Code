import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/classes/rulesets/lk1/ruleset_lk1.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:gym_code/constants/element_list_pommel_horse.dart';
import 'package:test/test.dart';

import '../constants/test_routines_pommel_horse.dart';

var ruleSet = Lk1RuleSet();

void main() {
  group('LK1 deviations from the general (Code of Points) ruleset', () {
    test('National ("NE") elements stay valid, unlike under Code of Points',
        () {
      ruleSet.markValidElements(routineNationalElementWithoutPredecessor);

      expect(
          routineNationalElementWithoutPredecessor.elements
              .map((e) => e.isValid),
          [true, true, true, true]);
    });

    test(
        'A group can contain more than 4 elements, unlike under Code of '
        'Points', () {
      // Group 1 has 5 elements (p_1_1, p_1_3, p_1_7, p_1_8, p_1_25); under
      // Code of Points the 5th one is invalidated, but LK1 does not limit
      // the number of elements per group.
      ruleSet.markValidElements(longRoutineWithDismount);

      expect(longRoutineWithDismount.elements.map((e) => e.isValid),
          List.filled(9, true));
    });

    test(
        'Group score is a flat bonus based on validity, not a tiered '
        'bonus based on the valued difficulty', () {
      ruleSet.evaluateRoutine(mediumRoutineWithDismount);

      expect(mediumRoutineWithDismount.result?.groups,
          {1: 0.5, 2: 0.5, 3: 0.5, 4: 0.2});
    });

    test('Difficulty values are capped at 0.8 instead of going up to 1.0', () {
      expect(ruleSet.difficultyValues['D'], 0.8);
      expect(ruleSet.difficultyValues['J'], 0.8);
      expect(RuleSet().difficultyValues['D'], 0.4);
      expect(RuleSet().difficultyValues['J'], 1.0);
    });

    test(
        'Penalty has no exemption for 6 or more valued elements, unlike '
        'under Code of Points', () {
      Routine routine = Routine(
          apparatus: Apparatus.pommelHorse,
          elements: [p_1_1, p_1_7, p_1_25, p_2_1, p_2_92, p_4_1]);
      Routine evaluatedByCop = routine.copy();
      Routine evaluatedByLk1 = routine.copy();

      RuleSet().evaluateRoutine(evaluatedByCop);
      ruleSet.evaluateRoutine(evaluatedByLk1);

      expect(evaluatedByCop.result?.penalty, 0.0);
      expect(evaluatedByLk1.result?.penalty, 2.0);
    });
  });
}
