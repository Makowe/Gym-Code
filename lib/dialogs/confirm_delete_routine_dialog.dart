import 'package:flutter/material.dart';
import 'package:gym_code/widgets/button_group.dart';

class ConfirmDeleteRoutineDialog extends StatelessWidget {
  const ConfirmDeleteRoutineDialog({super.key, required this.routineName});

  final String routineName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Übung löschen', style: TextStyle(fontSize: 20.0),),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Soll die Übung "$routineName" wirklich gelöscht werden?'),
          ),
          const SizedBox(height: 12),
        const Expanded(child: SizedBox()),
        ButtonGroup(buttons: [
          ButtonSpec(
              text: "Behalten",
              color: Colors.blue,
              icon: Icons.undo,
              onPressed: () => Navigator.pop(context, false) ),
          ButtonSpec(
              text: "Löschen",
              color: Colors.red,
              icon: Icons.delete,
              onPressed: () => Navigator.pop(context, true))
        ]),
        ],
      ),
    );
  }
}
