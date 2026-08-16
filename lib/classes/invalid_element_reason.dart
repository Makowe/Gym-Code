/// Why [RoutineElement.isValid] is false, according to the Code of Points.
enum InvalidElementReason {
  /// A previous valid element in the routine has the same id.
  repetition,

  /// More than one element of type Flop is present; only the
  /// highest-difficulty one stays valid.
  tooManyFlops,

  /// More than one element of type Combination is present; only the
  /// highest-difficulty one stays valid.
  tooManyCombinations,

  /// The element requires a specific direct predecessor which is not
  /// the element directly before it in the routine.
  missingPredecessor,

  /// The element is a dismount (group number 4) but is not the last
  /// element of the routine.
  dismountNotAtEnd,
}
