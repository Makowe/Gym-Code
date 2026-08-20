import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/value_column.dart';

import '../classes/routine.dart';
import '../classes/routine_hint.dart';

class RoutineResultCard extends StatelessWidget {
  final Routine routine;

  const RoutineResultCard({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final List<RoutineHint> hints = routine.result?.hints ?? [];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: colorScheme.surfaceContainerHigh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hints.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final hint in hints)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Container(
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
                      ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
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
                        value:
                            routine.result?.penalty.toStringAsFixed(1) ?? '-',
                        description: l10n.penalty,
                        color: colorScheme.onSurface),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
