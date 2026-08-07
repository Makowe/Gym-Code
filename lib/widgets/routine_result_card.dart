import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/value_column.dart';

import '../classes/routine.dart';

class RoutineResultCard extends StatelessWidget {
  final Routine routine;

  const RoutineResultCard({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    if (routine.isValid) {
      return Container(
        color: Colors.grey[300],
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueColumn(
                value: '${routine.elements.length}',
                description: l10n.elements,
              ),
              ValueColumn(
                  value: '${routine.getNumValuedElements()}',
                  description: l10n.countedElements),
              ValueColumn(
                  value: routine.result?.dScore.toStringAsFixed(1) ?? '-',
                  description: l10n.dScore),
              ValueColumn(
                  value: routine.result?.penalty.toStringAsFixed(1) ?? '-',
                  description: l10n.penalty),
            ]),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    routine.getInvalidReasonText(l10n),
                    style: TextStyle(color: Colors.red[800], fontSize: 16.0),
                  ),
                ),
              ))
        ],
      );
    }
  }
}
