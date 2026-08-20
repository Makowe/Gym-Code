import '../invalid_element_reason.dart';
import '../routine.dart';
import '../routine_element.dart';
import 'ruleset.dart';

class FloorRuleSet extends RuleSet {
  static const List<int> allGroups = [1, 2, 3, 4];
  static const int forbiddenDismountGroup = 1;
  static const List<String> forbiddenDismountIds = ['f_2_7', 'f_2_38', 'f_3_31'];

  @override
  RoutineElement? findDismount(Routine routine) {
    if (routine.elements.isEmpty) {
      return null;
    }
    RoutineElement last = routine.elements.last;
    if (last.group == forbiddenDismountGroup || forbiddenDismountIds.contains(last.id)) {
      return null;
    }
    return last;
  }

  @override
  void markValidElements(Routine routine) {
    /* Set all elements to valid by default */
    for (var element in routine.elements) {
      element.isValid = true;
    }

    for (final (idx, element) in routine.elements.indexed) {
      if (elementIsRepetition(idx, routine)) {
        element.isValid = false;
        element.invalidReason = InvalidElementReason.repetition;
      }
    }
  }

  @override
  bool elementIsRepetition(int targetElementIdx, Routine routine) {
    RoutineElement? dismount = findDismount(routine);
    RoutineElement targetElement = routine.elements[targetElementIdx];

    if(targetElement == dismount) {
      // dismount can never be repetition as it is counted first.
      return false;
    }

    if(dismount != null && targetElement.isEqualTo(dismount))
    {
      // element is same as dismount -> repetition
      return true;
    }
    // check all previously shown elements for repetition.
    return super.elementIsRepetition(targetElementIdx, routine);
  }

  @override
  Map<int, num> countGroups(Routine routine) {
    Map<int, num> result = {1: 0.0, 2: 0.0, 3: 0.0, 4: 0.0};

    // Deviation from general ruleset: group 4 is scored the same way as
    // groups 1, 2 and 3 instead of using the dismount's difficulty bonus.
    for (var group in allGroups) {
      var elementIdx =
          routine.elements.indexWhere((element) => element.group == group);
      if (elementIdx != -1) {
        result[group] = RuleSet.normalBonus;
      }
    }
    return result;
  }
}
