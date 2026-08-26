.. default-role:: code

Ruleset Code of Points
----------------------

A ruleset shall implement the rules of a specific rulebook. It is used to evaluate routines.

This file explains the general ruleset for code of points which are common for most apparatuses.

Other rulesets inherit this ruleset and change specific rules.

Each Ruleset shall implement a method `evaluateRoutine`.

method evaluateRoutine()
------------------------

The method `evaluateRoutine` shall take a Routine as input. It shall modify the Routine in place.

The method `evaluateRoutine` shall not return any value.

The method `evaluateRoutine` shall perform the following actions:

1. Element validity: Go through the elements `e` of the routine, checks if each element is valid and sets the fields `e.isValid` and `e.invalidReason` of the RoutineElement accordingly.

2. Element valued: Go through the elements `e` of the routine, checks if each element is valued and sets the field `e.isValued` of the RoutineElement accordingly.

3. Calculate Element Difficulties: Create the map `routine.result.numElements` that maps element difficulties to the number of valued elements with that difficulty.

4. Calculate Group Scores: the map `routine.result.groups` that maps group numbers to the reached group score.

5. Calculate the num `routine.result.dScore` by summing difficulties of valued elements and the group scores.

6. Calculate the num `routine.result.penalty`.

7. Calculate the list `routine.result.hints` by checking specific conditions of the routine.

(1) Element validity
---------------------

The ruleset shall go through the elements `e` of the routine, in order.

For each element, the ruleset shall go through the list of potential reasons why the element might be invalid, in the order they are listed below.

If any of the reasons applies to the element, the ruleset shall set `e.isValid = false` and `e.invalidReason` to the according value.

If none of the reasons apply, the ruleset shall set `e.isValid = true` and `e.invalidReason = null`.

Dismount not at the end
~~~~~~~~~~~~~~~~~~~~~~~

If a routine element has group number 4 (a dismount) and is not the last element of the routine, the ruleset shall set the element to invalid with `e.invalidReason = InvalidElementReason.dismountNotAtEnd`.

- *Comment*: This also covers routines with more than one dismount: only the routine's actual last element can ever be "at the end", so every dismount-group element besides the last one is caught by this rule.

National Element
~~~~~~~~~~~~~~~~

If a routine element has difficulty "NE", the ruleset shall set the element to invalid with `e.invalidReason = InvalidElementReason.nationalElementsForbidden`

Repetition
~~~~~~~~~~

If a routine element is a repetition, the ruleset shall set the element to invalid with `e.invalidReason = InvalidElementReason.repetition`.

- *Comment*: An element is a repetition if a previous valid element in the routine has the same id.

Too many elements of a group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For each evaluated element that has not been set to invalid by any other reason, the ruleset shall count following other elements in the routine:

- (A): Valid elements with the same group which have a higher difficulty than the evaluated element.
- (B): Valid elements with the same group and same difficulty at a previous position.

If the sum of (A) and (B) is greater or equal to 4, the ruleset shall set the evaluated element to invalid with `e.invalidReason = InvalidElementReason.tooManyElementsOfGroup`.

(2) Element valued
------------------

The ruleset shall set all elements to not valued at first.

The ruleset shall find the following values:

- `RoutineElement? dismount`: Dismount element if it exists, otherwise null.
- `numValidElements`: Number of valid elements in the routine.
- `numValidElementsBesideDismount`: Number of valid elements in the routine except the dismount. (If the routine has a dismount, then `numValidElementsBesideDismount == numValidElements - 1`, otherwise `numValidElementsBesideDismount == numValidElements`.

If `routine.dismount != null`, the ruleset shall set the dismount to valued.

If `numValidElementsBesideDismount < 7`, the ruleset shall set all valid routine elements to valued.

Else, the ruleset shall select 7 valued elements based on the following algorithm:

- Set the value `numValuedElementsBesideDismount = 0`.
- Set the list `valuedElements = []`. Add the dismount to the list if it exists.
- Go through all difficulty values from high to low.
    - If numValuedElements >= 7, return.
    - For each difficulty `d`, create a list of potentially valued elements `es` with that difficulty (skipping the dismount).
    - If `es.length + numValuedElements <= 7`, set all potentially valued elements `es` to valued. Add all elements in `es` to `valuedElements`.
    - Else, select the remaining elements with following strategy:
        - Go through all groups beside DismountGroup.
        - Check if that group is already fulfilled by checking if any element in `valuedElements` has that group.
        - If the group is already fulfilled, go to the next group.
        - If the group is not yet fulfilled, check if any of the potential valued elements in `es` fulfill that group.
        - If yes, set the first occurrence to valued and add it to `valueElements`. Then, go to the next group.
        - Make sure that the number of valuedElements does not exceed the limit.
        - If the limit is not reached after going through all groups, go through the remaining elements `es` which are not yet valued and set them to valued until the limit is reached.


(3) Calculate Element Difficulties
-----------------------------------

The ruleset shall go through all possible difficulties (NE, A, B, C, D, E, F, G, H, I, J) and create a map which contains the number of value elements with that difficulty.

- *Example*: `routine.result.numElements = {'NE': 3, 'A': 2, 'B': 1, 'C': 1}`

(4) Calculate Group Scores
---------------------------

The ruleset shall go through all groups (1, 2, 3, 4) and calculate the group score based on the following rules:

- For group 1, set the group score to 0.5 if the routine contains at least one **valued** element of that group. Otherwise set the group score to 0.0.
- For group 2 and 3, set the group score to 0.5 if the routine contains at least one **valued** element of that group with a difficulty of at least "D". Set the group score to 0.3 it at least one **valued** element of that group with a difficulty of "A", "B" or "C". Otherwise, set the group score to 0.0.
- For group 4, set the group score to 0.0 if the routine does not contain a dismount. If the routine contains a dismount, set the group score to the difficulty score of the dismount element.

  - *Example*: If the dismount has difficulty A (score: 0.1), the score of group 4 is 0.1.

The ruleset shall create a map which maps the groups to the reached group scores.

- *Example*: `routine.result.groups = {1: 0.5, 2: 0.5, 3: 0.0, 4: 0.2}`

(5) Calculate D-Score
-----------------------

The ruleset shall calculate the D-Score as follows.

Go through the map `routine.result.numElements` and add up the difficulty scores of all valued elements.

The difficulty score of an element is defined by the following mapping:

* NE: 0.0
* A: 0.1
* B: 0.2
* C: 0.3
* D: 0.4
* E: 0.5
* F: 0.6
* G: 0.7
* H: 0.8
* I: 0.9
* J: 1.0

*Example*: `routine.result.numElements = {'A': 3, 'B': 4, 'C': 1} -> 0.1 * 3 + 0.2 * 4 + 0.3 * 1 = 1.4`

Go through the map `routine.result.groups` and add up all values in the map.
*Example*: `routine.result.groups = {1: 0.5, 2: 0.5, 3: 0.0, 4: 0.2} -> 0.5 + 0.5 + 0.0 + 0.2 = 1.2`

Calculate the D-Score by adding up the difficulty scores of the elements and the group scores.
*Example*: `routine.result.dScore = 1.4 + 1.2 = 2.6`

(6) Penalty
------------

If `numValuedElements >= 6`, set the penalty to 0.0.

Else, calculate the penalty based on following formula:
penalty = (8 - numValuedElements) * 1.0

- *Example* `routine.result.numElements = {'A': 2, 'B': 1, 'C': 1} -> numValuedElements = 2 + 1 + 1 = 4 -> penalty = (8-4) * 1.0 = 4.0`

(7) Hints
---------

The ruleset shall add the hint `RoutineHint.codeOfPoints` if `routine.rulebook == Rulebook.cop`.

The ruleset shall add the hint `RoutineHint.lk1` if `routine.rulebook == Rulebook.lk1`.

The ruleset shall add the hint `RoutineHint.missingDismount` if the routine does not have a dismount.

The ruleset shall add the hint `RoutineHint.missingElements` if the number of valued elements besides dismount is smaller than expected.
