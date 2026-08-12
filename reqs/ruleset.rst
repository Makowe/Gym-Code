Ruleset
-------

A ruleset shall implement the rules of the code of points for a specific apparatus. It is used to evaluate routines.

Each Ruleset shall implement a method `evaluateRoutine`.

method evaluateRoutine()
------------------------

The method `evaluateRoutine` shall take a Routine as input and modifies the Routine in place.

The method `evaluateRoutine` shall not return any value.

The method `evaluateRoutine` shall perform the following actions:

1. Routine validity: Check if the routine is valid and set the field `routine.isValid` of the Routine accordingly. If the routine is invalid, set set the field `routine.invalidReason` of the Routine accordingly.

2. Element validity: Go through the elements `e` of the routine, checks if each element is valid and sets the field `e.isValid` of the RoutineElement accordingly.

3. Element valued: Go through the elements `e` of the routine, checks if each element is valued and sets the field `e.isValued` of the RoutineElement accordingly.

4. Calculate Element Difficulties: Create the map `routine.result.numElements` that maps element difficulties to the number of valued elements with that difficulty.

5. Calculate Group Scores: the map `routine.result.groups` that maps group numbers to the reached group score.

6. Calculate the num `routine.dScore` by summing difficulties of valued elements and the group scores.

7. Calculate the num `routine.penalty`.

Ruleset General
---------------

The general ruleset shall implement rules which are common for most apparatuses.
*Comment*: Rulesets for specific apparatuses can inherit from the general ruleset and implement additional rules override existing rules.

(1) Routine validity
--------------------

The ruleset shall go through the list of potential reasons why a routine might be invalid.

The ruleset shall go through the list in the order they are listed.

If any of the reasons applies to the routine, the ruleset shall set `routine.isValid = false` and the `routine.invalidReason` to the according value.

If none of the reasons apply, the ruleset shall set `routine.isValid = true` and and the `routine.invalidReason = null`.

More than one dismount
~~~~~~~~~~~~~~~~~~~~~~

If a routine contains more than one dismount, the ruleset shall set the routine to invalid.
*Comment*: A dismount is a routine element with group number 4.

If a routine contains more than one dismount, the ruleset shall set the field routine.invalidReason to InvalidRoutineReason.tooManyDismounts.

Dismount not at the end
~~~~~~~~~~~~~~~~~~~~~~~

If a routine contains exactly one dismount and the dismount is not the last element of the routine, the ruleset shall set the routine to invalid.

If a routine contains exactly one dismount and the dismount is not the last element of the routine, the ruleset shall set the field routine.invalidReason to InvalidRoutineReason.dismountNotAtEnd.

(2) Element validity
--------------------

If a routine element is a repetition, the ruleset shall set the element to invalid.
*Comment*: An element is a repetition if a previous valid element in the routine has the same id.

In all other cases, the ruleset shall set the routine element to valid.

(3) Element valued
------------------

The ruleset shall set all elements to not valued at first.

The ruleset shall set at most 8 routine elements to valued where 1 valued element is the dismount and 7 valued elements are the highest difficulty elements of the routine.

The ruleset shall only set valid elements to valued.

If the routine does not contain a dismount, the ruleset shall set at most 7 routine elements to valued.

If the routine contains less than 8 valid elements, the ruleset shall set all valid routine elements to valued.

(4) Calculate Element Difficulties
----------------------------------

The ruleset shall go through all possible difficulties (NE, A, B, C, D, E, F, G, H, I, J) and create a map which contains the number of value elements with that difficulty.
*Example*: `routine.result.numElements = {'NE': 3, 'A': 2, 'B': 1, 'C': 1}`

(5) Calculate Group Scores
--------------------------

The ruleset shall go through all groups (1, 2, 3, 4) and calculate the group score based on the following rules.

For group 1, 2 and 3, set the group score to 0.5 if the routine contains at least one valid element of that group where the difficulty is not "NE". Otherwise set the group score to 0.0.

For group 4, set the group score to 0.0 if the routine does not contain a dismount. If the routine contains a dismount, set the group score to the difficulty score of the dismount element.
*Comment*: Example: If the dismount has difficulty A (score: 0.2), the score of group 4 is 0.2.

The ruleset create a map which maps the groups to the reached group scores.
*Example*: `routine.result.groups = {1: 0.5, 2: 0.5, 3: 0.0, 4: 0.2}`

(6) Calculate D-Score
---------------------

The ruleset shall calculate the D-Score as follows.

Go through the map `routine.result.numElements` and add up the difficulty scores of all valued elements.

The difficulty score of an element is defined by the following mapping:

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

*Example*: `routine.result.numElements = {'NE': 3, 'A': 2, 'B': 1, 'C': 1} -> 0.0*3 + 0.2*2 + 0.4*1 + 0.6*1 = 1.4`

Go through the map `routine.result.groups` and add up all values in the map.
*Example*: `routine.result.groups = {1: 0.5, 2: 0.5, 3: 0.0, 4: 0.2} -> 0.5 + 0.5 + 0.0 + 0.2 = 1.2`

Calculate the D-Score by adding up the difficulty scores of the elements and the group scores.
*Example*: `routine.result.dScore = 1.4 + 1.2 = 2.6`

(7) Penalty
-----------

The ruleset shall calculate the penalty of the routine as follows:
penalty = (8 - numValuedElements) * 1.0
*Comment*: A routine is expected to have 8 valued elements. If the routine has less than 8 valued elements, a penalty of 1.0 is added for each missing valued element.
*Example* `routine.result.numElements = {'NE': 3, 'A': 2, 'B': 1, 'C': 1} -> numValuedElements = 3 + 2 + 1 + 1 = 7 -> penalty = (8-7) * 1.0 = 1.0`