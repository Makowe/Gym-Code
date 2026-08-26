import '../ruleset_floor.dart';
import 'ruleset_lk1.dart';

/// Floor ruleset for LK1 (see reqs/lk1/ruleset_lk1_floor.rst). Apparatus
/// deviations are identical to the Code of Points ruleset and shared via
/// [FloorMixin]; only the general LK1 rules ([Lk1RuleSet]) differ.
class FloorRuleSetLk1 extends Lk1RuleSet with FloorMixin {}
