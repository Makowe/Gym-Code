class RoutineResult {
  late final num dScore;
  late final Map<int, num> groups;
  late final Map<String, int> numElements;
  late final num penalty;

  RoutineResult(
      {num? dScore,
      Map<int, num>? groups,
      Map<String, int>? numElements,
      num? penalty}) {
    this.dScore = dScore ?? 0.0;
    this.groups = groups ?? {};
    this.numElements = numElements ?? {};
    this.penalty = penalty ?? 0.0;
  }
}
