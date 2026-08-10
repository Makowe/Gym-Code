import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

class ConfirmDeleteRoutineDialog extends StatelessWidget {
  const ConfirmDeleteRoutineDialog(this.routineName, {super.key});

  final String routineName;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      child: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(l10n.deleteRoutine,
                style: const TextStyle(fontSize: 20.0)),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(l10n.confirmDeleteRoutine(routineName)),
          ),
          const SizedBox(height: 12),
          const Expanded(child: SizedBox()),
          ButtonGroup([
            ButtonSpec(
                label: l10n.keep,
                color: colorScheme.primary,
                textColor: colorScheme.onPrimary,
                icon: Icons.undo,
                onPressed: () => Navigator.pop(context, false)),
            ButtonSpec(
                label: l10n.delete,
                color: colorScheme.secondaryContainer,
                textColor: colorScheme.onSecondaryContainer,
                icon: Icons.delete,
                onPressed: () => Navigator.pop(context, true))
          ]),
        ],
      ),
    );
  }
}
