import 'package:gym_code/classes/invalid_element_reason.dart';
import 'package:gym_code/classes/rulesets/lk1/ruleset_lk1_pommel_horse.dart';
import 'package:test/test.dart';

import '../constants/test_routines_pommel_horse.dart';

var ruleSet = PommelHorseRuleSetLk1();

void main() {
  group('Pommel Horse LK1 specific Element Validity', () {
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
}
