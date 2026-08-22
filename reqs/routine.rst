.. default-role:: code

Routine
-------

A Routine has a list of type RoutineElement `elements`.

A Routine has an optional int `id`.

A Routine has an optional string `name`.

A Routine has a bool `isValid` with default value `false`.
*Comment*: The field `isValid` tells if the combination of routine elements could be shown in a competition.
Example: It might be set to `false` if the dismount is not at the end of the routine.

A Routine has an optional field `invalidReason` of enum type InvalidRoutineReason.

A Routine has an optional field `result` of type RoutineResult.

A Routine has a field `apparatus` of type Apparatus.

A Routine has a field `rules` of type Rulebook, with default value `cop`.

Rulebook
--------

The enum Rulebook has the following values:
- `cop`
- `lk1`

RoutineElement
--------------

A RoutineElement has a string `id`.

A RoutineElement has a string `difficulty`.

A RoutineElement has an int `group`.

A RoutineElement has a map `name` that maps locale codes (string) to localized names (string).

A RoutineElement has an optional string `nameInt` which is an international name of the RoutineElement.

A RoutineElement has a bool `isValid` with default value `true`.
*Comment*: The field `isValid` tells whether the routine element can be valued within a routine.
Example: It might be set to `false` if the same routine element is already used in the routine.

A RoutineElement has a bool `isValued` with default value `true`.
*Comment*: The field `isValued` tells whether the routine element is included in the d score of a routine.
Example: It might be set to `false` if all other routine elements have a higher difficulty and the routine element does not contribute to the d score.

Two RoutineElements are equal if they have the same `id`.

Two RoutineElements have the same value if they have the same `difficulty`.

A RoutineElement has a higher value than another RoutineElement if it has a higher difficulty. 

The difficulty is ordered as follows: NE < A < B < C < D < E < F < G < H < I < J.

InvalidElementReason
--------------------

The enum InvalidElementReason has the following values:
- repetition
- tooManyFlops
- tooManyCombinations
- missingPredecessor
- dismountNotAtEnd
- tooManyStrengthElementsInARow

RoutineResult
-------------

A RoutineResult has an int `dScore`.

A RoutineResult has a map `groups` that maps the group number (int) to a d score (num).

A RoutineResult has a map `numElements` that maps difficulties (string) to the number of valued elements with that difficulty (int).

A RoutineResult has a num `penalty`.

A RoutineResult has a List of RoutineHint `hints`.

RoutineHint
-----------

The enum RoutineHints has the following values:
- missingDismount
- missingElements
- routineComplete
- codeOfPoints
- lk1

Apparatus
---------

The enum Apparatus has the following values:
- `floor`
- `pommel_horse`
- `rings`
- `vault`
- `parallel_bars`
- `horizontal_bar`