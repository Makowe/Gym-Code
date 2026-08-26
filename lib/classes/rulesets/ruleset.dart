import 'package:gym_code/classes/routine_result.dart';

import '../invalid_element_reason.dart';
import '../routine.dart';
import '../routine_element.dart';
import '../routine_hint.dart';
import '../rulebook.dart';

/// Ruleset implementing the general rules of the Code of Points (see
/// reqs/ruleset.rst). Apparatus rulesets mix in apparatus-specific
/// deviations on top of this class or [Lk1RuleSet].
class RuleSet {
  static const int maxElementsBesideDismount = 7;
  static const List<String> possibleDifficulties = [
    'J',
    'I',
    'H',
    'G',
    'F',
    'E',
    'D',
    'C',
    'B',
    'A',
    'NE'
  ];

  /// Difficulties which are considered "low" (as opposed to "high",
  /// difficulty D and above) when scoring group 2 and 3.
  static const List<String> lowDifficulties = ['A', 'B', 'C'];

  static const Map<String, num> copDifficultyValues = {
    'NE': 0.0,
    'A': 0.1,
    'B': 0.2,
    'C': 0.3,
    'D': 0.4,
    'E': 0.5,
    'F': 0.6,
    'G': 0.7,
    'H': 0.8,
    'I': 0.9,
    'J': 1.0
  };

  /// Maps element difficulties to their D-Score value. Overridden by
  /// [Lk1RuleSet].
  Map<String, num> get difficultyValues => copDifficultyValues;

  static const List<int> normalGroups = [1, 2, 3];
  static const int dismountGroup = 4;
  static const num normalBonus = 0.5;
  static const num lowDifficultyBonus = 0.3;

  /// Whether a group-4 element which is not the routine's last element
  /// invalidates that element. Overridden by apparatuses (e.g. floor) for
  /// which group 4 does not represent dismounts.
  bool get checksMisplacedDismounts => true;

  /// Whether elements with difficulty "NE" are invalid. Overridden by
  /// [Lk1RuleSet], which allows national elements to be valued.
  bool get checksNationalElementsForbidden => true;

  /// Whether a group can contain at most 4 elements (see
  /// [tooManyElementsOfGroup]). Overridden by [Lk1RuleSet], which does not
  /// limit the number of elements per group.
  bool get checksTooManyElementsOfGroup => true;

  /// Groups preferentially fulfilled when a routine has too many elements
  /// of a given difficulty to value them all.
  List<int> get groupsToFulfill => normalGroups;

  /// Returns [threshold] or a lower (i.e. more difficult) difficulty.
  static bool isAtLeastDifficulty(String difficulty, String threshold) {
    return possibleDifficulties.indexOf(difficulty) <=
        possibleDifficulties.indexOf(threshold);
  }

  void evaluateRoutine(Routine routine) {
    markValidElements(routine);
    markValuedElements(routine);

    Map<String, int> numElements = countElements(routine);
    Map<int, num> groups = countGroups(routine);
    num difficulty = calcDifficulty(numElements, groups);
    num penalty = calcPenalty(routine);
    List<RoutineHint> hints = addHints(routine);

    routine.result = RoutineResult(
        dScore: difficulty,
        groups: groups,
        numElements: numElements,
        penalty: penalty,
        hints: hints);
  }

  /// Non-blocking hints about the routine, shown to the user alongside the
  /// score (as opposed to [InvalidElementReason], which invalidates an
  /// individual element).
  List<RoutineHint> addHints(Routine routine) {
    List<RoutineHint> hints = [
      routine.rules == Rulebook.lk1 ? RoutineHint.lk1 : RoutineHint.codeOfPoints
    ];
    if (routine.elements.isNotEmpty && findDismount(routine) == null) {
      hints.add(RoutineHint.missingDismount);
    }
    if (countValuedElementsBesideDismount(routine, findDismount(routine)) <
        maxElementsBesideDismount) {
      hints.add(RoutineHint.missingElements);
    }
    return hints;
  }

  void markValidElements(Routine routine) {
    /* Set all elements to valid by default */
    for (var element in routine.elements) {
      element.isValid = true;
      element.invalidReason = null;
    }

    if (checksMisplacedDismounts) {
      invalidateMisplacedDismounts(routine);
    }
    if (checksNationalElementsForbidden) {
      invalidateNationalElements(routine);
    }
    invalidateRepetitions(routine);
    if (checksTooManyElementsOfGroup) {
      invalidateTooManyElementsOfGroup(routine);
    }
  }

  /// Invalidates every dismount-group element which is not the routine's
  /// last element.
  void invalidateMisplacedDismounts(Routine routine) {
    for (int i = 0; i < routine.elements.length; i++) {
      RoutineElement element = routine.elements[i];
      if (element.isValid &&
          element.group == dismountGroup &&
          i != routine.elements.length - 1) {
        element.isValid = false;
        element.invalidReason = InvalidElementReason.dismountNotAtEnd;
      }
    }
  }

  /// Invalidates every valid element with difficulty "NE".
  void invalidateNationalElements(Routine routine) {
    for (var element in routine.elements) {
      if (element.isValid && element.difficulty == 'NE') {
        element.isValid = false;
        element.invalidReason = InvalidElementReason.nationalElementsForbidden;
      }
    }
  }

  /// Invalidates every valid element which repeats an earlier valid
  /// element (see [elementIsRepetition]).
  void invalidateRepetitions(Routine routine) {
    for (final (idx, element) in routine.elements.indexed) {
      if (element.isValid && elementIsRepetition(idx, routine)) {
        element.isValid = false;
        element.invalidReason = InvalidElementReason.repetition;
      }
    }
  }

  /// Invalidates every valid element which exceeds the maximum number of
  /// elements of its group (see [tooManyElementsOfGroup]).
  void invalidateTooManyElementsOfGroup(Routine routine) {
    // Elements to invalidate are collected first and only invalidated
    // afterwards so that the counts used by [tooManyElementsOfGroup] are
    // based on the state before this rule was applied to any element.
    List<RoutineElement> toInvalidate = [];
    for (final (idx, element) in routine.elements.indexed) {
      if (element.isValid && tooManyElementsOfGroup(idx, routine)) {
        toInvalidate.add(element);
      }
    }
    for (var element in toInvalidate) {
      element.isValid = false;
      element.invalidReason = InvalidElementReason.tooManyElementsOfGroup;
    }
  }

  /// Whether the element at [targetElementIdx] is invalid because too many
  /// other valid elements of the same group already outrank it: counting
  /// valid elements of the same group with a higher difficulty, plus valid
  /// elements of the same group and same difficulty at an earlier position,
  /// reaches or exceeds 4.
  bool tooManyElementsOfGroup(int targetElementIdx, Routine routine) {
    RoutineElement target = routine.elements[targetElementIdx];
    int targetDifficultyIdx = possibleDifficulties.indexOf(target.difficulty);

    int count = 0;
    for (final (idx, element) in routine.elements.indexed) {
      if (idx == targetElementIdx ||
          !element.isValid ||
          element.group != target.group) {
        continue;
      }
      int difficultyIdx = possibleDifficulties.indexOf(element.difficulty);
      bool higherDifficulty = difficultyIdx < targetDifficultyIdx;
      bool samePreviousDifficulty =
          difficultyIdx == targetDifficultyIdx && idx < targetElementIdx;
      if (higherDifficulty || samePreviousDifficulty) {
        count += 1;
      }
    }
    return count >= 4;
  }

  RoutineElement? findDismount(Routine routine) {
    if (routine.elements.isEmpty ||
        routine.elements.last.group != dismountGroup) {
      return null;
    }
    return routine.elements.last;
  }

  bool elementIsRepetition(int targetElementIdx, Routine routine) {
    for (final (idx, element) in routine.elements.indexed) {
      /* Iterate over elements until referenceElementIdx is reached because
       * only elements in front of reference element are from interest. */
      if (idx == targetElementIdx) {
        break;
      }
      if (element.isValid &&
          element.isEqualTo(routine.elements[targetElementIdx])) {
        return true;
      }
    }
    return false;
  }

  void markValuedElements(Routine routine) {
    // Set all elements to not valued
    for (var element in routine.elements) {
      element.isValued = false;
    }

    RoutineElement? dismount = findDismount(routine);
    int numValidElements = routine.getNumValidElements();
    int numValidElementsBesideDismount;

    // Set dismount to valued if it exists.
    if (dismount != null) {
      dismount.isValued = true;
      numValidElementsBesideDismount = numValidElements - 1;
    } else {
      numValidElementsBesideDismount = numValidElements;
    }

    // Find all residual valued elements. Dismount is excluded.
    if (numValidElementsBesideDismount < maxElementsBesideDismount) {
      // Routine is short. All valid elements should be valued.
      for (var element in routine.elements) {
        if (element.isValid) {
          element.isValued = true;
        }
      }
    } else {
      // Routine is too long. Only value the most difficult elements,
      // preferring ones which still fulfil an empty group.
      selectValuedElementsBesideDismount(routine, dismount);
    }
  }

  /// Sets [maxElementsBesideDismount] elements (besides [dismount]) to
  /// valued, going through difficulties from high to low. Whenever not all
  /// candidates of a difficulty fit into the remaining slots, elements
  /// which still fulfil an otherwise unfulfilled group are preferred.
  void selectValuedElementsBesideDismount(
      Routine routine, RoutineElement? dismount) {
    List<RoutineElement> valuedElements = [];
    if (dismount != null) {
      valuedElements.add(dismount);
    }

    for (var difficulty in possibleDifficulties) {
      if (valuedElements.length - (dismount != null ? 1 : 0) >=
          maxElementsBesideDismount) {
        return;
      }

      List<RoutineElement> candidates = routine.elements
          .where((element) =>
              element.isValid &&
              element != dismount &&
              element.difficulty == difficulty)
          .toList();
      if (candidates.isEmpty) {
        continue;
      }

      int numValuedBesideDismount =
          valuedElements.length - (dismount != null ? 1 : 0);
      int remainingSlots = maxElementsBesideDismount - numValuedBesideDismount;

      if (candidates.length <= remainingSlots) {
        for (var element in candidates) {
          element.isValued = true;
          valuedElements.add(element);
        }
        continue;
      }

      // Not all candidates fit: first fill still-unfulfilled groups, then
      // fill the remaining slots with the leftover candidates.
      for (var group in groupsToFulfill) {
        if (valuedElements.length - (dismount != null ? 1 : 0) >=
            maxElementsBesideDismount) {
          break;
        }
        bool groupFulfilled =
            valuedElements.any((element) => element.group == group);
        if (groupFulfilled) {
          continue;
        }

        RoutineElement? fulfilling;
        for (var candidate in candidates) {
          if (!candidate.isValued && candidate.group == group) {
            fulfilling = candidate;
            break;
          }
        }
        if (fulfilling != null) {
          fulfilling.isValued = true;
          valuedElements.add(fulfilling);
        }
      }

      for (var candidate in candidates) {
        if (valuedElements.length - (dismount != null ? 1 : 0) >=
            maxElementsBesideDismount) {
          break;
        }
        if (candidate.isValued) {
          continue;
        }
        candidate.isValued = true;
        valuedElements.add(candidate);
      }
    }
  }

  Map<String, int> countElements(Routine routine) {
    Map<String, int> result = {};
    for (var element in routine.elements) {
      if (element.isValued) {
        var oldNum = result[element.difficulty];
        if (oldNum == null) {
          result[element.difficulty] = 1;
        } else {
          result[element.difficulty] = oldNum += 1;
        }
      }
    }
    return result;
  }

  Map<int, num> countGroups(Routine routine) {
    Map<int, num> result = {1: 0.0, 2: 0.0, 3: 0.0, 4: 0.0};
    for (var group in normalGroups) {
      result[group] = scoreForNormalGroup(routine, group);
    }
    result[dismountGroup] = scoreForDismountGroup(routine);
    return result;
  }

  /// The group score for a non-dismount [group] (1, 2 or 3): group 1 scores
  /// [normalBonus] if it has any valued element; groups 2 and 3 score
  /// [normalBonus] if they have a valued element of difficulty D or higher,
  /// [lowDifficultyBonus] if they only have valued elements of difficulty A
  /// to C, and 0.0 otherwise.
  num scoreForNormalGroup(Routine routine, int group) {
    bool hasValuedElement = routine.elements
        .any((element) => element.isValued && element.group == group);
    if (!hasValuedElement) {
      return 0.0;
    }
    if (group == 1) {
      return normalBonus;
    }

    bool hasHighDifficulty = routine.elements.any((element) =>
        element.isValued &&
        element.group == group &&
        isAtLeastDifficulty(element.difficulty, 'D'));
    if (hasHighDifficulty) {
      return normalBonus;
    }

    bool hasLowDifficulty = routine.elements.any((element) =>
        element.isValued &&
        element.group == group &&
        lowDifficulties.contains(element.difficulty));
    return hasLowDifficulty ? lowDifficultyBonus : 0.0;
  }

  /// The group score for the dismount group: the dismount's difficulty
  /// score, or 0.0 if the routine has no dismount.
  num scoreForDismountGroup(Routine routine) {
    RoutineElement? dismount = findDismount(routine);
    if (dismount == null) {
      return 0.0;
    }
    return difficultyValues[dismount.difficulty]!;
  }

  num calcDifficulty(Map<String, int> numElements, Map<int, num> groups) {
    num difficulty = 0.0;
    for (var value in numElements.keys) {
      difficulty += difficultyValues[value]! * numElements[value]!;
    }
    for (var groupValue in groups.values) {
      difficulty += groupValue;
    }
    return difficulty;
  }

  num calcPenalty(Routine routine) {
    int numValuedElements = routine.getNumValuedElements();
    if (numValuedElements >= 6) {
      return 0.0;
    }
    return (8 - numValuedElements) * 1.0;
  }

  int countValuedElementsBesideDismount(
      Routine routine, RoutineElement? dismount) {
    int numValuedElements = 0;
    for (var element in routine.elements) {
      if (element.isValued && element != dismount) {
        numValuedElements += 1;
      }
    }
    return numValuedElements;
  }
}
