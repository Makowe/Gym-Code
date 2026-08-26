import '../ruleset_pommel_horse.dart';
import 'ruleset_lk1.dart';

/// Pommel horse ruleset for LK1 (see
/// reqs/lk1/ruleset_lk1_pommel_horse.rst). Apparatus deviations are
/// identical to the Code of Points ruleset and shared via
/// [PommelHorseMixin]; only the general LK1 rules ([Lk1RuleSet]) differ.
class PommelHorseRuleSetLk1 extends Lk1RuleSet with PommelHorseMixin {}
