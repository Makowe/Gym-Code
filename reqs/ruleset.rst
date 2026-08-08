Ruleset
-------

A ruleset shall implement the rules of the code of points for a specific apparatus. It is used to evaluate routines.

Each Ruleset shall implement a method ``evaluateRoutine``.

evaluateRoutine
---------------

The method ``evaluateRoutine`` shall take a Routine as input and modifies the Routine in place.

The method ``evaluateRoutine`` shall not return any value.

The method ``evaluateRoutine`` shall perform the following actions:
1. Check if the routine is valid and sets the field ``routine.isValid`` of the Routine accordingly. 
2. If the routine is invalid, set the field ``routine.invalidReason`` of the Routine to the appropriate value of InvalidRoutineReason.
3. If the routine does not contain elements, set the d score of the Routine to 0.0 and the penalty to 10.0 and returns.
4. Go through the elements ``e`` of the routine, checks if each element is valid and sets the field ``e.isValid`` of the RoutineElement accordingly.
5. Go through the elements ``e`` of the routine, checks if each element is valued and sets the field ``e.isValued`` of the RoutineElement accordingly.
6. Calculate the map ``routine.numElements`` that maps element difficulties to the number of valued elements with that difficulty. (Example: {'A': 2, 'B': 1, 'C': 1})
7. Calculate the map ``routine.groupScores`` that maps group numbers to the d score of that group. (Example: {1: 0.5, 2: 0.5, 3: 0.0, 4: 0.3})
8. Calculate the num ``routine.dScore`` by summing difficulties of valued elements and the group scores.
9. Calculate the num ``routine.penalty``.
