import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';

import '../classes/routine.dart';
import '../classes/rulesets/ruleset.dart';
import '../services/ruleset_service.dart';

List<String> getDifficulties(Routine routine) {
  List<String> difficulties = routine.result!.numElements.keys.toList();
  difficulties.sort();
  return difficulties;
}

/// A bordered table breaking the routine's D-Score down by difficulty value:
/// how many elements of each difficulty were counted and the score they
/// contributed, with a totals row at the bottom.
class DifficultyTable extends StatelessWidget {
  final Routine routine;

  const DifficultyTable({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final RuleSet ruleSet =
        getRuleSetForApparatus(routine.apparatus, routine.rules);

    final Map<String, int> numElements = routine.result!.numElements;
    final List<String> difficulties = getDifficulties(routine);

    int totalElements = 0;
    num totalScore = 0.0;
    final List<TableRow> rows = [
      _tableHeaderRow(context, [l10n.value, l10n.elements, l10n.score]),
    ];
    for (final String difficulty in difficulties) {
      final int count = numElements[difficulty] ?? 0;
      final num score = count * (ruleSet.difficultyValues[difficulty] ?? 0.0);
      totalElements += count;
      totalScore += score;
      rows.add(_tableRow(context, [difficulty, '$count', score.toStringAsFixed(1)]));
    }
    rows.add(_tableHeaderRow(
        context,
        [l10n.total, '$totalElements', totalScore.toStringAsFixed(1)]));

    return _borderedTable(context, columnCount: 3, rows: rows);
  }
}

/// A bordered table breaking the routine's D-Score down by Code of Points
/// group: the bonus score contributed by each group, with a totals row at
/// the bottom.
class GroupsTable extends StatelessWidget {
  final Routine routine;

  const GroupsTable({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    final Map<int, num> groups = routine.result!.groups;
    final List<int> groupKeys = groups.keys.toList()..sort();

    num totalScore = 0.0;
    final List<TableRow> rows = [
      _tableHeaderRow(context, [l10n.group, l10n.score]),
    ];
    for (final int group in groupKeys) {
      final num score = groups[group] ?? 0.0;
      totalScore += score;
      rows.add(_tableRow(context, ['$group', score.toStringAsFixed(1)]));
    }
    rows.add(
        _tableHeaderRow(context, [l10n.total, totalScore.toStringAsFixed(1)]));

    return _borderedTable(context, columnCount: 2, rows: rows);
  }
}

Widget _borderedTable(BuildContext context,
    {required int columnCount, required List<TableRow> rows}) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;

  return Table(
    border: TableBorder.all(color: colorScheme.outlineVariant),
    columnWidths: {
      for (int i = 0; i < columnCount; i++) i: const FlexColumnWidth(1),
    },
    children: rows,
  );
}

TableRow _tableHeaderRow(BuildContext context, List<String> labels) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  return TableRow(
    decoration: BoxDecoration(color: colorScheme.surfaceContainerHigh),
    children: [
      for (final label in labels)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
    ],
  );
}

TableRow _tableRow(BuildContext context, List<String> values) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  return TableRow(
    decoration: BoxDecoration(color: colorScheme.surfaceContainerLow),
    children: [
      for (final value in values)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text(value, textAlign: TextAlign.center)
        )
    ]
  );
}
