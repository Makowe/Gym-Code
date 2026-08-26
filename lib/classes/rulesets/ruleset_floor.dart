import '../routine.dart';
import '../routine_element.dart';
import 'ruleset.dart';

/// Apparatus-specific deviations for floor (see reqs/ruleset_floor.rst and
/// reqs/lk1/ruleset_lk1_floor.rst), shared between the Code of Points and
/// LK1 rulesets by mixing this onto either [RuleSet] or `Lk1RuleSet`.
mixin FloorMixin on RuleSet {
  static const List<int> allGroups = [1, 2, 3, 4];
  static const int forbiddenDismountGroup = 1;
  static const List<String> forbiddenDismountIds = [
    'f_2_7',
    'f_2_38',
    'f_3_31'
  ];

  // Group 4 does not represent dismounts on floor, so a group-4 element
  // which is not the last element of the routine is not invalidated.
  @override
  bool get checksMisplacedDismounts => false;

  @override
  RoutineElement? findDismount(Routine routine) {
    if (routine.elements.isEmpty) {
      return null;
    }
    RoutineElement last = routine.elements.last;
    if (last.group == forbiddenDismountGroup ||
        forbiddenDismountIds.contains(last.id)) {
      return null;
    }
    return last;
  }

  @override
  bool elementIsRepetition(int targetElementIdx, Routine routine) {
    RoutineElement? dismount = findDismount(routine);
    RoutineElement targetElement = routine.elements[targetElementIdx];

    if (targetElement == dismount) {
      // dismount can never be repetition as it is counted first.
      return false;
    }

    if (dismount != null && targetElement.isEqualTo(dismount)) {
      // element is same as dismount -> repetition
      return true;
    }
    // check all previously shown elements for repetition.
    return super.elementIsRepetition(targetElementIdx, routine);
  }

  // Deviation from the general ruleset: group 4 is scored the same way as
  // groups 1, 2 and 3 instead of using the dismount's difficulty bonus.
  @override
  Map<int, num> countGroups(Routine routine) {
    Map<int, num> result = {};
    for (var group in allGroups) {
      result[group] = scoreForNormalGroup(routine, group);
    }
    return result;
  }

  // Deviation from the general ruleset: group 4 is fulfillable like groups
  // 1 to 3 when selecting valued elements, instead of being left to the
  // dismount.
  @override
  List<int> get groupsToFulfill => allGroups;
}

class FloorRuleSet extends RuleSet with FloorMixin {}
