import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/routine_score_tables.dart';
import 'package:gym_code/widgets/value_column.dart';

import '../classes/routine.dart';
import '../classes/routine_hint.dart';

const TextStyle _textStyleHeadline =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

class RoutineResultCard extends StatefulWidget {
  final Routine routine;

  const RoutineResultCard({super.key, required this.routine});

  @override
  State<RoutineResultCard> createState() => _RoutineResultCardState();
}

class _RoutineResultCardState extends State<RoutineResultCard> {
  static const Duration _duration = Duration(milliseconds: 250);

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8.0));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 12.0),
      child: Material(
        elevation: 2.0,
        borderRadius: borderRadius,
        color: colorScheme.surfaceContainerHighest,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => setState(() => _expanded = !_expanded),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSize(
                    duration: _duration,
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: AnimatedOpacity(
                      duration: _duration,
                      curve: Curves.easeInOut,
                      opacity: _expanded ? 1.0 : 0.0,
                      child: _expanded
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 8.0, 32.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(l10n.elementsByValue,
                                      style: _textStyleHeadline),
                                  const SizedBox(height: 8),
                                  DifficultyTable(routine: widget.routine),
                                  const SizedBox(height: 20),
                                  Text(l10n.groups, style: _textStyleHeadline),
                                  const SizedBox(height: 8),
                                  GroupsTable(routine: widget.routine),
                                ],
                              ),
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                  ),
                  RoutineResultCardContent(routine: widget.routine),
                ],
              ),
              Positioned(
                top: 4.0,
                right: 4.0,
                child: AnimatedRotation(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  turns: _expanded ? 0.5 : 0.0,
                  child: Icon(
                    Icons.expand_more,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The score summary shown inside [RoutineResultCard], factored out so it
/// can be reused by [RoutineDetailsDialog] as well.
class RoutineResultCardContent extends StatelessWidget {
  final Routine routine;

  const RoutineResultCardContent({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final List<RoutineHint> hints = routine.result?.hints ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hints.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 32.0, 0.0),
            child: Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: [
                for (final hint in hints)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiaryContainer,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 14.0,
                          color: colorScheme.onTertiaryContainer,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          hint.localizedText(l10n),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ValueColumn(
                  value: '${routine.elements.length}',
                  description: l10n.elements,
                  color: colorScheme.onSurface,
                ),
                SizedBox(
                  height: 40.0,
                  child: VerticalDivider(color: colorScheme.outlineVariant),
                ),
                ValueColumn(
                    value: '${routine.getNumValuedElements()}',
                    description: l10n.countedElements,
                    color: colorScheme.onSurface),
                SizedBox(
                  height: 40.0,
                  child: VerticalDivider(color: colorScheme.outlineVariant),
                ),
                ValueColumn(
                    value: routine.result?.dScore.toStringAsFixed(1) ?? '-',
                    description: l10n.dScore,
                    color: colorScheme.onSurface),
                SizedBox(
                  height: 40.0,
                  child: VerticalDivider(color: colorScheme.outlineVariant),
                ),
                ValueColumn(
                    value: routine.result?.penalty.toStringAsFixed(1) ?? '-',
                    description: l10n.penalty,
                    color: colorScheme.onSurface),
              ]),
        ),
      ],
    );
  }
}
