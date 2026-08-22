import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

class ConfirmDeleteRoutineDialog extends StatelessWidget {
  const ConfirmDeleteRoutineDialog(this.routineName, {super.key});

  final String routineName;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          ButtonGroup([
            ButtonSpec(
                type: ButtonType.filledSecondary,
                label: l10n.keep,
                icon: Icons.undo,
                onPressed: () => Navigator.pop(context, false)),
            ButtonSpec(
                type: ButtonType.filledError,
                label: l10n.delete,
                icon: Icons.delete,
                onPressed: () => Navigator.pop(context, true))
          ]),
        ],
      ),
    );
  }
}
