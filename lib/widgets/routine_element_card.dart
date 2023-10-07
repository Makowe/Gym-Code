import 'package:flutter/material.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/widgets/value_column.dart';

class RoutineElementCard extends StatelessWidget {
  final RoutineElement element;
  final Function? delete;
  final bool allowEdit;
  final int index;

  const RoutineElementCard(
      {super.key,
      required this.index,
      required this.element,
      required this.allowEdit,
      this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueColumn(
            value: element.difficulty,
            description: 'Wert',
          ),
          ValueColumn(
            value: element.group.toString(),
            description: 'Gruppe',
          ),
          Expanded(
            child: Text(
              element.name['de']!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[900],
              ),
            ),
          ),
          allowEdit
              ? IconButton(
                  onPressed: () {
                    if (delete != null) {
                      delete!(index);
                    }
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[800],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
