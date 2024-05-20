import 'package:flutter/material.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FittedBox(
                      child: FilledButton(
                          onPressed: () { discard(); },
                          style: ButtonStyle(
                              backgroundColor:
                              WidgetStatePropertyAll(Colors.red[600])),
                          child: const Row(
                              children: [Icon(Icons.cancel), Text('Abbrechen')]
                          )
                      )
                  ),
                  FittedBox(
                      child: FilledButton(
                          onPressed: () { save(); },
                          child: const Row(
                              children: [Icon(Icons.save), Text('Speichern')]
                          )
                      )
                  ),
                ]
            )
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
