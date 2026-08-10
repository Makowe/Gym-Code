import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/routine.dart';

const TextStyle textStyleLarger = TextStyle(fontSize: 20.0);
const TextStyle textStyleDefault = TextStyle(fontSize: 16.0);

class RoutineDetailsDialog extends StatelessWidget {
  const RoutineDetailsDialog(this.routine, {super.key});

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text(routine.getDisplayName(l10n), style: textStyleLarger),
          const SizedBox(height: 12),
          routine.isValid
              ? (Column(children: [
                  Text(
                      '${l10n.dScore}: ${routine.result?.dScore.toStringAsFixed(1)}',
                      style: textStyleDefault),
                  Text('${l10n.penalty}: ${routine.result?.penalty}',
                      style: textStyleDefault),
                  Text('${l10n.totalElements}: ${routine.elements.length}',
                      style: textStyleDefault),
                  Text(
                      '${l10n.countedElements}: ${routine.getNumValuedElements()}',
                      style: textStyleDefault),
                  Text('${l10n.elementsByValue}:', style: textStyleDefault),
                  for (String difficulty in getDifficulties(routine))
                    Text(
                        '$difficulty: ${routine.result!.numElements[difficulty]}',
                        style: textStyleDefault),
                  Text('${l10n.groups}:', style: textStyleDefault),
                  for (num group in routine.result!.groups.keys)
                    Text('$group: ${routine.result!.groups[group]}',
                        style: textStyleDefault)
                ]))
              : (Text(routine.getInvalidReasonText(l10n))),
          const Expanded(child: SizedBox(height: 12)),
          ButtonGroup([
            ButtonSpec(
                label: l10n.close,
                color: colorScheme.primary,
                textColor: colorScheme.onPrimary,
                icon: Icons.close,
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop())
          ]),
        ],
      ),
    );
  }
}

List<String> getDifficulties(Routine routine) {
  List<String> difficulties = routine.result!.numElements.keys.toList();
  difficulties.sort();
  return difficulties;
}
