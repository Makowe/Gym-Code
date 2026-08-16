import '../classes/apparatus.dart';
import '../classes/rulesets/ruleset.dart';
import '../classes/rulesets/ruleset_pommel_horse.dart';

/// Returns the ruleset which implements the rules of the code of points for
/// [apparatus]. Apparatuses without a dedicated ruleset fall back to the
/// general ruleset.
RuleSet getRuleSetForApparatus(Apparatus apparatus) {
  if (apparatus == Apparatus.pommelHorse) {
    return PommelHorseRuleSet();
  }
  return RuleSet();
}
