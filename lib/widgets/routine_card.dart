import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';

import '../classes/routine.dart';
import '../classes/rulebook.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final int index;
  final Function view;

  const RoutineCard(
      {super.key,
      required this.routine,
      required this.index,
      required this.view});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final num? dScore = routine.result?.dScore;
    final num? penalty = routine.result?.penalty;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Material(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          splashColor: colorScheme.onSurface.withValues(alpha: 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      routine.getDisplayName(AppLocalizations.of(context)),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  if (dScore != null)
                    Text(
                      [
                        if (penalty != null && penalty > 0)
                          '${l10n.penaltyAbbrev}: ${penalty.toStringAsFixed(1)}',
                        '${l10n.dScoreAbbrev}: ${dScore.toStringAsFixed(1)}',
                      ].join('  '),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  IconButton(
                      onPressed: () {
                        view(index);
                      },
                      icon: const Icon(Icons.keyboard_arrow_right_sharp)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
                        routine.rules.shortName(l10n),
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
          onTap: () {
            view(index);
          },
        ),
      ),
    );
  }
}
