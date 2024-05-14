import 'package:flutter/material.dart';

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
            child: Text('Soll die Übung \"$routineName\" wirklich gelöscht werden?'),
          ),
          const SizedBox(height: 12),
        const Expanded(child: SizedBox()),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FittedBox(
                  child: FilledButton(
                      onPressed: () { Navigator.pop(context, false); },
                      child: const Row(
                          children: [Icon(Icons.undo), Text('Behalten')]
                      )
                  )
              ),
              FittedBox(
                  child: FilledButton(
                      onPressed: () { Navigator.pop(context, true); },
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red[600])
                      ),
                      child: const Row(
                          children: [Icon(Icons.delete), Text('Löschen')]
                      )
                  )
              ),
            ]
        ),
        ],
      ),
    );
  }
}
