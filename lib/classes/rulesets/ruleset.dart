import 'dart:math';

import 'package:gym_code/classes/routine_result.dart';

import '../routine.dart';
import '../routine_element.dart';

class Ruleset {
  static const int maxElementsBesideDismount = 7;
  static const List<String> possibleDifficulties = [
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
  };

  void evaluateRoutine(Routine routine) {
    isRoutineValid(routine);
    if (!routine.isValid) {
      return;
    }

    markInvalidElements(routine);
    markValuedElements(routine);

    Map<String, int> numElements = countElements(routine);
    Map<int, num> groups = countGroups(routine);
    num difficulty = calcDifficulty(numElements, groups);
    num penalty = calcPenalty(routine);

    routine.result = RoutineResult(
        difficulty: difficulty,
        groups: groups,
        numElements: numElements,
        penalty: penalty);
  }

  void isRoutineValid(Routine routine) {
    if (routine.elements.isEmpty) {
      routine.isValid = false;
      routine.invalidText = "Übung enthält keine Elemente";
      return;
    }

    // Count number of dismounts
    int numDismounts = 0;
    routine.elements.forEach((element) {
      if (element.group == 4) {
        numDismounts += 1;
      }
    });

    if (numDismounts > 1) {
      // More than one dismount. Routine is invalid.
      routine.isValid = false;
      routine.invalidText = "Mehr als ein Abgang";
      return;
    }

    if (numDismounts == 1 && routine.elements.last.group != 4) {
      // Last element is not dismount. Routine is invalid.
      routine.isValid = false;
      routine.invalidText = "Abgang nicht am Ende";
      return;
    }
    routine.isValid = true;
  }

  void markInvalidElements(Routine routine) {
    /* TODO: implement function. Mark repetitions, etc. */
  }

  void markValuedElements(Routine routine) {
    // Set all elements to not valued
    routine.elements.forEach((element) {
      element.isValued = false;
    });

    int numValidElementsBesideDismount = routine.getNumValidElements();

    // Add dismount if it exists
    if (routine.elements.last.group == 4) {
      routine.elements.last.isValued = true;
      numValidElementsBesideDismount -= 1;
    }

    // Holds the number of elements which are currently set to valued.
    // Dismount is excluded.
    int currentValuedElements = 0;

    // Holds the number of total elements that should be valued. Dismount
    // is excluded.
    int targetValuedElements =
        min(maxElementsBesideDismount, numValidElementsBesideDismount);
    for (var value in possibleDifficulties) {
      for (var element in routine.elements) {
        if (currentValuedElements >= targetValuedElements) {
          break;
        }

        if (element.difficulty == value) {
          element.isValued = true;
          currentValuedElements += 1;
        }
      }
      if (currentValuedElements >= targetValuedElements) {
        break;
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
    print(result);
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
    RoutineElement? dismount = routine.getDismount();
    if (dismount != null) {
      result[dismountGroup] = dismountBonus[dismount.difficulty]!;
    }
    print(result);
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
    print('Difficulty: $difficulty');
    return difficulty;
  }

  num calcPenalty(Routine routine) {
    num penalty = 0.0;
    if (routine.getDismount() == null) {
      penalty += 1.0;
    }
    penalty += maxElementsBesideDismount -
        routine.getNumValuedElementsBesideDismount();
    print('Penalty: $penalty');
    return penalty;
  }
}
