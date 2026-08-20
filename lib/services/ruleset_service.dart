import '../classes/apparatus.dart';
import '../classes/rulesets/ruleset.dart';
import '../classes/rulesets/ruleset_floor.dart';
import '../classes/rulesets/ruleset_horizontal_bar.dart';
import '../classes/rulesets/ruleset_parallel_bars.dart';
import '../classes/rulesets/ruleset_pommel_horse.dart';
import '../classes/rulesets/ruleset_rings.dart';

/// Returns the ruleset which implements the rules of the code of points for
/// [apparatus]. Apparatuses without a dedicated ruleset fall back to the
/// general ruleset.
RuleSet getRuleSetForApparatus(Apparatus apparatus) {
  switch (apparatus) {
    case Apparatus.pommelHorse:
      return PommelHorseRuleSet();
    case Apparatus.floor:
      return FloorRuleSet();
    case Apparatus.rings:
      return RingsRuleSet();
    case Apparatus.parallelBars:
      return ParallelBarsRuleSet();
    case Apparatus.horizontalBar:
      return HorizontalBarRuleSet();
    default:
      return RuleSet();
  }
}
