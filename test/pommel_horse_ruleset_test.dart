import 'package:gym_code/classes/invalid_element_reason.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:gym_code/classes/rulesets/ruleset_pommel_horse.dart';
import 'package:test/test.dart';

import 'constants/test_routines_pommel_horse.dart';

var ruleSet = PommelHorseRuleSet();

void main() {
  group('Pommel Horse specific Element Validity', () {
    test('Only the highest difficulty Flop stays valid', () {
      ruleSet.markValidElements(routineTwoFlops);

      expect(routineTwoFlops.elements.map((e) => e.isValid),
          [false, true, true, true]);
      expect(routineTwoFlops.elements.map((e) => e.invalidReason),
          [InvalidElementReason.tooManyFlops, null, null, null]);
    });

    test('Only the first Combination stays valid if difficulties are equal',
        () {
      ruleSet.markValidElements(routineTwoCombinationsSameDifficulty);

      expect(
          routineTwoCombinationsSameDifficulty.elements.map((e) => e.isValid),
          [true, false, true, true]);
      // pXFourWithTiedDifficulty (id p_x_4, difficulty D) ties with p_x_3;
      // the first of the two (p_x_3) stays valid.
      expect(
          routineTwoCombinationsSameDifficulty.elements
              .map((e) => e.invalidReason),
          [null, InvalidElementReason.tooManyCombinations, null, null]);
    });

    test(
        'National elements are invalid under Code of Points even with a '
        'matching predecessor', () {
      // Code of Points forbids all "NE" difficulty elements outright (see
      // reqs/ruleset.rst), so the predecessor rule (reqs/ruleset_pommel_horse.rst
      // / reqs/lk1/ruleset_lk1_pommel_horse.rst) never gets a chance to apply
      // here; it only matters for LK1 (see
      // test/lk1/pommel_horse_lk1_ruleset_test.dart).
      ruleSet.markValidElements(routineNationalElementWithPredecessor);

      expect(
          routineNationalElementWithPredecessor.elements.map((e) => e.isValid),
          [true, false, true, true]);
      expect(
          routineNationalElementWithPredecessor.elements
              .map((e) => e.invalidReason),
          [null, InvalidElementReason.nationalElementsForbidden, null, null]);
    });
  });

  group('Pommel Horse Ruleset inherits general Ruleset behavior', () {
    test('Routine validity, valuing and scoring match the general ruleset', () {
      var generalRuleSet = RuleSet();
      var evaluatedByGeneral = mediumRoutineWithDismount.copy();
      var evaluatedByPommel = mediumRoutineWithDismount.copy();

      generalRuleSet.evaluateRoutine(evaluatedByGeneral);
      ruleSet.evaluateRoutine(evaluatedByPommel);

      expect(evaluatedByPommel.elements.map((e) => e.isValued),
          evaluatedByGeneral.elements.map((e) => e.isValued));
      expect(
          evaluatedByPommel.result?.dScore, evaluatedByGeneral.result?.dScore);
      expect(evaluatedByPommel.result?.penalty,
          evaluatedByGeneral.result?.penalty);
    });
  });
}
