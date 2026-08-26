import '../classes/apparatus.dart';
import '../classes/rulebook.dart';
import '../classes/rulesets/lk1/ruleset_lk1.dart';
import '../classes/rulesets/lk1/ruleset_lk1_floor.dart';
import '../classes/rulesets/lk1/ruleset_lk1_horizontal_bar.dart';
import '../classes/rulesets/lk1/ruleset_lk1_parallel_bars.dart';
import '../classes/rulesets/lk1/ruleset_lk1_pommel_horse.dart';
import '../classes/rulesets/lk1/ruleset_lk1_rings.dart';
import '../classes/rulesets/ruleset.dart';
import '../classes/rulesets/ruleset_floor.dart';
import '../classes/rulesets/ruleset_horizontal_bar.dart';
import '../classes/rulesets/ruleset_parallel_bars.dart';
import '../classes/rulesets/ruleset_pommel_horse.dart';
import '../classes/rulesets/ruleset_rings.dart';

/// Returns the ruleset which implements the rules of [rulebook] for
/// [apparatus]. Apparatuses without a dedicated ruleset fall back to the
/// general ruleset of that rulebook.
RuleSet getRuleSetForApparatus(Apparatus apparatus, Rulebook rulebook) {
  switch (rulebook) {
    case Rulebook.cop:
      return _getCopRuleSetForApparatus(apparatus);
    case Rulebook.lk1:
      return _getLk1RuleSetForApparatus(apparatus);
  }
}

RuleSet _getCopRuleSetForApparatus(Apparatus apparatus) {
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

RuleSet _getLk1RuleSetForApparatus(Apparatus apparatus) {
  switch (apparatus) {
    case Apparatus.pommelHorse:
      return PommelHorseRuleSetLk1();
    case Apparatus.floor:
      return FloorRuleSetLk1();
    case Apparatus.rings:
      return RingsRuleSetLk1();
    case Apparatus.parallelBars:
      return ParallelBarsRuleSetLk1();
    case Apparatus.horizontalBar:
      return HorizontalBarRuleSetLk1();
    default:
      return Lk1RuleSet();
  }
}
