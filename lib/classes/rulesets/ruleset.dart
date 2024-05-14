import 'package:gym_code/classes/routine_result.dart';

import '../routine.dart';
import '../routine_element.dart';

class RuleSet {
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
    calcRoutineValidity(routine);
    if (!routine.isValid) {
      routine.result = null;
      return;
    }
    if(routine.elements.isEmpty) {
      routine.result = RoutineResult(
          dScore: 0.0,
          penalty: 10.0);
      return;
    }

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

  void calcRoutineValidity(Routine routine) {
    // Count number of dismounts
    int numDismounts = 0;
    for (var element in routine.elements) {
      if (element.group == 4) {
        numDismounts += 1;
      }
    }

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

  void markValidElements(Routine routine) {

    // Set all elements to invalid
    for (var element in routine.elements) {
      element.isValid = false;
    }

    List<RoutineElement> validElements = [];

    // Set dismount to valid if it exists.
    if (routine.elements.last.group == dismountGroup) {
      routine.elements.last.isValid = true;
      validElements.add(routine.elements.last);
    }

    // mark residual elements
    for (var element in routine.elements) {
      if (!elementIsRepetition(element, validElements)) {
        element.isValid = true;
        validElements.add(element);
      }
    }
  }

  bool elementIsRepetition(
      RoutineElement element, List<RoutineElement> validElements) {
    bool result = false;
    for (var validElement in validElements) {
      if (element.isEqualTo(validElement)) {
        result = true;
        break;
      }
    }
    return result;
  }

  void markValuedElements(Routine routine) {
    // Set all elements to not valued
    for (var element in routine.elements) {
      element.isValued = false;
    }

    int numValidElements = routine.getNumValidElements();
    int numValidElementsBesideDismount;

    // Set dismount to valued if it exists.
    if (routine.elements.last.group == dismountGroup) {
      routine.elements.last.isValued = true;
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
      List<RoutineElement> difficultElements =
          findMostDifficultElements(routine, maxElementsBesideDismount);
      for (var difficultElement in difficultElements) {
        difficultElement.isValued = true;
      }
    }
  }

  List<RoutineElement> findMostDifficultElements(Routine routine, numElements) {
    List<RoutineElement> result = [];

    for (var difficulty in possibleDifficulties) {
      for (var element in routine.elements) {
        if (result.length >= numElements) {
          break;
        }
        if (element.difficulty == difficulty &&
            element.group != dismountGroup) {
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
    RoutineElement? dismount = routine.getDismount();
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
    return difficulty ;
  }

  num calcPenalty(Routine routine) {
    num penalty = 0.0;
    if (routine.getDismount() == null) {
      penalty += 1.0;
    }
    penalty += maxElementsBesideDismount -
        routine.getNumValuedElementsBesideDismount();
    return penalty;
  }
}
