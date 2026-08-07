/// Why [Routine.isValid] is false, according to the Code of Points.
enum InvalidRoutineReason {
  /// More than one element in [Routine.dismountGroup].
  tooManyDismounts,

  /// A dismount exists but is not the routine's last element.
  dismountNotAtEnd,
}
