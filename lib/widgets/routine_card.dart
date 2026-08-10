import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';

import '../classes/routine.dart';

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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Material(
        color: colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          splashColor: colorScheme.secondary.withValues(alpha: 0.3),
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  routine.getDisplayName(AppLocalizations.of(context)),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    view(index);
                  },
                  icon: const Icon(Icons.keyboard_arrow_right_sharp)),
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
