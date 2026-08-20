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

    test('National element stays valid if predecessor matches', () {
      ruleSet.markValidElements(routineNationalElementWithPredecessor);

      expect(
          routineNationalElementWithPredecessor.elements.map((e) => e.isValid),
          [true, true, true, true]);
    });

    test('National element is invalidated if predecessor does not match', () {
      ruleSet.markValidElements(routineNationalElementWithoutPredecessor);

      expect(
          routineNationalElementWithoutPredecessor.elements
              .map((e) => e.isValid),
          [true, true, false, true]);
      expect(
          routineNationalElementWithoutPredecessor.elements
              .map((e) => e.invalidReason),
          [null, null, InvalidElementReason.missingPredecessor, null]);
    });

    test('National element accepts any of its alternative predecessors', () {
      ruleSet
          .markValidElements(routineNationalElementWithAlternativePredecessor);

      expect(
          routineNationalElementWithAlternativePredecessor.elements
              .map((e) => e.isValid),
          [true, true, true, true]);
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
