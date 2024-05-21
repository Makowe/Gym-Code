import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text('Übung benennen', style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Übungsname'
                ),
                controller: routineNameController,
              ),
            ),
            const Expanded(child: SizedBox()),
            ButtonGroup(buttons: [
              ButtonSpec(text: "Abbrechen", color: Colors.red, icon: Icons.cancel, onPressed: discard),
              ButtonSpec(text: "Speichern", color: Colors.blue, icon: Icons.save, onPressed: save),
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
