import 'package:flutter/material.dart';
import 'package:gym_code/services/vocabulary_service.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/routine.dart';

const TextStyle TEXT_STYLE_LARGER = TextStyle(fontSize: 20.0);
const TextStyle TEXT_STYLE_DEFAULT = TextStyle(fontSize: 16.0);

class RoutineDetailsDialog extends StatefulWidget {
  const RoutineDetailsDialog(this.routine, {super.key});

  final Routine routine;

  @override
  State<RoutineDetailsDialog> createState() => _RoutineDetailsDialogState();
}

class _RoutineDetailsDialogState extends State<RoutineDetailsDialog> {

  late Routine routine;
  String routineName = '';

  @override
  void initState() {
    routine = widget.routine;
    routine.getDisplayName().then((name) {
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
          Text(routineName, style: TEXT_STYLE_LARGER),
          const SizedBox(height: 12),
          routine.isValid ? (
              Column(
                  children: [
                    Text('D-Note: ${routine.result?.dScore.toStringAsFixed(1)}', style: TEXT_STYLE_DEFAULT),
                    Text('Penalty: ${routine.result?.penalty}', style: TEXT_STYLE_DEFAULT),
                    Text('Geturnte Elemente: ${routine.elements.length}', style: TEXT_STYLE_DEFAULT),
                    Text('Gewertete Elemente: ${routine.getNumValuedElements()}', style: TEXT_STYLE_DEFAULT),
                    const Text('Elemente nach Schwierigkeit:', style: TEXT_STYLE_DEFAULT),
                    for(String difficulty in getDifficulties(routine))
                      Text('$difficulty: ${routine.result!.numElements[difficulty]}', style: TEXT_STYLE_DEFAULT),
                    const Text('Gruppen:', style: TEXT_STYLE_DEFAULT),
                    for(num group in routine.result!.groups.keys)
                      Text('$group: ${routine.result!.groups[group]}', style: TEXT_STYLE_DEFAULT)
                  ]
              )
          ) : (
              Text('Übung ungültig: ${routine.invalidText}')
          ),
          const Expanded(child: SizedBox(height: 12)),
          ButtonGroup([
            ButtonSpec(
                vocabulary: Vocabulary.close,
                color: Colors.blue,
                icon: Icons.close,
                onPressed: () => Navigator.of(context, rootNavigator: true).pop())
          ]),
        ],
      ),
    );
  }
}


List<String> getDifficulties(Routine routine) {
  List<String> difficulties = routine.result!.numElements.keys.toList();
  difficulties.sort();
  return difficulties;
}