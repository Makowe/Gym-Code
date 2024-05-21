import 'package:flutter/material.dart';
import 'package:gym_code/services/vocabulary_service.dart';
import 'package:gym_code/widgets/button_group.dart';

class ConfirmDeleteRoutineDialog extends StatefulWidget {
  const ConfirmDeleteRoutineDialog(this.futureRoutineName, {super.key});


  final Future<String> futureRoutineName;

  @override
  State<ConfirmDeleteRoutineDialog> createState() => _ConfirmDeleteRoutineDialogState();
}

class _ConfirmDeleteRoutineDialogState extends State<ConfirmDeleteRoutineDialog> {
  String routineName = '';

  @override
  void initState() {
    widget.futureRoutineName.then((name) {
      setState(() {
        routineName = name;
      });
    });
    super.initState();
  }

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
        ButtonGroup([
          ButtonSpec(
              vocabulary: Vocabulary.keep,
              color: Colors.blue,
              icon: Icons.undo,
              onPressed: () => Navigator.pop(context, false) ),
          ButtonSpec(
              vocabulary: Vocabulary.delete,
              color: Colors.red,
              icon: Icons.delete,
              onPressed: () => Navigator.pop(context, true))
        ]),
        ],
      ),
    );
  }
}
