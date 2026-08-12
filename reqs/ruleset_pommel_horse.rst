Ruleset Pommel Horse
--------------------

The ruleset for the pommel horse shall implement the rules of the code of points for the pommel horse apparatus. It is used to evaluate routines on the pommel horse.

(1) Routine validity
--------------------

The ruleset shall inherit the rules from the general ruleset.

(2) Element validity
--------------------

The ruleset shall inherit the rules from the general ruleset and implement the following additional rules:

Flops
~~~~~

The ruleset shall set at most 1 routine element of type Flop to valid.

Following routine elements are of type Flop:
- ``p_x_1``
- ``p_x_2``

If a routine contains more than 1 routine element of type Flop, the ruleset shall only set the element with the highest difficulty to valid and set all other elements of type Flop to invalid.

If multiple routine elements of type Flop have the same highest difficulty, the ruleset shall set the first of those elements to valid and all other elements of type Flop to invalid.

Combinations
~~~~~~~~~~~~

The ruleset shall set at most 1 routine element of type Combination to valid.

Following routine elements are of type Combination:
- ``p_x_3``
- ``p_x_4``
- ``p_x_5``
- ``p_x_6``

If a routine contains more than 1 routine element of type Combination, the ruleset shall only set the element with the highest difficulty to valid and set all other elements of type Combination to invalid.

If multiple routine elements of type Combination have the same highest difficulty, the ruleset shall set the first of those elements to valid and all other elements of type Combination to invalid.

National elements of type "second element in a row"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ruleset shall only set specific national elements to valid if the direct previous element is a specific element.

Following national elements require a direct predecessor:
- ``p_n_1`` requires predecessor ``p_1_1``.
- ``p_n_2`` requires predecessor ``p_1_13``.
- ``p_n_9`` requires one of the predecessors ``[p_2_1, p_n_10]``.


(3) Element valued
--------------

The ruleset shall inherit the rules from the general ruleset.

(4) Calculate Element Difficulties
----------------------------------

The ruleset shall inherit the rules from the general ruleset.

(5) Calculate Group Scores
--------------------------

The ruleset shall inherit the rules from the general ruleset.

(6) Calculate D-Score
---------------------

The ruleset shall inherit the rules from the general ruleset.

(7) Penalty
-------

The ruleset shall inherit the rules from the general ruleset.
