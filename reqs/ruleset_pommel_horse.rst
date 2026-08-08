Ruleset Pommel Horse
--------------------

The ruleset for the pommel horse shall implement the rules of the code of points for the pommel horse apparatus. It is used to evaluate routines on the pommel horse.

Routine validity and invalid reason
-----------------------------------

The ruleset shall inherit the rules from the general ruleset.

Element validity
----------------

The ruleset shall inherit the rules from the general ruleset and implement the following additional rules:

The ruleset shall set at most 1 routine element of type Flop to valid.

Following routine elements are of type Flop:
- ``p_x_1``, ``p_x_2``

If a routine contains more than 1 routine element of type Flop, the ruleset shall only set the element with the highest difficulty to valid and set all other elements of type Flop to invalid.

If multiple routine elements of type Flop have the same difficulty, the ruleset shall set the first element of type Flop to valid and set all other elements of type Flop to invalid.

The ruleset shall set at most 1 routine element of type Combination to valid.

Following routine elements are of type Combination:
- ``p_x_3``, ``p_x_4``, ``p_x_5``, ``p_x_6``

If a routine contains more than 1 routine element of type Combination, the ruleset shall only set the element with the highest difficulty to valid and set all other elements of type Combination    to invalid.

If multiple routine elements of type Combination have the same difficulty, the ruleset shall set the first element of type Combination to valid and set all other elements of type Combination to invalid.

Element valued
--------------

The ruleset shall inherit the rules from the general ruleset.

D Score
-------

The ruleset shall inherit the rules from the general ruleset.

Penalty
-------

The ruleset shall inherit the rules from the general ruleset.
