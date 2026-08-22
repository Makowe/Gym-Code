import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/rulebook.dart';

class RoutineSettingsDialog extends StatefulWidget {
  const RoutineSettingsDialog(
      {super.key, required this.routineName, required this.rulebook});

  final String routineName;
  final Rulebook rulebook;

  @override
  State<RoutineSettingsDialog> createState() => _RoutineSettingsDialogState();
}

class _RoutineSettingsDialogState extends State<RoutineSettingsDialog> {
  late TextEditingController routineNameController;
  late Rulebook selectedRulebook;

  @override
  void initState() {
    routineNameController = TextEditingController(text: widget.routineName);
    selectedRulebook = widget.rulebook;
    super.initState();
  }

  @override
  void dispose() {
    routineNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Dialog(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(height: 12),
      Text(l10n.routineSettings, style: const TextStyle(fontSize: 20.0)),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.routineNameLabel,
          ),
          controller: routineNameController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownMenu<Rulebook>(
          label: Text(l10n.rulebook),
          initialSelection: selectedRulebook,
          onSelected: (Rulebook? newRulebook) {
            if (newRulebook == null) return;
            setState(() {
              selectedRulebook = newRulebook;
            });
          },
          dropdownMenuEntries: Rulebook.values
              .map<DropdownMenuEntry<Rulebook>>((Rulebook rulebook) {
            return DropdownMenuEntry<Rulebook>(
              value: rulebook,
              label: rulebook.localizedName(l10n),
            );
          }).toList(),
        ),
      ),
      const SizedBox(height: 12),
      ButtonGroup([
        ButtonSpec(
            type: ButtonType.textSecondary,
            label: l10n.cancel,
            icon: Icons.cancel,
            onPressed: discard),
        ButtonSpec(label: l10n.save, icon: Icons.save, onPressed: save),
      ])
    ]));
  }

  void discard() {
    Navigator.pop(context, null);
  }

  void save() {
    Navigator.pop(context, (routineNameController.text, selectedRulebook));
  }
}
