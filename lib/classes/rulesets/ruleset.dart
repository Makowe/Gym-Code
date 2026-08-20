import 'package:gym_code/classes/routine_result.dart';

import '../invalid_element_reason.dart';
import '../routine.dart';
import '../routine_element.dart';

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

  static const Map<String, num> difficultyValues = {
    'NE': 0.0,
    'A': 0.2,
    'B': 0.4,
    'C': 0.6,
    'D': 0.8,
    'E': 0.8,
    'F': 0.8,
    'G': 0.8,
    'H': 0.8,
    'I': 0.8,
    'J': 0.8
  };
  static const List<int> normalGroups = [1, 2, 3];
  static const int dismountGroup = 4;
  static const num normalBonus = 0.5;
  static const Map<String, num> dismountBonus = {
    'NE': 0.0,
    'A': 0.0,
    'B': 0.3,
    'C': 0.5,
    'D': 0.5,
    'E': 0.5,
    'F': 0.5,
    'G': 0.5,
    'H': 0.5,
    'I': 0.5,
    'J': 0.5
  };

  void evaluateRoutine(Routine routine) {
    markValidElements(routine);
    markValuedElements(routine);

    Map<String, int> numElements = countElements(routine);
    Map<int, num> groups = countGroups(routine);
    num difficulty = calcDifficulty(numElements, groups);
    num penalty = calcPenalty(routine);

    routine.result = RoutineResult(
        dScore: difficulty,
        groups: groups,
        numElements: numElements,
        penalty: penalty);
  }

  void markValidElements(Routine routine) {
    /* Set all elements to valid by default */
    for (var element in routine.elements) {
      element.isValid = true;
    }

    invalidateMisplacedDismounts(routine);

    for (final (idx, element) in routine.elements.indexed) {
      if (elementIsRepetition(idx, routine)) {
        element.isValid = false;
        element.invalidReason = InvalidElementReason.repetition;
      }
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

  RoutineElement? findDismount(Routine routine) {
    if (routine.elements.isEmpty || routine.elements.last.group != dismountGroup) {
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
      if (element.isValid && element.isEqualTo(routine.elements[targetElementIdx])) {
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
    if (numValidElementsBesideDismount <= maxElementsBesideDismount) {
      // Routine is short. All valid elements should be valued.
      for (var element in routine.elements) {
        if (element.isValid) {
          element.isValued = true;
        }
      }
    } else {
      // Routine is too long. Only value the most difficult elements.
      List<RoutineElement> difficultElements = findMostDifficultElements(
          routine, maxElementsBesideDismount, dismount);
      for (var difficultElement in difficultElements) {
        difficultElement.isValued = true;
      }
    }
  }

  List<RoutineElement> findMostDifficultElements(
      Routine routine, numElements, RoutineElement? dismount) {
    List<RoutineElement> result = [];

    for (var difficulty in possibleDifficulties) {
      for (var element in routine.elements) {
        if (result.length >= numElements) {
          break;
        }

        if (element.isValid == true && element.difficulty == difficulty && element != dismount) {
          result.add(element);
        }
      }
    }
    return result;
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

    // count normal groups
    for (var group in normalGroups) {
      var elementIdx =
          routine.elements.indexWhere((element) => element.group == group);
      if (elementIdx != -1) {
        result[group] = normalBonus;
      }
    }

    // count dismount group
    RoutineElement? dismount = findDismount(routine);
    if (dismount != null) {
      result[dismountGroup] = dismountBonus[dismount.difficulty]!;
    }
    return result;
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
    num penalty = 0.0;
    RoutineElement? dismount = findDismount(routine);
    if (dismount == null) {
      penalty += 1.0;
    }
    penalty += maxElementsBesideDismount -
        countValuedElementsBesideDismount(routine, dismount);
    return penalty;
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
