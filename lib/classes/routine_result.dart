class RoutineResult {
  final num dScore;
  final Map<int, num> groups;
  final Map<String, int> numElements;
  final num penalty;

  RoutineResult(
      {required this.dScore,
      required this.groups,
      required this.numElements,
      required this.penalty});
}
