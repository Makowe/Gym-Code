import '../invalid_element_reason.dart';
import '../routine.dart';
import '../routine_element.dart';
import 'ruleset.dart';

/// Ruleset for the pommel horse. Inherits routine validity, valued-element
/// selection, difficulty/group scoring and penalty from [RuleSet] and only
/// adds apparatus-specific element validity rules (see
/// reqs/ruleset_pommel_horse.rst).
class PommelHorseRuleSet extends RuleSet {
  static const List<String> flopIds = ['p_x_1', 'p_x_2'];
  static const List<String> combinationIds = [
    'p_x_3',
    'p_x_4',
    'p_x_5',
    'p_x_6'
  ];

  /// Maps a national element to the ids of the elements which are allowed
  /// to directly precede it.
  static const Map<String, List<String>> nationalPredecessors = {
    'p_n_1': ['p_1_1'],
    'p_n_2': ['p_1_25'],
    'p_n_9': ['p_2_1', 'p_n_10'],
  };

  @override
  void markValidElements(Routine routine) {
    super.markValidElements(routine);

    invalidateAllButHighestDifficulty(
        routine, flopIds, InvalidElementReason.tooManyFlops);
    invalidateAllButHighestDifficulty(
        routine, combinationIds, InvalidElementReason.tooManyCombinations);
    invalidateElementsWithMissingPredecessor(routine);
  }

  /// Among the currently valid elements of the routine whose id is in [ids],
  /// keeps only the one with the highest difficulty valid (the first of them
  /// in case of a tie) and invalidates the rest, setting their
  /// [RoutineElement.invalidReason] to [reason].
  void invalidateAllButHighestDifficulty(
      Routine routine, List<String> ids, InvalidElementReason reason) {
    List<RoutineElement> candidates = routine.elements
        .where((element) => element.isValid && ids.contains(element.id))
        .toList();

    if (candidates.length <= 1) {
      return;
    }

    RoutineElement best = candidates.first;
    for (var candidate in candidates.skip(1)) {
      if (RuleSet.possibleDifficulties.indexOf(candidate.difficulty) <
          RuleSet.possibleDifficulties.indexOf(best.difficulty)) {
        best = candidate;
      }
    }

    for (var candidate in candidates) {
      if (candidate != best) {
        candidate.isValid = false;
        candidate.invalidReason = reason;
      }
    }
  }

  /// Invalidates valid elements which require a specific direct predecessor
  /// (see [nationalPredecessors]) if that predecessor is not the element
  /// directly before them in the routine.
  void invalidateElementsWithMissingPredecessor(Routine routine) {
    for (int i = 0; i < routine.elements.length; i++) {
      RoutineElement element = routine.elements[i];
      if (!element.isValid) {
        continue;
      }

      List<String>? requiredPredecessors = nationalPredecessors[element.id];
      if (requiredPredecessors == null) {
        continue;
      }

      String? previousId = i > 0 ? routine.elements[i - 1].id : null;
      if (!requiredPredecessors.contains(previousId)) {
        element.isValid = false;
        element.invalidReason = InvalidElementReason.missingPredecessor;
      }
    }
  }
}
