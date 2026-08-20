.. default-role:: code

Ruleset Floor
-------------

The ruleset for the floor shall implement the rules of the code of points for the floor apparatus.

Deviations from general ruleset
-------------------------------

Element group 4 does not represent dismounts. Therefore, element group 4 is treated the same way as element groups 1, 2 and 3.

The dismount is identified as follows:

If the last element of the routine belongs to element group 1, the routine does not have a dismount.

If the last element of the routine is one of the following elements, the routine does not have a dismount:
- `f_2_7`
- `f_2_38`
- `f_3_31`

In all other cases, the last element of the routine is considered as the dismount.
*Comment*: In other words, dismounts can only be of group 2, 3 and 4 and they cannot be elements with roll or elements to front support.

(1) Element validity
--------------------

The ruleset shall inherit the rules from the general ruleset with following exceptions:

Dismount not at the end
~~~~~~~~~~~~~~~~~~~~~~~

This rule from the general ruleset does not apply to floor.
*Comment*: With the updated rules for identifying the dismount, it will always be at the end, therefore this rule is not required.

Repetition
~~~~~~~~~~

If a routine element is a repetition, the ruleset shall set the element to invalid with `e.invalidReason = InvalidElementReason.repetition`.
*Deviation from general ruleset*: An element is a repition if a previous valid element in the routine has the same id or if the dismount has the same id.

The dismount itself is always valid and can never be invalidated because of a repition.

(2) Element valued
------------------

The ruleset shall inherit the rules from the general ruleset.

(3) Calculate Element Difficulties
----------------------------------

The ruleset shall inherit the rules from the general ruleset.

(4) Calculate Group Scores
--------------------------

The ruleset shall inherit the rules from the general ruleset with following exceptions.

For group 4, the group score is set in the same way as for groups 1, 2 and 3.
*Comment*: The group score can either be 0.0 or 0.5, depending on if an element with a difficulty other than NE was shown of that group.

(5) Calculate D-Score
---------------------

The ruleset shall inherit the rules from the general ruleset.

(6) Penalty
-----------

The ruleset shall inherit the rules from the general ruleset.
