import 'package:gym_code/classes/invalid_element_reason.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:gym_code/classes/rulesets/ruleset_rings.dart';
import 'package:test/test.dart';

import 'constants/test_routines_rings.dart';

var ruleSet = RingsRuleSet();

void main() {
  group('Rings Ruleset inherits general Ruleset behavior', () {
    test('Dismount not at the end is invalidated', () {
      ruleSet.markValidElements(routineDismountInMiddle);

      expect(routineDismountInMiddle.elements.map((e) => e.isValid),
          [true, false, true]);
      expect(routineDismountInMiddle.elements.map((e) => e.invalidReason),
          [null, InvalidElementReason.dismountNotAtEnd, null]);
    });

    test('Repetition is invalidated', () {
      ruleSet.markValidElements(routineRepetition);

      expect(routineRepetition.elements.map((e) => e.isValid), [true, false]);
      expect(routineRepetition.elements.map((e) => e.invalidReason),
          [null, InvalidElementReason.repetition]);
    });

    test('Routine validity, valuing and scoring match the general ruleset',
        () {
      var generalRuleSet = RuleSet();
      var evaluatedByGeneral = mediumRoutineWithDismount.copy();
      var evaluatedByRings = mediumRoutineWithDismount.copy();

      generalRuleSet.evaluateRoutine(evaluatedByGeneral);
      ruleSet.evaluateRoutine(evaluatedByRings);

      expect(evaluatedByRings.elements.map((e) => e.isValued),
          evaluatedByGeneral.elements.map((e) => e.isValued));
      expect(
          evaluatedByRings.result?.dScore, evaluatedByGeneral.result?.dScore);
      expect(evaluatedByRings.result?.groups, evaluatedByGeneral.result?.groups);
      expect(evaluatedByRings.result?.penalty,
          evaluatedByGeneral.result?.penalty);
    });
  });
}
