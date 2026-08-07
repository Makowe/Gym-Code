import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

class RenameRoutineDialog extends StatefulWidget {
  const RenameRoutineDialog({super.key, required this.routineName});

  final String routineName;

  @override
  State<RenameRoutineDialog> createState() => _RenameRoutineDialogState();
}

class _RenameRoutineDialogState extends State<RenameRoutineDialog> {

  late TextEditingController routineNameController;

  @override
  void initState() {
    routineNameController = TextEditingController(text: widget.routineName);
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
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(l10n.renameRoutine, style: const TextStyle(fontSize: 20.0)),
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
            const Expanded(child: SizedBox()),
            ButtonGroup([
              ButtonSpec(
                  label: l10n.cancel,
                  color: Colors.red,
                  icon: Icons.cancel,
                  onPressed: discard),
              ButtonSpec(
                  label: l10n.save,
                  color: Colors.blue,
                  icon: Icons.save,
                  onPressed: save),
            ])
          ]
        )
    );
  }

  void discard() {
    Navigator.pop(context, null);
  }

  void save() {
    Navigator.pop(context, routineNameController.text);
  }

}
