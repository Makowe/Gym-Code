import '../../routine.dart';
import '../ruleset.dart';

/// Ruleset for the rulebook LK1 (see reqs/lk1/ruleset_lk1.rst). Inherits
/// [RuleSet] and overrides the rules described there; apparatus-specific
/// deviations are shared with the Code of Points rulesets via mixins (see
/// e.g. ruleset_floor.dart).
class Lk1RuleSet extends RuleSet {
  @override
  bool get checksNationalElementsForbidden => false;

  @override
  bool get checksTooManyElementsOfGroup => false;

  static const Map<String, num> lk1DifficultyValues = {
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

  @override
  Map<String, num> get difficultyValues => lk1DifficultyValues;

  @override
  num scoreForNormalGroup(Routine routine, int group) {
    bool hasValidNonNationalElement = routine.elements.any((element) =>
        element.isValid &&
        element.group == group &&
        element.difficulty != 'NE');
    return hasValidNonNationalElement ? RuleSet.normalBonus : 0.0;
  }

  @override
  num calcPenalty(Routine routine) {
    int numValuedElements = routine.getNumValuedElements();
    return (8 - numValuedElements) * 1.0;
  }
}
