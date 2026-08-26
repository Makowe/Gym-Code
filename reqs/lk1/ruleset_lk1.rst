.. default-role:: code

Ruleset LK 1
------------

This ruleset shall implement general rules of the rulebook LK1.

It inherits the rules of the general ruleset and changes some of them.

Other rulesets inherit this ruleset and change specific rules.

Each Ruleset shall implement a method `evaluateRoutine`.

(1) Element validity
---------------------

The ruleset shall inherit the rules from the general ruleset with following exceptions:

The rule for national elements does not apply to LK1. National elements can also be valued.

The rule for too many elements of a group does not apply to LK1.

(2) Element valued
------------------

The ruleset shall inherit the rules from the general ruleset.

(3) Calculate Element Difficulties
-----------------------------------

The ruleset shall inherit the rules from the general ruleset.

(4) Calculate Group Scores
---------------------------

The ruleset shall override the rules from the general ruleset with following rules:

The ruleset shall go through all groups (1, 2, 3, 4) and calculate the group score based on the following rules.

For group 1, 2 and 3, set the group score to 0.5 if the routine contains at least one **valid** element of that group where the difficulty is not "NE". Otherwise set the group score to 0.0.

- *Comment*: In comparison to CoP, an element does not need to count to the valued elements to fulfill an element group.

For group 4, set the group score to 0.0 if the routine does not contain a dismount. If the routine contains a dismount, set the group score to the difficulty score of the dismount element.

- *Comment*: Example: If the dismount has difficulty A (score: 0.2), the score of group 4 is 0.2.

The ruleset create a map which maps the groups to the reached group scores.

- *Example*: `routine.result.groups = {1: 0.5, 2: 0.5, 3: 0.0, 4: 0.2}`

(5) Calculate D-Score
-----------------------

The ruleset shall inherit the rules from the general ruleset but override the difficulty scores as follows:

* NE: 0.0
* A: 0.2
* B: 0.4
* C: 0.6
* D: 0.8
* E: 0.8
* F: 0.8
* G: 0.8
* H: 0.8
* I: 0.8
* J: 0.8

(6) Penalty
------------

The ruleset shall override the rules from the general ruleset with following rules:

The ruleset shall calculate the penalty of the routine as follows:
penalty = (8 - numValuedElements) * 1.0
*Comment*: A routine is expected to have 8 valued elements. If the routine has less than 8 valued elements, a penalty of 1.0 is added for each missing valued element.
*Example* `routine.result.numElements = {'NE': 3, 'A': 2, 'B': 1, 'C': 1} -> numValuedElements = 3 + 2 + 1 + 1 = 7 -> penalty = (8-7) * 1.0 = 1.0`

(7) Hints
---------

The ruleset shall inherit the rules from the general ruleset.