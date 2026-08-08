Ruleset General
---------------

The general ruleset shall implement rules which are common for most apparatuses. 
*Comment*: Rulesets for specific apparatuses can inherit from the general ruleset and implement additional rules override existing rules.

Routine validity and invalid reason
-----------------------------------

If a routine contains more than one dismount, the ruleset shall set the routine to invalid.
*Comment*: A dismount is a routine element with group number 4.

If a routine contains more than one dismount, the ruleset shall set the field routine.invalidReason to InvalidRoutineReason.tooManyDismounts.

If a routine contains exactly one dismount and the dismount is not the last element of the routine, the ruleset shall set the routine to invalid.

If a routine contains exactly one dismount and the dismount is not the last element of the routine, the ruleset shall set the field routine.invalidReason to InvalidRoutineReason.dismountNotAtEnd.

In all other cases, the ruleset shall set the routine to valid and the field routine.invalidReason to null.

Element validity
----------------

If a routine element is a repetition, the ruleset shall set the element to invalid.
*Comment*: An element is a repetition if it has the same id as a previous element in the routine.

In all other cases, the ruleset shall set the routine element to valid.

Element valued
--------------

The ruleset shall set at most 8 routine elements to valued where 1 valued element is the dismount and 7 valued elements are the highest difficulty elements of the routine.
*Comment*: If the routine does not contain a dismount, the ruleset shall set at most 7 routine elements to valued.
*Comment*: If the routine contains less than 8 valid elements, the ruleset shall set all valid routine elements to valued.

Group scores
------------

By default, the ruleset shall set the group scores of all 4 groups to 0.0.

If the routine contains at least one valid element of group 1 where the difficulty is not "NE", the ruleset shall set the group score of group 1 to 0.5.

If the routine contains at least one valid element of group 2 where the difficulty is not "NE", the ruleset shall set the group score of group 2 to 0.5.

If the routine contains at least one valid element of group 3 where the difficulty is not "NE", the ruleset shall set the group score of group 3 to 0.5.

If the routine contains a valid element of group 4, the ruleset shall set the group score of group 4 to the score of that element.
*Comment*: Example: If the dismount has diffculty A (score: 0.2), the score of group 4 is 0.2.

D Score
-------

By default, the ruleset shall set the d score of the routine to 0.0.

For every valued element of the routine, the ruleset shall add the difficulty score of the element to the d score of the routine.

The difficulty score of an element is defined by the following mapping:
- NE: 0.0
- A: 0.2
- B: 0.4
- C: 0.6
- D: 0.8
- E: 0.8
- F: 0.8
- G: 0.8
- H: 0.8
- I: 0.8
- J: 0.8

For every group score of the routine, the ruleset shall add the group score to the d score of the routine.

Penalty
-------

The ruleset shall calculate the penalty of the routine as follows:
penalty = (8 - number of valued elements) * 1.0
*Comment*: A routine is expected to have 8 valued elements. If the routine has less than 8 valued elements, a penalty of 1.0 is added for each missing valued element.
