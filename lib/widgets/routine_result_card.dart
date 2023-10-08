import 'package:flutter/material.dart';
import 'package:gym_code/widgets/value_column.dart';

import '../classes/routine.dart';

class RoutineResultCard extends StatelessWidget {
  final Routine routine;

  const RoutineResultCard({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    if (routine.isValid) {
      return Container(
        color: Colors.grey[300],
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueColumn(
                value: '${routine.elements.length}',
                description: 'Elemente',
              ),
              ValueColumn(
                  value: '${routine.getNumValuedElements()}',
                  description: 'Gezählte Elemente'),
              ValueColumn(
                  value: '${routine.result?.dScore ?? '-'}',
                  description: 'D Note'),
              ValueColumn(
                  value: '${routine.result?.penalty ?? '-'}',
                  description: 'Penalty'),
            ]),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Ungültige Übung: ${routine.invalidText}',
                    style: TextStyle(color: Colors.red[800], fontSize: 16.0),
                  ),
                ),
              ))
        ],
      );
    }
  }
}
